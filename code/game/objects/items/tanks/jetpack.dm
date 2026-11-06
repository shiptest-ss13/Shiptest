/obj/item/tank/jetpack
	name = "jetpack (empty)"
	desc = "A tank of compressed gas for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack"
	item_state = "jetpack"
	lefthand_file = 'icons/mob/inhands/equipment/jetpacks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/jetpacks_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	distribute_pressure = ONE_ATMOSPHERE * O2STANDARD
	actions_types = list(/datum/action/item_action/set_internals, /datum/action/item_action/toggle_jetpack, /datum/action/item_action/jetpack_stabilization)
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	var/gas_type = GAS_O2
	var/on = FALSE
	var/full_speed = TRUE // Whether damage slowdown will affect the jetpack
	var/stabilize = FALSE
	var/thrust_callback

/obj/item/tank/jetpack/Initialize(mapload)
	. = ..()
	thrust_callback = CALLBACK(src, PROC_REF(allow_thrust), 0.01)
	configure_jetpack(stabilize)

/obj/item/tank/jetpack/Destroy()
	thrust_callback = null
	return ..()

/**
 * configures/re-configures the jetpack component
 *
 * Arguments
 * stabilize - Should this jetpack be stabalized
 */
/obj/item/tank/jetpack/proc/configure_jetpack(stabilize)
	src.stabilize = stabilize

	AddComponent( \
		/datum/component/jetpack, \
		src.stabilize, \
		COMSIG_JETPACK_ACTIVATED, \
		COMSIG_JETPACK_DEACTIVATED, \
		JETPACK_ACTIVATION_FAILED, \
		thrust_callback, \
		/datum/effect_system/trail_follow/ion \
	)

/obj/item/tank/jetpack/populate_gas()
	if(gas_type)
		air_contents.set_moles(gas_type, ((6 * ONE_ATMOSPHERE) * volume / (R_IDEAL_GAS_EQUATION * T20C)))

/obj/item/tank/jetpack/ui_action_click(mob/living/user, action)
	if(istype(action, /datum/action/item_action/toggle_jetpack))
		cycle(user)
	else if(istype(action, /datum/action/item_action/jetpack_stabilization))
		if(on)
			toggle_stabilization()
	else
		toggle_internals(user)


/obj/item/tank/jetpack/proc/toggle_stabilization(mob/user)
	if(on)
		configure_jetpack(!stabilize)
		to_chat(user, span_notice("You turn [src]'s stabilization [stabilize ? "on" : "off"]"))

/obj/item/tank/jetpack/proc/cycle(mob/living/user)
	if(user.incapacitated())
		return

	if(!on)
		turn_on(user)
		to_chat(user, span_notice("You turn the jetpack on."))
	else
		turn_off(user)
		to_chat(user, span_notice("You turn the jetpack off."))
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/tank/jetpack/proc/turn_on(mob/living/user)
	if(SEND_SIGNAL(src, COMSIG_JETPACK_ACTIVATED, user) & JETPACK_ACTIVATION_FAILED)
		return FALSE

	on = TRUE
	icon_state = "[initial(icon_state)]-on"
	if(full_speed)
		user.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown_flying)

/obj/item/tank/jetpack/proc/turn_off(mob/living/user)
	on = FALSE
	SEND_SIGNAL(src, COMSIG_JETPACK_DEACTIVATED, user)
	icon_state = initial(icon_state)
	user.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown_flying)

/obj/item/tank/jetpack/dropped(mob/user, silent)
	. = ..()
	if(on)
		turn_off(user)

/obj/item/tank/jetpack/proc/allow_thrust(num)
	if(!ismob(loc))
		return FALSE
	var/mob/user = loc
	if((num < 0.005 || air_contents.total_moles() < num))
		turn_off(user)
		return

	assume_air_moles(air_contents, num)

	return TRUE

/obj/item/tank/jetpack/improvised
	name = "improvised jetpack"
	desc = "A jetpack made from two air tanks, a fire extinguisher and some atmospherics equipment. It doesn't look like it can hold much."
	icon_state = "jetpack-improvised"
	item_state = "jetpack-sec"
	volume = 20 //normal jetpacks have 70 volume
	gas_type = null //it starts empty
	full_speed = FALSE // affected by damage slowdown

/obj/item/tank/jetpack/improvised/allow_thrust(num, mob/living/user)
	if(rand(0,250) == 0)
		to_chat(user, span_notice("You feel your jetpack's engines cut out."))
		turn_off(user)
		return
	..()

	assume_air_moles(air_contents, num)

	return TRUE

/obj/item/tank/jetpack/void
	name = "void jetpack (oxygen)"
	desc = "It works well in a void."
	icon_state = "jetpack-void"
	item_state =  "jetpack-void"

