/datum/species/jelly
	// Entirely alien beings that seem to be made entirely out of gel. They have three eyes and a skeleton visible within them.
	name = "\improper Jellyperson"
	id = SPECIES_JELLYPERSON
	default_color = "00FF90"
	species_traits = list(MUTCOLORS,NOBLOOD,HAIR,FACEHAIR,HAS_FLESH)
	inherent_traits = list(TRAIT_TOXINLOVER)
	hair_color = "mutcolor"
	hair_alpha = 150
	mutantlungs = /obj/item/organ/lungs/slime
	mutanttongue = /obj/item/organ/tongue/slime
	exotic_blood = /datum/reagent/toxin/slimejelly
	damage_overlay_type = ""
	var/datum/action/innate/regenerate_limbs/regenerate_limbs
	var/datum/action/innate/humanoid_customization/humanoid_customization
	liked_food = MEAT | GORE // Spliced with humans, they still never lost their carnivorous drive
	disliked_food = NONE
	toxic_food = NONE
	coldmod = 6   // = 3x cold damage
	heatmod = 0.5 // = 1/4x heat damage
	burnmod = 0.5 // = 1/2x generic burn damage
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	inherent_factions = list("slime")
	species_language_holder = /datum/language_holder/jelly
	ass_image = 'icons/ass/assslime.png'
	loreblurb = "Slime, itself a slime-mold like organism of unknown origin, is capable of both mutating existing biological organisms into slime, retaining most of the structure and mind of the original, and forming quick-learning gestalts capable of mimicking existing beings, including animals and humanoids. The blood of slimepeople is toxic, and the properties of poisonous and poison-healing substances are inverted for them."

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/jelly,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/jelly,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/jelly,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/jelly,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/jelly,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/jelly,
	)

/datum/species/jelly/on_species_loss(mob/living/carbon/C)
	if(regenerate_limbs)
		regenerate_limbs.Remove(C)
	if(humanoid_customization)
		humanoid_customization.Remove(C)
	..()

/datum/species/jelly/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		regenerate_limbs = new
		regenerate_limbs.Grant(C)
		humanoid_customization = new
		humanoid_customization.Grant(C)

/datum/species/jelly/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD) //can't farm slime jelly from a dead slime/jelly person indefinitely
		return
	if(!H.blood_volume)
		H.blood_volume += 5
		H.adjustBruteLoss(5)
		to_chat(H, span_danger("You feel empty!"))

	if(H.blood_volume < BLOOD_VOLUME_NORMAL)
		if(H.nutrition >= NUTRITION_LEVEL_STARVING)
			H.blood_volume += 3
			H.adjust_nutrition(-2.5)
	if(H.blood_volume < BLOOD_VOLUME_OKAY)
		if(prob(5))
			to_chat(H, span_danger("You feel drained!"))
	if(H.blood_volume < BLOOD_VOLUME_BAD)
		Cannibalize_Body(H)
	if(regenerate_limbs)
		regenerate_limbs.UpdateButtonIcon()

/datum/species/jelly/proc/Cannibalize_Body(mob/living/carbon/human/H)
	var/list/limbs_to_consume = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG) - H.get_missing_limbs()
	var/obj/item/bodypart/consumed_limb
	if(!limbs_to_consume.len)
		H.losebreath++
		return
	if(H.num_legs) //Legs go before arms
		limbs_to_consume -= list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
	consumed_limb = H.get_bodypart(pick(limbs_to_consume))
	consumed_limb.drop_limb()
	to_chat(H, span_userdanger("Your [consumed_limb] is drawn back into your body, unable to maintain its shape!"))
	qdel(consumed_limb)
	H.blood_volume += 20

/datum/species/jelly/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/jelly/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/jelly/can_wag_tail(mob/living/carbon/human/H)
	return ("tail_human" in mutant_bodyparts) || ("waggingtail_human" in mutant_bodyparts)

/datum/species/jelly/is_wagging_tail(mob/living/carbon/human/H)
	return ("waggingtail_human" in mutant_bodyparts)

