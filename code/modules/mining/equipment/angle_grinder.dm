/*
 * Configure features by editing __DEFINES/anglegrinder.dm
*/

/obj/item/anglegrinder
	name = "angle grinder"
	desc = "A powerful salvage tool used to cut apart walls and airlocks. A peeling hazard sticker recommends ear and eye protection."
	icon = 'icons/obj/mining.dmi'
	icon_state = "anglegrinder_off"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	slowdown = 1
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	custom_materials = list(/datum/material/iron=13000)
	attack_verb = list("sliced", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/anglegrinder.ogg'
	usesound = 'sound/weapons/anglegrinder.ogg'
	sharpness = IS_SHARP
	tool_behaviour = null // is set to TOOL_DECONSTRUCT once weildedk
	toolspeed = 1
	var/wielded = FALSE // track wielded status on item

// Trick to make the deconstruction that need a lit welder work. (bypassing fuel test)
/obj/item/anglegrinder/tool_use_check(mob/living/user, amount)
	return TRUE

/obj/item/anglegrinder/use(used)
	return TRUE

/obj/item/anglegrinder/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/anglegrinder/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/anglegrinder.ogg', TRUE)
	AddComponent(/datum/component/two_handed)
	AddElement(/datum/element/tool_flash, 2)
	AddElement(/datum/element/tool_bang, 2)

/// triggered on wield of two handed item
/obj/item/anglegrinder/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	playsound(src, 'sound/weapons/chainsawhit.ogg', 100, TRUE)
	force = 24
	tool_behaviour = TOOL_DECONSTRUCT
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/anglegrinder/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER
	force = 13
	tool_behaviour = null
	wielded = FALSE

/obj/item/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()

/obj/item/anglegrinder/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	target.add_overlay(GLOB.cutting_effect)
	. = ..()
	target.cut_overlay(GLOB.cutting_effect)
