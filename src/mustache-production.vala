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
using Json;

/**
 * Grammar production.
 */
public abstract class Mustache.Production : Object
{
	/**
	 * Context for rendering the production.
	 */
	public Context context { construct; get; }

	/**
	 * Render the node in the stream.
	 *
	 * @param out
	 * @param env
	 * @param flags rendering flags
	 */
	public abstract void to_stream (OutputStream @out,
									Node env) throws RenderError, IOError;

	/**
	 * @see Mustache.Node.to_stream
	 */
	public virtual async void to_stream_async (OutputStream @out,
	                                           Node env,
	                                           int priority = Priority.DEFAULT,
	                                           Cancellable? cancellable = null) throws RenderError, IOError;
	{
		to_stream (@out, env);
	}
}
