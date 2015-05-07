mustache-glib
=============

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

