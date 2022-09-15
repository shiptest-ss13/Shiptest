
GLOBAL_LIST_INIT(dwarf_first, world.file2list("strings/names/dwarf_first.txt")) //Textfiles with first
GLOBAL_LIST_INIT(dwarf_last, world.file2list("strings/names/dwarf_last.txt")) //textfiles with last

/datum/species/dwarf //not to be confused with the genetic manlets
	name = "Dwarf"
	id = "dwarf" //Also called Homo sapiens pumilionis
	default_color = "FFFFFF"
	default_features = list("mcolor" = "FFF", "wings" = "None", "body_size" = "Normal")
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	inherent_traits = list(TRAIT_DWARF,TRAIT_SNOB,TRAIT_QUICK_CARRY)
	use_skintones = 1
	armor = 15 //True dwarves are a bit sturdier than humans
	speedmod = 0.6 //They are also slower
	staminamod = 1.5//dwarves have a low center of mass and a high relative body weight. They fall hard.
	stunmod = 1.35//35% longer stuns.
	punchdamagelow = 5
	punchdamagehigh = 15 //and a bit stronger
	punchstunthreshold = 10
	damage_overlay_type = "human"
	skinned_type = /obj/item/stack/sheet/animalhide/human
	liked_food = ALCOHOL | MEAT | DAIRY //Dwarves like alcohol, meat, and dairy products.
	disliked_food = JUNKFOOD | FRIED //Dwarves hate foods that have no nutrition other than alcohol.
	mutant_organs = list(/obj/item/organ/dwarfgland) //Dwarven alcohol gland, literal gland warrior.
	mutantliver = /obj/item/organ/liver/dwarf //Dwarven super liver (Otherwise they r doomed)
	mutanttongue= /obj/item/organ/tongue/dwarf //A workaround for the language issues I was having
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/dwarf
	loreblurb = {"Essentially shorter, squatter humans, dwarves are one of the earliest divergent genelines, and one of the most unique in function and form. Specialized for prolonged isolation in space and the consumption of ethanols, they have developed into a unique, insular culture that values collective effort and contribution to society above all else."}

/mob/living/carbon/human/species/dwarf //species admin spawn path
	race = /datum/species/dwarf //and the race the path is set to.

/datum/species/dwarf/check_roundstart_eligible()
	return TRUE

/datum/species/dwarf/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	var/mob/living/carbon/human/H = C
	H.dna.add_mutation(DORFISM, MUT_OTHER)

/datum/species/dwarf/on_species_loss(mob/living/carbon/H, datum/species/new_species)
	. = ..()
	H.dna.remove_mutation(DORFISM)

//Dwarf Name stuff
/proc/dwarf_name() //hello caller: my name is urist mcuristurister
	return "[pick(GLOB.dwarf_first)] [pick(GLOB.dwarf_last)]"

/datum/species/dwarf/random_name(gender,unique,lastname)
	return dwarf_name() //hello, ill return the value from dwarf_name proc to you when called.

/obj/item/organ/tongue/dwarf
	name = "squat tongue"
	desc = "A stout, sturdy slab of muscle and tastebuds well-suited to enjoying strong alcohol and arguing about geology."
	initial_language_holder = /datum/language_holder/dwarf
	var/static/list/languages_possible_dwarf = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/terrum,
		/datum/language/sylvan,
		/datum/language/dwarf
	))

/obj/item/organ/tongue/dwarf/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_dwarf

//This mostly exists because my testdwarf's liver died while trying to also not die due to no alcohol.
/obj/item/organ/liver/dwarf
	name = "dwarf liver"
	icon_state = "liver"
	desc = "A dwarven liver, containing several secondary lobes designed to store alchohol and process it into usable forms."
	alcohol_tolerance = 0 //dwarves really shouldn't be dying to alcohol.
	toxTolerance = 5 //Shrugs off 5 units of toxins damage.
	maxHealth = 150 //More health than the average liver, as you aren't going to be replacing this.
	//If it does need replaced with a standard human liver, prepare for hell.

