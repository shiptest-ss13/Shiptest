

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DRINKS BELOW, Beer is up there though, along with cola. Cap'n Pete's Cuban Spiced Rum////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/reagent/consumable/orangejuice
	name = "Orange Juice"
	description = "Both delicious AND rich in Vitamin C, what more do you need?"
	color = "#E78108" // rgb: 231, 129, 8
	taste_description = "oranges"
	glass_icon_state = "glass_orange"
	glass_name = "glass of orange juice"
	glass_desc = "Tart and sweet. It might have pulp, if that's what you wanted."

/datum/reagent/consumable/orangejuice/on_mob_life(mob/living/carbon/M)
	if(M.getOxyLoss() && prob(30))
		M.adjustOxyLoss(-1, 0)
		. = 1
	..()

/datum/reagent/consumable/tomatojuice
	name = "Tomato Juice"
	description = "Tomatoes made into juice. What a waste of big, juicy tomatoes, huh?"
	color = "#92160d" // rgb: 115, 16, 8
	taste_description = "tomatoes"
	glass_icon_state = "glass_red"
	glass_name = "glass of tomato juice"
	glass_desc = "Some part of you wonders if this could have been a soup at some point."

/datum/reagent/consumable/tomatojuice/on_mob_life(mob/living/carbon/M)
	if(M.getFireLoss() && prob(20))
		M.heal_bodypart_damage(0,1, 0)
		. = 1
	..()

/datum/reagent/consumable/limejuice
	name = "Lime Juice"
	description = "The sweet-sour juice of limes."
	color = "#669933" // rgb: 54, 94, 48
	taste_description = "unbearable sourness"
	glass_icon_state = "glass_green"
	glass_name = "glass of lime juice"
	glass_desc = "A glass of intensely sour lime juice. You wonder to yourself: how much do you really need to ward off scurvy for it to come to the point?"

/datum/reagent/consumable/limejuice/on_mob_life(mob/living/carbon/M)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1*REM, 0)
		. = 1
	..()

/datum/reagent/consumable/carrotjuice
	name = "Carrot Juice"
	description = "It is just like a carrot but without crunching."
	color = "#cb650c"
	taste_description = "carrots"
	glass_icon_state = "carrotjuice"
	glass_name = "glass of  carrot juice"
	glass_desc = "Mildly sweet, but it won't actually improve your eyesight all that much beyond the baseline..."

/datum/reagent/consumable/carrotjuice/on_mob_life(mob/living/carbon/M)
	M.adjust_blurriness(-1)
	M.adjust_blindness(-1)
	switch(current_cycle)
		if(1 to 20)
			EMPTY_BLOCK_GUARD //nothing
		if(21 to INFINITY)
			if(prob(current_cycle-10))
				M.cure_nearsighted(list(EYE_DAMAGE))
	..()
	return

/datum/reagent/consumable/berryjuice
	name = "Berry Juice"
	description = "A delicious blend of several different kinds of berries."
	color = "#983939" // rgb: 134, 51, 51
	taste_description = "berries"
	glass_icon_state = "berryjuice"
	glass_name = "glass of berry juice"
	glass_desc = "Berry juice. Technically a fruit punch all on its own!"

/datum/reagent/consumable/applejuice
	name = "Apple Juice"
	description = "The sweet juice of an apple, fit for all ages."
	color = "#ECFF56" // rgb: 236, 255, 86
	taste_description = "apples"

/datum/reagent/consumable/poisonberryjuice
	name = "Poison Berry Juice"
	description = "A tasty juice blended from various kinds of very deadly and toxic berries."
	color = "#a7315e" // rgb: 134, 51, 83
	taste_description = "berries"
	glass_icon_state = "poisonberryjuice"
	glass_name = "glass of berry juice"
	glass_desc = "Berry juice. Technically a fruit punch all on its own!"

/datum/reagent/consumable/poisonberryjuice/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1, 0)
	. = 1
	..()

/datum/reagent/consumable/watermelonjuice
	name = "Watermelon Juice"
	description = "Delicious juice made from watermelon."
	color = "#b23b3b" // rgb: 134, 51, 51
	taste_description = "juicy watermelon"
	glass_icon_state = "glass_red"
	glass_name = "glass of watermelon juice"
	glass_desc = "A glass of watermelon juice. Mild and sweet."

