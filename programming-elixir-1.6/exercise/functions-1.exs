# Exercise: Anonymous Functions

# Go into IEx. Create and run the functions that do the following:
# - list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]
# - sum.(1, 2, 3) #=> 6
# - pair_tuple_to_list.( { 1234, 5678 } ) #=> [ 1234, 5678 ]

# Answers
# list_concat = fn a, b -> a ++ b end
list_concat = &(&1 ++ &2)

# sum = fn a, b, c -> a + b + c end
sum = &(&1 + &2 + &3)

# pair_tuple_to_list = fn tuple -> Tuple.to_list(tuple) end
# pair_tuple_to_list = &(Tuple.to_list(&1))
# pair_tuple_to_list = &Tuple.to_list(&1)
# pair_tuple_to_list = &Tuple.to_list/1

# pair_tuple_to_list = fn {a, b} -> [a, b] end
pair_tuple_to_list = &([elem(&1, 0), elem(&1, 1)])

# Print outputs
IO.inspect list_concat.([:a, :b], [:c, :d]), label: "Func: list_concat"
IO.inspect sum.(1, 2, 3), label: "Func: sum"
IO.inspect pair_tuple_to_list.({1234, 5678}), label: "Func: pair_tuple_to_list"
