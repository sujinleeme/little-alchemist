# Chapter 6. Modules and Named Functions

- Modules, the basic units of code
- Defining public and private named functions
- Guard clauses
- Module directives and attributes
- Calling functions in Erlang modules

## Compiling a module

```
iex> times.exs
```

Give IEx a source file’s name, and it compiles and loads the file before it displays a promp.

```
iex> c "times.exs"
iex > Times.double(4)
```

Use the `c` helper to compile a file without returning to the command line.

## Function calls and pattern matching

Factorial function

```
Factorial(0) -> 1
Factorial(n) -> n * factorial(n - 1)
```

Good:

```elixir
defmodule Factorial do
  def of(0), do: 1
  def of(n), do: n * of(n-1)
end
```

Bad:

```elixir
defmodule BadFactorial do
  def​ of(n), ​do​: n * of(n-1)
  def​ of(0), ​do​: 1
​end
```

The first function definition will always match and the second will never be called.
