//TODO: make this code more readable. weird var names, convoluted logic, etc

//Boxes of ammo
/obj/item/ammo_box
	name = "ammo box (null_reference_exception)"
	desc = "A box of ammo."
	icon = 'icons/obj/ammunition/ammo.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	custom_materials = list(/datum/material/iron = 15000)
	throwforce = 2
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	///list containing the actual ammo within the magazine
	var/list/stored_ammo = list()
	///type that the magazine will be searching for, rejects if not a subtype of
	var/ammo_type = /obj/item/ammo_casing
	///maximum amount of ammo in the magazine
	var/max_ammo = 7
	///Controls how sprites are updated for the ammo box; see defines in combat.dm: AMMO_BOX_ONE_SPRITE; AMMO_BOX_PER_BULLET; AMMO_BOX_FULL_EMPTY
	var/multiple_sprites = AMMO_BOX_ONE_SPRITE
	///String, used for checking if ammo of different types but still fits can fit inside it; generally used for magazines
	var/caliber
	///Allows multiple bullets to be loaded in from one click of another box/magazine
	var/multiload = FALSE
	///Whether or not an ammo box skips the do_after process (e.g. speedloaders)
	var/instant_load = FALSE
	///Whether the magazine should start with nothing in it
	var/start_empty = FALSE
	///cost of all the bullets in the magazine/box
	var/list/bullet_cost
	///cost of the materials in the magazine/box itself
	var/list/base_cost

/obj/item/ammo_box/Initialize(mapload, spawn_empty)
	. = ..()
	if(spawn_empty)
		start_empty = TRUE
	if(!base_icon_state)
		base_icon_state = icon_state

	if(!bullet_cost)
		for (var/material in custom_materials)
			var/material_amount = custom_materials[material]
			LAZYSET(base_cost, material, (material_amount * 0.10))

			material_amount *= 0.90 // 10% for the container
			material_amount /= max_ammo
			LAZYSET(bullet_cost, material, material_amount).

	if(!start_empty)
		top_off(starting = TRUE)

	update_appearance()

/*
 * top_off is used to refill the magazine to max, in case you want to increase the size of a magazine with VV then refill it at once
 * Arguments:
 * load_type - if you want to specify a specific ammo casing type to load, enter the path here, otherwise it'll use the basic [/obj/item/ammo_box/var/ammo_type]. Must be a compatible round
 * starting - Relevant for revolver cylinders, if FALSE then we mind the nulls that represent the empty cylinders (since those nulls don't exist yet if we haven't initialized when this is TRUE)
 */
/obj/item/ammo_box/proc/top_off(load_type, starting=FALSE)
	if(!load_type) //this check comes first so not defining an argument means we just go with default ammo
		load_type = ammo_type

	var/obj/item/ammo_casing/round_check = load_type
	if(!starting && (caliber && initial(round_check.caliber) != caliber) || (!caliber && load_type != ammo_type))
		stack_trace("Tried loading unsupported ammocasing type [load_type] into ammo box [type].")
		return

	for(var/i = max(1, stored_ammo.len), i <= max_ammo, i++)
		stored_ammo += new round_check(src)

/obj/item/ammo_box/Destroy()
	stored_ammo.Cut()
	return ..()

///gets a round from the magazine, if keep is TRUE the round will stay in the gun
/obj/item/ammo_box/proc/get_round(keep = FALSE)
	if(!stored_ammo.len)
		return null
	else
		var/b = stored_ammo[stored_ammo.len]
		stored_ammo -= b
		if (keep)
			stored_ammo.Insert(1,b)
		return b

///puts a round into the magazine
/obj/item/ammo_box/proc/give_round(obj/item/ammo_casing/R, replace_spent = FALSE)
	// Boxes don't have a caliber type, magazines do. Not sure if it's intended or not, but if we fail to find a caliber, then we fall back to ammo_type.
	if(!R || (caliber && R.caliber != caliber) || (!caliber && R.type != ammo_type))
		return FALSE

	if(stored_ammo.len < max_ammo)
		stored_ammo += R
		R.forceMove(src)
		return TRUE

	//for accessibles magazines (e.g internal ones) when full, start replacing spent ammo
	else if(replace_spent)
		for(var/obj/item/ammo_casing/AC in stored_ammo)
			if(!AC.BB)//found a spent ammo
				stored_ammo -= AC
				AC.forceMove(get_turf(src.loc))

				stored_ammo += R
				R.forceMove(src)
				return TRUE
	return FALSE

///Whether or not the box can be loaded, used in overrides
/obj/item/ammo_box/proc/can_load(mob/user)
	return TRUE

