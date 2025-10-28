/* Stack type objects!
 * Contains:
 * 		Stacks
 * 		Recipe datum
 * 		Recipe list datum
 */

/*
 * Stacks
 */

/obj/item/stack
	icon = 'icons/obj/stack_objects.dmi'
	gender = PLURAL
	material_modifier = 0.01
	max_integrity = 100
	var/list/datum/stack_recipe/recipes
	var/singular_name
	var/amount = 1
	var/max_amount = 50 //also see stack recipes initialisation, param "max_res_amount" must be equal to this max_amount
	var/is_cyborg = 0 // It's 1 if module is used by a cyborg, and uses its storage
	var/datum/robot_energy_storage/source
	var/cost = 1 // How much energy from storage it costs
	var/merge_type = null // This path and its children should merge with this stack, defaults to src.type
	var/full_w_class = WEIGHT_CLASS_NORMAL //The weight class the stack should have at amount > 2/3rds max_amount
	var/novariants = TRUE //Determines whether the item should update it's sprites based on amount.
	var/list/mats_per_unit //list that tells you how much is in a single unit.
	///Datum material type that this stack is made of
	var/material_type
	//NOTE: When adding grind_results, the amounts should be for an INDIVIDUAL ITEM - these amounts will be multiplied by the stack size in on_grind()
	var/obj/structure/table/tableVariant // we tables now (stores table variant to be built from this stack)

/obj/item/stack/on_grind()
	for(var/i in 1 to grind_results.len) //This should only call if it's ground, so no need to check if grind_results exists
		grind_results[grind_results[i]] *= get_amount() //Gets the key at position i, then the reagent amount of that key, then multiplies it by stack size

/obj/item/stack/grind_requirements()
	if(is_cyborg)
		to_chat(usr, span_warning("[src] is electronically synthesized in your chassis and can't be ground up!"))
		return
	return TRUE

/obj/item/stack/Initialize(mapload, new_amount, merge = TRUE)
	if(new_amount != null)
		amount = new_amount
	while(amount > max_amount)
		amount -= max_amount
		new type(loc, max_amount, FALSE)
	if(!merge_type)
		merge_type = type
	if(custom_materials && custom_materials.len)
		mats_per_unit = list()
		var/in_process_mat_list = custom_materials.Copy()
		for(var/i in custom_materials)
			mats_per_unit[SSmaterials.GetMaterialRef(i)] = in_process_mat_list[i]
			custom_materials[i] *= amount
	. = ..()
	if(merge)
		for(var/obj/item/stack/item_stack in loc)
			if(item_stack == src)
				continue
			if(can_merge(item_stack))
				INVOKE_ASYNC(src, PROC_REF(merge_without_del), item_stack)
				if(is_zero_amount(delete_if_zero = FALSE))
					return INITIALIZE_HINT_QDEL
	var/list/temp_recipes = get_main_recipes()
	recipes = temp_recipes.Copy()
	if(material_type)
		var/datum/material/M = SSmaterials.GetMaterialRef(material_type) //First/main material
		for(var/i in M.categories)
			switch(i)
				if(MAT_CATEGORY_RIGID && MAT_CATEGORY_BASE_RECIPES)
					var/list/temp = SSmaterials.rigid_stack_recipes.Copy()
					recipes += temp
	update_weight()
	update_appearance()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_movable_entered_occupied_turf),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/stack/proc/get_main_recipes()
	SHOULD_CALL_PARENT(1)
	return list()//empty list

/obj/item/stack/proc/update_weight()
	if(amount <= (max_amount * (1/3)))
		w_class = clamp(full_w_class-2, WEIGHT_CLASS_TINY, full_w_class)
	else if (amount <= (max_amount * (2/3)))
		w_class = clamp(full_w_class-1, WEIGHT_CLASS_TINY, full_w_class)
	else
		w_class = full_w_class

/obj/item/stack/update_icon_state()
	if(novariants)
		return ..()
	if(amount <= (max_amount * (1/3)))
		icon_state = initial(icon_state)
		return ..()
	if (amount <= (max_amount * (2/3)))
		icon_state = "[initial(icon_state)]_2"
		return ..()
	icon_state = "[initial(icon_state)]_3"
	return ..()

