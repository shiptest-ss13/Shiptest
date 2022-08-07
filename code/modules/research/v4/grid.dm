/datum/research_grid
	var/datum/research_node/parent_node
	var/datum/research_web/parent_web
	var/obj/machinery/research_linked/parent_machine

	var/completed = FALSE

/datum/research_grid/New(node, web, machine)
	parent_node = node
	parent_web = web
	parent_machine = machine

	if(!istype(parent_node) || !istype(parent_web) || !istype(parent_machine))
		stack_trace("Research Grid created with invalid arguments")
		qdel_self()
		return

/datum/research_grid/Destroy(force, ...)
	parent_node = null
	parent_web = null
	parent_machine = null
	return ..()

/datum/research_grid/proc/complete(mob/user)
	parent_web.finish_research_node(user, parent_machine, parent_node.id)
	completed = TRUE
	refresh()

/datum/research_grid/proc/refresh()
	for(var/datum/tgui/tgui as anything in SStgui.open_uis_by_src[src])
		to_chat(tgui.user, span_notice("Research completed."))
		tgui.send_full_update()

/datum/research_grid/ui_host(mob/user)
	return parent_machine.ui_host(user)

/datum/research_grid/ui_status(mob/user, datum/ui_state/state)
	return parent_machine.ui_status(user, state)

/datum/research_grid/ui_close(mob/user)
	if(!completed)
		return
	if(length(SStgui.open_uis_by_src[src]) == 1)
		qdel_self()

/datum/research_grid/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ResearchGrid")
		ui.set_autoupdate(TRUE)
		ui.open()

/datum/research_grid/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return .

	switch(action)
		if("debug-complete")
			complete(usr)
