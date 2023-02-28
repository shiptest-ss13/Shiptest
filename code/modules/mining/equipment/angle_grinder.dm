/*
 * YES it's tweaked chainsaw code, do something about it.
*/

/*
 * ############## Places where TOOL_DECONSTRUCT is used ############
 *
 * code/game/atoms.dm (for the definition of deconstruct_act(mob/living/user, /obj/item/I)
 *
 * code/game/objects/structures/salvaging.dm (waste planet salvagable machines)
 *
 * code/game/turfs/closed/walls.dm
 * code/game/objects/structures/girders.dm
 * code/game/objects/structures/grille.dm
 * code/game/objects/structures/catwalk.dm
 * code/game/objects/structures/lattice.dm
 * code/game/objects/structures/crates_lockers/closets.dm
 * code/game/objects/structures/tables_racks.dm (both normal and reinforced)
 * code/game/objects/structures/tables_frames.dm
 * code/game/objects/structures/window.dm (reinf window)
 * code/game/objects/structures/bed_chairs/bed.dm
 * code/game/objects/structures/bed_chairs/chair.dm
*/

/*
 * Configure features by editing __DEFINES/anglegrinder.dm
*/

/obj/item/anglegrinder
	name = "angle grinder"
	desc = "A powerfull tool to salvage about anything, you should wear earmuffs and welding protection to avoid damage to your ears and eyes."
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
	toolspeed = 0.25
	var/wielded = FALSE // track wielded status on item

// Trick to make the deconstruction that need a lit welder work. (bypassing fuel test)
/obj/item/anglegrinder/tool_use_check(mob/living/user, amount)
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

/obj/item/anglegrinder/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to tear [user.p_their()] head off with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/weapons/chainsawhit.ogg', 100, TRUE)
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(myhead)
		myhead.dismember()
	return(BRUTELOSS)

/obj/item/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()