/obj/item/stack/examine(mob/user)
	. = ..()
	if (is_cyborg)
		if(singular_name)
			. += "There is enough energy for [get_amount()] [singular_name]\s."
		else
			. += "There is enough energy for [get_amount()]."
		return
	if(singular_name)
		if(get_amount()>1)
			. += "There are [get_amount()] [singular_name]\s in the stack."
		else
			. += "There is [get_amount()] [singular_name] in the stack."
	else if(get_amount()>1)
		. += "There are [get_amount()] in the stack."
	else
		. += "There is [get_amount()] in the stack."
	. += span_notice("Alt-click to take a custom amount.")

/obj/item/stack/proc/get_amount()
	if(is_cyborg)
		. = round(source?.energy / cost)
	else
		. = (amount)

/**
 * Builds all recipes in a given recipe list and returns an association list containing them
 *
 * Arguments:
 * * recipe_to_iterate - The list of recipes we are using to build recipes
 */
/obj/item/stack/proc/recursively_build_recipes(list/recipe_to_iterate)
	var/list/L = list()
	for(var/recipe in recipe_to_iterate)
		if(istype(recipe, /datum/stack_recipe_list))
			var/datum/stack_recipe_list/R = recipe
			L["[R.title]"] = recursively_build_recipes(R.recipes)
		if(istype(recipe, /datum/stack_recipe))
			var/datum/stack_recipe/R = recipe
			L["[R.title]"] = build_recipe(R)
	return L

/**
 * Returns a list of properties of a given recipe
 *
 * Arguments:
 * * R - The stack recipe we are using to get a list of properties
 */
/obj/item/stack/proc/build_recipe(datum/stack_recipe/R)
	return list(
		"res_amount" = R.res_amount,
		"max_res_amount" = R.max_res_amount,
		"req_amount" = R.req_amount,
		"ref" = text_ref(R),
	)

/**
 * Checks if the recipe is valid to be used
 *
 * Arguments:
 * * R - The stack recipe we are checking if it is valid
 * * recipe_list - The list of recipes we are using to check the given recipe
 */
/obj/item/stack/proc/is_valid_recipe(datum/stack_recipe/R, list/recipe_list)
	for(var/S in recipe_list)
		if(S == R)
			return TRUE
		if(istype(S, /datum/stack_recipe_list))
			var/datum/stack_recipe_list/L = S
			if(is_valid_recipe(R, L.recipes))
				return TRUE
	return FALSE

/obj/item/stack/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/stack/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Stack", name)
		ui.open()

/obj/item/stack/ui_data(mob/user)
	var/list/data = list()
	data["amount"] = get_amount()
	return data

/obj/item/stack/ui_static_data(mob/user)
	var/list/data = list()
	data["recipes"] = recursively_build_recipes(recipes)
	return data

/obj/item/stack/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("make")
			if(get_amount() < 1 && !is_cyborg)
				qdel(src)
				return
			var/datum/stack_recipe/recipe = locate(params["ref"])
			if(!is_valid_recipe(recipe, recipes)) //href exploit protection
				return
			var/multiplier = text2num(params["multiplier"])
			if(!multiplier || (multiplier <= 0)) //href exploit protection
				return
			if(!building_checks(recipe, multiplier))
				return
			if(recipe.time)
				var/adjusted_time = 0
				usr.visible_message(span_notice("[usr] starts building \a [recipe.title]."), span_notice("You start building \a [recipe.title]..."))
				if(HAS_TRAIT(usr, recipe.trait_booster))
					adjusted_time = (recipe.time * recipe.trait_modifier)
				else
					adjusted_time = recipe.time
				if(!do_after(usr, adjusted_time, target = usr))
					return
				if(!building_checks(recipe, multiplier))
					return

			var/obj/O
			if(recipe.max_res_amount > 1) //Is it a stack?
				O = new recipe.result_type(usr.drop_location(), recipe.res_amount * multiplier)
			else if(ispath(recipe.result_type, /turf))
				var/turf/T = usr.drop_location()
				if(!isturf(T))
					return
				T.PlaceOnTop(recipe.result_type, flags = CHANGETURF_INHERIT_AIR)
			else
				O = new recipe.result_type(usr.drop_location())
			if(O)
				O.setDir(usr.dir)
			use(recipe.req_amount * multiplier)

			if(recipe.applies_mats && custom_materials && custom_materials.len)
				var/list/used_materials = list()
				for(var/i in custom_materials)
					used_materials[SSmaterials.GetMaterialRef(i)] = recipe.req_amount / recipe.res_amount * (MINERAL_MATERIAL_AMOUNT / custom_materials.len)
				O.set_custom_materials(used_materials)

			if(!QDELETED(O) && isitem(O))
				usr.put_in_hands(O)

			if(QDELETED(O))
				return //It's a stack and has already been merged

			O.add_fingerprint(usr)

			//BubbleWrap - so newly formed boxes are empty
			if(istype(O, /obj/item/storage))
				for (var/obj/item/I in O)
					qdel(I)
			//BubbleWrap END
			return TRUE