//alcohol gland.
/obj/item/organ/dwarfgland
	name = "ethanovoric glands"
	icon_state = "plasma" //Yes this is a actual icon in icons/obj/surgery.dmi
	desc = "A complex series of supportive glands, webbed around the liver and circulatory tract like a harness. They process alchohol directly into forms that the body can metabolize as cellular fuel."
	w_class = WEIGHT_CLASS_NORMAL
	var/stored_alcohol = 250 //They start with 250 units, that ticks down and eventaully bad effects occur
	var/max_alcohol = 500 //Max they can attain, easier than you think to OD on alcohol.
	var/heal_rate = 0.20 //The rate they heal damages over 350 alcohol stored.
	var/alcohol_rate = 0.20 //The rate the alcohol ticks down per each iteration of dwarf_eth_ticker completing.
	//These count in on_life ticks which should be 2 seconds per every increment of 1 in a perfect world.
	var/dwarf_eth_ticker = 0 //Currently set =< 1, that means this will fire the proc around every 2 seconds
	var/last_alcohol_spam

/obj/item/organ/dwarfgland/on_life() //Primary loop to hook into to start delayed loops for other loops..
	. = ..()
	if(owner && owner.stat != DEAD)
		if(!owner.client)
			return
		dwarf_eth_ticker++
		if(dwarf_eth_ticker >= 1) //Alcohol reagent check should be around 2 seconds, since a tick is around 2 seconds.
			dwarf_eth_cycle()
			dwarf_eth_ticker = 0

