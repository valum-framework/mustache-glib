/**
 *
 */
public enum Mustache.Token
{
	OPEN,             // '{{', but can be redefined
	CLOSE,            // '}}', but can be redefined
	OPEN_UNESCAPED,   // '{'
	CLOSE_UNESCAPED,  // '}'
	UNESCAPED,        // '&'
	SECTION,          // '#'
	NON_FALSE,        // '?'
	INVERTED_SECTION, // '^'
	CLOSE_SECTION,    // '/'
	PARTIAL,          // '>'
	COMMENT,          // '!'
	SET_DELIMITER,    // '='
	KEY,
	DELIMITER,
	TEXT
}
