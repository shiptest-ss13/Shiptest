#define DECONSTRUCT_STAMINA_MINIMUM 50
#define DECONSTRUCT_STAMINA_USE 20

/obj/structure/lathe
	name = "Machine Lathe"
	desc = "You could make alot of things with this."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "lathe"
	density = TRUE
	anchored = FALSE
	var/obj/item/work_piece = FALSE
	var/steps_left = 0
	//Whether there is an active job on the table
	var/in_progress = FALSE
	//Defines what job type its currently working on
	var/mode = FALSE
	//If activily doing a do untill loop
	var/working = FALSE
	//The part that the user has picked to fabricate
	var/obj/item/picked_part = FALSE
	var/list/tools_required = list(QUALITY_HAMMERING, QUALITY_SAWING, QUALITY_FILING)
	var/tool_required = FALSE

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
	remove_work_piece(user)

/obj/structure/lathe/attack_hand(mob/living/carbon/human/user)
	if(!work_piece)
		to_chat(user, "There is no item on the lathe.")
		return
	if(!mode)
		var/list/choose_options = list()
		choose_options += list("Deconstruct" = image(icon = 'icons/obj/tools.dmi', icon_state = "welder"))
		choose_options += list("Fabricate" = image(icon = 'icons/obj/tools.dmi', icon_state = "wrench"))
		mode = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
	if(mode && !working)
		if(mode == "Deconstruct")
			deconstruct_work_piece(user)
		if(mode == "Fabricate")
			work_on_part(user)

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(mode && !working)
		if(is_valid_tool(I))
			if(mode == "Deconstruct")
				deconstruct_work_piece(user)
			if(mode == "Fabricate")
				work_on_part(user)
		else
			balloon_alert(user, "you need a tool with [tool_required] to work on this part.")
	if(work_piece)
		to_chat(user, "You cant add another item to the lathe.")
		return
	if(istype(I, /obj/item))
		I.forceMove(src)
		work_piece = I
		work_piece.vis_flags |= VIS_INHERIT_ID
		vis_contents += work_piece

/obj/structure/lathe/proc/remove_work_piece(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		work_piece.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/obj/structure/lathe/proc/destroy_work_piece(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		qdel(work_piece)
		work_piece = FALSE
		in_progress = FALSE
		mode = FALSE

/obj/structure/lathe/proc/reset_lathe()
	picked_part = FALSE
	in_progress = FALSE
	mode = FALSE
	steps_left = FALSE
	working = FALSE

/obj/structure/lathe/proc/is_valid_tool(obj/item/I)
	if(I.has_quality(tool_required))
		return TRUE

/////////////////
// DECONSTRUCT //
/////////////////

/obj/structure/lathe/proc/deconstruct_work_piece(mob/living/carbon/human/user)
	if(!in_progress)
		in_progress = TRUE
		steps_left = 3
	if(user.getStaminaLoss() > DECONSTRUCT_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			deconstruct_work_piece(user)
		else
			scrap_work_piece(work_piece)
	working = FALSE

/obj/structure/lathe/proc/scrap_work_piece(mob/user)
	to_chat(user, "The [work_piece.name] is broken down into parts.")
	playsound(src,'sound/items/welder.ogg',50,TRUE)
	if(istype(work_piece, /obj/item/gun))
		//var/obj/item/gun/gun_work_piece = work_piece
		var/obj/item/new_part = new /obj/item/stack/gun_part
		new_part.forceMove(drop_location())
		/* I think this should be a seperate procces for obtaining the frame
		if(gun_work_piece.frame)
			var/obj/item/frame = gun_work_piece.frame
			frame.forceMove(drop_location())
		*/
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/material_amount = materials.get_item_material_amount(work_piece)
	if(material_amount)
		materials.insert_item(work_piece)
		materials.retrieve_all()
	destroy_work_piece(user)
	reset_lathe()

///////////////
// FABRICATE //
///////////////

/obj/structure/lathe/proc/choose_part(mob/living/carbon/human/user)
	if(istype (work_piece, /obj/item/gun))
		var/obj/item/gun/gun_work_piece = work_piece
		var/list/choose_options = list()
		var/list/option_results = list()
		if(gun_work_piece.frame)
			var/obj/item/part/gun/frame/frame = gun_work_piece.frame
			if(frame.material_cost)
				choose_options += list("Craft [frame.name]" = image(icon = frame.icon , icon_state = frame.icon_state))
				option_results["Craft [frame.name]"] = frame.type
			for(var/obj/item/part/gun/gun_part in frame.installed_parts)
				if(gun_part.material_cost)
					choose_options += list("Craft [gun_part.name]" = image(icon = gun_part.icon, icon_state = gun_part.icon_state))
					option_results["Craft [gun_part.name]"] = gun_part.type
		var/choosen_part = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
		if(!choosen_part)
			return
		if(check_materials(choosen_part))
			return option_results[choosen_part]

/obj/structure/lathe/proc/get_surrounding_items()
	var/list/surrounding_items = list()
	for(var/obj/item/I in view(1, src))
		surrounding_items[I.type] += 1
	return surrounding_items

/obj/structure/lathe/proc/check_materials(obj/item/part/gun/gun_part)
	var/list/surrounding_items = get_surrounding_items()
	for(var/obj/item/material in gun_part.material_cost)
		if(!(material in surrounding_items) || surrounding_items[material] < gun_part.material_cost[material])
			return FALSE
	return TRUE

/obj/structure/lathe/proc/start_work(mob/living/carbon/human/user)
	if(in_progress)
		return TRUE
	in_progress = TRUE
	tools_required = list(/obj/item/tool/hammer, /obj/item/tool/file, /obj/item/tool/saw)
	tool_required = pick(tools_required)
	steps_left = 3
	return TRUE

/obj/structure/lathe/proc/work_on_part(mob/living/carbon/human/user)
	if(!picked_part)
		picked_part = choose_part(user)
	if(!picked_part || !start_work(user))
		return
	if(user.getStaminaLoss() > DECONSTRUCT_STAMINA_MINIMUM)
		balloon_alert(user, "too tired")
		return FALSE
	working = TRUE
	if(do_after(user, 20, work_piece))
		if(steps_left > 1)
			steps_left--
			playsound(src,'sound/items/welder2.ogg',50,TRUE)
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			tool_required = pick(tools_required)
			balloon_alert(user, "You need a [tool_required.name] next.")
			work_on_part(user)
		else
			fabricate_part(user)
	working = FALSE

/obj/structure/lathe/proc/fabricate_part(mob/living/carbon/human/user)
	if(!picked_part)
		return
	var/turf/T = get_turf(src)
	var/obj/item/part/gun/new_part = new picked_part(T)
	new_part.forceMove(drop_location())
	reset_lathe()