/obj/item/stack/vv_edit_var(vname, vval)
	if(vname == NAMEOF(src, amount))
		add(clamp(vval, 1-amount, max_amount - amount)) //there must always be one.
		return TRUE
	else if(vname == NAMEOF(src, max_amount))
		max_amount = max(vval, 1)
		add((max_amount < amount) ? (max_amount - amount) : 0) //update icon, weight, ect
		return TRUE
	return ..()

/obj/item/stack/proc/building_checks(datum/stack_recipe/recipe, multiplier)
	if (get_amount() < recipe.req_amount*multiplier)
		if (recipe.req_amount*multiplier>1)
			to_chat(usr, span_warning("You haven't got enough [src] to build \the [recipe.req_amount*multiplier] [recipe.title]\s!"))
		else
			to_chat(usr, span_warning("You haven't got enough [src] to build \the [recipe.title]!"))
		return FALSE
	var/turf/dest_turf = get_turf(usr)

	// If we're making a window, we have some special snowflake window checks to do.
	if(ispath(recipe.result_type, /obj/structure/window))
		var/obj/structure/window/result_path = recipe.result_type
		if(!valid_window_location(dest_turf, usr.dir, is_fulltile = initial(result_path.fulltile)))
			to_chat(usr, span_warning("The [recipe.title] won't fit here!"))
			return FALSE

	if(recipe.one_per_turf && (locate(recipe.result_type) in dest_turf))
		to_chat(usr, span_warning("There is another [recipe.title] here!"))
		return FALSE

	if(recipe.on_floor)
		if(!isfloorturf(dest_turf))
			to_chat(usr, span_warning("\The [recipe.title] must be constructed on the floor!"))
			return FALSE

		for(var/obj/object in dest_turf)
			if(istype(object, /obj/structure/grille))
				continue
			if(istype(object, /obj/structure/table))
				continue
			if(istype(object, /obj/structure/window))
				var/obj/structure/window/window_structure = object
				if(!window_structure.fulltile)
					continue
			if(object.density)
				to_chat(usr, span_warning("There is \a [object.name] here. You can't make \a [recipe.title] here!"))
				return FALSE
	if(recipe.placement_checks)
		switch(recipe.placement_checks)
			if(STACK_CHECK_CARDINALS)
				var/turf/step
				for(var/direction in GLOB.cardinals)
					step = get_step(dest_turf, direction)
					if(locate(recipe.result_type) in step)
						to_chat(usr, span_warning("\The [recipe.title] must not be built directly adjacent to another!"))
						return FALSE
			if(STACK_CHECK_ADJACENT)
				if(locate(recipe.result_type) in range(1, dest_turf))
					to_chat(usr, span_warning("\The [recipe.title] must be constructed at least one tile away from others of its type!"))
					return FALSE
	return TRUE

/obj/item/stack/use(used, transfer = FALSE, check = TRUE) // return 0 = borked; return 1 = had enough
	if(check && is_zero_amount(delete_if_zero = TRUE))
		return FALSE
	if (is_cyborg)
		return source.use_charge(used * cost)
	if (amount < used)
		return FALSE
	amount -= used
	if(check && is_zero_amount(delete_if_zero = TRUE))
		return TRUE
	for(var/i in mats_per_unit)
		custom_materials[i] = amount * mats_per_unit[i]
	update_appearance()
	update_weight()
	return TRUE

