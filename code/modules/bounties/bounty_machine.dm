/obj/machinery/computer/bounty
	name = "\improper Outpost bounty console"
	desc = "Used to check and claim bounties offered by the outpost"
	icon_screen = "bounty"
	circuit = /obj/item/circuitboard/computer/bounty
	light_color = COLOR_BRIGHT_ORANGE
	///Reference to the specific pad that the control computer is linked up to.
	var/datum/weakref/pad_ref

/obj/machinery/computer/bounty/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I) && istype(I.buffer,/obj/machinery/bounty_pad))
		to_chat(user, span_notice("You link [src] with [I.buffer] in [I] buffer."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

//Pad & Pad Terminal
/obj/machinery/bounty_pad
	name = "cargo hold pad"
	icon_state = "laserboxb0f"
	///This is the icon_state that this telepad uses when it's not in use.
	var/idle_state = "laserboxb0"
	///This is the icon_state that this telepad uses when it's warming up for goods teleportation.
	var/warmup_state = "laserbox_open"
	///This is the icon_state to flick when the goods are being sent off by the telepad.
	var/sending_state = "laserbox_vend"
	///This is the cargo hold ID used by the bounty_control. Match these two to link them together.
	var/cargo_hold_id
	layer = TABLE_LAYER
	resistance_flags = FIRE_PROOF
	circuit = /obj/item/circuitboard/machine/bountypad
	var/cooldown_reduction = 0

/obj/machinery/bounty_pad/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		I.buffer = src
		balloon_alert(user, "saved to multitool buffer")
		return TRUE

/obj/machinery/bounty_pad/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, warmup_state, idle_state, tool)

/obj/machinery/bounty_pad/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return default_deconstruction_crowbar(tool)

/obj/machinery/bounty_pad/proc/get_cooldown_reduction()
	return cooldown_reduction