/datum/species/jelly/start_wagging_tail(mob/living/carbon/human/H)
	if("tail_human" in mutant_bodyparts)
		mutant_bodyparts -= "tail_human"
		mutant_bodyparts |= "waggingtail_human"
	H.update_body()

/datum/species/jelly/stop_wagging_tail(mob/living/carbon/human/H)
	if("waggingtail_human" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_human"
		mutant_bodyparts |= "tail_human"
	H.update_body()

/datum/action/innate/regenerate_limbs
	name = "Regenerate Limbs"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeheal"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/regenerate_limbs/IsAvailable()
	if(..())
		var/mob/living/carbon/human/H = owner
		var/list/limbs_to_heal = H.get_missing_limbs()
		if(limbs_to_heal.len < 1)
			return 0
		if(H.blood_volume >= BLOOD_VOLUME_OKAY+40)
			return 1
		return 0

/datum/action/innate/regenerate_limbs/Activate()
	var/mob/living/carbon/human/H = owner
	var/list/limbs_to_heal = H.get_missing_limbs()
	if(limbs_to_heal.len < 1)
		to_chat(H, span_notice("You feel intact enough as it is."))
		return
	to_chat(H, span_notice("You focus intently on your missing [limbs_to_heal.len >= 2 ? "limbs" : "limb"]..."))
	if(H.blood_volume >= 40*limbs_to_heal.len+BLOOD_VOLUME_OKAY)
		H.regenerate_limbs()
		H.blood_volume -= 40*limbs_to_heal.len
		to_chat(H, span_notice("...and after a moment you finish reforming!"))
		return
	else if(H.blood_volume >= 40)//We can partially heal some limbs
		while(H.blood_volume >= BLOOD_VOLUME_OKAY+40)
			var/healed_limb = pick(limbs_to_heal)
			H.regenerate_limb(healed_limb)
			limbs_to_heal -= healed_limb
			H.blood_volume -= 40
		to_chat(H, span_warning("...but there is not enough of you to fix everything! You must attain more mass to heal completely!"))
		return
	to_chat(H, span_warning("...but there is not enough of you to go around! You must attain more mass to heal!"))

/datum/action/innate/humanoid_customization //oh boy this will be fun to do <-- clueless
	name = "Alter Form"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeheal" //placeholder
	icon_icon = 'icons/mob/actions/actions_slime.dmi' //also placeholder
	background_icon_state = "bg_alien"

/datum/action/innate/humanoid_customization/Activate()
		var/mob/living/carbon/human/H = owner
		H.visible_message("<span class='notice'>[owner] gains a look of concentration while standing perfectly still.")
		change_form()

/datum/action/innate/humanoid_customization/proc/change_form()
	var/mob/living/carbon/human/H = owner
	var/select_alteration = input(owner, "Select what part of your form to alter.", "Form Alteration", "Cancel") in list("Body Color", "Hair Style", "Ears", "Tail") //Select what you want to alter
	switch(select_alteration) //fuck you i like readability
		if("Body Color")
			var/new_color = input(owner, "Select your new color.", "Color Change", "#"+H.dna.features["mcolor"]) as color|null
			if(new_color)
				H.dna.features["mcolor"] = sanitize_hexcolor(new_color)
				H.update_body()
				H.update_hair()

		if("Hair Style")
			//facial hair
			if(H.gender == MALE)
				var/new_style = input(owner, "Select a facial hair style.", "Facial Hair Alterations") as null|anything in GLOB.facial_hairstyles_list
				if(new_style)
					H.facial_hairstyle = new_style
			else
				H.facial_hairstyle = "Shaved" //Female characters can't have beards
			//normal hair
			var/new_style = input(owner, "Select your hair style.", "Hair Style Alterations") as null|anything in GLOB.hairstyles_list
			if(new_style)
				H.hairstyle = new_style
				H.update_hair()
				//Ears
		if("Ears")
			var/selected_ears = input(owner, "Select your desired ears.", "Ear Alteration") in list("None", "Cat") //easily expandable in case we ever have more ears
			if(selected_ears)
				switch(selected_ears)
					if("None")
						H.dna.features["ears"] = "None"
						H.dna.species.mutant_bodyparts -= "ears"
						H.update_body()
					if("Cat")
						H.dna.species.mutant_bodyparts |= "ears"
						H.dna.features["ears"] = "Slimecat"
						H.update_body()
				//Tails
		if("Tail")
			var/selected_tail = input(owner, "Select your desired tail.", "Tail Alteration") in list("None", "Cat") //lizard tails and/or horns to follow eventually
			if(selected_tail)
				switch(selected_tail)
					if("None")
						H.dna.features["tail_human"] = "None"
						H.dna.species.mutant_bodyparts -= "tail_human"
						H.update_body()
					if("Cat")
						H.dna.species.mutant_bodyparts |= "tail_human"
						H.dna.features["tail_human"] = "Slimecat"
						H.update_body()

////////////////////////////////////////////////////////SLIMEPEOPLE///////////////////////////////////////////////////////////////////

//Slime people are able to split like slimes, retaining a single mind that can swap between bodies at will, even after death.

/datum/species/jelly/slime
	name = "Slimeperson"
	id = SPECIES_SLIMEPERSON
	default_color = "00FFFF"
	species_traits = list(MUTCOLORS,HAIR,FACEHAIR,NOBLOOD)
	hair_color = "mutcolor"
	hair_alpha = 150
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN
	var/datum/action/innate/split_body/slime_split
	var/list/mob/living/carbon/bodies
	var/datum/action/innate/swap_body/swap_body

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/slime,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/slime,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/slime,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/slime,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/slime,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/slime,
	)