/datum/reagent/consumable/lemonjuice
	name = "Lemon Juice"
	description = "This juice is VERY sour."
	color = "#caad19"
	taste_description = "sourness"
	glass_icon_state  = "lemonglass"
	glass_name = "glass of lemon juice"
	glass_desc = "A glass of intensely sour lime juice. You wonder to yourself: how much do you really need to ward off scurvy for it to come to the point?"

/datum/reagent/consumable/banana
	name = "Banana Juice"
	description = "The raw essence of a banana."
	color = "#e6d283"
	taste_description = "banana"
	glass_icon_state = "banana"
	glass_name = "glass of banana juice"
	glass_desc = "While staring down at this glass, some part of you wonders what went through the minds of those who decided to add this to milk."

/datum/reagent/consumable/banana/on_mob_life(mob/living/carbon/M)
	if((ishuman(M) && M.job == "Clown") || ismonkey(M))
		M.heal_bodypart_damage(1,1, 0)
		. = 1
	..()

/datum/reagent/consumable/nothing
	name = "Nothing"
	description = "Absolutely nothing."
	taste_description = "nothing"
	glass_icon_state = "nothing"
	glass_name = "nothing"
	glass_desc = "Absolutely nothing."
	shot_glass_icon_state = "shotglass"

/datum/reagent/consumable/nothing/on_mob_life(mob/living/carbon/M)
	if(ishuman(M) && M.mind?.miming)
		M.silent = max(M.silent, MIMEDRINK_SILENCE_DURATION)
		M.heal_bodypart_damage(1,1)
		. = 1
	..()

/datum/reagent/consumable/laughter
	name = "Laughter"
	description = "Some say that this is the best medicine, but recent studies have proven that to be untrue."
	metabolization_rate = INFINITY
	color = "#FF4DD2"
	taste_description = "laughter"

/datum/reagent/consumable/laughter/on_mob_life(mob/living/carbon/M)
	M.emote("laugh")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "chemical_laughter", /datum/mood_event/chemical_laughter)
	..()

/datum/reagent/consumable/superlaughter
	name = "Super Laughter"
	description = "Funny until you're the one laughing."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#FF4DD2"
	taste_description = "laughter"

/datum/reagent/consumable/superlaughter/on_mob_life(mob/living/carbon/M)
	if(prob(30))
		M.visible_message("<span class='danger'>[M] bursts out into a fit of uncontrollable laughter!</span>", "<span class='userdanger'>You burst out in a fit of uncontrollable laughter!</span>")
		M.Stun(5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "chemical_laughter", /datum/mood_event/chemical_superlaughter)
	..()

/datum/reagent/consumable/potato_juice
	name = "Potato Juice"
	description = "Juice of the potato. Bleh."
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#9e8045" // rgb: 48, 32, 0
	taste_description = "starchy water"
	glass_icon_state = "glass_brown"
	glass_name = "glass of potato juice"
	glass_desc = "Starchy. It coats your mouth with a filament afterwards, which really isn't helping it's case."

/datum/reagent/consumable/grapejuice
	name = "Grape Juice"
	description = "The juice of a bunch of grapes. Guaranteed non-alcoholic."
	color = "#790b79" // dark purple
	taste_description = "grapes"

/datum/reagent/consumable/milk
	name = "Milk"
	description = "An opaque white liquid produced by the mammary glands of mammals, some arthropods, biogenerators, chemical factories..."
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "milk"
	glass_icon_state = "glass_white"
	glass_name = "glass of milk"
	glass_desc = "A glass of frothy milk. You wonder what animal this could have come from, if at all."

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
		. = 1
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 2)
	..()

/datum/reagent/consumable/soymilk
	name = "Soy Milk"
	description = "An opaque white liquid made from soybeans."
	color = "#DFDFC7" // rgb: 223, 223, 199
	taste_description = "soy milk"
	glass_icon_state = "glass_white"
	glass_name = "glass of soy milk"
	glass_desc = "Despite being made from soybeans, it sates the same desire to have an entire glass of milk."

/datum/reagent/consumable/soymilk/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
		. = 1
	..()

/datum/reagent/consumable/cream
	name = "Cream"
	description = "The fatty, still liquid part of milk."
	color = "#DFD7AF" // rgb: 223, 215, 175
	taste_description = "creamy milk"
	glass_icon_state  = "glass_white"
	glass_name = "glass of cream"
	glass_desc = "It's a bit thick to drink straight."

/datum/reagent/consumable/cream/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
		. = 1
	..()

