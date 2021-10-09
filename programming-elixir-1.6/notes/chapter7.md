# Chapter 7. Lists and Recursion

- The recursive structure of lists
- Traversing and building lists
- Accumulators
- Implementing map and reduce

## Heads and tails

```elixir
[3 | [ ]  # [3]
```

## Using Head and Tail to Process a List

```elixir
defmodule MyList do
  def len([]), do: 0
  def len([head|tail]), do: 1 + len(tail)
end
```

```elixir
len([11,12,13,14,15])
​ 	= 1 + len([12,13,14,15])
​ 	= 1 + 1 + len([13,14,15])
​ 	= 1 + 1 + 1 + len([14,15])
​ 	= 1 + 1 + 1 + 1 + len([15])
​ 	= 1 + 1 + 1 + 1 + 1 + len([])
​ 	= 1 + 1 + 1 + 1 + 1 + 0
​ 	= 5
```

We have a `compilation warning` — we never used the variable head in the body of our function.
We can fix that, and make our code more explicit, using the special variable `_`(underscore), which acts as a placeholder.

```elixir
defmodule MyList do
  def len([]),               do: 0
  def len([ _head | tail ]), do: 1 + len(tail)
​end
```

## Using Head and Tail to Build a List

```elixir
def square([]),              do: []
def square([ head | tail ]), do: [ head*head | square(tail) ]
```

## Creating a map function

```elixir
def map([], _func),             do: []
def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]

MyList.map[1,2,3,4], fn (n) -> n * n end
```

## Reducing a List to a Single value

```elixir
defmodule MyList do
  def reduce([], value, _) do
    value 
  end
  def reduce([head | tail], value, func) do 
    reduce(tail, func.(head, value), func) 
  end
end​
```

```elixir
iex> MyList.reduce([1,2,3,4,5], 0, &(&1 + &2))
```