/datum/species/jelly/slime/on_species_loss(mob/living/carbon/C)
	if(slime_split)
		slime_split.Remove(C)
	if(swap_body)
		swap_body.Remove(C)
	bodies -= C // This means that the other bodies maintain a link
	// so if someone mindswapped into them, they'd still be shared.
	bodies = null
	C.blood_volume = min(C.blood_volume, BLOOD_VOLUME_NORMAL)
	..()

/datum/species/jelly/slime/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		slime_split = new
		slime_split.Grant(C)
		swap_body = new
		swap_body.Grant(C)

		if(!bodies || !bodies.len)
			bodies = list(C)
		else
			bodies |= C

/datum/species/jelly/slime/spec_death(gibbed, mob/living/carbon/human/H)
	if(slime_split)
		if(!H.mind || !H.mind.active)
			return

		var/list/available_bodies = (bodies - H)
		for(var/mob/living/L in available_bodies)
			if(!swap_body.can_swap(L))
				available_bodies -= L

		if(!LAZYLEN(available_bodies))
			return

		swap_body.swap_to_dupe(H.mind, pick(available_bodies))

//If you're cloned you get your body pool back
/datum/species/jelly/slime/copy_properties_from(datum/species/jelly/slime/old_species)
	bodies = old_species.bodies

/datum/species/jelly/slime/spec_life(mob/living/carbon/human/H)
	if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
		if(prob(5))
			to_chat(H, span_notice("You feel very bloated!"))
	else if(H.nutrition >= NUTRITION_LEVEL_WELL_FED)
		H.blood_volume += 3
		H.adjust_nutrition(-2.5)

	..()

/datum/action/innate/split_body
	name = "Split Body"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimesplit"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/split_body/IsAvailable()
	if(..())
		var/mob/living/carbon/human/H = owner
		if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
			return 1
		return 0

/datum/action/innate/split_body/Activate()
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return
	CHECK_DNA_AND_SPECIES(H)
	H.visible_message("<span class='notice'>[owner] gains a look of \
		concentration while standing perfectly still.</span>",
		"<span class='notice'>You focus intently on moving your body while \
		standing perfectly still...</span>")

	H.notransform = TRUE

	if(do_after(owner, delay = 60, target = owner, show_progress = TRUE, timed_action_flags = IGNORE_HELD_ITEM))
		if(H.blood_volume >= BLOOD_VOLUME_SLIME_SPLIT)
			make_dupe()
		else
			to_chat(H, span_warning("...but there is not enough of you to go around! You must attain more mass to split!"))
	else
		to_chat(H, span_warning("...but fail to stand perfectly still!"))

	H.notransform = FALSE

