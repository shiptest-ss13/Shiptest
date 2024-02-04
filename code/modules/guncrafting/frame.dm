/obj/item/part/gun/frame
	name = "gun frame"
	desc = "a generic gun frame."
	icon_state = "frame_olivaw"
	var/list/preinstalledParts = list()
	var/list/installedParts = list()
	var/list/filtered_recipes = list()

	gun_part_type = GUN_PART_FRAME


/obj/item/part/gun/frame/Initialize()
	. = ..()
	for (var/partType in preinstalledParts)
		installedParts += new partType(src)
	get_current_recipes()
	/*
	var/spawn_with_preinstalled_parts = TRUE
	if(dont_spawn_with_parts)
		spawn_with_preinstalled_parts = FALSE

	if(spawn_with_preinstalled_parts)
		var/list/parts_list = list("mechanism", "barrel", "grip")
		for(var/part in parts_list)
			switch(part)
				if("mechanism")
					var/select = pick(validMechanisms)
					InstalledMechanism = new select(src)
				if("barrel")
					var/select = pick(validBarrels)
					InstalledBarrel = new select(src)
				if("grip")
					var/select = pick(validGrips)
					InstalledGrip = new select(src)
	*/

/obj/item/part/gun/frame/proc/eject_item(obj/item/I, mob/living/user)
	if(!I || !user.IsAdvancedToolUser() || user.stat || !user.Adjacent(I))
		return FALSE
	user.put_in_hands(I)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] removes [I] from [src].",
		span_notice("You remove [I] from [src].")
	)
	installedParts -= I
	return TRUE

/obj/item/part/gun/frame/proc/insert_item(obj/item/I, mob/living/user)
	if(!I || !istype(user) || user.stat)
		return FALSE
	I.forceMove(src)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	to_chat(user, span_notice("You insert [I] into [src]."))
	return TRUE

/obj/item/part/gun/frame/proc/replace_item(obj/item/I_old, obj/item/I_new, mob/living/user)
	if(!I_old || !I_new || !istype(user) || user.stat || !user.Adjacent(I_new) || !user.Adjacent(I_old))
		return FALSE
	I_new.forceMove(src)
	user.put_in_hands(I_old)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	spawn(2)
		playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] replaces [I_old] with [I_new] in [src].",
		span_notice("You replace [I_old] with [I_new] in [src]."))
	return TRUE

/obj/item/part/gun/frame/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/part/gun))
		handle_part(I, user)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		var/list/possibles = contents.Copy()
		var/obj/item/part/gun/toremove = input("Which part would you like to remove?","Removing parts") in possibles
		if(!toremove)
			return
		if(I.use_tool(src, user, 40, volume=50))
			eject_item(toremove, user)
	return ..()

/obj/item/part/gun/frame/proc/handle_part(obj/item/part/gun/I, mob/living/user)
	for(var/datum/lathe_recipe/gun/recipe in filtered_recipes)
		if(I.type in recipe.validParts)
			if(I.gun_part_type && !(I.gun_part_type in get_part_types()))
				if(insert_item(I, user))
					to_chat(user, span_notice("You have attached the part to \the [src]."))
					installedParts += I
					get_current_recipes()
					return
				else
					to_chat(user, span_warning("This part does not fit!"))
			else
				to_chat(user, span_warning("This type of part is already installed!"))
		else
			to_chat(user, span_warning("This part cannot be installed on this [src]!"))


//Finds all recipes that match the current parts
/obj/item/part/gun/frame/proc/get_current_recipes()
	filtered_recipes = list()
	for(var/datum/lathe_recipe/gun/recipe in GLOB.gun_recipe_list)
		if(is_recipe_valid(recipe))
			filtered_recipes += recipe
	return filtered_recipes


//Should return false if
/obj/item/part/gun/frame/proc/is_recipe_valid(datum/lathe_recipe/gun/recipe)
	if(!(src.type in recipe.validParts))
		return FALSE
	for(var/obj/item/part/gun/installed_part in installedParts)
		if(!(installed_part.type in recipe.validParts))
			return FALSE
	return TRUE

