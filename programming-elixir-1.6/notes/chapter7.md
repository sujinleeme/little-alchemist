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

## More Complex List Patterns

The function swaps pairs of values in a list:

```elixir
defmodule Swapper do
  def swap([]), do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end
```

### Lists of Lists

`[ timestamp, location_id, temperature, rainfall ]`

It gets only elements that have `location_id = 27` from the data.


```elixir
defmodule WeatherHistory do

  def test_data do
    [
     [1366225622, 26, 15, 0.125],
     [1366225622, 27, 15, 0.45],
     [1366225622, 28, 21, 0.25],
     [1366229222, 26, 19, 0.081],
     [1366229222, 27, 17, 0.468],
     [1366229222, 28, 15, 0.60],
     [1366232822, 26, 22, 0.095],
     [1366232822, 27, 21, 0.05],
     [1366232822, 28, 24, 0.03],
     [1366236422, 26, 17, 0.025]
    ]
  end

  def for_location_27([]), do: []
  def for_location_27([ [time, 27, temp, rain ] | tail]) do
    [ [time, 27, temp, rain] | for_location_27(tail) ]
  end
  def for_location_27([ _ | tail]), do: for_location_27(tail)

end
```

```elixir
iex> c "weather.exs"
  [WeatherHistory]
iex> import WeatherHistory
  WeatherHistory
iex> for_location_27(test_data)
    [[1366225622, 27, 15, 0.45], [1366229222, 27, 17, 0.468],
    [1366232822, 27, 21, 0.05]]
```

Now, it filters elements by a location prarm.


```elixir
defmodule WeatherHistory do

  def test_data do
    [
     [1366225622, 26, 15, 0.125],
     [1366225622, 27, 15, 0.45],
     [1366225622, 28, 21, 0.25],
     [1366229222, 26, 19, 0.081],
     [1366229222, 27, 17, 0.468],
     [1366229222, 28, 15, 0.60],
     [1366232822, 26, 22, 0.095],
     [1366232822, 27, 21, 0.05],
     [1366232822, 28, 24, 0.03],
     [1366236422, 26, 17, 0.025]
    ]
  end

  def for_location([], _target_loc), do: []

  def for_location([ [time, target_loc, temp, rain ] | tail], target_loc) do
    [ [time, target_loc, temp, rain] | for_location(tail, target_loc) ]
  end

  def for_location([ _ | tail], target_loc), do: for_location(tail, target_loc)

end
```

Now, it is able to pass in the location as a parameter.

```diff
defmodule WeatherHistory do

  def test_data do
    [
     [1366225622, 26, 15, 0.125],
     [1366225622, 27, 15, 0.45],
     [1366225622, 28, 21, 0.25],
     [1366229222, 26, 19, 0.081],
     [1366229222, 27, 17, 0.468],
     [1366229222, 28, 15, 0.60],
     [1366232822, 26, 22, 0.095],
     [1366232822, 27, 21, 0.05],
     [1366232822, 28, 24, 0.03],
     [1366236422, 26, 17, 0.025]
    ]
  end

  def for_location([], _target_loc), do: []

-  def for_location([ [time, target_loc, temp, rain ] | tail], target_loc) do
+  def for_location([ head = [_, target_loc, _, _ ] | tail], target_loc) do
-    [ [time, target_loc, temp, rain] | for_location(tail, target_loc) ]
+    [ head | for_location(tail, target_loc) ]
  end

  def for_location([ _ | tail], target_loc), do: for_location(tail, target_loc)

end
```

The filter doesn't care about he other three fileds in the head. It just needs the location.
