#define DECONSTRUCT_STAMINA_MINIMUM 50
#define DECONSTRUCT_STAMINA_USE 40

/obj/structure/lathe
	name = "Machine Lathe"
	desc = "You could make alot of things with this."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "lathe"
	density = TRUE
	anchored = FALSE
	var/obj/item/work_piece = FALSE
	var/obj/item/blueprint/blueprint = FALSE
	var/steps_left = 0
	//Whether there is an active job on the table
	var/in_progress = FALSE
	//Defines what job type its currently working on
	var/mode = FALSE
	//If activily doing a do untill loop
	var/working = FALSE

/obj/structure/lathe/Initialize()
	AddComponent(/datum/component/material_container, list(/datum/material/iron, /datum/material/glass, /datum/material/silver, /datum/material/plasma, /datum/material/gold, /datum/material/diamond, /datum/material/plastic, /datum/material/uranium, /datum/material/bananium, /datum/material/titanium, /datum/material/bluespace), INFINITY, FALSE, null, null, null, TRUE)
	. = ..()


/obj/structure/lathe/examine(mob/user)
	. = ..()
	if(steps_left)
		. += "\nThere are [steps_left] steps left."

/obj/structure/lathe/AltClick(mob/user)
	if(in_progress)
		to_chat(user, "The lathe is currently in use.")
		return
	remove_part(user)

/obj/structure/lathe/attack_hand(mob/living/carbon/human/user)
	if(!mode)
		var/list/choose_options = list()
		choose_options += list("Deconstruct" = image(icon = 'icons/obj/tools.dmi', icon_state = "welder"))
		choose_options += list("Research" = image(icon = 'icons/obj/tools.dmi', icon_state = "analyzer"))
		choose_options += list("Fabricate" = image(icon = 'icons/obj/tools.dmi', icon_state = "wrench"))
		mode = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
	if(mode && !working)
		if(mode == "Deconstruct")
			if(!work_piece)
				to_chat(user, "There is no item on the lathe.")
				return
			deconstruct_part(user)
		if(mode == "Research")
			if(!work_piece)
				to_chat(user, "There is no item on the lathe.")
				return
			research_part(user)
		if(mode == "Fabricate")
			if(!blueprint)
				to_chat(user, "There is no blueprint on the lathe.")
				return
			fabricate_part(user)

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/blueprint))
		if(blueprint)
			to_chat(user, "You cant add another blueprint to the lathe.")
			return
		I.forceMove(src)
		blueprint = I
		return
	if(work_piece)
		to_chat(user, "You cant add another item to the lathe.")
		return
	if(istype(I, /obj/item))
		I.forceMove(src)
		work_piece = I
		work_piece.vis_flags |= VIS_INHERIT_ID
		vis_contents += work_piece

