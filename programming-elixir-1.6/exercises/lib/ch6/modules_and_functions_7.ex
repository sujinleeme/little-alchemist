# -------
# Exercise: Modules and Functions-7 (Page 70)
#
# Find the library functions to do the following, and then use each in iex. (If
# there’s the word Elixir or Erlang at the end of the challenge, then you’ll find the
# answer in that set of libraries.)
#
# - Convert a float to a string with 2 decimal digits. (Erlang)
# - Get the value of an operating system environment variable. (Elixir)
# - Return the extension component of a file name (so return .exs if given "dave/test.exs" (Elixir)
# - Return the current working directory of the process. (Elixir)
# - Convert a string containing JSON into Elixir data structures. (Just find, #don’t install)
# - Execute an command in your operating system’s shell

# --------

# --------
# Answers
#
# - Convert a float to a string with 2 decimal digits. (Erlang)
float_to_string = &(:erlang.float_to_list(&1, [{:decimals, 2}]))
IO.inspect float_to_string.(2.123123)


# - Get the value of an operating system environment variable. (Elixir)
get_env_path = &(System.get_env(&1))
IO.inspect get_env_path("HOME")

# - Return the extension component of a file name (so return .exs if given "dave/test.exs" (Elixir)
get_extension = &(Path.extname(&1))
IO.inspect get_extension("HOME")

# - Return the current working directory of the process. (Elixir)
{:ok, path} = File.cwd

# - Convert a string containing JSON into Elixir data structures. (Just find, #don’t install)
# Poison: https://github.com/devinus/poison

# - Execute an command in your operating system’s shell
System.cmd("ls", ["-al"])

# --------
