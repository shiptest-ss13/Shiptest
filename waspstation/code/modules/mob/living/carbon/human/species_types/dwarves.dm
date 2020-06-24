
GLOBAL_LIST_INIT(dwarf_first, world.file2list("strings/names/dwarf_first.txt")) //Textfiles with first
GLOBAL_LIST_INIT(dwarf_last, world.file2list("strings/names/dwarf_last.txt")) //textfiles with last

/datum/species/dwarf //not to be confused with the genetic manlets
	name = "Dwarf"
	id = "dwarf" //Also called Homo sapiens pumilionis
	default_color = "FFFFFF"
	default_features = list("mcolor" = "FFF", "wings" = "None")
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	inherent_traits = list(TRAIT_DWARF,TRAIT_SNOB,TRAIT_QUICK_CARRY)
	limbs_id = "human"
	use_skintones = 1
	armor = 15 //True dwarves are a bit sturdier than humans
	speedmod = 0.5 //They are also slower
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
	loreblurb = "A species of squat, sturdy creatures drenched in facial hair with a fondness for drink and industry.\
	 They superficially look like short humans, but they have engorged livers, thick skin, and a specialized gall bladder\
	 that processes alcohol into vital nutrients that the dwarf cannot live without, making them compulsory drunkards."

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
	desc = "A stout, sturdy slab of muscle and tastebuds well-suited to enjoying strong alcohol and spewing litanies of scathing insults and threats at elves."
	say_mod = "bellows"
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
	desc = "A dwarven liver, theres something magical about seeing one of these up close."
	alcohol_tolerance = 0 //dwarves really shouldn't be dying to alcohol.
	toxTolerance = 5 //Shrugs off 5 units of toxins damage.
	maxHealth = 150 //More health than the average liver, as you aren't going to be replacing this.
	//If it does need replaced with a standard human liver, prepare for hell.

//alcohol gland
/obj/item/organ/dwarfgland
	name = "dwarf alcohol gland"
	icon_state = "plasma" //Yes this is a actual icon in icons/obj/surgery.dmi
	desc = "A genetically engineered gland which is hopefully a step forward for humanity."
	w_class = WEIGHT_CLASS_NORMAL
	var/stored_alcohol = 250 //They start with 250 units, that ticks down and eventaully bad effects occur
	var/max_alcohol = 500 //Max they can attain, easier than you think to OD on alcohol.
	var/heal_rate = 0.5 //The rate they heal damages over 400 alcohol stored. Default is 0.5 so we times 3 since 3 seconds.
	var/alcohol_rate = 0.25 //The rate the alcohol ticks down per each iteration of dwarf_eth_ticker completing.
	//These count in on_life ticks which should be 2 seconds per every increment of 1 in a perfect world.
	var/dwarf_eth_ticker = 0 //Currently set =< 1, that means this will fire the proc around every 2 seconds
	var/last_alcohol_spam

/obj/item/organ/dwarfgland/on_life() //Primary loop to hook into to start delayed loops for other loops..
	. = ..()
	if(owner && owner.stat != DEAD)
		dwarf_eth_ticker++
		if(dwarf_eth_ticker >= 1) //Alcohol reagent check should be around 2 seconds, since a tick is around 2 seconds.
			dwarf_eth_cycle()
			dwarf_eth_ticker = 0

//Handles the dwarf alcohol cycle tied to on_life, it ticks in dwarf_cycle_ticker.
/obj/item/organ/dwarfgland/proc/dwarf_eth_cycle()
	//BOOZE POWER
	var/init_stored_alcohol = stored_alcohol
	for(var/datum/reagent/R in owner.reagents.reagent_list)
		if(istype(R, /datum/reagent/consumable/ethanol))
			var/datum/reagent/consumable/ethanol/E = R
			stored_alcohol = clamp(stored_alcohol + E.boozepwr / 50, 0, max_alcohol)
	var/heal_amt = heal_rate
	stored_alcohol -= alcohol_rate //Subtracts alcohol_Rate from stored alcohol so EX: 250 - 0.25 per each loop that occurs.
	if(stored_alcohol > 400) //If they are over 400 they start regenerating
		owner.adjustBruteLoss(-heal_amt) //But its alcohol, there will be other issues here.
		owner.adjustFireLoss(-heal_amt) //Unless they drink casually all the time.
		owner.adjustOxyLoss(-heal_amt)
		owner.adjustCloneLoss(-heal_amt) //Also they will probably get brain damage if thats a thing here.
	if(init_stored_alcohol + 0.5 < stored_alcohol) //recovering stored alcohol at a steady rate of +0.75, no spam.
		return
	switch(stored_alcohol)
		if(0 to 24)
			if(last_alcohol_spam + 8 SECONDS < world.time)
				to_chat(owner, "<span class='userdanger'>DAMNATION INCARNATE, WHY AM I CURSED WITH THIS DRY-SPELL? I MUST DRINK.</span>")
				last_alcohol_spam = world.time
			owner.adjustToxLoss(10)
		if(25 to 50)
			if(last_alcohol_spam + 20 SECONDS < world.time)
				to_chat(owner, "<span class='danger'>Oh DAMN, I need some brew!</span>")
				last_alcohol_spam = world.time
		if(51 to 75)
			if(last_alcohol_spam + 35 SECONDS < world.time)
				to_chat(owner, "<span class='warning'>Your body aches, you need to get ahold of some booze...</span>")
				last_alcohol_spam = world.time
		if(76 to 100)
			if(last_alcohol_spam + 40 SECONDS < world.time)
				to_chat(owner, "<span class='notice'>A pint of anything would really hit the spot right now.</span>")
				last_alcohol_spam = world.time
		if(101 to 150)
			if(last_alcohol_spam + 50 SECONDS < world.time)
				to_chat(owner, "<span class='notice'>You feel like you could use a good brew.</span>")
				last_alcohol_spam = world.time
