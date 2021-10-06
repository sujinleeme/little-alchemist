# Chapter 6: Modules and Named Functions

# Exercise: Modules and Functions-1 (Page 55)
# - Extend the Times module with a triple function, that multiplies its parameter by three
# - Run the result in iex. Use both techniques to compile the file.
# - Add a quadruple function. (Maybe it could call the double function….)

# Answer
defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quardruple(n), do: double(double(n))
end
