/datum/mission
	var/desc
	var/value = 500

	var/datum/overmap/outpost/source_outpost

	var/datum/overmap/ship/controlled/servant
	var/accept_time
	var/duration = 30 MINUTES

/datum/mission/New(_outpost)
	source_outpost = _outpost
	. = ..()

/datum/mission/Destroy()
	. = ..()
	detach()
	source_outpost = null

/datum/mission/proc/accepted(datum/overmap/ship/controlled/_servant)
	servant = _servant
	accept_time = world.time
	return

/datum/mission/proc/turn_in()
	servant.ship_account.adjust_money(value)
	qdel(src)
	return

/datum/mission/proc/give_up()
	qdel(src)
	return

/datum/mission/proc/detach()
	servant = null
	return

/datum/mission/proc/is_failed()
	return accept_time && (world.time >= accept_time + duration)

/datum/mission/proc/is_complete()
	return !is_failed()

/datum/mission/proc/get_tgui_info()
	var/time_remaining = duration
	if(accept_time)
		time_remaining += accept_time - world.time

	var/act_str = "Give up"
	if(!servant && !accept_time)
		act_str = "Accept"
	else if(is_complete())
		act_str = "Turn in"

	return list(
		"ref" = REF(src),
		"name" = "mission",
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





/datum/mission/research
	desc = "Fly through some shit on the overmap to get me data."

	var/allow_subtypes = TRUE
	var/num_current = 0
	var/num_wanted = 10
	var/objective_type

	var/static/list/objective_types = list(
		/datum/overmap/event/meteor,
		/datum/overmap/event/emp,
		/datum/overmap/event/electric
	)

/datum/mission/research/New()
	objective_type = pick(objective_types)

/datum/mission/research/accepted(datum/overmap/ship/controlled/acceptor)
	. = ..()
	RegisterSignal(servant, COMSIG_OVERMAP_MOVED, .proc/ship_moved)
	return

/datum/mission/research/detach()
	if(servant)
		UnregisterSignal(servant, COMSIG_OVERMAP_MOVED)
	return ..()

/datum/mission/research/get_progress_string()
	return "[num_current]/[num_wanted]"

/datum/mission/research/is_complete()
	return (num_current >= num_wanted) && ..()

/datum/mission/research/proc/ship_moved(datum/overmap/ship/controlled/S, x, y)
	SIGNAL_HANDLER
	if(is_failed() || is_complete() || S != servant)
		return
	var/list/datum/overmap/obj_in_square = SSovermap.overmap_container[x][y]
	var/datum/overmap/O
	if(allow_subtypes)
		O =
	else





	if((allow_subtypes ? istype(E, objective_type) : E.type == objective_type))
		num_current++
	return






/datum/mission/acquire
	desc = "Get me some things."

	var/allow_subtypes = FALSE
	var/objective_type = /obj/item/stack/sheet/animalhide/goliath_hide
	var/num = 10




