/obj/structure/hazard_shutoff
	name = "shutoff"
	desc = "you shouldn't be seeing this. Tell a maptainer!"
	icon = 'icons/obj/hazard/shutoff.dmi'
	icon_state = "standing_toggle"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	COOLDOWN_DECLARE(cooldown)
	var/cooldown_time = 1 SECONDS
	var/resets = null //if set to a time, will turn back on after that time.
	var/id = 0
	var/shutoff_message = "you toggle the shutoff"

	FASTDMM_PROP(\
		pinned_vars = list("name", "dir", "id")\
	)

/obj/structure/hazard_shutoff/proc/activate(mob/user)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return FALSE
	COOLDOWN_START(src, cooldown, cooldown_time)
	if(!id) //makes null shutoffs not turn off all null hazards. would be bad!
		say("no id set! fix that")
		return FALSE
	to_chat(user, span_notice("[shutoff_message]"))
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

