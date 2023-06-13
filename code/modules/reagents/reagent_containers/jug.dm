/obj/item/reagent_containers/glass/chem_jug
	name = "chemical jug"
	desc = "A large jug used for storing bulk ammounts chemicals. Provided with a tamper seal which ensures that the contents are pure"
	icon = 'icons/obj/chem_jug.dmi'
	icon_state = "chem_jug"
	item_state = "sheet-plastic"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 3
	volume = 150
	amount_per_transfer_from_this = 25
	possible_transfer_amounts = list(25,50,75,100,150)
	custom_materials = list(/datum/material/plastic=1000)
	fill_icon_thresholds = null
	can_have_cap = TRUE
	cap_on = TRUE
	var/tamper = TRUE
	var/tamper_cap_icon_state = "chem_jug_cap"
	cap_icon_state = "chem_jug_cap_tamper"
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound =  'sound/items/handling/device_pickup.ogg'
	lefthand_file = 'icons/mob/inhands/misc/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/sheets_righthand.dmi'

/obj/item/reagent_containers/glass/chem_jug/AltClick(mob/user)
	. = ..()
	if(tamper && !cap_on)
		tamper = FALSE
		cap_overlay = mutable_appearance(icon, tamper_cap_icon_state)
		playsound(src, 'sound/items/poster_ripped.ogg', 50, 1)
		to_chat(user, "<span class='notice'>You rip the tamper seal off of [src].</span>")

/obj/item/reagent_containers/glass/chem_jug/examine(mob/user)
	. = ..()
	if(tamper)
		if(!cap_on)
			. += "<span class='info'>The tamper seal hasn't been applied yet.</span>"
			return
		. += "<span class='green'>The tamper seal is <b>intact</b>.</span>"
	else
		. += "<span class='warning'>The tamper seal is <b>broken</b>.</span>"

/obj/item/reagent_containers/glass/chem_jug/open
	cap_on = FALSE

/obj/item/reagent_containers/glass/chem_jug/carbon
	name = "jug of carbon"
	icon_state = "chem_jug_carbon"
	list_reagents = list(/datum/reagent/carbon = 150)

/obj/item/reagent_containers/glass/chem_jug/oxygen
	name = "jug of oxygen"
	icon_state = "chem_jug_oxygen"
	list_reagents = list(/datum/reagent/oxygen = 150)

/obj/item/reagent_containers/glass/chem_jug/nitrogen
	name = "jug of nitrogen"
	icon_state = "chem_jug_nitrogen"
	list_reagents = list(/datum/reagent/nitrogen = 150)

/obj/item/reagent_containers/glass/chem_jug/hydrogen
	name = "jug of hydrogen"
	icon_state = "chem_jug_hydrogen"
	list_reagents = list(/datum/reagent/hydrogen = 150)

/obj/item/reagent_containers/glass/chem_jug/radium
	name = "jug of radium"
	icon_state = "chem_jug_radium"
	list_reagents = list(/datum/reagent/radium = 150)

/obj/item/reagent_containers/glass/chem_jug/aluminium
	name = "jug of aluminium"
	icon_state = "chem_jug_aluminium"
	list_reagents = list(/datum/reagent/aluminium = 150)

/obj/item/reagent_containers/glass/chem_jug/chlorine
	name = "jug of chlorine"
	icon_state = "chem_jug_chlorine"
	list_reagents = list(/datum/reagent/chlorine = 150)

/obj/item/reagent_containers/glass/chem_jug/copper
	name = "jug of copper"
	icon_state = "chem_jug_copper"
	list_reagents = list(/datum/reagent/copper = 150)

/obj/item/reagent_containers/glass/chem_jug/bromine
	name = "jug of bromine"
	icon_state = "chem_jug_bromine"
	list_reagents = list(/datum/reagent/bromine = 150)

/obj/item/reagent_containers/glass/chem_jug/iodine
	name = "jug of iodine"
	icon_state = "chem_jug_iodine"
	list_reagents = list(/datum/reagent/iodine = 150)

/obj/item/reagent_containers/glass/chem_jug/potassium
	name = "jug of potassium"
	icon_state = "chem_jug_potassium"
	list_reagents = list(/datum/reagent/potassium = 150)

/obj/item/reagent_containers/glass/chem_jug/sulfur
	name = "jug of sulfur"
	icon_state = "chem_jug_sulfur"
	list_reagents = list(/datum/reagent/sulfur = 150)