/datum/action/innate/split_body/proc/make_dupe()
	var/mob/living/carbon/human/H = owner
	CHECK_DNA_AND_SPECIES(H)

	var/mob/living/carbon/human/spare = new /mob/living/carbon/human(H.loc)

	spare.underwear = "Nude"
	H.dna.transfer_identity(spare, transfer_SE=1)
	spare.dna.features["mcolor"] = pick("FFFFFF","7F7F7F", "7FFF7F", "7F7FFF", "FF7F7F", "7FFFFF", "FF7FFF", "FFFF7F")
	spare.real_name = spare.dna.real_name
	spare.name = spare.dna.real_name
	spare.updateappearance(mutcolor_update=1)
	spare.domutcheck()
	spare.Move(get_step(H.loc, pick(NORTH,SOUTH,EAST,WEST)))


	var/datum/component/nanites/owner_nanites = H.GetComponent(/datum/component/nanites)
	if(owner_nanites)
		//copying over nanite programs/cloud sync with 50% saturation in host and spare
		owner_nanites.nanite_volume *= 0.5
		spare.AddComponent(/datum/component/nanites, owner_nanites.linked_techweb, owner_nanites.nanite_volume)
		SEND_SIGNAL(spare, COMSIG_NANITE_SYNC, owner_nanites, TRUE, TRUE) //The trues are to copy activation as well

	H.blood_volume *= 0.45
	H.notransform = 0

	var/datum/species/jelly/slime/origin_datum = H.dna.species
	origin_datum.bodies |= spare

	var/datum/species/jelly/slime/spare_datum = spare.dna.species
	spare_datum.bodies = origin_datum.bodies

	H.transfer_trait_datums(spare)
	H.mind.transfer_to(spare)
	spare.visible_message("<span class='warning'>[H] distorts as a new body \
		\"steps out\" of [H.p_them()].</span>",
		"<span class='notice'>...and after a moment of disorentation, \
		you're besides yourself!</span>")


/datum/action/innate/swap_body
	name = "Swap Body"
	check_flags = NONE
	button_icon_state = "slimeswap"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/swap_body/Activate()
	if(!isslimeperson(owner))
		to_chat(owner, span_warning("You are not a slimeperson."))
		Remove(owner)
	else
		ui_interact(owner)

/datum/action/innate/swap_body/ui_host(mob/user)
	return owner

/datum/action/innate/swap_body/ui_state(mob/user)
	return GLOB.not_incapacitated_state

/datum/action/innate/swap_body/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlimeBodySwapper", name)
		ui.open()

/datum/action/innate/swap_body/ui_data(mob/user)
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return

	var/datum/species/jelly/slime/SS = H.dna.species

	var/list/data = list()
	data["bodies"] = list()
	for(var/b in SS.bodies)
		var/mob/living/carbon/human/body = b
		if(!body || QDELETED(body) || !isslimeperson(body))
			SS.bodies -= b
			continue

		var/list/L = list()
		// HTML colors need a # prefix
		L["htmlcolor"] = "#[body.dna.features["mcolor"]]"
		L["area"] = get_area_name(body, TRUE)
		var/stat = "error"
		switch(body.stat)
			if(CONSCIOUS)
				stat = "Conscious"
			if(UNCONSCIOUS)
				stat = "Unconscious"
			if(DEAD)
				stat = "Dead"
		var/occupied
		if(body == H)
			occupied = "owner"
		else if(body.mind && body.mind.active)
			occupied = "stranger"
		else
			occupied = "available"

		L["status"] = stat
		L["exoticblood"] = body.blood_volume
		L["name"] = body.name
		L["ref"] = "[REF(body)]"
		L["occupied"] = occupied
		var/button
		if(occupied == "owner")
			button = "selected"
		else if(occupied == "stranger")
			button = "danger"
		else if(can_swap(body))
			button = null
		else
			button = "disabled"

		L["swap_button_state"] = button
		L["swappable"] = (occupied == "available") && can_swap(body)

		data["bodies"] += list(L)

	return data

