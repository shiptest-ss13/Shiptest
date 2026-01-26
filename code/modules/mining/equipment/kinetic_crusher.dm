/*********************Mining Hammer****************/
/obj/item/kinetic_crusher
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	item_state = "crusher0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "proto-magnetic crusher"
	desc = "A multipurpose disembarkation and self-defense tool designed by EXOCOM using an incomplete Nanotrasen prototype. \
	Found in the grime-stained hands of wannabee explorers across the frontier, it cuts rock and hews flora using magnetic osscilation and a heavy cleaving edge."
	force = 0 //You can't hit stuff unless it's wielded
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	armour_penetration = 5
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("smashed", "crushed", "cleaved", "chopped", "pulped")
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/toggle_light)
	obj_flags = UNIQUE_RENAME
	light_system = MOVABLE_LIGHT
	light_range = 5
	light_on = FALSE
	custom_price = 800
	var/charged = TRUE
	var/charge_time = 15
	var/detonation_damage = 20
	var/backstab_bonus = 10
	var/unwielded_force = 0
	var/wielded_force = 25

/obj/item/kinetic_crusher/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110) //technically it's huge and bulky, but this provides an incentive to use it
	AddComponent(/datum/component/two_handed, force_unwielded=unwielded_force, force_wielded=wielded_force)

/obj/item/kinetic_crusher/examine(mob/living/user)
	. = ..()
	. += span_notice("Induce magnetism in an enemy by striking them with a magnetospheric wave, then hit them in melee to force a waveform collapse for <b>[force + detonation_damage]</b> damage.")
	. += span_notice("Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.")

/obj/item/kinetic_crusher/attack(mob/living/target, mob/living/carbon/user)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return

	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(!target.anchored)
		target.throw_at(throw_target, rand(1,2), 2, user, gentle = TRUE)

	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/kinetic_crusher/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	var/modifiers = params2list(clickparams)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/D = new /obj/projectile/destabilizer(proj_turf)
		D.preparePixelProjectile(target, user, modifiers)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/melee/plasmacutter/plasma_cutter.ogg', 100, TRUE)
		D.fire()
		charged = FALSE
		update_appearance()
		addtimer(CALLBACK(src, PROC_REF(Recharge)), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, TRUE) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

/obj/item/kinetic_crusher/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_appearance()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, TRUE)

/obj/item/kinetic_crusher/ui_action_click(mob/user, actiontype)
	set_light_on(!light_on)
	playsound(user, SOUND_EMPTY_MAG, 100, TRUE)
	update_appearance()


/obj/item/kinetic_crusher/update_icon_state()
	item_state = "crusher[HAS_TRAIT(src, TRAIT_WIELDED)]" // this is not icon_state and not supported by 2hcomponent
	return ..()

/obj/item/kinetic_crusher/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(light_on)
		. += "[icon_state]_lit"

//destablizing force
/obj/projectile/destabilizer
	name = "magnetic wave"
	icon_state = "pulse1"
	nodamage = TRUE
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	damage_type = BRUTE
	wall_damage_flags = PROJECTILE_BONUS_DAMAGE_MINERALS
	wall_damage_override = MINERAL_WALL_INTEGRITY
	flag = "bomb"
	range = 6
	log_override = TRUE
	var/obj/item/kinetic_crusher/hammer_synced

/obj/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/projectile/destabilizer/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK, hammer_synced)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		SSblackbox.record_feedback("tally", "pick_used_mining", 1, src.type)
		var/turf/closed/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
	..()

//outdated Nanotrasen prototype of the crusher. Incredibly heavy, but the blade was made at a premium. //to alter this I had to duplicate some code, big moment.
/obj/item/kinetic_crusher/old
	icon_state = "crusherold"
	item_state = "crusherold0"
	name = "proto-kinetic crusher"
	desc = "During the early design process of the Kinetic Accelerator, a great deal of money and time was invested in magnetic distruption technology. \
	Though eventually replaced with concussive blasts, the ever-practical NT designed a second mining tool. \
	Only a few were ever produced, mostly for NT research institutions, and they are a valulable relic in the postwar age."
	detonation_damage = 10
	slowdown = 0.5//hevy
	attack_verb = list("mashed", "flattened", "bisected", "eradicated","destroyed")
	unwielded_force = 0
	wielded_force = 30

/obj/item/kinetic_crusher/old/examine(mob/user)
	. = ..()
	. += span_notice("This hunk of junk's so heavy that you can barely swing it! Though, that blade looks pretty sharp...")

/obj/item/kinetic_crusher/old/melee_attack_chain(mob/user, atom/target, params)
	..()
	user.changeNext_move(CLICK_CD_MELEE * 2.0)//...slow swinga.

/obj/item/kinetic_crusher/old/update_icon_state()
	item_state = "crusherold[HAS_TRAIT(src, TRAIT_WIELDED)]" // still not supported by 2hcomponent
	return ..()

//100% original syndicate oc, plz do not steal. More effective against human targets then the typical crusher, with a bit of block chance.
/obj/item/kinetic_crusher/syndie_crusher
	icon = 'icons/obj/mining.dmi'
	icon_state = "crushersyndie"
	item_state = "crushersyndie0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "magnetic cleaver"
	desc = "Designed by Syndicate Research and Development for their resource-gathering operations on hostile worlds. Syndicate Legal Ops would like to stress that you've never seen anything like this before. Ever."
	armour_penetration = 69//nice cut
	force = 0 //You can't hit stuff unless HAS_TRAIT(src, TRAIT_WIELDED)
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 5
	throw_speed = 4
	block_chance = 20
	custom_materials = list(/datum/material/titanium=5000, /datum/material/iron=2075)
	hitsound = 'sound/weapons/blade1.ogg'
	attack_verb = list("sliced", "bisected", "diced", "chopped", "filleted")
	sharpness = SHARP_EDGED
	obj_flags = UNIQUE_RENAME
	light_color = "#fb6767"
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 1
	light_on = FALSE
	custom_price = 7500//a rare syndicate prototype.
	charged = TRUE
	charge_time = 15
	detonation_damage = 35
	backstab_bonus = 15
	actions_types = list()
	unwielded_force = 0
	wielded_force = 22

/obj/item/kinetic_crusher/syndie_crusher/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/// triggered on wield of two handed item
/obj/item/kinetic_crusher/syndie_crusher/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	icon_state = "crushersyndie1"
	playsound(user, 'sound/weapons/saberon.ogg', 35, TRUE)
	set_light_on(HAS_TRAIT(src, TRAIT_WIELDED))

/// triggered on unwield of two handed item
/obj/item/kinetic_crusher/syndie_crusher/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	icon_state = "crushersyndie"
	playsound(user, 'sound/weapons/saberoff.ogg', 35, TRUE)
	set_light_on(HAS_TRAIT(src, TRAIT_WIELDED))

/obj/item/kinetic_crusher/syndie_crusher/update_icon_state()
	item_state = "crushersyndie[HAS_TRAIT(src, TRAIT_WIELDED)]" // this is not icon_state and not supported by 2hcomponent
	return ..()

/obj/item/kinetic_crusher/syndie_crusher/update_overlays()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		. += "[icon_state]_lit"
