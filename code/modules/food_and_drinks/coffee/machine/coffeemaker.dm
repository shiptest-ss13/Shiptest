/obj/machinery/coffeemaker
	name = "coffeemaker"
	desc = "An Attention model coffeemaker, manufactured by Delemont Food Co, and imported from various places within the Solarian Confederation, where it is extremely popular."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "coffeemaker_nopot_nocart"
	base_icon_state = "coffeemaker"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	circuit = /obj/item/circuitboard/machine/coffeemaker
	pixel_y = 4 //needed to make it sit nicely on tables
	var/obj/item/reagent_containers/glass/coffeepot/coffeepot = null
	var/brewing = FALSE
	var/brew_time = 20 SECONDS
	var/speed = 1
	/// The coffee cartridge to make coffee from. In the future, coffee grounds are like printer ink.
	var/obj/item/coffee_cartridge/cartridge = null
	/// The type path to instantiate for the coffee cartridge the device initially comes with, eg. /obj/item/coffee_cartridge
	var/initial_cartridge = /obj/item/coffee_cartridge
	/// The number of cups left
	var/coffee_cups = 15
	var/max_coffee_cups = 15
	/// The amount of sugar packets left
	var/sugar_packs = 10
	var/max_sugar_packs = 10
	/// The amount of sweetener packets left
	var/sweetener_packs = 10
	var/max_sweetener_packs = 10
	/// The amount of creamer packets left
	var/creamer_packs = 10
	var/max_creamer_packs = 10
	var/coffeemaker_particle = /particles/smoke/steam/mild/coffeemaker

	var/static/radial_examine = image(icon = 'icons/mob/radial.dmi', icon_state = "radial_examine")
	var/static/radial_brew = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_brew")
	var/static/radial_eject_pot = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_eject_pot")
	var/static/radial_eject_cartridge = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_eject_cartridge")
	var/static/radial_take_cup = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_take_cup")
	var/static/radial_take_sugar = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_take_sugar")
	var/static/radial_take_sweetener = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_take_sweetener")
	var/static/radial_take_creamer = image(icon = 'icons/effects/radial_coffee.dmi', icon_state = "radial_take_creamer")

/obj/machinery/coffeemaker/Initialize(mapload)
	. = ..()
	if(mapload)
		coffeepot = new /obj/item/reagent_containers/glass/coffeepot(src)
		cartridge = new /obj/item/coffee_cartridge(src)
		update_icon()

/obj/machinery/coffeemaker/deconstruct(disassembled)
	coffeepot?.forceMove(drop_location())
	cartridge?.forceMove(drop_location())
	return ..()

/obj/machinery/coffeemaker/Destroy()
	QDEL_NULL(coffeepot)
	QDEL_NULL(cartridge)
	return ..()

/obj/machinery/coffeemaker/Exited(atom/movable/gone, direction)
	if(gone == coffeepot)
		coffeepot = null
	if(gone == cartridge)
		cartridge = null
	return ..()

/obj/machinery/coffeemaker/RefreshParts()
	. = ..()
	speed = 0
	for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
		speed += laser.rating

