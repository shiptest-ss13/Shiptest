/datum/species/squid
	// Cephalopod humanoids with squid-like features
	name = "Yuggolith"
	id = "squid"
	default_color = "#268074"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_BONES)
	inherent_traits = list(TRAIT_NOSLIPALL)
	mutant_bodyparts = list("squid_face")
	default_features = list("mcolor" = "189", "squid_face" = "Squidward")
	coldmod = 0.6
	heatmod = 1.2
	burnmod = 1.4
	speedmod = 0.55
	var/speedmod_grav = 0.55
	var/speedmod_nograv = 0
	punchdamagehigh = 8 //Tentacles make for weak noodle arms
	punchstunthreshold = 6 //Good for smacking down though
	attack_verb = "slap"
	attack_sound = 'sound/weapons/slap.ogg'
	miss_sound = 'sound/weapons/punchmiss.ogg'
	special_step_sounds = list('whitesands/sound/effects/footstep/squid1.ogg', 'whitesands/sound/effects/footstep/squid2.ogg', 'whitesands/sound/effects/footstep/squid3.ogg')
	disliked_food = JUNKFOOD
	liked_food = VEGETABLES | MEAT
	toxic_food = FRIED
	mutanttongue = /obj/item/organ/tongue/squid
	species_language_holder = /datum/language_holder/squid
	swimming_component = /datum/component/swimming/squid //shiptest
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/squid
	exotic_bloodtype = "S"
	no_equip = list(ITEM_SLOT_FEET)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	loreblurb = "A race of squid-like amphibians with an odd appearance. \
	They posses the ability to change their pigmentation at will, often leading to confusion. \
	It's frequently rumored that they eat human grey matter. This is definitely, absolutely, most certainly not in any way at all true."

/datum/species/squid/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_squid_name()

	var/randname = squid_name()

	return randname

/datum/species/squid/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	var/datum/action/innate/change_color/S = new
	var/datum/action/cooldown/spit_ink/I = new
	S.Grant(H)
	I.Grant(H)

/datum/species/squid/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	fixed_mut_color = rgb(128,128,128)
	H.update_body()
	var/datum/action/innate/change_color/S = locate(/datum/action/innate/change_color) in H.actions
	S?.Remove(H)

/datum/action/innate/change_color
	name = "Change Color"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "squid_color"

/datum/action/innate/change_color/Activate()
	active = TRUE //Prevent promptspam
	var/mob/living/carbon/human/H = owner
	var/color_choice = input(usr, "What color will you change to?", "Color Change") as null | color
	if (color_choice)
		var/temp_hsv = RGBtoHSV(color_choice)
		if (ReadHSV(temp_hsv)[3] >= ReadHSV("#7f7f7f")[3])
			H.dna.species.fixed_mut_color = sanitize_hexcolor(color_choice)
			H.update_body()
		else
			to_chat(usr, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")
	active = FALSE

/datum/action/innate/change_color/IsAvailable()
	if(active)
		return FALSE
	return ..()

/datum/action/cooldown/spit_ink
	name = "Spit Ink"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_IMMOBILE
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "squid_ink"
	cooldown_time = 60
	var/ink_cost = 60

/datum/action/cooldown/spit_ink/Trigger()
	var/mob/living/carbon/C = owner
	var/turf/T = get_turf(C)
	if(!T)
		to_chat(C, "<span class='warning'>There's no room to spill ink here!</span>")
		return
	var/obj/effect/decal/cleanable/squid_ink/I = locate() in T
	if(I)
		to_chat(C, "<span class='warning'>There's already a puddle of ink here!</span>")
		return
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (C.nutrition >= nutrition_threshold)
		C.adjust_nutrition(-ink_cost)
		playsound(C, 'sound/effects/splat.ogg', 50, 1)
		new /obj/effect/decal/cleanable/squid_ink(T, C)
		C.visible_message("<span class='danger'>[C.name] sprays a puddle of slippery ink onto the floor!</span>", "<i>You spray ink all over the floor!</i>")
	else
		to_chat(C, "<span class='warning'>You don't have enough neutrients to create ink, you need to eat!</span>")
		return

// Zero gravity movement
/datum/species/squid/spec_life(mob/living/carbon/human/H)
	var/area/A = get_area(H)
	speedmod = A.has_gravity ? speedmod_grav : speedmod_nograv
	..()

/datum/species/squid/negates_gravity(mob/living/carbon/human/H)
	if(H.movement_type & !isspaceturf(H.loc))
		return TRUE
