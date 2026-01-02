/obj/item/clothing/neck
	name = "necklace"
	icon = 'icons/obj/clothing/neck.dmi'
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	strip_delay = 40
	equip_delay_other = 40
	cuttable = TRUE
	clothamnt = 1
	greyscale_colors = list(list(15, 20), list(16, 21), list(14, 19))
	greyscale_icon_state = "scarf"

/obj/item/clothing/neck/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		if(body_parts_covered & HEAD)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")
			if(HAS_BLOOD_DNA(src))
				. += mutable_appearance('icons/effects/blood.dmi', "maskblood")

/obj/item/clothing/neck/tie
	name = "tie"
	desc = "A neosilk clip-on tie. Special material allows it to be reskinned, but only once."
	unique_reskin = list(
		"red tie" = "redtie",
		"orange tie" = "orangetie",
		"green tie" = "greentie",
		"light blue tie" = "lightbluetie",
		"blue tie" = "bluetie",
		"purple tie" = "purpletie",
		"black tie" = "blacktie",
		"orange tie" = "orangetie",
		"light blue tie" = "lightbluetie",
		"purple tie" = "purpletie",
		"green tie" = "greentie",
		"brown tie" = "browntie",
		"rainbow tie" = "rainbow_tie",
		"horrible tie" = "horribletie",
		"transgender tie" = "transgender",
		"pansexual tie" = "pansexual",
		"nonbinary tie" = "nonbinary",
		"bisexual tie" = "bisexual",
		"lesbian tie" = "lesbian",
		"intersex tie" = "intersex",
		"gay tie" = "gay",
		"genderfluid tie" = "genderfluid",
		"asexual tie" = "asexual",
		"genderfae tie" = "genderfae",
		"ally tie" = "ally_tie"
	)
	unique_reskin_changes_name = TRUE
	icon_state = "rainbow_tie"
	item_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = 60
	greyscale_colors = list(list(16, 20), list(16, 16), list(16, 18))
	greyscale_icon_state = "tie"

/obj/item/clothing/neck/tie/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/neck/tie/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/neck/tie/black
	name = "black tie"
	icon_state = "blacktie"
//
/obj/item/clothing/neck/tie/orange
	name = "orange tie"
	icon_state = "orangetie"

/obj/item/clothing/neck/tie/light_blue
	name = "light blue tie"
	icon_state = "lightbluetie"

/obj/item/clothing/neck/tie/purple
	name = "purple tie"
	icon_state = "purpletie"

/obj/item/clothing/neck/tie/green
	name = "green tie"
	icon_state = "greentie"

/obj/item/clothing/neck/tie/brown
	name = "brown tie"
	icon_state = "browntie"
//
/obj/item/clothing/neck/tie/rainbow
	name = "rainbow tie"
	icon_state = "rainbow_tie"

/obj/item/clothing/neck/tie/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"

/obj/item/clothing/neck/tie/detective
	name = "loose tie"
	desc = "A loosely tied necktie, a perfect accessory for the over-worked detective."
	icon_state = "detective"
	unique_reskin = null

/obj/item/clothing/neck/maid
	name = "maid neck cover"
	desc = "A neckpiece for a maid costume, it smells faintly of disappointment."
	icon_state = "maid_neck"
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/tie/trans
	name = "transgender tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the trans flag."
	icon_state = "transgender"

/obj/item/clothing/neck/tie/pan
	name = "pansexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the pansexual flag."
	icon_state = "pansexual"

/obj/item/clothing/neck/tie/enby
	name = "nonbinary tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the nonbinary flag."
	icon_state = "nonbinary"

/obj/item/clothing/neck/tie/bi
	name = "bisexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the bisexual flag."
	icon_state = "bisexual"

/obj/item/clothing/neck/tie/lesbian
	name = "lesbian tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the lesbian flag."
	icon_state = "lesbian"

/obj/item/clothing/neck/tie/intersex
	name = "intersex tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the intersex flag."
	icon_state = "intersex"

/obj/item/clothing/neck/tie/gay
	name = "gay tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the gay flag."
	icon_state = "gay"

/obj/item/clothing/neck/tie/genderfluid
	name = "genderfluid tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the genderfluid flag."
	icon_state = "genderfluid"

/obj/item/clothing/neck/tie/asexual
	name = "asexual tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the asexual flag."
	icon_state = "asexual"

/obj/item/clothing/neck/tie/genderfae
	name = "genderfae tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the genderfae flag."
	icon_state = "genderfae"

