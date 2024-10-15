/datum/species/snail
	name = "\improper Snailperson"
	id = SPECIES_SNAIL
	species_traits = list(NO_UNDERWEAR)
	inherent_traits = list(TRAIT_ALWAYS_CLEAN, TRAIT_NOSLIPALL)
	attack_verb = "slap"
	coldmod = 0.5 //snails only come out when its cold and wet
	burnmod = 2
	speedmod = 6
	punchdamagehigh = 0.5 //snails are soft and squishy
	siemens_coeff = 2 //snails are mostly water
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	var/shell_type = /obj/item/storage/backpack/snail

	mutanteyes = /obj/item/organ/eyes/snail
	mutanttongue = /obj/item/organ/tongue/snail
	exotic_blood = /datum/reagent/lube

	species_chest = /obj/item/bodypart/chest/snail
	species_head = /obj/item/bodypart/head/snail
	species_l_arm = /obj/item/bodypart/l_arm/snail
	species_r_arm = /obj/item/bodypart/r_arm/snail
	species_l_leg = /obj/item/bodypart/leg/left/snail
	species_r_leg = /obj/item/bodypart/leg/right/snail

/datum/species/snail/New()
	. = ..()
	offset_clothing = list(
		"[GLASSES_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = 4), "[EAST]" = list("x" = 0, "y" = 4), "[SOUTH]" = list("x" = 0, "y" = 4), "[WEST]" = list("x" =  0, "y" = 4))
	)

/datum/species/snail/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/consumable/sodiumchloride)
		H.adjustFireLoss(2)
		playsound(H, 'sound/weapons/sear.ogg', 30, TRUE)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE
	return ..()

/datum/species/snail/on_species_gain(mob/living/carbon/C)
	. = ..()
	var/obj/item/storage/backpack/bag = C.get_item_by_slot(ITEM_SLOT_BACK)
	if(!istype(bag, /obj/item/storage/backpack/snail))
		if(C.dropItemToGround(bag)) //returns TRUE even if its null
			C.equip_to_slot_or_del(new /obj/item/storage/backpack/snail(C), ITEM_SLOT_BACK)
	C.AddElement(/datum/element/snailcrawl)

/datum/species/snail/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.RemoveElement(/datum/element/snailcrawl)
	var/obj/item/storage/backpack/bag = C.get_item_by_slot(ITEM_SLOT_BACK)
	if(istype(bag, /obj/item/storage/backpack/snail))
		bag.emptyStorage()
		C.temporarilyRemoveItemFromInventory(bag, TRUE)
		qdel(bag)

/obj/item/storage/backpack/snail
	name = "snail shell"
	desc = "Worn by snails as armor and storage compartment."
	icon_state = "snailshell"
	item_state = "snailshell"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/storage/backpack/snail/dropped(mob/user, silent)
	. = ..()
	emptyStorage()
	if(!QDELETED(src))
		qdel(src)

/obj/item/storage/backpack/snail/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "snailshell")
