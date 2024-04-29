/obj/item/storage/book
	name = "hollowed book"
	desc = "I guess someone didn't like it."
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	var/title = "book"

/obj/item/storage/book/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1

/obj/item/storage/book/attack_self(mob/user)
	to_chat(user, "<span class='notice'>The pages of [title] have been cut out!</span>")

/obj/item/storage/book/bible
	name = "ancient text of worship"
	desc = "Completely ruined by age, nothing is understandable"
	icon = 'icons/obj/storage.dmi'
	icon_state = "bible"
	item_state = "bible"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	force_string = "holy"

/obj/item/storage/book/bible/booze/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)

/obj/item/book/bible
	name = "ancient text of worship"
	desc = "Completely ruined by age, nothing is understandable"

/obj/item/book/bible/srm
	name = "Liber Incendium"
	desc = "Otherwise known as the Book of Conflagration. The pages are blank. There must have been a misprint."
	icon_state = "book6"
	item_state = "book6"

/obj/item/book/bible/stars
	name = "Hail to the stars"
	desc = "The pages are blank. There must have been a misprint."
	icon_state = "book2"
	item_state = "book2"

/obj/item/book/bible/blueflame
	name = "History of the blueflame"
	desc = "The pages are blank. There must have been a misprint."
	icon_state = "book4"
	item_state = "book4"
