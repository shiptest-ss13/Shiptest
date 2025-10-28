/mob/living/carbon/monkey
	name = "monkey"
	verb_say = "chimpers"
	initial_language_holder = /datum/language_holder/monkey
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_HARM)
	icon = 'icons/mob/monkey.dmi'
	icon_state = null
	gender = NEUTER
	pass_flags = PASSTABLE
	ventcrawler = VENTCRAWLER_NUDE
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	butcher_results = list(/obj/item/food/meat/slab/monkey = 5, /obj/item/stack/sheet/animalhide/monkey = 1)
	type_of_meat = /obj/item/food/meat/slab/monkey
	gib_type = /obj/effect/decal/cleanable/blood/gibs
	unique_name = TRUE
	can_be_shoved_into = TRUE
	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	bodyparts = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/monkey,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/monkey,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/monkey,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/monkey,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/monkey,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/monkey,
		)
	hud_type = /datum/hud/monkey
	melee_damage_lower = 1
	melee_damage_upper = 3
	ai_controller = /datum/ai_controller/monkey
	faction = list("neutral", "monkey")

/mob/living/carbon/monkey/Initialize(mapload, cubespawned=FALSE, mob/spawner)
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	if(unique_name) //used to exclude pun pun
		gender = pick(MALE, FEMALE)
	real_name = name

	//initialize limbs
	create_bodyparts()
	create_internal_organs()

	. = ..()

	if (cubespawned)
		var/cap = CONFIG_GET(number/monkeycap)
		if (LAZYLEN(SSmobs.cubemonkeys) > cap)
			if (spawner)
				to_chat(spawner, span_warning("Bluespace harmonics prevent the spawning of more than [cap] monkeys in this sector at one time!"))
			return INITIALIZE_HINT_QDEL
		SSmobs.cubemonkeys += src

	create_dna(src)
	dna.initialize_dna(random_blood_type())
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_BAREFOOT, 1, -6)
	AddComponent(/datum/component/bloodysoles/feet)

/mob/living/carbon/monkey/Destroy()
	SSmobs.cubemonkeys -= src
	return ..()

/mob/living/carbon/monkey/create_internal_organs()
	internal_organs += new /obj/item/organ/appendix
	internal_organs += new /obj/item/organ/lungs
	internal_organs += new /obj/item/organ/heart
	internal_organs += new /obj/item/organ/brain
	internal_organs += new /obj/item/organ/tongue
	internal_organs += new /obj/item/organ/eyes
	internal_organs += new /obj/item/organ/ears
	internal_organs += new /obj/item/organ/liver
	internal_organs += new /obj/item/organ/stomach
	..()

/mob/living/carbon/monkey/on_reagent_change()
	. = ..()
	var/amount
	if(has_reagent(/datum/reagent/medicine/morphine))
		amount = -1
	if(amount)
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/monkey_reagent_speedmod, TRUE, amount)


/mob/living/carbon/monkey/updatehealth()
	. = ..()
	var/slow = 0
	if(!HAS_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN))
		var/health_deficiency = (maxHealth - health)
		if(health_deficiency >= 45)
			slow += (health_deficiency / 25)
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/monkey_health_speedmod, TRUE, slow)

/mob/living/carbon/monkey/adjust_bodytemperature(amount, min_temp=0, max_temp=INFINITY, use_insulation=FALSE, use_steps=FALSE)
	. = ..()
	var/slow = 0
	if (bodytemperature < 283.222)
		slow += ((283.222 - bodytemperature) / 10) * 1.75
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/monkey_temperature_speedmod, TRUE, slow)

/mob/living/carbon/monkey/get_status_tab_items()
	. = ..()
	. += "Intent: [a_intent]"
	. += "Move Mode: [m_intent]"
	if(client && mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling)
			. += ""
			. += "Chemical Storage: [changeling.chem_charges]/[changeling.chem_storage]"
			. += "Absorbed DNA: [changeling.absorbedcount]"


/mob/living/carbon/monkey/verb/removeinternal()
	set name = "Remove Internals"
	set category = "IC"
	internal = null
	return

/mob/living/carbon/monkey/can_use_guns(obj/item/G)
	if(G.trigger_guard == TRIGGER_GUARD_NONE)
		to_chat(src, span_warning("You are unable to fire this!"))
		return FALSE
	return TRUE

/mob/living/carbon/monkey/handled_by_species(datum/reagent/R) //can metabolize all reagents
	return FALSE

/mob/living/carbon/monkey/canBeHandcuffed()
	if(num_hands < 2)
		return FALSE
	return TRUE

/mob/living/carbon/monkey/assess_threat(judgment_criteria, lasercolor = "", datum/callback/weaponcheck=null)
	if(judgment_criteria & JUDGE_EMAGGED)
		return 10 //Everyone is a criminal!

	var/threatcount = 0

	//Securitrons can't identify monkeys
	if(!(judgment_criteria & JUDGE_IGNOREMONKEYS) && (judgment_criteria & JUDGE_IDCHECK))
		threatcount += 4

	//Lasertag bullshit
	if(lasercolor)
		if(lasercolor == "b")//Lasertag turrets target the opposing team, how great is that? -Sieve
			if(is_holding_item_of_type(/obj/item/gun/energy/laser/redtag))
				threatcount += 4

		if(lasercolor == "r")
			if(is_holding_item_of_type(/obj/item/gun/energy/laser/bluetag))
				threatcount += 4

		return threatcount

	//Check for weapons
	if((judgment_criteria & JUDGE_WEAPONCHECK) && weaponcheck)
		for(var/obj/item/I in held_items) //if they're holding a gun
			if(weaponcheck.Invoke(I))
				threatcount += 4
		if(weaponcheck.Invoke(back)) //if a weapon is present in the back slot
			threatcount += 4 //trigger look_for_perp() since they're nonhuman and very likely hostile

	//mindshield implants imply trustworthyness
	if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
		threatcount -= 1

	return threatcount

/mob/living/carbon/monkey/IsVocal()
	if(!getorganslot(ORGAN_SLOT_LUNGS))
		return 0
	return 1

/mob/living/carbon/monkey/angry

/mob/living/carbon/monkey/angry/Initialize()
	. = ..()
	ai_controller.set_blackboard_key(BB_MONKEY_AGRESSIVE, TRUE)
	if(prob(10))
		var/obj/item/clothing/head/helmet/justice/escape/helmet = new(src)
		equip_to_slot_or_del(helmet,ITEM_SLOT_HEAD)
		helmet.attack_self(src) // todo encapsulate toggle
