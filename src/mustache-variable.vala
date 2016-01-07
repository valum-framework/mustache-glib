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

public class Mustache.Variable : Mustache.Tag
{
	public string key { construct; get; }

	public bool unescaped { construct; get; }

	public Variable (Context context, string key, bool unescaped)
	{
		Object (context: context, key: key, unescaped: unescaped);
	}

	public to_stream (OutputStream @out, Json.Node env, RenderFlags flags)
		requires (NodeType.OBJECT == env.get_node_type ())
	{
		if (env.get_object ().has_member (key))
		{
			if (unescaped)
			{
			}
			else
			{
#if HAVE_LIBXML
				Html.encode_entities ()
#else
				Markup.escape_text ();
#endif
			}
		}
		else if (null != env.get_parent ())
		{
			to_stream (@out, env.get_parent ());
		}
		else if (RenderFlags in flags)
		{
			throw new RenderError.KEY_NOT_FOUND ("key '%s' was not found");
		}
	}
}
