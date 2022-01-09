/obj/machinery/integrated_airlock_tiny_fan
	name = "Integrated Air-based Atmospheric Seal"
	desc = "A tiny fan linked to the control circuity of the airlock."
	icon = 'icons/obj/lavaland/survival_pod.dmi'
	icon_state = "fan_tiny"
	CanAtmosPass = ATMOS_PASS_YES
	power_channel = AREA_USAGE_ENVIRON
	use_power = IDLE_POWER_USE
	idle_power_usage = 20
	/// Reference to our parent airlock
	var/obj/machinery/door/airlock/parent_airlock

/obj/machinery/integrated_airlock_tiny_fan/Initialize(mapload)
	. = ..()
	parent_airlock = locate() in get_turf(src)

/obj/machinery/integrated_airlock_tiny_fan/process()
	var/old_pass = CanAtmosPass
	var/area/area = get_area(src)
	if(area.powered(AREA_USAGE_ENVIRON))
		area.use_power(idle_power_usage, AREA_USAGE_ENVIRON)
		CanAtmosPass = ATMOS_PASS_NO
	else
		CanAtmosPass = ATMOS_PASS_YES
	if(old_pass == CanAtmosPass)
		return
	var/turf/our_turf = get_turf(src)
	our_turf.ImmediateCalculateAdjacentTurfs()

/obj/machinery/integrated_airlock_tiny_fan/Destroy()
	. = ..()
	parent_airlock = null
