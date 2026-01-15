/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * Contains:
 *		Donut Box
 *		Egg Box
 *		Candle Box
 *		Cigarette Box
 *		Cigar Case
 *		Heart Shaped Box w/ Chocolates
 */

/obj/item/storage/fancy
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "donutbox"
	base_icon_state = "donutbox"
	resistance_flags = FLAMMABLE
	/// Used by examine to report what this thing is holding.
	var/contents_tag = "errors"
	/// What type of thing to fill this storage with.
	var/spawn_type = null
	/// Whether the container is open or not
	var/is_open = FALSE

/obj/item/storage/fancy/PopulateContents()
	if(!spawn_type)
		return
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(!spawn_type)
		return
	for(var/i = 1 to STR.max_items)
		new spawn_type(src)

/obj/item/storage/fancy/update_icon_state()
	icon_state = "[base_icon_state][is_open ? contents.len : null]"
	return ..()

/obj/item/storage/fancy/examine(mob/user)
	. = ..()
	if(!is_open)
		return
	if(length(contents) == 1)
		. += "There is one [contents_tag] left."
	else
		. += "There are [contents.len <= 0 ? "no" : "[contents.len]"] [contents_tag]s left."

/obj/item/storage/fancy/attack_self(mob/user)
	is_open = !is_open
	update_appearance()
	. = ..()

/obj/item/storage/fancy/Exited()
	. = ..()
	is_open = TRUE
	update_appearance()

/obj/item/storage/fancy/Entered()
	. = ..()
	is_open = TRUE
	update_appearance()

#define DONUT_INBOX_SPRITE_WIDTH 3

/*
 * Donut Box
 */

/obj/item/storage/fancy/donut_box
	name = "donut box"
	desc = "Mmm. Donuts."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox_inner"
	base_icon_state = "donutbox"
	spawn_type = /obj/item/food/donut
	is_open = TRUE
	appearance_flags = KEEP_TOGETHER
	contents_tag = "donut"

/obj/item/storage/fancy/donut_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.set_holdable(list(/obj/item/food/donut))

/obj/item/storage/fancy/donut_box/PopulateContents()
	. = ..()
	update_appearance()

/obj/item/storage/fancy/donut_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][is_open ? "_inner" : null]"

/obj/item/storage/fancy/donut_box/update_overlays()
	. = ..()

	if(!is_open)
		return

	var/donuts = 0

	for(var/_donut in contents)
		var/obj/item/food/donut/donut = _donut
		if (!istype(donut))
			continue

		. += image(icon = initial(icon), icon_state = donut.in_box_sprite(), pixel_x = donuts * DONUT_INBOX_SPRITE_WIDTH)
		donuts += 1

	. += image(icon = initial(icon), icon_state = "[base_icon_state]_top")

#undef DONUT_INBOX_SPRITE_WIDTH

/*
 * Egg Box
 */

/obj/item/storage/fancy/egg_box
	icon = 'icons/obj/food/containers.dmi'
	item_state = "eggbox"
	icon_state = "eggbox"
	base_icon_state = "eggbox"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	name = "egg box"
	desc = "A carton for containing eggs."
	spawn_type = /obj/item/food/egg
	contents_tag = "egg"

/obj/item/storage/fancy/egg_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 12
	STR.set_holdable(list(/obj/item/food/egg))

/obj/item/storage/fancy/egg_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][is_open ? "_open" : null]"

/obj/item/storage/fancy/egg_box/update_overlays()
	. = ..()
	cut_overlays()
	if(!is_open)
		return
	var/egg_count = 0
	for(var/obj/item/food/egg as anything in contents)
		egg_count++
		if(!egg)
			return
		var/image/current_huevo = image(icon = icon, icon_state = "eggbox_eggoverlay")
		if(egg_count <= 6) //less than 6 eggs
			current_huevo.pixel_x = (3*(egg_count-1))
		else //if more than 6, make an extra row
			current_huevo.pixel_x = (3*(egg_count-7)) //-7 to 'reset' it
			current_huevo.pixel_y = -3
		add_overlay(current_huevo)


/*
 * Candle Box
 */

/obj/item/storage/fancy/candle_box
	name = "candle pack"
	desc = "A pack of red candles."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	base_icon_state = "candlebox"
	item_state = "candlebox5"
	throwforce = 2
	slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/candle
	is_open = TRUE
	contents_tag = "candle"

