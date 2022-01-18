# Chapter 6. Modules and Named Functions

- Modules, the basic units of code
- Defining public and private named functions
- Guard clauses
- Module directives and attributes
- Calling functions in Erlang modules

## Compiling a module

```elixir
iex> times.exs
```

Give IEx a source file’s name, and it compiles and loads the file before it displays a promp.

```elixir
iex> c "times.exs"
iex > Times.double(4)
```

Use the `c` helper to compile a file without returning to the command line.

## Function calls and pattern matching

Factorial function

```elixir
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
​    ​if​ n < 0 ​do​
​      ​raise​ ​"​​factorial called on a negative number"​
​    ​else​
​      n * of(n-1)
​    ​end​
​  ​end
```

What's difference between the guard clauses and conditional logic?
Tthe first case isn’t defined at all for negative parameters and makes it explicit that the function domain is nonnegative integers. In the second case, the of/1 function is defined for any input.

### Guard-clause limitations

- [Operators](https://hexdocs.pm/elixir/master/operators.html)
- [Type-check functions](https://hexdocs.pm/elixir/1.12/Kernel.html#in/2-guards)

## Default parameters

`param \\ value` gives a defualt to any of its parameters.

```elixir
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a", "b")             # => ["a",2,3,"b"]
Example.func("a", "b", "c")        # => ["a","b",3,"c"]
Example.func("a", "b", "c", "d")   # => ["a","b","c","d"]
```

```elixir
defmodule Params do

  def func(p1, p2 \\ 123) 

  def func(p1, p2) when is_list(p1)  do
    "You said #{p2} with a list"
  end

  def func(p1, p2) do
    "You passed in #{p1} and #{p2}"
  end

end

IO.puts Params.func(99)           # You passed in 99 and 123
IO.puts Params.func(99, "cat")    # You passed in 99 and cat
IO.puts Params.func([99])         # You said 123 with a list
IO.puts Params.func([99], "dog")  # You said dog with a list
```

### Private Functions

`~defp` macro defines a private function—one that can be called only within the module that declares it.

```elxiir
people = DB.find_customers
orders = Orders.for_customers(people)
​tax    = sales_tax(orders, 2018)
​filing = prepare_filing(tax)
```

```
filing = prepare_filing(sales_tax(Orders.for_customers(DB.find_customers), 2018))
filing = DB.find_customers
          |> Orders.for_customers
          |> sales_tax(2018)
          |> prepare_filing”
```

## Modules

Elixir programmers use nested modules to impose structure for readability and reuse. After all, every programmer is a library write. All modules are defined at the top level.

```elixir
defmodule Outer do
  defmodule Inner do
    def inner_func do
    end
  end
  
  def outer_func do
    Inner.inner_func
  end
end

Outer.outer_func
Outer.Inner.inner_func
```

We can directly define a nested module.

```elixir
defmodule Mix.Tasks.Doctest do
  def run do
  end
end
```

### Directives for Modules

[alias, require, and import](https://elixir-lang.org/getting-started/alias-require-and-import.html) are “lexically scoped” meaning that they can be used inside a module and apply to the whole module body, or inside individual functions and apply to the scope of that functions only.

https://medium.com/@vas.manoli/elixirs-alias-require-and-import-d28e3acf4d79

### Module attributes

Inside a module, you can access attributes by prefixing the name with an at sign (`@`).
 Each item of metadata is called an attribute of the module and is identified by a name.
```
@name  value
```

```elixir
​defmodule​ Example ​do​
​ 	  @author  ​"​​Dave Thomas"​
​ 	  ​def​ get_author ​do​
​ 	    @author
​ 	  ​end​
​ 	​end​
​ 	IO.puts ​"​​Example was written by ​​#{​Example.get_author​}​"
```

```elixir
“​ 	​defmodule​ Example ​do​
​ 	  @attr ​"​​one"​
​ 	  ​def​ first, ​do​: @attr
​ 	  @attr ​"​​two"​
​ 	  ​def​ second, ​do​: @attr
​ 	​end​
​ 	IO.puts ​"​​#{​Example.second​}​​  ​​#{​Example.first​}​​"​ 
```

### Module Names: Elixir, Erlang, and Atoms


```elixir
iex>​ is_atom IO
​ 	true
​ 	​iex>​ to_string IO
​ 	"Elixir.IO"
​ 	​iex>​ ​:"Elixir.IO"​ === IO
​ 	true
```

Such as `IO`, Elixir converts it internally into an atom of the same name with `Elixir`. So a call to a function in a module is really an atom followed by a dot followed by the function name

## # “Calling a Function in an Erlang Library

Erlang module `timer` is, the atom `timer` and Elixir, we write that as `:timer`. To use `tc` function, you'd write ` :timer.rc`.
