/**
 * The ammo stack object itself, making this a magazine was the easiest way to handle it
 * Practically every casing type needs an associated ammo stack type, because that was the easiest
 * way for me to handle it.
 */
/obj/item/ammo_box/magazine/ammo_stack
	name = "ammo stack"
	desc = "A stack of ammo."
	icon_state = "pistol-brass"
	base_icon_state = "pistol-brass"
	item_flags = NO_PIXEL_RANDOM_DROP
	multiple_sprites = AMMO_BOX_ONE_SPRITE
	multiload = FALSE
	start_empty = TRUE
	max_ammo = 12

/obj/item/ammo_box/magazine/ammo_stack/update_icon(updates)
	icon = initial(icon)
	cut_overlays()
	return ..()

/obj/item/ammo_box/magazine/ammo_stack/update_icon_state()
	. = ..()
	cut_overlays()
	icon_state = ""

	for(var/casing in stored_ammo)
		var/image/bullet = image(initial(icon), src, "[base_icon_state]")
		bullet.pixel_x = rand(-8, 8)
		bullet.pixel_y = rand(-8, 8)
		add_overlay(bullet)
	return UPDATE_ICON_STATE | UPDATE_OVERLAYS

/obj/item/ammo_box/magazine/ammo_stack/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
    . = ..()
    var/loc_before_del = loc
    while(LAZYLEN(stored_ammo))
        var/obj/item/ammo = get_round(FALSE)
        ammo.forceMove(loc_before_del)
        ammo.throw_at(loc_before_del)
    check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/handle_atom_del(atom/A)
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/empty_magazine()
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/update_ammo_count()
	. = ..()
	check_for_del()

/obj/item/ammo_box/magazine/ammo_stack/proc/check_for_del()
	. = FALSE
	if((ammo_count(TRUE) <= 0) && !QDELETED(src))
		qdel(src)
		return TRUE

/obj/item/ammo_box/magazine/ammo_stack/attackby(obj/item/A, mob/user, params, silent = FALSE, replace_spent = 0)
	var/num_loaded = 0
	if(!can_load(user))
		return
	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/AM = A
		for(var/obj/item/ammo_casing/AC in AM.stored_ammo)
			var/did_load = give_round(AC, replace_spent)
			if(did_load)
				AM.stored_ammo -= AC
				num_loaded++
			if(!did_load || !multiload)
				break
		if(num_loaded)
			AM.update_ammo_count()
	if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/AC = A
		if(give_round(AC, replace_spent))
			user.transferItemToLoc(AC, src, TRUE)
			num_loaded++
			AC.update_appearance()

	if(num_loaded)
		if(!silent)
			to_chat(user, span_notice("You load [num_loaded] shell\s into \the [src]!"))
			playsound(src, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
		update_ammo_count()
