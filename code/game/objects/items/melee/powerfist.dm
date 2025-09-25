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
	bare_wound_bonus = 20
	attack_cooldown = HEAVY_WEAPON_CD
	var/power_level = 1
	var/overcharge = FALSE
	var/charge_per_attack = 1000
	var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/melee/powerfist/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cell, cell_override, CALLBACK(src, PROC_REF(switched_off)))

/obj/item/melee/powerfist/attack_self(mob/user)
	power_level = (power_level+1)%4
	//range of 25 (off) to 40 (lv3)
	force = 25+power_level*5
	playsound(src, 'sound/machines/click.ogg', 60, TRUE)
	to_chat(user, span_notice("You tweak \the [src]'s charge to [power_level]."))


/obj/item/melee/powerfist/multitool_act(mob/living/user, mob/living/user)
	overcharge =! overcharge
	to_chat(user, span_warning("Overcharge toggled"))


/obj/item/melee/powerfist/attack(mob/living/target, mob/living/user)
	. = ..()
	var/power_use_amount = charge_per_attack * power_level
	if(overcharge)
		power_use_amount += 6000
	if(!item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS)
		if(overcharge)
			target.apply_damage((power_level*10), BRUTE, wound_bonus = 20)
			user.apply_damage(power_level*4, BRUTE,  wound_bonus = 40)
			do_sparks(5, TRUE, src)
		else
			target.apply_damage((power_level * 5), BRUTE, wound_bonus = 20)
		var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
		target.throw_at(throw_target, 1 * power_level, 0.5 + (power_level / 2), gentle = !overcharge)

	return