/datum/reagent/consumable/coffee
	name = "Coffee"
	description = "Coffee is a brewed drink prepared from roasted seeds, commonly called coffee beans, of the coffee plant."
	color = "#572b07" // rgb: 72, 32, 0
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitterness"
	glass_icon_state = "glass_brown"
	glass_name = "glass of coffee"
	glass_desc = "Black coffee, served straight. It'll be pretty bitter without anything else in it!"

/datum/reagent/consumable/coffee/overdose_process(mob/living/M)
	M.Jitter(5)
	..()

/datum/reagent/consumable/coffee/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	if(holder.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 5)
	..()
	. = 1

/datum/reagent/consumable/tea
	name = "Tea"
	description = "Warm, dark tea."
	color = "#5f4a05"
	nutriment_factor = 0
	taste_description = "tart dark tea"
	glass_icon_state = "teaglass"
	glass_name = "glass of tea"
	glass_desc = "There's a latent desire to drink this out of a teacup, but there's no time for teatime out here."

/datum/reagent/consumable/tea/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	..()
	. = 1

/datum/reagent/consumable/lemonade
	name = "Lemonade"
	description = "Sweet, tangy lemonade. Good for the soul."
	color = "#FFE978"
	quality = DRINK_NICE
	taste_description = "sunshine and distant shores"
	glass_icon_state = "lemonpitcher"
	glass_name = "pitcher of lemonade"
	glass_desc = "Sweet, slightly tart, and refreshing. You feel some misplaced nostalgia when you have this, even though you're not sure you've ever squeezed a lemon before."

/datum/reagent/consumable/tea/arnold_palmer
	name = "Arnold Palmer"
	description = "Iced sweet tea and lemonade."
	color = "#FFB766"
	quality = DRINK_NICE
	nutriment_factor = 2
	taste_description = "bitter tea"
	glass_icon_state = "arnold_palmer"
	glass_name = "Arnold Palmer"
	glass_desc = "Iced tea and lemonade. You don't think you know any Arnolds, though."

/datum/reagent/consumable/tea/arnold_palmer/on_mob_life(mob/living/carbon/M)
	if(prob(5))
		to_chat(M, "<span class='notice'>[pick("You remember to square your shoulders.","You remember to keep your head down.","You can't decide between squaring your shoulders and keeping your head down.","You remember to relax.","You think about how someday you'll get two strokes off your golf game... whatever that is.")]</span>")
	..()
	. = 1

/datum/reagent/consumable/icecoffee
	name = "Iced Coffee"
	description = "Coffee and ice, refreshing and cool."
	color = "#112a3b" // rgb: 16, 40, 56
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitter coldness"
	glass_icon_state = "icedcoffeeglass"
	glass_name = "iced coffee"
	glass_desc = "Iced black coffee. It's still going to be pretty bitter on it's own, though!"

/datum/reagent/consumable/icecoffee/overdose_process(mob/living/M)
	M.Jitter(5)
	..()

/datum/reagent/consumable/icecoffee/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()
	. = 1

/datum/reagent/consumable/hot_ice_coffee
	name = "Hot Ice Coffee"
	description = "Coffee with pulsing ice shards"
	color = "#132043" // rgb: 16, 40, 56
	nutriment_factor = 0
	overdose_threshold = 80
	quality = DRINK_FANTASTIC
	taste_description = "bitter coldness and a hint of smoke"
	glass_icon_state = "hoticecoffee"
	glass_name = "hot ice coffee"
	glass_desc = "The wonders of fusion mixed into a cup of coffee, resulting in an extremely hot-cold drink."

/datum/reagent/consumable/hot_ice_coffee/overdose_process(mob/living/M)
	M.Jitter(5)
	..()

/datum/reagent/consumable/hot_ice_coffee/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-60)
	M.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.adjustToxLoss(1*REM, 0)
	..()
	. = TRUE

/datum/reagent/consumable/icetea
	name = "Iced Tea"
	description = "Iced, sweetened tea."
	color = "#104038" // rgb: 16, 64, 56
	nutriment_factor = 0
	taste_description = "sweet tea"
	glass_icon_state = "icedteaglass"
	glass_name = "iced tea"
	glass_desc = "A much more appealing way to have tea while dealing with the heat."

/datum/reagent/consumable/icetea/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.AdjustSleeping(-40)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()
	. = 1

/datum/reagent/consumable/space_cola
	name = "Cola"
	description = "A refreshing beverage."
	color = "#743c05" // rgb: 16, 8, 0
	taste_description = "cola"
	glass_icon_state  = "glass_brown"
	glass_name = "glass of cola"
	glass_desc = "A carbonated cola. You should drink it before it gets flat!"

