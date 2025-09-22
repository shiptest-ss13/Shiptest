// For Cases of all kinds, storage with specific purpose

//Base Case
/obj/item/storage/case
	name = "case"
	desc = "A large case."
	icon = 'icons/obj/storage.dmi'
	icon_state = "case_base"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox_pickup.ogg'
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/case/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.use_sound = 'sound/items/storage/toolbox.ogg'

/obj/item/storage/case/surgery
	name = "surgical case"
	icon_state = "case_surgery"
	item_state = "case_surgery"
	desc = "A large sterile tray with a lid for storing all of the tools you'd need for surgery."

//Surgical Case
/obj/item/storage/case/surgery/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = INFINITY //workaround for the differently sized items, case is still limited to 8 items max and to the list.
	STR.max_combined_w_class = INFINITY //part of the workaround, not setting a max combined weight defaults to some weird number.
	STR.max_items = 8
	STR.set_holdable(list(
		/obj/item/healthanalyzer,
		/obj/item/healthanalyzer/advanced,
		/obj/item/scalpel,
		/obj/item/scalpel/advanced,
		/obj/item/circular_saw,
		/obj/item/circular_saw/best, //CODY WUZ HERE
		/obj/item/surgicaldrill,
		/obj/item/surgicaldrill/advanced,
		/obj/item/retractor,
		/obj/item/retractor/advanced,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/shears,
		/obj/item/bonesetter,
	))

/obj/item/storage/case/surgery/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/scalpel = 1,
		/obj/item/retractor = 1,
		/obj/item/hemostat = 1,
		/obj/item/circular_saw = 1,
		/obj/item/surgicaldrill = 1,
		/obj/item/cautery = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/bonesetter = 1,
	)
	generate_items_inside(items_inside,src)
