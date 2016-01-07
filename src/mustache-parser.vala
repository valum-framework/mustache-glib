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
 * Lexer state.
 */
public enum Mustache.LexerState
{
	LEXING_TEXT,
	LEXING_TAG,
	EOF
}

/**
 * Recursive-descent parser for the Mustache language.
 */
public class Mustache.Parser : DataInputStream
{
	/**
	 * Parsing and rendering context.
	 */
	public Context context { construct; get; }

	/**
	 * Delimiter for an opening tag.
	 */
	public string opening_delimiter { get; set; default = "{{"; }

	/**
	 * Delimiter for a closing tag.
	 */
	public string closing_delimiter { get; set; default = "}}"; }

	/**
	 * Lexer state
	 *
	 * The lexer is initially expecting an opening token '{{', which means that
	 * it can lex either {@link Token.TEXT} or a {@link Token.OPEN} token.
	 */
	public LexerState state { construct; get; default = LexerState.EXPECTING_OPEN_TOKEN; }

	/**
	 * @param context
	 * @param lexer
	 */
	public Parser (Context context, Lexer lexer)
	{
		Object (context: context, lexer: lexer);
	}

	// LL(1) grammar need a single readahead
	private Token? next = null;
	private Bytes? next_value = null;

	/**
	 * @param token expected token
	 * @param token_value
	 */
	public bool accept (Token token, out Bytes? token_value) throws ParseError {
		if (next == null)
			next = read_token (out next_value);

		if (next == null)
			return false; // EOF

		return token == next;
	}

	/**
	 * @param token       expected token
	 * @param token_value token value, if appliable
	 */
	public void expect (Token token, out Bytes? token_value) throws ParseError {
		if (!accept (token, out token_value))
			throw ParseError.UNEXPECTED_TOKEN ("unexpected token '%s', '%s' was found instead",
			                                   token.to_string (),
			                                   next.to_string ());

		// consume the token
		next       = null;
		next_value = null;
	}

	/**
	 * Parse a {@link Mustache.Template}.
	 */
	public Template template () throws ParserError
	{
		var blocks = new SList<Block> ();

		while (true)
		{
			if (accept (Token.OPEN))
			{
				expect (Token.OPEN);
				blocks.prepend (tag ());
				expect (Token.CLOSE);
			}
			else
			{
				blocks.prepend (text ());
			}
		}

		blocks.reverse ();

		return new Template (blocks);
	}

	public Tag tag ()
	{
		Tag tag;

		expect (Token.OPEN);

		if (accept (Token.KEY) || accept (Token.OPEN_UNESCAPED) || accept (Token.UNESCAPED))
			tag = variable ();

		else if (accept (Token.SECTION))
			tag = section ();

		else if (accept (Token.INVERTED_SECTION))
			tag = section ();

		else if (accept (Token.COMMENT))
			tag = partial ();

		else if (accept (Token.PARTIAL))
			tag = partial ();

		else
			tag = set_delimiter ();

		expect (Token.CLOSE);

		return tag;
	}

	public Variable variable ()
	{
		if (accept (Token.KEY))
		{
			return new Variable (expect (Token.KEY))
		}
		expect (Token.VARIABLE):w
		return new Variable (expect (Token.KEY));
	}

}
