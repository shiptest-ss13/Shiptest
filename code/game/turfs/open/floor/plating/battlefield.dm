/turf/open/floor/plating/asteroid/battlefield_wasteland
	name = "wasteland"
	desc = "The dry enviroment and lack of nutrients have cracked the earth here."
	icon = 'icons/turf/planetary/battlefield.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	floor_variance = 88
	max_icon_states = 22
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	layer = STONE_TURF_LAYER
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/battlefield_wasteland

/turf/open/floor/plating/asteroid/battlefield_wasteland/lit
	baseturfs = /turf/open/floor/plating/asteroid/battlefield_wasteland/lit
	light_color = COLOR_FOGGY_LIGHT
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/dirt/battlefield
	baseturfs = /turf/open/floor/plating/asteroid/dirt/battlefield
	light_color = COLOR_FOGGY_LIGHT
	light_range = 2
	light_power = 1

/turf/open/water/battlefield
	name = "\"water\""
	desc = "This can't be good to drink... or even step in for that matter"
	color = "#c24850"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/water/battlefield

/turf/open/water/battlefield/CanAllowThrough(atom/movable/passing_atom, turf/target)
	if(ishostile(passing_atom))
		return FALSE
	return ..()

/turf/open/water/battlefield/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM))
		return
	if(poison_tile(AM))
		START_PROCESSING(SSobj, src)

/turf/open/water/battlefield/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(!iscarbon(AM))
		return
	if(poison_tile(AM))
		START_PROCESSING(SSobj, src)

/turf/open/water/battlefield/process()
	if(!poison_tile())
		STOP_PROCESSING(SSobj, src)

/turf/open/water/battlefield/proc/poison_tile(mob/living/carbon/living_mob)
	var/thing_to_check = src
	. = FALSE
	if (living_mob)
		thing_to_check = list(living_mob)
	for(var/thing in thing_to_check)
		if(!iscarbon(living_mob))
			continue
		if("toxic" in living_mob.weather_immunities)
			continue
		living_mob.reagents.add_reagent(/datum/reagent/toxin, 0.2)
		. = TRUE


/turf/open/water/battlefield/lit
	light_range = 2
	light_power = 1
	light_color = COLOR_FOGGY_LIGHT
