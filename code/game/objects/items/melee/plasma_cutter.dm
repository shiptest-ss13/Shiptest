
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
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

	force = 10
	demolition_mod = 2
	armour_penetration = 0

	heat = 3800
	usesound = list('sound/weapons/melee/plasmacutter/plasma_cutter_melee.ogg')

	power_use_amount = POWER_CELL_USE_VERY_LOW

	tool_behaviour = NONE
	wall_decon_damage = 200
	toolspeed = 0.75

	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_PURPLE
	light_on = FALSE

	var/obj/projectile/shot_type = /obj/projectile/plasma
	var/fire_delay = 3 SECONDS
	var/charged = TRUE

	var/static/list/cutting_overlays

	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/plasmacutter/Initialize()
	. = ..()
	if(!cutting_overlays)
		cutting_overlays = list(
			TOOL_DECONSTRUCT = GLOB.advanced_cutting_effect,
			TOOL_WELDER = GLOB.cutting_effect,
		)

/obj/item/plasmacutter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = force+20, icon_wielded="[base_icon_state]_w")
	AddComponent(/datum/component/cell, cell_override, CALLBACK(src, PROC_REF(switched_off)))
	AddElement(/datum/element/tool_flash, 1)
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(switched_on))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(switched_off))

/obj/item/plasmacutter/examine(mob/user)
	. = ..()
	. += span_notice("Use the <b>Unique Action</b> key to swap the cutting mode. It is currently set to <b>[tool_behaviour]</b>.")

/obj/item/plasmacutter/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if(proximity_flag)
		return ..()
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!(item_use_power(power_use_amount*30) & COMPONENT_POWER_SUCCESS))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!charged)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/turf/proj_turf = user.loc
	if(!isturf(proj_turf))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/modifiers = params2list(click_parameters)
	var/obj/projectile/plasma_burst = new shot_type(proj_turf)
	plasma_burst.preparePixelProjectile(target, user, modifiers)
	plasma_burst.firer = user
	playsound(user, 'sound/weapons/melee/plasmacutter/plasma_cutter.ogg', 100, TRUE)
	plasma_burst.fire()
	charged = FALSE
	update_appearance()
	addtimer(CALLBACK(src, GLOBAL_PROC_REF(playsound), src, 'sound/weapons/melee/plasmacutter/cutter_recharge.ogg', 60, TRUE), fire_delay-8)
	addtimer(CALLBACK(src, PROC_REF(recharge)), fire_delay)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/plasmacutter/proc/recharge()
	if(!charged)
		charged = TRUE
		update_appearance()

/obj/item/plasmacutter/update_appearance(updates)
	. = ..()
	var/wielded = HAS_TRAIT(src, TRAIT_WIELDED)
	icon_state = "[base_icon_state][wielded ? "_on" : ""]"
	item_state = "[base_icon_state][wielded ? "_wielded_on" : ""]"

/obj/item/plasmacutter/unique_action(mob/user, modifiers)
	. = ..()
	if(obj_flags & IN_USE)
		user.balloon_alert(user, "in use!")
		return
	if(tool_behaviour == TOOL_DECONSTRUCT)
		tool_behaviour = TOOL_WELDER
	else
		tool_behaviour = TOOL_DECONSTRUCT
	playsound(src, 'sound/weapons/gun/general/selector.ogg', 50, TRUE)
	to_chat(user, "You adjust [src]'s lens to [tool_behaviour].")

/obj/item/plasmacutter/proc/switched_on(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
		to_chat(user, span_warning("[src] doesn't have enough charge!"))
		return COMPONENT_TWOHANDED_BLOCK_WIELD
	if(user)
		to_chat(user, span_notice("You ignite [src]'s blade."))
	playsound(user, 'sound/weapons/saberon.ogg', 20, TRUE)
	damtype = BURN
	sharpness = SHARP_EDGED
	hitsound = 'sound/weapons/melee/plasmacutter/plasma_cutter_melee.ogg'
	set_light_on(TRUE)
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/item/plasmacutter/proc/switched_off(mob/user)
	SIGNAL_HANDLER
	if(user)
		to_chat(user, span_notice("You disable [src]'s blade."))
	playsound(user, 'sound/weapons/saberoff.ogg', 20, TRUE)
	damtype = BRUTE
	sharpness = SHARP_NONE
	hitsound = 'sound/weapons/melee/baton_hit.ogg'
	set_light_on(FALSE)
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/item/plasmacutter/process(seconds_per_tick)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		switched_off()
		CRASH("[type] was still processing without being wielded!")

	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		playsound(src, 'sound/weapons/saberoff.ogg', 20, TRUE)
		attack_self()

/obj/item/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	if(delay)
		obj_flags |= IN_USE
		target.add_overlay(cutting_overlays[tool_behaviour])
		. = ..()
		target.cut_overlay(cutting_overlays[tool_behaviour])
		obj_flags &= ~IN_USE
	else
		return ..()

/obj/item/plasmacutter/use()
	return (item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS)

/obj/item/plasmacutter/tool_use_check(mob/living/user, atom/target, amount)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		to_chat(user, span_warning("[src] has to be on to complete this task!"))
		return FALSE

	if((item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		return TRUE

	to_chat(user, span_warning("You need more charge to complete this task!"))
	return FALSE
