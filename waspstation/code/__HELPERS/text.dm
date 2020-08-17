//Very shitty proc that allows you to get the (mostly) pure text out of a book. There's probably something that can get this more cleanly or more efficiently, btu I don't care.
/proc/strip_booktext(text, limit=MAX_MESSAGE_LEN)
	var/start = findtext(text, ">")
	var/end = findtext(text, "<", 2)
	return strip_html(copytext_char(text, start, min(start + limit, end)))
