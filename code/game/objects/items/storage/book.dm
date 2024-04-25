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

GLOBAL_LIST_INIT(biblenames, list("Bible", "Quran", "Scrapbook", "Burning Bible", "Clown Bible", "Banana Bible", "Creeper Bible", "White Bible", "Holy Light", "The God Delusion", "Tome", "The King in Yellow", "Ithaqua", "Scientology", "Melted Bible", "Necronomicon", "Insulationism", "Guru Granth Sahib"))
//If you get these two lists not matching in size, there will be runtimes and I will hurt you in ways you couldn't even begin to imagine
// if your bible has no custom itemstate, use one of the existing ones
GLOBAL_LIST_INIT(biblestates, list("bible", "koran", "scrapbook", "burning", "honk1", "honk2", "creeper", "white", "holylight", "atheist", "tome", "kingyellow", "ithaqua", "scientology", "melted", "necronomicon", "insuls", "gurugranthsahib"))
GLOBAL_LIST_INIT(bibleitemstates, list("bible", "koran", "scrapbook", "burning", "honk1", "honk2", "creeper", "white", "holylight", "atheist", "tome", "kingyellow", "ithaqua", "scientology", "melted", "necronomicon", "kingyellow", "gurugranthsahib"))

/obj/item/storage/book/bible
	name = "bible"
	desc = "Apply to head repeatedly."
	icon = 'icons/obj/storage.dmi'
	icon_state = "bible"
	item_state = "bible"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	var/mob/affecting = null
	var/deity_name = "Christ"
	force_string = "holy"

/obj/item/storage/book/bible/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, FALSE, TRUE)

/obj/item/storage/book/bible/attack_self(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(!H.can_read(src))
		return FALSE
	// If H is the Chaplain, we can set the icon_state of the bible (but only once!)
	if(!GLOB.bible_icon_state && H.mind.holy_role == HOLY_ROLE_HIGHPRIEST)
		var/dat = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>Pick Bible Style</title></head><body><center><h2>Pick a bible style</h2></center><table>"
		for(var/i in 1 to GLOB.biblestates.len)
			var/icon/bibleicon = icon('icons/obj/storage.dmi', GLOB.biblestates[i])
			var/nicename = GLOB.biblenames[i]
			H << browse_rsc(bibleicon, nicename)
			dat += {"<tr><td><img src="[nicename]"></td><td><a href="?src=[REF(src)];seticon=[i]">[nicename]</a></td></tr>"}
		dat += "</table></body></html>"
		H << browse(dat, "window=editicon;can_close=0;can_minimize=0;size=250x650")

/obj/item/storage/book/bible/Topic(href, href_list)
	if(!usr.canUseTopic(src, BE_CLOSE))
		return
	if(href_list["seticon"] && !GLOB.bible_icon_state)
		var/iconi = text2num(href_list["seticon"])
		var/biblename = GLOB.biblenames[iconi]
		icon_state = GLOB.biblestates[iconi]
		item_state = GLOB.bibleitemstates[iconi]
		if(icon_state == "insuls")
			var/mob/living/carbon/human/H =usr
			var/obj/item/clothing/gloves/color/fyellow/insuls = new
			insuls.name = "insuls"
			insuls.desc = "A mere copy of the true insuls."
			insuls.siemens_coefficient = 0.99999
			H.equip_to_slot(insuls, ITEM_SLOT_GLOVES)
		GLOB.bible_icon_state = icon_state
		GLOB.bible_item_state = item_state

		SSblackbox.record_feedback("text", "religion_book", 1, "[biblename]")
		usr << browse(null, "window=editicon")

/obj/item/storage/book/bible/koran
	name = "Koran"
	icon_state = "koran"
	item_state = "koran"
	deity_name = "Allah"

/obj/item/storage/book/bible/booze
	desc = "To be applied to the head repeatedly."

/obj/item/storage/book/bible/booze/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)

/obj/item/storage/book/bible/syndicate
	name = "Syndicate Tome"
	icon_state ="ebook"
	deity_name = "The Syndicate"
