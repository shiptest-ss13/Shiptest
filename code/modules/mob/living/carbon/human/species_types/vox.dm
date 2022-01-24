//Copy-pasted kepori stuff
/datum/species/vox
	name = "\improper Vox"
	id = SPECIES_VOX
	default_color = "6060FF"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_UNDERWEAR)
	mutant_bodyparts = list("vox_head_quills", "vox_neck_quills")
	default_features = list("mcolor" = "0F0", "wings" = "None", "vox_head_quills" = "None", "vox_neck_quills" = "None")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GRAIN
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Vox test"
	say_mod = "shrieks"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	// species_clothing_path = 'icons/mob/clothing/species/kepori.dmi'
	species_eye_path = 'icons/mob/vox_parts.dmi'
	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,-4), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-4), OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,-4), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0), OFFSET_ACCESSORY = list(0, -4))
	punchdamagelow = 4
	punchdamagehigh = 10
	mutanttongue = /obj/item/organ/tongue/vox
	species_language_holder = /datum/language_holder/vox

	species_chest = /obj/item/bodypart/chest/vox
	species_head = /obj/item/bodypart/head/vox
	species_l_arm = /obj/item/bodypart/l_arm/vox
	species_r_arm = /obj/item/bodypart/r_arm/vox
	species_l_leg = /obj/item/bodypart/l_leg/vox
	species_r_leg = /obj/item/bodypart/r_leg/vox

/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()
	return kepori_name()

/datum/species/vox/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.pixel_x -= 10

/datum/species/vox/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.pixel_x += 10
