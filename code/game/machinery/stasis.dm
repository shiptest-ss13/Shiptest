#define STASIS_TOGGLE_COOLDOWN 50
/obj/machinery/stasis
	name = "Lifeform Stasis Unit"
	desc = "A not so comfortable looking bed with some nozzles at the top and bottom. It will keep someone in stasis."
	icon = 'icons/obj/machines/stasis.dmi'
	icon_state = "stasis"
	base_icon_state = "stasis"
	density = FALSE
	can_buckle = TRUE
	buckle_lying = 90
	circuit = /obj/item/circuitboard/machine/stasis
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = ACTIVE_DRAW_HIGH
	var/stasis_enabled = TRUE
	var/last_stasis_sound = FALSE
	var/stasis_can_toggle = 0
	var/mattress_state = "stasis_on"
	var/obj/effect/overlay/vis/mattress_on
	var/obj/machinery/computer/operating/op_computer

/obj/machinery/stasis/Initialize()
	. = ..()
	for(var/direction in GLOB.alldirs)
		op_computer = locate(/obj/machinery/computer/operating) in get_step(src, direction)
		if(op_computer)
			op_computer.sbed = src
			break

/obj/machinery/stasis/Destroy()
	. = ..()
	if(op_computer && op_computer.sbed == src)
		op_computer.sbed = null

/obj/machinery/stasis/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [stasis_enabled ? "turn off" : "turn on"] the machine.")
	. += span_notice("\The [src] is [op_computer ? "linked" : "<b>NOT</b> linked"] to a nearby operating computer.")

/obj/machinery/stasis/proc/play_power_sound()
	var/_running = stasis_running()
	if(last_stasis_sound != _running)
		var/sound_freq = rand(5120, 8800)
		if(_running)
			playsound(src, 'sound/machines/synth_yes.ogg', 50, TRUE, frequency = sound_freq)
		else
			playsound(src, 'sound/machines/synth_no.ogg', 50, TRUE, frequency = sound_freq)
		last_stasis_sound = _running

/obj/machinery/stasis/AltClick(mob/user)
	if(world.time >= stasis_can_toggle && user.canUseTopic(src, !issilicon(user)))
		stasis_enabled = !stasis_enabled
		stasis_can_toggle = world.time + STASIS_TOGGLE_COOLDOWN
		playsound(src, 'sound/machines/click.ogg', 60, TRUE)
		user.visible_message(span_notice("\The [src] [stasis_enabled ? "powers on" : "shuts down"]."), \
					span_notice("You [stasis_enabled ? "power on" : "shut down"] \the [src]."), \
					span_hear("You hear a nearby machine [stasis_enabled ? "power on" : "shut down"]."))
		play_power_sound()
		update_appearance()

/obj/machinery/stasis/Exited(atom/movable/AM, atom/newloc)
	if(AM == occupant)
		var/mob/living/L = AM
		if(IS_IN_STASIS(L))
			thaw_them(L)
	. = ..()

/obj/machinery/stasis/proc/stasis_running()
	return stasis_enabled && is_operational

/obj/machinery/stasis/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]_broken"
		return ..()
	if(panel_open || machine_stat & MAINT)
		icon_state = "[base_icon_state]_maintenance"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/stasis/update_overlays()
	. = ..()
	if(!mattress_state)
		return
	var/_running = stasis_running()
	if(!mattress_on)
		mattress_on = SSvis_overlays.add_vis_overlay(src, icon, mattress_state, BELOW_OBJ_LAYER, plane, dir, alpha = 0, unique = TRUE)
	else
		vis_contents += mattress_on
		if(managed_vis_overlays)
			managed_vis_overlays += mattress_on
		else
			managed_vis_overlays = list(mattress_on)

	if(mattress_on.alpha ? !_running : _running) //check the inverse of _running compared to truthy alpha, to see if they differ
		var/new_alpha = _running ? 255 : 0
		var/easing_direction = _running ? EASE_OUT : EASE_IN
		animate(mattress_on, alpha = new_alpha, time = 50, easing = CUBIC_EASING|easing_direction)

/obj/machinery/stasis/atom_break(damage_flag)
	. = ..()
	if(.)
		play_power_sound()

/obj/machinery/stasis/power_change()
	. = ..()
	play_power_sound()

/obj/machinery/stasis/proc/chill_out(mob/living/target)
	if(target != occupant)
		return
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)
	target.apply_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
	target.ExtinguishMob()
	set_active_power()

/obj/machinery/stasis/proc/thaw_them(mob/living/target)
	target.remove_status_effect(STATUS_EFFECT_STASIS, STASIS_MACHINE_EFFECT)
	if(target == occupant)
		set_idle_power()

/obj/machinery/stasis/post_buckle_mob(mob/living/L)
	if(!can_be_occupant(L))
		return
	occupant = L
	if(stasis_running())
		chill_out(L)
	update_appearance()

/obj/machinery/stasis/post_unbuckle_mob(mob/living/L)
	thaw_them(L)
	if(L == occupant)
		occupant = null
	update_appearance()

/obj/machinery/stasis/process(seconds_per_tick)
	if(!occupant || !isliving(occupant))
		use_power = IDLE_POWER_USE
		return
	var/mob/living/L_occupant = occupant
	if(stasis_running())
		if(!IS_IN_STASIS(L_occupant))
			chill_out(L_occupant)
	else if(IS_IN_STASIS(L_occupant))
		thaw_them(L_occupant)

/obj/machinery/stasis/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	. |= default_deconstruction_screwdriver(user, "stasis_maintenance", "stasis", I)
	update_appearance()

/obj/machinery/stasis/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	return default_deconstruction_crowbar(I) || .

#undef STASIS_TOGGLE_COOLDOWN
