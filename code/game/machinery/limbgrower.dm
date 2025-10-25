/// The limbgrower. Makes organd and limbs with synthflesh and chems.
/// See [limbgrower_designs.dm] for everything we can make.
/obj/machinery/limbgrower
	name = "limb grower"
	desc = "It grows new limbs using Synthflesh."
	icon = 'icons/obj/machines/limbgrower.dmi'
	icon_state = "limbgrower_idleoff"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = ACTIVE_DRAW_LOW
	circuit = /obj/item/circuitboard/machine/limbgrower

	/// The category of limbs we're browing in our UI.
	var/selected_category = "human"
	/// If we're currently printing something.
	var/busy = FALSE
	/// How efficient our machine is. Better parts = less chemicals used and less power used. Range of 1 to 0.25.
	var/production_coefficient = 1
	/// How long it takes for us to print a limb. Affected by production_coefficient.
	var/production_speed = 3 SECONDS
	/// The design we're printing currently.
	var/datum/design/being_built
	/// Our internal techweb for limbgrower designs.
	var/datum/techweb/stored_research
	/// All the categories of organs we can print.
	var/list/categories = list(SPECIES_HUMAN,SPECIES_SARATHI,SPECIES_MOTH,SPECIES_PLASMAMAN,SPECIES_ELZUOSE,SPECIES_RACHNID,SPECIES_KEPORI,SPECIES_VOX,"other")
	//yogs grower a little different because we're going to allow meats to be converted to synthflesh because hugbox
	var/list/accepted_biomass = list(
		/obj/item/food/meat/slab/monkey = 25,
		/obj/item/food/meat/slab/synthmeat = 34,
		/obj/item/food/meat/slab = 50,
		/obj/item/stack/sheet/animalhide/human = 50
		)
	var/biomass_per_slab = 20

/obj/machinery/limbgrower/Initialize(mapload)
	create_reagents(100, OPENCONTAINER)
	stored_research = new /datum/techweb/specialized/autounlocking/limbgrower
	. = ..()
	AddComponent(/datum/component/plumbing/simple_demand)

/obj/machinery/limbgrower/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Limbgrower")
		ui.open()

/obj/machinery/limbgrower/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/limbgrower/ui_data(mob/user)
	var/list/data = list()

	for(var/datum/reagent/reagent_id in reagents.reagent_list)
		var/list/reagent_data = list(
			reagent_name = reagent_id.name,
			reagent_amount = reagent_id.volume,
			reagent_type = reagent_id.type
		)
		data["reagents"] += list(reagent_data)

	data["total_reagents"] = reagents.total_volume
	data["max_reagents"] = reagents.maximum_volume
	data["busy"] = busy

	return data

/obj/machinery/limbgrower/ui_static_data(mob/user)
	var/list/data = list()
	data["categories"] = list()

	var/species_categories = categories.Copy()
	for(var/species in species_categories)
		species_categories[species] = list()
	for(var/design_id in stored_research.researched_designs)
		var/datum/design/limb_design = SSresearch.techweb_design_by_id(design_id)
		for(var/found_category in species_categories)
			if(found_category in limb_design.category)
				species_categories[found_category] += limb_design

	for(var/category in species_categories)
		var/list/category_data = list(
			name = category,
			designs = list(),
		)
		for(var/datum/design/found_design as anything in species_categories[category])
			var/list/all_reagents = list()
			for(var/reagent_typepath in found_design.reagents_list)
				var/datum/reagent/reagent_id = find_reagent_object_from_type(reagent_typepath)
				var/list/reagent_data = list(
					name = reagent_id.name,
					amount = (found_design.reagents_list[reagent_typepath] * production_coefficient),
				)
				all_reagents += list(reagent_data)

			category_data["designs"] += list(list(
				parent_category = category,
				name = found_design.name,
				id = found_design.id,
				needed_reagents = all_reagents,
			))

		data["categories"] += list(category_data)

	return data

/obj/machinery/limbgrower/on_deconstruction()
	for(var/obj/item/reagent_containers/glass/our_beaker in component_parts)
		reagents.trans_to(our_beaker, our_beaker.reagents.maximum_volume)
	..()