//Handles the dwarf alcohol cycle tied to on_life, it ticks in dwarf_cycle_ticker.
/obj/item/organ/dwarfgland/proc/dwarf_eth_cycle()
	//BOOZE POWER
	var/init_stored_alcohol = stored_alcohol
	var/heal_amt = heal_rate
	for(var/datum/reagent/R in owner.reagents.reagent_list)
		if(istype(R, /datum/reagent/consumable/ethanol))
			var/datum/reagent/consumable/ethanol/E = R
			stored_alcohol = clamp(stored_alcohol + E.boozepwr / 50, 0, max_alcohol)
			var/boozelvl = clamp(E.quality, 0.50, 5)//0 quality has half effect instead of nothing
			if(stored_alcohol >= 400)//alchohol reagents amplify healing and temp gain, for risk-reward that punishes chemstacking in larger amounts.
				owner.adjustBruteLoss(-heal_amt * boozelvl)
				owner.adjustFireLoss(-heal_amt * boozelvl)
				owner.adjustToxLoss(-heal_amt * boozelvl)
				owner.adjustOxyLoss((-heal_amt * boozelvl) / 2)
				owner.adjustCloneLoss((-heal_amt * boozelvl) / 15)
				owner.adjust_bodytemperature(6 / clamp(boozelvl, 1, 6))
	stored_alcohol -= alcohol_rate //Subtracts alcohol_Rate from stored alcohol so EX: 250 - 0.25 per each loop that occurs.
	if(stored_alcohol > 200)
		if(owner.nutrition < 300)
			owner.nutrition += heal_amt
	if(stored_alcohol > 400) //If they are over 400 they enter a frenzy
		owner.adjustBruteLoss(-heal_amt)
		owner.adjustFireLoss(-heal_amt)
		owner.adjustToxLoss(-heal_amt)
		owner.adjustOxyLoss(-heal_amt / 2)
		owner.adjustCloneLoss(-heal_amt / 15)
		owner.throw_alert("overdorf", /atom/movable/screen/alert/overdorf)
		switch(owner.bodytemperature)
			if(-300 to 400)
				if(last_alcohol_spam + 30 SECONDS < world.time)
					to_chat(owner, pick("<span class='notice'>Your blood is racing.</span>", "<span class='notice'>You're past the limit.</span>", "<span class='notice'>You feel alive!</span>"))
					last_alcohol_spam = world.time
				alcohol_rate = 0.65
				owner.adjust_bodytemperature(2)//to offset chilling effects slightly
			if(401 to 700)//you're going too far! Slow down there, laddie!
				owner.adjustFireLoss(2, 0)
				owner.Jitter(5)
				alcohol_rate = 0.65
				if(last_alcohol_spam + 30 SECONDS < world.time)
					to_chat(owner, pick("<span class='warning'>You can't stop sweating.</span>", "<span class='warning'>Your muscles are aching.</span>", "<span class='warning'>You can feel your heart pounding like a pickaxe.</span>"))
					last_alcohol_spam = world.time
			if(701 to 1200)//burning like a bat out of hell!
				owner.adjustFireLoss(3.5, 0)
				owner.Jitter(5)
				alcohol_rate = 0.85
				if(last_alcohol_spam + 30 SECONDS < world.time)
					to_chat(owner, pick("<span class='warning'>Your inner world's on fire.</span>", "<span class='warning'>Your heart's pounding out of your chest!</span>", "<span class='warning'>Your body can't take any more!.</span>"))
					last_alcohol_spam = world.time
			if(1201 to INFINITY)//so essentialy, yer fucked.
				owner.adjustFireLoss(6.5, 0)
				owner.Jitter(5)
				owner.blur_eyes(5)
				alcohol_rate = 1
				if(last_alcohol_spam + 15 SECONDS < world.time)
					to_chat(owner, pick("<span class='boldwarning'></b>it burns.</span>", "<span class='boldwarnin'>Everything's going dark...</span>", "<span class='boldwarning'>You can't imagine being warmer than this.</span>", "<span class='boldwarning'>Your blood is boiling in your veins.</span>"))
					last_alcohol_spam = world.time
			else
				if(last_alcohol_spam + 30 SECONDS < world.time)
					to_chat(owner, pick("<span class='notice'>Your blood is racing.</span>", "<span class='notice'>You're past the limit.</span>", "<span class='notice'>You feel alive!</span>"))
					last_alcohol_spam = world.time
	else
		owner.clear_alert("overdorf")
		alcohol_rate = 0.20
	if(init_stored_alcohol + 55 < stored_alcohol)
		return
	switch(stored_alcohol)
		if(0 to 24)
			if(last_alcohol_spam + 35 SECONDS < world.time)
				to_chat(owner, "<span class='userdanger'>I can feel myself wasting away! I need a drink!.</span>")
				last_alcohol_spam = world.time
			owner.adjustToxLoss(0.5)
			owner.nutrition -= 5
			owner.throw_alert("dorfcharge", /atom/movable/screen/alert/dorflow, 3)
			if(prob(5))
				owner.blur_eyes(6)
				owner.adjustStaminaLoss(30)
				to_chat(owner, "<span class='warning'>You feel very dizzy.</span>")
		if(25 to 75)
			if(last_alcohol_spam + 70 SECONDS < world.time)
				to_chat(owner, "<span class='warning'>Your body aches, you need to get ahold of some booze...</span>")
				last_alcohol_spam = world.time
			owner.adjustToxLoss(0.1)
			owner.nutrition -= 2
			owner.throw_alert("dorfcharge", /atom/movable/screen/alert/dorflow, 2)
		if(76 to 100)
			if(last_alcohol_spam + 100 SECONDS < world.time)
				to_chat(owner, "<span class='notice'>A pint of anything would really hit the spot right now.</span>")
				last_alcohol_spam = world.time
			owner.throw_alert("dorfcharge", /atom/movable/screen/alert/dorflow, 1)
		if(101 to 200)
			if(last_alcohol_spam + 160 SECONDS < world.time)
				to_chat(owner, "<span class='notice'>You feel like you could use a good brew.</span>")
				last_alcohol_spam = world.time
			owner.throw_alert("dorfcharge", /atom/movable/screen/alert/dorflow, 1)
		else
			owner.clear_alert("dorfcharge")

//the dwarf counter(real)
/datum/species/dwarf/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/medicine/antihol)
		H.adjustToxLoss(0.5, 0)
		H.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.2)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * 4)
		var/obj/item/organ/dwarfgland/dwarfgland = H.getorgan(/obj/item/organ/dwarfgland)
		dwarfgland.stored_alcohol -= 25
		return TRUE

	if(chem.type == /datum/reagent/medicine/leporazine)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * 2)//dwarves process leporazine much faster to reduce overdorf exploitation
		return TRUE
	if(chem.type == /datum/reagent/medicine/pyroxadone)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * 3)//ditto
		return TRUE
	return ..()