/obj/item/tank/jetpack/oxygen
	name = "jetpack (oxygen)"
	desc = "A tank of compressed oxygen for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack"
	item_state = "jetpack"

/obj/item/tank/jetpack/oxygen/harness
	name = "jet harness (oxygen)"
	desc = "A lightweight tactical harness, used by those who don't want to be weighed down by traditional jetpacks."
	icon_state = "jetpack-mini"
	item_state = "jetpack-mini"
	volume = 40
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

/obj/item/tank/jetpack/oxygen/captain
	name = "captain's jetpack"
	desc = "A compact, lightweight jetpack containing a high amount of compressed oxygen."
	icon_state = "jetpack-captain"
	item_state = "jetpack-captain"
	w_class = WEIGHT_CLASS_NORMAL
	volume = 90
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF //steal objective items are hard to destroy.

/obj/item/tank/jetpack/oxygen/security
	name = "security jetpack (oxygen)"
	desc = "A tank of compressed oxygen for use as propulsion in zero-gravity areas by security forces."
	icon_state = "jetpack-sec"
	item_state = "jetpack-sec"

/obj/item/tank/jetpack/carbondioxide
	name = "jetpack (carbon dioxide)"
	desc = "A tank of compressed carbon dioxide for use as propulsion in zero-gravity areas. Painted black to indicate that it should not be used as a source for internals."
	icon_state = "jetpack-black"
	item_state =  "jetpack-black"
	distribute_pressure = 0
	gas_type = GAS_CO2

/obj/item/tank/jetpack/suit
	name = "hardsuit jetpack upgrade"
	desc = "A modular, compact set of thrusters designed to integrate with a hardsuit. It draws propellant from an external air tank."
	icon = 'icons/obj/items.dmi'
	icon_state = "jetpack_upgrade"
	item_state = "jetpack-black"
	w_class = WEIGHT_CLASS_NORMAL
	actions_types = list(/datum/action/item_action/toggle_jetpack, /datum/action/item_action/jetpack_stabilization)
	volume = 1
	slot_flags = null
	gas_type = null
	custom_price = 2000
	var/datum/gas_mixture/temp_air_contents
	var/obj/item/tank/internals/tank = null
	var/mob/living/carbon/human/cur_user

/obj/item/tank/jetpack/suit/Initialize()
	. = ..()
	STOP_PROCESSING(SSobj, src)
	temp_air_contents = air_contents

/obj/item/tank/jetpack/suit/attack_self()
	return

/obj/item/tank/jetpack/suit/cycle(mob/user)
	if(!istype(loc, /obj/item/clothing/suit/space/hardsuit))
		to_chat(user, span_warning("\The [src] must be connected to a hardsuit!"))
		return

	var/mob/living/carbon/human/H = user
	if((!istype(H.s_store, /obj/item/tank/internals)) && (!istype(H.back, /obj/item/tank/internals)) && (!istype(H.belt, /obj/item/tank/internals)) && (!istype(H.l_store, /obj/item/tank/internals)) && (!istype(H.r_store, /obj/item/tank/internals)))
		to_chat(user, span_warning("You need to equip a tank!"))
		return
	..()

/obj/item/tank/jetpack/suit/turn_on(mob/user)
	if(!istype(loc, /obj/item/clothing/suit/space/hardsuit) || !ishuman(loc.loc) || loc.loc != user)
		return
	var/mob/living/carbon/human/H = user

	//Cascades down a priority list, taking air from first the suit storage slot, then the back, the belt, the left pocket and the right pocket
	if(istype(H.back, /obj/item/tank))
		tank = H.back
	else if(istype(H.s_store, /obj/item/tank))
		tank = H.s_store
	else if(istype(H.belt, /obj/item/tank))
		tank = H.belt
	else if(istype(H.l_store, /obj/item/tank))
		tank = H.l_store
	else if (istype(H.r_store, /obj/item/tank))
		tank = H.r_store
	else
		tank = null
		return

	air_contents = tank.air_contents
	START_PROCESSING(SSobj, src)
	cur_user = user
	..()

/obj/item/tank/jetpack/suit/turn_off(mob/user)
	tank = null
	air_contents = temp_air_contents
	STOP_PROCESSING(SSobj, src)
	cur_user = null
	..()

/obj/item/tank/jetpack/suit/process(seconds_per_tick)
	if(!istype(loc, /obj/item/clothing/suit/space/hardsuit) || !ishuman(loc.loc))
		turn_off(cur_user)
		return

	if(!tank)
		to_chat(usr, span_warning("\The [src] shuts down!"))
		turn_off(cur_user)
		return
	..()
