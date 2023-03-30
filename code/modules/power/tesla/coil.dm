/obj/machinery/power/tesla_coil
	name = "tesla coil"
	desc = "For the union!"
	icon = 'icons/obj/tesla_engine/tesla_coil.dmi'
	icon_state = "coil0"
	base_icon_state = "coil"
	anchored = FALSE
	density = TRUE

	// Executing a traitor caught releasing tesla was never this fun!
	can_buckle = TRUE
	buckle_lying = FALSE
	buckle_requires_restraints = TRUE

	circuit = /obj/item/circuitboard/machine/tesla_coil

	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE
	var/power_loss = 2
	var/input_power_multiplier = 1
	var/zap_cooldown = 100
	var/last_zap = 0
	var/can_generate_research = TRUE

	var/datum/techweb/linked_techweb

/obj/machinery/power/tesla_coil/power
	circuit = /obj/item/circuitboard/machine/tesla_coil/power

/obj/machinery/power/tesla_coil/Initialize()
	. = ..()
	wires = new /datum/wires/tesla_coil(src)

/obj/machinery/power/tesla_coil/Destroy()
	linked_techweb = null
	. = ..()

/obj/machinery/power/tesla_coil/RefreshParts()
	var/power_multiplier = 0
	zap_cooldown = 100
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		power_multiplier += C.rating
		zap_cooldown -= (C.rating * 20)
	input_power_multiplier = power_multiplier

/obj/machinery/power/tesla_coil/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>The status display reads: Power generation at <b>[input_power_multiplier*100]%</b>.<br>Shock interval at <b>[zap_cooldown*0.1]</b> seconds.</span>"

/obj/machinery/power/tesla_coil/on_construction()
	if(anchored)
		connect_to_network()

/obj/machinery/power/tesla_coil/default_unfasten_wrench(mob/user, obj/item/I, time = 20)
	. = ..()
	if(. == SUCCESSFUL_UNFASTEN)
		if(panel_open)
			icon_state = "[base_icon_state][anchored]"
		else
			icon_state = "[base_icon_state][anchored]"
		if(anchored)
			connect_to_network()
		else
			disconnect_from_network()
//		update_cable_icons_on_turf(get_turf(src)) - WS Edit - Smartwire Revert

/obj/machinery/power/tesla_coil/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, "[base_icon_state][anchored]", "[base_icon_state][anchored]", W))
		return

	if(default_unfasten_wrench(user, W))
		return

	if(default_deconstruction_crowbar(W))
		return

	if(is_wire_tool(W) && panel_open)
		wires.interact(user)
		return

	if(istype(W, /obj/item/multitool) && can_generate_research)
		var/obj/item/multitool/multi = W
		if(istype(multi.buffer, /obj/machinery/rnd/server))
			var/obj/machinery/rnd/server/serv = multi.buffer
			linked_techweb = serv.stored_research
			visible_message("Linked to Server!")
		return

	return ..()

