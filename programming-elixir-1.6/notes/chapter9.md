# Chapter 9. An Aside - What are types?


A different between the primitive list and the functionality of the List module

A primitive Elixir list is just an ordered group of values. (e.g. `1..3`) The primitive list is an implementation, whereas the List module adds a layer of abstraction. Both implement types, but the type is different. Primitive lists, for example, don’t have a flatten function.

Working with a keyword list, you have access to the APIs in the primitive list type, and the List and Keyword modules. You also get Enum and Collectable.

This is a form of the duck typing that is talked about in dynamic object-oriented languages.
