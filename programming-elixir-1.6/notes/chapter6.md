# Chapter 6. Modules and Named Functions

- Modules, the basic units of code
- Defining public and private named functions
- Guard clauses
- Module directives and attributes
- Calling functions in Erlang modules

## Compiling a module

```
iex> times.exs
```

Give IEx a source file’s name, and it compiles and loads the file before it displays a promp.

```
iex> c "times.exs"
iex > Times.double(4)
```

Use the `c` helper to compile a file without returning to the command line.

