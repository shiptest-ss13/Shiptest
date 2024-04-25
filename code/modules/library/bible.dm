//need to refactor this.
GLOBAL_LIST_INIT(biblenames, list("Hail to the Stars", "The History of the SRM", "Text of the Blueflame"))
//If you get these two lists not matching in size, there will be runtimes and I will hurt you in ways you couldn't even begin to imagine
// if your bible has no custom itemstate, use one of the existing ones
GLOBAL_LIST_INIT(biblestates, list("book6", "book2", "book4"))
GLOBAL_LIST_INIT(bibleitemstates, list("book6", "book2", "book4"))

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
	var/mob/affecting = null
	var/deity_name = "Christ"
	force_string = "holy"

/obj/item/storage/book/bible/booze/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)


/obj/item/book/bible
	name = "ancient text of worship"
	desc = "Completely ruined by age, nothing is understandable"

/obj/item/book/bible/srm
	name = "History of the srm"

/obj/item/book/bible/stars
	name = "Hail to the stars"

/obj/item/book/bible/blueflame
	name = "History of the blueflame"
	desc = "I need to learn more about these folk"
