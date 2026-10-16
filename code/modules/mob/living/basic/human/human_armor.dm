
/mob/living/basic/human
	var/datum/incoming_hit/incoming_hit

/mob/living/basic/human/proc/setup_body_armor()
	if(mob_spawner && !armored_all_over)
		armor = get_spawner_body_armor(mob_spawner)

/mob/living/basic/human/proc/pick_hit_zone()
	return pick_weight(GLOB.ai_hit_zone_weights)

// how often each body part gets hit by attacks that don't aim
GLOBAL_LIST_INIT(ai_hit_zone_weights, list(BODY_ZONE_HEAD = 4, BODY_ZONE_CHEST = 64, BODY_ZONE_L_ARM = 8, BODY_ZONE_R_ARM = 8, BODY_ZONE_L_LEG = 8, BODY_ZONE_R_LEG = 8))

// average the armour from a spawner's outfit over the entire body
/proc/get_spawner_body_armor(spawner_type)
	var/static/list/armor_by_spawner = list()
	if(armor_by_spawner[spawner_type])
		return armor_by_spawner[spawner_type]
	var/list/zone_armor = get_spawner_zone_armor(spawner_type)
	var/total_weight = 0
	for(var/zone in GLOB.ai_hit_zone_weights)
		total_weight += GLOB.ai_hit_zone_weights[zone]
	var/list/averaged = list()
	for(var/zone in GLOB.ai_hit_zone_weights)
		var/datum/armor/part_armor = zone_armor[zone]
		var/list/part_ratings = part_armor.getList()
		for(var/armor_type in part_ratings)
			averaged[armor_type] += part_ratings[armor_type] * GLOB.ai_hit_zone_weights[zone] / total_weight
	for(var/armor_type in averaged)
		averaged[armor_type] = round(averaged[armor_type])
	var/datum/armor/body_armor = getArmor(arglist(averaged))
	armor_by_spawner[spawner_type] = body_armor
	return body_armor

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

/proc/spawner_has_jetpack(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/back = initial(spawner.back) == -1 && ispath(outfit) ? initial(outfit.back) : initial(spawner.back)
	return ispath(back, /obj/item/tank/jetpack)

/proc/spawner_is_pressure_sealed(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/obj/item/clothing/suit = initial(spawner.suit) == -1 && ispath(outfit) ? initial(outfit.suit) : initial(spawner.suit)
	var/obj/item/clothing/head = initial(spawner.head) == -1 && ispath(outfit) ? initial(outfit.head) : initial(spawner.head)
	if(!ispath(suit, /obj/item/clothing) || !ispath(head, /obj/item/clothing))
		return FALSE
	return (initial(suit.clothing_flags) & STOPSPRESSUREDAMAGE) && (initial(head.clothing_flags) & STOPSPRESSUREDAMAGE)

// how much a corpse spawner's outfit slows whoever wears it, all its clothes together
/proc/get_spawner_slowdown(spawner_type)
	var/static/list/slowdown_by_spawner = list()
	if(!isnull(slowdown_by_spawner[spawner_type]))
		return slowdown_by_spawner[spawner_type]
	var/total = 0
	for(var/obj/item/clothing/worn as anything in get_spawner_clothing(spawner_type))
		total += initial(worn.slowdown)
	slowdown_by_spawner[spawner_type] = total
	return total

/proc/spawner_has_flashlight(spawner_type)
	var/static/list/flashlight_by_spawner = list()
	if(!isnull(flashlight_by_spawner[spawner_type]))
		return flashlight_by_spawner[spawner_type]
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/outfit_type = initial(spawner.outfit)
	var/datum/outfit/outfit = ispath(outfit_type, /datum/outfit) ? new outfit_type : null
	var/list/carried = list(
		initial(spawner.belt) == -1 ? outfit?.belt : initial(spawner.belt),
		initial(spawner.r_pocket) == -1 ? outfit?.r_pocket : initial(spawner.r_pocket),
		initial(spawner.l_pocket) == -1 ? outfit?.l_pocket : initial(spawner.l_pocket),
		initial(spawner.suit_store) == -1 ? outfit?.suit_store : initial(spawner.suit_store),
	)
	if(islist(outfit?.backpack_contents))
		carried += outfit.backpack_contents
	qdel(outfit)
	var/found = FALSE
	for(var/item_type in carried)
		if(ispath(item_type, /obj/item/flashlight) || ispath(item_type, /obj/item/attachment/rail_light))
			found = TRUE
			break
	flashlight_by_spawner[spawner_type] = found
	return found
