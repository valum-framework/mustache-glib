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

public class Mustache.Section : Mustache.Node
{
	public string key { construct; get; }

	/**
	 * If enabled, the boolean value key by the key will toggle the
	 * rendering of the template.
	 */
	public bool non_false { construct; get; }

	public Template template { construct; get; }

	public Section (Context context, string key, bool non_false, Template template)
	{
		Object (context: context, key: key, non_false: non_false, template: template);
	}

	public void to_stream (OutputStream @out, Json.Node env) throws RenderError, IOError
		requires (NodeType.OBJECT == env.get_node_type ())
	{
		if (env.get_object ().has_member (key))
		{
			var member = env.get_object ().get_member (key);

			if (non_false)
			{
				if (!falsy (member))
					template.render (@out, env);
			}
			else
			{
				switch (member.get_node_type ())
				{
					case NodeType.ARRAY:
						member.get_array ().foreach ((i, node) =>
						{
							template.render (@out, node);
						});
						break;
					case NodeType.VALUE:
						env.
				}
			}
		}
		else if (env.get_parent () != null)
		{
			to_stream (@out, env.get_parent ());
		}
		else if (RenderFlags.CHECK_MISSING_VARIABLES in flags)
		{
			throw new RenderError.VARIABLE_NOT_FOUND ("expected variable '%s' was not found", key);
		}
	}
}
