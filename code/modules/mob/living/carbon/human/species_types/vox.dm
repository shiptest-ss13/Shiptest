//Copy-pasted kepori stuff
/datum/species/vox
	name = "\improper Vox"
	id = SPECIES_VOX
	default_color = "6060FF"
	species_age_max = 280
	mutant_bodyparts = list("vox_head_quills", "vox_neck_quills")
	default_features = list("mcolor" = "0F0", "wings" = "None", "vox_head_quills" = "None", "vox_neck_quills" = "None")
	meat = /obj/item/food/meat/slab/chicken
	disliked_food = GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	loreblurb = "Vox are a big bird-like species with quills, much larger and much more long-lasting than other species. Sadly, not much else is known."
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/vox.dmi'
	species_eye_path = 'icons/mob/species/vox/vox_parts.dmi'
	punchdamagelow = 6
	punchdamagehigh = 12
	species_language_holder = /datum/language_holder/vox

	bodytemp_heat_divisor = VOX_BODYTEMP_HEAT_DIVISOR
	bodytemp_cold_divisor = VOX_BODYTEMP_COLD_DIVISOR
	bodytemp_autorecovery_min = VOX_BODYTEMP_AUTORECOVERY_MIN

	max_temp_comfortable = HUMAN_BODYTEMP_NORMAL + 10
	min_temp_comfortable = HUMAN_BODYTEMP_NORMAL - 20

	bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT + 10
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 20

	bodytype = BODYTYPE_VOX

	custom_overlay_icon = 'icons/mob/species/vox/vox_overlays.dmi'
	damage_overlay_type = "vox"
	fire_overlay = "generic"

	species_organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/vox,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
	)

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/vox,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/vox,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/vox,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/vox,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/vox,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/vox,
		BODY_ZONE_TAIL = /obj/item/bodypart/tail/vox,
	)

	prosthetic_style = /datum/sprite_accessory/body/prosthetic/vox

	var/static/list/allergy_reactions = list(
		"Your beak itches.",
		"Your stomach churns.",
		"Your tail flicks on its own.",
		"Your quills feel heavy.",
		"Your lungs struggle to fill."
		)

	var/static/list/allergic_to = typecacheof(
		list(
			/datum/reagent/medicine/ephedrine,
			/datum/reagent/medicine/atropine,
			/datum/reagent/medicine/epinephrine,
			/datum/reagent/medicine/mannitol,
			/datum/reagent/medicine/antihol,
			/datum/reagent/medicine/stimulants,
			/datum/reagent/medicine/inaprovaline
		)
	)

/datum/species/vox/New()
	. = ..()
	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[SUIT_STORE_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = 0),
							"[EAST]" = list("x" = 8, "y" = 0),
							"[SOUTH]" = list("x" = 8, "y" = 0),
							"[WEST]" = list("x" =  -8, "y" = 0)
							),
		"[EARS_LAYER]" = list(
							"[NORTH]" = list("x" = 8, "y" = 0),
							"[EAST]" = list("x" = 8, "y" = 0),
							"[SOUTH]" = list("x" = 8, "y" = 0),
							"[WEST]" = list("x" =  -8, "y" = 0)
							),
	)

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()
	return vox_name()

/datum/species/vox/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.base_pixel_x -= 9
	C.pixel_x = C.base_pixel_x
	C.update_hands_on_rotate()

/datum/species/vox/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.base_pixel_x += 9
	C.pixel_x = C.base_pixel_x
	C.stop_updating_hands()

/datum/species/vox/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(allergic_to[chem.type]) //Is_type_in_typecache is BAD.
		H.reagents.add_reagent(/datum/reagent/toxin/histamine, chem.metabolization_rate * 3)
		if(prob(5))
			to_chat(H, span_danger("[pick(allergy_reactions)]"))
		else if(prob(5))
			H.emote("clack")
		return FALSE //Its a bit TOO mean to have the chems not work at all.
	return ..()

/datum/species/vox/get_item_offsets_for_dir(dir, hand)
	//LEFT/RIGHT
	if(dir & NORTH)
		return list(list("x" = 9, "y" = 0), list("x" = 9, "y" = 0))
	if(dir & SOUTH)
		return list(list("x" = 10, "y" = -1), list("x" = 8, "y" = -1))
	if(dir & EAST)
		return list(list("x" = 18, "y" = 2), list("x" = 21, "y" = -1))
	if(dir & WEST)
		return list(list("x" = -5, "y" = -1), list("x" = -1, "y" = 2))
