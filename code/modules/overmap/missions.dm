/datum/mission
	var/name = "mission"
	var/desc
	var/value = 1000

	var/accepted = FALSE

	var/datum/overmap/outpost/source_outpost

	var/datum/overmap/ship/controlled/servant
	var/accept_time
	var/duration = 30 MINUTES

/datum/mission/New(_outpost)
	source_outpost = _outpost
	RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, .proc/on_vital_delete)
	. = ..()

/datum/mission/proc/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	accepted = TRUE
	accept_time = world.time
	servant = acceptor
	LAZYREMOVE(source_outpost.missions, src)
	LAZYADD(servant.missions, src)
	RegisterSignal(servant, COMSIG_PARENT_QDELETING, .proc/on_vital_delete)
	return

/datum/mission/proc/on_vital_delete()
	qdel(src)

/datum/mission/Destroy()
	. = ..()
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		LAZYREMOVE(servant.missions, src)
		servant = null

/datum/mission/proc/turn_in()
	servant.ship_account.adjust_money(value)
	qdel(src)
	return

/datum/mission/proc/give_up()
	qdel(src)
	return

/datum/mission/proc/is_failed()
	return accepted && (world.time >= accept_time + duration)

/datum/mission/proc/is_complete()
	return !is_failed()

/datum/mission/proc/get_tgui_info()
	var/time_remaining = duration
	if(accepted)
		time_remaining += accept_time - world.time

	var/act_str = "Give up"
	if(!accepted)
		act_str = "Accept"
	else if(is_complete())
		act_str = "Turn in"

	return list(
		"ref" = REF(src),
		"name" = src.name,
		"desc" = src.desc,
		"value" = src.value,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str
	)

/datum/mission/proc/get_progress_string()
	return "null"
