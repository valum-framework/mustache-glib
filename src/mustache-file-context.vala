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
 * Mustache context based on {@link GLib.File} to resolve partials.
 */
public Mustache.FileContext : Mustache.Context
{
	/**
	 * Path from which templates are resolved.
	 */
	public File root { construct; get; }

	/**
	 *
	 */
	public string extension { get; set; default = ".mustache"; }

	public InputStream read_partial (string name) throws Error
	{
		return root.resolve_relative_path (name + extension).read ();
	}

	public InputStream read_partial_async (string name) throws Error
	{
		return yield root.resolve_relative_path (name + extension).read_async ();
	}
}
