# -------
# Chapter 5: Anonymous Functions
#
# Exercise: Functions-4
# Write a function prefix that takes a string.
# It should return a new function that takes a second string.
# When that second function is called, it will return a string containing the first string, a space, and the second string.
#
# iex> mrs = prefix.("Mrs")
# iex> mrs.("Smith")
# "Mrs Smith"
# iex> prefix.("Elixir").("Rocks")
# "​Elixir Rocks"​”
# -------

# -------
# Answers

prefix = fn pre -> fn word -> "#{pre} #{word}" end end
mrs = prefix.("Mrs")
IO.inspect mrs.("Smith")
IO.inspect prefix.("Elixir").("Rocks")

# -------
