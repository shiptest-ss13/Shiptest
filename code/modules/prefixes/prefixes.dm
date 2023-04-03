/client/proc/get_prefix()
	var/datum/DBQuery/query_get_prefix = SSdbcore.NewQuery(
		"SELECT rprefix FROM [format_table_name("player")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	var/rprefix = ""
	if(query_get_prefix.warn_execute())
		if(query_get_prefix.NextRow())
			rprefix = query_get_prefix.item[1]

	qdel(query_get_prefix)
	return rprefix

/client/proc/change_prefix(ckey, prefix)
	prefix=input(src,"Prefix:", "Write new prefix") as text|null
	var/datum/DBQuery/query_change_prefix = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET rprefix = :prefix WHERE ckey = :ckey",
		list("prefix" = prefix, "ckey" = ckey)
	)
	query_change_prefix.warn_execute()
	qdel(query_change_prefix)
