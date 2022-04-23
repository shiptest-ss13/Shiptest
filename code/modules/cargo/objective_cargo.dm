// TODO for myself: This file was copied wholesale from NSV, don't forget to strip down the NSV related mission code!

#define COMSIG_FREIGHT_TAMPERED "comsig_freight_tampered"

// mission_cargos.dm has a bunch of signal code that I'm not going to touch at 3 in the morning,
// delivery_types.dm contains redundant checks that allow repackaging anyway,
// and overmap gamemodes are currently in a state that don't exactly encourage "bonus points" for untampered transfers.
// I literally just need a box right now. // Edit: hey past me you're lazy and dumb signals are great
// TODO Refactor mission_cargos.dm to handle cargo objective descriptions

/obj/structure/closet/crate/large/freight_objective/
	desc = "A hefty wooden crate. This crate is fitted with an anti-tamper seal. If you really want to open it you'll need a crowbar to get it open."
	// TODO find a new icon, or port it
	// icon = 'nsv13/icons/obj/custom_crates.dmi'
	// icon_state = "large_cargo_crate"
	var/datum/overmap_objective/cargo/overmap_objective = null
	var/datum/freight_type/single/freight_type = null

/obj/structure/closet/crate/large/freight_objective/New()
	. = ..()
	RegisterSignal( src, COMSIG_FREIGHT_TAMPERED, .proc/poll_for_ghost_sentience )

/obj/structure/closet/crate/large/freight_objective/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_CROWBAR)
		var/choice = input("WARNING: The client requests that the cargo must not be tampered with. Opening this crate may mark the objective as failed and cancel the transfer. Are you sure you wish to open it?", "WARNING!", "No") in list("Yes", "No")
		if(choice != "Yes")
			return
		if(get_dist(user, src) > 1) //Check they are still in range
			return
		// Detach the ghost poll from this proc so the crate gets opened
		SEND_SIGNAL( src, COMSIG_FREIGHT_TAMPERED )
		message_admins( "[user] opened a sealed cargo objective crate! [ADMIN_FLW(user)] [ADMIN_JMP(src)]" )
		..()

/obj/structure/closet/crate/large/freight_objective/Destroy() // Also covers destruction from weapons fire
	// TODO update this to fail a shiptest bounty, not an NSV objective
	/*
	if ( freight_type )
		if ( !freight_type.allow_replacements )
			if ( overmap_objective )
				// Mark objective as failed
				// I haven't figured out how to cleanly attach a Destroy check to prepackaged items that fail their associated transfer objective if destroyed
				// Checking against the packaging crate this way will at least prevent gamemode softlocks due to incomplete
				overmap_objective.status = 2
	*/
	..()

/obj/structure/closet/crate/large/freight_objective/proc/poll_for_ghost_sentience()
	for ( var/mob/living/simple_animal/M in contents )
		if ( rand( 1, 20 ) == 20 ) // Random sentient mob event!
			var/list/candidates = pollCandidatesForMob("Do you want to play as [M]?", ROLE_SENTIENCE, null, ROLE_SENTIENCE, 50, M, POLL_IGNORE_SENTIENCE_POTION)
			M.AIStatus = AI_ON // Keep the mob asleep unless the poll receives no candidates
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				M.key = C.key
				M.sentience_act()
				log_game("[key_name(M)] took control of [M].")
		else
			M.AIStatus = AI_ON

/obj/structure/closet/crate/large/freight_objective/examine( mob/user )
	. = ..()
	var/text = "<span class='warning'>"
	text += "This item is tagged as cargo. "

	// TODO update this to display shiptest bounty data, not NSV objective data

	/*
	if ( freight_type )
		text += "It contains [freight_type.get_brief_segment()]"
		if ( overmap_objective?.destination )
			var/obj/structure/overmap/S = overmap_objective.destination
			text += ", and needs to be delivered to [S] in system [S.current_system]. "
		else
			text += ". "
	else if ( overmap_objective?.destination )
		var/obj/structure/overmap/S = overmap_objective.destination
		text += "It needs to be delivered to [S] in system [S.current_system]. "
	*/

	// text += "<B>Opening this crate will reduce payout!</B>" // No it doesn't
	text += "</span>\n"

	. += text
