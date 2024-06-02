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
	var/delete_product = FALSE
	data["tray"] = list()
	data["seed"] = list()
	data["product"] = list()
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
		data["tray"]["dead"] = tray.dead
		data["tray"]["harvest"] = tray.harvest
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
			/*
			if(istype(traits, /datum/plant_gene/trait/plant_type))
				continue
			*/
			data["seed"]["genes"] += traits.type

		data["seed"]["mutatelist"] = list()
		for(var/obj/item/seeds/mutant as anything in my_seed.mutatelist)
			data["seed"]["mutatelist"] += initial(mutant.plantname)


	if(product)
		data["product"]["name"] = product.name

		if(istype(product, /obj/item/reagent_containers/food/snacks/grown))
			var/datum/reagent/product_distill_reagent = product.distill_reagent
			data["product"]["distill_reagent"] = initial(product_distill_reagent.name)

			data["product"]["juice_results"] = list()
			for(var/datum/reagent/reagent as anything in product.juice_results)
				data["product"]["juice_results"] += initial(reagent.name)

		data["product"]["grind_results"] = list()
		for(var/reagent_id in my_seed.reagents_add)
			var/datum/reagent/seed_reagent  = GLOB.chemical_reagents_list[reagent_id]
			var/amt = product.reagents.get_reagent_amount(reagent_id)
			data["product"]["grind_results"] += "[seed_reagent.name]: [amt]"

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

// *************************************
// Hydroponics Tools
// *************************************

/obj/item/reagent_containers/spray/weedspray // -- Skie
	desc = "It's a toxic mixture, in spray form, to kill small weeds."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	name = "weed spray"
	icon_state = "weedspray"
	item_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 100)

/obj/item/reagent_containers/spray/pestspray // -- Skie
	desc = "It's some pest eliminator spray! <I>Do not inhale!</I>"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	name = "pest spray"
	icon_state = "pestspray"
	item_state = "plantbgone"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/pestkiller = 100)

/obj/item/cultivator
	name = "cultivator"
	desc = "It's used for removing weeds or scratching your back."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cultivator"
	item_state = "cultivator"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("slashed", "sliced", "cut", "clawed")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/cultivator/rake
	name = "rake"
	icon_state = "rake"
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "bashed", "clawed")
	hitsound = null
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.5)
	flags_1 = NONE
	resistance_flags = FLAMMABLE

/obj/item/cultivator/rake/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/cultivator/rake/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	if(has_gravity(loc) && HAS_TRAIT(H, TRAIT_CLUMSY) && !H.resting)
		H.confused = max(H.confused, 10)
		H.Stun(20)
		playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
		H.visible_message(
			"<span class='warning'>[H] steps on [src] causing the handle to hit [H.p_them()] right in the face!</span>", \
			"<span class='userdanger'>You step on [src] causing the handle to hit you right in the face!</span>")

/obj/item/hatchet
	name = "hatchet"
	desc = "A very sharp axe blade upon a short fibremetal handle. It has a long history of chopping things, but now it is used for chopping wood."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "hatchet"
	item_state = "hatchet"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 12
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 3
	throw_range = 4
	custom_materials = list(/datum/material/iron = 15000)
	attack_verb = list("chopped", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP

/obj/item/hatchet/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)

/obj/item/hatchet/wooden
	desc = "A crude axe blade upon a short wooden handle."
	icon_state = "woodhatchet"
	custom_materials = null
	flags_1 = NONE

/obj/item/scythe
	icon_state = "scythe0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "scythe"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	force = 13
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	armour_penetration = 20
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("chopped", "sliced", "cut", "reaped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/swiping = FALSE

/obj/item/scythe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 90, 105)

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params)
	if(swiping || !istype(A, /obj/structure/spacevine) || get_turf(A) == get_turf(user))
		return ..()
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(A))
	swiping = TRUE
	var/static/list/scythe_slash_angles = list(0, 45, 90, -45, -90)
	for(var/i in scythe_slash_angles)
		var/turf/T = get_step(user_turf, turn(dir_to_target, i))
		for(var/obj/structure/spacevine/V in T)
			if(user.Adjacent(V))
				melee_attack_chain(user, V)
	swiping = FALSE
	return TRUE

// *************************************
// Nutrient defines for hydroponics
// *************************************


/obj/item/reagent_containers/glass/bottle/nutrient
	name = "bottle of nutrient"
	volume = 50
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/glass/bottle/nutrient/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)


/obj/item/reagent_containers/glass/bottle/nutrient/ez
	name = "bottle of E-Z-Nutrient"
	desc = "Contains a fertilizer that causes mild mutations with each harvest."
	list_reagents = list(/datum/reagent/plantnutriment/eznutriment = 50)

/obj/item/reagent_containers/glass/bottle/nutrient/l4z
	name = "bottle of Left 4 Zed"
	desc = "Contains a fertilizer that limits plant yields to no more than one and causes significant mutations in plants."
	list_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 50)

/obj/item/reagent_containers/glass/bottle/nutrient/rh
	name = "bottle of Robust Harvest"
	desc = "Contains a fertilizer that increases the yield of a plant by 30% while causing no mutations."
	list_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 50)

/obj/item/reagent_containers/glass/bottle/killer
	volume = 50
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/glass/bottle/killer/weedkiller
	name = "bottle of weed killer"
	desc = "Contains a herbicide."
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 50)

/obj/item/reagent_containers/glass/bottle/killer/pestkiller
	name = "bottle of pest spray"
	desc = "Contains a pesticide."
	list_reagents = list(/datum/reagent/toxin/pestkiller = 50)
