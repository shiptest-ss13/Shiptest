#define SAUNA_H2O_TEMP T20C + 60
#define SAUNA_LOG_FUEL 150
#define SAUNA_MAXIMUM_FUEL 3000
#define SAUNA_WATER_PER_WATER_UNIT 5

/obj/structure/sauna_oven
	name = "sauna oven"
	desc = "A modest sauna oven with rocks. Add some fuel, pour some water and enjoy the moment."
	icon_state = "sauna"
	density = TRUE
	anchored = TRUE
	resistance_flags = FIRE_PROOF
	var/lit = FALSE
	var/fuel_amount = 0
	var/water_amount = 0

/obj/structure/sauna_oven/examine(mob/user)
	. = ..()
	. += "<span class='notice'>The rocks are [water_amount ? "moist" : "dry"].</span>"
	. += "<span class='notice'>There's [fuel_amount ? "some fuel" : "no fuel"] in the oven.</span>"

/obj/structure/sauna_oven/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(add_water))

/obj/structure/sauna_oven/proc/add_water(atom/source, list/reagents, datum/reagents/source_reagents, method, volume_modifier, show_message)
	SIGNAL_HANDLER

	if(method != TOUCH) // Only splashing/pouring
		return

	for(var/reagent in reagents)
		if(istype(reagent, /datum/reagent/water))
			water_amount += reagents[reagent] * SAUNA_WATER_PER_WATER_UNIT

/obj/structure/sauna_oven/Destroy()
	if(lit)
		STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/sauna_oven/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSobj, src)
		user.visible_message("<span class='notice'>[user] turns off [src].</span>", "<span class='notice'>You turn on [src].</span>")
	else if (fuel_amount)
		lit = TRUE
		START_PROCESSING(SSobj, src)
		user.visible_message("<span class='notice'>[user] turns on [src].</span>", "<span class='notice'>You turn off [src].</span>")
	update_icon()

/obj/structure/sauna_oven/update_overlays()
	. = ..()
	if(lit)
		. += "sauna_on_overlay"

/obj/structure/sauna_oven/update_icon()
	..()
	icon_state = "[lit ? "sauna_on" : initial(icon_state)]"

/obj/structure/sauna_oven/attackby(obj/item/T, mob/user)
	if(T.tool_behaviour == TOOL_WRENCH)
		to_chat(user, "<span class='notice'>You begin to deconstruct [src].</span>")
		if(T.use_tool(src, user, 60, volume=50))
			to_chat(user, "<span class='notice'>You successfully deconstructed [src].</span>")
			new /obj/item/stack/sheet/mineral/wood(get_turf(src), 15)
			qdel(src)

	else if(istype(T, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/wood = T
		if(fuel_amount > SAUNA_MAXIMUM_FUEL)
			to_chat(user, "<span class='warning'>You can't fit any more of [T] in [src]!</span>")
			return
		fuel_amount += SAUNA_LOG_FUEL * wood.amount
		wood.use(wood.amount)
		user.visible_message("<span class='notice'>[user] tosses some \
			wood into [src].</span>", "<span class='notice'>You add \
			some fuel to [src].</span>")
	return ..()

/obj/structure/sauna_oven/process()
	if(water_amount)
		var/used_amount = min(water_amount / 10, 20)
		water_amount -= used_amount
		var/turf/pos = get_turf(src)
		if(pos)
			pos.atmos_spawn_air("water_vapor=[used_amount];TEMP=[SAUNA_H2O_TEMP]")
	fuel_amount--

	if(fuel_amount <= 0)
		lit = FALSE
		STOP_PROCESSING(SSobj, src)
		update_icon()

#undef SAUNA_H2O_TEMP
#undef SAUNA_LOG_FUEL
#undef SAUNA_MAXIMUM_FUEL
#undef SAUNA_WATER_PER_WATER_UNIT
