/datum/species/teshari
	name = "Kepori"
	id = "teshari"
	default_color = "6060FF"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_UNDERWEAR)
	mutant_bodyparts = list("teshari_feathers", "teshari_body_feathers")
	default_features = list("mcolor" = "0F0", "wings" = "None", "teshari_feathers" = "Plain", "teshari_body_feathers" = "Plain")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GRAIN | GROSS
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Kepori are a raptor-like species covered in feathers vaguely reminiscent of earth’s extinct troodontidae. They’re small and sometimes seen as weak by other species due to their hollow bones but make up for that in speed and reflexes. Those found in space usually lack a clutch, commonly known as rollaways."	
	say_mod = "chirps"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'icons/mob/clothing/species/teshari.dmi'
	species_eye_path = 'icons/mob/teshari_parts.dmi'
	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,-4), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-4), OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,-4), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0), OFFSET_ACCESSORY = list(0, -4))
	punchdamagelow = 0
	punchdamagehigh = 6
	coldmod = 0.67
	heatmod = 1.5
	brutemod = 1.5
	burnmod = 1.5
	speedmod = -0.25
	bodytemp_normal = BODYTEMP_NORMAL - 30
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 30)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)
	no_equip = list(ITEM_SLOT_BACK)
	mutanttongue = /obj/item/organ/tongue/teshari
	species_language_holder = /datum/language_holder/teshari

/datum/species/teshari/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.can_be_held = TRUE

/datum/species/teshari/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.can_be_held = FALSE

/datum/species/teshari/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self, swap)
	if(slot == ITEM_SLOT_MASK)
		if(H.wear_mask && !swap)
			return FALSE
		if(I.w_class > WEIGHT_CLASS_SMALL)
			return FALSE
		if(!H.get_bodypart(BODY_ZONE_HEAD))
			return FALSE
		return equip_delay_self_check(I, H, bypass_equip_delay_self)
	. = ..()
