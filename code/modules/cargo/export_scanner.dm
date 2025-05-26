/obj/item/export_scanner
	name = "export scanner"
	desc = "A device used to check objects against exports and bounty database."
	icon = 'icons/obj/device.dmi'
	icon_state = "export_scanner"
	item_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	siemens_coefficient = 1

/obj/item/export_scanner/afterattack(obj/O, mob/user, proximity)
	. = ..()
	if(!istype(O) || !proximity)
		return

	var/datum/export_report/ex = export_item_and_contents(O, dry_run=TRUE)
	var/cost = 0
	for(var/x in ex.total_amount)
		cost += ex.total_value[x]

	if(cost)
		to_chat(user, span_notice("Scanned [O], value: <b>[cost]</b> credits[O.contents.len ? " (contents included)" : ""]."))
	else
		to_chat(user, span_warning("Scanned [O], no export value."))