/obj/item/clothing/neck/tie/ally_tie
	name = "ally tie"
	desc = "A neosilk clip-on tie. This one is in the colors of the ally flag."
	icon_state = "ally_tie"

/obj/item/clothing/neck/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"
	cuttable = FALSE
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == INTENT_HELP)
			var/body_part = parse_zone(user.zone_selected)

			var/heart_strength = span_danger("no")
			var/lung_strength = span_danger("no")

			var/obj/item/organ/heart/heart = M.getorganslot(ORGAN_SLOT_HEART)
			var/obj/item/organ/lungs/lungs = M.getorganslot(ORGAN_SLOT_LUNGS)

			if(!(M.stat == DEAD || (HAS_TRAIT(M, TRAIT_FAKEDEATH))))
				if(heart && istype(heart))
					heart_strength = span_danger("an unstable")
					if(heart.beating)
						heart_strength = "a healthy"
				if(lungs && istype(lungs))
					lung_strength = span_danger("strained")
					if(!(M.failed_last_breath || M.losebreath))
						lung_strength = "healthy"

			var/diagnosis = (body_part == BODY_ZONE_CHEST ? "You hear [heart_strength] pulse and [lung_strength] respiration." : "You faintly hear [heart_strength] pulse.")
			user.visible_message(span_notice("[user] places [src] against [M]'s [body_part] and listens attentively."), span_notice("You place [src] against [M]'s [body_part]. [diagnosis]"))
			return
	return ..(M,user)

///////////
//SCARVES//
///////////

