# Exercise: Functions-2
# Write a function that takes three arguments.
# If the first two are zero, return “FizzBuzz.”
# If the first is zero, return “Fizz.”
# If the second is zero, return “Buzz.” Otherwise return the third argument.
# Do not use any language features that we haven’t yet covered in this book.

fizz_buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, n) -> n
end

# Exercise: Functions-3
# The operator rem(a, b) returns the remainder after dividing a by b.
# Write a function that takes a single integer (n) and calls the function in the previous exercise, passing it rem(n,3), rem(n,5), and n.
# Call it seven times with the arguments 10, 11, 12, and so on.
# You should get “Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.

iteration = 6
fizz_buzz_params = &({rem(&1, 3), rem(&1, 5), &1})

fizz_buzz_with_rem = fn n -> Enum.map(0..iteration, fn(i) ->
  case fizz_buzz_params.(i + n) do
    {x, y, z} -> fizz_buzz.(x, y, z)
  end
end) |> Enum.join(", ") end

IO.inspect fizz_buzz_with_rem.(10)
