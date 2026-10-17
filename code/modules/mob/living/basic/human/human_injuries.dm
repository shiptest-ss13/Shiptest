/// How human npcs show injuries. Basicmobs don't have the full health system a carbon would. They don't drop a normal body too so we record the damage taken and replay it on the body created after death

/datum/incoming_hit
	var/zone 	// body zone hit
	var/damage
	var/armor_flag
	var/sharpness
	var/direction

/datum/incoming_hit/New(zone, damage, armor_flag, sharpness, direction)
	src.zone = zone
	src.damage = damage
	src.armor_flag = armor_flag
	src.sharpness = sharpness
	src.direction = direction

/mob/living/basic/human
	blood_volume = BLOOD_VOLUME_NORMAL // so getting shot sprays blood like it does for players. need this for get_blood_id()
	var/datum/incoming_hit/incoming_hit
	var/datum/blood_type/blood_type
	var/list/bloodied_clothing_kinds
	var/list/bloody_clothing_overlays
	//How much brute and burn damage each body part has taken
	var/list/zone_brute
	var/list/zone_burn
	//Brute and burn the mob took from something that didn't hit anywhere in particular, like an explosion or fire, spread over our corpse
	var/untracked_brute = 0
	var/untracked_burn = 0
	//Suffocation and toxin damage the mob took
	var/oxy_damage_taken = 0
	var/tox_damage_taken = 0

// Works out what blood the mob bleeds
/mob/living/basic/human/proc/setup_blood()
	var/blood_type_name
	if(ispath(blood_type, /datum/blood_type))
		blood_type_name = initial(blood_type.name)
	else if(ispath(mob_species, /datum/species))
		var/datum/species/species_path = mob_species
		blood_type_name = initial(species_path.exotic_bloodtype)
	blood_type = get_blood_type(blood_type_name) || random_blood_type()

// basic mobs have no blood by default, so without this the blood we spray leaves no trace of whose or what colour it is
/mob/living/basic/human/get_blood_id()
	if(blood_volume)
		return /datum/reagent/blood

/mob/living/basic/human/get_blood_dna_list()
	if(get_blood_id() != /datum/reagent/blood)
		return
	return list("[real_name] DNA" = blood_type)

// the icon our species' blood sprites are in, if it has its own like vox do
/mob/living/basic/human/proc/get_species_overlay_icon()
	if(!ispath(mob_species, /datum/species))
		return null
	var/datum/species/species_path = mob_species
	return initial(species_path.custom_overlay_icon)

// ---------- taking hits ----------

/mob/living/basic/human/proc/begin_hit(zone, damage, armor_flag, sharpness, direction)
	incoming_hit = new(check_zone(zone || pick_hit_zone()), damage, armor_flag, sharpness, direction)

/mob/living/basic/human/proc/end_hit()
	incoming_hit = null

/mob/living/basic/human/bullet_act(obj/projectile/projectile, def_zone, piercing_hit = FALSE)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [projectile] with [p_their()] shield!"))
		return BULLET_ACT_BLOCK
	shake_animation(projectile.damage)
	begin_hit(def_zone, projectile.damage, projectile.flag, projectile.sharpness, get_dir(projectile.starting, src))
	. = ..()
	end_hit()

/mob/living/basic/human/attacked_by(obj/item/attacking_item, mob/living/user)
	begin_hit(user?.zone_selected, attacking_item.force, MELEE, attacking_item.get_sharpness(), get_dir(user, src))
	. = ..()
	end_hit()

/mob/living/basic/human/attack_animal(mob/living/simple_animal/user, list/modifiers)
	begin_hit(null, (user.melee_damage_lower + user.melee_damage_upper) / 2, MELEE, user.sharpness, get_dir(user, src))
	. = ..()
	end_hit()

/mob/living/basic/human/attack_basic_mob(mob/living/basic/user, list/modifiers)
	begin_hit(null, (user.melee_damage_lower + user.melee_damage_upper) / 2, MELEE, user.sharpness, get_dir(user, src))
	. = ..()
	end_hit()

// Basic mobs keep all their damage as one number, so we note what kind it was and where as we take it, for the corpse we leave

/mob/living/basic/human/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0)
		note_damage(BRUTE, .)

/mob/living/basic/human/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0)
		note_damage(BURN, .)

/mob/living/basic/human/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0)
		oxy_damage_taken += .