/obj/item/clothing/neck/scarf
	name = "scarf"
	desc = "A stylish scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	icon = 'icons/obj/clothing/neck/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/neck/color.dmi'
	icon_state = "scarfwhite"
	item_state = "scarfwhite"
	custom_price = 60
	unique_reskin = list("white scarf" = "scarfwhite",
						"grey scarf" = "scarfgrey",
						"black scarf" = "scarfblack",
						"red scarf" = "scarfred",
						"maroon scarf" = "scarfmaroon",
						"orange scarf" = "scarforange",
						"yellow scarf" = "scarfyellow",
						"green scarf" = "scarfgreen",
						"dark green scarf" = "scarfdarkgreen",
						"teal scarf" = "scarfteal",
						"blue scarf" = "scarfblue",
						"dark blue scarf" = "scarfdarkblue",
						"purple scarf" = "scarfpurple",
						"pink scarf" = "scarfpink",
						"brown scarf" = "scarfbrown",
						"light brown scarf" = "scarflightbrown"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

/obj/item/clothing/neck/scarf/white
	name = "white scarf"
	icon_state = "scarfwhite"
	current_skin = "white scarf"

/obj/item/clothing/neck/scarf/grey
	name = "grey scarf"
	icon_state = "scarfgrey"
	current_skin = "grey scarf"

/obj/item/clothing/neck/scarf/black
	name = "black scarf"
	icon_state = "scarfblack"
	current_skin = "black scarf"

/obj/item/clothing/neck/scarf/red
	name = "red scarf"
	icon_state = "scarfred"
	current_skin = "red scarf"

/obj/item/clothing/neck/scarf/maroon
	name = "maroon scarf"
	icon_state = "scarfmaroon"
	current_skin = "maroon scarf"

/obj/item/clothing/neck/scarf/orange
	name = "orange scarf"
	icon_state = "scarforange"
	current_skin = "orange scarf"

/obj/item/clothing/neck/scarf/yellow
	name = "yellow scarf"
	icon_state = "scarfyellow"
	current_skin = "yellow scarf"

/obj/item/clothing/neck/scarf/green
	name = "green scarf"
	icon_state = "scarfgreen"
	current_skin = "green scarf"

/obj/item/clothing/neck/scarf/darkgreen
	name = "dark green scarf"
	icon_state = "scarfdarkgreen"
	current_skin = "dark green scarf"

/obj/item/clothing/neck/scarf/teal
	name = "teal scarf"
	icon_state = "scarfteal"
	current_skin = "teal scarf"

/obj/item/clothing/neck/scarf/blue
	name = "blue scarf"
	icon_state = "scarfblue"
	current_skin = "blue scarf"

/obj/item/clothing/neck/scarf/darkblue
	name = "dark blue scarf"
	icon_state = "scarfdarkblue"
	current_skin = "dark blue scarf"

/obj/item/clothing/neck/scarf/purple
	name = "purple scarf"
	icon_state = "scarfpurple"
	current_skin = "purple scarf"

/obj/item/clothing/neck/scarf/pink
	name = "scarf"
	icon_state = "scarfpink"
	current_skin = "pink scarf"

/obj/item/clothing/neck/scarf/brown
	name = "brown scarf"
	icon_state = "scarfbrown"
	current_skin = "brown scarf"

/obj/item/clothing/neck/scarf/lightbrown
	name = "light brown scarf"
	icon_state = "scarflightbrown"
	current_skin = "light brown scarf"

//Ponchos. Duh

/obj/item/clothing/neck/poncho
	name = "poncho"
	desc = "Perfect for a rainy night with jazz."
	icon = 'icons/obj/clothing/neck/poncho.dmi'
	mob_overlay_icon = 'icons/mob/clothing/neck/poncho.dmi'
	icon_state = "ponchowhite"
	item_state = "ponchowhite"
	body_parts_covered = CHEST
	custom_price = 60
	unique_reskin = list("white poncho" = "ponchowhite",
						"grey poncho" = "ponchogrey",
						"black poncho" = "ponchoblack",
						"red poncho" = "ponchored",
						"maroon poncho" = "ponchomaroon",
						"orange poncho" = "ponchoorange",
						"yellow poncho" = "ponchoyellow",
						"green poncho" = "ponchogreen",
						"dark green poncho" = "ponchodarkgreen",
						"teal poncho" = "ponchoteal",
						"blue poncho" = "ponchoblue",
						"dark blue poncho" = "ponchodarkblue",
						"purple poncho" = "ponchopurple",
						"pink poncho" = "ponchopink",
						"brown poncho" = "ponchobrown",
						"light brown poncho" = "poncholightbrown"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE
	actions_types = list(/datum/action/item_action/toggle_hood)
	var/ponchotoggled = FALSE
	var/obj/item/clothing/head/hooded/hood
	var/hoodtype = /obj/item/clothing/head/hooded/poncho

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC

/obj/item/clothing/neck/poncho/Initialize()
	. = ..()
	if(!base_icon_state)
		base_icon_state = icon_state
	make_hood()

/obj/item/clothing/neck/poncho/Destroy()
	. = ..()
	qdel(hood)
	hood = null

/obj/item/clothing/neck/poncho/reskin_obj(mob/M, change_name)
	. = ..()
	if(hood)
		hood.icon_state = base_icon_state
	return

/obj/item/clothing/neck/poncho/proc/make_hood()
	if(!hood)
		var/obj/item/clothing/head/hooded/W = new hoodtype(src)
		W.suit = src
		hood = W

/obj/item/clothing/neck/poncho/ui_action_click()
	toggle_hood()

/obj/item/clothing/neck/poncho/item_action_slot_check(slot, mob/user)
	if(slot == ITEM_SLOT_NECK)
		return 1

/obj/item/clothing/neck/poncho/equipped(mob/user, slot)
	if(slot != ITEM_SLOT_NECK)
		remove_hood()
	..()

/obj/item/clothing/neck/poncho/proc/remove_hood()
	ponchotoggled = FALSE
	if(hood)
		if(ishuman(hood.loc))
			var/mob/living/carbon/H = hood.loc
			H.transferItemToLoc(hood, src, TRUE)
			H.update_inv_neck()
			update_appearance()
			H.regenerate_icons()
		else
			hood.forceMove(src)
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()

/obj/item/clothing/neck/poncho/update_appearance(updates)
	if(ponchotoggled)
		icon_state = "[base_icon_state]_t"
	else
		icon_state = base_icon_state
	if(isobj(hood))
		hood.icon_state = base_icon_state
	. = ..()

/obj/item/clothing/neck/poncho/dropped()
	..()
	remove_hood()

/obj/item/clothing/neck/poncho/proc/toggle_hood()
	if(!ponchotoggled)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.wear_neck != src)
				to_chat(H, span_warning("You must be wearing [src] to put up the hood!"))
				return
			if(H.head)
				to_chat(H, span_warning("You're already wearing something on your head!"))
				return
			else if(H.equip_to_slot_if_possible(hood,ITEM_SLOT_HEAD,0,0,1))
				ponchotoggled = TRUE
				H.update_inv_neck()
				update_appearance()
				H.regenerate_icons()
				for(var/X in actions)
					var/datum/action/A = X
					A.UpdateButtonIcon()
	else
		remove_hood()

/obj/item/clothing/head/hooded/poncho
	name = "poncho"
	desc = "Perfect for a rainy night with jazz."
	icon = 'icons/obj/clothing/head/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/color.dmi'
	icon_state = "ponchowhite"
	item_state = "ponchowhite"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/neck/poncho/white
	name = "white poncho"
	icon_state = "ponchowhite"
	current_skin = "white poncho"

/obj/item/clothing/neck/poncho/grey
	name = "grey poncho"
	icon_state = "ponchogrey"
	current_skin = "grey poncho"

/obj/item/clothing/neck/poncho/black
	name = "black poncho"
	icon_state = "ponchoblack"
	current_skin = "black poncho"

/obj/item/clothing/neck/poncho/red
	name = "red poncho"
	icon_state = "ponchored"
	current_skin = "red poncho"

/obj/item/clothing/neck/poncho/maroon
	name = "maroon poncho"
	icon_state = "ponchomaroon"
	current_skin = "maroon poncho"

/obj/item/clothing/neck/poncho/orange
	name = "orange poncho"
	icon_state = "ponchoorange"
	current_skin = "orange poncho"

/obj/item/clothing/neck/poncho/yellow
	name = "yellow poncho"
	icon_state = "ponchoyellow"
	current_skin = "yellow poncho"

/obj/item/clothing/neck/poncho/green
	name = "green poncho"
	icon_state = "ponchogreen"
	current_skin = "green poncho"

/obj/item/clothing/neck/poncho/darkgreen
	name = "dark green poncho"
	icon_state = "ponchowhite"
	current_skin = "dark green poncho"

/obj/item/clothing/neck/poncho/teal
	name = "teal poncho"
	icon_state = "ponchoteal"
	current_skin = "teal poncho"

/obj/item/clothing/neck/poncho/blue
	name = "blue poncho"
	icon_state = "ponchoblue"
	current_skin = "blue poncho"

/obj/item/clothing/neck/poncho/darkblue
	name = "dark blue poncho"
	icon_state = "ponchodarkblue"
	current_skin = "dark blue poncho"

/obj/item/clothing/neck/poncho/purple
	name = "purple poncho"
	icon_state = "ponchopurple"
	current_skin = "purple poncho"

/obj/item/clothing/neck/poncho/pink
	name = "pink poncho"
	icon_state = "ponchopink"
	current_skin = "pink poncho"

/obj/item/clothing/neck/poncho/brown
	name = "brown poncho"
	icon_state = "ponchobrown"
	current_skin = "brown poncho"

/obj/item/clothing/neck/poncho/lightbrown
	name = "light brown poncho"
	icon_state = "poncholightbrown"
	current_skin = "light brown poncho"

//Shemaghs to operate tactically in a operational tactical situation

/obj/item/clothing/neck/shemagh
	name = "shemagh"
	desc = "An oversized shemagh, for those with a keen sense of fashion, or those operating tactically."
	icon_state = "shemagh"
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/shemagh/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if((C.get_item_by_slot(ITEM_SLOT_NECK) == src))
			to_chat(user, span_warning("You can't tie [src] while wearing it!"))
			return
		if(user.is_holding(src))
			var/obj/item/clothing/mask/shemagh/nk = new(src)
			nk.name = "[name] mask"
			nk.icon_state = "[icon_state]_over"
			nk.source_shemagh_type = src.type
			var/current_hand_index = user.get_held_index_of_item(src)
			user.transferItemToLoc(src, null)
			user.put_in_hand(nk, current_hand_index)
			user.visible_message(span_notice("You tie [src] up like a facemask."), span_notice("[user] ties [src] up like a facemask."))
			qdel(src)
		else
			to_chat(user, span_warning("You must be holding [src] in order to tie it!"))

/obj/item/clothing/mask/shemagh
	icon = 'icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/neck.dmi'
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = ALLOWINTERNALS
	flags_cover = MASKCOVERSMOUTH
	alternate_worn_layer = FACEWRAP_LAYER
	w_class = WEIGHT_CLASS_TINY
	var/source_shemagh_type

/obj/item/clothing/mask/shemagh/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.get_item_by_slot(ITEM_SLOT_MASK) == src)
			to_chat(user, span_warning("You can't untie [src] while wearing it!"))
			return
		if(user.is_holding(src))
			var/obj/item/clothing/neck/shemagh/new_shemagh = new source_shemagh_type(user)
			var/current_hand_index = user.get_held_index_of_item(src)
			var/old_name = src.name
			qdel(src)
			user.put_in_hand(new_shemagh, current_hand_index)
			user.visible_message(span_notice("You untie [old_name] back into a [new_shemagh.name]."), span_notice("[user] unties [old_name] back into a [new_shemagh.name]."))
		else
			to_chat(user, span_warning("You must be holding [src] in order to untie it!"))

