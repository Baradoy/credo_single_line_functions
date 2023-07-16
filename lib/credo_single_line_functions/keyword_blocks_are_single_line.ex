defmodule CredoSingleLineFunctions.KeywordBlocksAreSingleLine do
  use Credo.Check,
    base_priority: :high,
    category: :readability,
    explanations: [
      check: ~S"""
      When using the `do:` function definition syntax, the body of the function should be on one line.

      As per the [Elixir lanuage docs](https://elixir-lang.org/getting-started/modules-and-functions.html#named-functions):
      ```
      And it will provide the same behaviour. You may use do: for one-liners but always
      use do-blocks for functions spanning multiple lines. If you prefer to be consistent,
      you can use do-blocks throughout your codebase.
      ```

        # preferred

          def foo, do: 1 |> Integer.to_string() |> String.to_integer()
          def foo,
            do: 1 |> Integer.to_string() |> String.to_integer()

        # NOT preferred

          def foo,
            do:
              1
              |> Integer.to_string()
              |> String.to_integer()
      """,
      params: []
    ]

  def run(%SourceFile{filename: filename} = source_file, params) do
    issue_meta = IssueMeta.for(source_file, params)

    # Credo.Code.to_tokens(source_file)

    source_file
    |> SourceFile.source()
    |> Code.string_to_quoted(
      line: 1,
      file: filename,
      literal_encoder: &{:ok, {:__block__, &2, [&1]}}
    )
    |> Credo.Code.prewalk(&traverse(&1, &2, issue_meta))
  end

  defp traverse(
         {{:__block__, metadata, [:do]}, {:|>, _other_metadata, _rest}} = ast,
         issues,
         issue_meta
       ) do
    line_number = Keyword.get(metadata, :line)

    with :keyword <- Keyword.get(metadata, :format),
         {:error, line} <- Credo.Code.prewalk(ast, &count_lines(&1, &2, line_number)) do
      new_issue =
        format_issue(
          issue_meta,
          message: "Use a do block for multi line functions, or keep `do:` to a single line",
          # trigger: trigger,
          line_no: line
        )

      {ast, [new_issue | issues]}
    else
      _ -> {ast, issues}
    end
  end

  defp traverse(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp count_lines({_, metadata, _} = ast, acc, initial_line) do
    line_number = Keyword.get(metadata, :line, nil)

    if initial_line != line_number do
      {ast, {:error, line_number}}
    else
      {ast, acc}
    end
  end

  defp count_lines(ast, acc, _) do
    {ast, acc}
  end
end
