/obj/machinery/nomifactory/machinery
	var/progress
	var/datum/nomi_recipe/recipe

	/// The cached power multiplier, calcualted in RefreshParts
	var/cached_power_mult = 1
	/// See above
	var/cached_speed_mult = 1
	var/cached_examine_text = ""

	/// The number of excess items allowed, aka the buffer capacity
	var/buffer_count = 0

/obj/machinery/nomifactory/machinery/Initialize()
	. = ..()
	RegisterSignal(get_turf(src), COMSIG_ATOM_ENTERED, .proc/turf_entered)

/obj/machinery/nomifactory/machinery/update_icon()
	name = recipe ? "[initial(name)] ([recipe.name])" : initial(name)
	. = ..()

/obj/machinery/nomifactory/machinery/RefreshParts()
	cached_power_mult = 1
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		cached_power_mult *= 1 - (capacitor.get_part_rating() * 0.01)

	cached_speed_mult = 1
	for(var/obj/item/stock_parts/manipulator/manipulator in component_parts)
		cached_speed_mult *= 1 - (manipulator.get_part_rating() * 0.01)
	for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
		cached_speed_mult *= 1 - (laser.get_part_rating() * 0.01)

	for(var/obj/item/nomi/nomi_part in component_parts)
		cached_power_mult *= 1 - (nomi_part.power_rating * 0.01)
		cached_speed_mult *= 1 - (nomi_part.speed_rating * 0.01)

	var/pct_speed = 10000 / cached_speed_mult
	cached_examine_text = "The automated efficiency panel shows the following:\nPower Usage: [cached_power_mult * 100]%\n\tSpeed Modifer: [pct_speed]%"

/obj/machinery/nomifactory/machinery/update_overlays()
	. = ..()
	if(recipe?.generated_overlay)
		. += recipe.generated_overlay

/obj/machinery/nomifactory/machinery/examine(mob/user)
	. = ..()

	if(cached_examine_text)
		. += cached_examine_text

	var/list/content_tally = new
	for(var/content in contents)
		if(!recipe?.is_valid_input(content))
			continue
		content_tally[content]++

	if(length(content_tally))
		var/contains_str = "It contains: "
		for(var/content in content_tally)
			contains_str += "\n\t([content_tally[content]]x) [content]"
		. += contains_str

/obj/machinery/nomifactory/machinery/attack_hand(mob/user)
	var/list/valid_recipes = new
	for(var/datum/nomi_recipe/recipe as anything in GLOB.nomi_recipes)
		if(!istype(src, recipe.machine_needed))
			continue
		valid_recipes[recipe.name] = recipe
	valid_recipes["Disable"] = TRUE
	var/selected = tgui_input_list(user, "Select Recipe", name, valid_recipes)
	if(selected)
		recipe = valid_recipes[selected] // Indexing by a non-existant key returns null, so this works
	update_icon()

/obj/machinery/nomifactory/machinery/proc/nomifactory_pre_turf_entered(atom/movable/entered)
	return FALSE

/obj/machinery/nomifactory/machinery/proc/turf_entered(datum/source, atom/movable/entered)
	SIGNAL_HANDLER
	SHOULD_NOT_OVERRIDE(TRUE)

	if(nomifactory_pre_turf_entered(entered))
		return

	if(!recipe.is_valid_input(entered))
		say("rejecting invalid input")
		step(entered, dir)
		return

	var/total = 0
	for(var/datum/content as anything in contents)
		if(content.type == entered.type)
			total++

	if(total >= recipe.inputs[entered.type])
		say("rejecting excess input")
		step(entered, dir)
		return

	entered.forceMove(src)

/obj/machinery/nomifactory/machinery/nomifactory_process()
	if(!recipe)
		progress = 0
		return

	if(!progress)
		if(recipe.can_begin(contents))
			progress = 1
			for(var/taken in recipe.take_ingredients(contents))
				contents -= taken
		return

	var/actual_needed = recipe.work_needed * cached_speed_mult
	if(progress++ >= actual_needed)
		progress = 0
		say("recipe complete")
		recipe.create_outputs(get_step(src, dir))
		return
