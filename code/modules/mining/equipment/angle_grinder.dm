/obj/item/gear_pack/anglegrinder
	name = "grinder pack"
	desc = "Supplies the high voltage needed to run the attached grinder."
	icon = 'icons/obj/item/gear_packs.dmi'
	item_state = "anglegrinderpack"
	icon_state = "anglegrinderpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	attachment_type = /obj/item/gear_handle/anglegrinder

/obj/item/gear_handle/anglegrinder
	name = "angle grinder"
	desc = "A powerful salvage tool used to cut apart walls and airlocks. A hazard sticker recommends ear and eye protection."
	icon = 'icons/obj/item/gear_packs.dmi'
	icon_state = "anglegrinder_off"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ABSTRACT
	attack_verb = list("sliced", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/anglegrinder.ogg'
	usesound = 'sound/weapons/anglegrinder.ogg'
	sharpness = IS_SHARP
	tool_behaviour = null // is set to TOOL_DECONSTRUCT once wielded
	toolspeed = 1
	usecost = 5
	pack = /obj/item/gear_pack/anglegrinder
	var/wielded = FALSE // track wielded status on item

/obj/item/gear_handle/anglegrinder/tool_start_check(mob/living/user, amount)
	if(!pack)
		to_chat(user, "<span class='warning'>how do you not have a pack for this. what.</span>")
		return FALSE
	if(!pack.cell)
		to_chat(user, "<span class='warning'>You need a cell to start!</span>")
		return FALSE
	var/obj/item/stock_parts/cell/cell = pack.get_cell()
	if(cell.charge < usecost)
		to_chat(user, "<span class='warning'>You need more charge to complete this task!</span>")
		return FALSE
	return TRUE

/obj/item/gear_handle/anglegrinder/tool_use_check(mob/living/user, amount)
	if(!pack.cell)
		return FALSE
	if(pack.deductcharge(usecost))
		return TRUE
	else
		to_chat(user, "<span class='warning'>You need more charge to complete this task!</span>")
		return FALSE

/obj/item/gear_handle/anglegrinder/use(used)
	return TRUE

/obj/item/gear_handle/anglegrinder/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/gear_handle/anglegrinder/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/anglegrinder.ogg', TRUE)
	AddComponent(/datum/component/two_handed)
	AddElement(/datum/element/tool_flash, 2)
	AddElement(/datum/element/tool_bang, 2)

/// triggered on wield of two handed item
/obj/item/gear_handle/anglegrinder/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	playsound(src, 'sound/weapons/chainsawhit.ogg', 100, TRUE)
	force = 24
	tool_behaviour = TOOL_DECONSTRUCT
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/gear_handle/anglegrinder/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	force = 13
	tool_behaviour = null
	wielded = FALSE

/obj/item/gear_handle/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()

/obj/item/gear_handle/anglegrinder/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	target.add_overlay(GLOB.cutting_effect)
	. = ..()
	target.cut_overlay(GLOB.cutting_effect)
