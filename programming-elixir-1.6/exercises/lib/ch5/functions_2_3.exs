# -------
# Chapter 5: Anonymous Functions
#
# Exercise: Functions-2
# Write a function that takes three arguments.
# If the first two are zero, return “FizzBuzz.”
# If the first is zero, return “Fizz.”
# If the second is zero, return “Buzz.” Otherwise return the third argument.
# Do not use any language features that we haven’t yet covered in this book.
# -------

fizz_buzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, n -> n
end

# -------
# Exercise: Functions-3
# The operator rem(a, b) returns the remainder after dividing a by b.
# Write a function that takes a single integer (n) and calls the function in the previous exercise, passing it rem(n,3), rem(n,5), and n.
# Call it seven times with the arguments 10, 11, 12, and so on.
# You should get “Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.
# -------

iteration = 6

calculate_fizz_buzz = fn n ->
  Enum.map(0..iteration, &fizz_buzz.(rem(n + &1, 3), rem(n + &1, 5), n + &1)) |> Enum.join(", ")
end

IO.inspect(calculate_fizz_buzz.(10))

# -------