/obj/item/storage/fancy/candle_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5

/obj/item/storage/fancy/candle_box/attack_self(mob_user)
	return

////////////
//CIG PACK//
////////////
/obj/item/storage/fancy/cigarettes
	name = "\improper Space Cigarettes packet"
	desc = "The most popular brand of cigarettes on the Frontier."
	icon = 'icons/obj/cigarettes.dmi'
	base_icon_state = "cig"
	icon_state = "cig"
	item_state = "cigpacket"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/clothing/mask/cigarette/space_cigarette
	var/candy = FALSE //for cigarette overlay
	custom_price = 10
	contents_tag = "cigarette"

/obj/item/storage/fancy/cigarettes/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.set_holdable(list(/obj/item/clothing/mask/cigarette, /obj/item/lighter))

/obj/item/storage/fancy/cigarettes/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to extract contents.")

/obj/item/storage/fancy/cigarettes/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag)
		return
	if(ishuman(target) && contents.len)
		var/mob/living/carbon/human/bumming_a_smoke = target
		if(do_after(user, 15, bumming_a_smoke, show_progress = FALSE))
			var/obj/item/clothing/mask/cigarette/british_slang = locate(/obj/item/clothing/mask/cigarette) in contents
			if(british_slang)
				SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, british_slang, user)
				if(bumming_a_smoke.equip_to_slot_if_possible(british_slang, ITEM_SLOT_MASK, disable_warning=TRUE))
					user.visible_message(span_notice("[user] puts a cigarette in [bumming_a_smoke]'s lips"), span_notice("You put a cigarette in [bumming_a_smoke]'s lips"))
				else
					bumming_a_smoke.put_in_hand(british_slang)
					user.visible_message(span_notice("[user] puts a cigarette in [bumming_a_smoke]'s hand"), span_notice("You put a cigarette in [bumming_a_smoke]'s hands"))
				contents -= british_slang

/obj/item/storage/fancy/cigarettes/attack_self_secondary(mob/living/carbon/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	get_cigarette(user)

/obj/item/storage/fancy/cigarettes/AltClick(mob/living/carbon/user)
	. = ..()
	var/obj/item/lighter/the_zippo = locate(/obj/item/lighter) in contents
	if(the_zippo)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, the_zippo, user)
		user.put_in_hands(the_zippo)
		contents -= the_zippo
	else
		get_cigarette(user)

/obj/item/storage/fancy/cigarettes/proc/get_cigarette(mob/living/carbon/user)
	var/obj/item/clothing/mask/cigarette/british_slang = locate(/obj/item/clothing/mask/cigarette) in contents
	if(british_slang)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, british_slang, user)
		user.put_in_hands(british_slang)
		contents -= british_slang
		to_chat(user, span_notice("You take \a [british_slang] out of the pack."))
	else
		to_chat(user, span_notice("There are no [contents_tag]s left in the pack."))


/obj/item/storage/fancy/cigarettes/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][contents.len ? null : "_empty"]"
	return

/obj/item/storage/fancy/cigarettes/update_overlays()
	. = ..()
	if(!is_open || !contents.len)
		return

	. += "[icon_state]_open"
	var/cig_position = 1
	for(var/C in contents)
		var/mutable_appearance/inserted_overlay = mutable_appearance(icon)

		if(istype(C, /obj/item/lighter/greyscale))
			inserted_overlay.icon_state = "lighter_in"
		else if(istype(C, /obj/item/lighter))
			inserted_overlay.icon_state = "zippo_in"
		else if(candy)
			inserted_overlay.icon_state = "candy"
		else
			inserted_overlay.icon_state = "cigarette"

		inserted_overlay.icon_state = "[inserted_overlay.icon_state]_[cig_position]"
		. += inserted_overlay
		cig_position++

/obj/item/storage/fancy/cigarettes/attack(mob/living/carbon/target, mob/living/carbon/user)
	if(!istype(target))
		return

	var/obj/item/clothing/mask/cigarette/cig = locate() in contents
	if(!cig)
		to_chat(user, span_notice("There are no [contents_tag]s left in the pack."))
		return
	if(target != user || !contents.len || user.wear_mask)
		return ..()

	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, cig, target)
	target.equip_to_slot_if_possible(cig, ITEM_SLOT_MASK)
	contents -= cig
	to_chat(user, span_notice("You take \a [cig] out of the pack."))
	return

