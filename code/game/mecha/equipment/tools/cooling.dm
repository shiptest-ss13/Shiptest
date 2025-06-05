/obj/item/mecha_parts/mecha_equipment/heat_sink
	name = "heat sink"
	desc = "A large heat sink for preventing large mechanical exosuits from overheating as easily, but also makes them harder to cool down."
	icon_state = "heatsink"
	energy_drain = 0
	active = TRUE
	selectable = FALSE // no.
	var/heat_modifier = 0.75

/obj/item/mecha_parts/mecha_equipment/heat_sink/attach(obj/mecha/new_chassis)
	. = ..()
	new_chassis.heat_modifier *= heat_modifier // these DO stack, the more you attach the harder it is to overheat but the more fucked you are if you do

/obj/item/mecha_parts/mecha_equipment/heat_sink/detach(atom/moveto)
	chassis.heat_modifier /= heat_modifier
	return ..()

/obj/item/mecha_parts/mecha_equipment/cooling
	name = "generic mech cooling system"
	desc = "If you see this, something has gone terribly wrong."
	icon_state = "radiator"
	selectable = FALSE // absolutely not
	active = TRUE
	energy_drain = 0
	heat_cost = 0
	/// The cooling rate from this equipment
	var/cooling_rate = -5

/obj/item/mecha_parts/mecha_equipment/cooling/on_process(seconds_per_tick)
	if(!chassis.overheat)
		return
	if(energy_drain)
		chassis.use_power(energy_drain * seconds_per_tick)
	chassis.adjust_overheat(cooling_rate * seconds_per_tick)

/obj/item/mecha_parts/mecha_equipment/cooling/passive
	name = "mounted radiator"
	desc = "A passive cooling radiator designed for mechanical exosuits. It's slower than active cooling, but it doesn't require power."
	cooling_rate = -1.5

/obj/item/mecha_parts/mecha_equipment/cooling/passive/on_process(seconds_per_tick)
	var/datum/gas_mixture/air_coolant = chassis.loc.return_air()
	if(!air_coolant || air_coolant.return_pressure() < HAZARD_LOW_PRESSURE)
		return ..(seconds_per_tick / 3) // less effective in low pressure
	return ..()

/obj/item/mecha_parts/mecha_equipment/cooling/active
	name = "active cooling system"
	desc = "A powered liquid-cooled radiator system. Requires power to pump the coolant around, but it's faster than passive cooling."
	cooling_rate = -3

/obj/item/mecha_parts/mecha_equipment/cooling/active/on_process(seconds_per_tick)
	if(chassis.equipment_disabled)
		return FALSE
	return ..()
