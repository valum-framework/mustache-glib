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

/**
 *
 */
public class Mustache.Comment : Mustache.Tag
{
	/**
	 *
	 */
	public string comment { construct; get; }

	public Comment (Context context, string comment)
	{
		Object (context: context, comment: comment);
	}

	public void to_stream (OutputStream @out, Json.Node env, RenderFlags flags)
	{
		// skip!
	}
}
