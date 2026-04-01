/obj/item/ammo_box/magazine/internal/cylinder
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = ".357"
	max_ammo = 6
	instant_load = TRUE
	quick_empty = FALSE

/obj/item/ammo_box/magazine/internal/cylinder/get_round(keep = FALSE, counter_clockwise = FALSE)
	rotate(counter_clockwise)

	var/b = stored_ammo[1]
	if(!keep)
		stored_ammo[1] = null

	return b

/obj/item/ammo_box/magazine/internal/cylinder/proc/rotate(counter_clockwise = FALSE)
	var/b
	if(!counter_clockwise)
		b = stored_ammo[1]
		stored_ammo.Cut(1,2)
		stored_ammo.Insert(0, b)
	else
		b = stored_ammo[max_ammo]
		stored_ammo.Cut(max_ammo,max_ammo+1)
		stored_ammo.Insert(1, b)

/obj/item/ammo_box/magazine/internal/cylinder/proc/spin()
	for(var/i in 1 to rand(0, max_ammo*2))
		rotate()

/obj/item/ammo_box/magazine/internal/cylinder/ammo_list(drop_list = FALSE)
	var/list/L = list()
	for(var/i=1 to stored_ammo.len)
		var/obj/item/ammo_casing/bullet = stored_ammo[i]
		if(bullet)
			L.Add(bullet)
			if(drop_list)//We have to maintain the list size, to emulate a cylinder
				stored_ammo[i] = null
		else
			L.Add(null)
	return L

/obj/item/ammo_box/magazine/internal/cylinder/give_round(obj/item/ammo_casing/R, replace_spent = 0)
	if(!R || (caliber && R.caliber != caliber) || (!caliber && R.type != ammo_type))
		return FALSE

	for(var/i in 1 to stored_ammo.len)
		var/obj/item/ammo_casing/bullet = stored_ammo[i]
		if(!bullet || !bullet.BB) // found a spent ammo
			stored_ammo[i] = R
			R.forceMove(src)

			if(bullet)
				bullet.forceMove(drop_location())
			return TRUE

	return FALSE

/obj/item/ammo_box/magazine/internal/cylinder/attackby(obj/item/attacking_obj, mob/user, params, silent = FALSE, replace_spent = FALSE)
	var/num_loaded = 0
	if(!can_load(user))
		return
	if(istype(attacking_obj, /obj/item/ammo_box))
		var/obj/item/ammo_box/attacking_box = attacking_obj
		var/list/ammo_list_no_empty = ammo_list(FALSE)
		listclearnulls(ammo_list_no_empty)
		for(var/obj/item/ammo_casing/casing_to_insert in attacking_box.stored_ammo)
			if(!((instant_load && attacking_box.instant_load) || (ammo_list_no_empty.len >= max_ammo) || do_after(user, 1 SECONDS, attacking_box))) //stupid work around for revolvers
				break
			var/did_load = give_round(casing_to_insert, replace_spent)
			if(!did_load)
				break
			attacking_box.stored_ammo -= casing_to_insert
			if(!silent)
				playsound(get_turf(attacking_box), 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE) //src is nullspaced, which means internal magazines won't properly play sound, thus we use attacking_box
			num_loaded++
			ammo_list_no_empty = ammo_list(FALSE)
			listclearnulls(ammo_list_no_empty)
			attacking_obj.update_appearance()
			update_appearance()

	if(istype(attacking_obj, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/casing_to_insert = attacking_obj
		if(give_round(casing_to_insert, replace_spent))
			user.transferItemToLoc(casing_to_insert, src, TRUE)
			if(!silent)
				playsound(casing_to_insert, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
			num_loaded++
			update_appearance()


	if(num_loaded)
		if(!silent)
			to_chat(user, span_notice("You load [num_loaded] cartridge\s into \the [src]!"))
	return num_loaded
