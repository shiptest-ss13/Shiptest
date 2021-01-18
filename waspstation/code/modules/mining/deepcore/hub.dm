GLOBAL_DATUM(dcm_net_default, /datum/dcm_net)
/obj/machinery/deepcore/hub
	name = "Deepcore Mining Control Hub"
	desc = "Houses the server which processes all connected mining equipment."
	icon_state = "hub"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/deepcore/hub

/obj/machinery/deepcore/hub/Initialize(mapload)
	. = ..()
	if(mapload)
		if(!GLOB.dcm_net_default)
			GLOB.dcm_net_default = new /datum/dcm_net(src)
		network = GLOB.dcm_net_default
	else if (!network)
		network = new /datum/dcm_net(src)
	RefreshParts()

/obj/machinery/deepcore/hub/Destroy()
	qdel(network)
	return ..()

/obj/machinery/deepcore/hub/examine(mob/user)
	. = ..()
	. += "<span class='info'>Linked to [network.connected.len] machines.</span>"
	. += "<span class='notice'>Deep core mining equipment can be linked to [src] with a multitool.</span>"

/obj/machinery/deepcore/hub/RefreshParts()
	//Matter bins = size of container
	var/MB_value = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		MB_value += MINERAL_MATERIAL_AMOUNT * 10 ** MB.rating
	container.max_amount = MB_value
	if(network)
		//Micro Laser = transfer limit
		var/ML_value = 0
		for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
			ML_value += MINERAL_MATERIAL_AMOUNT * 5 ** ML.rating
		network.transfer_limit = ML_value
		//Micro Manipulator = connected limit
		var/MM_value = 0
		for(var/obj/item/stock_parts/manipulator/MM in component_parts)
			MM_value += 3 * MM.rating + 2
		network.max_connected = MM_value

/obj/machinery/deepcore/hub/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		to_chat(user, "<span class='notice'>You load the network data on to the multitool...</span>")
		I.buffer = network
		return TRUE

/obj/machinery/deepcore/hub/ui_interact(mob/user, datum/tgui/ui)
	user.set_machine(src)
	var/datum/browser/popup = new(user, "dcm_hub", null, 600, 550)
	popup.set_content(generate_ui())
	popup.open()

/obj/machinery/deepcore/hub/proc/generate_ui()
	var/dat = "<div class='statusDisplay'><h3>Deepcore Network Hub:</h3><br>"
	dat = "<h2>Connected to [network.connected.len] machines.</h4>"
	for(var/M in network.connected)
		var/obj/machinery/deepcore/D = M
		dat += "[D.x], [D.y], [D.z] : <b>[D.name]</b>"
		dat += "<br>"
	dat += "</div>"
	return dat

// DCM NETWORK LOGIC