/obj/machinery/limbgrower/attackby(obj/item/user_item, mob/living/user, params)
	if (busy)
		to_chat(user, span_warning("The Limb Grower is busy. Please wait for completion of previous operation."))
		return

	if(istype(user_item, /obj/item/disk/design_disk/limbs))
		user.visible_message(span_notice("[user] begins to load \the [user_item] in \the [src]..."),
			span_notice("You begin to load designs from \the [user_item]..."),
			span_hear("You hear the clatter of a floppy drive."))
		busy = TRUE
		var/obj/item/disk/design_disk/limbs/limb_design_disk = user_item
		if(do_after(user, 2 SECONDS, target = src))
			if(!(limb_design_disk.species in categories))
				categories += limb_design_disk.species
			// for(var/datum/design/found_design in limb_design_disk.blueprints)
			// 	stored_research.add_design(found_design)
			update_static_data(user)
		busy = FALSE
		return

	//yogs start hugbox code
	var/biomass = 0
	if(user_item.type in accepted_biomass)
		busy = TRUE
		if(istype(user_item, /obj/item/stack/sheet))
			var/obj/item/stack/S = user_item
			biomass += S.amount * accepted_biomass[user_item.type] //we need special code because stacks are cringe
			handle_biomass(user_item, biomass, user)
		else
			biomass += accepted_biomass[user_item.type] // changes biomass to whatever slab it picked
			handle_biomass(user_item, biomass, user)
		return
	else if(istype(user_item, /obj/item/food/meat/slab)) // If no special slab was picked it reverts to var/biomass_per_slab
		busy = TRUE
		biomass += biomass_per_slab
		handle_biomass(user_item, biomass, user)
		return
	//end yog hugbox code

	if(default_deconstruction_screwdriver(user, "limbgrower_panelopen", "limbgrower_idleoff", user_item))
		ui_close(user)
		return

	if(panel_open && default_deconstruction_crowbar(user_item))
		return

/obj/machinery/limbgrower/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	if (busy)
		to_chat(usr, span_warning("The limb grower is busy. Please wait for completion of previous operation."))
		return

	switch(action)

		if("empty_reagent")
			reagents.del_reagent(text2path(params["reagent_type"]))
			. = TRUE

		if("make_limb")
			being_built = stored_research.isDesignResearchedID(params["design_id"])
			if(!being_built)
				CRASH("[src] was passed an invalid design id!")

			/// All the reagents we're using to make our organ.
			var/list/consumed_reagents_list = being_built.reagents_list.Copy()
			/// The amount of power we're going to use, based on how much reagent we use.
			var/power = 0

			for(var/reagent_id in consumed_reagents_list)
				consumed_reagents_list[reagent_id] *= production_coefficient
				if(!reagents.has_reagent(reagent_id, consumed_reagents_list[reagent_id]))
					audible_message(span_notice("The [src] buzzes."))
					playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
					return

				power = max(active_power_usage, (power + consumed_reagents_list[reagent_id]))

			busy = TRUE
			use_power(power)
			flick("limbgrower_fill",src)
			icon_state = "limbgrower_idleon"
			selected_category = params["active_tab"]
			addtimer(CALLBACK(src, PROC_REF(build_item), consumed_reagents_list), production_speed * production_coefficient)
			. = TRUE

	return

/*
 * The process of beginning to build a limb or organ.
 * Goes through and sanity checks that we actually have enough reagent to build our item.
 * Then, remove those reagents from our reagents datum.
 *
 * After the reagents are handled, we can proceede with making the limb or organ. (Limbs are handled in a separate proc)
 *
 * modified_consumed_reagents_list - the list of reagents we will consume on build, modified by the production coefficient.
 */
/obj/machinery/limbgrower/proc/build_item(list/modified_consumed_reagents_list)
	for(var/reagent_id in modified_consumed_reagents_list)
		if(!reagents.has_reagent(reagent_id, modified_consumed_reagents_list[reagent_id]))
			audible_message(span_notice("The [src] buzzes."))
			playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
			break

		reagents.remove_reagent(reagent_id, modified_consumed_reagents_list[reagent_id])

	var/built_typepath = being_built.build_path
	if(ispath(built_typepath, /obj/item/bodypart))
		build_limb(create_buildpath())
	else
		//Just build whatever it is
		new built_typepath(loc)

	busy = FALSE
	flick("limbgrower_unfill", src)
	icon_state = "limbgrower_idleoff"

