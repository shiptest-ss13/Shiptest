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
	blood_volume = BLOOD_VOLUME_NORMAL // so getting shot sprays blood like it does for players. need this for get_blood_id()

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
	///The kind of blood the simplemob bleeds
	var/datum/blood_type/blood_type
	///Name of a blood type to bleed instead of mob_species' one, like "Coolant" for IPC shells
	var/forced_blood_type
	///How long the mob keeps leaving drips after its last bleeding wound
	var/bleeding_duration = 15 SECONDS
	///Cooldown for how long the mob keeps leaving drips after its last bleeding wound
	COOLDOWN_DECLARE(bleeding_cooldown)

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

	// bleed what our species would, like coolant for synthetics, so blood we leave is the right colour
	var/datum/species/species_path = mob_species
	var/our_blood_type = forced_blood_type || (ispath(species_path) ? initial(species_path.exotic_bloodtype) : null)
	blood_type = our_blood_type ? get_blood_type(our_blood_type) : random_blood_type()

	if(ispath(armor_base, /obj/item/clothing))
		//sigh. if only we could get the initial() value of list vars
		var/obj/item/clothing/instance = new armor_base()
		armor = instance.armor
		qdel(instance)

/mob/living/simple_animal/hostile/human/Moved(atom/old_loc, movement_dir, Forced = FALSE, list/old_locs)
	. = ..()
	if(is_bleeding() && isturf(loc) && prob(40))
		add_splatter_floor(loc, TRUE)

/mob/living/simple_animal/hostile/human/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	. = ..()
	if(is_bleeding() && isturf(loc) && prob(20))
		add_splatter_floor(loc, TRUE)

/mob/living/simple_animal/hostile/human/proc/is_bleeding()
	return blood_volume && stat != DEAD && health < maxHealth * 0.5 && !COOLDOWN_FINISHED(src, bleeding_cooldown)

// Rolls for bleeding the way a carbon's wound roll does, see /obj/item/bodypart/proc/check_wounding(). No real wounds, so it's much cheaper
/mob/living/simple_animal/hostile/human/proc/roll_for_bleeding(damage, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE, armor_flag = MELEE, armour_penetration = 0, attack_direction)
	if(!blood_volume || !sharpness)
		return
	var/armor_value = run_armor_check(null, armor_flag, armour_penetration = armour_penetration, silent = TRUE)
	var/wound_damage = damage * (100 - armor_value) / 100
	if(wound_damage < WOUND_MINIMUM_DAMAGE)
		return
	var/wound_armor = get_armor_rating(WOUND)
	var/injury_roll = rand(1, round(min(wound_damage, WOUND_MAX_CONSIDERED_DAMAGE)) ** WOUND_DAMAGE_EXPONENT) + wound_bonus - wound_armor
	if(!wound_armor)
		injury_roll += bare_wound_bonus
	// the bleeding wounds a player would get from this, most severe first, as list(wound type = severity)
	var/static/list/slash_wounds = list(
		/datum/wound/slash/flesh/critical = WOUND_SEVERITY_CRITICAL,
		/datum/wound/slash/flesh/severe = WOUND_SEVERITY_SEVERE,
		/datum/wound/slash/flesh/moderate = WOUND_SEVERITY_MODERATE,
	)
	var/static/list/pierce_wounds = list(
		/datum/wound/pierce/bleed/critical = WOUND_SEVERITY_CRITICAL,
		/datum/wound/pierce/bleed/severe = WOUND_SEVERITY_SEVERE,
		/datum/wound/pierce/bleed/moderate = WOUND_SEVERITY_MODERATE,
	)
	var/list/possible_wounds
	switch(sharpness)
		if(SHARP_EDGED)
			possible_wounds = slash_wounds
		if(SHARP_POINTY)
			possible_wounds = pierce_wounds
	for(var/wound_type in possible_wounds)
		var/datum/wound_pregen_data/wound_data = SSwounds.pregen_data[wound_type]
		if(wound_data && injury_roll >= wound_data.threshold_minimum)
			spray_blood(attack_direction || pick(GLOB.alldirs), possible_wounds[wound_type])
			COOLDOWN_START(src, bleeding_cooldown, bleeding_duration)
			return

/mob/living/simple_animal/hostile/human/attack_animal(mob/living/simple_animal/attacker)
	. = ..()
	if(!. || attacker.melee_damage_type != BRUTE)
		return
	var/damage = (attacker.melee_damage_lower + attacker.melee_damage_upper) / 2
	roll_for_bleeding(damage, attacker.wound_bonus, attacker.bare_wound_bonus, attacker.sharpness, MELEE, attacker.armour_penetration, get_dir(attacker, src))
	if(prob(33)) // same prob as in /mob/living/attacked_by()
		add_splatter_floor(get_turf(src))

/mob/living/simple_animal/hostile/human/attacked_by(obj/item/attacking_item, mob/living/user)
	. = ..()
	if(attacking_item.force >= force_threshold && attacking_item.damtype == BRUTE)
		roll_for_bleeding(attacking_item.force, attacking_item.wound_bonus, attacking_item.bare_wound_bonus, attacking_item.get_sharpness(), MELEE, attacking_item.armour_penetration, get_dir(user, src))

/mob/living/simple_animal/hostile/human/get_blood_dna_list()
	if(get_blood_id() != /datum/reagent/blood)
		return
	return list("[real_name] DNA" = blood_type)

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
		dropped_gun.glunkify()

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
	if(projectile.damage_type == BRUTE)
		roll_for_bleeding(projectile.damage, projectile.wound_bonus, projectile.bare_wound_bonus, projectile.sharpness, projectile.flag, projectile.armour_penetration, get_dir(projectile.starting, src))
	return ..()

/mob/living/simple_animal/hostile/human/proc/spray_blood(splatter_direction, splatter_strength = 3)
	if(!isturf(loc) || !blood_volume)
		return
	var/obj/effect/decal/cleanable/blood/pool = new(loc)
	pool.transfer_mob_blood_dna(src)
	var/obj/effect/decal/cleanable/blood/hitsplatter/our_splatter = new(loc)
	our_splatter.blood_dna_info = get_blood_dna_list()
	our_splatter.transfer_mob_blood_dna(src)
	var/turf/targ = get_ranged_target_turf(src, splatter_direction, splatter_strength)
	INVOKE_ASYNC(our_splatter, TYPE_PROC_REF(/obj/effect/decal/cleanable/blood/hitsplatter, fly_towards), targ, splatter_strength)
