
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
