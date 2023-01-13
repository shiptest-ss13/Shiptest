/*
 * YES it's tweaked chainsaw code, do something about it.
*/

/*
 * ############## Places where TOOL_DECONSTRUCT is used ############
 *
 * code/game/turfs/closed/walls.dm
 * code/game/objects/structures/girders.dm
 * code/game/objects/structures/grille.dm
 * code/game/objects/structures/catwalk.dm
 * code/game/objects/structures/lattice.dm
*/
/obj/item/anglegrinder
	name = "angle grinder"
	desc = "A powerfull tool to salvage about anything. You better wear some protection tough"
	icon_state = "chainsaw_off"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	var/force_on = 24
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	slowdown = 1
	throwforce = 13
	throw_speed = 2
	throw_range = 4
	custom_materials = list(/datum/material/iron=13000)
	attack_verb = list("sliced", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/circsawhit.ogg'
	usesound = 'sound/weapons/circsawhit.ogg'
	sharpness = IS_SHARP
	actions_types = list(/datum/action/item_action/startchainsaw)
	tool_behaviour = TOOL_DECONSTRUCT
	toolspeed = 0.5 
	light_range = 2
	var/on = FALSE
	var/wielded = FALSE // track wielded status on item

// Trick to make the welder act always pass
/obj/item/anglegrinder/tool_use_check(mob/living/user, amount)
	to_chat(user, "he did the funny")
	return TRUE

/obj/item/anglegrinder/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/anglegrinder/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/circsawhit.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddElement(/datum/element/tool_flash, light_range)

/// triggered on wield of two handed item
/obj/item/anglegrinder/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/anglegrinder/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/anglegrinder/suicide_act(mob/living/carbon/user)
	if(on)
		user.visible_message("<span class='suicide'>[user] begins to tear [user.p_their()] head off with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/chainsawhit.ogg', 100, TRUE)
		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
		if(myhead)
			myhead.dismember()
	else
		user.visible_message("<span class='suicide'>[user] smashes [src] into [user.p_their()] neck, destroying [user.p_their()] esophagus! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/genhit1.ogg', 100, TRUE)
	return(BRUTELOSS)

/obj/item/anglegrinder/attack_self(mob/user)
	on = !on
	to_chat(user, "As you pull the starting cord dangling from [src], [on ? "it begins to whirr." : "the chain stops moving."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	// No active icon state yet
	// icon_state = "chainsaw_[on ? "on" : "off"]"
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = on

	if(on)
		hitsound = 'sound/weapons/circsawhit.ogg'
	else
		hitsound = "swing_hit"

	if(src == user.get_active_held_item()) //update inhands
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()
