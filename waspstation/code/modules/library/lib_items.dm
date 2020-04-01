/obj/structure/bookcase/manuals/medical
	name = "medical manuals bookcase"

/obj/structure/bookcase/manuals/medical/Initialize()
	. = ..()
	new /obj/item/book/manual/wiki/medical_cloning(src)
	update_icon()

/obj/item/book/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] begins closing the book on life! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/items/handling/paper_pickup.ogg', 100, TRUE)
	return BRUTELOSS;