/obj/item/stack/tool_use_check(mob/living/user, atom/target, amount)
	if(get_amount() < amount)
		if(singular_name)
			if(amount > 1)
				to_chat(user, span_warning("You need at least [amount] [singular_name]\s to do this!"))
			else
				to_chat(user, span_warning("You need at least [amount] [singular_name] to do this!"))
		else
			to_chat(user, span_warning("You need at least [amount] to do this!"))

		return FALSE

	return TRUE

/**
 * Returns TRUE if the item stack is the equivalent of a 0 amount item.
 *
 * Also deletes the item if delete_if_zero is TRUE and the stack does not have
 * is_cyborg set to true.
 */
/obj/item/stack/proc/is_zero_amount(delete_if_zero = TRUE)
	if(is_cyborg)
		return source.energy < cost
	if(amount < 1)
		if(delete_if_zero)
			qdel(src)
		return TRUE
	return FALSE

/obj/item/stack/proc/add(amount)
	if (is_cyborg)
		source.add_charge(amount * cost)
	else
		src.amount += amount
	if(mats_per_unit && mats_per_unit.len)
		for(var/i in mats_per_unit)
			custom_materials[i] = mats_per_unit[i] * src.amount
		set_custom_materials() //Refresh
	update_appearance()
	update_weight()

/** Checks whether this stack can merge itself into another stack.
 *
 * Arguments:
 * - [check][/obj/item/stack]: The stack to check for mergeability.
 * - [inhand][boolean]: Whether or not the stack to check should act like it's in a mob's hand.
 */
/obj/item/stack/proc/can_merge(obj/item/stack/check, inhand = FALSE)
	if(!istype(check, merge_type))
		return FALSE
	if(mats_per_unit ~! check.mats_per_unit)
		return FALSE
	if(is_cyborg) // No merging cyborg stacks into other stacks
		return FALSE
	if(ismob(loc) && !inhand) // no merging with items that are on the mob
		return FALSE
	return TRUE

/**
 * Merges as much of src into target_stack as possible. If present, the limit arg overrides target_stack.max_amount for transfer.
 *
 * This calls use() without check = FALSE, preventing the item from qdeling itself if it reaches 0 stack size.
 *
 * As a result, this proc can leave behind a 0 amount stack.
 */
/obj/item/stack/proc/merge_without_del(obj/item/stack/target_stack, limit)
	// Cover edge cases where multiple stacks are being merged together and haven't been deleted properly.
	// Also cover edge case where a stack is being merged into itself, which is supposedly possible.
	if(QDELETED(target_stack))
		CRASH("Stack merge attempted on qdeleted target stack.")
	if(QDELETED(src))
		CRASH("Stack merge attempted on qdeleted source stack.")
	if(target_stack == src)
		CRASH("Stack attempted to merge into itself.")

	var/transfer = get_amount()
	if(target_stack.is_cyborg)
		transfer = min(transfer, round((target_stack.source.max_energy - target_stack.source.energy) / target_stack.cost))
	else
		transfer = min(transfer, (limit ? limit : target_stack.max_amount) - target_stack.amount)
	if(pulledby)
		pulledby.start_pulling(target_stack)
	target_stack.copy_evidences(src)
	use(transfer, transfer = TRUE, check = FALSE)
	target_stack.add(transfer)
	return transfer

/**
 * Merges as much of src into target_stack as possible. If present, the limit arg overrides target_stack.max_amount for transfer.
 *
 * This proc deletes src if the remaining amount after the transfer is 0.
 */
/obj/item/stack/proc/merge(obj/item/stack/target_stack, limit)
	. = merge_without_del(target_stack, limit)
	is_zero_amount(delete_if_zero = TRUE)