/obj/machinery/coffeemaker/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !issilicon(user) && !isobserver(user))
		. += span_warning("You're too far away to examine [src]'s contents and display!")
		return

	if(brewing)
		. += span_warning("The [src] is brewing.")
		return

	if(panel_open)
		. += span_warning("[src]'s maintenance hatch is open!")
		return

	if(coffeepot || cartridge)
		. += span_notice("\The [src] contains:")
		if(coffeepot)
			. += span_notice("\A [coffeepot].")
		if(cartridge)
			. += span_notice("\A [cartridge].")
		return

	if(!(machine_stat & (NOPOWER|BROKEN)))
		. += span_notice("The status display reads: Brewing coffee at <b>[speed*100]%</b> efficiency.")
		if(coffeepot)
			for(var/datum/reagent/consumable/cawfee as anything in coffeepot.reagents.reagent_list)
				. += span_notice("[cawfee.volume] units of coffee in pot.")
		if(cartridge)
			if(cartridge.charges < 1)
				. += span_notice("The grounds cartridge is empty.")
			else
				. += span_notice("The grounds cartridge has [cartridge.charges] charges remaining.")

	if(coffee_cups >= 1)
		. += span_notice("There [coffee_cups == 1 ? "is" : "are"] [coffee_cups] coffee cup[coffee_cups != 1 && "s"] left.")
	else
		. += span_notice("There are no cups left.")

	if(sugar_packs >= 1)
		. += span_notice("There [sugar_packs == 1 ? "is" : "are"] [sugar_packs] packet[sugar_packs != 1 && "s"] of sugar left.")
	else
		. += span_notice("There is no sugar left.")

	if(sweetener_packs >= 1)
		. += span_notice("There [sweetener_packs == 1 ? "is" : "are"] [sweetener_packs] packet[sweetener_packs != 1 && "s"] of sweetener left.")
	else
		. += span_notice("There is no sweetener left.")

	if(creamer_packs > 1)
		. += span_notice("There [creamer_packs == 1 ? "is" : "are"] [creamer_packs] packet[creamer_packs != 1 && "s"] of creamer left.")
	else
		. += span_notice("There is no creamer left.")

/obj/machinery/coffeemaker/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(brewing)
		return

/obj/machinery/coffeemaker/handle_atom_del(atom/A)
	. = ..()
	if(A == coffeepot)
		coffeepot = null
	if(A == cartridge)
		cartridge = null
	update_icon()

/obj/machinery/coffeemaker/update_overlays()
	. = ..()
	. += overlay_checks()

/obj/machinery/coffeemaker/proc/overlay_checks()
	. = list()
	if(coffeepot)
		. += "coffeemaker_pot"
	if(cartridge)
		. += "coffeemaker_cartridge"
	return .

/obj/machinery/coffeemaker/proc/replace_pot(mob/living/user, obj/item/reagent_containers/glass/coffeepot/new_coffeepot)
	if(!user)
		return FALSE
	if(coffeepot)
		if(Adjacent(usr) && !issilicon(usr))
			usr.put_in_hands(coffeepot)
		else
			coffeepot.forceMove(drop_location())
		coffeepot = null
	if(new_coffeepot)
		coffeepot = new_coffeepot
	user.visible_message(span_notice("[user] replaces the coffeepot in [src]."), span_notice("You replace the coffeepot in [src]."))
	update_icon()
	return TRUE

/obj/machinery/coffeemaker/proc/replace_cartridge(mob/living/user, obj/item/coffee_cartridge/new_cartridge)
	if(!user)
		return FALSE
	if(cartridge)
		if(Adjacent(usr) && !issilicon(usr))
			usr.put_in_hands(cartridge)
		else
			cartridge.forceMove(drop_location())
		cartridge = null
	if(new_cartridge)
		cartridge = new_cartridge
	update_icon()
	return TRUE

