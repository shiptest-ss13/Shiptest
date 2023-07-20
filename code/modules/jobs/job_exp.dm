GLOBAL_LIST_EMPTY(exp_to_update)
GLOBAL_PROTECT(exp_to_update)

/datum/map_template/shuttle/proc/has_ship_spawn_playtime(client/Client)
	if(!Client) // lol. client deletion
		return FALSE
	// checks config values, DB status, and client-specific exemptions.
	if(Client.is_playtime_restriction_eligible())
		var/player_living_time = Client.get_exp_living(TRUE) // returns value in minutes
		var/req_spawn_time = get_req_spawn_minutes()
		if(player_living_time < req_spawn_time)
			return FALSE
	return TRUE

/datum/map_template/shuttle/proc/has_job_playtime(client/Client, datum/job/Job)
	if(!Client) // lol. client deletion
		return FALSE
	// job must be an officer to enforce playtime requirements, AND we need to check
	// config values, DB status, and client-specific exceptions.
	if(Job.officer && Client.is_playtime_restriction_eligible())
		var/player_living_time = Client.get_exp_living(TRUE) // returns value in minutes
		var/req_join_time = get_req_officer_minutes()
		if(player_living_time < req_join_time)
			return FALSE
	return TRUE

/datum/map_template/shuttle/proc/get_req_spawn_minutes()
	if(!CONFIG_GET(flag/use_exp_tracking) || !SSdbcore.Connect())
		return 0
	return spawn_time_coeff * CONFIG_GET(number/ship_spawn_base_exp_min)

/datum/map_template/shuttle/proc/get_req_officer_minutes()
	if(!CONFIG_GET(flag/use_exp_tracking) || !SSdbcore.Connect())
		return 0
	return officer_time_coeff * CONFIG_GET(number/officer_join_base_exp_min)

/client/proc/is_playtime_restriction_eligible()
	if(!CONFIG_GET(flag/use_exp_tracking))
		return FALSE // playtime tracking must be enabled
	if(!SSdbcore.Connect())
		return FALSE // must have an active DB

	// not actually entirely sure what this is. believe it's a flag for exemption from exp restrictions? sure, whatever
	if(prefs.db_flags & DB_FLAG_EXEMPT)
		return FALSE
	if(CONFIG_GET(flag/use_exp_restrictions_admin_bypass) && check_rights_for(src, R_ADMIN))
		return FALSE // if admin exemption is enabled, and client is an admin, let them through

/client/proc/get_exp_living(pure_numeric = FALSE)
	if(!prefs.exp)
		return pure_numeric ? 0 : "No data"
	var/exp_living = text2num(prefs.exp[EXP_TYPE_LIVING])
	return pure_numeric ? exp_living : get_exp_format(exp_living)

/proc/get_exp_format(expnum)
	if(expnum > 60)
		return num2text(round(expnum / 60)) + "h"
	else if(expnum > 0)
		return num2text(expnum) + "m"
	else
		return "0h"

/datum/controller/subsystem/blackbox/proc/update_exp(mins, ann = FALSE)
	if(!SSdbcore.Connect())
		return -1
	for(var/client/L in GLOB.clients)
		if(L.is_afk())
			continue
		L.update_exp_list(mins,ann)

/datum/controller/subsystem/blackbox/proc/update_exp_db()
	set waitfor = FALSE
	var/list/old_minutes = GLOB.exp_to_update
	GLOB.exp_to_update = null
	SSdbcore.MassInsert(format_table_name("role_time"), old_minutes, duplicate_key = "ON DUPLICATE KEY UPDATE minutes = minutes + VALUES(minutes)")

//resets a client's exp to what was in the db.
/client/proc/set_exp_from_db()
	if(!CONFIG_GET(flag/use_exp_tracking))
		return -1
	if(!SSdbcore.Connect())
		return -1
	var/datum/DBQuery/exp_read = SSdbcore.NewQuery(
		"SELECT job, minutes FROM [format_table_name("role_time")] WHERE ckey = :ckey",
		list("ckey" = ckey)
	)
	if(!exp_read.Execute(async = TRUE))
		qdel(exp_read)
		return -1
	var/list/play_records = list()
	while(exp_read.NextRow())
		play_records[exp_read.item[1]] = text2num(exp_read.item[2])
	qdel(exp_read)

	for(var/rtype in SSjob.name_occupations)
		if(!play_records[rtype])
			play_records[rtype] = 0
	for(var/rtype in GLOB.exp_specialmap)
		if(!play_records[rtype])
			play_records[rtype] = 0

	prefs.exp = play_records

