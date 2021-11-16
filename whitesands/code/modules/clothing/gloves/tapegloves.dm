/obj/item/clothing/gloves/color/yellow/sprayon/tape
	name = "taped-on insulated gloves"
	desc = "This is a totally safe idea."
	icon_state = "yellowtape"
	item_state = "ygloves"
	shocks_remaining = 3

/obj/item/clothing/gloves/color/yellow/sprayon/tape/Initialize()
	.=..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/gloves/color/yellow/sprayon/tape/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_SHOCK_PREVENTED, .proc/Shocked)

/obj/item/clothing/gloves/color/yellow/sprayon/tape/Shocked(mob/user)
	if(prob(50)) //Fear the unpredictable
		shocks_remaining--
	if(shocks_remaining <= 0)
		playsound(user, 'sound/items/poster_ripped.ogg', 30)
		to_chat(user, "<span class='danger'>\The [src] fall appart into useless scraps!</span>")
		qdel(src)
