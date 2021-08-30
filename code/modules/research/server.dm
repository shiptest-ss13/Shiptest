/obj/machinery/rnd/server
	desc = "A computer system running a deep neural network that processes arbitrary information to produce data useable in the development of new technologies. In layman's terms, it makes research points."
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "RD-server-on"
	var/datum/techweb/stored_research

/obj/machinery/rnd/server/on_construction()
	var/obj/item/circuitboard/machine/rdserver/board = circuit
	name = "\improper [board.server_id] research server"
	SSresearch.servers |= src
	stored_research = new(board.server_id)

/obj/machinery/rnd/server/Destroy()
	SSresearch.servers -= src
	return ..()

/obj/machinery/rnd/server/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/multitool))
		var/obj/item/multitool/multi = O
		multi.buffer = src
		to_chat(user, "<span class='notice'>[src] stored in [O].</span>")
		return TRUE

	return ..()
