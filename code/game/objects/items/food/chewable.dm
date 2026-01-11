/obj/item/food/chewable
	slot_flags = ITEM_SLOT_MASK
	///How long it lasts before being deleted in seconds
	var/succ_dur = 360
	///The delay between each time it will handle reagents
	var/succ_int = 100
	///Stores the time set for the next handle_reagents //bro come on
	var/next_succ = 0

/obj/item/food/chewable/proc/handle_reagents()
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(!reagents.trans_to(C, REAGENTS_METABOLISM, methods = INGEST))
					reagents.remove_any(REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)

/obj/item/food/chewable/process(seconds_per_tick)
	if(iscarbon(loc))
		if(succ_dur <= 0)
			qdel(src)
			return
		succ_dur -= seconds_per_tick
		if((reagents && reagents.total_volume) && (next_succ <= world.time))
			handle_reagents()
			next_succ = world.time + succ_int

/obj/item/food/chewable/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_MASK)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/food/chewable/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/food/chewable/bubblegum
	name = "bubblegum"
	desc = "A rubbery strip of gum. Not exactly filling, but it keeps you busy."
	icon_state = "bubblegum"
	item_state = "bubblegum"
	supports_variations = VOX_VARIATION
	color = "#E48AB5"
	food_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)

/obj/item/food/chewable/bubblegum/nicotine
	name = "nicotine gum"
	food_reagents = list(
		/datum/reagent/drug/nicotine = 10,
		/datum/reagent/consumable/menthol = 5,
	)
	tastes = list("mint" = 1)
	color = "#60A584"

/obj/item/food/chewable/bubblegum/happiness
	name = "HP+ gum"
	desc = "A rubbery strip of gum, originating from a fad of using gum as a vessel for recreational drugs. This one tastes particularly acrid..."
	food_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("intense chemical sweetness" = 1)
	color = "#EE35FF"

//boxes for gum
/obj/item/storage/box/bubblegum
	name = "bubblegum packet"
	desc = "The packaging is entirely in japanese, apparently. You can't make out a single word of it."
	icon_state = "bubblegum_generic"
	w_class = WEIGHT_CLASS_TINY
	illustration = null
	foldable = null

/obj/item/storage/box/bubblegum/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_TINY
	STR.max_items = 4
	STR.set_holdable(list(
		/obj/item/food/chewable/bubblegum,
	))

/obj/item/storage/box/bubblegum/PopulateContents()
	var/static/items_inside = list(
		/obj/item/food/chewable/bubblegum = 4,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/bubblegum/nicotine
	name = "nicotine gum packet"
	desc = "Designed to help with nicotine addiction and oral fixation all at once without destroying your lungs in the process. Mint flavored!"
	icon_state = "bubblegum_nicotine"

/obj/item/storage/box/bubblegum/nicotine/PopulateContents()
	var/static/items_inside = list(
		/obj/item/food/chewable/bubblegum/nicotine = 4,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/bubblegum/happiness
	name = "HP+ gum packet"
	desc = "A seemingly homemade packaging with an odd smell. It has a weird drawing of a smiling face sticking out its tongue."
	icon_state = "bubblegum_happiness"

/obj/item/storage/box/bubblegum/happiness/PopulateContents()
	var/static/items_inside = list(
		/obj/item/food/chewable/bubblegum/happiness = 4,
	)
	generate_items_inside(items_inside,src)
