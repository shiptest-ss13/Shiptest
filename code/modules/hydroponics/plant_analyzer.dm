// Plant analyzer
/obj/item/plant_analyzer
	name = "plant analyzer"
	desc = "A scanner used to evaluate a plant's various areas of growth, chemical contents, and genetic traits."
	icon = 'icons/obj/device.dmi'
	icon_state = "hydro"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=20)
	var/scan_mode = PLANT_SCANMODE_STATS
	var/atom/scan_target

/obj/item/plant_analyzer/attack_self(mob/user)
	. = ..()
	scan_mode = !scan_mode
	to_chat(user, span_notice("You switch [src] to [scan_mode == PLANT_SCANMODE_CHEMICALS ? "scan for chemical reagents" : "scan for plant growth statistics and traits"]."))

/obj/item/plant_analyzer/attack(mob/living/M, mob/living/carbon/human/user)
	//Checks if target is a podman
	if(ispodperson(M))
		user.visible_message(span_notice("[user] analyzes [M]'s vitals."), \
							span_notice("You analyze [M]'s vitals."))
		if(scan_mode == PLANT_SCANMODE_STATS)
			healthscan(user, M, advanced = TRUE)
		else
			chemscan(user, M)
		add_fingerprint(user)
		return
	return ..()

/obj/item/plant_analyzer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(can_scan_target(target))
		change_target(target, user)

/obj/item/plant_analyzer/proc/can_scan_target(atom/target)
	if(istype(target, /obj/machinery/hydroponics) || istype(target, /obj/item/seeds) || istype(target, /obj/item/food/grown))
		return TRUE

/obj/item/plant_analyzer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PlantAnalyzer", name)
		ui.open()

/obj/item/plant_analyzer/ui_close(mob/user)
	scan_target = null

/obj/item/plant_analyzer/ui_data(mob/user)
	. = ..()
	var/list/data = list()

	var/obj/machinery/hydroponics/tray
	var/obj/item/seeds/my_seed
	var/obj/item/food/grown/product

	var/temp_seed = FALSE
	var/temp_product = FALSE

	data["tray"] = list()
	data["seed"] = list()

	if(ispath(text2path(scan_target), /obj/item/seeds))
		my_seed = new scan_target
		temp_seed = TRUE

	else if(istype(scan_target, /obj/machinery/hydroponics))
		tray = scan_target
		if(tray.myseed)
			my_seed = tray.myseed

	else if(istype(scan_target, /obj/item/seeds))
		my_seed = scan_target

	else if(istype(scan_target, /obj/item/food/grown))
		product = scan_target

	if(product && !my_seed)
		my_seed = product.seed

	if(my_seed && !product && ispath(my_seed.product, /obj/item/food/grown))
		product = new my_seed.product
		temp_product = TRUE

	if(tray)
		data["tray"] = tray.get_tgui_info()
	if(my_seed)
		data["seed"] = my_seed.get_tgui_info()
	//if(product)
	//	data["seed"] += product.get_tgui_info() todo make fallcon fix this

	if(temp_seed)
		qdel(my_seed)
	if(temp_product)
		qdel(product)
	return data

/obj/item/plant_analyzer/ui_static_data(mob/user)
	var/list/data = list()
	data["cycle_seconds"] = HYDROTRAY_CYCLE_DELAY / 10
	data["trait_db"] = list()
	for(var/trait_path in subtypesof(/datum/plant_gene/trait))
		var/datum/plant_gene/trait/trait = new trait_path
		var/trait_data = list(list(
			"path" = trait.type,
			"name" = trait.name,
			"description" = trait.description
		))
		data["trait_db"] += trait_data
	return data

/obj/item/plant_analyzer/ui_act(action, list/params)
	. = ..()
	switch(action)
		if("investigate_plant")
			var/seed = params["mutation_type"]
			if(seed)
				change_target(seed, usr)

/obj/item/plant_analyzer/ui_status(mob/user)
	if(isobj(scan_target) && !can_scan_target(scan_target))
		return UI_CLOSE
	. = ..()

/obj/item/plant_analyzer/proc/change_target(target, mob/user)
	if(target != scan_target)
		scan_target = target
	ui_interact(user)


