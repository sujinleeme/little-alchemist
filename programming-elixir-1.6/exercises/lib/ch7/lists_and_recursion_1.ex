# -------
# Chapter 7: Lists and Recursion
#
# Exercise: Lists and Recursion-1 (Page 77)
# Write a function mapsum that takes a list and a function.
# It applies the function to each element of the list, and then sums the result, so
# iex> MyList.mapsum([1, 2, 3], &(&1 * &1))
# 14
# -------

defmodule MyList.Exercise1 do
  def mapsum([], _func), do: 0

  def mapsum([head | tail], func) when is_integer(head), do: func.(head) + mapsum(tail, func)
end
