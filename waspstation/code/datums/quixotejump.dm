/datum/action/innate/quixotejump
	name = "Dash"
	desc = "Activate the quixote hardsuit's dash mechanism, allowing the user to dash over 4-tile gaps."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "jetboot"
	var/charges = 3
	var/max_charges = 3
	var/charge_rate = 60 //3 seconds
	var/mob/living/carbon/human/holder
	var/dash_sound = 'sound/magic/blink.ogg'
	var/beam_effect = "blur"

/datum/action/innate/quixotejump/Grant(mob/user)
	. = ..()
	holder = user

/datum/action/innate/quixotejump/IsAvailable()
	if(charges > 0)
		return TRUE
	else
		return FALSE

/datum/action/innate/quixotejump/proc/charge()
	charges = clamp(charges + 1, 0, max_charges)
	holder.update_action_buttons_icon()
	to_chat(holder, "<span class='notice'>Quixote dash mechanisms now have [charges]/[max_charges] charges.</span>")

/datum/action/innate/quixotejump/Activate()
    if(!charges)
        to_chat(holder, "<span class='warning'>Quixote dash mechanisms are still recharging. Please standby.</span>")
        return
    var/newx = holder.x
    var/newy = holder.y
    switch(holder.dir)
        if(NORTH) newy += 4
        if(EAST)  newx += 4
        if(SOUTH) newy -= 4
        if(WEST)  newx -= 4
        else      CRASH("Invalid direction!")
    var/turf/T = locate(newx, newy, holder.z)
    holder.throw_at(T, 5, 3, spin = FALSE)
    holder.visible_message("<span class='warning'>[holder] suddenly dashes forward!</span>", "<span class='notice'>The Quixote dash mechanisms propel you forward!</span>")
    playsound(T, dash_sound, 25, TRUE)
    charges--
    holder.update_action_buttons_icon()
    addtimer(CALLBACK(src, .proc/charge), charge_rate)
