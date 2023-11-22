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
	if(work_piece)
		vis_contents -= work_piece
		work_piece.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(work_piece)
		work_piece = FALSE

/obj/structure/lathe/attack_hand(mob/living/carbon/human/user)
	if(istype(work_piece, /obj/item) && !mode)
		var/list/choose_options = list()
		choose_options += list("Deconstruct" = image(icon = 'icons/obj/tools.dmi', icon_state = "welder"))
		mode = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
	if(mode && !working)
		if(mode == "Deconstruct")
			deconstruct_part(user)

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(!work_piece && istype(I, /obj/item))
		I.forceMove(src)
		work_piece = I
		work_piece.vis_flags |= VIS_INHERIT_ID
		vis_contents += work_piece

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
			to_chat(user, "You have [steps_left] steps left.")
			user.adjustStaminaLoss(DECONSTRUCT_STAMINA_USE)
			deconstruct_part(user)
		else
			scrap_item(work_piece)
	working = FALSE

/obj/structure/lathe/proc/scrap_item(mob/user)
	to_chat(user, "The [work_piece.name] is broken down into parts.")
	if(istype (work_piece, /obj/item/gun))
		deconstruct_gun()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/material_amount = materials.get_item_material_amount(work_piece)
	if(material_amount)
		materials.insert_item(work_piece)
		materials.retrieve_all()
	vis_contents -= work_piece
	qdel(work_piece)
	work_piece = FALSE
	in_progress = FALSE
	mode = FALSE

/obj/structure/lathe/proc/deconstruct_gun()
	var/obj/item/new_part = new /obj/item/gun_part
	new_part.forceMove(drop_location())

/obj/item/gun_part
	name = "Gun Part"
	desc = "This could fabcricate metal parts."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "work_piece"

/obj/item/mod_gun/frame
