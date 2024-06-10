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
	to_chat(user, "<span class='notice'>You switch [src] to [scan_mode == PLANT_SCANMODE_CHEMICALS ? "scan for chemical reagents" : "scan for plant growth statistics and traits"].</span>")

/obj/item/plant_analyzer/attack(mob/living/M, mob/living/carbon/human/user)
	//Checks if target is a podman
	if(ispodperson(M))
		user.visible_message("<span class='notice'>[user] analyzes [M]'s vitals.</span>", \
							"<span class='notice'>You analyze [M]'s vitals.</span>")
		if(scan_mode == PLANT_SCANMODE_STATS)
			healthscan(user, M, advanced = TRUE)
		else
			chemscan(user, M)
		add_fingerprint(user)
		return
	return ..()

/obj/item/plant_analyzer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	scan_target = null
	if(isobj(target))
		scan_target = target
	ui_interact(user)

/obj/item/plant_analyzer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PlantAnalyzer", name)
		ui.open()

/obj/item/plant_analyzer/ui_data(mob/user)
	. = ..()
	var/list/data = list()
	var/obj/item/seeds/my_seed
	var/obj/item/reagent_containers/food/snacks/grown/product
	var/delete_seed = FALSE
	var/delete_product = FALSE
	data["tray"] = list()
	data["seed"] = list()
	data["product"] = list()

	if(ispath(scan_target, /obj/item/seeds))
		my_seed = new scan_target
		delete_seed = TRUE

	if(istype(scan_target, /obj/machinery/hydroponics))
		var/obj/machinery/hydroponics/tray = scan_target
		data["tray"]["name"] = tray.name
		data["tray"]["weeds"] = tray.weedlevel
		data["tray"]["pests"] = tray.pestlevel
		data["tray"]["toxic"] = tray.toxic
		data["tray"]["water"] = tray.waterlevel
		data["tray"]["maxwater"] = tray.maxwater
		data["tray"]["nutrients"] = tray.reagents.total_volume
		data["tray"]["maxnutri"] = tray.maxnutri
		data["tray"]["age"] = tray.age
		data["tray"]["status"] = tray.get_plant_status()
		data["tray"]["self_sustaining"] = tray.self_sustaining

		if(tray.myseed)
			my_seed = tray.myseed

	else if(istype(scan_target, /obj/item/seeds))
		my_seed = scan_target

	else if(istype(scan_target, /obj/item/reagent_containers/food/snacks/grown))
		var/obj/item/reagent_containers/food/snacks/grown/plant = scan_target
		product = plant
		my_seed = plant.seed

	else if(istype(scan_target, /obj/item/grown))
		var/obj/item/grown/plant = scan_target
		my_seed = plant.seed

	if(my_seed)
		product = new my_seed.product
		delete_product = TRUE
		data["seed"]["name"] = my_seed.plantname
		data["seed"]["lifespan"] = my_seed.lifespan
		data["seed"]["endurance"] = my_seed.endurance
		data["seed"]["maturation"] = my_seed.maturation
		data["seed"]["production"] = my_seed.production
		data["seed"]["yield"] = my_seed.yield
		data["seed"]["potency"] = my_seed.potency
		data["seed"]["instability"] = my_seed.instability
		data["seed"]["weed_rate"] = my_seed.weed_rate
		data["seed"]["weed_chance"] = my_seed.weed_chance
		data["seed"]["rarity"] = my_seed.rarity
		data["seed"]["genes"] = list()
		for(var/datum/plant_gene/trait/traits in my_seed.genes)
			data["seed"]["genes"] += traits.type

		data["seed"]["mutatelist"] = list()
		for(var/obj/item/seeds/mutant as anything in my_seed.mutatelist)
			data["seed"]["mutatelist"] += list(list(
				"type" = REF(mutant),
				"name" = initial(mutant.plantname),
				"desc" = initial(mutant.desc)
			))


	if(product)
		data["product"]["name"] = product.name

		if(istype(product, /obj/item/reagent_containers/food/snacks/grown))
			var/datum/reagent/product_distill_reagent = product.distill_reagent
			data["product"]["distill_reagent"] = initial(product_distill_reagent.name)

			data["product"]["juice_result"] = list()
			for(var/datum/reagent/reagent as anything in product.juice_results)
				data["product"]["juice_result"] += initial(reagent.name)

		data["product"]["grind_results"] = list()
		for(var/reagent_id in my_seed.reagents_add)
			var/datum/reagent/seed_reagent  = GLOB.chemical_reagents_list[reagent_id]
			var/amt = product.reagents.get_reagent_amount(reagent_id)
			data["product"]["grind_results"] += list(list(
				"name" = seed_reagent.name,
				"desc" = seed_reagent.description,
				"amount" = amt
			))

	if(delete_seed)
		qdel(my_seed)
	if(delete_product)
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
			"description" = trait.examine_line
		))
		data["trait_db"] += trait_data
	return data

/obj/item/plant_analyzer/ui_act(action, list/params)
	. = ..()
	switch(action)
		if("investigate_plant")
			var/obj/item/seeds/seed = params["mutation_type"]
			if(seed)
				scan_target = seed

