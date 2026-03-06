/datum/mission/acquire/dogtags
	name = "Pirate Hunting Stipend"
	desc = ""
	value = 2000
	container_type = /obj/item/storage/dogtag_case


	///The item that this mission wants
	objective_type = null
	///How many of this item does the mission want?
	num_wanted = 10
	weight = 0
	var/pirate_type = ""

/datum/mission/acquire/dogtags/New(...)
	. = ..()
	num_wanted = rand(num_wanted-4,num_wanted+6)
	if(!desc)
		desc = "The [pirate_type] are ramping up activity near [source_outpost]. We are offering a [value]cr bounty to kill at least [num_wanted] of them, in addition to the usual pirate bounty. \
		Retrieve their dogtags, put them in the provided case, and return it to us to complete the bounty."
	value += (num_wanted*200)

/datum/mission/acquire/dogtags/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc, obj/hangar_crate_spawner/cargo_belt)
	. = ..()
	container.name = "dogtag case ([num_wanted] [pirate_type] dogtags)"

/datum/mission/acquire/dogtags/ramzi
	name = "Ramzi Clique Bounty"
	desc = null
	objective_type = /obj/item/clothing/neck/dogtag/ramzi
	weight = 8
	num_wanted = 8
	pirate_type = "Ramzi Clique"

/datum/mission/acquire/dogtags/frontier
	name = "New Frontiersman Bounty"
	desc = null
	objective_type = /obj/item/clothing/neck/dogtag/frontier
	weight = 8
	pirate_type = "New Frontiersmen"

/obj/item/storage/dogtag_case
	name = "dogtag case"
	desc = "A box designed to hold a collection of dogtags."
	icon = 'icons/obj/guncase.dmi'
	icon_state = "guncase"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	item_state = "infiltrator_case"
	force = 12
	throwforce = 12
	throw_speed = 2
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("bonked")
	hitsound = 'sound/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox_pickup.ogg'

/obj/item/storage/dogtag_case/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 40
	STR.set_holdable(list(/obj/item/clothing/neck/dogtag))
