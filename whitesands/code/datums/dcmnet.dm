/datum/dcm_net
	/*Hub machine
		The hub machine acts as the main container for the network.
		influences the following values through proc/UpdateNetwork():
	transfer_limit = max amount of each material transfered in any given push/pull
	max_connected = number of machines that can be connected at once
	*/
	var/obj/machinery/deepcore/hub/netHub
	var/transfer_limit = 0
	var/max_connected = 0
	// List of connected machines
	var/list/obj/machinery/deepcore/connected = list()

/datum/dcm_net/New(obj/machinery/deepcore/hub/source)
	if(!source)
		stack_trace("dcm_net created without a valid source!")
		qdel(src)
	netHub = source

// ** Machine handling procs **

/datum/dcm_net/Destroy()
	netHub.network = null
	if(connected)
		for (var/obj/machinery/deepcore/M in connected)
			M.network = null
	return ..()

/datum/dcm_net/proc/AddMachine(obj/machinery/deepcore/M)
	if(connected.len >= max_connected)
		playsound(M, 'sound/machines/buzz-sigh.ogg', 30)
		M.visible_message("<span class='warning'>[M] fails to connect! The display reads 'ERROR: Connection limit reached!'</span>")
		return FALSE
	if(!(M in connected))
		connected += M
		M.network = src
		return TRUE

/datum/dcm_net/proc/RemoveMachine(obj/machinery/deepcore/M)
	if(M in connected)
		connected -= M
		M.network = null
		//Destroys the network if there's no more machines attached
		if(!length(connected))
			connected = null
			qdel(src)
		return TRUE

/datum/dcm_net/proc/MergeWith(datum/dcm_net/net)
	for (var/obj/machinery/deepcore/M in net.connected)
		AddMachine(M)
	qdel(net)

// ** Ore handling procs **

/datum/dcm_net/proc/Push(var/datum/component/material_container/cont)
	for(var/O in cont.materials)
		var/datum/material/M = O
		cont.transer_amt_to(netHub.container, transfer_limit, M)

/datum/dcm_net/proc/Pull(var/datum/component/material_container/cont)
	for(var/O in netHub.container.materials)
		var/datum/material/M = O
		netHub.container.transer_amt_to(cont, transfer_limit, M)
