/*
steam/smoke, foam, and water spray effects

the steam particle effect is different than 'steam' referenced in the smoke section. steam particles are refered to as water spray here.

types
/obj/effect/particle_effect/smoke //safe smoke, blocks view
/obj/effect/particle_effect/smoke/bad_smoke //forcedrops items, blocks view. use sparingly
/obj/effect/particle_effect/smoke/hazard_smoke //oxyloss, blocks view, feels most like deadly smoke
/obj/effect/particle_effect/smoke/transparent //doesn't block view, feels most like steam
 */


/obj/structure/hazard/spray
	name = "steam hazard"
	desc = "tell a maptainer if you see this. FWSSSH!"
	icon_state = "hazardg"

	//how far smoke and foam spreads, smoke spreads further with same number.
	var/range = 2
	//the datum path of the foam/smoke reagent, needs chem_foam = TRUE or chem_smoke = TRUE
	var/reagent_type = /datum/reagent/space_cleaner

	//randomly emits smoke between random_min and random_max time
	var/random_steam = FALSE
	//emits smoke when bumped or walked over, can have cooldown_time set.
	var/contact_steam = FALSE
	//type of smoke emited, check effects_smoke.dm for all of them, or the short list at the top of this file.
	var/smoke_type = /obj/effect/particle_effect/smoke/transparent
	//chem smoke overrides smoke_type
	var/chem_smoke = FALSE


	//randomly emits water spray, entirely for show
	var/random_water = FALSE
	//emits water on contact, entirely for show
	var/contact_water = FALSE
	//how many water spray effects the hazard makes
	var/water_amount = 5
	//if the water only goes cardinal directions.
	var/water_cardinals_only = FALSE

	//randomly emits foam, can be chem foam
	var/random_foam = FALSE
	//emits foam on contact, can be chem foam
	var/contact_foam = FALSE
	//only used if chem_foam is false
	var/foam_type = /datum/effect_system/foam_spread
	//nullifies foam_type
	var/chem_foam = FALSE
	//the amount of reagent, needs reagen_foam = TRUE
	var/reagent_amount = 20

/obj/structure/hazard/spray/Initialize()
	if(contact_steam || contact_water || contact_foam)
		enter_activated = TRUE
	if(random_steam || random_water || random_foam)
		random_effect = TRUE
	. = ..()

/obj/structure/hazard/spray/proc/steam()
	if(chem_smoke)
		var/datum/reagents/reagents = new/datum/reagents(50)
		reagents.my_atom = src
		reagents.add_reagent(reagent_type , 50)
		var/datum/effect_system/smoke_spread/chem/smoke = new
		smoke.set_up(reagents, range, src)
		smoke.start()
		qdel(reagents)
	else
		do_smoke(range, src, smoke_type)

/obj/structure/hazard/spray/proc/water_spray()
	do_steam(water_amount, src, water_cardinals_only)

/obj/structure/hazard/spray/proc/foam()
	if(chem_foam)
		var/datum/reagents/reagents = new/datum/reagents(1000)
		reagents.my_atom = src
		reagents.add_reagent(reagent_type, reagent_amount)
		reagents.create_foam(/datum/effect_system/foam_spread, range)
	else
		var/datum/effect_system/foam_spread/foam = new foam_type()
		var/datum/reagents/dud = new //foam set_up gets mad if we don't pass a reagent, but this works.
		foam.set_up(range, loc, dud)
		foam.start()

/obj/structure/hazard/spray/do_random_effect()
	if(random_steam)
		steam()
	if(random_water)
		water_spray()
	if(random_foam)
		foam()

/obj/structure/hazard/spray/contact(target)
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_time)
	if(contact_steam)
		steam()
	if(contact_water)
		water_spray()
	if(contact_foam)
		foam()
