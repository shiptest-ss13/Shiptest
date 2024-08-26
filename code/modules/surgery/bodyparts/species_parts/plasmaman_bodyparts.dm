/obj/item/bodypart/head/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/chest/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	var/internal_fire = FALSE //If the bones themselves are burning clothes won't help you much // this is terrible but i cant think of anything else
	bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/chest/plasmaman/on_life() // this is also terrible
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/gas_mixture/environment = H.loc.return_air()
	var/atmos_sealed = FALSE
	if (H.wear_suit && H.head && istype(H.wear_suit, /obj/item/clothing) && istype(H.head, /obj/item/clothing))
		var/obj/item/clothing/CS = H.wear_suit
		var/obj/item/clothing/CH = H.head
		if (CS.clothing_flags & CH.clothing_flags & STOPSPRESSUREDAMAGE)
			atmos_sealed = TRUE
	if((!istype(H.w_uniform, /obj/item/clothing/under/plasmaman) || !istype(H.head, /obj/item/clothing/head/helmet/space/plasmaman)) && !atmos_sealed)
		if(environment)
			if(environment.total_moles())
				if(environment.get_moles(GAS_O2) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.5)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
					H.IgniteMob()
					internal_fire = TRUE
	else
		if(H.fire_stacks)
			var/obj/item/clothing/under/plasmaman/P = H.w_uniform
			if(istype(P))
				P.Extinguish(H)
				internal_fire = FALSE
		else
			internal_fire = FALSE
	H.update_fire()

/obj/item/bodypart/l_arm/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/r_arm/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/leg/left/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	bodytype = BODYTYPE_HUMANOID

/obj/item/bodypart/leg/right/plasmaman
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	limb_id = SPECIES_PLASMAMAN
	should_draw_greyscale = FALSE
	body_damage_coeff = 1.5
	bodytype = BODYTYPE_HUMANOID

// kepori

/obj/item/bodypart/head/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/chest/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI
	acceptable_bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/l_arm/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/r_arm/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/leg/left/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI

/obj/item/bodypart/leg/right/plasmaman/kepori
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_KEPORI

// vox

/obj/item/bodypart/head/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_VOX

/obj/item/bodypart/chest/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_VOX
	acceptable_bodytype = BODYTYPE_VOX

/obj/item/bodypart/l_arm/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_VOX

/obj/item/bodypart/r_arm/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_VOX

/obj/item/bodypart/leg/left/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
//	limb_id = "phorid"
	bodytype = BODYTYPE_VOX

/obj/item/bodypart/leg/right/plasmaman/vox
	static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
	bodytype = BODYTYPE_VOX
