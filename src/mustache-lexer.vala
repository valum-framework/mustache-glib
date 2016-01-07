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
	REACHED_EOF
}

public class Mustache.Lexer : DataInputStream
{
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
	public LexerState state { construct; get; default = LexerState.LEXING_TEXT; }

	/**
	 * @param context
	 * @param lexer
	 */
	public Lexer (InputStream base_stream)
	{
		base (base_stream);
	}

	/**
	 * Lex a single token from the stream.
	 *
	 * @param value for value token, this is the lexed string
	 * @return the lexed token, or 'null' on EOF
	 */
	public Token? read_token (out Bytes? @value)
	{
		if (LexerState.REACHED_EOF == state)
			return null;

		if (((string) base_stream.peak_buffer ()).has_prefix (expected_delimiter))
		{
			base_stream.skip (expected_delimiter.length);
			@value = null;
			return LexerState.EXPECTING_OPEN_TOKEN == state ? Token.OPEN : Token.CLOSE;
		}

		if (base_stream.available_bytes () < opening_delimiter.length)
			yield base_stream.fill_async (expected_delimiter.length);

		if (LexerState.LEXING_TEXT == state)
		{
			do
			{
				@value = yield base_stream.read_upto_async (opening_delimiter[i],
				                                            1,
															Priority.DEFAULT,
															null,
															out length);

				if (length > 1024)


				return Token.TEXT;

				yield base_stream.fill_async (sequence.length);
			}
			while (!((string) base_stream.peek_buffer ()).has_prefix (opening_delimiter));
		}
		else switch (base_stream.peek_buffer ()[0])
		{
			case '#':
				return Token.SECTION;
			case '/':
				return Token.CLOSED_SECTION;
			case '?':
				return Token.NON_FALSE;
			case '^':
				return Token.INVERED_SECTION;
			case '!':
				return Token.COMMENT;
			case '>':
				return Token.PARTIAL;
			case '=':
				return Token.SET_DELIMITER;
			default:
				@value = yield base_stream.read_upto_async (closing_delimiter[0:-1], 1);
				return Token.KEY;
		}
	}

	/**
	 * @see read_token
	 */
	public async Token? read_token_async (out Bytes? @value)
	{
		return next_token (out @value);
	}
}
