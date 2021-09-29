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