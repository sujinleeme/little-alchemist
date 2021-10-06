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

## Guard clauses

```elixir
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end
end

Guard.what_is(99)        # => 99 is a number
Guard.what_is(:cat)      # => cat is an atom
Guard.what_is([1,2,3])   # => [1,2,3] is a list
Guard.what_is([1,2,3])   ​# => [1,2,3] is a list​
```

In factorial function, it's good idea to add a _guard clause_ to stop infinite loop.

```diff
defmodule Factorial do
  def of(0), do: 1
- def of(n), do: n * of(n-1)
+ def of(n) when is_integer(n) and n > 0 do
    n * of(n-1)
  end
end
```

With a negative arugment, it will show clause error.

```
iex>​ Factorial.of -100
​ ​**​ (FunctionClauseError) no function clause matching in Factorial.of/1
```

We can add a type constraint, "The parameter must be an integer."

```elixir
def of(0), do: 1
​def of(n) ​do​
​ 	  ​if​ n < 0 ​do​
​ 	    ​raise​ ​"​​factorial called on a negative number"​
​ 	  ​else​
​ 	    n * of(n-1)
​ 	  ​end​
​ 	​end
```

What's difference between the guard clauses and conditional logic?
Tthe first case isn’t defined at all for negative parameters and makes it explicit that the function domain is nonnegative integers. In the second case, the of/1 function is defined for any input.
