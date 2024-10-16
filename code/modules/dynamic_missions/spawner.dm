#define SPAWNER_TOOL_TRIGGER "trigger" //Only spawns something when alt clicked or by a registered signal
#define SPAWNER_TOOL_TOGGLE "direct" //Uses /datum/component/spawner

/obj/effect/spawner_tool
	name = "spawner tool"
	desc = "Spawns things, presumably."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	invisibility = INVISIBILITY_OBSERVER
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	alpha = 175
	var/spawn_type = /obj/item/toy/figure/ian
	var/spawner_mode = SPAWNER_TOOL_TRIGGER
	var/limited_use = FALSE
	var/uses

	var/datum/component/spawner/spawner_comp
	var/spawning_state = FALSE

	var/max_mobs = 5
	var/spawn_time = 300 //30 seconds default
	//var/mob_types = list(/mob/living/simple_animal/hostile/carp)
	var/spawn_text = "emerges from"
	var/faction = list("hostile")
	var/spawn_sound = list('sound/effects/break_stone.ogg')
	var/spawner_type = /datum/component/spawner
	var/spawn_distance_min = 1
	var/spawn_distance_max = 1

/obj/effect/spawner_tool/Destroy(force)
	if(!force)
		return QDEL_HINT_LETMELIVE
	. = ..()

/obj/effect/spawner_tool/singularity_act()
	return

/obj/effect/spawner_tool/singularity_pull()
	return

/obj/effect/spawner_tool/examine(mob/user)
	. = ..()
	if(!isobserver(user))
		return
	. += "<span class='boldnotice'>Spawn Type:</span> [spawn_type ? spawn_type : "None chosen"]"
	. += "<span class='boldnotice'>Mode:</span> [spawner_mode]</span>"
	if(limited_use)
		. += "<span class='boldnotice'>Uses left:</span> [uses]</span>"
	if(user.client.holder)
		. += "<b>Ctrl-click it to quickly activate it!</b>"

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/effect/spawner_tool/attack_ghost(mob/user)
	if(!check_rights_for(user.client, R_SPAWN))
		examine(user)
		return
	edit_tool(user)

/obj/effect/spawner_tool/CtrlClick(mob/user)
	if(check_rights_for(user.client, R_SPAWN))
		activate(user)
		to_chat(user, "<span class='notice'>Spawner tool activated.</span>", confidential = TRUE)

/obj/effect/spawner_tool/proc/activate(mob/user)
	if(spawner_mode == SPAWNER_TOOL_TRIGGER)
		if(ispath(spawn_type))
			new spawn_type(loc)
			if(limited_use)
				uses--
				if(uses <= 0)
					qdel(src, TRUE)
	else
		toggle_spawner()

/obj/effect/spawner_tool/proc/toggle_spawner()
	spawning_state = !spawning_state
	if(!spawner_comp)
		spawner_comp = AddComponent(spawner_type, list(spawn_type), spawn_time, faction, spawn_text, max_mobs, spawn_sound, spawn_distance_min, spawn_distance_max)
	spawning_state = SEND_SIGNAL(src, COMSIG_SPAWNER_TOGGLE_SPAWNING, spawning_state)

///Specificly for if you want to register it to things
/obj/effect/spawner_tool/proc/trigger_activate()
	SIGNAL_HANDLER

	activate()

/obj/effect/spawner_tool/proc/edit_tool(mob/user)
	var/dat = ""
	dat += "<b>Label:</b> <a href='?src=[text_ref(src)];edit_label=1'>[maptext ? maptext : "No label set!"]</a><br>"
	dat += "<br>"
	dat += "<b>Spawn path:</b> <a href='?src=[text_ref(src)];edit_spawn_path=1'>[spawn_type ? spawn_type : "No path chosen!"]</a><br>"
	dat += "<br>"
	dat += "<b>Mode:</b> <a href='?src=[text_ref(src)];edit_mode=1'>[spawner_mode]</a><br>"
	dat += "<br>"
	if(spawner_mode == SPAWNER_TOOL_TRIGGER)
		dat += "<a href='?src=[text_ref(src)];trigger=1'>Spawn</a>"
	else
		dat += "<a href='?src=[text_ref(src)];trigger=1'>Toggle</a>"
		dat += "<b>[spawning_state ? "On" : "Off"]</b>"
	var/datum/browser/popup = new(user, "spawner_tool", "", 500, 600)
	popup.set_content(dat)
	popup.open()

/obj/effect/spawner_tool/Topic(href, href_list)
	..()
	if(!ismob(usr) || !usr.client || !check_rights_for(usr.client, R_SPAWN))
		return
	var/mob/user = usr
	if(href_list["edit_label"])
		var/new_label = stripped_input(user, "Choose a new label.", "Spawner Tool")
		if(!new_label)
			return
		maptext = new_label
		to_chat(user, "<span class='notice'>Label set to [maptext].</span>", confidential = TRUE)
	if(href_list["edit_spawn_path"])
		var/new_path = input(user, "Choose a path.", "Spawner Tool") as null|text
		new_path = pick_closest_path(new_path)
		if(!new_path)
			return
		spawn_type = new_path
		to_chat(user, "<span class='notice'>New path set to [spawn_type].</span>", confidential = TRUE)
	if(href_list["edit_mode"])
		var/new_mode
		var/mode_list = list("Only spawns something when alt clicked or by a registered signal" = SPAWNER_TOOL_TRIGGER, "Uses /datum/component/spawner" = SPAWNER_TOOL_TOGGLE)
		new_mode = input(user, "Choose a new mode.", "Spawner Tool") as null|anything in mode_list
		if(!new_mode)
			return
		spawner_mode = mode_list[new_mode]
		to_chat(user, "<span class='notice'>Mode set to [spawner_mode].</span>", confidential = TRUE)
	if(href_list["trigger"])
		activate(user)
	edit_tool(user) //Refresh the UI to see our changes

