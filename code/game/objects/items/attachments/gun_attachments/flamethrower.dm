/obj/item/attachment/gun/flamethrower
	name = "underbarrel flamethrower"
	desc = "A compact underbarrel flamethrower holding up to 20 units of fuel, enough for two sprays."
	attached_gun = null
	var/obj/item/flamethrower/underbarrel/attached_flamethrower

/obj/item/attachment/gun/flamethrower/Initialize()
	. = ..()
	attached_flamethrower = new /obj/item/flamethrower/underbarrel(src)

/obj/item/attachment/gun/flamethrower/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(gun.safety == TRUE && attached_flamethrower.lit == TRUE)
		attached_flamethrower.toggle_igniter(user)
	else if(gun.safety == FALSE && attached_flamethrower.lit == FALSE)
		attached_flamethrower.toggle_igniter(user)

/obj/item/attachment/gun/flamethrower/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	if(toggled)
		if(istype(attack_item,/obj/item/reagent_containers/glass))
			attached_flamethrower.attackby(attack_item,user)

/obj/item/attachment/gun/flamethrower/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/reagent_containers/glass))
		attached_flamethrower.attackby(I,user)
	else
		return ..()

/obj/item/attachment/gun/flamethrower/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(toggled)
		log_combat(user, target, "flamethrowered", src)
		attached_flamethrower.flame_turf(get_turf(target))
		return COMPONENT_NO_ATTACK

/obj/item/attachment/gun/flamethrower/on_unique_action(obj/item/gun/gun, mob/user)
	if(toggled)
		attached_flamethrower.reagents.clear_reagents()

/obj/item/attachment/gun/flamethrower/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	. = ..()
	var/total_volume = 0
	for(var/datum/reagent/R in attached_flamethrower.beaker.reagents.reagent_list)
		total_volume += R.volume
	examine_list += span_notice("-\The [src] has [total_volume] units of fuel left.")
	examine_list += span_notice("-You can empty the [attached_flamethrower.beaker] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")

/obj/item/attachment/gun/flamethrower/on_wield(obj/item/gun/gun, mob/user, list/params)
	return FALSE

/obj/item/attachment/gun/flamethrower/on_unwield(obj/item/gun/gun, mob/user, list/params)
	return FALSE

/obj/item/attachment/gun/flamethrower/on_ctrl_click(obj/item/gun/gun, mob/user)
	. = ..()
	attached_flamethrower.toggle_igniter(user)

/obj/item/flamethrower/underbarrel
	name = "underbarrel flamethrower"
	desc = "Something is wrong if you're seeing this."
	create_full = TRUE

/obj/item/flamethrower/underbarrel/Initialize(mapload)
	. = ..()
	beaker = new /obj/item/reagent_containers/glass/beaker/flamethrower_underbarrel(src)

// you cant pull out the fuel beaker
/obj/item/flamethrower/underbarrel/AltClick(mob/user)
	return

/obj/item/flamethrower/underbarrel/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/source = W
		if(!source.is_refillable())
			to_chat(user, span_danger("\The [source]'s cap is on! Take it off first."))
			return
		if(beaker.reagents.total_volume >= beaker.volume)
			to_chat(user, span_danger("\The [beaker] is full."))
			return
		source.reagents.trans_to(beaker, source.amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You transfer [source.amount_per_transfer_from_this] units to \the [beaker]"))
	else
		return ..()


/obj/item/reagent_containers/glass/beaker/flamethrower_underbarrel
	name = "internal fuel tank"
	desc = "An internal fuel tank for a flamethrower. You shouldnt have been able to pull this out."
	icon = 'icons/obj/chemical/hypovial.dmi'
	icon_state = "hypovial"
	volume = 20