/datum/action/innate/swap_body/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(owner))
		return
	if(!H.mind || !H.mind.active)
		return
	switch(action)
		if("swap")
			var/datum/species/jelly/slime/SS = H.dna.species
			var/mob/living/carbon/human/selected = locate(params["ref"]) in SS.bodies
			if(!can_swap(selected))
				return
			SStgui.close_uis(src)
			swap_to_dupe(H.mind, selected)

/datum/action/innate/swap_body/proc/can_swap(mob/living/carbon/human/dupe)
	var/mob/living/carbon/human/H = owner
	if(!isslimeperson(H))
		return FALSE
	var/datum/species/jelly/slime/SS = H.dna.species

	if(QDELETED(dupe)) 					//Is there a body?
		SS.bodies -= dupe
		return FALSE

	if(!isslimeperson(dupe)) 			//Is it a slimeperson?
		SS.bodies -= dupe
		return FALSE

	if(dupe.stat == DEAD) 				//Is it alive?
		return FALSE

	if(dupe.stat != CONSCIOUS) 			//Is it awake?
		return FALSE

	if(dupe.mind && dupe.mind.active) 	//Is it unoccupied?
		return FALSE

	if(!(dupe in SS.bodies))			//Do we actually own it?
		return FALSE

	return TRUE

/datum/action/innate/swap_body/proc/swap_to_dupe(datum/mind/M, mob/living/carbon/human/dupe)
	if(!can_swap(dupe)) //sanity check
		return
	if(M.current.stat == CONSCIOUS)
		M.current.visible_message("<span class='notice'>[M.current] \
			stops moving and starts staring vacantly into space.</span>",
			span_notice("You stop moving this body..."))
	else
		to_chat(M.current, span_notice("You abandon this body..."))
	M.current.transfer_trait_datums(dupe)
	M.transfer_to(dupe)
	dupe.visible_message("<span class='notice'>[dupe] blinks and looks \
		around.</span>",
		span_notice("...and move this one instead."))


///////////////////////////////////LUMINESCENTS//////////////////////////////////////////

//Luminescents are able to consume and use slime extracts, without them decaying.

/datum/species/jelly/luminescent
	name = "Luminescent"
	id = SPECIES_LUMINESCENT
	var/glow_intensity = LUMINESCENT_DEFAULT_GLOW
	var/obj/effect/dummy/luminescent_glow/glow
	examine_limb_id = SPECIES_JELLYPERSON

//Species datums don't normally implement destroy, but JELLIES SUCK ASS OUT OF A STEEL STRAW
/datum/species/jelly/luminescent/Destroy(force)
	QDEL_NULL(glow)
	return ..()


/datum/species/jelly/luminescent/on_species_loss(mob/living/carbon/C)
	..()
	QDEL_NULL(glow)

/datum/species/jelly/luminescent/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	glow = new(C)
	update_glow(C)

/datum/species/jelly/luminescent/proc/update_glow(mob/living/carbon/C, intensity)
	if(intensity)
		glow_intensity = intensity
	glow.set_light_range_power_color(glow_intensity, glow_intensity, C.dna.features["mcolor"])

/obj/effect/dummy/luminescent_glow
	name = "luminescent glow"
	desc = "Tell a coder if you're seeing this."
	icon_state = "nothing"
	light_system = MOVABLE_LIGHT
	light_range = LUMINESCENT_DEFAULT_GLOW
	light_power = 2.5
	light_color = COLOR_WHITE

/obj/effect/dummy/luminescent_glow/Initialize()
	. = ..()
	if(!isliving(loc))
		return INITIALIZE_HINT_QDEL

///////////////////////////////////STARGAZERS//////////////////////////////////////////

