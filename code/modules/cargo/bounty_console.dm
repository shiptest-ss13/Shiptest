#define PRINTER_TIMEOUT 10

/obj/machinery/computer/bounty
	name = "\improper Nanotrasen bounty console"
	desc = "Used to check and claim bounties offered by Nanotrasen"
	icon_screen = "bounty"
	circuit = /obj/item/circuitboard/computer/bounty
	light_color = COLOR_BRIGHT_ORANGE
	COOLDOWN_DECLARE(printer_ready)
	var/datum/bank_account/cargocash

/obj/machinery/computer/bounty/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	cargocash = port.current_ship.ship_account

/obj/machinery/computer/bounty/Initialize()
	. = ..()
	COOLDOWN_START(src, printer_ready, PRINTER_TIMEOUT)

/obj/machinery/computer/bounty/proc/print_paper()
	new /obj/item/paper/bounty_printout(loc)

/obj/item/paper/bounty_printout
	name = "paper - Bounties"

/obj/item/paper/bounty_printout/Initialize()
	. = ..()
	default_raw_text = "<h2>Nanotrasen Cargo Bounties</h2></br>"
	update_appearance()

	for(var/datum/bounty/bounty as anything in GLOB.bounties_list)
		if(bounty.claimed)
			continue
		add_raw_text({"<h3>[bounty.name]</h3>
		<ul><li>Reward: [bounty.reward_string()]</li>
		<li>Completed: [bounty.completion_string()]</li></ul>"})

/obj/machinery/computer/bounty/ui_interact(mob/user, datum/tgui/ui)
	if(!length(GLOB.bounties_list))
		setup_bounties()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CargoBountyConsole", name)
		ui.open()

/obj/machinery/computer/bounty/ui_data(mob/user)
	var/list/data = list()
	var/list/bountyinfo = list()
	for(var/datum/bounty/bounty as anything in GLOB.bounties_list) //This should probably be static data.
		bountyinfo += list(list("name" = bounty.name, "description" = bounty.description, "reward_string" = bounty.reward_string(), "completion_string" = bounty.completion_string() , "claimed" = bounty.claimed, "can_claim" = bounty.can_claim(), "priority" = bounty.high_priority, "bounty_ref" = REF(bounty)))
	data["stored_cash"] = cargocash?.account_balance
	data["bountydata"] = bountyinfo
	return data

/obj/machinery/computer/bounty/ui_act(action,params)
	. = ..()
	if(.)
		return
	switch(action)
		if("ClaimBounty")
			var/datum/bounty/cashmoney = locate(params["bounty"]) in GLOB.bounties_list
			if(cashmoney)
				cashmoney.claim(cargocash)
			return TRUE
		if("Print")
			if(COOLDOWN_FINISHED(src, printer_ready))
				COOLDOWN_START(src, printer_ready, PRINTER_TIMEOUT)
				print_paper()
				return TRUE
