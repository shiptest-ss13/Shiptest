/datum/wires/recorder
	wires = list(WIRE_ACTIVATE, WIRE_DISABLE, WIRE_RX)
	holder_type = /obj/item/taperecorder

/datum/wires/recorder/on_pulse(wire)
	var/obj/item/taperecorder/recorder = holder
	switch(wire)
		if(WIRE_ACTIVATE)
			recorder.record()
		if(WIRE_DISABLE)
			recorder.stop()
		if(WIRE_RX)
			recorder.play()

/obj/item/taperecorder
	name = "universal recorder"
	desc = "A device that can record to cassette tapes, and play them. It automatically translates the content in playback."
	icon = 'icons/obj/device.dmi'
	icon_state = "taperecorder_empty"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	drop_sound = 'sound/items/handling/device_drop.ogg'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=60, /datum/material/glass=30)
	force = 2
	throwforce = 0
	var/recording = 0
	var/playing = 0
	var/playsleepseconds = 0
	var/obj/item/tape/mytape
	var/starting_tape_type = /obj/item/tape/random
	var/open_panel = 0
	var/canprint = 1
	var/list/icons_available = list()
	var/icon_directory = 'icons/effects/icons.dmi'

/obj/item/taperecorder/Initialize(mapload)
	. = ..()
	wires = new /datum/wires/recorder(src)
	if(starting_tape_type)
		mytape = new starting_tape_type(src)
	update_appearance()
	become_hearing_sensitive(ROUNDSTART_TRAIT)

/obj/item/taperecorder/Destroy()
	QDEL_NULL(wires)
	QDEL_NULL(mytape)
	return ..()

/obj/item/taperecorder/examine(mob/user)
	. = ..()
	. += "The wire panel is [open_panel ? "opened" : "closed"]."


/obj/item/taperecorder/attackby(obj/item/item, mob/user, params)
	if(!mytape && istype(item, /obj/item/tape))
		if(!user.transferItemToLoc(item,src))
			return
		mytape = item
		to_chat(user, span_notice("You insert [item] into [src]."))
		playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
		update_appearance()
	if(open_panel)
		if(is_wire_tool(item))
			wires.interact(user)

/obj/item/taperecorder/screwdriver_act(mob/living/user, obj/item/screwdriver)
	to_chat(usr, span_notice("You [open_panel ? "close" : "open"] [src]s panel."))
	open_panel = !open_panel

/obj/item/taperecorder/proc/eject(mob/user)
	if(mytape)
		to_chat(user, span_notice("You remove [mytape] from [src]."))
		playsound(src, 'sound/items/taperecorder/taperecorder_open.ogg', 50, FALSE)
		stop()
		user.put_in_hands(mytape)
		mytape = null
		update_appearance()

/obj/item/taperecorder/fire_act(exposed_temperature, exposed_volume)
	mytape.ruin() //Fires destroy the tape
	..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/taperecorder/attack_hand(mob/user)
	if(loc != user || !mytape || !user.is_holding(src))
		return ..()
	eject(user)

/obj/item/taperecorder/proc/can_use(mob/user)
	if(user && ismob(user))
		if(!user.incapacitated())
			return TRUE
	return FALSE


/obj/item/taperecorder/verb/ejectverb()
	set name = "Eject Tape"
	set category = "Object"

	if(!can_use(usr))
		return
	if(!mytape)
		return

	eject(usr)


/obj/item/taperecorder/update_icon_state()
	if(!mytape)
		icon_state = "taperecorder_empty"
		return ..()
	if(recording)
		icon_state = "taperecorder_recording"
		return ..()
	if(playing)
		icon_state = "taperecorder_playing"
		return ..()
	icon_state = "taperecorder_idle"
	return ..()


/obj/item/taperecorder/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, spans, list/message_mods = list())
	. = ..()
	if(mytape && recording)
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] [message]"

/obj/item/taperecorder/verb/record()
	set name = "Start Recording"
	set category = "Object"

	if(!can_use(usr))
		return
	if(!mytape || mytape.ruined)
		return
	if(recording)
		return
	if(playing)
		return

	if(mytape.used_capacity < mytape.max_capacity)
		to_chat(usr, span_notice("Recording started."))
		recording = 1
		update_appearance()
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] Recording started."
		var/used = mytape.used_capacity	//to stop runtimes when you eject the tape
		var/max = mytape.max_capacity
		while(recording && used < max)
			mytape.used_capacity++
			used++
			sleep(10)
		recording = 0
		update_appearance()
	else
		to_chat(usr, span_notice("[src] is full."))


/obj/item/taperecorder/verb/stop()
	set name = "Stop"
	set category = "Object"

	if(!can_use(usr))
		return

	if(recording)
		recording = 0
		mytape.timestamp += mytape.used_capacity
		mytape.storedinfo += "\[[time2text(mytape.used_capacity * 10,"mm:ss")]\] Recording stopped."
		playsound(src, 'sound/items/taperecorder/taperecorder_stop.ogg', 50, FALSE)
		to_chat(usr, "<span class='notice'>Recording stopped.</span>")
		return
	else if(playing)
		playing = 0
		var/turf/T = get_turf(src)
		playsound(src, 'sound/items/taperecorder/taperecorder_stop.ogg', 50, FALSE)
		T.visible_message("<font color=Maroon><B>Tape Recorder</B>: Playback stopped.</font>")
	update_appearance()


