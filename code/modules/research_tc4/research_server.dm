/obj/machinery/research_server
	name = "defunct research server"

	/// Is this research server inside a ruin, and nonfunctional
	var/is_ruin = FALSE
	/// Maximum number of nodes this server can spawn with
	var/ruin_node_max = 2
	/// A list containing a probability map of nodes this server can spawn with
	var/list/ruin_node_list

	var/datum/research_web/web

/obj/machinery/research_server/Initialize(mapload)
	. = ..()
	web = new(src)

/obj/machinery/research_server/multitool_act(mob/living/user, obj/item/multitool/multi)
	multi.buffer = web
	to_chat(user, "<span class='notice'>You store the research web of [src] into the buffer on [multi].</span>")
	return COMPONENT_BLOCK_TOOL_ATTACK
