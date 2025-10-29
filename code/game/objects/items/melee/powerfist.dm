/obj/item/melee/powerfist
	name = "power-fist"
	desc = "A metal gauntlet with a electrically charged ram ontop for that extra 'ompfh' in your punch."
	icon = 'icons/obj/weapon/blunt.dmi'
	icon_state = "powerfist"
	item_state = "powerfist"
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 25
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)
	resistance_flags = FIRE_PROOF
	hitsound = 'sound/weapons/resonator_blast.ogg'
	pickup_sound = 'sound/weapons/melee/general_pickup.ogg'
	wound_bonus = 10
	armour_penetration = -10
	bare_wound_bonus = 20
	attack_cooldown = HEAVY_WEAPON_CD
	pickup_sound = 'sound/weapons/melee/powerfist_pickup.ogg'
	var/power_level = 0
	var/overcharge = FALSE
	var/charge_per_attack = 1000
	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/melee/powerfist/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell, cell_override, _has_cell_overlays=FALSE)
	update_appearance()

/obj/item/melee/powerfist/examine()
	. = ..()
	. += span_notice("It is currently set to power level [power_level]!")
	if(overcharge)
		. += span_warning("Sparks are coming off it!")

/obj/item/melee/powerfist/attack_self(mob/user)
	set_power_level(user, (power_level+1)%4)

/obj/item/melee/powerfist/AltClick(mob/user)
	. = ..()
	update_appearance()

/obj/item/melee/powerfist/proc/set_power_level(mob/user, new_power_level, forced=FALSE)
	playsound(src, 'sound/machines/click.ogg', 60, TRUE)
	power_level = new_power_level
	switch(power_level)
		if(0)
			to_chat(user, span_warning("[forced ? "[src] disables itself" : "You disable [src]"]."))
			hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
			overcharge = FALSE
		if(1,2)
			to_chat(user, span_warning("[forced ? "[src] sets itself" : "You tune [src]"] to setting [power_level]."))
			hitsound = 'sound/weapons/resonator_blast.ogg'
		if(3)
			to_chat(user, span_warning("[forced ? "[src] sets itself" : "You tune [src]" ] to setting [power_level]. Maximum force."))
	update_appearance()

/obj/item/melee/powerfist/multitool_act(mob/living/user, obj/item/I)
	overcharge =! overcharge
	to_chat(user, span_boldwarning("Overcharge [overcharge ? "engaged" : "disabled"]"))

/obj/item/melee/powerfist/CtrlClick(mob/user)
	. = ..()
	playsound(src, 'sound/machines/switch3.ogg', 25, TRUE)
	if(HAS_TRAIT_FROM(src, TRAIT_NODROP, "powerfist"))
		REMOVE_TRAIT(src, TRAIT_NODROP, "powerfist")
	else
		ADD_TRAIT(src, TRAIT_NODROP, "powerfist")
	if(ismob(loc))
		to_chat(loc, span_notice("[src] is now [HAS_TRAIT_FROM(src, TRAIT_NODROP, "powerfist") ? "locked" : "unlocked"]."))

/obj/item/melee/powerfist/update_overlays()
	. = ..()
	var/datum/component/cell/our_cell = GetComponent(/datum/component/cell)
	if(!our_cell.inserted_cell)
		return cut_overlays()
	var/charge = our_cell.inserted_cell.percent()
	if(charge > 66)
		. += "powerfist-3"
	else if(charge > 20)
		. += "powerfist-2"
	else
		. += "powerfist-1"

/obj/item/melee/powerfist/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!power_level)
		return
	var/power_use_amount = charge_per_attack * power_level
	if(overcharge)
		power_use_amount += 6000
	if((item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		if(overcharge)
			target.apply_damage((power_level*10), BRUTE, wound_bonus = 20)
			user.apply_damage(5+power_level*5, BRUTE, def_zone = check_zone(user.get_active_hand()), wound_bonus = 40)
			do_sparks(5, TRUE, src)
		else
			target.apply_damage((power_level * 5), BRUTE, wound_bonus = 20)
		var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
		target.throw_at(throw_target, 1 * power_level, 2, gentle = !overcharge)
	else
		set_power_level(user, 0, TRUE)

	return
