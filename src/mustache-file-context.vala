
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
