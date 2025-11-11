// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

// Base type. Subtypes are found in /grown dir. Lavaland-based subtypes can be found in mining/ash_flora.dm
/obj/item/food/grown
	icon = 'icons/obj/hydroponics/harvest.dmi'
	name = "fresh produce" //fix naming bug
	max_volume = 100
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	/// type path, gets converted to item on New(). It's safe to assume it's always a seed item.
	var/obj/item/seeds/seed = null
	///Name of the plant
	var/plantname = ""
	/// The modifier applied to the plant's bite size. If a plant has a large amount of reagents naturally, this should be increased to match.
	var/bite_consumption_mod = 1
	///the splat it makes when it splats lol
	var/splat_type = /obj/effect/decal/cleanable/food/plant_smudge
	/// If TRUE, this object needs to be dry to be ground up
	var/dry_grind = FALSE
	/// If FALSE, this object cannot be distilled into an alcohol.
	var/can_distill = TRUE
	/// The reagent this plant distills to. If NULL, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_reagent
	/// Flavor of the plant's wine if NULL distill_reagent. If NULL, this is automatically set to the fruit's flavor.
	var/wine_flavor
	/// Boozepwr of the wine if NULL distill_reagent
	var/wine_power = 10
	///Color of the grown object
	var/filling_color
	//Amount of discovery points given for scanning
	var/discovery_points = 0

/obj/item/food/grown/Initialize(mapload, obj/item/seeds/new_seed)
	if(!tastes)
		tastes = list("[name]" = 1) //This happens first else the component already inits

	if(new_seed)
		seed = new_seed.Copy()

	else if(ispath(seed))
		// This is for adminspawn or map-placed growns. They get the default stats of their seed type.
		seed = new seed()
		seed.adjust_potency(50-seed.potency)
	else if(!seed)
		stack_trace("Grown object created without a seed!")
		return INITIALIZE_HINT_QDEL

	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

	for(var/datum/plant_gene/trait/trait in seed.genes)
		trait.on_new(src, loc)

	// Set our default bitesize: bite size = 1 + (potency * 0.05) * (max_volume * 0.01) * modifier
	// A 100 potency, non-densified plant = 1 + (5 * 1 * modifier) = 6u bite size
	// For reference, your average 100 potency tomato has 14u of reagents - So, with no modifier it is eaten in 3 bites
	bite_consumption = 1 + round(max((seed.potency * BITE_SIZE_POTENCY_MULTIPLIER), 1) * (max_volume * BITE_SIZE_VOLUME_MULTIPLIER) * bite_consumption_mod)

	. = ..() //Only call it here because we want all the genes and shit to be applied before we add edibility. God this code is a mess.

	seed.prepare_result(src)
	transform *= TRANSFORM_USING_VARIABLE(seed.potency, 100) + 0.5 //Makes the resulting produce's sprite larger or smaller based on potency!

/obj/item/food/grown/Destroy()
	if(isatom(seed))
		QDEL_NULL(seed)
	return ..()

/obj/item/food/grown/make_edible()
	AddComponent(/datum/component/edible,\
				initial_reagents = food_reagents,\
				food_flags = food_flags,\
				foodtypes = foodtypes,\
				volume = max_volume,\
				eat_time = eat_time,\
				tastes = tastes,\
				eatverbs = eatverbs,\
				bite_consumption = bite_consumption,\
				microwaved_type = microwaved_type,\
				junkiness = junkiness)

/obj/item/food/grown/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_OPENABLE, TYPE_PROC_REF(/obj/item/food/grown/, generate_trash))
	return

/obj/item/food/grown/examine(user)
	. = ..()
	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			if(T.examine_line)
				. += T.examine_line

/obj/item/food/grown/attackby(obj/item/O, mob/user, params)
	..()
	if (istype(O, /obj/item/plant_analyzer))
		var/msg = "<span class='info'>This is \a <span class='name'>[src]</span>.\n"
		if(seed)
			msg += seed.get_analyzer_text()
		var/reag_txt = ""
		if(seed)
			for(var/reagent_id in seed.reagents_add)
				var/datum/reagent/R = GLOB.chemical_reagents_list[reagent_id]
				var/amt = reagents.get_reagent_amount(reagent_id)
				reag_txt += "\n<span class='info'>- [R.name]: [amt]</span>"

		if(reag_txt)
			msg += reag_txt
		to_chat(user, boxed_message(msg))
	else
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_attackby(src, O, user)

