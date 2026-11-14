// Contains:
// Gavel
// Sound Block

/obj/item/gavelhammer
	name = "gavel"
	desc = "Order, order! No bombs in my courthouse."
	icon = 'icons/obj/items.dmi'
	icon_state = "gavelhammer"
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("bashed", "battered", "judged", "whacked")
	resistance_flags = FLAMMABLE

/obj/item/gavelblock
	name = "sound block"
	desc = "Smack it with a gavel when the assistants get rowdy."
	icon = 'icons/obj/items.dmi'
	icon_state = "gavelblock"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE

/obj/item/gavelblock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/gavelhammer))
		playsound(loc, 'sound/items/gavel.ogg', 100, TRUE)
		user.visible_message(span_warning("[user] strikes [src] with [I]."))
		user.changeNext_move(CLICK_CD_MELEE)
	else
		return ..()
