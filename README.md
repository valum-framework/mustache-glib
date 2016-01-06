mustache-glib
=============

Logic-less templates for people using GLib.

## Usage

```vala
using Mustache;
using Json;

var context = new FileContext (File.new_for_path ("templates"));
var template = new Parser (new Lexer (context.read_partial ("index.html.mustache"))).template ();

var env = new Json.Node ();
env.set_object (new Json.Object ());

template.to_stream (@out, env);
```

## Implementation Reference

This is still a work-in-progress, so here's the implementation reference:

The reference document is here: https://mustache.github.io/mustache.5.html

The lexer can be implemented using
[GLib.Scanner](http://valadoc.org/#!api=glib-2.0/GLib.Scanner) as a reference.
Using it directly is not really useful as it is designed to parse C-like
languages.

Recursive descent can be used to parse the template:

 - submap of the environment is passed as a parameter, this way the parsing is
   contextualized and the function stack is used to backtrack in the environment
 - template is tokenized, analyzed and rendered in an `OutputStream` during the
   descent to maintain a low memory consumption and render very big templates
   efficiently

The Set Delimiter feature is a real pain. The lexer will have to memorize the
tag delimiters.

Environment will hold different types:

 - string
 - function
 - environment (hash)

The function should by typed by a delegate.

libxml2 can handle HTML escaping by encoding entities:
http://valadoc.org/#!api=libxml-2.0/Html

