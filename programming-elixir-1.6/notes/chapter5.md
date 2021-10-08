# Chapter 5. Anonymous Functions

- Anonymous functions
- Pattern matching and arguments
- Higher-order Functions
- Closures
- The & function literal for

### Syntax


```elixir
iex>​ sum = ​fn​ (a, b) -> a + b ​end​
#Function<12.17052888 in :erl_eval.expr/5>
​iex>​ sum.(1, 2)
# omit the parentheses
iex>​ sum = ​fn​ a, b -> a + b ​end
# ​&1 refers to the first argument the callback function would receive. The ampersand by itself ( & ) is a shorthand for a captured function.
iex> sum = &(&1 + &2)
```

#### Anonymous function shorthand

Read: [Understanding the & (capture operator) in Elixir](https://dockyard.com/blog/2016/08/05/understand-capture-operator-in-elixir)

`fn ->` is equal to `&(...`
`x -> x` is equal to `...(&1`

`fn(x, y, z) -> x + y + z end`

`x == &1` because `x` is the first argument
`y == &2` because `y` is the second argument
`z == &3` because `z` is the third argument

```elixir
pair_tuple_to_list = fn tuple -> Tuple.to_list(tuple) end
pair_tuple_to_list = &(Tuple.to_list(&1))
pair_tuple_to_list = &Tuple.to_list(&1)
pair_tuple_to_list = &Tuple.to_list/1
```

What's `&Tuple.to_list/1`?

> It contains a list of functions, each of which is written in the format `<function name>/<arity>`. Arity stands for the number of arguments.

### Functions and Pattern Matching

```elixir
iex>​ swap = ​fn​ { a, b } -> { b, a } ​end​
#Function<12.17052888 in :erl_eval.expr/5>
iex>​ swap.( { 6, 8 } )
{8, 6}
```

### One Function, Multiple Bodies

```elixir
handle_open = ​fn​
​   {​:ok​, file}  -> ​"​​First line: ​​#{​IO.read(file, ​:line​)​}​​"
​   {_,   error} -> ​"​​Error:  ​​#{​​:file​.format_error(error)​}​​"​
​  ​end​”

IO.puts handle_open.(File.open(​"​​Rakefile"​))      ​# call with a file that exists​
IO.puts handle_open.(File.open(​"​​nonexistent"​))   ​# and then with one that doesn't​”
```

### Functions can return functions

Bad

```elixir
​iex>​ fun1 = ​fn​ -> ​fn​ -> ​"​​Hello"​ ​end​ ​end
iex>​ fun1.()
​​iex>​ fun1.().()
"Hello"
```

Good: Use parentheses to make the inner function more obvious.

```elixir
​iex>​ fun1 = ​fn​ -> (​fn​ -> ​"​​Hello"​ ​end​) ​end
​iex>​ other = fun1.()
iex> other.()
"Hello"
```

Functions remember their original environment.

```elixir
iex>​ greeter = ​fn​ name -> (​fn​ -> ​"​​Hello ​​#{​name​}​​"​ ​end​) end​
​#Function<12.17052888 in :erl_eval.expr/5>
​iex>​ dave_greeter = greeter.(​"​​Dave"​)
​#Function<12.17052888 in :erl_eval.expr/5>
​iex>​ dave_greeter.()
​"Hello Dave”
```

Why? Elixir automatically carry with them the bindings of variables in the scope in which they are defined. In this example, the variable `name` is bound in the scope of the outer function. When the inner function is defined, it inherits this scope and carries the binding of name around with it.
This is _closure_. The scope encloses the bindings of its variables, packaging them into something that can be saved and used later.

#### Parameterized function

Each time we call the outer function, we give it a value for n and it returns a function that adds `n` to its own parameter.

```elixir
iex>​ add_n = ​fn​ n -> (​fn​ other -> n + other ​end​) ​end​
​iex>​ add_two = add_n.(2)
​​iex>​ add_five = add_n.(5)
​iex>​ add_two.(3)
​5
iex>​ add_five.(7)
​12
```

#### Passing functions as arguments

```
iex>​ times_2 = ​fn​ n -> n * 2 ​end​
​#Function<12.17052888 in :erl_eval.expr/5>
​iex>​ apply = ​fn​ (fun, value) -> fun.(value) ​end​
#Function<12.17052888 in :erl_eval.expr/5>
iex>​ apply.(times_2, 6)
12
​iex>​ Enum.map list, ​fn​ elem -> elem * 2 ​end​
[2, 6, 10, 14, 18]
```

`^` [Pin operator](https://elixir-lang.org/getting-started/pattern-matching.html#the-pin-operator) can be used the current value of a variable in a pattern and function parameter.

Because `[]` and `{}` are operators in Elixir, literal lists and tuples can also be turned into functions.

```
​iex>​ divrem = &{ div(&1,&2), rem(&1,&2) }
​iex>​ divrem.(13, 5)
{2, 3}
```

The basis of programming is transforming data. Functions are the little engines that perform that transformation.
