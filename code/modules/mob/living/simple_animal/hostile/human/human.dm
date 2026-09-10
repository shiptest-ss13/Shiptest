/mob/living/simple_animal/hostile/human
	name = "crazed human"
	desc = "A crazed human, they cannot be reasoned with"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "survivor_base"
	icon_living = "survivor_base"
	icon_dead = null
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID

	speak_chance = 20
	speak_emote = list("groans")

	turns_per_move = 5
	speed = 0
	maxHealth = 100
	health = 100

	robust_searching = TRUE
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	response_help_continuous = "pushes"
	response_help_simple = "push"

	loot = list(/obj/effect/mob_spawn/human/corpse/damaged)
	del_on_death = TRUE

	unsuitable_atmos_damage = 7.5
	minbodytemp = 180

	minimum_pressure = HAZARD_LOW_PRESSURE
	maximum_pressure = HAZARD_HIGH_PRESSURE
	status_flags = CANPUSH

	footstep_type = FOOTSTEP_MOB_SHOE

	faction = list(FACTION_ANTAG_HERMITS)

	/// If we use stuff from dynamic human icon generation for loot
	var/human_loot = TRUE
	/// Path of the mob spawner we base the mob's visuals off of.
	var/obj/effect/mob_spawn/human/mob_spawner
	/// Path of the species we base the mob's visuals off of.
	var/datum/species/mob_species
	/// Path of the right hand held item we give to the mob's visuals.
	var/obj/r_hand
	/// THE DEFAULT HAND (Required if you want them to wield it). Path of the left hand held item we give to the mob's visuals.
	var/obj/l_hand
	// Prob of us dropping l/r hand loot.
	var/weapon_drop_chance = 10

	///Steals the armor datum from this type of armor
	var/obj/item/clothing/armor_base

/mob/living/simple_animal/hostile/human/Initialize(mapload)
	. = ..()
	if(mob_spawner)
		if(!mob_species)
			mob_species = pick_weight(list(
					/datum/species/lizard = 28,
					/datum/species/human = 22,
					/datum/species/ipc = 20,
					/datum/species/elzuose = 20,
					/datum/species/moth = 5,
					/datum/species/spider = 3
				)
			)
		apply_dynamic_human_appearance(src, species_path = mob_species, mob_spawn_path = mob_spawner, r_hand = r_hand, l_hand = l_hand, seed = rand(1,3))
		if(ispath(r_hand,/obj/item/gun))
			var/obj/item/gun/our_gun = r_hand
			spread = our_gun.spread
		else if(ispath(l_hand, /obj/item/gun))
			var/obj/item/gun/our_gun = l_hand
			spread = our_gun.spread

	if(ispath(armor_base, /obj/item/clothing))
		//sigh. if only we could get the initial() value of list vars
		var/obj/item/clothing/instance = new armor_base()
		armor = instance.armor
		qdel(instance)

