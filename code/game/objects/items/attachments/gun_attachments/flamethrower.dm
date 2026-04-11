/obj/item/attachment/gun/flamethrower
	name = "underbarrel flamethrower"
	desc = "A compact underbarrel flamethrower holding up to 20 units of fuel, enough for two sprays."
	icon_state = "flamethrower"
	weapon_type = null
	var/obj/item/flamethrower/underbarrel/attached_flamethrower

/obj/item/attachment/gun/flamethrower/Initialize()
	. = ..()
	attached_flamethrower = new /obj/item/flamethrower/underbarrel(src)

/obj/item/attachment/gun/flamethrower/Destroy()
	. = ..()
	QDEL_NULL(attached_flamethrower)

/obj/item/attachment/gun/flamethrower/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(gun.safety == TRUE && attached_flamethrower.lit == TRUE)
		attached_flamethrower.toggle_igniter(user)
	else if(gun.safety == FALSE && attached_flamethrower.lit == FALSE)
		attached_flamethrower.toggle_igniter(user)

/obj/item/attachment/gun/flamethrower/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/reagent_containers/glass) || istype(I,/obj/item/reagent_containers/food/drinks))
		attached_flamethrower.attackby(I,user)
	else
		return ..()

/obj/item/attachment/gun/flamethrower/on_fire_gun(obj/item/gun/gun, mob/living/user, atom/target, flag, params)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		log_combat(user, target, "flamethrowered", src)
		INVOKE_ASYNC(attached_flamethrower, TYPE_PROC_REF(/obj/item/flamethrower, flame_turf), get_turf(target))
		return COMPONENT_CANCEL_GUN_FIRE

/obj/item/attachment/gun/flamethrower/on_unique_action(obj/item/gun/gun, mob/user)
	attached_flamethrower.unique_action(user)
	return OVERRIDE_SECONDARY_ACTION

/obj/item/attachment/gun/flamethrower/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/total_volume = 0
	for(var/datum/reagent/R in attached_flamethrower.beaker.reagents.reagent_list)
		total_volume += R.volume
	examine_list += span_notice("-\The [src] has [total_volume] units of fuel left.")
	examine_list += span_notice("-You can empty the [attached_flamethrower.beaker] by pressing the <b>secondary action</b> key. By default, this is <b>shift + space</b>")
	return examine_list

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
	if(istype(W, /obj/item/reagent_containers/glass) || istype(W,/obj/item/reagent_containers/food/drinks))
		var/obj/item/reagent_containers/glass/source = W
		if(!source.is_refillable())
			to_chat(user, span_danger("\The [source]'s cap is on! Take it off first."))
			return
		if(beaker.reagents.total_volume >= beaker.volume)
			to_chat(user, span_danger("\The [beaker] is full."))
			return
		source.reagents.trans_to(beaker, source.amount_per_transfer_from_this, transfered_by = user)
		playsound(user,'sound/items/glass_transfer.ogg',100)
		to_chat(user, span_notice("You transfer [source.amount_per_transfer_from_this] units to \the [beaker]"))
	else
		return ..()

/obj/item/flamethrower/underbarrel/unique_action(mob/living/user)
	. = ..()
	beaker.reagents.clear_reagents()
	playsound(user,'sound/items/glass_splash.ogg',100)


/obj/item/reagent_containers/glass/beaker/flamethrower_underbarrel
	name = "internal fuel tank"
	desc = "An internal fuel tank for a flamethrower. You shouldn't have been able to pull this out."
	icon = 'icons/obj/chemical/hypovial.dmi'
	icon_state = "hypovial"
	volume = 20
