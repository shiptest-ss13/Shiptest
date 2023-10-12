/obj/item/organ/genital
	color = "#fcccb3"
	organ_flags = ORGAN_EDIBLE | ORGAN_NO_DISMEMBERMENT
	///Size value of the genital, needs to be translated to proper lengths/diameters/cups
	var/genital_size = 1
	///Sprite name of the genital, it's what shows up on character creation
	var/genital_name = "Human"
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = "human"
	///Used for determining what sprite is being used, derrives from size and type
	var/sprite_suffix
	///Used for input from the user whether to show a genital through clothing or not, always or never etc.
	var/visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	///Whether the organ is aroused, matters for sprites, use AROUSAL_CANT, AROUSAL_NONE, AROUSAL_PARTIAL or AROUSAL_FULL
	var/aroused = AROUSAL_NONE
	///Whether the organ is supposed to use a skintoned variant of the sprite
	var/uses_skintones

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/get_sprite_size_string()
	return 0

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/update_sprite_suffix()
	sprite_suffix = "[get_sprite_size_string()]"

/obj/item/organ/genital/proc/get_description_string(datum/sprite_accessory/genital/gas)
	return "You see genitals"

/obj/item/organ/genital/proc/update_genital_icon_state()
	return

/obj/item/organ/genital/proc/set_size(size)
	genital_size = size
	update_sprite_suffix()

/obj/item/organ/genital/Initialize()
	. = ..()
	update_sprite_suffix()

/obj/item/organ/genital/Remove(mob/living/carbon/M, special = FALSE)
	. = ..()
	update_genital_icon_state()

/obj/item/organ/genital/build_from_dna(datum/dna/DNA, associated_key)
	..()
	var/datum/sprite_accessory/genital/SA = GLOB.sprite_accessories[associated_key][DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME]]
	genital_name = SA.name
	genital_type = SA.icon_state
	if(DNA.features["uses_skintones"])
		uses_skintones = SA.uses_skintones
	update_sprite_suffix()

/obj/item/organ/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'modular_zubbers/modules/customization/icons/organs/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	mutantpart_key = "penis"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	var/girth = 9
	var/sheath = SHEATH_NONE

/obj/item/organ/genital/penis/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = ""
	var/pname = lowertext(genital_name)
	if(sheath != SHEATH_NONE && aroused != AROUSAL_FULL) //Hidden in sheath
		switch(sheath)
			if(SHEATH_NORMAL)
				returned_string = "You see a sheath."
			if(SHEATH_SLIT)
				returned_string = "You see genital slit."
		if(aroused == AROUSAL_PARTIAL)
			returned_string += " There's a [pname] penis poking out of it."
	else
		returned_string = "You see a [pname] penis. You estimate it's [genital_size] inches long, and [girth] inches in circumference."
		switch(aroused)
			if(AROUSAL_NONE)
				returned_string += " It seems flaccid."
			if(AROUSAL_PARTIAL)
				returned_string += " It's partically erect."
			if(AROUSAL_FULL)
				returned_string += " It's fully erect."
	return returned_string

/obj/item/organ/genital/penis/update_genital_icon_state()
	var/size_affix
	var/measured_size = FLOOR(genital_size,1)
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 10)
			size_affix = "1"
		if(11 to 15)
			size_affix = "2"
		if(16 to 24)
			size_affix = "3"
		else
			size_affix = "4"
	var/passed_string = "penis_[genital_type]_[size_affix]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/penis/get_sprite_size_string()
	if(aroused != AROUSAL_FULL && sheath != SHEATH_NONE) //Sheath time!
		var/poking_out = 0
		if(aroused == AROUSAL_PARTIAL)
			poking_out = 1
		return "[lowertext(sheath)]_[poking_out]"

	var/size_affix
	var/measured_size = FLOOR(genital_size,1)
	var/is_erect = 0
	if(aroused == AROUSAL_FULL)
		is_erect = 1
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 10)
			size_affix = "1"
		if(11 to 15)
			size_affix = "2"
		if(16 to 24)
			size_affix = "3"
		else
			size_affix = "4"
	var/passed_string = "[genital_type]_[size_affix]_[is_erect]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/genital/penis/build_from_dna(datum/dna/DNA, associated_key)
	..()
	girth = DNA.features["penis_girth"]
	var/datum/sprite_accessory/genital/penis/PS = GLOB.sprite_accessories[associated_key][DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME]]
	if(PS.can_have_sheath)
		sheath = DNA.features["penis_sheath"]
	set_size(DNA.features["penis_size"])

/obj/item/organ/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'modular_zubbers/modules/customization/icons/organs/genitals/testicles.dmi'
	mutantpart_key = "testicles"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	aroused = AROUSAL_CANT

/obj/item/organ/genital/testicles/update_genital_icon_state()
	var/measured_size = clamp(genital_size, 1, 3)
	var/passed_string = "testicles_[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/testicles/get_description_string(datum/sprite_accessory/genital/gas)
	if(gas.type == /datum/sprite_accessory/genital/testicles/internal)
		return null
	return "You see a pair of testicles, they look [lowertext(balls_size_to_description(genital_size))]."

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	..()
	set_size(DNA.features["balls_size"])