/// Signal handler for connect_loc element. Called when a movable enters the turf we're currently occupying. Merges if possible.
/obj/item/stack/proc/on_movable_entered_occupied_turf(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER

	// Edge case. This signal will also be sent when src has entered the turf. Don't want to merge with ourselves.
	if(arrived == src)
		return

	if(!arrived.throwing && can_merge(arrived))
		INVOKE_ASYNC(src, PROC_REF(merge), arrived)

/obj/item/stack/hitby(atom/movable/hitting, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(can_merge(hitting, TRUE))
		merge(hitting)
	. = ..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/stack/attack_hand(mob/user)
	if(user.get_inactive_held_item() == src)
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		return split_stack(user,1)
	else
		. = ..()

/obj/item/stack/AltClick(mob/living/user)
	. = ..()
	if(isturf(loc)) // to prevent people that are alt clicking a tile to see its content from getting undesidered pop ups
		return
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(is_cyborg)
		return
	if(is_zero_amount(delete_if_zero = TRUE))
		return
	//get amount from user
	var/max = get_amount()
	var/stackmaterial = round(input(user,"How many sheets do you wish to take out of this stack? (Maximum  [max])") as null|num)
	max = get_amount()
	stackmaterial = min(max, stackmaterial)
	if(stackmaterial == null || stackmaterial <= 0 || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		split_stack(user, stackmaterial)
		to_chat(user, span_notice("You take [stackmaterial] sheets out of the stack."))

/** Splits the stack into two stacks.
 *
 * Arguments:
 * - [user][/mob]: The mob splitting the stack.
 * - amount: The number of units to split from this stack.
 */
/obj/item/stack/proc/split_stack(mob/user, amount)
	if(!use(amount, TRUE, FALSE))
		return FALSE
	var/obj/item/stack/F = new type(user? user : drop_location(), amount, FALSE)
	. = F
	F.copy_evidences(src)
	if(user)
		if(!user.put_in_hands(F, merge_stacks = FALSE))
			F.forceMove(user.drop_location())
		add_fingerprint(user)
		F.add_fingerprint(user)

	is_zero_amount(delete_if_zero = TRUE)

/obj/item/stack/attackby(obj/item/W, mob/user, params)
	if(can_merge(W, TRUE))
		var/obj/item/stack/S = W
		if(merge(S))
			to_chat(user, span_notice("Your [S.name] stack now contains [S.get_amount()] [S.singular_name]\s."))
	else
		. = ..()

/obj/item/stack/proc/copy_evidences(obj/item/stack/from)
	add_blood_DNA(from.return_blood_DNA())
	add_fingerprint_list(from.return_fingerprints())
	add_hiddenprint_list(from.return_hiddenprints())
	fingerprintslast  = from.fingerprintslast
	//TODO bloody overlay

/obj/item/stack/microwave_act(obj/machinery/microwave/M)
	if(istype(M) && M.dirty < 100)
		M.dirty += amount

/*
 * Recipe datum
 */
/datum/stack_recipe
	var/title = "ERROR"
	var/result_type
	var/req_amount = 1
	var/res_amount = 1
	var/max_res_amount = 1
	var/time = 0
	var/one_per_turf = FALSE
	var/on_floor = FALSE
	var/placement_checks = FALSE
	var/applies_mats = FALSE
	var/trait_booster = null
	var/trait_modifier = 1

/datum/stack_recipe/New(title, result_type, req_amount = 1, res_amount = 1, max_res_amount = 1,time = 0, one_per_turf = FALSE, on_floor = FALSE, window_checks = FALSE, placement_checks = FALSE, applies_mats = FALSE, trait_booster = null, trait_modifier = 1)
	src.title = title
	src.result_type = result_type
	src.req_amount = req_amount
	src.res_amount = res_amount
	src.max_res_amount = max_res_amount
	src.time = time
	src.one_per_turf = one_per_turf
	src.on_floor = on_floor
	src.placement_checks = placement_checks
	src.applies_mats = applies_mats
	src.trait_booster = trait_booster
	src.trait_modifier = trait_modifier
/*
 * Recipe list datum
 */
/datum/stack_recipe_list
	var/title = "ERROR"
	var/list/recipes

/datum/stack_recipe_list/New(title, recipes)
	src.title = title
	src.recipes = recipes
