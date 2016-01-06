
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
