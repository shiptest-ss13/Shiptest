//emits steam when walked over. if density = TRUE, emits steam when bumped
/obj/structure/hazard/spray/steam
	name = "steam vent"
	desc = "A outlet for steam, usually for water coming in contact with steam pipes."
	icon = 'icons/obj/structures.dmi'
	icon_state = "steamvent"
	contact_steam = TRUE //needed
	density = 0
	range = 2

//transparent smoke that players can see through (otherwise blocks view)
/obj/structure/hazard/spray/steam/transparent_safe
	smoke_type = /obj/effect/particle_effect/smoke/transparent

//opaque smoke that does no damage
/obj/structure/hazard/spray/steam/safe
	smoke_type = /obj/effect/particle_effect/smoke

//smoke that makes you drop items and cough
/obj/structure/hazard/spray/steam/cough
	smoke_type = /obj/effect/particle_effect/smoke/bad

//smoke that makes you take oxyloss and cough
/obj/structure/hazard/spray/steam/dangerous
	smoke_type = /obj/effect/particle_effect/smoke/hazard

//note dont use this one unless you add a reagent
/*
/obj/structure/hazard/spray/steam/chem
	chem_smoke = TRUE
	reagent_type = /datum/reagent/
*/