/*
/obj/effect/spawner_tool/proc/edit_emitter(mob/user)
	var/dat = ""
	dat += "<b>Label:</b> <a href='?src=[text_ref(src)];edit_label=1'>[maptext ? maptext : "No label set!"]</a><br>"
	dat += "<br>"
	dat += "<b>Sound File:</b> <a href='?src=[text_ref(src)];edit_sound_file=1'>[sound_file ? sound_file : "No file chosen!"]</a><br>"
	dat += "<b>Volume:</b> <a href='?src=[text_ref(src)];edit_volume=1'>[sound_volume]%</a><br>"
	dat += "<br>"
	dat += "<b>Mode:</b> <a href='?src=[text_ref(src)];edit_mode=1'>[spawner_mode]</a><br>"
	if(spawner_mode != SOUND_EMITTER_LOCAL)
		dat += "<b>Range:</b> <a href='?src=[text_ref(src)];edit_range=1'>[emitter_range]</a>[emitter_range == SOUND_EMITTER_RADIUS ? "<a href='?src=[text_ref(src)];edit_radius=1'>[play_radius]-tile radius</a>" : ""]<br>"
	dat += "<br>"
	dat += "<a href='?src=[text_ref(src)];play=1'>Play Sound</a> (interrupts other spawner tool sounds)"
	var/datum/browser/popup = new(user, "emitter", "", 500, 600)
	popup.set_content(dat)
	popup.open()

/obj/effect/spawner_tool/Topic(href, href_list)
	..()
	if(!ismob(usr) || !usr.client || !check_rights_for(usr.client, R_SOUND))
		return
	var/mob/user = usr
	if(href_list["edit_label"])
		var/new_label = stripped_input(user, "Choose a new label.", "Spawner Tool")
		if(!new_label)
			return
		maptext = new_label
		to_chat(user, "<span class='notice'>Label set to [maptext].</span>", confidential = TRUE)
	if(href_list["edit_sound_file"])
		var/new_file = input(user, "Choose a sound file.", "Spawner Tool") as null|sound
		if(!new_file)
			return
		sound_file = new_file
		to_chat(user, "<span class='notice'>New sound file set to [sound_file].</span>", confidential = TRUE)
	if(href_list["edit_volume"])
		var/new_volume = input(user, "Choose a volume.", "Spawner Tool", sound_volume) as null|num
		if(isnull(new_volume))
			return
		new_volume = clamp(new_volume, 0, 100)
		sound_volume = new_volume
		to_chat(user, "<span class='notice'>Volume set to [sound_volume]%.</span>", confidential = TRUE)
	if(href_list["edit_mode"])
		var/new_mode
		var/mode_list = list("Local (normal sound)" = SOUND_EMITTER_LOCAL, "Direct (not affected by environment/location)" = SOUND_EMITTER_DIRECT)
		new_mode = input(user, "Choose a new mode.", "Spawner Tool") as null|anything in mode_list
		if(!new_mode)
			return
		spawner_mode = mode_list[new_mode]
		to_chat(user, "<span class='notice'>Mode set to [spawner_mode].</span>", confidential = TRUE)
	if(href_list["edit_range"])
		var/new_range
		var/range_list = list("Radius (all mobs within a radius)" = SOUND_EMITTER_RADIUS, "Z-Level (all mobs on the same z)" = SOUND_EMITTER_ZLEVEL, "Global (all players)" = SOUND_EMITTER_GLOBAL)
		new_range = input(user, "Choose a new range.", "Spawner Tool") as null|anything in range_list
		if(!new_range)
			return
		emitter_range = range_list[new_range]
		to_chat(user, "<span class='notice'>Range set to [emitter_range].</span>", confidential = TRUE)
	if(href_list["edit_radius"])
		var/new_radius = input(user, "Choose a radius.", "Spawner Tool", sound_volume) as null|num
		if(isnull(new_radius))
			return
		new_radius = clamp(new_radius, 0, 127)
		play_radius = new_radius
		to_chat(user, "<span class='notice'>Audible radius set to [play_radius].</span>", confidential = TRUE)
	if(href_list["play"])
		activate(user)
	edit_emitter(user) //Refresh the UI to see our changes

/obj/effect/spawner_tool/proc/activate(mob/user)
	var/list/hearing_mobs = list()
	if(spawner_mode == SOUND_EMITTER_LOCAL)
		playsound(src, sound_file, sound_volume, FALSE)
		return
	switch(emitter_range)
		if(SOUND_EMITTER_RADIUS)
			for(var/mob/M in GLOB.player_list)
				if(get_dist(src, M) <= play_radius)
					hearing_mobs += M
		if(SOUND_EMITTER_ZLEVEL)
			for(var/mob/M in GLOB.player_list)
				if(M.virtual_z() == virtual_z())
					hearing_mobs += M
		if(SOUND_EMITTER_GLOBAL)
			hearing_mobs = GLOB.player_list.Copy()
	for(var/mob/M in hearing_mobs)
		if(M.client.prefs.toggles & SOUND_MIDI)
			M.playsound_local(M, sound_file, sound_volume, FALSE, channel = CHANNEL_ADMIN, pressure_affected = FALSE)
	if(user)
		log_admin("[ADMIN_LOOKUPFLW(user)] activated a spawner tool with file \"[sound_file]\" at [AREACOORD(src)]")
	flick("shield1", src)
*/