/obj/item/storage/fancy/cigarettes/dromedaryco
	name = "\improper DromedaryCo packet"
	desc = "A packet of six imported DromedaryCo cancer sticks. A label on the packaging reads, \"Wouldn't a slow death make a change?\""
	icon_state = "dromedary"
	base_icon_state = "dromedary"
	spawn_type = /obj/item/clothing/mask/cigarette/dromedary

/obj/item/storage/fancy/cigarettes/cigpack_uplift
	name = "\improper Uplift Smooth packet"
	desc = "Your favorite brand, now menthol flavored."
	icon_state = "uplift"
	base_icon_state = "uplift"
	spawn_type = /obj/item/clothing/mask/cigarette/uplift

/obj/item/storage/fancy/cigarettes/cigpack_robust
	name = "\improper Robust packet"
	desc = "Smoked by the robust."
	icon_state = "robust"
	base_icon_state = "robust"
	spawn_type = /obj/item/clothing/mask/cigarette/robust

/obj/item/storage/fancy/cigarettes/cigpack_robustgold
	name = "\improper Robust Gold packet"
	desc = "Smoked by the truly robust."
	icon_state = "robustg"
	base_icon_state = "robustg"
	spawn_type = /obj/item/clothing/mask/cigarette/robustgold

/obj/item/storage/fancy/cigarettes/cigpack_carp
	name = "\improper Carp Classic packet"
	desc = "Since 207 FS."
	icon_state = "carp"
	base_icon_state = "carp"
	spawn_type = /obj/item/clothing/mask/cigarette/carp

/obj/item/storage/fancy/cigarettes/cigpack_syndicate
	name = "cigarette packet"
	desc = "A semi-obscure brand of cigarettes, favored by interstellar miners."
	icon_state = "syndie"
	base_icon_state = "syndie"
	spawn_type = /obj/item/clothing/mask/cigarette/syndicate

/obj/item/storage/fancy/cigarettes/cigpack_midori
	name = "\improper Midori Tabako packet"
	desc = "You can't understand the runes, but the packet smells funny."
	icon_state = "midori"
	base_icon_state = "midori"
	spawn_type = /obj/item/clothing/mask/cigarette/rollie/nicotine

/obj/item/storage/fancy/cigarettes/cigpack_candy
	name = "\improper Timmy's First Candy Smokes packet"
	desc = "Unsure about smoking? Want to bring your children safely into the family tradition? Look no more with this special packet! Includes 100%* Nicotine-Free candy cigarettes."
	icon_state = "candy"
	base_icon_state = "candy"
	contents_tag = "candy cigarette"
	spawn_type = /obj/item/clothing/mask/cigarette/candy
	candy = TRUE

/obj/item/storage/fancy/cigarettes/cigpack_candy/Initialize()
	. = ..()
	if(prob(7))
		spawn_type = /obj/item/clothing/mask/cigarette/candy/nicotine //uh oh!

/obj/item/storage/fancy/cigarettes/cigpack_cannabis
	name = "\improper Freak Brothers' Special packet"
	desc = "A label on the packaging reads, \"Endorsed by Phineas, Freddy and Franklin.\""
	icon_state = "midori"
	base_icon_state = "midori"
	spawn_type = /obj/item/clothing/mask/cigarette/rollie/cannabis

/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker
	name = "\improper Leary's Delight packet"
	desc = "Banned in over 36 Sectors."
	icon_state = "shadyjim"
	base_icon_state = "shadyjim"
	spawn_type = /obj/item/clothing/mask/cigarette/rollie/mindbreaker

/obj/item/storage/fancy/rollingpapers
	name = "rolling paper pack"
	desc = "A pack of Nanotrasen brand rolling papers."
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig_paper_pack"
	base_icon_state = "cig_paper_pack"
	contents_tag = "rolling paper"
	spawn_type = /obj/item/rollingpaper
	custom_price = 5

/obj/item/storage/fancy/rollingpapers/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 10
	STR.set_holdable(list(/obj/item/rollingpaper))

///Overrides to do nothing because fancy boxes are fucking insane.
/obj/item/storage/fancy/rollingpapers/update_icon_state()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/item/storage/fancy/rollingpapers/update_overlays()
	. = ..()
	if(!contents.len)
		. += "[base_icon_state]_empty"

