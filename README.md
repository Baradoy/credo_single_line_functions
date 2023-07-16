# CredoSingleLineFunctions

A Credo rule to report when `do:` syntax is used over multiple lines. This rule will report multi-line functions as well as `do:` syntax used in other clauses.

As per the [Elixir lanuage docs](https://elixir-lang.org/getting-started/modules-and-functions.html#named-functions):
```
And it will provide the same behaviour. You may use do: for one-liners but always
use do-blocks for functions spanning multiple lines. If you prefer to be consistent,
you can use do-blocks throughout your codebase.
```

# Usage

Add the dependency to `mix.exs`:

```elixir
defp deps do
    [
      ...
      {:credo_single_line_functions, github: "Baradoy/credo_single_line_functions", tag: "v0.1.0", only: [:dev, :test], runtime: false},
      ...
    ]
end
```

Add the check to `.credo.exs`:
```elixir
checks: [
  ...
  {CredoSingleLineFunctions.KeywordBlocksAreSingleLine, []},
  ...
}
```

# Examples:

## preferred

```elixir
  def foo, do: 1 |> Integer.to_string() |> String.to_integer()
  def foo,
    do: 1 |> Integer.to_string() |> String.to_integer()
```

## NOT preferred

```elixir
  def foo,
    do:
      1
      |> Integer.to_string()
      |> String.to_integer()
```
