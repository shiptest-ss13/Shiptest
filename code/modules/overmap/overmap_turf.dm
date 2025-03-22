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
	if(!virtual_z)
		return
	var/datum/virtual_level/vlevel = get_virtual_level()
	if(!vlevel.current_systen)
		return
	var/primary_color = vlevel.current_systen.primary_color //jesus
	var/secondary_color = vlevel.current_systen.secondary_color
	var/new_icon_state = vlevel.current_systen.overmap_icon_state
	icon_state = new_icon_state
	color = secondary_color

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
		var/mutable_appearance/I = image('icons/misc/numbers.dmi', numbers[i])
		I.pixel_x = 5*i + (world.icon_size - length(numbers)*5)/2 - 5
		I.pixel_x = 5*i + (world.icon_size - length(numbers)*5)/2 - 5
		I.pixel_y = world.icon_size/2 - 3
		I.pixel_y = world.icon_size/2 - 3
		I.appearance_flags = RESET_COLOR
		I.color = primary_color
		overlays += I
		overlays += I

/** # Overmap area
 * Area that all overmap objects will spawn in at roundstart.
 */
/area/overmap
	name = "Overmap"
	icon_state = "yellow"
	requires_power = FALSE
	area_flags = NOTELEPORT | UNIQUE_AREA
	flags_1 = NONE