/obj/item/storage/fancy/cigarettes/derringer
	name = "\improper Robust packet"
	desc = "Smoked by the robust."
	icon_state = "robust"
	spawn_type = /obj/item/gun/ballistic/derringer/traitor

/obj/item/storage/fancy/cigarettes/derringer/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.set_holdable(list(/obj/item/clothing/mask/cigarette, /obj/item/lighter, /obj/item/gun/ballistic/derringer, /obj/item/ammo_casing/a357))

/obj/item/storage/fancy/cigarettes/derringer/AltClick(mob/living/carbon/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	var/obj/item/W = (locate(/obj/item/ammo_casing/a357) in contents) || (locate(/obj/item/clothing/mask/cigarette) in contents) //Easy access smokes and bullets
	if(W && contents.len > 0)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, W, user)
		user.put_in_hands(W)
		contents -= W
		to_chat(user, span_notice("You take \a [W] out of the pack."))
	else
		to_chat(user, span_notice("There are no items left in the pack."))

/obj/item/storage/fancy/cigarettes/derringer/PopulateContents()
	new spawn_type(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/ammo_casing/a357(src)
	new /obj/item/clothing/mask/cigarette/syndicate(src)

//For traitors with luck/class
/obj/item/storage/fancy/cigarettes/derringer/gold
	name = "\improper Robust Gold packet"
	desc = "Smoked by the truly robust."
	icon_state = "robustg"
	spawn_type = /obj/item/gun/ballistic/derringer/gold

/////////////
//CIGAR BOX//
/////////////

/obj/item/storage/fancy/cigarettes/cigars
	name = "\improper premium cigar case"
	desc = "A case of premium cigars. Very expensive."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigarcase"
	w_class = WEIGHT_CLASS_NORMAL
	base_icon_state = "cigarcase"
	spawn_type = /obj/item/clothing/mask/cigarette/cigar

/obj/item/storage/fancy/cigarettes/cigars/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.set_holdable(list(/obj/item/clothing/mask/cigarette/cigar))

/obj/item/storage/fancy/cigarettes/cigars/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][is_open ? "_open" : null]"

/obj/item/storage/fancy/cigarettes/cigars/update_overlays()
	. = ..()
	if(!is_open)
		return
	var/cigar_position = 1 //generate sprites for cigars in the box
	for(var/obj/item/clothing/mask/cigarette/cigar/smokes in contents)
		var/mutable_appearance/cigar_overlay = mutable_appearance(icon, "[smokes.icon_off]_[cigar_position]")
		. += cigar_overlay
		cigar_position++

/obj/item/storage/fancy/cigarettes/cigars/cohiba
	name = "\improper Cohiba Robusto cigar case"
	desc = "A case of imported Cohiba cigars, renowned for their strong flavor."
	icon_state = "cohibacase"
	base_icon_state = "cohibacase"
	spawn_type = /obj/item/clothing/mask/cigarette/cigar/cohiba

/obj/item/storage/fancy/cigarettes/cigars/havana
	name = "\improper premium Havanian cigar case"
	desc = "Even after centuries of Solarian export, Havana smooth is only found in proper terran cigars."
	icon_state = "cohibacase"
	base_icon_state = "cohibacase"
	spawn_type = /obj/item/clothing/mask/cigarette/cigar/havana

/*
 * Heart Shaped Box w/ Chocolates
 */

/obj/item/storage/fancy/heart_box
	name = "heart-shaped box"
	desc = "A heart-shaped box for holding tiny chocolates."
	icon = 'icons/obj/food/containers.dmi'
	item_state = "chocolatebox"
	icon_state = "chocolatebox"
	base_icon_state = "chocolatebox"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	spawn_type = /obj/item/food/bonbon
	contents_tag = "chocolate"

/obj/item/storage/fancy/heart_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 8
	STR.set_holdable(list(/obj/item/food/bonbon))

/obj/item/storage/fancy/nugget_box
	name = "nugget box"
	desc = "A cardboard box used for holding chicken nuggies."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "nuggetbox"
	base_icon_state = "nuggetbox"
	contents_tag = "nugget"
	spawn_type = /obj/item/food/nugget

/obj/item/storage/fancy/nugget_box/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.set_holdable(list(/obj/item/food/nugget))
