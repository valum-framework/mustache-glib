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
public abstract class Mustache.Context : Object
{
	/**
	 * Ignore missing variables by rendering nothing instead of raising a
	 * {@link Mustache.RenderError.KEY_NOT_FOUND}
	 */
	public bool ignore_missing_keys { get; set; default = true; }

	/**
	 * Resolve and read a partial.
	 *
	 * @return a stream on the Mustache template
	 */
	public abstract InputStream read_partial (string name) throws Error;

	/**
	 * @see Mustache.Context.read_partial
	 */
	public virtual async InputStream read_partial_async (string name) throws Error {
		return read_partial (name);
	}
}
