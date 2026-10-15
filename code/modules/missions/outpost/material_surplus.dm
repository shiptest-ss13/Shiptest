//all hull materials, nothing else. Gold/Silver are worth enough on their own.
//IEV = Inital Export Value = Look At The Material Export Datums

/datum/mission/acquire/material
	desc = "Refined Material Bounty"

	blackbox_prefix = "Acquire Material "

	container_type = /obj/structure/material_crate
	objective_type = /obj/item/stack/sheet
	num_wanted = 0
	allow_subtypes = TRUE

	count_stacks = TRUE

	weight = 0

/datum/mission/acquire/material/New(...)
	. = ..()
	num_wanted = round(rand(200,500), 50)
	value = round(get_material_value(num_wanted), 1000)
	name = "Refined Material Bounty ([capitalize(objective_type.name)])"

//ugly way of doing this
/datum/mission/acquire/material/proc/get_material_value(amount)
	return


/datum/mission/acquire/material/iron
	desc = "Most industrial groups in the Frontier require bulk quantities of iron and are willing to pay the going market rate for consistent deliveries. This mission fulfills one such contract."
	container_type = /obj/structure/material_crate/iron
	objective_type = /obj/item/stack/sheet/plasteel
	weight = 10

/datum/mission/acquire/material/iron/get_material_value(amount)
	//amount = iron IEV * amount
	return round(2 * 35)

/datum/mission/acquire/material/titanium
	desc = "Starship-ready titanium plating is in high demand in the Frontier, with the most active buyer being the Clover Corporation. An open purchasing channel is maintained with all major outposts."
	container_type = /obj/structure/material_crate/titanium
	objective_type = /obj/item/stack/sheet/plasteel
	weight = 10

/datum/mission/acquire/material/titanium/get_material_value(amount)
	//amount = titanium IEV * amount
	return round(amount * 35)

/datum/mission/acquire/material/plasteel
	desc = "A standing subsidy is maintained by Miskilamao Spacefaring for the purchase of intact scrap pieces - including common plasteel."
	objective_type = /obj/item/stack/sheet/plasteel
	weight = 12

/datum/mission/acquire/material/plasteel/get_material_value(amount)
	//amount = iron IEV + plasma IEV * amount
	return round(amount * 27)

/datum/mission/acquire/material/plastitanium
	desc = "The New Gorlex Republic often purchases bulk quantity of refined plastitanium to fuel the expansion of its fleets. Several such contracts are up today."
	container_type = /obj/structure/material_crate/plastit
	objective_type = /obj/item/stack/sheet/mineral/plastitanium
	weight = 8

/datum/mission/acquire/material/plastitanium/get_material_value(amount)
	//amount = plasma IEV + titanium IEV * amount
	return round(amount * 60)

/obj/structure/material_crate
	name = "material crate"
	desc = "A crate meant to be filled with refined materials, such as plasteel, or plastitanium. Do you ever think about how all the alloys are plas-something?"
	icon = 'icons/obj/mining.dmi'
	icon_state = "matbox_plasteel"
	anchored = FALSE
	density = TRUE

/obj/structure/material_crate/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 16
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 100
	STR.set_holdable(list(/obj/item/stack/sheet))

/obj/structure/material_crate/examine(mob/user)
	. = ..()
	. += span_notice("You could open this by <b>Alt-clicking</b> it!")

/obj/structure/material_crate/plastit
	icon_state = "matbox_plastitanium"

/obj/structure/material_crate/iron
	icon_state = "matbox_iron"

/obj/structure/material_crate/titanium
	icon_state = "matbox_titanium"
