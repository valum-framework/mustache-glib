
using GLib;

namespace Mustache
{
	/**
	 *
	 */
	public errordomain ParseError
	{
		/**
		 *
		 */
		UNEXPECTED_TOKEN,
	}

	/**
	 *
	 */
	public errordomain RenderError
	{
		VARIABLE_NOT_FOUND,
		PARTIAL_NOT_FOUND
	}

	/**
	 * Check if the node is falsy.
	 */
	public internal falsy (Json.Node node)
	{
		return node.is_null () ||
		       NodeType.ARRAY == node.get_node_type () && node.get_array ().is_empty () ||
		       typeof (bool) == node.get_value_type () && !node.get_bool ();
	}

	public string render (InputStream template, Json.Node env)
	{
		new Parser (new Lexer (template))
	}
}
