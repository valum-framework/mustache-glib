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