/datum/reagent/consumable/space_cola/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-5)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/crosstalk
	name = "Crosstalk"
	description = "Crosstalk! Share the energy with everyone!"
	color = "#EEFF00" // rgb: 238, 255, 0
	quality = DRINK_VERYGOOD
	taste_description = "carbonated battery acid with a spoonful of sugar"
	glass_icon_state = "crosstalk_glass"
	glass_name = "glass of Crosstalk"
	glass_desc = "The amount of sugar and chemicals in this drink makes your eyes water."

/datum/reagent/consumable/crosstalk/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_SHOCKIMMUNE, type)

/datum/reagent/consumable/crosstalk/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_SHOCKIMMUNE, type)
	..()

/datum/reagent/consumable/crosstalk/on_mob_life(mob/living/carbon/M)
	M.Jitter(20)
	M.dizziness +=1
	M.drowsyness = 0
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/comet_trail
	name = "Comet Trail"
	description = "A citrusy drink from the Kepori space installation known as The Ring."
	color = "#c4ff2d" // rgb: 16, 32, 0
	taste_description = "sweet citrus soda"
	glass_icon_state = "comet_trail_glass"
	glass_name = "glass of Comet Trail"
	glass_desc = "A glass of Comet Trail. Taste the stars!"

/datum/reagent/consumable/comet_trail/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-7)
	M.AdjustSleeping(-20)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	M.Jitter(5)
	..()
	. = 1

/datum/reagent/consumable/tadrixx
	name = "Tadrixx"
	description = "A Kalixcian drink made from a plant that tastes similar to sassafrass, which is used in root beer. A stumpy drake holding a mug of it is on the front."
	color = "#732a03"
	taste_description = "root beer" // FALSE ADVERTISING
	glass_icon_state = "tadrixx_glass"
	glass_name = "glass of Tadrixx"
	glass_desc = "A cup of fizzy Tadrixx. It smells sweet."

/datum/reagent/consumable/tadrixx/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-6)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/space_up
	name = "Space-Up"
	description = "Tastes like a hull breach in your mouth."
	color = "#00FF00" // rgb: 0, 255, 0
	taste_description = "cherry soda"
	glass_icon_state = "space-up_glass"
	glass_name = "glass of Space-Up"
	glass_desc = "Space-up. It helps you keep your cool."


/datum/reagent/consumable/space_up/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-8 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/molten
	name = "Molten Bubbles"
	description = "A spicy soft drink made from a coca-like plant from Kalixcis. Popularly served both cold -and- hot, depending on the weather."
	color = "#5f2010"
	taste_description = "spiced cola"
	glass_icon_state = "glass_brown"
	glass_name = "glass of Molten Bubbles"
	glass_desc = "A glass of Molten Bubbles. The spices tickle your nose."

/datum/reagent/consumable/molten/on_mob_life(mob/living/carbon/M)
	M.heal_bodypart_damage(1,1,0)
	if(M.bodytemperature > M.get_body_temp_normal(apply_change=FALSE))
		M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(apply_change=FALSE))
	else if(M.bodytemperature < (M.get_body_temp_normal(apply_change=FALSE) + 1))
		M.adjust_bodytemperature(10 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal(apply_change=FALSE))
	..()

/datum/reagent/consumable/molten/plasma_fizz
	name = "Plasma Fizz"
	description = "A  spinoff of the popular Molten Bubbles drink from Kalixcis, made to emulate the flavor of spiced grape instead. It's... not exactly convincing or a very good mix."
	color = "#5f2010"
	taste_description = "spiced grape soda"
	glass_icon_state = "plasma_fizz_glass"
	glass_name = "glass of Plasma Fizz"
	glass_desc = "A glass of Plasma Fizz. The spices (and fake grape flavoring) wrinkles your nose."

/datum/reagent/consumable/molten/sand
	name = "Sandblast Sarsaparilla"
	description = "Extra refreshing for those long desert days."
	color = "#af9938"
	taste_description = "root-beer and asbestos"
	glass_name = "glass of Sandblast Sarsaparilla"
	glass_desc = "A glass of Sandblast Sarsaparilla. Perfect for those long desert days."

