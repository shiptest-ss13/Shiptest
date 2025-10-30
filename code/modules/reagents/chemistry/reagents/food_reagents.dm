///////////////////////////////////////////////////////////////////
					//Food Reagents
//////////////////////////////////////////////////////////////////


// Part of the food code. Also is where all the food
// 	condiments, additives, and such go.


/datum/reagent/consumable
	name = "Consumable"
	taste_description = "generic food"
	taste_mult = 4
	category = "Food and Drink"
	var/nutriment_factor = 1 * REAGENTS_METABOLISM
	var/quality = 0	//affects mood, typically higher for mixed drinks with more complex recipes

/datum/reagent/consumable/on_mob_life(mob/living/carbon/M)
	current_cycle++
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_nutrition(nutriment_factor)
	holder.remove_reagent(type, metabolization_rate)

/datum/reagent/consumable/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == INGEST)
		if (quality && !HAS_TRAIT(M, TRAIT_AGEUSIA))
			switch(quality)
				if (DRINK_NICE)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "quality_drink", /datum/mood_event/quality_nice)
				if (DRINK_GOOD)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "quality_drink", /datum/mood_event/quality_good)
				if (DRINK_VERYGOOD)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "quality_drink", /datum/mood_event/quality_verygood)
				if (DRINK_FANTASTIC)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "quality_drink", /datum/mood_event/quality_fantastic)
				if (FOOD_AMAZING)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "quality_food", /datum/mood_event/amazingtaste)
	return ..()

/datum/reagent/consumable/nutriment
	name = "Nutriment"
	description = "All the vitamins, minerals, and carbohydrates the body needs in pure form."
	reagent_state = SOLID
	nutriment_factor = 15 * REAGENTS_METABOLISM
	color = "#664330" // rgb: 102, 67, 48

	var/brute_heal = 1
	var/burn_heal = 0

/datum/reagent/consumable/nutriment/on_mob_life(mob/living/carbon/M)
	if(prob(50))
		M.heal_bodypart_damage(brute_heal,burn_heal, 0)
		. = 1
	..()

/datum/reagent/consumable/nutriment/on_new(list/supplied_data)
	// taste data can sometimes be ("salt" = 3, "chips" = 1)
	// and we want it to be in the form ("salt" = 0.75, "chips" = 0.25)
	// which is called "normalizing"
	if(!supplied_data)
		supplied_data = data

	// if data isn't an associative list, this has some WEIRD side effects
	// TODO probably check for assoc list?

	data = counterlist_normalise(supplied_data)

/datum/reagent/consumable/nutriment/on_merge(list/newdata, newvolume)
	if(!islist(newdata) || !newdata.len)
		return

	// data for nutriment is one or more (flavour -> ratio)
	// where all the ratio values adds up to 1

	var/list/taste_amounts = list()
	if(data)
		taste_amounts = data.Copy()

	counterlist_scale(taste_amounts, volume)

	var/list/other_taste_amounts = newdata.Copy()
	counterlist_scale(other_taste_amounts, newvolume)

	counterlist_combine(taste_amounts, other_taste_amounts)

	counterlist_normalise(taste_amounts)

	data = taste_amounts

/datum/reagent/consumable/nutriment/vitamin
	name = "Vitamin"
	description = "All the best vitamins, minerals, and carbohydrates the body needs in pure form."

	brute_heal = 1
	burn_heal = 1

/datum/reagent/consumable/nutriment/vitamin/on_mob_life(mob/living/carbon/M)
	if(M.satiety < 600)
		M.satiety += 30
	. = ..()

/datum/reagent/consumable/nutriment/protein //this is from a beestation pr from a tg pr that actually makes use of this reagent. At the moment that I am porting newfood, we are just using it as filler to have something other than vitamins and nutriments.
	name = "Protein"
	description = "A natural polyamide made up of amino acids. An essential constituent of mosts known forms of life."
	brute_heal = 0.8 //Rewards the player for eating a balanced diet.
	nutriment_factor = 9 * REAGENTS_METABOLISM //45% as calorie dense as corn oil.

