defmodule CredoSingleLineFunctions.KeywordBlocksAreSingleLineTest do
  use Credo.Test.Case

  @described_check CredoSingleLineFunctions.KeywordBlocksAreSingleLine

  test "it should NOT report multi-line do block functions" do
    """
    defmodule CredoTestModule do
      def some_fun do
        :ok
        |> Atom.to_string()
        |> String.to_atom()
      end
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> refute_issues()
  end

  test "it should NOT report single-line do: functions" do
    """
    defmodule CredoTestModule do
      def some_fun,
        do: :ok |> Atom.to_string() |> String.to_atom()
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> refute_issues()
  end

  test "it should NOT report single-line do: functions with guards" do
    """
    defmodule CredoTestModule do
      def some_fun(atom)
        when atom == :some_atom,
        do: :ok |> Atom.to_string() |> String.to_atom()
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> refute_issues()
  end

  test "it should report multi-line do: functions" do
    """
    defmodule CredoTestModule do
    def some_fun,
      do:
        :error
        |> Atom.to_string()
        |> String.to_atom()
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> assert_issue()
  end

  test "it should report two-line do: functions" do
    """
    defmodule CredoTestModule do
    def some_fun,
      do:
        :error |> Atom.to_string() |> String.to_atom()
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> assert_issue()
  end

  test "it should report multi-line do: sections" do
    """
    defmodule CredoTestModule do
      def some_fun do
        with true <- true,
          do:
            :ok
            |> Atom.to_string()
            |> String.to_atom()
      end
    end
    """
    |> to_source_file()
    |> run_check(@described_check)
    |> assert_issue()
  end
end