/datum/reagent/consumable/lemon_lime
	name = "Lemon Lime"
	description = "A tangy substance made of 0.5% natural citrus!"
	color = "#8CFF00" // rgb: 135, 255, 0
	taste_description = "tangy lime and lemon soda"
	glass_icon_state = "glass_yellow"
	glass_name = "glass of lemon-lime"
	glass_desc = "You're pretty certain a real fruit has never actually touched this."


/datum/reagent/consumable/lemon_lime/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-8 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()


/datum/reagent/consumable/pacfuel
	name = "PAC-Fuel"
	description = "A carbonated energy drink themed after the purple coloration, similar to plasma."
	color = "#9385bf" // rgb: 58, 52, 75
	taste_description = "sweet and salty tang"
	glass_icon_state = "glass_red"
	glass_name = "glass of PAC-Fuel"
	glass_desc = "A glass of PAC-Fuel energy drink. It smells vaguely like acidic cotton candy..."

/datum/reagent/consumable/pacfuel/expose_mob(mob/living/C, method=TOUCH, reac_volume)
	..()
	if(C?.mind?.get_skill_level(/datum/skill/gaming) >= SKILL_LEVEL_LEGENDARY && method==INGEST && !HAS_TRAIT(C, TRAIT_GAMERGOD))
		ADD_TRAIT(C, TRAIT_GAMERGOD, "pwr_game")
		to_chat(C, "<span class='nicegreen'>As you imbibe the PAC-Fuel, your gamer third eye opens... \
		You feel as though a great secret of the universe has been made known to you...</span>")

/datum/reagent/consumable/pacfuel/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-8 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	if(prob(10))
		M?.mind.adjust_experience(/datum/skill/gaming, 5)
	..()

/datum/reagent/consumable/shoal_punch
	name = "Shoal Punch"
	description = "Sugary, and from the Shoal."
	color = "#f00060" // rgb: 94, 0, 38
	taste_description = "sugary fruity soda"
	glass_icon_state = "glass_red"
	glass_name = "glass of Shoal Punch"
	glass_desc = "It's hard to imagine all those fruits getting condensed into a cup like this."

/datum/reagent/consumable/shoal_punch/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-8 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()
/datum/reagent/consumable/sodawater
	name = "Soda Water"
	description = "A can of club soda."
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "carbonated water"
	glass_icon_state = "glass_clear"
	glass_name = "glass of soda water"
	glass_desc = "Soda water. You feel like you should add something to this..."

/datum/reagent/consumable/sodawater/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/tonic
	name = "Tonic Water"
	description = "It tastes strange, and it's not like malaria is much of an issue anymore."
	color = "#709fce"
	taste_description = "tart and fresh"
	glass_icon_state = "glass_clear"
	glass_name = "glass of tonic water"
	glass_desc = "Quinine and carbonated water. You really should add something to this..."

/datum/reagent/consumable/tonic/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()
	. = 1

/datum/reagent/consumable/xeno_energy
	name = "Xeno-Energy"
	description = "An unbearably sugary, fizzy green drink."
	color = "#88b488" // rgb: 243, 155, 3
	overdose_threshold = 60
	taste_description = "tooth-rotting sweetness"
	glass_icon_state = "xeno_energy_glass"
	glass_name = "glass of Xeno Energy"
	glass_desc = "A glass of Xeno Energy. It seems to swirl and roil outside of the can..."

/datum/reagent/consumable/xeno_energy/on_mob_life(mob/living/carbon/M)
	M.Jitter(20)
	M.dizziness +=1
	M.drowsyness = 0
	M.AdjustSleeping(-40)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/xeno_energy/on_mob_metabolize(mob/living/L)
	..()
	if(ismonkey(L))
		L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/xeno_energy)

/datum/reagent/consumable/xeno_energy/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/xeno_energy)
	..()

/datum/reagent/consumable/ice
	name = "Ice"
	description = "Frozen water, your dentist wouldn't like you chewing this."
	reagent_state = SOLID
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "ice"
	glass_icon_state = "iceglass"
	glass_name = "glass of ice"
	glass_desc = "Generally, you're supposed to put something else in there, too..."

/datum/reagent/consumable/ice/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/soy_latte
	name = "Soy Latte"
	description = "A hot beverage for those who can't handle the lactose."
	color = "#664300" // rgb: 102, 67, 0
	quality = DRINK_NICE
	overdose_threshold = 80
	taste_description = "creamy coffee"
	glass_icon_state = "soy_latte"
	glass_name = "soy latte"
	glass_desc = "A nice and refreshing beverage. It goes well with a book, if you have the time to read."

