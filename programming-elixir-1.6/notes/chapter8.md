# Chapter 8. Maps, Keyword Lists, Sets, and Structs

- The two and a half dictionary data types
- Pattern matching and updating maps
- Structs
- Nested data structures

## How to Choose Between Maps, Structs, and Keyword Lists

Do I want to pattern-match against the contents (for example, matching a dictionary that has a key of `:name` somewhere in it)?
__If so, use a map.__

Will I want more than one entry with the same key?
__If so, you’ll have to use the `Keyword` module.__

Do I need to guarantee the elements are ordered?
__If so, again, use the `Keyword` module.__

Do I have a fixed set of fields (that is, is the structure of the data always the same)?
__If so, use a `struct`.__

Otherwise, if you’ve reached this point,
__Use a `map`.__

## Pattern matching and updating maps

```elixir
person = %{ ​name:​ ​"​​Dave", ​height​ 1.88 }
```

```elixir
people = [
  %{ name: "Grumpy",    height: 1.24 },
  %{ name: "Dave",      height: 1.88 },
  %{ name: "Dopey",     height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy",    height: 1.28 }
]

IO.inspect(for person = %{ height: height } <- people, height > 1.5, do: person)
```

```elixir
people = [
  %{ name: "Grumpy",    height: 1.24 },
  %{ name: "Dave",      height: 1.88 },
  %{ name: "Dopey",     height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy",    height: 1.28 }
]

defmodule HotelRoom do

  def book(%{name: name, height: height})
  when height > 1.9 do
    IO.puts "Need extra-long bed for #{name}"
  end

  def book(%{name: name, height: height})
  when height < 1.3 do
    IO.puts "Need low shower controls for #{name}"
  end

  def book(person) do
    IO.puts "Need regular bed for #{person.name}"
  end

end

people |> Enum.each(&HotelRoom.book/1)

#=> Need low shower controls for Grumpy
#   Need regular bed for Dave
#   Need regular bed for Dopey
#   Need extra-long bed for Shaquille
#   Need low shower controls for Sneezy
```

## Structs

`%{ … }` is fine for anonymous maps. For creating a typed map, we use `struct`. (See: [Structs - elixir-lang.org](https://elixir-lang.org/getting-started/structs.html))

To define a struct, the `defstruct` construct is used :

```elixir
defmodule Subscriber do
  defstruct name: "​​"​, ​paid:​ false, ​over_18:​ true
end
```

`%{}` is creating a struct.

```elixir
iex> s3 = %Subscriber{ ​name:​ ​"​​Mary"​, ​paid:​ true }
%Subscriber{name: "Mary", over_18: true, paid: true}
```

```elixir
defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Attendee{name: name}) when name !=  "" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vip_badge(%Attendee{}) do
    raise "missing name for badge"
  end
end
```

## Nested Dictionary Structures

```elixir
defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end

defmodule User do
  report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"},
                      details: "broken"}

  IO.inspect report

  report = %BugReport{ report | owner: %Customer{ report.owner | company: "PragProg" }}

  IO.inspect report

  IO.inspect update_in(report.owner.name, &("Mr. " <> &1))
end
```

### Nested accessors and nonstructs

```elixir
iex(1)> report = %{owner: %{name: "Dave", company: "Pragmatic"}}
%{owner: %{company: "Pragmatic", name: "Dave"}}
iex(2)> put_in(report[:owner][:company], "PragProg")
%{owner: %{company: "PragProg", name: "Dave"}}
```

### Dynmaic (runtime nested accessors)

The nested accessors sare macros have limitations.

* The number of keys you pass a particular call is static.
* You can’t pass the set of keys as parameters between functions.

`get_in`, `put_in`, `update_in`, `get_and_update_in` can all take a list of keys as a seperate parameter.

```elixir
nested = %{
    buttercup: %{ 
      actor: %{
        first: "Robin",
        last:  "Wright"
      },
      role: "princess"
    },
    westley: %{
      actor: %{
        first: "Cary",
        last:  "Elwes"     # typo!
      },
      role: "farm boy"
    }
}

IO.inspect get_in(nested, [:buttercup])
# => %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}
```

### The access Mmdule

```elixir
cast = [
  %{
    character: "Buttercup",
    actor: %{
      first: "Robin",
      last:  "Wright"
    },
    role: "princess"
  },
  %{
    character: "Westley",
    actor: %{
      first: "Cary",
      last:  "Elwes"
    },
    role: "farm boy"
  }
]

IO.inspect get_in(cast, [Access.all(), :character])
#=> ["Buttercup", "Westley"]

IO.inspect get_in(cast, [Access.at(1), :role])
#=> "farm boy"
```

with elem function, 

```elixir
cast = [
  %{
    character: "Buttercup",
    actor:    {"Robin", "Wright"},
    role:      "princess"
  },
  %{
    character: "Westley",
    actor:    {"Carey", "Elwes"},
    role:      "farm boy"
  }
]

IO.inspect get_in(cast, [Access.all(), :actor, Access.elem(1)])
#=> ["Wright", "Elwes"]

IO.inspect get_and_update_in(cast, [Access.all(), :actor, Access.elem(1)],
                             fn (val) -> {val, String.reverse(val)} end)
#=> {["Wright", "Elwes"],
#    [%{actor: {"Robin", "thgirW"}, character: "Buttercup", role: "princess"},
#     %{actor: {"Carey", "sewlE"}, character: "Westley", role: "farm boy"}]}
```

with `key` and `key!` functions,

```elixir
cast = %{
  buttercup: %{
    actor:    {"Robin", "Wright"},
    role:      "princess"
  },
  westley: %{
    actor:    {"Carey", "Elwes"},
    role:      "farm boy"
  }
}

IO.inspect get_in(cast, [Access.key(:westley), :actor, Access.elem(1)])
#=> "Elwes"

IO.inspect get_and_update_in(cast, [Access.key(:buttercup), :role],
                             fn (val) -> {val, "Queen"} end)
#=> {"princess",
#    %{buttercup: %{actor: {"Robin", "Wright"}, role: "Queen"},
#      westley: %{actor: {"Carey", "Elwes"}, role: "farm boy"}}}
```

## Sets

Use ` MapSet`

```elixir
iex(5)> set2 = 3..8 |> Enum.into(MapSet.new)
#MapSet<[3, 4, 5, 6, 7, 8]>
iex(6)> MapSet.member? set1,3
true
iex(7)> set1
#MapSet<[1, 2, 3, 4, 5]>
iex(8)> MapSet.union set1,set2
#MapSet<[1, 2, 3, 4, 5, 6, 7, 8]>
iex(9)> MapSet.union set1,set2
#MapSet<[1, 2, 3, 4, 5, 6, 7, 8]>
```