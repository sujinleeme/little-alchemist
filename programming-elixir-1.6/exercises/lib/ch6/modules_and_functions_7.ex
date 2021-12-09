# -------
# Chapter 6: Modules and Named Functions
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

# - Convert a float to a string with 2 decimal digits. (Erlang)
float = 2.123123
float_to_string = :erlang.float_to_list(float, [{:decimals, 2}])
IO.inspect(float_to_string)

# Get the value of an operating system environment variable. (Elixir)
dir = "HOME"
env_path = System.get_env(dir)
IO.inspect(env_path)

# Return the extension component of a file name (so return .exs if given "dave/test.exs" (Elixir)
file_name = "test.exs"
extension = Path.extname(file_name)
IO.inspect(extension)

# Return the current working directory of the process. (Elixir)
{:ok, path} = File.cwd()
IO.inspect(path)

# Convert a string containing JSON into Elixir data structures. (Just find, #don’t install)
# Poison: https://github.com/devinus/poison

# Execute an command in your operating system’s shell
System.cmd("ls", ["-al"])