/datum/reagent/consumable/soy_latte/overdose_process(mob/living/M)
	M.Jitter(5)
	..()

/datum/reagent/consumable/soy_latte/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.SetSleeping(0)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
	..()
	. = 1

/datum/reagent/consumable/cafe_latte
	name = "Cafe Latte"
	description = "A nice, strong and tasty beverage while you are reading."
	color = "#664300" // rgb: 102, 67, 0
	quality = DRINK_NICE
	overdose_threshold = 80
	taste_description = "bitter cream"
	glass_icon_state = "cafe_latte"
	glass_name = "cafe latte"
	glass_desc = "A nice, strong and refreshing beverage. It goes well with a book, if you have the time to read."

/datum/reagent/consumable/cafe_latte/overdose_process(mob/living/M)
	M.Jitter(5)
	..()

/datum/reagent/consumable/cafe_latte/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.SetSleeping(0)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
	..()
	. = 1

/datum/reagent/consumable/doctor_delight
	name = "The Doctor's Delight"
	description = "A homemade curative. A mixture of juices that helps your body heal against most damage, at the cost of leaving you hungry."
	color = "#FF8CFF" // rgb: 255, 140, 255
	quality = DRINK_VERYGOOD
	taste_description = "homely fruit"
	glass_icon_state = "doctorsdelightglass"
	glass_name = "Doctor's Delight"
	glass_desc = "A homemade curative. Helps the body heal with the nutrition density, but it leaves a gnawing hunger afterwards."

/datum/reagent/consumable/doctor_delight/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-0.5, 0)
	M.adjustFireLoss(-0.5, 0)
	M.adjustToxLoss(-0.5, 0)
	M.adjustOxyLoss(-0.5, 0)
	if(M.nutrition && (M.nutrition - 2 > 0))
		if(!(M.mind && M.mind.assigned_role == "Medical Doctor")) //Drains the nutrition of the holder. Not medical doctors though, since it's the Doctor's Delight!
			M.adjust_nutrition(-2)
	..()
	. = 1

/datum/reagent/consumable/chocolatepudding
	name = "Chocolate Pudding"
	description = "A great dessert for chocolate lovers."
	color = "#800000"
	quality = DRINK_VERYGOOD
	nutriment_factor = 4 * REAGENTS_METABOLISM
	taste_description = "sweet chocolate"
	glass_icon_state = "chocolatepudding"
	glass_name = "chocolate pudding"
	glass_desc = "Thick, sweet, and chocolatey."

/datum/reagent/consumable/vanillapudding
	name = "Vanilla Pudding"
	description = "A great dessert for vanilla lovers."
	color = "#FAFAD2"
	quality = DRINK_VERYGOOD
	nutriment_factor = 4 * REAGENTS_METABOLISM
	taste_description = "sweet vanilla"
	glass_icon_state = "vanillapudding"
	glass_name = "vanilla pudding"
	glass_desc = "Thick, sweet, and pleasantly vanilla."

/datum/reagent/consumable/cherryshake
	name = "Cherry Shake"
	description = "A cherry flavored milkshake."
	color = "#FFB6C1"
	quality = DRINK_VERYGOOD
	nutriment_factor = 4 * REAGENTS_METABOLISM
	taste_description = "creamy cherry"
	glass_icon_state = "cherryshake"
	glass_name = "cherry shake"
	glass_desc = "A cherry flavored milkshake. Don't get any on your jumpsuit!"

/datum/reagent/consumable/bluecherryshake
	name = "Blue Cherry Shake"
	description = "An exotic milkshake."
	color = "#00F1FF"
	quality = DRINK_VERYGOOD
	nutriment_factor = 4 * REAGENTS_METABOLISM
	taste_description = "creamy blue cherry"
	glass_icon_state = "bluecherryshake"
	glass_name = "blue cherry shake"
	glass_desc = "A blue-cherry milkshake. Generally, the blue is meant to be figurative, but..."

/datum/reagent/consumable/pumpkin_latte
	name = "Pumpkin Latte"
	description = "A mix of spices and coffee. It doesn't actually contain any pumpkin, though."
	color = "#F4A460"
	quality = DRINK_VERYGOOD
	nutriment_factor = 3 * REAGENTS_METABOLISM
	taste_description = "creamy pumpkin"
	glass_icon_state = "pumpkin_latte"
	glass_name = "pumpkin latte"
	glass_desc = "A mix of coffee and pumpkin juice would taste a whole lot different than what you're having right now, you know."

