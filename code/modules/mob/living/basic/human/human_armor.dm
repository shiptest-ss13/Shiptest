/*
 * Human NPCs are armoured like players: each body part by whatever the clothes they'd leave behind as a corpse cover it with,
 * a vest on the chest, a helmet on the head, a hardsuit nearly everywhere, adding up like a player's do, see /mob/living/carbon/human/proc/checkarmor().
 * Worked out once for each corpse spawner and shared, see get_spawner_zone_armor(). Humans without a corpse fall back to armor_base, all over
 */

/mob/living/basic/human
	///How each body part is armoured, as list(body zone = /datum/armor), shared by every human dressed the same way. Null to use our armor all over
	var/list/zone_armor
	///The hit we're taking right now, so our armour goes by where it's landing, for hits that don't say, like melee, and our injuries agree, see begin_hit()
	var/datum/incoming_hit/incoming_hit

/// Armours each body part by what our corpse is wearing on it, if we have one, unless we're armored_all_over
/mob/living/basic/human/proc/setup_zone_armor()
	if(mob_spawner && !armored_all_over)
		zone_armor = get_spawner_zone_armor(mob_spawner)

/mob/living/basic/human/getarmor(def_zone, type)
	if(!zone_armor)
		return ..()
	var/datum/armor/part_armor = zone_armor[check_zone(def_zone || incoming_hit?.zone || BODY_ZONE_CHEST)]
	return part_armor ? part_armor.getRating(type) : 0

/// Picks where a hit that doesn't say lands, like a mob's attack would, mostly the chest
/mob/living/basic/human/proc/pick_hit_zone()
	return pick_weight(list(BODY_ZONE_HEAD = 4, BODY_ZONE_CHEST = 64, BODY_ZONE_L_ARM = 8, BODY_ZONE_R_ARM = 8, BODY_ZONE_L_LEG = 8, BODY_ZONE_R_LEG = 8))

/**
 * How each body part of someone dressed by this corpse spawner is armoured by their clothes, as list(body zone = /datum/armor).
 * Worked out once for each spawner, by making each piece of its outfit to see what it covers, and remembered
 */
/proc/get_spawner_zone_armor(spawner_type)
	var/static/list/armor_by_spawner = list()
	if(armor_by_spawner[spawner_type])
		return armor_by_spawner[spawner_type]
	var/static/list/zone_flags = list(
		BODY_ZONE_HEAD = HEAD,
		BODY_ZONE_CHEST = CHEST,
		BODY_ZONE_L_ARM = ARM_LEFT,
		BODY_ZONE_R_ARM = ARM_RIGHT,
		BODY_ZONE_L_LEG = LEG_LEFT,
		BODY_ZONE_R_LEG = LEG_RIGHT,
	)
	var/list/zone_armor = list()
	for(var/zone in zone_flags)
		zone_armor[zone] = getArmor()
	for(var/item_type in get_spawner_clothing(spawner_type))
		var/obj/item/clothing/clothing = new item_type
		for(var/zone in zone_flags)
			if(clothing.body_parts_covered & zone_flags[zone])
				var/datum/armor/part_armor = zone_armor[zone]
				zone_armor[zone] = part_armor.attachArmor(clothing.armor)
		qdel(clothing)
	armor_by_spawner[spawner_type] = zone_armor
	return zone_armor

/// The clothing typepaths a corpse spawner dresses its corpse in: its outfit's, with any the spawner itself overrides
/proc/get_spawner_clothing(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	// the spawner's own slot vars are -1 when it leaves that slot to the outfit
	var/list/slots = list(
		initial(spawner.uniform) == -1 && ispath(outfit) ? initial(outfit.uniform) : initial(spawner.uniform),
		initial(spawner.suit) == -1 && ispath(outfit) ? initial(outfit.suit) : initial(spawner.suit),
		initial(spawner.head) == -1 && ispath(outfit) ? initial(outfit.head) : initial(spawner.head),
		initial(spawner.mask) == -1 && ispath(outfit) ? initial(outfit.mask) : initial(spawner.mask),
		initial(spawner.gloves) == -1 && ispath(outfit) ? initial(outfit.gloves) : initial(spawner.gloves),
		initial(spawner.shoes) == -1 && ispath(outfit) ? initial(outfit.shoes) : initial(spawner.shoes),
		initial(spawner.neck) == -1 && ispath(outfit) ? initial(outfit.neck) : initial(spawner.neck),
		initial(spawner.belt) == -1 && ispath(outfit) ? initial(outfit.belt) : initial(spawner.belt),
		initial(spawner.back) == -1 && ispath(outfit) ? initial(outfit.back) : initial(spawner.back),
	)
	. = list()
	for(var/item_type in slots)
		if(ispath(item_type, /obj/item/clothing))
			. += item_type
