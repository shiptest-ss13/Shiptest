GLOBAL_LIST_INIT_TYPED(nomi_recipes, /datum/nomi_recipe, setup_nomi_recipes())

/proc/setup_nomi_recipes()
	. = list()
	for(var/datum/nomi_recipe/recipe as anything in subtypesof(/datum/nomi_recipe))
		if(initial(recipe.abstract) == recipe)
			continue
		var/datum/nomi_recipe/recipe_instance = new recipe
		if(recipe_instance.overlay_icon && recipe_instance.overlay_icon_state)
			recipe_instance.generated_overlay = mutable_appearance(recipe_instance.overlay_icon, recipe_instance.overlay_icon_state)
		. += recipe_instance
	return .

/datum/nomi_recipe
	var/name = "Recipe"
	var/desc = "Recipe Description"

	var/list/inputs
	var/list/outputs

	var/work_needed
	var/machine_needed

	var/overlay_icon
	var/overlay_icon_state
	var/mutable_appearance/generated_overlay

	var/abstract = /datum/nomi_recipe

/**
 * Checks if the given input is valid. This checks both valid in general and buffering capacity
 */
/datum/nomi_recipe/proc/is_valid_input(atom/checking, list/current, maximum_buffer_allowed = -1)
	var/check_type = checking.type
	if(!(check_type in inputs))
		return FALSE

	if(maximum_buffer_allowed < 0)
		return TRUE

	var/current_buffer = 0 - inputs[check_type] // The buffer starts off the negative number needed for the recipe
	if(istype(checking, /obj/item/stack))
		for(var/obj/item/stack/ingredient_stack in current)
			if(istype(ingredient_stack, check_type))
				current_buffer += ingredient_stack.amount
		return
	else for(var/ingredient in current)
		if(istype(ingredient, check_type))
			current_buffer++
	return current_buffer < maximum_buffer_allowed

/datum/nomi_recipe/proc/can_begin(list/ingredients)
	var/list/totals = new

	for(var/atom/ingredient as anything in ingredients)
		totals[ingredient.type]++

	for(var/ingredient in inputs)
		if(inputs[ingredient] > totals[ingredient])
			return FALSE

	return TRUE

/datum/nomi_recipe/proc/take_ingredients(list/ingredients)
	var/list/all_taken = new
	for(var/ingredient in inputs)
		var/taking = inputs[ingredient]
		while(taking)
			taking -= 1
			var/obj/item/took = locate(ingredient) in ingredients

			var/obj/item/stack/took_as_stack = took
			if(istype(took_as_stack)) // Special snowflake handling for stacks, I.E. metal sheets and ore
				var/can_take = min(taking, took_as_stack.amount)
				taking = 0

				if(can_take >= took_as_stack.amount)
					qdel(took_as_stack)
				else
					took_as_stack.amount -= can_take
			else if(took)
				ingredients -= took
				all_taken += took
				qdel(took)
	return all_taken

/datum/nomi_recipe/proc/create_outputs(atom/output_atom)
	for(var/output in outputs)
		var/making = outputs[output]
		if(istype(making, /obj/item/stack)) // This is painful
			var/obj/item/stack/out = new output(output_atom)
			out.amount = making
		else while(making)
			making -= 1
			new output(output_atom)