/datum/reagent/consumable/tadrixxfloat
	name = "Tadrixx Float"
	description = "Ice cream on top of a glass of Tadrixx."
	color = "#533713"
	quality = DRINK_NICE
	nutriment_factor = 3 * REAGENTS_METABOLISM
	taste_description = "creamy root beer"
	glass_icon_state = "tadrixxfloat"
	glass_name = "Tadrixxfloat"
	glass_desc = "A glass of Tadrixx with ice cream on top."

/datum/reagent/consumable/pumpkinjuice
	name = "Pumpkin Juice"
	description = "Juiced from real pumpkins."
	color = "#FFA500"
	taste_description = "pumpkin"

/datum/reagent/consumable/blumpkinjuice
	name = "Blumpkin Juice"
	description = "Juiced from real blumpkin."
	color = "#00BFFF"
	taste_description = "a mouthful of pool water"

/datum/reagent/consumable/triple_citrus
	name = "Triple Citrus"
	description = "A solution."
	color = "#EEFF00"
	quality = DRINK_NICE
	taste_description = "extreme sourness"
	glass_icon_state = "triplecitrus" //needs own sprite mine are trash //your sprite is great tho
	glass_name = "glass of triple citrus"
	glass_desc = "A mixture of citrus juices. Intensely sour, and leaves you reeling afterwards."

/datum/reagent/consumable/grape_soda
	name = "Grape soda"
	description = "Artificial grape soda."
	color = "#E6CDFF"
	taste_description = "grape soda"
	glass_name = "glass of grape juice"
	glass_desc = "It's grape soda!"

/datum/reagent/consumable/grape_soda/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/milk/chocolate_milk
	name = "Chocolate Milk"
	description = "Milk mixed with chocolate powder. Beloved by children everywhere."
	color = "#7D4E29"
	quality = DRINK_NICE
	taste_description = "chocolate milk"

/datum/reagent/consumable/lunapunch
	name = "Lunapunch"
	description = "An herbal-sweet carbonated drink with a bitter bite."
	color = "#7D4E29"
	quality = DRINK_NICE
	taste_description = "sweet herbs and lingering bitterness"
	glass_name = "glass of Lunapunch"
	glass_desc = "An herbal-sweet soft drink. The bitter bite after each sip is enough to make you wince, but leaves you wanting more."
/datum/reagent/consumable/hot_coco
	name = "Hot Cocoa"
	description = "Made with love and cocoa beans. Or from a vending machine."
	nutriment_factor = 3 * REAGENTS_METABOLISM
	color = "#4f3a11" // rgb: 64, 48, 16
	taste_description = "creamy chocolate"
	glass_icon_state  = "chocolateglass"
	glass_name = "glass of hot cocoa."
	glass_desc = "A favorite winter drink from the Solar Confederation. Good for warming yourself up."

/datum/reagent/consumable/hot_coco/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/hot_coco/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() && prob(20))
		M.heal_bodypart_damage(1,0, 0)
		. = 1
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 2)
	..()

/datum/reagent/consumable/menthol
	name = "Menthol"
	description = "Alleviates coughing symptoms one might have."
	color = "#80AF9C"
	taste_description = "mint"
	glass_icon_state = "glass_green"
	glass_name = "glass of menthol"
	glass_desc = "Tastes naturally and sharply minty, with a mild numbing sensation."

/datum/reagent/consumable/menthol/on_mob_life(mob/living/L)
	L.apply_status_effect(/datum/status_effect/throat_soothed)
	..()

/datum/reagent/consumable/grenadine
	name = "Grenadine"
	description = "More blackcurrant than cherry, actually."
	color = "#EA1D26"
	taste_description = "sweet pomegranates"
	glass_name = "glass of grenadine"
	glass_desc = "Flavored syrup, traditionally used for mixing drinks. Having it straight is certainly a choice."

/datum/reagent/consumable/parsnipjuice
	name = "Parsnip Juice"
	description = "Starchy and uncommon."
	color = "#FFA500"
	taste_description = "parsnip"
	glass_name = "glass of parsnip juice"
	glass_desc = "It doesn't really count as a soup this way. Maybe it'd better if it was a soup."

/datum/reagent/consumable/pineapplejuice
	name = "Pineapple Juice"
	description = "Tart, tropical, and sweet."
	color = "#F7D435"
	taste_description = "pineapple"
	glass_name = "glass of pineapple juice"
	glass_desc = "Tart, tropical, and sweet."