/obj/item/clothing/neck/shemagh/khaki
	icon_state = "shemagh_khaki"

/obj/item/clothing/neck/shemagh/olive
	icon_state = "shemagh_olive"

/obj/item/clothing/neck/shemagh/brown
	icon_state = "shemagh_brown"

/obj/item/clothing/neck/shemagh/black
	icon_state = "shemagh_black"

// neck wraps

/obj/item/clothing/neck/neckwraps
	name = "neckwraps"
	desc = "A fashionable piece of cloth cover your neck."
	icon_state = "neckwraps"
	item_state = "neckwraps"
	unique_reskin = list("grey neckwraps" = "neckwraps",
						"black neckwraps" = "neckwraps_black",
						"brown neckwraps" = "neckwraps_brown",
						"tan neckwraps" = "neckwraps_tan",
						"olive neckwraps" = "neckwraps_olive",
						"red neckwraps" = "neckwraps_red",
						"blue neckwraps" = "neckwraps_blue"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

/obj/item/clothing/neck/neckwraps/grey
	name = "grey neckwraps"
	icon_state = "neckwraps"
	current_skin = "grey neckwraps"

/obj/item/clothing/neck/neckwraps/black
	name = "black neckwraps"
	icon_state = "neckwraps_black"
	current_skin = "black neckwraps"

/obj/item/clothing/neck/neckwraps/brown
	name = "brown neckwraps"
	icon_state = "neckwraps_brown"
	current_skin = "brown neckwraps"

/obj/item/clothing/neck/neckwraps/tan
	name = "tan neckwraps"
	icon_state = "neckwraps_tan"
	current_skin = "tan neckwraps"

/obj/item/clothing/neck/neckwraps/olive
	name = "olive neckwraps"
	icon_state = "neckwraps_olive"
	current_skin = "olive neckwraps"

/obj/item/clothing/neck/neckwraps/red
	name = "red neckwraps"
	icon_state = "neckwraps_red"
	current_skin = "red neckwraps"

/obj/item/clothing/neck/neckwraps/blue
	name = "blue neckwraps"
	icon_state = "neckwraps_blue"
	current_skin = "blue neckwraps"

//The three following scarves don't have the scarf subtype
//This is because Ian can equip anything from that subtype
//However, these 4 don't have corgi versions of their sprites
/obj/item/clothing/neck/stripedredscarf
	name = "striped red scarf"
	icon_state = "stripedredscarf"
	custom_price = 10
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/stripedgreenscarf
	name = "striped green scarf"
	icon_state = "stripedgreenscarf"
	custom_price = 10
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/stripedbluescarf
	name = "striped blue scarf"
	icon_state = "stripedbluescarf"
	custom_price = 10
	supports_variations = VOX_VARIATION

/obj/item/clothing/neck/petcollar
	name = "pet collar"
	desc = "It's for pets. But some people wear it anyways for reasons unknown."
	icon_state = "petcollar"
	greyscale_colors = list(list(16,21), list(16,19), list(16,19))
	greyscale_icon_state = "collar"
	var/tagname = null


/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/dogtag
	name = "dogtag"
	desc = "A nondescript dogtag."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "dogtag"
	resistance_flags = FIRE_PROOF
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_NECK | ITEM_SLOT_POCKETS
	strip_delay = 10
	var/list/tag_fluff = list()

/obj/item/clothing/neck/dogtag/examine_more(mob/user)
	. = ..()
	for(var/line in tag_fluff)
		. += span_boldnotice(line)

/obj/item/clothing/neck/dogtag/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/pen))
		if(length(tag_fluff) >= 5)
			to_chat(user, span_warning("[src] has no more space!"))
			return
		var/tagfluff = stripped_input(user, "Add to this dogtag.", "Plaque Customization", max_length=60)
		if(!tagfluff)
			return
		tag_fluff = tagfluff
		to_chat(user, span_notice("You add to the information on [src]!"))
		return