/obj/machinery/coffeemaker/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, 20)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/coffeemaker/attackby(obj/item/attack_item, mob/living/user, params)
	//You can only screw open empty coffeemakers
	if(!coffeepot && default_deconstruction_screwdriver(user, icon_state, icon_state, attack_item))
		return

	if(default_deconstruction_crowbar(attack_item))
		return

	if(panel_open) //Can't insert objects when its screwed open
		return TRUE

	if(istype(attack_item, /obj/item/reagent_containers/glass/coffeepot) && !(attack_item.item_flags & ABSTRACT) && attack_item.is_open_container())
		var/obj/item/reagent_containers/glass/coffeepot/new_pot = attack_item
		. = TRUE
		if(!user.transferItemToLoc(new_pot, src))
			return TRUE
		replace_pot(user, new_pot)
		update_icon()
		return TRUE

	if(istype(attack_item, /obj/item/reagent_containers/glass/coffee_cup) && !(attack_item.item_flags & ABSTRACT) && attack_item.is_open_container())
		var/obj/item/reagent_containers/glass/coffee_cup/new_cup = attack_item
		if(new_cup.reagents.total_volume > 0)
			balloon_alert(user, "the cup must be empty!")
			return TRUE
		if(coffee_cups >= max_coffee_cups)
			balloon_alert(user, "the cup holder is full!")
			return TRUE
		. = TRUE
		if(!user.transferItemToLoc(attack_item, src))
			return TRUE
		coffee_cups++
		update_icon()
		return TRUE

	if(istype(attack_item, /obj/item/reagent_containers/condiment/pack/sugar))
		var/obj/item/reagent_containers/condiment/pack/sugar/new_pack = attack_item
		if(new_pack.reagents.total_volume < new_pack.reagents.maximum_volume)
			balloon_alert(user, "the pack must be full!")
			return TRUE
		if(sugar_packs >= max_sugar_packs)
			balloon_alert(user, "the sugar compartment is full!")
			return TRUE
		. = TRUE
		if(!user.transferItemToLoc(attack_item, src))
			return TRUE
		sugar_packs++
		update_icon()
		return TRUE

	if(istype(attack_item, /obj/item/reagent_containers/condiment/creamer))
		var/obj/item/reagent_containers/condiment/creamer/new_pack = attack_item
		if(new_pack.reagents.total_volume < new_pack.reagents.maximum_volume)
			balloon_alert(user, "the pack must be full!")
			return TRUE
		if(creamer_packs >= max_creamer_packs)
			balloon_alert(user, "the creamer compartment is full!")
			return TRUE
		. = TRUE
		if(!user.transferItemToLoc(attack_item, src))
			return TRUE
		creamer_packs++
		update_icon()
		return TRUE

	if(istype(attack_item, /obj/item/reagent_containers/condiment/pack/astrotame))
		var/obj/item/reagent_containers/condiment/pack/astrotame/new_pack = attack_item
		if(new_pack.reagents.total_volume < new_pack.reagents.maximum_volume)
			balloon_alert(user, "the pack must be full!")
			return TRUE
		if(sweetener_packs >= max_sweetener_packs)
			balloon_alert(user, "the sweetener compartment is full!")
			return TRUE
		. = TRUE
		if(!user.transferItemToLoc(attack_item, src))
			return TRUE
		sweetener_packs++
		update_icon()
		return TRUE

	if(istype(attack_item, /obj/item/coffee_cartridge) && !(attack_item.item_flags & ABSTRACT))
		var/obj/item/coffee_cartridge/new_cartridge = attack_item
		. = TRUE
		if(!user.transferItemToLoc(new_cartridge, src))
			return TRUE
		replace_cartridge(user, new_cartridge)
		user.visible_message(span_notice("[user] adds a new cartridge to the [src]."), span_notice("You add the new cartridge to the [src]."))
		update_icon()
		return TRUE

/obj/machinery/coffeemaker/proc/can_brew()
	if(!cartridge)
		balloon_alert_to_viewers("no coffee cartridge inserted!")
		return FALSE
	if(cartridge.charges < 1)
		balloon_alert_to_viewers("coffee cartridge empty!")
		return FALSE
	if(!coffeepot)
		balloon_alert_to_viewers("no coffeepot inside!")
		return FALSE
	if(machine_stat & (NOPOWER|BROKEN))
		balloon_alert_to_viewers("machine unpowered!")
		return FALSE
	if(coffeepot.reagents.total_volume >= coffeepot.reagents.maximum_volume)
		balloon_alert_to_viewers("the coffeepot is already full!")
		return FALSE
	return TRUE

