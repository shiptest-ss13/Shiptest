/obj/item/clothing/gloves
	name = "gloves"
	lefthand_file = 'icons/mob/inhands/clothing/gloves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/gloves_righthand.dmi'
	gender = PLURAL //Carn: for grammarically correct text-parsing
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/clothing/gloves.dmi'
	item_state = "bgloves"
	siemens_coefficient = 0.5
	body_parts_covered = HANDS
	slot_flags = ITEM_SLOT_GLOVES
	attack_verb = list("challenged")
	var/transfer_prints = FALSE
	strip_delay = 20
	equip_delay_other = 40
	cuttable = TRUE
	clothamnt = 2
	greyscale_colors = list(list(10, 13), list(11, 14), list(9, 12))
	greyscale_icon_state = "gloves"
	blood_overlay_type = "hands"

/obj/item/clothing/gloves/wash(clean_types)
	. = ..()
	if((clean_types & CLEAN_TYPE_BLOOD) && transfer_blood > 0)
		transfer_blood = 0
		return TRUE

/obj/item/clothing/gloves/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damagedgloves")
		if(HAS_BLOOD_DNA(src))
			. += setup_blood_overlay()


/obj/item/clothing/gloves/update_clothes_damaged_state(damaging = TRUE)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_gloves()

// Called just before an attack_hand(), in mob/UnarmedAttack()
/obj/item/clothing/gloves/proc/Touch(atom/A, proximity)
	return 0 // return 1 to cancel attack_hand()