//updates player db flags
/client/proc/update_flag_db(newflag, state = FALSE)

	if(!SSdbcore.Connect())
		return -1

	if(!set_db_player_flags())
		return -1

	if((prefs.db_flags & newflag) && !state)
		prefs.db_flags &= ~newflag
	else
		prefs.db_flags |= newflag

	var/datum/DBQuery/flag_update = SSdbcore.NewQuery(
		"UPDATE [format_table_name("player")] SET flags=:flags WHERE ckey=:ckey",
		list("flags" = "[prefs.db_flags]", "ckey" = ckey)
	)

	if(!flag_update.Execute())
		qdel(flag_update)
		return -1
	qdel(flag_update)


/client/proc/update_exp_list(minutes, announce_changes = FALSE)
	if(!CONFIG_GET(flag/use_exp_tracking))
		return -1
	if(!SSdbcore.Connect())
		return -1
	if (!isnum(minutes))
		return -1
	var/list/play_records = list()

	if(isliving(mob))
		if(mob.stat != DEAD)
			var/rolefound = FALSE
			play_records[EXP_TYPE_LIVING] += minutes

			if(announce_changes)
				to_chat(src,"<span class='notice'>You got: [minutes] Living EXP!</span>")
			if(mob.mind.assigned_role)
				for(var/job in SSjob.name_occupations)
					if(mob.mind.assigned_role == job)
						rolefound = TRUE
						play_records[job] += minutes
						if(announce_changes)
							to_chat(src,"<span class='notice'>You got: [minutes] [job] EXP!</span>")
				if(!rolefound)
					for(var/role in GLOB.exp_specialmap[EXP_TYPE_SPECIAL])
						if(mob.mind.assigned_role == role)
							rolefound = TRUE
							play_records[role] += minutes
							if(announce_changes)
								to_chat(mob,"<span class='notice'>You got: [minutes] [role] EXP!</span>")
				if(mob.mind.special_role && !(mob.mind.datum_flags & DF_VAR_EDITED))
					var/trackedrole = mob.mind.special_role
					play_records[trackedrole] += minutes
					if(announce_changes)
						to_chat(src,"<span class='notice'>You got: [minutes] [trackedrole] EXP!</span>")
			if(!rolefound)
				play_records["Unknown"] += minutes
		else
			if(holder && !holder.deadmined)
				play_records[EXP_TYPE_ADMIN] += minutes
				if(announce_changes)
					to_chat(src,"<span class='notice'>You got: [minutes] Admin EXP!</span>")
			else
				play_records[EXP_TYPE_GHOST] += minutes
				if(announce_changes)
					to_chat(src,"<span class='notice'>You got: [minutes] Ghost EXP!</span>")
	else if(isobserver(mob))
		play_records[EXP_TYPE_GHOST] += minutes
		if(announce_changes)
			to_chat(src,"<span class='notice'>You got: [minutes] Ghost EXP!</span>")
	else if(minutes)	//Let "refresh" checks go through
		return

	for(var/jtype in play_records)
		var/jvalue = play_records[jtype]
		if (!jvalue)
			continue
		if (!isnum(jvalue))
			CRASH("invalid job value [jtype]:[jvalue]")
		LAZYINITLIST(GLOB.exp_to_update)
		GLOB.exp_to_update.Add(list(list(
			"job" = jtype,
			"ckey" = ckey,
			"minutes" = jvalue)))
		prefs.exp[jtype] += jvalue
	addtimer(CALLBACK(SSblackbox,/datum/controller/subsystem/blackbox/proc/update_exp_db),20,TIMER_OVERRIDE|TIMER_UNIQUE)


//ALWAYS call this at beginning to any proc touching player flags, or your database admin will probably be mad
/client/proc/set_db_player_flags()
	if(!SSdbcore.Connect())
		return FALSE

	var/datum/DBQuery/flags_read = SSdbcore.NewQuery(
		"SELECT flags FROM [format_table_name("player")] WHERE ckey=:ckey",
		list("ckey" = ckey)
	)

	if(!flags_read.Execute(async = TRUE))
		qdel(flags_read)
		return FALSE

	if(flags_read.NextRow())
		prefs.db_flags = text2num(flags_read.item[1])
	else if(isnull(prefs.db_flags))
		prefs.db_flags = 0	//This PROBABLY won't happen, but better safe than sorry.
	qdel(flags_read)
	return TRUE