/obj/item/clothing/neck/dogtag/loadout
	desc = "A non-military dogtag, often worn for style in certain circles."

/obj/item/clothing/neck/dogtag/gold
	icon_state = "dogtag_gold"
	desc = "The characters are engraved with gold."

/obj/item/clothing/neck/dogtag/frontier
	name = "frontiersman dogtag"
	desc = "A dogtag marked with the name and rank of a Frontiersmen pirate. You could turn this in to an outpost console contract for money."

/obj/item/clothing/neck/dogtag/ramzi
	name = "ramzi clique dogtag"
	desc = "A dogtag marked with the name and rank of a Ramzi Clique pirate. You could turn this in to an outpost console contract for money."

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/neck/necklace/dope
	name = "gold necklace"
	desc = "Damn, it feels good to be a gangster."
	icon_state = "bling"
	cuttable = FALSE

/obj/item/clothing/neck/neckerchief
	icon = 'icons/obj/clothing/masks.dmi' //In order to reuse the bandana sprite
	w_class = WEIGHT_CLASS_TINY
	var/sourceBandanaType

/obj/item/clothing/neck/neckerchief/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/realOverlay = mutable_appearance('icons/mob/clothing/mask.dmi', icon_state)
		realOverlay.pixel_y = -3
		. += realOverlay

