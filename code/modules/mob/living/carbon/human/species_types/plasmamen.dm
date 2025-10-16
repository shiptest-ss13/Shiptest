/datum/species/plasmaman
	name = "\improper Phorid"
	id = SPECIES_PLASMAMAN
	meat = /obj/item/stack/sheet/mineral/plasma
	species_traits = list(NOBLOOD, NOTRANSSTING, HAS_BONE)
	// plasmemes get hard to wound since they only need a severe bone wound to dismember, but unlike skellies, they can't pop their bones back into place
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RADIMMUNE,TRAIT_GENELESS,TRAIT_NOHUNGER,TRAIT_ALWAYS_CLEAN, TRAIT_HARDLY_WOUNDED)
	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	mutantlungs = /obj/item/organ/lungs/plasmaman
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/plasmaman
	mutantstomach = /obj/item/organ/stomach/plasmaman
	heatmod = 1.5
	breathid = "tox"
	damage_overlay_type = ""//let's not show bloody wounds or burns over bones.
	var/internal_fire = FALSE //If the bones themselves are burning clothes won't help you much
	disliked_food = FRUIT
	liked_food = VEGETABLES | DAIRY
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	outfit_important_for_life = /datum/outfit/plasmaman
	species_language_holder = /datum/language_holder/skeleton
	loreblurb = "Technically a disability rather than a species, Phorids (known far more commonly as plasmamen) are a loose grouping of people fallen victim to anomalous plasma-related effects that convert tough biological matter into inorganic, biology-mimicking plasma structures. Phorids often live their lives dependent on larger organizations due to their oxygen-incompatible physiology."

	species_chest = /obj/item/bodypart/chest/plasmaman
	species_head = /obj/item/bodypart/head/plasmaman
	species_l_arm = /obj/item/bodypart/l_arm/plasmaman
	species_r_arm = /obj/item/bodypart/r_arm/plasmaman
	species_l_leg = /obj/item/bodypart/leg/left/plasmaman
	species_r_leg = /obj/item/bodypart/leg/right/plasmaman

	// Body temperature for Plasmen is much lower human as they can handle colder environments
	bodytemp_normal = (HUMAN_BODYTEMP_NORMAL - 40)
	// The minimum amount they stabilize per tick is reduced making hot areas harder to deal with
	bodytemp_autorecovery_min = 2
	// They are hurt at hot temps faster as it is harder to hold their form
	bodytemp_heat_damage_limit = (HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT - 20) // about 40C
	// This effects how fast body temp stabilizes, also if cold resit is lost on the mob
	bodytemp_cold_damage_limit = (HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 50) // about -50c
	ass_image = 'icons/ass/assplasma.png'

/datum/species/plasmaman/spec_life(mob/living/carbon/human/H)
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
						H.visible_message(span_danger("[H]'s body reacts with the atmosphere and bursts into flames!"),span_userdanger("Your body reacts with the atmosphere and bursts into flame!"))
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

/datum/species/plasmaman/handle_fire(mob/living/carbon/human/H, no_protection)
	if(internal_fire)
		no_protection = TRUE
	. = ..()

/datum/species/plasmaman/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/current_job = J.name
	var/datum/outfit/plasmaman/O = new /datum/outfit/plasmaman
	switch(current_job)
		if("Chaplain")
			O = new /datum/outfit/plasmaman/chaplain

		if("Curator")
			O = new /datum/outfit/plasmaman/curator

		if("Janitor")
			O = new /datum/outfit/plasmaman/janitor

		if("Botanist")
			O = new /datum/outfit/plasmaman/botany

		if("Bartender", "Lawyer")
			O = new /datum/outfit/plasmaman/bar

		if("Cook")
			O = new /datum/outfit/plasmaman/chef

		if("Prisoner")
			O = new /datum/outfit/plasmaman/prisoner

		if("Security Officer")
			O = new /datum/outfit/plasmaman/security

		if("Brig Physician")
			O = new /datum/outfit/plasmaman/secmed

		if("Detective")
			O = new /datum/outfit/plasmaman/detective

		if("Warden")
			O = new /datum/outfit/plasmaman/warden

		if("Cargo Technician", "Quartermaster")
			O = new /datum/outfit/plasmaman/cargo

		if("Shaft Miner")
			O = new /datum/outfit/plasmaman/mining

		if("Medical Doctor")
			O = new /datum/outfit/plasmaman/medical

		if("Paramedic")
			O = new /datum/outfit/plasmaman/paramedic

		if("Chemist")
			O = new /datum/outfit/plasmaman/chemist

		if("Geneticist")
			O = new /datum/outfit/plasmaman/genetics

		if("Roboticist")
			O = new /datum/outfit/plasmaman/robotics

		if("Virologist")
			O = new /datum/outfit/plasmaman/viro

		if("Scientist")
			O = new /datum/outfit/plasmaman/science

		if("Station Engineer")
			O = new /datum/outfit/plasmaman/engineering

		if("Atmospheric Technician")
			O = new /datum/outfit/plasmaman/atmospherics

		if("Captain")
			O = new /datum/outfit/plasmaman/command

		if("Chief Engineer")
			O = new /datum/outfit/plasmaman/ce

		if("Chief Medical Officer")
			O = new /datum/outfit/plasmaman/cmo

		if("Head of Security")
			O = new /datum/outfit/plasmaman/hos

		if("Research Director")
			O = new /datum/outfit/plasmaman/rd

		if("Head of Personnel")
			O = new /datum/outfit/plasmaman/hop

		if("SolGov Representative") //WS edit sgr
			O = new /datum/outfit/plasmaman/solgov

	var/holder		//WS Edit Begin - Plasma skirtsuit prefs
	switch(H.jumpsuit_style)
		if(PREF_SKIRT)
			holder = "[O.uniform]/skirt"
		if(PREF_GREYSUIT)
			O.head = /obj/item/clothing/head/helmet/space/plasmaman
			holder = "/obj/item/clothing/under/plasmaman"
		else
			holder = "[O.uniform]"

	if(text2path(holder))
		O.uniform = text2path(holder)		//WS Edit End

	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)
	return 0

/datum/species/plasmaman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_plasmaman_name()

	var/randname = plasmaman_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/plasmaman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	. = ..()
	if(istype(chem, /datum/reagent/toxin/plasma))
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate)
		for(var/i in H.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_xadone(4) // plasmamen use plasma to reform their bones or whatever
		return TRUE

	return ..()