//Stargazers are the telepathic branch of jellypeople, able to project psychic messages and to link minds with willing participants.

/datum/species/jelly/stargazer
	name = "Stargazer"
	id = SPECIES_STARGAZER
	var/datum/action/innate/project_thought/project_thought
	var/datum/action/innate/link_minds/link_minds
	var/list/mob/living/linked_mobs = list()
	var/list/datum/action/innate/linked_speech/linked_actions = list()
	var/datum/weakref/slimelink_owner
	var/current_link_id = 0

	examine_limb_id = SPECIES_JELLYPERSON

//Species datums don't normally implement destroy, but JELLIES SUCK ASS OUT OF A STEEL STRAW
/datum/species/jelly/stargazer/Destroy()
	for(var/mob/living/link_to_clear as anything in linked_mobs)
		unlink_mob(link_to_clear)
	linked_mobs.Cut()
	QDEL_NULL(project_thought)
	QDEL_NULL(link_minds)
	slimelink_owner = null
	return ..()

/datum/species/jelly/stargazer/on_species_loss(mob/living/carbon/C)
	..()
	for(var/mob/living/link_to_clear as anything in linked_mobs)
		unlink_mob(link_to_clear)
	if(project_thought)
		QDEL_NULL(project_thought)
	if(link_minds)
		QDEL_NULL(link_minds)
	slimelink_owner = null

/datum/species/jelly/stargazer/spec_death(gibbed, mob/living/carbon/human/H)
	..()
	for(var/mob/living/link_to_clear as anything in linked_mobs)
		unlink_mob(link_to_clear)

/datum/species/jelly/stargazer/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	project_thought = new(src)
	project_thought.Grant(C)
	link_minds = new(src)
	link_minds.Grant(C)
	slimelink_owner = WEAKREF(C)
	link_mob(C)

/datum/species/jelly/stargazer/proc/link_mob(mob/living/M)
	if(QDELETED(M) || M.stat == DEAD)
		return FALSE
	if(HAS_TRAIT(M, TRAIT_MINDSHIELD)) //mindshield implant, no dice
		return FALSE
	if(M.anti_magic_check(FALSE, FALSE, TRUE, 0))
		return FALSE
	if(M in linked_mobs)
		return FALSE
	var/mob/living/carbon/human/owner = slimelink_owner.resolve()
	if(!owner)
		return FALSE
	linked_mobs.Add(M)
	to_chat(M, span_notice("You are now connected to [owner.real_name]'s Slime Link."))
	var/datum/action/innate/linked_speech/action = new(src)
	linked_actions.Add(action)
	action.Grant(M)
	RegisterSignal(M, COMSIG_MOB_DEATH , PROC_REF(unlink_mob))
	RegisterSignal(M, COMSIG_PARENT_QDELETING, PROC_REF(unlink_mob))
	return TRUE

/datum/species/jelly/stargazer/proc/unlink_mob(mob/living/M)
	var/link_id = linked_mobs.Find(M)
	if(!(link_id))
		return
	UnregisterSignal(M, list(COMSIG_MOB_DEATH, COMSIG_PARENT_QDELETING))
	var/datum/action/innate/linked_speech/action = linked_actions[link_id]
	action.Remove(M)
	var/mob/living/carbon/human/owner = slimelink_owner.resolve()
	if(owner)
		to_chat(M, span_notice("You are no longer connected to [owner.real_name]'s Slime Link."))
	linked_mobs -= M
	linked_actions -= action
	qdel(action)

