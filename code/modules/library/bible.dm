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

// SRM

/obj/item/book/bible/srm
	name = "Liber Incendium"
	desc = "Otherwise known as the Book of Conflagration. The pages are blank. There must have been a misprint."
	icon_state = "book6"
	item_state = "book6"

/datum/outfit/job/roumain/flamebearer
	name = "Saint-Roumain Militia - Flamebearer"
	id_assignment = "flamebearer"
	jobtype = /datum/job/chaplain
	job_icon = "chaplain"
	uniform = /obj/item/clothing/under/suit/roumain
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/witchhunter
	head = /obj/item/clothing/head/witchhunter

/obj/item/clothing/accessory/srm
	name = "Ashen Sachet"
	desc = "A small sachet filled with ashes. These are most commonly ancient-growth tree or a slain predetor the owner hunted themselves, each having a diffrent meaning to the "

// STJARN COLLECTIVE

/obj/item/book/bible/stars
	name = "Hail to the stars"
	desc = "The grand text of the Stjarn. Its the collective research, history, and practices of the group. The pages are blank. There must have been a misprint."
	icon_state = "book2"
	item_state = "book2"

// Stjärnforskare. Swedish for star scientist. On the nose
/datum/outfit/job/chaplain/star
	name = "Stjarn Seer"
	neck = /obj/item/bedsheet/cosmos
	backpack_contents = list(
		/obj/item/starmap = 1,
		/obj/item/binoculars/sextant = 1
		)

/obj/item/clothing/accessory/cosmo
	name = "Stjarn Patch"
	desc = "A delicate hand stiched patch of the star system the wearer was born from. Underneath the art is written: HAIL TO THE STARS."

// karta. Swedish for map
/obj/item/starmap
	name = "sector star karta"
	desc = "A intricate and colorful starmap of this sector. karta is and old word for map."

/obj/item/binoculars/sextant
	name = "engraved sextant"
	desc = "Its engraved in star maps of the most populated sectors."

// BLUEFLAME

/obj/item/book/bible/blueflame
	name = "History of the blueflame"
	desc = "The text of the Astrometry Initiative. The pages are blank. There must have been a misprint."
	icon_state = "book4"
	item_state = "book4"

/obj/item/clothing/accessory/blueflame
	name = "Blueflame Pin"
	desc = "A steel pin that has been blued to mimic the color of the Blueflames worshiped star."

/obj/item/clothing/neck/cloak/blueflame

/datum/outfit/job/chaplain/blueflame
