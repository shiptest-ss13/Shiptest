/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/ammunition/ammo_bullets.dmi'
	icon_state = "pistol-brass"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = 500)

	/// Instance of the projectile to be shot, or null if there is no loaded projectile.
	var/obj/projectile/BB = null
	/// The projectile type to create in Initialize(), populating the BB variable with a projectile.
	var/projectile_type = null
	/// Caliber string, used to determine if the casing can be loaded into specific guns or magazines.
	var/caliber = null
	/// Used for pacifism checks. Set to FALSE if the bullet is non-lethal and pacifists should be able to fire.
	var/harmful = TRUE
	/// String, used to determine the appearance of the bullet on the casing sprite if the casing is filled.
	var/bullet_skin

	/// The sound played when this ammo is fired by an energy gun.
	var/fire_sound = null
	/// The visual effect that appears when the ammo is fired.
	var/firing_effect_type
	/// Enables casing spinning and sizzling after being ejected from a gun.
	var/heavy_metal = TRUE
	/// If true, the casing's sprite will automatically be transformed in Initialize().
	/// Disable for things like rockets or other heavy ammunition that should only appear right-side up.
	var/auto_rotate = TRUE
	/// If you dont want to bullets to randomly change position on spawn. For mapping.
	var/auto_scatter = TRUE

	///Pellets for spreadshot
	var/pellets = 1
	///Variance for inaccuracy fundamental to the casing
	var/variance = 0
	///Randomspread for automatics
	var/randomspread = FALSE
	///Delay for energy weapons
	var/delay = 0
	///Override this to make your gun have a faster fire rate, in tenths of a second. 4 is the default gun cooldown.
	var/click_cooldown_override = 0
	///If true, overrides the bouncing sfx from the turf to this one
	var/list/bounce_sfx_override

	///What this casing can be stacked into.
	var/obj/item/ammo_box/magazine/stack_type = /obj/item/ammo_box/magazine/ammo_stack
	///Maximum stack size of ammunition
	var/stack_size = 15

/obj/item/ammo_casing/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/pen))
		if(!user.is_literate())
			to_chat(user, "<span class='notice'>You scribble illegibly on the [src]!</span>")
			return
		var/inputvalue = stripped_input(user, "What would you like to label the round?", "Bullet Labelling", "", MAX_NAME_LEN)

		if(!inputvalue)
			return

		if(user.canUseTopic(src, BE_CLOSE))
			name = "[initial(src.name)][(inputvalue ? " - '[inputvalue]'" : null)]"
			if(BB)
				BB.name = "[initial(BB.name)][(inputvalue ? " - '[inputvalue]'" : null)]"
	else if(istype(attacking_item, /obj/item/ammo_box) && user.is_holding(src))
		add_fingerprint(user)
		var/obj/item/ammo_box/ammo_box = attacking_item
		var/obj/item/ammo_casing/other_casing = ammo_box.get_round(TRUE)

		if(try_stacking(other_casing, user))
			ammo_box.stored_ammo -= other_casing
			ammo_box.update_ammo_count()
		return

	else if(istype(attacking_item, /obj/item/ammo_box/magazine/ammo_stack))
		add_fingerprint(user)
		var/obj/item/ammo_box/magazine/ammo_stack = attacking_item
		if(isturf(loc))
			var/boolets = 0
			for(var/obj/item/ammo_casing/bullet in loc)
				if(bullet == src)
					continue
				if(!bullet.BB)
					continue
				if(length(ammo_stack.stored_ammo) >= ammo_stack.max_ammo)
					break
				if(ammo_stack.give_round(bullet, FALSE))
					boolets++
					break
			if((boolets <= 0) && BB && !(length(ammo_stack.stored_ammo) >= ammo_stack.max_ammo))
				if(ammo_stack.give_round(src, FALSE))
					boolets++
			if(boolets > 0)
				ammo_stack.update_ammo_count()
				to_chat(user, span_notice("You collect [boolets] round\s. [ammo_stack] now contains [length(ammo_stack.stored_ammo)] round\s."))
			else
				to_chat(user, span_warning("You can't stack any more!"))
		return

	else if(istype(attacking_item, /obj/item/ammo_casing))
		try_stacking(attacking_item, user)
		return

	return ..()

/obj/item/ammo_casing/examine(mob/user)
	. = ..()
	. += span_notice("You could write a message on \the [src] by writing on it with a pen.")

