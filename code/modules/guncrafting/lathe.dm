/obj/structure/lathe
	name = "Machine Lathe"
	desc = "You could make alot of things with this."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "lathe"
	density = TRUE
	anchored = FALSE
	var/obj/item/work_piece = FALSE

/obj/structure/lathe/AltClick(mob/user)
	if(work_piece)
		vis_contents -= work_piece
		work_piece.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(work_piece)
		work_piece = FALSE

/*
/obj/structure/lathe/attack_hand(mob/user)
	if(work_piece)
		var/list/choose_options = list()
		choose_options += list("Screwdriver" = image(icon = 'icons/obj/tools.dmi', icon_state = "screwdriver_nuke"))
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
		if(picked_option)
			if(picked_option == "Screwdriver")
				work_piece.screwdriver_act(user, /obj/item/screwdriver)
*/

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(!work_piece && istype(I, /obj/item/gun))
		I.forceMove(src)
		work_piece = I
		work_piece.vis_flags |= VIS_INHERIT_ID
		vis_contents += work_piece
	else
		work_piece.attackby(I, user)