/obj/item/ammo_box/attackby(obj/item/attacking_obj, mob/user, params, silent = FALSE, replace_spent = FALSE)
	var/num_loaded = 0

	if(!can_load(user))
		return

	if(istype(attacking_obj, /obj/item/ammo_box))
		var/obj/item/ammo_box/attacking_box = attacking_obj
		for(var/obj/item/ammo_casing/casing_to_insert in attacking_box.stored_ammo)
			if(!((instant_load && attacking_box.instant_load) || (stored_ammo.len >= max_ammo) || istype(attacking_obj, /obj/item/ammo_box/magazine/ammo_stack) && do_after(user, 0.5 SECONDS, attacking_box, timed_action_flags = IGNORE_USER_LOC_CHANGE)))
				break
			var/did_load = give_round(casing_to_insert, replace_spent)
			if(!did_load)
				break
			attacking_box.stored_ammo -= casing_to_insert
			if(!silent)
				playsound(get_turf(attacking_box), 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE) //src is nullspaced, which means internal magazines won't properly play sound, thus we use attacking_box
			num_loaded++
			attacking_box.update_ammo_count()
			update_ammo_count()

	if(istype(attacking_obj, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/casing_to_insert = attacking_obj
		if(give_round(casing_to_insert, replace_spent))
			user.transferItemToLoc(casing_to_insert, src, TRUE)
			num_loaded++
			casing_to_insert.update_appearance()
			update_ammo_count()

	if(num_loaded)
		if(!silent)
			to_chat(user, span_notice("You load [num_loaded] cartridge\s into \the [src]!"))
			playsound(src, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
	return num_loaded

/obj/item/ammo_box/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/num_loaded = 0
	var/obj/item/storage/belt/bandolier/to_load
	if(istype(target,/obj/item/storage/belt/bandolier))
		to_load = target
		var/datum/component/storage/storage_to_load = to_load.GetComponent(/datum/component/storage)
		for(var/obj/item/ammo_casing/casing_to_insert in stored_ammo)
			if(!((to_load.contents.len >= storage_to_load.get_max_volume()) || do_after(user, 0.5 SECONDS, src)))
				break
			if(!storage_to_load.can_be_inserted(casing_to_insert,TRUE,user))
				break
			storage_to_load.handle_item_insertion(casing_to_insert,TRUE,user)
			stored_ammo -= casing_to_insert
			playsound(get_turf(src), 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
			num_loaded++
			update_ammo_count()
	if(num_loaded)
		to_chat(user, "<span class='notice'>You load [num_loaded] cartridge\s into \the [to_load]!</span>")
	return

/obj/item/ammo_box/attack_self(mob/user)
	var/obj/item/ammo_casing/A = get_round()
	if(!A)
		return

	A.forceMove(drop_location())
	var/mob/living/carbon/human/H = user
	if(!(user.is_holding(src) || H.l_store == src || H.r_store == src) || !user.put_in_hands(A)) //incase they're using TK
		A.bounce_away(FALSE, NONE)
	playsound(src, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE)
	to_chat(user, span_notice("You remove a round from [src]!"))
	update_ammo_count()

/// Updates the materials and appearance of this ammo box
/obj/item/ammo_box/proc/update_ammo_count()
	update_custom_materials()
	update_appearance()

/obj/item/ammo_box/update_desc(updates)
	. = ..()
	var/shells_left = LAZYLEN(stored_ammo)
	desc = "[initial(desc)] There [(shells_left == 1) ? "is" : "are"] [shells_left] shell\s left!"

/obj/item/ammo_box/update_icon_state()
	var/shells_left = LAZYLEN(stored_ammo)
	switch(multiple_sprites)
		if(AMMO_BOX_PER_BULLET)
			icon_state = "[base_icon_state]-[shells_left]"
		if(AMMO_BOX_FULL_EMPTY)
			icon_state = "[base_icon_state]-[shells_left ? "1" : "0"]"
	return ..()

/// Updates the amount of material in this ammo box according to how many bullets are left in it.
/obj/item/ammo_box/proc/update_custom_materials()
	var/temp_materials = custom_materials.Copy()
	for(var/material in bullet_cost)
		temp_materials[material] = (bullet_cost[material] * stored_ammo.len) + base_cost[material]
	set_custom_materials(temp_materials)

/obj/item/ammo_box/AltClick(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if((user.is_holding(src) ||H.l_store == src || H.r_store == src) && !(caliber || istype(src, /obj/item/ammo_box/magazine) || instant_load))	//caliber because boxes have none, instant load because speedloaders use the base ammo box type with instant load on, and magazine for the obvious.
			attack_self(user)
			return
	..()

/obj/item/ammo_box/examine(mob/user)
	. = ..()
	if(!(caliber || istype(src, /obj/item/ammo_box/magazine) || instant_load))
		. += "Alt-click on [src] while it in a pocket or your off-hand to take out a round while it is there."

/obj/item/ammo_box/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	for(var/obj/item/ammo_casing/bullet2pop in stored_ammo)
		bullet2pop.fire_act()

/obj/item/ammo_box/magazine
	w_class = WEIGHT_CLASS_SMALL //Default magazine weight, only differs for tiny mags and drums

///Count of number of bullets in the magazine
/obj/item/ammo_box/magazine/proc/ammo_count(countempties = TRUE)
	var/boolets = 0
	for(var/obj/item/ammo_casing/bullet in stored_ammo)
		if(bullet && (bullet.BB || countempties))
			boolets++
	return boolets

///list of every bullet in the magazine
/obj/item/ammo_box/magazine/proc/ammo_list(drop_list = FALSE)
	var/list/L = stored_ammo.Copy()
	if(drop_list)
		stored_ammo.Cut()
		update_ammo_count()
	return L

///drops the entire contents of the magazine on the floor
/obj/item/ammo_box/magazine/proc/empty_magazine()
	var/turf_mag = get_turf(src)
	for(var/obj/item/ammo in stored_ammo)
		ammo.forceMove(turf_mag)
		stored_ammo -= ammo
	update_ammo_count()

/obj/item/ammo_box/magazine/handle_atom_del(atom/A)
	stored_ammo -= A
	update_ammo_count()