/obj/item/organ/genital/testicles/get_sprite_size_string()
	var/measured_size = FLOOR(genital_size,1)
	measured_size = clamp(measured_size, 0, 3)
	var/passed_string = "[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/genital/vagina
	name = "vagina"
	icon = 'modular_zubbers/modules/customization/icons/organs/genitals/vagina.dmi'
	icon_state = "vagina"
	mutantpart_key = "vagina"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA

/obj/item/organ/genital/vagina/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [lowertext(genital_name)] vagina."
	switch(aroused)
		if(AROUSAL_NONE)
			returned_string += " It seems dry."
		if(AROUSAL_PARTIAL)
			returned_string += " It's glistening with arousal."
		if(AROUSAL_FULL)
			returned_string += " It's bright and dripping with arousal."
	return returned_string

/obj/item/organ/genital/vagina/get_sprite_size_string()
	var/is_dripping = 0
	if(aroused == AROUSAL_FULL)
		is_dripping = 1
	return "[genital_type]_[is_dripping]"

/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'modular_zubbers/modules/customization/icons/organs/genitals/breasts.dmi'
	genital_type = "pair"
	mutantpart_key = "penis"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	var/lactates = FALSE

/obj/item/organ/genital/breasts/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [lowertext(genital_name)] of breasts."
	var/size_description
	var/translation = breasts_size_to_cup(genital_size)
	switch(translation)
		if("Flatchested")
			size_description = " They are small and flat, however."
		if("beyond measurement")
			size_description = " Their size is enormous, you estimate they're around [genital_size] inches in diameter."
		else
			size_description = " You estimate they are [translation]-cups."
	returned_string += size_description
	if(aroused == AROUSAL_FULL)
		if(lactates)
			returned_string += " The nipples seem hard, perky and are leaking milk."
		else
			returned_string += " Their nipples look hard and perky."
	return returned_string

/obj/item/organ/genital/breasts/update_genital_icon_state()
	var/max_size = 5
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "breasts_pair_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/genital/breasts/get_sprite_size_string()
	var/max_size = 5
	if(genital_type == "pair")
		max_size = 16
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "[genital_type]_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	..()
	lactates = DNA.features["breasts_lactation"]
	set_size(DNA.features["breasts_size"])

/proc/breasts_size_to_cup(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.breasts_size_translation["[number]"]
	if(!returned)
		returned = "beyond measurement"
	return returned

/proc/breasts_cup_to_size(cup)
	for(var/key in GLOB.breasts_size_translation)
		if(GLOB.breasts_size_translation[key] == cup)
			return text2num(key)
	return 0

/proc/balls_size_to_description(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.balls_size_translation["[number]"]
	if(!returned)
		returned = "beyond measurement"
	return returned

/proc/balls_description_to_size(cup)
	for(var/key in GLOB.balls_size_translation)
		if(GLOB.balls_size_translation[key] == cup)
			return text2num(key)
	return 0

/mob/living/carbon/human/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Allows you to toggle which genitals should show through clothes or not."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle genitals visibility right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		if(!G.visibility_preference == GENITAL_SKIP_VISIBILITY)
			genital_list += G
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to expose/hide", "Expose/Hide genitals") as null|anything in genital_list
	if(picked_organ && (picked_organ in internal_organs))
		var/list/gen_vis_trans = list("Never show" = GENITAL_NEVER_SHOW,
												"Hidden by clothes" = GENITAL_HIDDEN_BY_CLOTHES,
												"Always show" = GENITAL_ALWAYS_SHOW
												)
		var/picked_visibility = input(src, "Choose visibility setting", "Expose/Hide genitals") as null|anything in gen_vis_trans
		if(picked_visibility && picked_organ && (picked_organ in internal_organs))
			picked_organ.visibility_preference = gen_vis_trans[picked_visibility]
			update_body()
	return

/mob/living/carbon/human/verb/toggle_arousal()
	set category = "IC"
	set name = "Toggle Arousal"
	set desc = "Allows you to toggle how aroused your private parts are."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle arousal right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		if(!G.aroused == AROUSAL_CANT)
			genital_list += G
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to change arousal", "Expose/Hide genitals") as null|anything in genital_list
	if(picked_organ && (picked_organ in internal_organs))
		var/list/gen_arous_trans = list("Not aroused" = AROUSAL_NONE,
												"Partly aroused" = AROUSAL_PARTIAL,
												"Very aroused" = AROUSAL_FULL
												)
		var/picked_arousal = input(src, "Choose arousal", "Toggle Arousal") as null|anything in gen_arous_trans
		if(picked_arousal && picked_organ && (picked_organ in internal_organs))
			picked_organ.aroused = gen_arous_trans[picked_arousal]
			picked_organ.update_sprite_suffix()
			update_body()
	return