/obj/item/taperecorder/verb/play()
	set name = "Play Tape"
	set category = "Object"

	if(!can_use(usr))
		return
	if(!mytape || mytape.ruined)
		return
	if(recording)
		return
	if(playing)
		return

	playing = 1
	update_appearance()
	playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 50, FALSE)
	to_chat(usr, "<span class='notice'>Playing started.</span>")
	var/used = mytape.used_capacity	//to stop runtimes when you eject the tape
	var/max = mytape.max_capacity
	for(var/i = 1, used <= max, sleep(10 * playsleepseconds))
		if(!mytape)
			break
		if(playing == 0)
			break
		if(mytape.storedinfo.len < i)
			break
		say(mytape.storedinfo[i])
		if(mytape.storedinfo.len < i + 1)
			playsleepseconds = 1
			sleep(10)
			say("End of recording.")
		else
			playsleepseconds = mytape.timestamp[i + 1] - mytape.timestamp[i]
		if(playsleepseconds > 14)
			sleep(10)
			say("Skipping [playsleepseconds] seconds of silence")
			playsleepseconds = 1
		i++

	playing = 0
	update_appearance()


/obj/item/taperecorder/attack_self(mob/user)
	if(!mytape)
		to_chat(user, span_notice("The [src] does not have a tape inside."))
	if(mytape.ruined)
		to_chat(user, span_notice("The tape inside the [src] appears to be broken."))
		return

	update_available_icons()
	if(icons_available)
		var/selection = show_radial_menu(user, src, icons_available, radius = 38, require_near = TRUE, tooltips = TRUE)
		if(!selection)
			return
		switch(selection)
			if("Pause")
				stop()
			if("Stop Recording")  // yes we actually need 2 seperate stops for the same proc- Hopek
				stop()
			if("Record")
				record()
			if("Play")
				play()
			if("Print Transcript")
				print_transcript()
			if("Eject")
				eject(user)


/obj/item/taperecorder/verb/print_transcript()
	set name = "Print Transcript"
	set category = "Object"

	if(!can_use(usr))
		return
	if(!mytape)
		return
	if(!canprint)
		to_chat(usr, span_notice("The recorder can't print that fast!"))
		return
	if(recording || playing)
		return

	to_chat(usr, span_notice("Transcript printed."))
	playsound(src, 'sound/items/taperecorder/taperecorder_print.ogg', 50, FALSE)
	var/obj/item/paper/transcript_paper = new /obj/item/paper(get_turf(src))
	var/t1 = "<h2><center>Transcript:</h2><center><HR><BR>"
	for(var/i = 1, mytape.storedinfo.len >= i, i++)
		t1 += "[mytape.storedinfo[i]]<BR>"
	transcript_paper.add_raw_text(t1)
	transcript_paper.update_appearance()
	usr.put_in_hands(transcript_paper)
	canprint = FALSE
	addtimer(VARSET_CALLBACK(src, canprint, TRUE), 30 SECONDS)

/obj/item/taperecorder/AltClick(mob/user)
	. = ..()
	if (recording)
		stop()
	else
		record()

/obj/item/taperecorder/proc/update_available_icons()
	icons_available = list()

	if(recording)
		icons_available += list("Stop Recording" = image(icon = icon_directory, icon_state = "record_stop"))
	else
		if(!playing)
			icons_available += list("Record" = image(icon = icon_directory, icon_state = "record"))

	if(playing)
		icons_available += list("Pause" = image(icon = icon_directory, icon_state = "pause"))
	else
		if(!recording)
			icons_available += list("Play" = image(icon = icon_directory, icon_state = "play"))

	if(canprint && !recording && !playing)
		icons_available += list("Print Transcript" = image(icon = icon_directory, icon_state = "print"))
	if(mytape)
		icons_available += list("Eject" = image(icon = icon_directory, icon_state = "eject"))

//empty tape recorders
/obj/item/taperecorder/empty
	starting_tape_type = null


/obj/item/tape
	name = "tape"
	desc = "A magnetic tape that can hold up to ten minutes of content."
	icon_state = "tape_white"
	icon = 'icons/obj/device.dmi'
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron=20, /datum/material/glass=5)
	force = 1
	throwforce = 0
	var/max_capacity = 600
	var/used_capacity = 0
	var/list/storedinfo = list()
	var/list/timestamp = list()
	var/ruined = 0

/obj/item/tape/fire_act(exposed_temperature, exposed_volume)
	if(!ruined)
		ruin()
	..()

/obj/item/tape/attack_self(mob/user)
	if(!ruined)
		if(do_after(user, 30, src))
			to_chat(user, span_notice("You pull out all the tape!"))
			ruin()

/obj/item/tape/proc/ruin()
	add_overlay("ribbonoverlay")
	ruined = 1

/obj/item/tape/proc/fix()
	cut_overlay("ribbonoverlay")
	ruined = 0


/obj/item/tape/attackby(obj/item/I, mob/user, params)
	if(ruined && (I.tool_behaviour == TOOL_SCREWDRIVER || istype(I, /obj/item/pen)))
		to_chat(user, span_notice("You start winding the tape back in..."))
		if(I.use_tool(src, user, 120))
			to_chat(user, span_notice("You wound the tape back in."))
			fix()

//Random colour tapes
/obj/item/tape/random
	icon_state = "random_tape"

/obj/item/tape/random/Initialize()
	. = ..()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple")]"