/mob/living/basic/human/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0)
		tox_damage_taken += .

// notes the damage taken so we can "replay" it on the corpse the mob leaves
/mob/living/basic/human/proc/note_damage(damage_type, amount)
	var/datum/incoming_hit/hit = incoming_hit
	if(!hit)
		if(damage_type == BRUTE)
			untracked_brute += amount
		else
			untracked_burn += amount
		return
	if(damage_type == BRUTE)
		LAZYSET(zone_brute, hit.zone, LAZYACCESS(zone_brute, hit.zone) + amount)
	else
		LAZYSET(zone_burn, hit.zone, LAZYACCESS(zone_burn, hit.zone) + amount)
	if(damage_type != BRUTE || stat == DEAD || QDELETED(src))
		return
	if(hit.armor_flag == MELEE && prob(25 + hit.damage * 2) && prob(hit.damage * 2))
		bloody_clothes(hit.zone)
	if(hit.armor_flag == BULLET || hit.sharpness)
		if(prob(amount))
			spray_blood(hit.direction || pick(GLOB.alldirs), rand(1, 3))
		bloody_clothes(hit.zone)

// ---------- blood ----------

/mob/living/basic/human/proc/spray_blood(splatter_direction, splatter_strength = 3)
	if(!isturf(loc) || !blood_volume)
		return
	var/obj/effect/decal/cleanable/blood/pool = new(loc)
	pool.transfer_mob_blood_dna(src)
	var/obj/effect/decal/cleanable/blood/hitsplatter/our_splatter = new(loc)
	our_splatter.blood_dna_info = get_blood_dna_list()
	our_splatter.transfer_mob_blood_dna(src)
	var/turf/splatter_target = get_ranged_target_turf(src, splatter_direction, splatter_strength)
	INVOKE_ASYNC(our_splatter, TYPE_PROC_REF(/obj/effect/decal/cleanable/blood/hitsplatter, fly_towards), splatter_target, splatter_strength)

/mob/living/basic/human/proc/bloody_clothes(zone)
	var/static/list/clothing_kinds_by_zone = list(
		BODY_ZONE_HEAD = list(/obj/item/clothing/head, /obj/item/clothing/mask),
		BODY_ZONE_CHEST = list(/obj/item/clothing/suit, /obj/item/clothing/under),
		BODY_ZONE_L_ARM = list(/obj/item/clothing/suit, /obj/item/clothing/under, /obj/item/clothing/gloves),
		BODY_ZONE_R_ARM = list(/obj/item/clothing/suit, /obj/item/clothing/under, /obj/item/clothing/gloves),
		BODY_ZONE_L_LEG = list(/obj/item/clothing/under, /obj/item/clothing/shoes),
		BODY_ZONE_R_LEG = list(/obj/item/clothing/under, /obj/item/clothing/shoes),
	)
	var/static/list/layers_by_clothing = list(
		/obj/item/clothing/under = UNIFORM_LAYER,
		/obj/item/clothing/suit = SUIT_LAYER,
		/obj/item/clothing/head = HEAD_LAYER,
		/obj/item/clothing/mask = FACEMASK_LAYER,
		/obj/item/clothing/gloves = GLOVES_LAYER,
		/obj/item/clothing/shoes = SHOES_LAYER,
	)
	if(!mob_spawner || !blood_volume)
		return
	var/list/new_kinds = clothing_kinds_by_zone[check_zone(zone || BODY_ZONE_CHEST)] - bloodied_clothing_kinds
	if(!length(new_kinds))
		return // already bloodied there
	LAZYADD(bloodied_clothing_kinds, new_kinds)
	if(length(bloody_clothing_overlays))
		cut_overlay(bloody_clothing_overlays)
	bloody_clothing_overlays = list()
	var/overlay_file = get_species_overlay_icon() || 'icons/effects/blood.dmi'
	for(var/obj/item/clothing/clothing_type as anything in get_spawner_clothing(mob_spawner))
		for(var/clothing_kind in bloodied_clothing_kinds)
			if(!ispath(clothing_type, clothing_kind))
				continue
			var/mutable_appearance/bloody_clothing = mutable_appearance(overlay_file, "[initial(clothing_type.blood_overlay_type)]blood", -layers_by_clothing[clothing_kind])
			bloody_clothing.color = blood_type?.color
			bloody_clothing_overlays += bloody_clothing
			break
	add_overlay(bloody_clothing_overlays)
