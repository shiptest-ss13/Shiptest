///base turf

/turf/open/floor/plating/asteroid/wasteplanet
	name = "dry rock"
	icon = 'icons/turf/planetary/wasteplanet.dmi'
	icon_state = "wasteplanet0"
	base_icon_state = "wasteplanet"
	turf_type = /turf/open/floor/plating/asteroid/wasteplanet
	floor_variance = 45
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	digResult = /obj/item/stack/ore/glass/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/asteroid/wasteplanet/lit
	light_range = 2
	light_power = 0.2

///plating turfs

/turf/open/floor/plating/wasteplanet
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/wasteplanet/rust
	name = "rusted plating"
	desc = "Corrupted steel."
	icon_state = "plating_rust"

/turf/open/indestructible/hierophant/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/indestructible/hierophant/two/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/wood/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/concrete/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet

/turf/open/floor/concrete/wasteplanet/Initialize()
	. = ..()
	icon_state = pick(list(
		"conc_smooth",
		"conc_slab_1",
		"conc_slab_2",
		"conc_slab_3",
		"conc_slab_4",
		"conc_tiles"
	))

/turf/open/floor/concrete/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/concrete/reinforced/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet

/turf/open/floor/concrete/reinforced/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/concrete/pavement/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet

/turf/open/floor/concrete/pavement/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plasteel/wasteplanet
	baseturfs = /turf/open/floor/plating/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plasteel/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plasteel/dark/wasteplanet
	baseturfs = /turf/open/floor/plating/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plasteel/dark/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plasteel/stairs/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/wasteplanet

/turf/open/floor/plasteel/stairs/wasteplanet/lit
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/pod/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/wasteplanet

/turf/open/floor/pod/wasteplanet/lit
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/wood/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/indestructible/hierophant/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/indestructible/hierophant/two/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/engine/hull/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/waste/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/engine/hull/reinforced/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/reinforced/waste/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/engine/hull/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/waste/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/engine/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS


///liquids

/turf/open/water/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/water/tar/waste
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	planetary_atmos = TRUE
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/water/tar/waste/lit
	light_range = 2
	light_power = 0.2


///cement turfs

/turf/open/floor/concrete/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/concrete/wasteplanet/Initialize()
	. = ..()
	icon_state = pick(list(
		"conc_smooth",
		"conc_slab_1",
		"conc_slab_2",
		"conc_slab_3",
		"conc_slab_4",
		"conc_tiles"
	))

/turf/open/floor/concrete/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/concrete/reinforced/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/concrete/reinforced/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/concrete/pavement/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/concrete/pavement/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

//open turfs then open lits.

/turf/open/floor/plating/wasteplanet/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/plating/wasteplanet/rust/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/plating/asteroid/wasteplanet/lit
	light_range = 2
	light_power = 0.2

/turf/open/water/tar/waste/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/concrete/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/concrete/reinforced/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/concrete/pavement/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/water/waste/lit //do not drink
	light_range = 2
	light_power = 0.2
	light_color = COLOR_WASTEPLANET_LIGHT

//closed turfs are a thing
/turf/closed/wall/r_wall/wasteplanet
	max_integrity = 800
	atom_integrity = 800
	baseturfs = /turf/open/floor/plating/wasteplanet
	girder_type = /obj/structure/girder/wasteworld

/turf/closed/wall/r_wall/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(200,400))


/turf/closed/wall/r_wall/rust/wasteplanet
	max_integrity = 600
	atom_integrity = 600
	baseturfs = /turf/open/floor/plating/wasteplanet/rust
	girder_type = /obj/structure/girder/wasteworld

/turf/closed/wall/r_wall/rust/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(0,400))

/turf/closed/wall/wasteplanet
	max_integrity = 200
	atom_integrity = 200
	baseturfs = /turf/open/floor/plating/wasteplanet
	girder_type = /obj/structure/girder/wasteworld

/turf/closed/wall/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(0,150))

/turf/closed/wall/rust/wasteplanet
	max_integrity = 100
	atom_integrity = 100
	baseturfs = /turf/open/floor/plating/wasteplanet/rust
	girder_type = /obj/structure/girder/wasteworld

/turf/closed/wall/rust/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(0,100))

/turf/closed/wall/concrete/wasteplanet
	max_integrity = 200
	atom_integrity = 200
	baseturfs = /turf/open/floor/concrete/wasteplanet

/turf/closed/wall/concrete/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(0,100))

/turf/closed/wall/concrete/reinforced/wasteplanet
	max_integrity = 700
	atom_integrity = 700
	baseturfs = /turf/open/floor/concrete/wasteplanet

/turf/closed/wall/concrete/reinforced/wasteplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(25))
		alter_integrity(-rand(0,500))

//girlder

/obj/structure/girder/wasteworld
	max_integrity = 40
