
/obj/item/plasmacutter
	name = "plasma cutter"
	desc = "A high powered engineering tool used for everything from hull slicing to industrial revolts. This particular model has an adjustable lens capable of welding, cutting, and firing energetic bursts."
	icon = 'icons/obj/weapon/plasmacutter.dmi'
	base_icon_state = "cutter"
	icon_state = "cutter"
	item_state = "cutter"

	lefthand_file = 'icons/mob/inhands/weapons/plasmacutter_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/plasmacutter_right.dmi'

	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "slashed", "cut", "sliced")

	sharpness = SHARP_NONE

	force = 10
	demolition_mod = 2
	armour_penetration = 0

	heat = 3800
	usesound = list('sound/weapons/melee/plasmacutter/plasma_cutter_melee.ogg')

	power_use_amount = POWER_CELL_USE_VERY_LOW

	tool_behaviour = TOOL_DECONSTRUCT
	wall_decon_damage = 200
	toolspeed = 0.75

	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_PURPLE
	light_on = FALSE

	///is the cutter currently powered?
	var/powered = FALSE

	var/obj/projectile/shot_type = /obj/projectile/plasma
	var/fire_delay = 3 SECONDS
	var/charged = TRUE

	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/plasmacutter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = force+5, icon_wielded="[base_icon_state]_w")
	AddComponent(/datum/component/cell, cell_override, CALLBACK(src, PROC_REF(switched_off)))
	AddElement(/datum/element/tool_flash, 1)

/obj/item/plasmacutter/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>Control+Click</b> the plasmacutter to change its mode. It is currently on [tool_behaviour]")

/obj/item/plasmacutter/CtrlClick(mob/user)
	. = ..()
	toggle_tool_mode(user)

/obj/item/plasmacutter/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	var/modifiers = params2list(clickparams)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return
	if(!(item_use_power(power_use_amount*30) & COMPONENT_POWER_SUCCESS))
		return
	if(!proximity_flag && charged && powered)
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/plasma_burst = new shot_type(proj_turf)
		plasma_burst.preparePixelProjectile(target, user, modifiers)
		plasma_burst.firer = user
		playsound(user, 'sound/weapons/melee/plasmacutter/plasma_cutter.ogg', 100, TRUE)
		plasma_burst.fire()
		charged = FALSE
		update_appearance()
		addtimer(CALLBACK(src, GLOBAL_PROC_REF(playsound), src, 'sound/weapons/melee/plasmacutter/cutter_recharge.ogg', 60, TRUE), fire_delay-8)
		addtimer(CALLBACK(src, PROC_REF(recharge)), fire_delay)
		return

/obj/item/plasmacutter/proc/recharge()
	if(!charged)
		charged = TRUE
		update_appearance()

/obj/item/plasmacutter/update_appearance(updates)
	. = ..()
	icon_state = "[base_icon_state][powered ? "_on" : ""]"
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		item_state = "[base_icon_state]_wielded[powered ? "_on" : ""]"
	else
		item_state = "[base_icon_state]"


/obj/item/plasmacutter/proc/toggle_tool_mode(mob/user)
	if(tool_behaviour == TOOL_DECONSTRUCT)
		tool_behaviour = TOOL_WELDER
	else
		tool_behaviour = TOOL_DECONSTRUCT
	playsound(src, 'sound/weapons/gun/general/selector.ogg', 50, TRUE)
	to_chat(user, "You adjust [src]'s lens to [tool_behaviour]")

/obj/item/plasmacutter/unique_action(mob/user, modifiers)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		to_chat(user, span_warning("[src] needs to beheld in both hands to activate!"))
		return FALSE
	if(!powered)
		if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
			return
	powered = !powered

	if(powered)
		to_chat(user, span_notice("You ignite [src]'s blade."))
		playsound(user, 'sound/weapons/saberon.ogg', 20, TRUE)
		switched_on()
		return

	to_chat(user, span_notice("You disable [src]'s blade."))
	playsound(user, 'sound/weapons/saberoff.ogg', 20, TRUE)
	switched_off()

/obj/item/plasmacutter/proc/switched_on(mob/user)
	powered = TRUE
	force += 15
	damtype = BURN
	sharpness = SHARP_EDGED
	hitsound = 'sound/weapons/melee/plasmacutter/plasma_cutter_melee.ogg'
	tool_behaviour = TOOL_DECONSTRUCT
	set_light_on(powered)
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/item/plasmacutter/proc/switched_off(mob/user)
	powered = FALSE
	force -= 15
	damtype = BRUTE
	sharpness = SHARP_NONE
	hitsound = 'sound/weapons/melee/baton_hit.ogg'
	set_light_on(powered)
	tool_behaviour = NONE
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/item/plasmacutter/process(seconds_per_tick)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		playsound(src, 'sound/weapons/saberoff.ogg', 20, TRUE)
		switched_off()
		return

	if(!powered)
		playsound(src, 'sound/weapons/saberoff.ogg', 20, TRUE)
		switched_off()
		return

	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		playsound(src, 'sound/weapons/saberoff.ogg', 20, TRUE)
		switched_off()
		return

/obj/item/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	if(amount)
		if(tool_behaviour==TOOL_DECONSTRUCT)
			target.add_overlay(GLOB.advanced_cutting_effect)
			. = ..()
			target.cut_overlay(GLOB.advanced_cutting_effect)


		else
			target.add_overlay(GLOB.welding_sparks)
			. = ..()
			target.cut_overlay(GLOB.welding_sparks)
	else
		. = ..(amount=1)

/obj/item/plasmacutter/use()
	return (item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS)

/obj/item/plasmacutter/tool_use_check(mob/living/user, atom/target, amount)
	if(!powered)
		to_chat(user, span_warning("[src] has to be on to complete this task!"))
		return FALSE

	if((item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		return TRUE
	else
		to_chat(user, span_warning("You need more charge to complete this task!"))
		return FALSE
