/obj/item/gear_pack/anglegrinder
	name = "grinder pack"
	desc = "Supplies the high voltage needed to run the attached grinder."
	icon = 'icons/obj/item/gear_packs.dmi'
	item_state = "anglegrinderpack"
	icon_state = "anglegrinderpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	gear_handle_type = /obj/item/gear_handle/anglegrinder
	slowdown = 0.3
	drag_slowdown = 0.3

/obj/item/gear_handle/anglegrinder
	name = "angle grinder"
	desc = "A powerful salvage tool used to cut apart walls and airlocks. A hazard sticker recommends ear and eye protection."
	icon = 'icons/obj/item/gear_packs.dmi'
	icon_state = "anglegrinder"
	item_state = "anglegrinder"
	lefthand_file = 'icons/mob/inhands/equipment/gear_handle_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/gear_handle_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	armour_penetration = 5
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ABSTRACT
	attack_verb = list("lacerated", "ripped", "sliced", "sawed", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/anglegrinder.ogg'
	usesound = 'sound/weapons/anglegrinder.ogg'
	tool_behaviour = null // is set to TOOL_DECONSTRUCT once wielded
	toolspeed = 1
	wall_decon_damage = 250
	usecost = 5
	pack = /obj/item/gear_pack/anglegrinder
	var/startsound = 'sound/weapons/chainsawhit.ogg'
	var/adv = FALSE
	var/wielded = FALSE // track wielded status on item
	var/two_hand_force = 24

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
	AddComponent(/datum/component/butchering, 30, 100, 0, startsound, TRUE)
	AddComponent(/datum/component/two_handed, force_unwielded=force, force_wielded=two_hand_force, wieldsound=startsound)
	AddElement(/datum/element/tool_bang, 1)

/// triggered on wield of two handed item
/obj/item/gear_handle/anglegrinder/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	tool_behaviour = TOOL_DECONSTRUCT
	wielded = TRUE
	sharpness = IS_SHARP
	icon_state = "[initial(item_state)]-wield"
	item_state = "[initial(item_state)]-wield"

/// triggered on unwield of two handed item
/obj/item/gear_handle/anglegrinder/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	tool_behaviour = null
	wielded = FALSE
	sharpness = initial(sharpness)
	icon_state = initial(icon_state)
	item_state = initial(item_state)

/obj/item/gear_handle/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()

/obj/item/gear_handle/anglegrinder/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	if(adv)
		target.add_overlay(GLOB.advanced_cutting_effect)
		. = ..()
		target.cut_overlay(GLOB.advanced_cutting_effect)
	else
		target.add_overlay(GLOB.cutting_effect)
		. = ..()
		target.cut_overlay(GLOB.cutting_effect)

/obj/item/gear_pack/anglegrinder/energy
	name = "energy supply pack"
	desc = "a highly inefficient GEC-E-014 Supply Pack, used to generate and contain an energy field."
	item_state = "energyanglegrinderpack"
	icon_state = "energyanglegrinderpack"
	gear_handle_type = /obj/item/gear_handle/anglegrinder/energy

/obj/item/gear_handle/anglegrinder/energy
	name = "energy saw"
	desc = "An early prototype for handheld energy weapons, designed by a joint GEC-Cybersun lab to create an energy field for combat use."
	icon_state = "energyanglegrinder"
	item_state = "energyanglegrinder"
	force = 5
	two_hand_force = 28
	armour_penetration = 16
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ABSTRACT
	attack_verb = list("lacerated", "ripped", "burned", "sliced", "cauterized", "seared", "diced")
	hitsound = 'sound/weapons/blade1.ogg'
	usesound = 'sound/weapons/blade1.ogg'
	startsound = 'sound/weapons/saberon.ogg'
	toolspeed = 0.7
	usecost = 10
	pack = /obj/item/gear_pack/anglegrinder/energy
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	light_on = FALSE
	adv = TRUE

/obj/item/gear_handle/anglegrinder/energy/on_wield(obj/item/source, mob/user)
	. = ..()
	set_light_on(TRUE)

/obj/item/gear_handle/anglegrinder/energy/on_unwield(obj/item/source, mob/user)
	. = ..()
	set_light_on(FALSE)

