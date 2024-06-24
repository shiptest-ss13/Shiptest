//does brute damage through armor and bio resistance
/datum/blobstrain/reagent/reactive_spines
	name = "Reactive Spines"
	description = "will do medium brute damage through armor and bio resistance."
	effectdesc = "will also react when attacked with brute damage, attacking all near the attacked blob."
	analyzerdescdamage = "Does medium brute damage, ignoring armor and bio resistance."
	analyzerdesceffect = "When attacked with brute damage, will lash out, attacking everything near it."
	color = "#9ACD32"
	complementary_color = "#FFA500"
	blobbernaut_message = "stabs"
	message = "The blob stabs you"
	reagent = /datum/reagent/blob/reactive_spines

/datum/reagent/blob/reactive_spines
	name = "Reactive Spines"
	taste_description = "rock"
	color = "#9ACD32"

/datum/reagent/blob/reactive_spines/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/O)
	if(M.stat == DEAD || istype(M, /mob/living/simple_animal/hostile/blob))
		return 0 //the dead, and blob mobs, don't cause reactions
	M.adjustBruteLoss(0.8*reac_volume)