// applies special stuff to guns that are dropped, which are very special indeed
/mob/living/simple_animal/hostile/human/proc/modify_dropped_gun(obj/item/gun/dropped_gun)
	var/good = TRUE
	// break gun and apply broken overlay
	if(!prob(weapon_drop_chance)) // you got the dud!
		good = FALSE
		visible_message(span_danger("[src]'s [dropped_gun.name] is destroyed as they collapse!"))
		dropped_gun.actually_shoots = FALSE
		dropped_gun.desc += span_warning("\nIt appears to be irreparably broken.")
		// broken overlay
		var/index = "[REF(initial(dropped_gun.icon))]-[initial(dropped_gun.icon_state)]"
		var/static/list/scuff_cache = list()
		var/icon/scuff = scuff_cache[index]
		if(!scuff) // we only need to generate each scuff overlay once
			scuff = icon(initial(dropped_gun.icon), initial(dropped_gun.icon_state))
			var/icon/temp = icon('icons/effects/item_damage.dmi', "itemdamaged")
			temp.Scale(64, 32)
			temp.Shift(EAST, 32) // we put two side by side so it fits on guns
			temp.Blend(icon('icons/effects/item_damage.dmi', "itemdamaged"), ICON_OVERLAY)
			scuff.Blend("#fff", ICON_ADD)
			scuff.Blend(temp, ICON_MULTIPLY)
			scuff_cache[index] = scuff
		var/mutable_appearance/scuff_instance = new(scuff)
		dropped_gun.add_overlay(scuff_instance)

	// BALLISTICS - apply wear, mag drop chance, and empty the mag partially
	if(istype(dropped_gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/cosmetic_damage = dropped_gun
		cosmetic_damage.gun_wear = rand(cosmetic_damage.wear_minor_threshold, cosmetic_damage.wear_maximum) //my free gun... it's bowowken...
		if(!prob(weapon_drop_chance) && !cosmetic_damage.internal_magazine)
			qdel(cosmetic_damage.magazine)
			cosmetic_damage.magazine = null
		if(cosmetic_damage.magazine)
			for(var/i = 0, i < rand(0, cosmetic_damage.magazine.max_ammo), i++)
				qdel(cosmetic_damage.magazine.get_round()) // feels kludgy but like. how else
				cosmetic_damage.magazine.update_ammo_count()
		cosmetic_damage.update_appearance()

	// ENERGY - drain cell a random amount, cell drop chance
	if(istype(dropped_gun, /obj/item/gun/energy))
		var/obj/item/gun/energy/lazor = dropped_gun
		if(lazor.cell)
			lazor.cell.charge = rand(0, lazor.cell.maxcharge)
			lazor.update_appearance()
			if(!good) // undamaged guns never have dud cells
				lazor.cell.name = "dented [lazor.cell.name]"
				lazor.cell.desc += " It doesn't seem to be in the greatest condition..."
				if(!prob(weapon_drop_chance))
					lazor.cell.rigged = TRUE // smiles warmly
					lazor.cell.show_rigged = FALSE

// handles behavior for either dropping the held item or damaging it
/mob/living/simple_animal/hostile/human/proc/handle_hand_item_destruction(obj/hand)
	if(!hand) // wow look nothing
		return
	if(ispath(hand, /obj/item/gun)) // we always drop guns, the drop chance just makes them functional
		var/obj/item/gun/dropped_gun = new hand(loc)
		modify_dropped_gun(dropped_gun)
	else // for melee weapons and stuff they just explode into dust
		if(prob(weapon_drop_chance))
			new hand(loc)
		else
			visible_message(span_danger("[src]'s [hand.name] is destroyed as they collapse!"))

/mob/living/simple_animal/hostile/human/drop_loot()
	. = ..()
	if(QDELING(src))
		return
	if(!human_loot)
		return
	if(mob_spawner)
		new mob_spawner(loc, mob_species)
	handle_hand_item_destruction(l_hand)
	handle_hand_item_destruction(r_hand)

/mob/living/simple_animal/hostile/human/vv_edit_var(var_name, var_value)
	switch(var_name)
		if (NAMEOF(src, armor_base))
			if(ispath(var_value, /obj/item/clothing))
				var/obj/item/clothing/temp = new var_value
				armor = temp.armor
				qdel(temp)
				datum_flags |= DF_VAR_EDITED
				return TRUE
			return FALSE
	. = ..()

/mob/living/simple_animal/hostile/human/bullet_act(obj/projectile/projectile)
	shake_animation(projectile.damage)
	if(projectile.damage_type==BRUTE)
		if(prob((projectile.damage + projectile.wound_bonus)-(armor.bullet - projectile.armour_penetration)))
			spray_blood(projectile.dir, rand(1,3))
	return ..()

/mob/living/simple_animal/hostile/human/proc/spray_blood(splatter_direction, splatter_strength = 3)
	if(!isturf(loc))
		return
	new /obj/effect/decal/cleanable/blood(loc)
	var/obj/effect/decal/cleanable/blood/hitsplatter/our_splatter = new(loc)
	var/turf/targ = get_ranged_target_turf(src, splatter_direction, splatter_strength)
	INVOKE_ASYNC(our_splatter, TYPE_PROC_REF(/obj/effect/decal/cleanable/blood/hitsplatter, fly_towards), targ, splatter_strength)
