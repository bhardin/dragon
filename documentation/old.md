Thing vs World
--------------

There are two important objects that exist in Dragon for all runtimes.
The first is `Thing` which is the basic object.
All objects initially have the behavior of `Thing`.
The other object is `World`, which is the default context of the first line of any code.
wq

-> vs =>
--------

In Dragon there are 2 types of anonymous function symbols.
They do roughly the same thing with one exception.

Consider the following code:

    open("README.mdown") ->
      mode("write")
      write("Hello, World")

As you know the above context becomes the object returned by `open()`.
It is lexically equivelent to writing `self mode(...)` and `self write(...)`.
You can always access the bindings of the open call scope by using doing it like this:


    name: "Kurtis"
    open("README.mdown") ->
      mode("write")
      write("Hello, World")
      write(_context name)

In that example `self _context()` returns the `self` that `open()` is being called on.
That object has the assignment `name` binded to it.
This is very clunky, however and so we've provided you the context arrow!
Here's an example of using it correctly:

    name: "Kurtis"
    open("README.mdown") =>
      mode("write")
      write("Hello, World")
      write(name)

Now `self` recieves the assignments of the context that `open()` was called on.
This can be slightly dangerous as in the below example:

  Profile: Object clone ->
    first_name: function(name split)


  first_name: "John"
  Profile new =>
    name: "Jane Public"
    first_name

What does the last line return?
Does it return the output of the function above?
Does it return the assignment?
With a simple `->` this would be an answer as the assignment would be out of context.
With the fat arrow the result would be `"John"`.
While the function `first_name()` was defined for Profile the fat arrow brings in the bindings into the `new` Profile object.
It then overwrites the function with the text value.
