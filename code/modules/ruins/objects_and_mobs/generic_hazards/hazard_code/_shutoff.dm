/obj/structure/hazard_shutoff
	name = "shutoff"
	desc = "you shouldn't be seeing this. Tell a maptainer!"
	icon = 'icons/obj/hazard/shutoff.dmi'
	icon_state = "standing_toggle"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	COOLDOWN_DECLARE(cooldown)
	//cooldown on activating the shutoff
	var/cooldown_time = 1 SECONDS
	//if set to a time, resets will turn the hazards back on after that time.
	var/resets = null
	//ID used to toggle hazards, should only be set in maps.
	var/id = 0
	//to_chat message when using the shutoff
	var/shutoff_message = "You toggle the shutoff."

	FASTDMM_PROP(\
		pinned_vars = list("name", "dir", "id")\
	)

/obj/structure/hazard_shutoff/proc/activate(mob/user)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return FALSE
	COOLDOWN_START(src, cooldown, cooldown_time)
	if(!id) //makes null shutoffs not turn off all null hazards. would be bad!
		say("no id set! fix that") //shutoffs without IDs shouldn't exist, so this lets mappers know, hopefully.
		return FALSE
	to_chat(user, span_notice("[shutoff_message]"))
	playsound(src.loc, 'sound/machines/switch3.ogg', 35, TRUE)
	for(var/obj/structure/hazard/hazard in GLOB.ruin_hazards)
		if(hazard.id != src.id)
			continue
		if(resets) //if resets is a time, turns off the hazard until the reset time has passed. Can continuosly pull switch if cooldown_time is shorter than resets
			hazard.turn_off()
			addtimer(CALLBACK(hazard, TYPE_PROC_REF(/obj/structure/hazard, turn_on)), resets)
		else
			hazard.toggle() //allows for switching hazards. IE one section turns on, one turns off.
	return TRUE

/obj/structure/hazard_shutoff/interact(mob/user)
	. = ..()
	activate(user)

/obj/structure/hazard_shutoff/powered
	name = "powered shutoff"
	desc = "A shutoff that requires power."
	icon_state = "standing_toggle"
	shutoff_message = "The shutoff hums as you toggle it."
	var/obj/structure/cable/attached_cable
	var/siphoned_power = 0
	var/siphon_max = 1e7
	var/toggle_power = 5e6

/obj/structure/hazard_shutoff/powered/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/hazard_shutoff/powered/process()
	if(siphoned_power >= siphon_max)
		return
	update_cable()
	if(attached_cable)
		attempt_siphon()

/obj/structure/hazard_shutoff/powered/proc/update_cable()
	var/turf/T = get_turf(src)
	attached_cable = locate(/obj/structure/cable) in T

/obj/structure/hazard_shutoff/powered/proc/attempt_siphon()
	var/surpluspower = clamp(attached_cable.surplus(), 0, (siphon_max - siphoned_power))
	if(surpluspower)
		attached_cable.add_load(surpluspower)
		siphoned_power += surpluspower

/obj/structure/hazard_shutoff/powered/activate(mob/user)
	if(siphoned_power < siphon_max)
		to_chat(user, span_notice("[src] requires power!"))
		return
	if(toggle_power)
		siphoned_power -= toggle_power
	. = ..()

/obj/structure/hazard_shutoff/powered/examine(mob/user)
	. = ..()
	if(!siphoned_power)
		. += "<span class='notice'>[src] is disabled, and could be charged with a cable connection!</span>"
	else if(siphoned_power >= siphon_max)
		. += "<span class='notice'>[src] is fully charged.</span>"
	else
		. += "<span class='notice'>[src] is [round((siphoned_power/siphon_max)*100, 0.1)]% charged.</span>"