/obj/item/part/gun/frame/attack_self(mob/user)
	var/list/choose_options = list()
	var/list/option_results = list()
	for(var/datum/lathe_recipe/gun/recipe in filtered_recipes)
		var/obj/recipe_result = recipe.result
		var/list/parts_for_craft = list()
		for(var/obj/item/part/gun/part as anything in recipe.validParts)
			var/part_type = initial(part.gun_part_type)
			var/list/installed_types = get_part_types()
			if(!(part_type in installed_types))
				parts_for_craft += "	\a [initial(part.name)]"
		if(length(parts_for_craft) != 0)
			to_chat(user, span_warning("Parts needed for a [initial(recipe_result.name)]:"))
			for(var/part in parts_for_craft)
				to_chat(user, span_warning(part))
		else
			to_chat(user, span_notice("You can craft a [initial(recipe_result.name)] with the parts installed."))
			choose_options += list("Craft [initial(recipe_result.name)]" = image(icon = initial(recipe_result.icon), icon_state = initial(recipe_result.icon_state)))
			option_results["Craft [initial(recipe_result.name)]"] = recipe_result
	if(length(choose_options) == 0)
		to_chat(user, span_warning("No recipes can be crafted with the parts installed."))
		return
	var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
	if(!picked_option)
		return
	var/turf/T = get_turf(src)
	var/obj/item/gun/ballistic/pickedGun = option_results[picked_option]
	var/obj/item/gun/newGun = new pickedGun(T, FALSE, FALSE)
	newGun.frame = src
	src.forceMove(newGun)

/obj/item/part/gun/frame/proc/get_part_types()
	var/list/part_types = list()
	part_types |= gun_part_type
	for(var/obj/item/part/gun/part in installedParts)
		part_types |= part.gun_part_type
	return part_types

/obj/item/part/gun/frame/examine(user, distance)
	. = ..()
	if(.)
		for(var/obj/item/part/gun/part in installedParts)
			. += "<span class='notice'>[src] has \a [part] [icon2html(part, user)] installed.</span>"
		for(var/datum/lathe_recipe/gun/recipe in filtered_recipes)
			var/obj/recipe_result = recipe.result
			var/list/parts_for_craft = list()
			for(var/obj/item/part/gun/part as anything in recipe.validParts)
				var/part_type = initial(part.gun_part_type)
				var/list/installed_types = get_part_types()
				if(!(part_type in installed_types))
					parts_for_craft += "	\a [initial(part.name)]"
			if(length(parts_for_craft) != 0)
				. += "<span class='notice'>Parts needed for a [initial(recipe_result.name)]:</span>"
				for(var/part in parts_for_craft)
					. += part
			else
				. += "<span class='notice'>You can craft a [initial(recipe_result.name)] with the parts installed.</span>"
/*
		var/part_type_message = ""
		for(var/part_type in get_part_types())
			part_type_message += "\a [part_type], "
		if(part_type_message)
			. += "<span class='notice'>[src] has " + part_type_message + ".</span>"
*/

/obj/item/part/gun/frame/winchester
	name = "winchester gun frame"
	icon_state = "frame_shotgun"
	preinstalledParts = list(
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/rifle,
		/obj/item/part/gun/modular/barrel/rifle
		)

/obj/item/part/gun/frame/winchester/mk1
	name = "winchester mk1 gun frame"

/obj/item/part/gun/frame/m1911
	name = "m1911 gun frame"
	preinstalledParts = list(
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/pistol,
		/obj/item/part/gun/modular/barrel/pistol
		)

/obj/item/part/gun/frame/commander
	name = "commander gun frame"

/obj/item/part/gun/frame/boltaction
	name = "bolt action gun frame"

/obj/item/part/gun/frame/revolver

/obj/item/part/gun/frame/tec9

/obj/item/part/gun/frame/shotgun