/obj/item/ammo_casing/proc/try_stacking(obj/item/ammo_casing/other_casing, mob/living/user)
	if(user)
		add_fingerprint(user)
	if(!other_casing.stack_type)
		if(user)
			to_chat(user, span_warning("[other_casing] can't be stacked."))
		return
	if(!stack_type)
		if(user)
			to_chat(user, span_warning("[src] can't be stacked."))
		return
	if(name != other_casing.name) //Has to match exactly
		if(user)
			to_chat(user, span_warning("You can't stack different types of ammunition."))
		return
	if(stack_type != other_casing.stack_type)
		if(user)
			to_chat(user, span_warning("You can't stack [other_casing] with [src]."))
		return
	if(!BB || !other_casing.BB) //maybe allow empty casing stacking at a later date, when there's a feature to recycle casings
		if(user)
			to_chat(user, span_warning("You can't stack empty casings."))
		return
	if((item_flags & IN_STORAGE) || (other_casing.item_flags & IN_STORAGE))
		if(user)
			to_chat(user, span_warning("You can't stack casings while they are inside storage."))
		return
	var/obj/item/ammo_box/magazine/ammo_stack/ammo_stack = other_casing.stack_with(src)
	if(user)
		user.put_in_hands(ammo_stack)
		to_chat(user, span_notice("[src] has been stacked with [other_casing]."))
	return ammo_stack

/obj/item/ammo_casing/proc/stack_with(obj/item/ammo_casing/other_casing)
	var/obj/item/ammo_box/magazine/ammo_stack/ammo_stack = new stack_type(drop_location())
	ammo_stack.name = "handful of [name]s" //"handful of .9mm bullet casings"
	ammo_stack.base_icon_state = other_casing.icon_state
	ammo_stack.caliber = caliber
	ammo_stack.max_ammo = stack_size
	ammo_stack.give_round(src)
	ammo_stack.give_round(other_casing)
	ammo_stack.update_ammo_count()
	return ammo_stack

/obj/item/ammo_casing/spent
	name = "spent bullet casing"
	BB = null

/obj/item/ammo_casing/Initialize()
	. = ..()
	if(projectile_type)
		BB = new projectile_type(src)
	if(auto_scatter)
		pixel_x = base_pixel_x + rand(-10, 10)
		pixel_y = base_pixel_y + rand(-10, 10)
	item_flags |= NO_PIXEL_RANDOM_DROP
	if(auto_rotate)
		transform = transform.Turn(round(45 * rand(0, 32) / 2))
	update_appearance()

/obj/item/ammo_casing/Destroy()
	. = ..()
	if(BB)
		QDEL_NULL(BB)

/obj/item/ammo_casing/update_icon_state()
	icon_state = "[initial(icon_state)][BB ? (bullet_skin ? "-[bullet_skin]" : "") : "-empty"]"
	return ..()

/obj/item/ammo_casing/update_desc()
	desc = "[initial(desc)][BB ? null : " This one is spent."]"
	return ..()

///Proc to magically refill a casing with a new projectile
/obj/item/ammo_casing/proc/newshot() //For energy weapons, syringe gun, shotgun shells and wands (!).
	if(!BB)
		BB = new projectile_type(src, src)

/obj/item/ammo_casing/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	bounce_away(FALSE, NONE)
	. = ..()

/obj/item/ammo_casing/proc/on_eject(atom/shooter)
	forceMove(drop_location()) //Eject casing onto ground.
	pixel_x = rand(-4, 4)
	pixel_y = rand(-4, 4)
	pixel_z = 8 //bounce time
	var/angle_of_movement = !isnull(shooter) ? (rand(-3000, 3000) / 100) + dir2angle(turn(shooter.dir, 180)) : rand(-3000, 3000) / 100
	AddComponent(/datum/component/movable_physics, _horizontal_velocity = rand(400, 450) / 100, _vertical_velocity = rand(400, 450) / 100, _horizontal_friction = rand(20, 24) / 100, _z_gravity = PHYSICS_GRAV_STANDARD, _z_floor = 0, _angle_of_movement = angle_of_movement, _bounce_sound = bounce_sfx_override)

/obj/item/ammo_casing/proc/bounce_away(still_warm = FALSE, bounce_delay = 3)
	if(!heavy_metal)
		return
	update_appearance()
	SpinAnimation(10, 1)
	var/turf/location = get_turf(src)
	if(bounce_sfx_override)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, pick(bounce_sfx_override), 20, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.
		return
	if(!location)
		return

	if(still_warm && location.bullet_sizzle)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.

	else if(location.bullet_bounce_sound)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, pick(location.bullet_bounce_sound), 20, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.