/obj/machinery/power/tesla_coil/zap_act(power, zap_flags, shocked_targets)
	if(anchored && !panel_open)
		obj_flags |= BEING_SHOCKED
		//don't lose arc power when it's not connected to anything
		//please place tesla coils all around the station to maximize effectiveness
		var/power_produced = powernet ? power / power_loss : power
		add_avail(power_produced*input_power_multiplier)
		flick("coilhit", src)
		var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_ENG)
		if(D)
			D.adjust_money(min(power_produced, 1))
		if(istype(linked_techweb) && (zap_flags & ZAP_GIVES_RESEARCH) && can_generate_research)
			linked_techweb.add_point_type(TECHWEB_POINT_TYPE_DEFAULT, min(power_produced, 3)) // x4 coils = 12 points a shock for RND, if they even bothered to link the server.
		addtimer(CALLBACK(src, .proc/reset_shocked), 10)
		zap_buckle_check(power)
		playsound(src.loc, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		return power_produced
	else
		. = ..()

/obj/machinery/power/tesla_coil/proc/zap()
	if((last_zap + zap_cooldown) > world.time || !powernet)
		return FALSE
	last_zap = world.time
	var/coeff = (20 - ((input_power_multiplier - 1) * 3))
	coeff = max(coeff, 10)
	var/power = (powernet.avail/2)
	add_load(power)
	playsound(src.loc, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
	tesla_zap(src, 10, power/(coeff/2), zap_flags)
	zap_buckle_check(power/(coeff/2))

// Tesla R&D researcher
/obj/machinery/power/tesla_coil/research
	name = "Tesla Corona Analyzer"
	desc = "A modified Tesla Coil used to study the effects of Edison's Bane for research. Gives research from the discharges produced by supermatter crystals, tesla engines, and electrical storms."
	icon_state = "rpcoil0"
	base_icon_state = "rpcoil"
	circuit = /obj/item/circuitboard/machine/tesla_coil/research
	power_loss = 20 // something something, high voltage + resistance

/obj/machinery/power/tesla_coil/research/zap_act(power, zap_flags, shocked_targets)
	if(anchored && !panel_open)
		obj_flags |= BEING_SHOCKED
		var/power_produced = powernet ? power / power_loss : power
		add_avail(power_produced*input_power_multiplier)
		flick("rpcoilhit", src)
		var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_ENG)
		if(D)
			D.adjust_money(min(power_produced, 12))
		if(istype(linked_techweb) && (zap_flags & ZAP_GIVES_RESEARCH))
			linked_techweb.add_point_type(TECHWEB_POINT_TYPE_DEFAULT, min(power_produced, 25)) // x4 coils = 100 points per shock, which is a good reward for building a research tesla or electrical storm harvest ship
		addtimer(CALLBACK(src, .proc/reset_shocked), 10)
		zap_buckle_check(power)
		playsound(src.loc, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		return power_produced
	else
		. = ..()

/obj/machinery/power/tesla_coil/research/default_unfasten_wrench(mob/user, obj/item/wrench/W, time = 20)
	. = ..()
	if(. == SUCCESSFUL_UNFASTEN)
		if(panel_open)
			icon_state = "rpcoil_open[anchored]"
		else
			icon_state = "rpcoil[anchored]"

/obj/machinery/power/tesla_coil/research/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, "rpcoil_open[anchored]", "rpcoil[anchored]", W))
		return
	return ..()

/obj/machinery/power/tesla_coil/research/on_construction()
	if(anchored)
		connect_to_network()

/obj/machinery/power/grounding_rod
	name = "grounding rod"
	desc = "Keep an area from being fried from Edison's Bane."
	icon = 'icons/obj/tesla_engine/tesla_coil.dmi'
	icon_state = "grounding_rod0"
	anchored = FALSE
	density = TRUE

	can_buckle = TRUE
	buckle_lying = FALSE
	buckle_requires_restraints = TRUE

/obj/machinery/power/grounding_rod/default_unfasten_wrench(mob/user, obj/item/I, time = 20)
	. = ..()
	if(. == SUCCESSFUL_UNFASTEN)
		if(panel_open)
			icon_state = "grounding_rod_open[anchored]"
		else
			icon_state = "grounding_rod[anchored]"

/obj/machinery/power/grounding_rod/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, "grounding_rod_open[anchored]", "grounding_rod[anchored]", W))
		return

	if(default_unfasten_wrench(user, W))
		return

	if(default_deconstruction_crowbar(W))
		return

	return ..()

/obj/machinery/power/grounding_rod/zap_act(power)
	if(anchored && !panel_open)
		flick("grounding_rodhit", src)
		zap_buckle_check(power)
		return 0
	else
		. = ..()

/obj/machinery/power/tesla_coil/tesla_ground //it's a no density tesla coil that you can't make into a research machine.
	name = "tesla ground"
	desc = "A tesla grounding arrangement woven into the hull plating."
	icon = 'icons/obj/singularity.dmi'
	base_icon_state = "beaconsynd"
	icon_state = "beaconsynd0" //to do: beg spriter for a real sprite

	anchored = TRUE
	density = FALSE
	can_be_unanchored = FALSE //foxes HATE booleans

	can_buckle = TRUE
	buckle_lying = TRUE
	buckle_requires_restraints = FALSE

	can_generate_research = FALSE //cannot set these to make research

	circuit = /obj/item/circuitboard/machine/tesla_ground
