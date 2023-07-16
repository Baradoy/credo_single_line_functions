# CredoSingleLineFunctions

A Credo rule to report when `do:` syntax is used over multiple lines. This rule will report multi-line functions as well as `do:` syntax used in other clauses.

As per the [Elixir lanuage docs](https://elixir-lang.org/getting-started/modules-and-functions.html#named-functions):
```
And it will provide the same behaviour. You may use do: for one-liners but always
use do-blocks for functions spanning multiple lines. If you prefer to be consistent,
you can use do-blocks throughout your codebase.
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
