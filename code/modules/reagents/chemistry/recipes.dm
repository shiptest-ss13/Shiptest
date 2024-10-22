/datum/chemical_reaction
	var/list/results = new/list()
	var/list/required_reagents = new/list()
	var/list/required_catalysts = new/list()

	// Both of these variables are mostly going to be used with slime cores - but if you want to, you can use them for other things
	var/obj/item/reagent_containers/required_container = null // the exact container path required for the reaction to happen
	var/required_other = 0 // an integer required for the reaction to happen

	var/mob_react = TRUE //Determines if a chemical reaction can occur inside a mob

	var/required_temp = 0
	var/is_cold_recipe = 0 // Set to 1 if you want the recipe to only react when it's BELOW the required temp.
	var/mix_message = "The solution begins to bubble." //The message shown to nearby people upon mixing, if applicable
	var/mix_sound = 'sound/effects/bubbles.ogg' //The sound played upon mixing, if applicable

/datum/chemical_reaction/proc/on_reaction(datum/reagents/holder, created_volume)
	return
	//I recommend you set the result amount to the total volume of all components.

///Simulates a vortex that moves nearby movable atoms towards or away from the turf T. Range also determines the strength of the effect. High values cause nearby objects to be thrown.
/proc/goonchem_vortex(turf/T, setting_type, range)
	for(var/atom/movable/X in orange(range, T))
		if(X.anchored)
			continue
		if(iseffect(X) || iscameramob(X) || isdead(X))
			continue
		var/distance = get_dist(X, T)
		var/moving_power = max(range - distance, 1)
		if(moving_power > 2) //if the vortex is powerful and we're close, we get thrown
			if(setting_type)
				var/atom/throw_target = get_edge_target_turf(X, get_dir(X, get_step_away(X, T)))
				X.throw_at(throw_target, moving_power, 1)
			else
				X.throw_at(T, moving_power, 1)
		else
			if(setting_type)
				if(step_away(X, T) && moving_power > 1) //Can happen twice at most. So this is fine.
					addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_step_away), X, T), 2)
			else
				if(step_towards(X, T) && moving_power > 1)
					addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_step_towards), X, T), 2)