/obj/item/clothing/neck/neckerchief/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.get_item_by_slot(ITEM_SLOT_NECK) == src)
			to_chat(user, span_warning("You can't untie [src] while wearing it!"))
			return
		if(user.is_holding(src))
			var/obj/item/clothing/mask/bandana/newBand = new sourceBandanaType(user)
			var/currentHandIndex = user.get_held_index_of_item(src)
			var/oldName = src.name
			qdel(src)
			user.put_in_hand(newBand, currentHandIndex)
			user.visible_message(span_notice("You untie [oldName] back into a [newBand.name]."), span_notice("[user] unties [oldName] back into a [newBand.name]."))
		else
			to_chat(user, span_warning("You must be holding [src] in order to untie it!"))

/obj/item/clothing/neck/beads
	name = "plastic bead necklace"
	desc = "A cheap, plastic bead necklace. Show team spirit! Collect them! Throw them away! The posibilites are endless!"
	icon_state = "beads"
	color = "#ffffff"
	custom_price = 10
	custom_materials = (list(/datum/material/plastic = 500))
	cuttable = FALSE

/obj/item/clothing/neck/beads/Initialize()
	. = ..()
	color = color = pick("#ff0077","#d400ff","#2600ff","#00ccff","#00ff2a","#e5ff00","#ffae00","#ff0000", "#ffffff")

/obj/item/clothing/neck/crystal_amulet
	name = "crystal amulet"
	desc = "A mysterious amulet which protects the user from hits, at the cost of itself."
	icon_state = "crystal_talisman"
	cuttable = FALSE
	var/shield_state = "shieldsparkles"
	var/shield_on = "shieldsparkles"
	var/damage_to_take_on_hit = 40 //every time the owner is hit, how much damage to give to the amulet?


//This is copied and pasted from the shield harsuit code, any issues here are also a issue there. Should I have done this? No, i shouldn't. Should this be a component? Yes, most likely. Do i want to touch DCS ever again? No.

/obj/item/clothing/neck/crystal_amulet/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/datum/effect_system/spark_spread/quantum/spark_creator = new
	spark_creator.set_up(2, 1, src)
	spark_creator.start()
	owner.visible_message(span_danger("[owner]'s shields deflect [attack_text] in a shower of sparks!"))
	take_damage(damage_to_take_on_hit)
	playsound(src, 'sound/effects/hit_on_shattered_glass.ogg', 70, TRUE)
	return TRUE

/obj/item/clothing/neck/crystal_amulet/examine(mob/user)
	. = ..()
	var/healthpercent = (atom_integrity/max_integrity) * 100
	switch(healthpercent)
		if(50 to 99)
			. += "It looks slightly damaged."
		if(25 to 50)
			. += "It appears heavily damaged."
		if(0 to 25)
			. += span_warning("It's falling apart!")

/obj/item/clothing/neck/crystal_amulet/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_state, MOB_LAYER + 0.01)

/obj/item/clothing/neck/crystal_amulet/atom_destruction(damage_flag)
	visible_message(span_danger("[src] shatters into a million pieces!"))
	playsound(src,"shatter", 70)
	new /obj/effect/decal/cleanable/glass/strange(get_turf(src))
	return ..()

/obj/item/clothing/neck/fangnecklace
	name = "wolf fang necklace"
	desc = "A necklace made out of a wolf's fang and some sinew. According to a common Frontier superstition, it brings good luck to its wearer."
	icon_state = "fang_necklace"
	cuttable = FALSE
