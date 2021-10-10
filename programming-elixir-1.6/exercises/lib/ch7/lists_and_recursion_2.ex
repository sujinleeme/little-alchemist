# -------
# Chapter 7: Lists and Recursion
#
# Exercise: Lists and Recursion-2 (Page 77)
# Write max(list) that returns the element with the maximum value in the list.
# -------

defmodule MyList.Exercise2 do
  def max([head]), do: head

  def max([head | tail]) when is_integer(head) === false, do: max([tail])

  def max([head | [next | tail]]) when is_integer(next) === false or head > next, do: max([head | tail])

  def max([_head | tail]), do: max(tail)
end