/*
 * The process of putting together a limb.
 * This is called from after we remove the reagents, so this proc is just initializing the limb type.
 *
 * This proc handles skin / mutant color, greyscaling, names and descriptions, and various other limb creation steps.
 *
 * buildpath - the path of the bodypart we're building.
 */
/obj/machinery/limbgrower/proc/build_limb(buildpath)
	/// The limb we're making with our buildpath, so we can edit it.
	//i need to create a body part manually using a set icon (otherwise it doesnt appear)
	var/obj/item/bodypart/limb
	limb = new buildpath(loc)
	limb.name = "\improper synthetic [limb.bodytype & BODYTYPE_DIGITIGRADE ? "digitigrade ":""][selected_category] [limb.plaintext_zone]"
	limb.limb_id = selected_category
	//fun override colors
	limb.mutation_color = random_color()
	limb.update_icon_dropped()

///Returns a valid limb typepath based on the selected option
/obj/machinery/limbgrower/proc/create_buildpath()
	var/species = selected_category
	var/path
	if(species == SPECIES_HUMAN) //Humans use the parent type.
		path = being_built.build_path
		return path
	else if(istype(being_built,/datum/design/digitigrade))
		path = being_built.build_path
		return path
	else
		path = "[being_built.build_path]/[species]"
	return text2path(path)

/obj/machinery/limbgrower/RefreshParts()
	. = ..()
	reagents.maximum_volume = 0
	for(var/obj/item/reagent_containers/glass/our_beaker in component_parts)
		reagents.maximum_volume += our_beaker.volume
		our_beaker.reagents.trans_to(src, our_beaker.reagents.total_volume)
	production_coefficient = 1.25
	for(var/obj/item/stock_parts/manipulator/our_manipulator in component_parts)
		production_coefficient -= our_manipulator.rating * 0.25
	production_coefficient = clamp(production_coefficient, 0, 1) // coefficient goes from 1 -> 0.75 -> 0.5 -> 0.25

/obj/machinery/limbgrower/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Storing up to <b>[reagents.maximum_volume]u</b> of reagents.<br>Reagent consumption rate at <b>[production_coefficient * 100]%</b>.")

/*
 * Checks our reagent list to see if a design can be built.
 *
 * limb_design - the design we're checking for buildability.
 *
 * returns TRUE if we have enough reagent to build it. Returns FALSE if we do not.
 */
/obj/machinery/limbgrower/proc/can_build(datum/design/limb_design)
	for(var/datum/reagent/reagent_id in limb_design.reagents_list)
		if(!reagents.has_reagent(reagent_id, limb_design.reagents_list[reagent_id] * production_coefficient))
			return FALSE
	return TRUE

/// Emagging a limbgrower allows you to build synthetic armblades.
/obj/machinery/limbgrower/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	for(var/design_id in SSresearch.techweb_designs)
		var/datum/design/found_design = SSresearch.techweb_design_by_id(design_id)
		if((found_design.build_type & LIMBGROWER) && ("emagged" in found_design.category))
			stored_research.add_design(found_design)
	to_chat(user, span_warning("Safety overrides have been deactivated!"))
	obj_flags |= EMAGGED
	update_static_data(user)


//start yog
/obj/machinery/limbgrower/proc/handle_biomass(user_item, biomass, user) // updates the value
	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src]'s reagent containers are full!."))
		busy = FALSE
		return // if reagent container is already past the max, stop this from working
	else
		to_chat(user, span_notice("You insert [user_item] into [src].")) // feel free to fill it.
		playsound(loc, 'sound/machines/blender.ogg', 50, TRUE)
		qdel(user_item)
		use_power(biomass * production_coefficient * 10)
		sleep(min(10 SECONDS, biomass * production_coefficient))
		reagents.add_reagent(/datum/reagent/medicine/synthflesh, biomass)
	busy = FALSE
	return
//end yog (please)