//Ghetto Seed Extraction
	switch(O.tool_behaviour)
		if(TOOL_SCREWDRIVER)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts digging into \the [src]."), span_notice("You start digging into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts digging into \the [src]."), span_notice("You start digging into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_WIRECUTTER)
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts nipping into \the [src]."), span_notice("You start nipping into \the [src]..."), span_hear("You hear the sound of a sharp object penetrating some plant matter."))
			if(do_after(user, 28, target = src))
				to_chat(user, span_notice("You nip into the [src] to collect it's seeds! It's all gross and unusuable now, ew!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_CROWBAR)
			playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts splitting \the [src]."), span_notice("You dig into \the [src] and start to split it..."), span_hear("You hear the sound of a sharp object digging into some plant matter."))
			if(do_after(user, 20, target = src))
				to_chat(user, span_notice("You split apart the [src]! Sadly you put too much force and it's remains are unusable, but hey, you got your seeds!"))
				seedify(src, 1, TRUE, TRUE, src, user)
		if(TOOL_WRENCH)
			playsound(loc, 'sound/misc/splort.ogg', 50, TRUE, -1)
			user.visible_message(span_notice("[user] starts whacking \the [src]."), span_notice("You start whacking \the [src]..."), span_hear("You hear the sound of a plant being whacked violently."))
			if(do_after(user, 17, target = src))
				to_chat(user, span_notice("You smash [src]! Sadly there's nothing left of it other than the seeds and some junk."))
				seedify(src, 1, TRUE, TRUE, src, user)

// Various gene procs
/obj/item/food/grown/attack_self(mob/user)
	if(seed && seed.get_gene(/datum/plant_gene/trait/squash))
		squash(user)
	..()

/obj/item/food/grown/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_throw_impact(src, hit_atom)
			if(seed.get_gene(/datum/plant_gene/trait/squash))
				squash(hit_atom)

/obj/item/food/grown/proc/squash(atom/target)
	var/turf/T = get_turf(target)
	forceMove(T)
	if(ispath(splat_type, /obj/effect/decal/cleanable/food/plant_smudge))
		if(filling_color)
			var/obj/O = new splat_type(T)
			O.color = filling_color
			O.name = "[name] smudge"
	else if(splat_type)
		new splat_type(T)

	visible_message("<span class='warning'>[src] has been squashed.</span>","<span class='italics'>You hear a smack.</span>")
	if(seed)
		for(var/datum/plant_gene/trait/trait in seed.genes)
			trait.on_squash(src, target)
	reagents.expose(T)
	for(var/A in T)
		reagents.expose(A)
	qdel(src)

/obj/item/food/grown/proc/squashreact()
	for(var/datum/plant_gene/trait/trait in seed.genes)
		trait.on_squashreact(src)
	qdel(src)

/obj/item/food/grown/proc/OnConsume(mob/living/eater, mob/living/feeder)
	if(iscarbon(usr))
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_consume(src, usr)

///Callback for bonus behavior for generating trash of grown food.
/obj/item/food/grown/proc/generate_trash(atom/location)
	return new trash_type(location, seed)

/// Turns the nutriments and vitamins into the distill reagent or fruit wine
/obj/item/food/grown/proc/ferment()
	for(var/datum/reagent/reagent in reagents.reagent_list)
		if(reagent.type != /datum/reagent/consumable/nutriment && reagent.type != /datum/reagent/consumable/nutriment/vitamin)
			continue
		if(distill_reagent)
			reagents.add_reagent(distill_reagent, reagent.volume)
		else
			var/data = list()
			data["names"] = list("[initial(name)]" = 1)
			data["color"] = filling_color
			data["boozepwr"] = wine_power
			if(wine_flavor)
				data["tastes"] = list(wine_flavor = 1)
			else
				data["tastes"] = list(tastes[1] = 1)
			reagents.add_reagent(/datum/reagent/consumable/ethanol/fruit_wine, reagent.volume, data)
		reagents.del_reagent(reagent.type)

/obj/item/food/grown/grind_requirements()
	if(dry_grind && !HAS_TRAIT(src, TRAIT_DRIED))
		to_chat(usr, span_warning("[src] needs to be dry before it can be ground up!"))
		return
	return TRUE

/obj/item/food/grown/on_grind()
	. = ..()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(grind_results&&grind_results.len)
		for(var/i in 1 to grind_results.len)
			grind_results[grind_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

/obj/item/food/grown/on_juice()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(juice_results?.len)
		for(var/i in 1 to juice_results.len)
			juice_results[juice_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

#undef BITE_SIZE_POTENCY_MULTIPLIER
#undef BITE_SIZE_VOLUME_MULTIPLIER