/datum/reagent/consumable/cooking_oil
	name = "Cooking Oil"
	description = "A variety of cooking oil derived from fat or plants. Used in food preparation and frying."
	color = "#EADD6B" //RGB: 234, 221, 107 (based off of canola oil)
	taste_mult = 0.8
	taste_description = "oil"
	nutriment_factor = 7 * REAGENTS_METABOLISM //Not very healthy on its own
	metabolization_rate = 10 * REAGENTS_METABOLISM
	var/fry_temperature = 450 //Around ~350 F (117 C) which deep fryers operate around in the real world

/datum/reagent/consumable/cooking_oil/expose_obj(obj/O, reac_volume)
	if(holder && holder.chem_temp >= fry_temperature)
		if(isitem(O) && !istype(O, /obj/item/food/deepfryholder))
			O.loc.visible_message(span_warning("[O] rapidly fries as it's splashed with hot oil! Somehow."))
			var/obj/item/food/deepfryholder/F = new(O.drop_location(), O)
			F.fry(volume)
			F.reagents.add_reagent(/datum/reagent/consumable/cooking_oil, reac_volume)

/datum/reagent/consumable/cooking_oil/expose_mob(mob/living/M, method = TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(!istype(M))
		return
	var/boiling = FALSE
	if(holder && holder.chem_temp >= fry_temperature)
		boiling = TRUE
	if(method != VAPOR && method != TOUCH && method != SMOKE) //Directly coats the mob, and doesn't go into their bloodstream
		return ..()
	if(!boiling)
		return TRUE
	var/oil_damage = ((holder.chem_temp / fry_temperature) * 0.33) //Damage taken per unit
	if(method == TOUCH || method == SMOKE)
		oil_damage *= 1 - M.get_permeability_protection()
	var/FryLoss = round(min(38, oil_damage * reac_volume))
	if(!HAS_TRAIT(M, TRAIT_OIL_FRIED))
		M.visible_message(span_warning("The boiling oil sizzles as it covers [M]!"), \
		span_userdanger("You're covered in boiling oil!"))
		if(FryLoss)
			M.force_scream()
		playsound(M, 'sound/machines/fryer/deep_fryer_emerge.ogg', 25, TRUE)
		ADD_TRAIT(M, TRAIT_OIL_FRIED, "cooking_oil_react")
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, unfry_mob)), 3)
	if(FryLoss)
		M.adjustFireLoss(FryLoss)
	return TRUE

/datum/reagent/consumable/cooking_oil/expose_turf(turf/open/T, reac_volume)
	if(!istype(T) || isgroundlessturf(T))
		return
	if(reac_volume >= 5)
		T.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = reac_volume * 1.5 SECONDS)
		T.name = "deep-fried [initial(T.name)]"
		T.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)

/datum/reagent/consumable/sugar
	name = "Sugar"
	description = "The organic compound commonly known as table sugar and sometimes called saccharose. This white, odorless, crystalline powder has a pleasing, sweet taste."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	taste_mult = 1.5 // stop sugar drowning out other flavours
	nutriment_factor = 10 * REAGENTS_METABOLISM
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 200 // Hyperglycaemic shock
	taste_description = "sweetness"

/datum/reagent/consumable/sugar/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("You go into hyperglycaemic shock! Lay off the twinkies!"))
	M.AdjustSleeping(600)
	. = 1

/datum/reagent/consumable/sugar/overdose_process(mob/living/M)
	M.AdjustSleeping(40)
	..()
	. = 1

/datum/reagent/consumable/sugar/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustWeeds(rand(2,3))
		mytray.adjustPests(rand(1,2))

/datum/reagent/consumable/virus_food
	name = "Virus Food"
	description = "A mixture of water and milk. Virus cells can use this mixture to reproduce."
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#899613" // rgb: 137, 150, 19
	taste_description = "watery milk"

