# -------
# Chapter 7: Lists and Recursion

# Exercise: Lists and Recursion-4 (Page 81)
# Write a function MyList.span(from, to) that returns a list of the numbers from
# `from` up to `to`.
# -------

defmodule MyList.Exercise4 do
  def span(from, from), do: [from]
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
end
