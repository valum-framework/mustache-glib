
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