/datum/reagent/consumable/soysauce
	name = "Soysauce"
	description = "A salty sauce made from the soy plant."
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#792300" // rgb: 121, 35, 0
	taste_description = "umami"

/datum/reagent/consumable/ketchup
	name = "Ketchup"
	description = "Ketchup, catsup, whatever. It's tomato paste."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#731008" // rgb: 115, 16, 8
	taste_description = "ketchup"

/datum/reagent/consumable/capsaicin
	name = "Capsaicin Oil"
	description = "This is what makes chilis hot."
	color = "#B31008" // rgb: 179, 16, 8
	taste_description = "hot peppers"
	taste_mult = 1.5

/datum/reagent/consumable/frostoil
	name = "Frost Oil"
	description = "A special oil that noticeably chills the body. Extracted from chilly peppers and slimes."
	color = "#8BA6E9" // rgb: 139, 166, 233
	taste_description = "mint"

/datum/reagent/consumable/frostoil/on_mob_life(mob/living/carbon/M)
	var/cooling = 0
	switch(current_cycle)
		if(1 to 15)
			cooling = -10 * TEMPERATURE_DAMAGE_COEFFICIENT
			if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
				holder.remove_reagent(/datum/reagent/consumable/capsaicin, 5)
			if(isslime(M))
				cooling = -rand(1,2)
		if(15 to 25)
			cooling = -20 * TEMPERATURE_DAMAGE_COEFFICIENT
			if(isslime(M))
				cooling = -rand(2,4)
		if(25 to 35)
			cooling = -30 * TEMPERATURE_DAMAGE_COEFFICIENT
			if(prob(1))
				M.emote("shiver")
			if(isslime(M))
				cooling = -rand(4,8)
		if(35 to INFINITY)
			cooling = -40 * TEMPERATURE_DAMAGE_COEFFICIENT
			if(prob(5))
				M.emote("shiver")
			if(isslime(M))
				cooling = -rand(8,10)
	M.adjust_bodytemperature(cooling, 10)
	..()

/datum/reagent/consumable/frostoil/expose_turf(turf/T, reac_volume)
	if(reac_volume >= 5)
		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(15,30))
	if(reac_volume >= 1) // Make Freezy Foam and anti-fire grenades!
		if(isopenturf(T))
			var/turf/open/OT = T
			OT.MakeSlippery(wet_setting=TURF_WET_ICE, min_wet_time=100, wet_time_to_add=reac_volume SECONDS) // Is less effective in high pressure/high heat capacity environments. More effective in low pressure.
			OT.air.set_temperature(OT.air.return_temperature() - MOLES_CELLSTANDARD*100*reac_volume/OT.air.heat_capacity()) // reduces environment temperature by 5K per unit.

/datum/reagent/consumable/condensedcapsaicin
	name = "Condensed Capsaicin"
	description = "A chemical agent used for self-defense and in police work."
	color = "#B31008" // rgb: 179, 16, 8
	taste_description = "scorching agony"

