/** # Overmap turfs
 * Overmap turfs, has no non-aesthetic functionality.
 */
/turf/open/overmap
	icon = 'icons/turf/overmap.dmi'
	icon_state = "overmap"
	initial_gas_mix = AIRLESS_ATMOS

//this is completely unnecessary but it looks nice
/turf/open/overmap/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(!SSovermap.overmap_vlevel)
		return
	var/datum/virtual_level/vlevel = SSovermap.overmap_vlevel
	var/overmap_x = x - (vlevel.low_x + vlevel.reserved_margin) + 1
	var/overmap_y = y - (vlevel.low_y + vlevel.reserved_margin) + 1

	name = "[overmap_x]-[overmap_y]"
	var/list/numbers = list()

	if(overmap_x == 1)
		numbers += list("[round(overmap_y/10)]","[round(overmap_y%10)]")
		if(overmap_y == 1)
			numbers += "-"
	if(overmap_y == 1)
		numbers += list("[round(overmap_x/10)]","[round(overmap_x%10)]")

	for(var/i = 1 to length(numbers))
		var/image/I = image('icons/misc/numbers.dmi', numbers[i])
		I.pixel_x = 5*i + (world.icon_size - length(numbers)*5)/2 - 5
		I.pixel_y = world.icon_size/2 - 3
		overlays += I

/** # Overmap area
 * Area that all overmap objects will spawn in at roundstart.
 */
/area/overmap
	name = "Overmap"
	icon_state = "yellow"
	requires_power = FALSE
	area_flags = NOTELEPORT
	flags_1 = NONE
