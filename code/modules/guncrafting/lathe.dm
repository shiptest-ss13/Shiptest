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

/obj/structure/lathe/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun))
		I.forceMove(src)
		work_piece = I
		vis_contents += work_piece


