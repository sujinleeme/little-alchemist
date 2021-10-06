# Chapter 6: Modules and Named Functions

# Exercise: Exercise: Modules and Functions-4 (Page 57)
# Implement and run a function sum(n) that uses recursion to calculate the sum of the integers from 1 to n .
# You’ll need to write this function inside a module in a separate file.
# Then load up iex, compile that file, and try your function.

# Exercise: Modules and Functions-5 (Page 57)
# Write a function gcd(x,y) that finds the greatest common divisor between two
# nonnegative integers. Algebraically, gcd(x,y) is x if y is zero, gcd(y,
# rem(x,y)) otherwise.

# Answer
defmodule Math do
  def sum(0), do: 0
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
