/obj/machinery/medical
	name = "Medical Unit"
	desc = "If you see this something went horrbily, horrbily wrong."
	icon = 'icons/obj/machines/medical/medical_machinery.dmi'
	icon_state = "mechanical_liver"
	density = TRUE
	anchored = TRUE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	idle_power_usage = 100
	active_power_usage = 750
	///Whos is attached to the life support.
	var/mob/living/carbon/attached
	///Active beam currently connected to attached target
	var/datum/beam/attached_beam = null

/obj/machinery/medical/Initialize()
	. = ..()
	START_PROCESSING(SSmachines, src)

/obj/machinery/medical/Destroy()
	STOP_PROCESSING(SSmachines, src)
	clear_status()
	return ..()

/obj/machinery/medical/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	anchored = !anchored
	return

/obj/machinery/medical/MouseDrop(mob/living/target)
	. = ..()
	if(!ishuman(usr) || !usr.canUseTopic(src, BE_CLOSE) || !isliving(target))
		return

	if(attached)
		usr.visible_message(span_warning("[usr] detaches [src] from [target]."), span_notice("You detach [src] from [target]."))
		clear_status()
		attached = null
		return

	if(!target.has_dna())
		to_chat(usr, span_warning("The [name] beeps: 'Warning, incompatible creature!'"))
		return

	if(Adjacent(target) && usr.Adjacent(target))
		usr.visible_message(span_warning("[usr] attaches [src] to [target]."), span_notice("You attach [src] to [target]."))
		attached_beam = src.Beam(target, icon_state = "1-full", maxdistance = 3)
		add_fingerprint(usr)
		attached = target
		update_overlays()

/obj/machinery/medical/process()
	update_overlays()
	update_appearance()

	if(!attached)
		use_power = IDLE_POWER_USE
		return

	if(machine_stat & (NOPOWER|BROKEN))
		clear_status()
		return

	if(!(get_dist(src, attached) <= 2 && isturf(attached.loc))) //you will most likely have multiple machines hooked up to you. Running away from them is a bad idea.
		to_chat(attached, "<span class='userdanger'>The [name] lines are ripped out of you!</span>")
		attached.apply_damage(20, BRUTE, BODY_ZONE_CHEST)
		attached.apply_damage(15, BRUTE, pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM))
		clear_status()
		attached = null
		return

	use_power = ACTIVE_POWER_USE

	return

/**
 * Properly gets rid of status effects from the attached
 *
 * Internal function, you shouldn't be calling this from anywhere else. Gets rid of all the status effects, traits and other shit you might have
 * put on the attached victim. Automatically updates overlays in case you have some, and changes power to idle power use.
 */
/obj/machinery/medical/proc/clear_status()
	update_overlays()
	qdel(attached_beam)
	return