/datum/reagent/consumable/condensedcapsaicin/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(!ishuman(M) && !ismonkey(M))
		return

	var/mob/living/carbon/victim = M
	if(method == TOUCH || method == SMOKE || method == VAPOR)
		var/pepper_proof = victim.is_pepper_proof()

		//check for protection
		//actually handle the pepperspray effects
		if (!(pepper_proof)) // you need both eye and mouth protection
			if(prob(5))
				victim.force_scream()
			victim.blur_eyes(5) // 10 seconds
			victim.blind_eyes(3) // 6 seconds
			victim.confused = max(M.confused, 5) // 10 seconds
			victim.Knockdown(3 SECONDS)
			victim.add_movespeed_modifier(/datum/movespeed_modifier/reagent/pepperspray)
			addtimer(CALLBACK(victim, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/reagent/pepperspray), 10 SECONDS)
		victim.update_damage_hud()
	if(method == INGEST)
		if(!M.has_reagent(/datum/reagent/consumable/milk))
			if(prob(15))
				to_chat(M, span_danger("[pick("Your head pounds.", "Your mouth feels like it's on fire.", "You feel dizzy.")]"))
			if(prob(10))
				victim.blur_eyes(1)
			if(prob(10))
				victim.set_timed_status_effect(2 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			if(prob(5))
				victim.vomit()

/datum/reagent/consumable/condensedcapsaicin/on_mob_life(mob/living/carbon/M)
	if(!M.has_reagent(/datum/reagent/consumable/milk))
		if(prob(10))
			M.visible_message(span_warning("[M] [pick("dry heaves!","coughs!","splutters!")]"))
	..()

/datum/reagent/consumable/sodiumchloride
	name = "Table Salt"
	description = "A salt made of sodium chloride. Commonly used to season food."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255,255,255
	taste_description = "salt"

/datum/reagent/consumable/sodiumchloride/expose_turf(turf/T, reac_volume) //Creates an umbra-blocking salt pile
	if(!istype(T))
		return
	if(reac_volume < 1)
		return
	new/obj/effect/decal/cleanable/food/salt(T)

/datum/reagent/consumable/blackpepper
	name = "Black Pepper"
	description = "A powder ground from peppercorns. *AAAACHOOO*"
	reagent_state = SOLID
	// no color (ie, black)
	taste_description = "pepper"

/datum/reagent/consumable/coco
	name = "Coco Powder"
	description = "A fatty, bitter paste made from coco beans."
	reagent_state = SOLID
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "bitterness"

/datum/reagent/drug/mushroomhallucinogen
	name = "Mushroom Hallucinogen"
	description = "A strong hallucinogenic drug derived from certain species of mushroom."
	color = "#E700E7" // rgb: 231, 0, 231
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	taste_description = "mushroom"
	addiction_types = list(/datum/addiction/hallucinogens = 12)

/datum/reagent/drug/mushroomhallucinogen/on_mob_life(mob/living/carbon/M)
	if(!M.slurring)
		M.slurring = 1
	switch(current_cycle)
		if(1 to 5)
			M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
			M.set_drugginess(30)
		if(5 to 10)
			M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
			M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
			M.set_drugginess(35)
		if (10 to INFINITY)
			M.set_timed_status_effect(40 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
			M.set_timed_status_effect(40 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
			M.set_drugginess(40)
	..()

/datum/reagent/consumable/garlic //NOTE: having garlic in your blood stops vampires from biting you.
	name = "Garlic Juice"
	description = "Crushed garlic. Chefs love it, but it can make you smell bad."
	color = "#FEFEFE"
	taste_description = "garlic"
	metabolization_rate = 0.15 * REAGENTS_METABOLISM

/datum/reagent/consumable/garlic/on_mob_life(mob/living/carbon/M)
	if(isvampire(M)) //incapacitating but not lethal. Unfortunately, vampires cannot vomit.
		if(prob(min(25,current_cycle)))
			to_chat(M, span_danger("You can't get the scent of garlic out of your nose! You can barely think..."))
			M.Paralyze(10)
			M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	else if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.job == "Cook")
			if(prob(20)) //stays in the system much longer than sprinkles/banana juice, so heals slower to partially compensate
				H.heal_bodypart_damage(1,1, 0)
				. = 1
	..()

/datum/reagent/consumable/sprinkles
	name = "Sprinkles"
	description = "Multi-colored little bits of sugar, commonly found on donuts. Loved by cops."
	color = "#FF00FF" // rgb: 255, 0, 255
	taste_description = "childhood whimsy"

/datum/reagent/consumable/sprinkles/on_mob_life(mob/living/carbon/M)
	if(M.mind && HAS_TRAIT(M.mind, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		M.heal_bodypart_damage(1,1, 0)
		. = 1
	..()

/datum/reagent/consumable/cornoil
	name = "Corn Oil"
	description = "An oil derived from various types of corn."
	nutriment_factor = 20 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "slime"

/datum/reagent/consumable/cornoil/expose_turf(turf/open/T, reac_volume)
	if (!istype(T))
		return
	T.MakeSlippery(TURF_WET_LUBE, min_wet_time = 10 SECONDS, wet_time_to_add = reac_volume*2 SECONDS)
	T.extinguish_turf()

/datum/reagent/consumable/enzyme
	name = "Universal Enzyme"
	description = "A universal enzyme used in the preparation of certain chemicals and foods."
	color = "#365E30" // rgb: 54, 94, 48
	taste_description = "sweetness"

/datum/reagent/consumable/dry_ramen
	name = "Dry Ramen"
	description = "Space age food, since August 25, 1958. Contains dried noodles, vegetables, and chemicals that boil in contact with water."
	reagent_state = SOLID
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "dry and cheap noodles"

/datum/reagent/consumable/hot_ramen
	name = "Hot Ramen"
	description = "The noodles are boiled, the flavors are artificial, just like being back in school."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "wet and cheap noodles"

/datum/reagent/consumable/nutraslop
	name = "Nutraslop"
	description = "Mixture of leftover prison foods served on previous days."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#3E4A00" // rgb: 62, 74, 0
	taste_description = "your imprisonment"

/datum/reagent/consumable/hot_ramen/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(1 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(), FALSE)
	..()

/datum/reagent/consumable/hell_ramen
	name = "Hell Ramen"
	description = "The noodles are boiled, the flavors are artificial, just like being back in school."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "wet and cheap noodles on fire"

/datum/reagent/consumable/hell_ramen/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(1 * TEMPERATURE_DAMAGE_COEFFICIENT)
	..()

/datum/reagent/consumable/flour
	name = "Flour"
	description = "This is what you rub all over yourself to pretend to be a ghost."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 0, 0, 0
	taste_description = "chalky wheat"

/datum/reagent/consumable/flour/expose_turf(turf/T, reac_volume)
	if(!isspaceturf(T))
		var/obj/effect/decal/cleanable/food/flour/reagentdecal = new(T)
		reagentdecal = locate() in T //Might have merged with flour already there.
		if(reagentdecal)
			reagentdecal.reagents.add_reagent(/datum/reagent/consumable/flour, reac_volume)

/datum/reagent/consumable/cherryjelly
	name = "Cherry Jelly"
	description = "Totally the best. Only to be spread on foods with excellent lateral symmetry."
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "cherry"

/datum/reagent/consumable/bluecherryjelly
	name = "Blue Cherry Jelly"
	description = "Blue and tastier kind of cherry jelly."
	color = "#00F0FF"
	taste_description = "blue cherry"

/datum/reagent/consumable/rice
	name = "Rice"
	description = "tiny nutritious grains"
	reagent_state = SOLID
	nutriment_factor = 3 * REAGENTS_METABOLISM
	color = "#FFFFFF" // rgb: 0, 0, 0
	taste_description = "rice"

/datum/reagent/consumable/vanilla
	name = "Vanilla Powder"
	description = "A fatty, bitter paste made from vanilla pods."
	reagent_state = SOLID
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#FFFACD"
	taste_description = "vanilla"

/datum/reagent/consumable/eggyolk
	name = "Egg Yolk"
	description = "It's full of protein."
	nutriment_factor = 4 * REAGENTS_METABOLISM
	color = "#FFB500"
	taste_description = "egg"

/datum/reagent/consumable/eggwhite
	name = "Egg White"
	description = "It's full of even more protein."
	nutriment_factor = 1.5 * REAGENTS_METABOLISM
	color = "#fffdf7"
	taste_description = "bland egg"

/datum/reagent/consumable/corn_starch
	name = "Corn Starch"
	description = "A slippery solution."
	color = "#DBCE95"
	taste_description = "slime"

/datum/reagent/consumable/corn_syrup
	name = "Corn Syrup"
	description = "Decays into sugar."
	color = "#DBCE95"
	metabolization_rate = 3 * REAGENTS_METABOLISM
	taste_description = "sweet slime"

/datum/reagent/consumable/corn_syrup/on_mob_life(mob/living/carbon/M)
	holder.add_reagent(/datum/reagent/consumable/sugar, 3)
	..()

/datum/reagent/consumable/honey
	name = "Honey"
	description = "Sweet sweet honey that decays into sugar. Has antibacterial and natural healing properties."
	color = "#d3a308"
	nutriment_factor = 15 * REAGENTS_METABOLISM
	metabolization_rate = 1 * REAGENTS_METABOLISM
	taste_description = "sweetness"

/datum/reagent/consumable/honey/on_mob_life(mob/living/carbon/M)
	holder.add_reagent(/datum/reagent/consumable/sugar,3)
	if(prob(55))
		M.adjustBruteLoss(-1*REM, 0)
		M.adjustFireLoss(-1*REM, 0)
		M.adjustOxyLoss(-1*REM, 0)
		M.adjustToxLoss(-1*REM, 0)
	..()

/datum/reagent/consumable/honey/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(iscarbon(M) && (method in list(TOUCH, VAPOR, PATCH, SMOKE)))
		var/mob/living/carbon/C = M
		for(var/s in C.surgeries)
			var/datum/surgery/S = s
			S.speed_modifier = max(0.6, S.speed_modifier)
	..()

/datum/reagent/consumable/mayonnaise
	name = "Mayonnaise"
	description = "An white and oily mixture of mixed egg yolks."
	color = "#DFDFDF"
	taste_description = "mayonnaise"

/datum/reagent/consumable/mold // yeah, ok, togopal, I guess you could call that a condiment
	name = "Mold"
	description = "This condiment will make any food break the mold. Or your stomach."
	color ="#708a88"
	taste_description = "rancid fungus"

/datum/reagent/consumable/tearjuice
	name = "Tear Juice"
	description = "A blinding substance extracted from certain onions."
	color = "#c0c9a0"
	taste_description = "bitterness"

/datum/reagent/consumable/tearjuice/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(!istype(M))
		return
	var/unprotected = FALSE
	switch(method)
		if(INGEST)
			unprotected = TRUE
		if(INJECT)
			unprotected = FALSE
		else	//Touch or vapor
			if(!M.is_mouth_covered() && !M.is_eyes_covered())
				unprotected = TRUE
	if(unprotected)
		if(!M.getorganslot(ORGAN_SLOT_EYES))	//can't blind somebody with no eyes
			to_chat(M, span_notice("Your eye sockets feel wet."))
		else
			if(!M.eye_blurry)
				to_chat(M, span_warning("Tears well up in your eyes!"))
			M.blind_eyes(2)
			M.blur_eyes(5)
	..()

/datum/reagent/consumable/tearjuice/on_mob_life(mob/living/carbon/M)
	..()
	if(M.eye_blurry)	//Don't worsen vision if it was otherwise fine
		M.blur_eyes(4)
		if(prob(10))
			to_chat(M, span_warning("Your eyes sting!"))
			M.blind_eyes(2)


/datum/reagent/consumable/nutriment/stabilized
	name = "Stabilized Nutriment"
	description = "A bioengineered protien-nutrient structure designed to decompose in high saturation. In layman's terms, it won't get you fat."
	reagent_state = SOLID
	nutriment_factor = 15 * REAGENTS_METABOLISM
	color = "#664330" // rgb: 102, 67, 48

/datum/reagent/consumable/nutriment/stabilized/on_mob_life(mob/living/carbon/M)
	if(M.nutrition > NUTRITION_LEVEL_FULL - 25)
		M.adjust_nutrition(-3*nutriment_factor)
	..()

////Lavaland Flora Reagents////

/datum/reagent/consumable/entpoly
	name = "Entropic Polypnium"
	description = "An ichor, derived from a certain mushroom, makes for a bad time."
	color = "#1d043d"
	taste_description = "bitter mushroom"

/datum/reagent/consumable/entpoly/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 10)
		M.Unconscious(40, 0)
		. = 1
	if(prob(20))
		M.losebreath += 4
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM, 150)
		M.adjustToxLoss(3*REM,0)
		M.adjustStaminaLoss(10*REM,0)
		M.blur_eyes(5)
		. = TRUE
	..()

/datum/reagent/consumable/tinlux
	name = "Tinea Luxor"
	description = "A stimulating ichor which causes luminescent fungi to grow on the skin. "
	color = "#b5a213"
	taste_description = "tingling mushroom"
	//Lazy list of mobs affected by the luminosity of this reagent.
	var/list/mobs_affected

/datum/reagent/consumable/tinlux/expose_mob(mob/living/M)
	add_reagent_light(M)

/datum/reagent/consumable/tinlux/on_mob_end_metabolize(mob/living/M)
	remove_reagent_light(M)

/datum/reagent/consumable/tinlux/proc/on_living_holder_deletion(mob/living/source)
	SIGNAL_HANDLER
	remove_reagent_light(source)

/datum/reagent/consumable/tinlux/proc/add_reagent_light(mob/living/living_holder)
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj = living_holder.mob_light(2)
	LAZYSET(mobs_affected, living_holder, mob_light_obj)
	RegisterSignal(living_holder, COMSIG_PARENT_QDELETING, PROC_REF(on_living_holder_deletion))

/datum/reagent/consumable/tinlux/proc/remove_reagent_light(mob/living/living_holder)
	UnregisterSignal(living_holder, COMSIG_PARENT_QDELETING)
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj = LAZYACCESS(mobs_affected, living_holder)
	LAZYREMOVE(mobs_affected, living_holder)
	if(mob_light_obj)
		qdel(mob_light_obj)

/datum/reagent/consumable/vitfro
	name = "Vitrium Froth"
	description = "A bubbly paste that heals wounds of the skin."
	color = "#d3a308"
	nutriment_factor = 3 * REAGENTS_METABOLISM
	taste_description = "fruity mushroom"

/datum/reagent/consumable/vitfro/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-1*REM, 0)
		M.adjustFireLoss(-1*REM, 0)
		. = TRUE
	..()

/datum/reagent/consumable/liquidelectricity
	name = "Liquid Electricity"
	description = "A glowing, viscous substance that radiates pure energy." //this is no longer Elzousa blood
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#97ee63"
	taste_description = "pure electricity"

/datum/reagent/consumable/liquidelectricity/on_mob_life(mob/living/carbon/M)
	if(prob(25) && !iselzuose(M))
		M.electrocute_act(rand(10,15), "Liquid Electricity in their body", 1) //lmao at the newbs who eat energy bars
		playsound(M, "sparks", 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	return ..()

/datum/reagent/consumable/electrolytes
	name = "Electrolytes"
	description = "It's what crystal-plant-dragons crave."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#8effdd"

/datum/reagent/consumable/electrolytes/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == INGEST || method == INJECT || method == PATCH) && iscarbon(M))
		var/mob/living/carbon/C = M
		var/obj/item/organ/stomach/ethereal/stomach = C.getorganslot(ORGAN_SLOT_STOMACH)
		if(istype(stomach))
			stomach.adjust_charge(reac_volume * REM * ELZUOSE_CHARGE_SCALING_MULTIPLIER)	  //WS Edit -- Ethereal Charge Scaling

/datum/reagent/consumable/astrotame
	name = "Astrotame"
	description = "A space age artifical sweetener."
	nutriment_factor = 0
	metabolization_rate = 2 * REAGENTS_METABOLISM
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 255, 255, 255
	taste_mult = 8
	taste_description = "sweetness"
	overdose_threshold = 17

/datum/reagent/consumable/astrotame/overdose_process(mob/living/carbon/M)
	if(M.disgust < 80)
		M.adjust_disgust(10)
	..()
	. = 1

/datum/reagent/consumable/secretsauce
	name = "Secret Sauce"
	description = "What could it be?"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#792300"
	taste_description = "indescribable"
	quality = FOOD_AMAZING
	taste_mult = 100
	can_synth = FALSE

/datum/reagent/consumable/nutriment/peptides
	name = "Peptides"
	color = "#BBD4D9"
	taste_description = "mint frosting"
	description = "These restorative peptides not only speed up wound healing, but are nutritious as well!"
	nutriment_factor = 10 * REAGENTS_METABOLISM // 33% less than nutriment to reduce weight gain
	brute_heal = 3
	burn_heal = 1

/datum/reagent/consumable/caramel
	name = "Caramel"
	description = "Who would have guessed that heated sugar could be so delicious?"
	nutriment_factor = 10 * REAGENTS_METABOLISM
	color = "#D98736"
	taste_mult = 2
	taste_description = "caramel"
	reagent_state = SOLID

/datum/reagent/consumable/bbqsauce
	name = "BBQ Sauce"
	description = "Sweet, smoky, savory, and gets everywhere. Perfect for grilling."
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#78280A" // rgb: 120 40, 10
	taste_mult = 2.5 //sugar's 1.5, capsacin's 1.5, so a good middle ground.
	taste_description = "smokey sweetness"

/datum/reagent/consumable/laughsyrup
	name = "Laughin' Syrup"
	description = "The product of juicing Laughin' Peas. Fizzy, and seems to change flavour based on what it's used with!"
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#803280"
	taste_mult = 2
	taste_description = "fizzy sweetness"

/datum/reagent/consumable/pyre_elementum
	name = "Pyre Elementum"
	description = "This is what makes Fireblossoms even hotter."
	color = "#d30639"
	taste_description = "burning heat"
	taste_mult = 8.0
	nutriment_factor = -1 * REAGENTS_METABOLISM
	var/ingested = FALSE

/datum/reagent/consumable/pyre_elementum/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == INGEST)
		ingested = TRUE
		return
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pyre_elementum", /datum/mood_event/irritate, name)		// Applied if not eaten
	if(method == TOUCH || method == SMOKE || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 5)
		return
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(2 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(), FALSE)		// Doesn't kill you like capsaicin
	if(!ingested)							// Unless you didn't eat it
		M.adjustFireLoss(0.25*REM, 0)
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "pyre_elementum")
	..()

