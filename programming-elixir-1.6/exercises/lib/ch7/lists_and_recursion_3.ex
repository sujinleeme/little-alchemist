# -------
# Chapter 7: Lists and Recursion
#
# Exercise: Lists and Recursion-3 (Page 78) : Caesar cipher
# An Elixir single quoted string is actually a list of individual character codes.
# Write a function caesar(list, n) that adds n to each element of the list, but
# wrapping if the addition results in a character greater than z.
# -------

defmodule MyList.Exercise3 do
  def caesar([], _n), do: []

  def caesar([head | tail], n) when head + n <= ?z, do: [head + n | caesar(tail, n)]

  def caesar([head | tail], n), do: [head + n - 26 | caesar(tail, n)]
end
