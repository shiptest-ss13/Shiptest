/obj/item/reagent_containers/glass/chem_jug
	name = "chemical jug"
	desc = "A large jug used for storing bulk quantities of chemicals. Provided with an anti-tamper seal which ensures that the contents are pure."
	icon = 'icons/obj/chemical/chem_jug.dmi' // the coloring of labels for elemental chemicals is based on the chemical group block coloring at https://pubchem.ncbi.nlm.nih.gov/periodic-table/ . Everything else is whatever.
	icon_state = "chem_jug"
	item_state = "sheet-plastic"
	w_class = WEIGHT_CLASS_BULKY
	reagent_flags = REFILLABLE | DUNKABLE
	throw_range = 2
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

/obj/item/reagent_containers/glass/chem_jug/attack_self_secondary(mob/user)
	. = ..()
	if(tamper && !cap_on)
		tamper = FALSE
		cap_overlay = mutable_appearance(icon, tamper_cap_icon_state)
		playsound(src, 'sound/items/poster_ripped.ogg', 50, 1)
		to_chat(user, span_notice("You rip the tamper seal off of [src]."))

/obj/item/reagent_containers/glass/chem_jug/examine(mob/user)
	. = ..()
	if(tamper)
		if(!cap_on)
			. += span_info("The tamper seal hasn't been applied yet.")
			return
		. += span_green("The tamper seal is <b>intact</b>.")
	else
		. += span_warning("The tamper seal is <b>broken</b>.")