/datum/reagent/consumable/peachjuice //Intended to be extremely rare due to being the limiting ingredients in the blazaam drink
	name = "Peach Juice"
	description = "Just peachy."
	color = "#E78108"
	taste_description = "peaches"
	glass_name = "glass of peach juice"
	glass_desc = "A glass full of sweet peach juice. Strange, you don't often see it out this far into the Frontier..."

/datum/reagent/consumable/cream_soda
	name = "Cream Soda"
	description = "A classic vanilla flavored soft drink."
	color = "#dcb137"
	quality = DRINK_VERYGOOD
	taste_description = "fizzy vanilla"
	glass_icon_state = "cream_soda"
	glass_name = "Cream Soda"
	glass_desc = "A classic vanilla flavored soft drink."

/datum/reagent/consumable/cream_soda/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal())
	..()

/datum/reagent/consumable/sol_dry
	name = "Sol Dry"
	description = "A soothing, mellow drink made from ginger."
	color = "#f7d26a"
	quality = DRINK_NICE
	taste_description = "sweet ginger spice"
	glass_name = "Sol Dry"
	glass_desc = "A soothing, mellow drink made from ginger. You can't imagine drinking a carbonated drink while in microgravity, though, nausea or not..."

/datum/reagent/consumable/sol_dry/on_mob_life(mob/living/carbon/M)
	M.adjust_disgust(-5)
	..()

/datum/reagent/consumable/red_queen
	name = "Red Queen"
	description = "You feel inclined to drink it, somehow."
	color = "#e6ddc3"
	quality = DRINK_GOOD
	taste_description = "wonder"
	glass_icon_state = "red_queen"
	glass_name = "Red Queen"
	glass_desc = "A cup of red tea. A small note is tied around the handle of it, which asks you to drink it."
	var/current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/red_queen/on_mob_life(mob/living/carbon/H)
	if(prob(75))
		return ..()
	var/newsize = pick(0.5, 0.75, 1, 1.50, 2)
	newsize *= RESIZE_DEFAULT_SIZE
	H.resize = newsize/current_size
	current_size = newsize
	H.update_transform()
	if(prob(40))
		H.emote("sneeze")
	..()

/datum/reagent/consumable/red_queen/on_mob_end_metabolize(mob/living/M)
	M.resize = RESIZE_DEFAULT_SIZE/current_size
	current_size = RESIZE_DEFAULT_SIZE
	M.update_transform()
	..()

/datum/reagent/consumable/bungojuice
	name = "Bungo Juice"
	color = "#F9E43D"
	description = "A botanical experiment gone right."
	taste_description = "succulent bungo"
	glass_icon_state = "glass_yellow"
	glass_name = "glass of bungo juice"
	glass_desc = "A botanical experiment in creating a new fruit. It smells faintly citrusy, along with a hint of... banana?"

/datum/reagent/consumable/prunomix
	name = "pruno mixture"
	color = "#E78108"
	description = "Fruit, sugar, yeast, and water pulped together into a pungent slurry."
	taste_description = "garbage"
	glass_icon_state = "glass_orange"
	glass_name = "glass of pruno mixture"
	glass_desc = "Fruit, sugar, yeast, and water pulped together into a pungent slurry."

/datum/reagent/consumable/aloejuice
	name = "Aloe Juice"
	color = "#A3C48B"
	description = "A healthy and refreshing juice."
	taste_description = "vegetable"
	glass_icon_state = "glass_yellow"
	glass_name = "glass of aloe juice"
	glass_desc = "Juiced aloe vera. It's an acquired taste."

/datum/reagent/consumable/aloejuice/on_mob_life(mob/living/M)
	if(M.getToxLoss() && prob(30))
		M.adjustToxLoss(-1, 0)
	..()
	. = TRUE

/datum/reagent/consumable/lean
	name = "Lean"
	description = "The drank that makes you go wheezy."
	color = "#DE55ED"
	quality = DRINK_NICE
	taste_description = "purple and a hint of opioid."
	glass_icon_state = "lean"
	glass_name = "Lean"
	glass_desc = "You just don't often get to see cough syrup out here, and someone had enough to mix it with soda. You're left wondering why."

/datum/reagent/consumable/lean/on_mob_life(mob/living/carbon/M)
	if(M.slurring < 3)
		M.slurring+= 2
	if(M.druggy < 3)
		M.adjust_drugginess(1)
	if(M.drowsyness < 3)
		M.drowsyness++
	return ..()