/obj/machinery/coffeemaker/ui_interact(mob/user) // The coffeemaker menu
	. = ..()

	if(brewing || !user.canUseTopic(src, !issilicon(user)))
		return

	var/list/options = list()

	if(coffeepot)
		options["Eject Pot"] = radial_eject_pot

	if(cartridge)
		options["Eject Cartridge"] = radial_eject_cartridge

	options["Brew"] = radial_brew //brew is always available as an option, when the machine is unable to brew, the player is told by balloon alerts what exactly is wrong

	if(coffee_cups > 0)
		options["Take Cup"] = radial_take_cup

	if(sugar_packs > 0)
		options["Take Sugar"] = radial_take_sugar

	if(sweetener_packs > 0)
		options["Take Sweetener"] = radial_take_sweetener

	if(creamer_packs > 0)
		options["Take Creamer"] = radial_take_creamer

	if(isAI(user))
		if(machine_stat & NOPOWER)
			return
		options["Examine"] = radial_examine

	var/choice

	if(length(options) < 1)
		return
	if(length(options) == 1)
		choice = options[1]
	else
		choice = show_radial_menu(user, src, options, require_near = !issilicon(user))

	// post choice verification
	if(brewing || (isAI(user) && machine_stat & NOPOWER) || !user.canUseTopic(src, !issilicon(user)))
		return

	switch(choice)
		if("Brew")
			brew(user)
		if("Eject Pot")
			eject_pot(user)
		if("Eject Cartridge")
			eject_cartridge(user)
		if("Examine")
			examine(user)
		if("Take Cup")
			take_cup(user)
		if("Take Sugar")
			take_sugar(user)
		if("Take Sweetener")
			take_sweetener(user)
		if("Take Creamer")
			take_creamer(user)

/obj/machinery/coffeemaker/proc/eject_pot(mob/user)
	if(coffeepot)
		replace_pot(user)

/obj/machinery/coffeemaker/proc/eject_cartridge(mob/user)
	if(cartridge)
		replace_cartridge(user)

/obj/machinery/coffeemaker/proc/take_cup(mob/user)
	if(!coffee_cups) //shouldn't happen, but we all know how stuff manages to break
		balloon_alert(user, "no cups left!")
		return
	var/obj/item/reagent_containers/glass/coffee_cup/new_cup = new(get_turf(src))
	user.put_in_hands(new_cup)
	coffee_cups--
	update_icon()

/obj/machinery/coffeemaker/proc/take_sugar(mob/user)
	if(!sugar_packs)
		balloon_alert(user, "no sugar left!")
		return
	var/obj/item/reagent_containers/condiment/pack/sugar/new_pack = new(get_turf(src))
	user.put_in_hands(new_pack)
	sugar_packs--
	update_icon()

/obj/machinery/coffeemaker/proc/take_sweetener(mob/user)
	if(!sweetener_packs)
		balloon_alert(user, "no sweetener left!")
		return
	var/obj/item/reagent_containers/condiment/pack/astrotame/new_pack = new(get_turf(src))
	user.put_in_hands(new_pack)
	sweetener_packs--
	update_icon()

/obj/machinery/coffeemaker/proc/take_creamer(mob/user)
	if(!creamer_packs)
		balloon_alert(user, "no creamer left!")
		return
	var/obj/item/reagent_containers/condiment/creamer/new_pack = new(get_turf(src))
	user.put_in_hands(new_pack)
	creamer_packs--
	update_icon()

///Updates the smoke state to something else, setting particles if relevant
/obj/machinery/coffeemaker/proc/toggle_steam()
	QDEL_NULL(particles)
	if(brewing)
		particles = new coffeemaker_particle()

/obj/machinery/coffeemaker/proc/operate_for(time, silent = FALSE)
	brewing = TRUE
	if(!silent)
		playsound(src, 'sound/machines/coffeemaker_brew.ogg', 20, vary = TRUE)
	toggle_steam()
	use_power(active_power_usage * time * 0.1) // .1 needed here to convert time (in deciseconds) to seconds such that watts * seconds = joules
	addtimer(CALLBACK(src, PROC_REF(stop_operating)), time / speed)

/obj/machinery/coffeemaker/proc/stop_operating()
	brewing = FALSE
	toggle_steam()

/obj/machinery/coffeemaker/proc/brew()
	power_change()
	if(!can_brew())
		return
	operate_for(brew_time)
	coffeepot.reagents.add_reagent_list(cartridge.drink_type)
	cartridge.charges--