/obj/item/reagent_containers/glass/chem_jug/SplashReagents(atom/target, thrown = FALSE)
	if(!reagents || !reagents.total_volume || !spillable)
		return

	if(ismob(target) && target.reagents)
		if(thrown)
			reagents.total_volume *= rand(1,3) * 0.1 //little makes contact with the target
		var/mob/M = target
		var/R
		playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
		target.visible_message(span_danger("[M] is splashed with something!"), \
						span_userdanger("[M] is splashed with something!"))
		for(var/datum/reagent/A in reagents.reagent_list)
			R += "[A.type]  ([num2text(A.volume)]),"

		if(thrownby)
			log_combat(thrownby, M, "splashed", R)
		reagents.expose(target, TOUCH, 0.3)

	else if(bartender_check(target) && thrown)
		visible_message(span_notice("[src] lands onto the [target.name] without spilling a single drop."))
		return

	else
		if(isturf(target) && reagents.reagent_list.len && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
			log_game("[key_name(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
			message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [ADMIN_VERBOSEJMP(target)].")
		playsound(src, 'sound/items/glass_splash.ogg', 50, 1)
		visible_message(span_notice("[src] spills its contents all over [target]."))
		reagents.expose(target, TOUCH, 0.3)
		if(QDELETED(src))
			return

	reagents.remove_any(45)

/obj/item/reagent_containers/glass/chem_jug/open
	cap_on = FALSE

/obj/item/reagent_containers/glass/chem_jug/aluminium
	name = "chemical jug (aluminium)"
	icon_state = "chem_jug_aluminium"
	list_reagents = list(/datum/reagent/aluminium = 150)

/obj/item/reagent_containers/glass/chem_jug/bromine
	name = "chemical jug (bromine)"
	icon_state = "chem_jug_bromine"
	list_reagents = list(/datum/reagent/bromine = 150)

/obj/item/reagent_containers/glass/chem_jug/carbon
	name = "chemical jug (carbon)"
	icon_state = "chem_jug_carbon"
	list_reagents = list(/datum/reagent/carbon = 150)

/obj/item/reagent_containers/glass/chem_jug/chlorine
	name = "chemical jug (chlorine)"
	icon_state = "chem_jug_chlorine"
	list_reagents = list(/datum/reagent/chlorine = 150)

/obj/item/reagent_containers/glass/chem_jug/copper
	name = "chemical jug (copper)"
	icon_state = "chem_jug_copper"
	list_reagents = list(/datum/reagent/copper = 150)

/obj/item/reagent_containers/glass/chem_jug/fluorine
	name = "chemical jug (fluorine)"
	icon_state = "chem_jug_fluorine"
	list_reagents = list(/datum/reagent/fluorine = 150)

/obj/item/reagent_containers/glass/chem_jug/hydrogen
	name = "chemical jug (hydrogen)"
	icon_state = "chem_jug_hydrogen"
	list_reagents = list(/datum/reagent/hydrogen = 150)

/obj/item/reagent_containers/glass/chem_jug/iodine
	name = "chemical jug (iodine)"
	icon_state = "chem_jug_iodine"
	list_reagents = list(/datum/reagent/iodine = 150)

/obj/item/reagent_containers/glass/chem_jug/lithium
	name = "chemical jug (lithium)"
	icon_state = "chem_jug_lithium"
	list_reagents = list(/datum/reagent/lithium = 150)

/obj/item/reagent_containers/glass/chem_jug/mercury
	name = "chemical jug (mercury)"
	icon_state = "chem_jug_mercury"
	list_reagents = list(/datum/reagent/mercury = 150)

/obj/item/reagent_containers/glass/chem_jug/nitrogen
	name = "chemical jug (nitrogen)"
	icon_state = "chem_jug_nitrogen"
	list_reagents = list(/datum/reagent/nitrogen = 150)

/obj/item/reagent_containers/glass/chem_jug/oxygen
	name = "chemical jug (oxygen)"
	icon_state = "chem_jug_oxygen"
	list_reagents = list(/datum/reagent/oxygen = 150)

/obj/item/reagent_containers/glass/chem_jug/phosphorus
	name = "chemical jug (phosphorus)"
	icon_state = "chem_jug_phosphorus"
	list_reagents = list(/datum/reagent/phosphorus = 150)

/obj/item/reagent_containers/glass/chem_jug/potassium
	name = "chemical jug (potassium)"
	icon_state = "chem_jug_potassium"
	list_reagents = list(/datum/reagent/potassium = 150)

/obj/item/reagent_containers/glass/chem_jug/radium
	name = "chemical jug (radium)"
	icon_state = "chem_jug_radium"
	list_reagents = list(/datum/reagent/uranium/radium = 150)

/obj/item/reagent_containers/glass/chem_jug/sodium
	name = "chemical jug (sodium)"
	icon_state = "chem_jug_sodium"
	list_reagents = list(/datum/reagent/sodium = 150)

/obj/item/reagent_containers/glass/chem_jug/sulfur
	name = "chemical jug (sulfur)"
	icon_state = "chem_jug_sulfur"
	list_reagents = list(/datum/reagent/sulfur = 150)

/obj/item/reagent_containers/glass/chem_jug/thermite // not giving this its own "elemental" jug sprite.
	name = "chemical jug (thermite)"
	list_reagents = list(/datum/reagent/thermite = 150)

/obj/item/reagent_containers/glass/chem_jug/hexacrete
	name = "chemical jug (hexacrete)"
	list_reagents = list(/datum/reagent/concrete/hexacrete = 150)

/obj/item/reagent_containers/glass/chem_jug/eznutriment
	name = "chemical jug (E-Z-Nutrient)"
	list_reagents = list(/datum/reagent/plantnutriment/eznutriment = 150)

/obj/item/reagent_containers/glass/chem_jug/left4zednutriment
	name = "chemical jug (Left 4 Zed)"
	list_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 150)

/obj/item/reagent_containers/glass/chem_jug/robustharvestnutriment
	name = "chemical jug (Robust Harvest)"
	list_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 150)

/obj/item/reagent_containers/glass/chem_jug/endurogrow
	name = "chemical jug (Enduro Grow)"
	list_reagents = list(/datum/reagent/plantnutriment/endurogrow = 150)

/obj/item/reagent_containers/glass/chem_jug/liquidearthquake
	name = "chemical jug (Liquid Earthquake)"
	list_reagents = list(/datum/reagent/plantnutriment/liquidearthquake = 150)
