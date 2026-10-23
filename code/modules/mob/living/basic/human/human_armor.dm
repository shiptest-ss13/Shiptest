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

// the armour a piece of clothing of this type has, made once per type
/proc/get_clothing_armor(clothing_type)
	var/static/list/armor_by_type = list()
	if(armor_by_type[clothing_type])
		return armor_by_type[clothing_type]
	//sigh. if only we could get the initial() value of list vars
	var/obj/item/clothing/clothing = new clothing_type
	var/datum/armor/clothing_armor = clothing.armor
	qdel(clothing)
	armor_by_type[clothing_type] = clothing_armor
	return clothing_armor

/mob/living/basic/human/proc/blocks_shove_knockdown()
	var/static/list/blocks_by_outfit = list()
	var/outfit_key = "[mob_spawner]|[armor_base]|[armored_all_over]"
	if(!isnull(blocks_by_outfit[outfit_key]))
		return blocks_by_outfit[outfit_key]
	var/list/worn = list()
	if(mob_spawner && !armored_all_over)
		worn += get_spawner_clothing(mob_spawner)
	if(ispath(armor_base, /obj/item/clothing))
		worn += armor_base
	var/blocks = FALSE
	for(var/obj/item/clothing/clothing_type as anything in worn)
		if(ispath(clothing_type, /obj/item/clothing) && (initial(clothing_type.clothing_flags) & BLOCKS_SHOVE_KNOCKDOWN))
			blocks = TRUE
			break
	blocks_by_outfit[outfit_key] = blocks
	return blocks

/mob/living/basic/human/proc/get_held_shield_type()
	for(var/held in list(r_hand, l_hand))
		var/held_type = held
		if(isobj(held))
			var/obj/held_object = held
			held_type = held_object.type
		if(ispath(held_type, /obj/item/shield))
			return held_type
	return null

/mob/living/basic/human/proc/blocks_shove_with_shield(mob/living/shover)
	var/obj/item/shield/shield_type = get_held_shield_type()
	if(!shield_type || stat != CONSCIOUS || body_position == LYING_DOWN)
		return FALSE
	var/angle_off_facing = abs(dir2angle(dir) - dir2angle(get_dir(src, shover)))
	if(angle_off_facing > 180)
		angle_off_facing = 360 - angle_off_facing
	if(angle_off_facing > 45 || !prob(initial(shield_type.block_chance)))
		return FALSE
	visible_message(span_danger("[src] blocks [shover]'s shove with [p_their()] [initial(shield_type.name)]!"))
	playsound(src, 'sound/weapons/effects/deflect.ogg', 100)
	return TRUE
