//EXAMPLE HAZARDS. DON'T USE THESE!

/*
SLOWDOWN HAZARDS
*/

//a climbing hazard, similar to tables. Must be dense!
/obj/structure/hazard/slowdown/example/climb
	name = "climb"
	icon_state = "hazard"
	density = TRUE //needed
	climbable = TRUE //needed
	climb_time = 2 SECONDS

//an overhead hazard, requires laying down to get under.
/obj/structure/hazard/slowdown/example/overhead
	name = "overhead"
	icon_state = "hazard"
	layer = ABOVE_MOB_LAYER //needed
	overhead = TRUE //needed

//a sticky hazard, has a chance to not let you through
/obj/structure/hazard/slowdown/example/sticky
	name = "sticky"
	icon_state = "hazard"
	sticky = TRUE //needed
	stick_chance = 50
	projectile_stick_chance = 30

//a slowing hazard, slows down movement within. (all hazards can have slowdown set, not just hazard/slowdown)
/obj/structure/hazard/slowdown/example/slow
	name = "slow"
	icon_state = "hazard"
	slowdown = 1 //needed

/*
ELECTRICAL HAZARDS
*/

//emits a spark shower every 10-20 seconds
/obj/structure/hazard/electrical/example/random_sparks
	name = "random sparks"
	icon_state = "hazardb"
	random_sparks = TRUE //needed
	random_min = 10 SECONDS
	random_max = 20 SECONDS

//emits a tesla arc every 5-10 seconds, within the set range and at the set power.
/obj/structure/hazard/electrical/example/random_tesla
	name = "random tesla"
	icon_state = "hazardb"
	random_tesla = TRUE //needed
	random_min = 5 SECONDS
	random_max = 10 SECONDS
	zap_range = 3
	zap_power = 1500
	zap_flags = ZAP_MOB_DAMAGE | ZAP_MOB_STUN

//emits sparks when walked over. If density = TRUE, emits sparks when bumped! Cooldown stops spark spam
/obj/structure/hazard/electrical/example/contact_sparks
	name = "contact sparks"
	icon_state = "hazardb"
	density = FALSE
	contact_sparks = TRUE //needed
	cooldown_time = 3 SECONDS

//stuns when walked over. If density = TRUE, stuns when bumped into!
/obj/structure/hazard/electrical/example/contact_stun
	name = "contact stun"
	icon_state = "hazardb"
	density = FALSE
	contact_stun = TRUE //needed
	stun_time = 50
	contact_damage = 30
	shock_flags = SHOCK_NOGLOVES | SHOCK_NOSTUN

/obj/structure/hazard/electrical/example/stun_and_spark
	name = "random sparks and contact stun"
	icon_state = "hazardb"
	density = TRUE

	random_sparks = TRUE
	random_min = 10 SECONDS
	random_max = 20 SECONDS

	contact_stun = TRUE
	stun_time = 0 //don't do stun_time if not using SHOCK_NOGLOVES
	contact_damage = 30
	shock_flags = 0 //doesn't shock if not wearing gloves, but stuns if you get shocked.

/*
STEAM HAZARDS
*/

//emits steam every 10-20 seconds
/obj/structure/hazard/steam/example/random_steam
	name = "random steam"
	icon_state = "hazardg"
	random_steam = TRUE //needed
	random_min = 10 SECONDS
	random_max = 20 SECONDS
	range = 2

//emits steam when walked over. if density = TRUE, emits steam when bumped
/obj/structure/hazard/steam/example/contact_steam
	name = "contact steam"
	icon_state = "hazardg"
	contact_steam = TRUE //needed
	range = 2
// different smoke examples

//transparent smoke that players can see through (otherwise blocks view)
/obj/structure/hazard/steam/example/contact_steam/steam
	name = "steam"
	smoke_type = /obj/effect/particle_effect/smoke/transparent

//opaque smoke that does no damage
/obj/structure/hazard/steam/example/contact_steam/safe
	name = "safe"
	smoke_type = /obj/effect/particle_effect/smoke

//smoke that makes you drop items and cough
/obj/structure/hazard/steam/example/contact_steam/bad
	name = "bad"
	smoke_type = /obj/effect/particle_effect/smoke/bad

//smoke that makes you take oxyloss and cough
/obj/structure/hazard/steam/example/contact_steam/hazard
	name = "hazard"
	smoke_type = /obj/effect/particle_effect/smoke/hazard

/*
FLOOR EXAMPLES
*/

//classic spike pit, can be avoided by laying down.
/obj/structure/hazard/floor/example/sharp
	name = "example sharp"
	icon_state = "spikepit"
	caltrop = TRUE //needed
	low_damage = 20
	high_damage = 30
	probability = 80
	caltrop_flags = CALTROP_BYPASS_SHOES | CALTROP_IGNORE_WALKERS

//simple slipping hazard, similar to oil spills.
/obj/structure/hazard/floor/example/slip
	name = "example slip"
	icon_state = "hazardb"
	slippery = TRUE //needed
	knockdown_time = 3 SECONDS
	slip_flags = NO_SLIP_WHEN_WALKING | SLIDE
	paralyze_time = 1 SECONDS
	forcedrop = TRUE

/obj/structure/hazard/floor/example/launch
	name = "example launch"
	icon_state = "gravplate" //needs state-launch version
	layer = ABOVE_OPEN_TURF_LAYER //needed
	launcher = TRUE //needed
	random_min = 5 SECONDS
	random_max = 5 SECONDS

/*
shutoff example
*/

//Toggles the state of hazards with the same ID. SET ID ON MAP USING VAREDIT AND BE UNIQUE (ie id = crashed_starwalker_water_hazard)
/obj/structure/hazard_shutoff/example
	name = "example shutoff"
	desc = "id = 1"
	id = 1

//ingame working example
/obj/structure/hazard/electrical/example/random_tesla/shutoffexample
	name = "shutoff tesla"
	id = 1
	random_min = 1 SECONDS
	random_max = 2 SECONDS

//another ingame working example
/obj/structure/hazard/electrical/electrified_water/example
	id = 1

//turns off hazards with the same ID until the resets time has passed!
/obj/structure/hazard_shutoff/example/timed
	name = "timed example shutoff"
	desc = "id = 1"
	id = 1
	resets = 3 SECONDS

//good luck with radioactive hazards for now. you'll likely need to write code (dear god)