/datum/reagent/consumable/fervor
	name = "Fervor Ignium"
	description = "Healing chem made from mushrooms."
	color = "#b6a076"
	taste_description = "mushrooms"
	nutriment_factor = -1 * REAGENTS_METABOLISM

/datum/reagent/consumable/fervor/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-2*REM, 0)
		M.adjustFireLoss(-2*REM, 0)
	M.adjustStaminaLoss(-5*REM, 0)
	..()

/datum/reagent/consumable/cheese_spread
	name = "Cheese Spread"
	description = "I cant believe its not cheese!"
	color = "#FBDB65"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	taste_mult = 2
	taste_description = "cheese"

/datum/reagent/consumable/peanut_butter
	name = "Peanut Butter"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	taste_description = "peanut"
	reagent_state = SOLID

/datum/reagent/consumable/tiris_blood
	name = "Tiris blood"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	taste_description = "bloody and earthy"

/datum/reagent/consumable/tiris_sele
	name = "Tiris-Sele"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	taste_description = "gently blossoming umami"

/datum/reagent/consumable/tiris_sale
	name = "Tiris-Sale"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	taste_description = "bloody piercing umami"

/datum/reagent/consumable/pancakebatter
	name = "pancake batter"
	description = "A very milky batter. 5 units of this on the griddle makes a mean pancake."
	taste_description = "milky batter"
	color = "#fccc98"

/datum/reagent/consumable/whipped_cream
	name = "Whipped Cream"
	description = "A white fluffy cream made from whipping cream at intense speed."
	color = "#efeff0"
	nutriment_factor = 4
	taste_description = "fluffy sweet cream"