/datum/action/innate/linked_speech
	name = "Slimelink"
	desc = "Send a psychic message to everyone connected to your slime link."
	button_icon_state = "link_speech"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/linked_speech/Activate()
	var/mob/living/carbon/human/H = owner
	if(H.stat == DEAD)
		return
	var/datum/species/jelly/stargazer/species = target
	if(!species || !(H in species.linked_mobs))
		to_chat(H, span_warning("The link seems to have been severed..."))
		Remove(H)
		return

	var/message = sanitize(input("Message:", "Slime Telepathy") as text|null)

	if(!species || !(H in species.linked_mobs))
		to_chat(H, span_warning("The link seems to have been severed..."))
		Remove(H)
		return

	var/mob/living/carbon/human/star_owner = species.slimelink_owner.resolve()

	if(message && star_owner)
		var/msg = "<i><font color=#008CA2>\[[star_owner.real_name]'s Slime Link\] <b>[H]:</b> [message]</font></i>"
		log_directed_talk(H, star_owner, msg, LOG_SAY, "slime link")
		for(var/X in species.linked_mobs)
			var/mob/living/M = X
			to_chat(M, msg)

		for(var/X in GLOB.dead_mob_list)
			var/mob/M = X
			var/link = FOLLOW_LINK(M, H)
			to_chat(M, "[link] [msg]")

/datum/action/innate/project_thought
	name = "Send Thought"
	desc = "Send a private psychic message to someone you can see."
	button_icon_state = "send_mind"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/project_thought/Activate()
	var/mob/living/carbon/human/H = owner
	if(H.stat == DEAD)
		return
	if(!is_species(H, /datum/species/jelly/stargazer))
		return
	CHECK_DNA_AND_SPECIES(H)

	var/list/options = list()
	for(var/mob/living/Ms in oview(H))
		options += Ms
	var/mob/living/M = input("Select who to send your message to:","Send thought to?",null) as null|mob in sortNames(options)
	if(!M)
		return
	if(M.anti_magic_check(FALSE, FALSE, TRUE, 0))
		to_chat(H, span_notice("As you try to communicate with [M], you're suddenly stopped by a vision of a massive tinfoil wall that streches beyond visible range. It seems you've been foiled."))
		return
	var/msg = sanitize(input("Message:", "Telepathy") as text|null)
	if(msg)
		if(M.anti_magic_check(FALSE, FALSE, TRUE, 0))
			to_chat(H, span_notice("As you try to communicate with [M], you're suddenly stopped by a vision of a massive tinfoil wall that streches beyond visible range. It seems you've been foiled."))
			return
		log_directed_talk(H, M, msg, LOG_SAY, "slime telepathy")
		to_chat(M, "[span_notice("You hear an alien voice in your head... ")]<font color=#008CA2>[msg]</font>")
		to_chat(H, span_notice("You telepathically said: \"[msg]\" to [M]"))
		for(var/dead in GLOB.dead_mob_list)
			if(!isobserver(dead))
				continue
			var/follow_link_user = FOLLOW_LINK(dead, H)
			var/follow_link_target = FOLLOW_LINK(dead, M)
			to_chat(dead, "[follow_link_user] [span_name("[H]")] [span_alertalien("Slime Telepathy --> ")] [follow_link_target] [span_name("[M]")] [span_noticealien("[msg]")]")

/datum/action/innate/link_minds
	name = "Link Minds"
	desc = "Link someone's mind to your Slime Link, allowing them to communicate telepathically with other linked minds."
	button_icon_state = "mindlink"
	icon_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/link_minds/Activate()
	var/mob/living/carbon/human/H = owner
	if(!is_species(H, /datum/species/jelly/stargazer))
		return
	CHECK_DNA_AND_SPECIES(H)

	if(!H.pulling || !isliving(H.pulling) || H.grab_state < GRAB_AGGRESSIVE)
		to_chat(H, span_warning("You need to aggressively grab someone to link minds!"))
		return

	var/mob/living/target = H.pulling
	var/datum/species/jelly/stargazer/species = target

	to_chat(H, span_notice("You begin linking [target]'s mind to yours..."))
	to_chat(target, span_warning("You feel a foreign presence within your mind..."))
	if(do_after(H, 60, target = target))
		if(H.pulling != target || H.grab_state < GRAB_AGGRESSIVE)
			return
		if(species.link_mob(target))
			to_chat(H, span_notice("You connect [target]'s mind to your slime link!"))
		else
			to_chat(H, span_warning("You can't seem to link [target]'s mind..."))
			to_chat(target, span_warning("The foreign presence leaves your mind."))
