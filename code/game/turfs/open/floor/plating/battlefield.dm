/turf/open/floor/plating/asteroid/dry_seafloor/battlefield
	name = "wasteland"
	desc = "The dry enviroment and lack of nutrients have cracked the earth here."
	icon = 'icons/turf/planetary/battlefield.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	floor_variance = 88
	max_icon_states = 22
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor/battlefield
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/dry_seafloor/battlefield/lit
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor/battlefield/lit
	light_color = "#849abf"
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/dark/lit/battlefield
	baseturfs = /turf/open/floor/plating/dirt/jungle/dark/lit/battlefield
	light_color = "#849abf"
	light_range = 2
	light_power = 1

/turf/open/water/battlefield
	color = "#c24850"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/acid/CanAllowThrough(atom/movable/passing_atom, turf/target)
	if(ishostile(passing_atom))
		return FALSE
	return ..()

/turf/open/acid/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM))
		return
	if(poison_tile(AM))
		START_PROCESSING(SSobj, src)

/turf/open/acid/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(!iscarbon(AM))
		return
	if(poison_tile(AM))
		START_PROCESSING(SSobj, src)

/turf/open/acid/process()
	if(!poison_tile())
		STOP_PROCESSING(SSobj, src)

/turf/open/acid/proc/poison_tile(mob/living/carbon/living_mob)
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
	light_color = "#849abf"
