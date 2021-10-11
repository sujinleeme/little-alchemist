# Miscellaneous

## Fun facts

- [`mix` comes from `mixing the elixir`](https://twitter.com/rrrene/status/1420340262962962434
) - René Föhring
    - [Who's mixing elixirs? Hex](https://twitter.com/itshq1/status/1420377810300977158).

## Remove zero width space character (U+200B) in VSCode

I faced the Zero Width Space character (U+200B) trap in VSCode on the way to do elixir coding.

```elixir
prefix = fn pre -> (fn word -> "#{pre} #{word}" end) end
mrs = prefix.(​"​​Mrs"​)
```

```
iex(1)> c "functions-4.exs"

== Compilation error in file functions-4.exs ==
** (SyntaxError) functions-4.exs:15:15: unexpected token: "​" (column 15, code point U+200B)
    (elixir 1.12.3) lib/kernel/parallel_compiler.ex:320: anonymous fn/4 in Kernel.ParallelCompiler.spawn_workers/7
** (CompileError)  compile error
    (iex 1.12.3) lib/iex/helpers.ex:202: IEx.Helpers.c/2
```

It is caused by Visual Studio that allows the Unicode character Zero Width Space (U+200B) to be pasted into the code editor. This character is (as the name implies) invisible.

With the help of [Gremlins tracker](https://github.com/nhoizey/vscode-gremlins), all invisible spacings are going to be visible and you may fix them. This [issue](https://github.com/Microsoft/vscode/issues/58252) was reported to VSCode repo.
