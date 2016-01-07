/*
 * This file is part of Mustache-GLib.
 *
 * Mustache-GLib is free software: you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * Mustache-GLib is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Mustache-GLib.  If not, see <http://www.gnu.org/licenses/>.
 */

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