/obj/structure/lathe/proc/remove_part(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		work_piece.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/obj/structure/lathe/proc/destroy_part(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		qdel(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/////////////////
// DECONSTRUCT //
/////////////////

/obj/structure/lathe/proc/deconstruct_part(mob/living/carbon/human/user)
	if(!in_progress)
		in_progress = TRUE
		steps_left = 3
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			deconstruct_part(user)
		else
			scrap_item(work_piece)
	working = FALSE

/obj/structure/lathe/proc/scrap_item(mob/user)
	to_chat(user, "The [work_piece.name] is broken down into parts.")
	playsound(src,'sound/items/welder.ogg',50,TRUE)
	if(istype (work_piece, /obj/item/modgun))
		var/obj/item/new_part = new /obj/item/part/gun
		new_part.forceMove(drop_location())
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/material_amount = materials.get_item_material_amount(work_piece)
	if(material_amount)
		materials.insert_item(work_piece)
		materials.retrieve_all()
	destroy_part(user)

//////////////
// RESEARCH //
//////////////

/obj/structure/lathe/proc/research_part(mob/living/carbon/human/user)
	if(!in_progress)
		in_progress = TRUE
		steps_left = 3
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			research_part(user)
		else
			var/obj/item/blueprint/blueprint = new /obj/item/blueprint
			blueprint.desc += "\nA blueprint on [work_piece.name]."
			blueprint.design = work_piece
			blueprint.forceMove(drop_location())
			if(Adjacent(user) && !issilicon(user))
				user.put_in_hands(blueprint)
			remove_part(user)
	working = FALSE

///////////////
// FABRICATE //
///////////////

/obj/structure/lathe/proc/fabricate_part(mob/living/carbon/human/user)
	if(blueprint)
		var/obj/item/new_part = new blueprint.design(loc)
		new_part.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(new_part)


///////////
// ITEMS //
///////////

/obj/item/stack/gun_part
	name = "Gun Part"
	desc = "This could fabcricate metal parts."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "work_piece"
	max_amount = 10

/obj/item/part/gun
	name = "gun part"
	desc = "Spare part of gun."

/obj/item/part/gun/frame
	name = "gun frame"
	desc = "a generic gun frame. consider debug"
	var/result = /obj/item/modgun

	// Currently installed grip
	var/obj/item/part/gun/modular/grip/InstalledGrip
	// Which grips does the frame accept?
	var/list/gripvars = list(/obj/item/part/gun/modular/grip/wood, /obj/item/part/gun/modular/grip/black)

	// What are the results (in order relative to gripvars)?
	var/list/resultvars = list(/obj/item/modgun, /obj/item/modgun)

	// Currently installed mechanism
	var/obj/item/part/gun/modular/grip/InstalledMechanism
	// Which mechanism the frame accepts?
	var/list/mechanismvar = /obj/item/part/gun/modular/mechanism

	// Currently installed barrel
	var/obj/item/part/gun/modular/barrel/InstalledBarrel
	// Which barrels does the frame accept?
	var/list/barrelvars = list(/obj/item/part/gun/modular/barrel)

	// Bonuses from forging/type or maluses from printing
	var/cheap = FALSE // Set this to true for cheap variants

/obj/item/part/gun/frame/New(loc, ...)
	. = ..()
	var/obj/item/modgun/G = new result(null)

/obj/item/part/gun/frame/New(loc)
	..()
	var/spawn_with_preinstalled_parts = FALSE

	if(spawn_with_preinstalled_parts)
		var/list/parts_list = list("mechanism", "barrel", "grip")

		pick_n_take(parts_list)
		if(prob(50))
			pick_n_take(parts_list)

		for(var/part in parts_list)
			switch(part)
				if("mechanism")
					InstalledMechanism = new mechanismvar(src)
				if("barrel")
					var/select = pick(barrelvars)
					InstalledBarrel = new select(src)
				if("grip")
					var/select = pick(gripvars)
					InstalledGrip = new select(src)
					var/variantnum = gripvars.Find(select)
					result = resultvars[variantnum]

/obj/item/part/gun/frame/proc/eject_item(obj/item/I, mob/living/user)
	if(!I || !user.IsAdvancedToolUser() || user.stat || !user.Adjacent(I))
		return FALSE
	user.put_in_hands(I)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] removes [I] from [src].",
		span_notice("You remove [I] from [src].")
	)
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
	if(istype(I, /obj/item/part/gun/modular/grip))
		if(InstalledGrip)
			to_chat(user, span_warning("[src] already has a grip attached!"))
			return
		else
			handle_gripvar(I, user)

	if(istype(I, /obj/item/part/gun/modular/mechanism))
		if(InstalledMechanism)
			to_chat(user, span_warning("[src] already has a mechanism attached!"))
			return
		else
			handle_mechanismvar(I, user)

	if(istype(I, /obj/item/part/gun/modular/barrel))
		if(InstalledBarrel)
			to_chat(user, span_warning("[src] already has a barrel attached!"))
			return
		else
			handle_barrelvar(I, user)

	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		var/list/possibles = contents.Copy()
		var/obj/item/part/gun/toremove = input("Which part would you like to remove?","Removing parts") in possibles
		if(!toremove)
			return
		if(I.use_tool(src, user, 40, volume=50))
			eject_item(toremove, user)
			if(istype(toremove, /obj/item/part/gun/modular/grip))
				InstalledGrip = null
			else if(istype(toremove, /obj/item/part/gun/modular/barrel))
				InstalledBarrel = FALSE
			else if(istype(toremove, /obj/item/part/gun/modular/mechanism))
				InstalledMechanism = FALSE

	return ..()

/obj/item/part/gun/frame/proc/handle_gripvar(obj/item/I, mob/living/user)
	if(I.type in gripvars)
		if(insert_item(I, user))
			var/variantnum = gripvars.Find(I.type)
			result = resultvars[variantnum]
			InstalledGrip = I
			to_chat(user, span_notice("You have attached the grip to \the [src]."))
			return
	else
		to_chat(user, span_warning("This grip does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_mechanismvar(obj/item/I, mob/living/user)
	if(I.type == mechanismvar)
		if(insert_item(I, user))
			InstalledMechanism = I
			to_chat(user, span_notice("You have attached the mechanism to \the [src]."))
			return
	else
		to_chat(user, span_warning("This mechanism does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_barrelvar(obj/item/I, mob/living/user)
	if(I.type in barrelvars)
		if(insert_item(I, user))
			InstalledBarrel = I
			to_chat(user, span_notice("You have attached the barrel to \the [src]."))
			return
	else
		to_chat(user, span_warning("This barrel does not fit!"))
		return

/obj/item/part/gun/frame/attack_self(mob/user)
	. = ..()
	var/turf/T = get_turf(src)
	if(!InstalledGrip)
		to_chat(user, span_warning("\the [src] does not have a grip!"))
		return
	if(!InstalledMechanism)
		to_chat(user, span_warning("\the [src] does not have a mechanism!"))
		return
	if(!InstalledBarrel)
		to_chat(user, span_warning("\the [src] does not have a barrel!"))
		return
	var/obj/item/modgun/G = new result(T)
	if(barrelvars.len > 1 && istype(G, /obj/item/modgun))
		var/obj/item/modgun/P = G
		P.caliber = InstalledBarrel.caliber
		G.gun_parts = list(src.type = 1, InstalledGrip.type = 1, InstalledMechanism.type = 1, InstalledBarrel.type = 1)
	qdel(src)
	return

/obj/item/part/gun/frame/examine(user, distance)
	. = ..()
	if(.)
		if(InstalledGrip)
			to_chat(user, span_notice("\the [src] has \a [InstalledGrip] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a grip installed."))
		if(InstalledMechanism)
			to_chat(user, span_notice("\the [src] has \a [InstalledMechanism] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a mechanism installed."))
		if(InstalledBarrel)
			to_chat(user, span_notice("\the [src] has \a [InstalledBarrel] installed."))
		else
			to_chat(user, span_notice("\the [src] does not have a barrel installed."))

/obj/item/modgun
	name = "gun"
	desc = "A gun."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "detective"
	item_state = "gun"
	var/caliber = 357
	var/gun_parts = list()

/obj/item/part/gun
	name = "gun part"
	desc = "Spare part of gun."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "gun_part"

/obj/item/part/gun/modular
/obj/item/part/gun/modular/grip/wood
	name = "wooden grip"
/obj/item/part/gun/modular/grip/black
	name = "black grip"
/obj/item/part/gun/modular/mechanism
	name = "mechanism"
/obj/item/part/gun/modular/barrel
	name = "barrel"
	var/caliber = 357
/obj/item/blueprint
	name = "Blueprint"
	desc = "This could be used to make a gun."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "blueprint"
	var/design = FALSE
	var/blueprint = FALSE
