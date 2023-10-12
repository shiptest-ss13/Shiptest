/datum/sprite_accessory/genital
	special_render_case = TRUE
	var/associated_organ_slot
	var/uses_skintones
	///Where the genital is on the body. If clothing doesn't cover it, it shows up!
	var/genital_location = GROIN

/datum/sprite_accessory/genital/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	var/obj/item/organ/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(!badonkers)
		return TRUE
	switch(badonkers.visibility_preference)
		if(GENITAL_ALWAYS_SHOW)
			return FALSE
		if(GENITAL_HIDDEN_BY_CLOTHES)
			if((H.w_uniform && H.w_uniform.body_parts_covered & genital_location) || (H.wear_suit && H.wear_suit.body_parts_covered & genital_location) || (H.belt && H.belt.body_parts_covered & genital_location))
				return TRUE
			else
				return FALSE
		else
			return TRUE

/datum/sprite_accessory/genital/get_special_render_state(mob/living/carbon/human/H)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return  "[gen.sprite_suffix]"
	else
		return null

/datum/sprite_accessory/genital/penis
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/penis_onmob.dmi'
	organ_type = /obj/item/organ/genital/penis
	associated_organ_slot = ORGAN_SLOT_PENIS
	key = "penis"
	color_src = USE_MATRIXED_COLORS
	always_color_customizable = TRUE
	center = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	//default_color = DEFAULT_SKIN_OR_PRIMARY //This is the price we're paying for sheaths
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	var/can_have_sheath = TRUE

/datum/sprite_accessory/genital/penis/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return
	var/obj/item/organ/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES) && badonkers.visibility_preference != GENITAL_ALWAYS_SHOW)
		return TRUE

/datum/sprite_accessory/genital/penis/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & BODYTYPE_TAUR_SNAKE))
			returned = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/taur_penis_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/penis/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & BODYTYPE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/penis/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/penis/human
	icon_state = "human"
	name = "Human"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SKIN_OR_PRIMARY
	uses_skintones = TRUE
	can_have_sheath = FALSE

/datum/sprite_accessory/genital/penis/knotted
	icon_state = "knotted"
	name = "Knotted"

/datum/sprite_accessory/genital/penis/knotted2
	name = "Knotted 2"
	icon_state = "knotted2"

/datum/sprite_accessory/genital/penis/flared
	icon_state = "flared"
	name = "Flared"

/datum/sprite_accessory/genital/penis/barbknot
	icon_state = "barbknot"
	name = "Barbed, Knotted"

/datum/sprite_accessory/genital/penis/tapered
	icon_state = "tapered"
	name = "Tapered"

/datum/sprite_accessory/genital/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled"

/datum/sprite_accessory/genital/penis/hemi
	icon_state = "hemi"
	name = "Hemi"

/datum/sprite_accessory/genital/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi"

/datum/sprite_accessory/genital/testicles
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/genital/testicles
	associated_organ_slot = ORGAN_SLOT_TESTICLES
	key = "testicles"
	always_color_customizable = TRUE
	special_icon_case = TRUE
	special_x_dimension = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_ADJ_LAYER, BODY_BEHIND_LAYER)
	var/has_size = TRUE

/datum/sprite_accessory/genital/testicles/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return
	var/obj/item/organ/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES) && badonkers.visibility_preference != GENITAL_ALWAYS_SHOW)
		return TRUE

/datum/sprite_accessory/genital/testicles/get_special_icon(mob/living/carbon/human/H)
	var/returned = icon
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & BODYTYPE_TAUR_SNAKE))
			returned = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/taur_testicles_onmob.dmi'
	return returned

/datum/sprite_accessory/genital/testicles/get_special_x_dimension(mob/living/carbon/human/H)
	var/returned = dimension_x
	if(H.dna.species.mutant_bodyparts["taur"] && H.dna.features["penis_taur_mode"])
		var/datum/sprite_accessory/taur/SP = GLOB.sprite_accessories["taur"][H.dna.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(!(SP.taur_mode & BODYTYPE_TAUR_SNAKE))
			returned = 64
	return returned

/datum/sprite_accessory/genital/testicles/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/testicles/pair
	name = "Pair"
	icon_state = "pair"
	uses_skintones = TRUE

/datum/sprite_accessory/genital/testicles/internal
	name = "Internal"
	icon_state = "none"
	color_src = null
	has_size = FALSE

/datum/sprite_accessory/genital/vagina
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/testicles_onmob.dmi'
	organ_type = /obj/item/organ/genital/vagina
	associated_organ_slot = ORGAN_SLOT_VAGINA
	key = "vagina"
	always_color_customizable = TRUE
	default_color = "fcc"
	relevent_layers = list(BODY_FRONT_LAYER)
	var/alt_aroused = TRUE

/datum/sprite_accessory/genital/vagina/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return
	var/obj/item/organ/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(H.underwear != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_UNDIES) && badonkers.visibility_preference != GENITAL_ALWAYS_SHOW)
		return TRUE

/datum/sprite_accessory/genital/vagina/get_special_render_state(mob/living/carbon/human/H)
	var/obj/item/organ/genital/gen = H.getorganslot(associated_organ_slot)
	if(gen)
		return "[gen.sprite_suffix]"
	else
		return null

/datum/sprite_accessory/genital/vagina/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/vagina/human
	icon_state = "human"
	name = "Human"

/datum/sprite_accessory/genital/vagina/tentacles
	icon_state = "tentacle"
	name = "Tentacle"

/datum/sprite_accessory/genital/vagina/dentata
	icon_state = "dentata"
	name = "Dentata"

/datum/sprite_accessory/genital/vagina/hairy
	icon_state = "hairy"
	name = "Hairy"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/spade
	icon_state = "spade"
	name = "Spade"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/furred
	icon_state = "furred"
	name = "Furred"
	alt_aroused = FALSE

/datum/sprite_accessory/genital/vagina/gaping
	icon_state = "gaping"
	name = "Gaping"

/datum/sprite_accessory/genital/vagina/cloaca
	icon_state = "cloaca"
	name = "Cloaca"

/datum/sprite_accessory/genital/breasts
	icon = 'modular_zubbers/modules/customization/icons/sprite_accessory/genitals/breasts_onmob.dmi'
	organ_type = /obj/item/organ/genital/breasts
	associated_organ_slot = ORGAN_SLOT_BREASTS
	key = "breasts"
	always_color_customizable = TRUE
	default_color = DEFAULT_SKIN_OR_PRIMARY
	relevent_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	uses_skintones = TRUE
	genital_location = CHEST

/datum/sprite_accessory/genital/breasts/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return
	var/obj/item/organ/genital/badonkers = H.getorganslot(associated_organ_slot)
	if(H.undershirt != "Nude" && !(H.underwear_visibility & UNDERWEAR_HIDE_SHIRT) && badonkers.visibility_preference != GENITAL_ALWAYS_SHOW)
		return TRUE

/datum/sprite_accessory/genital/breasts/none
	icon_state = "none"
	name = "None"
	factual = FALSE
	color_src = null

/datum/sprite_accessory/genital/breasts/pair
	icon_state = "pair"
	name = "Pair"

/datum/sprite_accessory/genital/breasts/quad
	icon_state = "quad"
	name = "Quad"

/datum/sprite_accessory/genital/breasts/sextuple
	icon_state = "sextuple"
	name = "Sextuple"
