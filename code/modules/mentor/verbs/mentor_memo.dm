/client/proc/mentor_memo()
	set name = "Mentor Memos"
	set category = "Server"
	if(!check_rights(0))
		return
	if(!SSdbcore.IsConnected())
		to_chat(src, "<span class='danger'>Failed to establish database connection.</span>")
		return
	var/memotask = input(usr,"Choose task.","Memo") in list("Show","Write","Edit","Remove")
	if(!memotask)
		return
	mentor_memo_output(memotask)

/client/proc/show_mentor_memo()
	set name = "Show Memos"
	set category = "Mentor"
	if(!check_mentor())
		return
	if(!SSdbcore.IsConnected())
		to_chat(src, "<span class='danger'>Failed to establish database connection.</span>")
		return
	mentor_memo_output("Show")

/client/proc/mentor_memo_output(task)
	if(!task)
		return
	if(!SSdbcore.IsConnected())
		to_chat(src, "<span class='danger'>Failed to establish database connection.</span>")
		return
	switch(task)
		if("Write")
			var/datum/DBQuery/query_memocheck = SSdbcore.NewQuery(
				"SELECT ckey FROM [format_table_name("mentor_memo")] WHERE ckey = :ckey",
				list("ckey" = src.ckey))
			if(!query_memocheck.Execute())
				var/err = query_memocheck.ErrorMsg()
				log_game("SQL ERROR obtaining ckey from memo table. Error : \[[err]\]\n")
				return
			if(query_memocheck.NextRow())
				to_chat(src, "You already have set a memo.")
				return
			var/memotext = input(src,"Write your Memo","Memo") as message
			if(!memotext)
				return
			var/datum/DBQuery/query_memoadd = SSdbcore.NewQuery(
				"INSERT INTO [format_table_name("mentor_memo")] (ckey, memotext, timestamp) VALUES (:ckey, :memotext, :timestamp)",
				list("ckey" = src.ckey, "memotext" = memotext, "timestamp" = SQLtime()))
			if(!query_memoadd.Execute())
				var/err = query_memoadd.ErrorMsg()
				log_game("SQL ERROR adding new memo. Error : \[[err]\]\n")
				return
			log_admin("[key_name(src)] has set a mentor memo: [memotext]")
			message_admins("[key_name_admin(src)] has set a mentor memo:<br>[memotext]")
			qdel(query_memocheck)
			qdel(query_memoadd)
		if("Edit")
			var/datum/DBQuery/query_memolist = SSdbcore.NewQuery("SELECT ckey FROM [format_table_name("mentor_memo")]")
			if(!query_memolist.Execute())
				var/err = query_memolist.ErrorMsg()
				log_game("SQL ERROR obtaining ckey from memo table. Error : \[[err]\]\n")
				return
			var/list/memolist = list()
			while(query_memolist.NextRow())
				var/lkey = query_memolist.item[1]
				memolist += "[lkey]"
			if(!memolist.len)
				to_chat(src, "No memos found in database.")
				return
			var/target_ckey = input(src, "Select whose memo to edit", "Select memo") as null|anything in memolist
			if(!target_ckey)
				return
			var/datum/DBQuery/query_memofind = SSdbcore.NewQuery(
				"SELECT memotext FROM [format_table_name("mentor_memo")] WHERE ckey = :target_ckey",
				list("target_ckey" = target_ckey))
			if(!query_memofind.Execute())
				var/err = query_memofind.ErrorMsg()
				log_game("SQL ERROR obtaining memotext from memo table. Error : \[[err]\]\n")
				return
			if(query_memofind.NextRow())
				var/old_memo = query_memofind.item[1]
				var/new_memo = input("Input new memo", "New Memo", "[old_memo]", null) as message
				if(!new_memo)
					return
				var/edit_text = "Edited by [src.ckey] on [SQLtime()] from<br>[old_memo]<br>to<br>[new_memo]<hr>"
				var/datum/DBQuery/update_query = SSdbcore.NewQuery(
					"UPDATE [format_table_name("mentor_memo")] SET memotext = :new_memo, last_editor = :ckey, edits = CONCAT(IFNULL(edits,''),:edit_text) WHERE ckey = :target_ckey",
					list("ckey" = src.ckey, "target_ckey" = target_ckey, "new_memo" = new_memo, "edit_text" = edit_text))
				if(!update_query.Execute())
					var/err = update_query.ErrorMsg()
					log_game("SQL ERROR editing memo. Error : \[[err]\]\n")
					return
				log_admin("[key_name(src)] has edited [target_ckey == src.ckey ? "their" : "[target_ckey]'s'"] mentor memo from [old_memo] to [new_memo]")
				message_admins("[key_name_admin(src)] has edited [target_ckey == src.ckey ? "their" : "[target_ckey]'s'"] mentor memo from<br>[old_memo]<br>to<br>[new_memo]")
				qdel(update_query)
			qdel(query_memolist)
			qdel(query_memofind)
		if("Show")
			var/datum/DBQuery/query_memoshow = SSdbcore.NewQuery("SELECT ckey, memotext, timestamp, last_editor FROM [format_table_name("mentor_memo")]")
			if(!query_memoshow.Execute())
				var/err = query_memoshow.ErrorMsg()
				log_game("SQL ERROR obtaining ckey, memotext, timestamp, last_editor from memo table. Error : \[[err]\]\n")
				return
			var/output = null
			while(query_memoshow.NextRow())
				var/ckey = query_memoshow.item[1]
				var/memotext = query_memoshow.item[2]
				var/timestamp = query_memoshow.item[3]
				var/last_editor = query_memoshow.item[4]
				output += "<span class='memo'>Mentor memo by <span class='prefix'>[ckey]</span> on [timestamp]"
				if(last_editor)
					output += "<br><span class='memoedit'>Last edit by [last_editor] <A href='?_src_=holder;mentormemoeditlist=[ckey]'>(Click here to see edit log)</A></span>"
				output += "<br>[memotext]</span><br>"
			if(!output)
				to_chat(src, "No memos found in database.")
				return
			to_chat(src, output)
			qdel(query_memoshow)
		if("Remove")
			var/datum/DBQuery/query_memodellist = SSdbcore.NewQuery("SELECT ckey FROM [format_table_name("mentor_memo")]")
			if(!query_memodellist.Execute())
				var/err = query_memodellist.ErrorMsg()
				log_game("SQL ERROR obtaining ckey from memo table. Error : \[[err]\]\n")
				return
			var/list/memolist = list()
			while(query_memodellist.NextRow())
				var/ckey = query_memodellist.item[1]
				memolist += "[ckey]"
			if(!memolist.len)
				to_chat(src, "No memos found in database.")
				return
			var/target_ckey = input(src, "Select whose mentor memo to delete", "Select mentor memo") as null|anything in memolist
			if(!target_ckey)
				return
			var/datum/DBQuery/query_memodel = SSdbcore.NewQuery(
				"DELETE FROM [format_table_name("memo")] WHERE ckey = ':target_ckey'",
				list("target_ckey" = target_ckey))
			if(!query_memodel.Execute())
				var/err = query_memodel.ErrorMsg()
				log_game("SQL ERROR removing memo. Error : \[[err]\]\n")
				return
			log_admin("[key_name(src)] has removed [target_ckey == src.ckey ? "their" : "[target_ckey]'s'"] mentor memo.")
			message_admins("[key_name_admin(src)] has removed [target_ckey == src.ckey ? "their" : "[target_ckey]'s'"]'s mentor memo.")
			qdel(query_memodellist)
			qdel(query_memodel)
