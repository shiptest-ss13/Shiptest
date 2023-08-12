/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/ammo_bullets.dmi'
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
	var/firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect
	/// Enables casing spinning and sizzling after being ejected from a gun.
	var/heavy_metal = TRUE
	/// If true, the casing's sprite will automatically be transformed in Initialize().
	/// Disable for things like rockets or other heavy ammunition that should only appear right-side up.
	var/auto_rotate = TRUE

	var/pellets = 1								//Pellets for spreadshot
	var/variance = 0							//Variance for inaccuracy fundamental to the casing
	var/randomspread = 0						//Randomspread for automatics
	var/delay = 0								//Delay for energy weapons
	var/click_cooldown_override = 0				//Override this to make your gun have a faster fire rate, in tenths of a second. 4 is the default gun cooldown.


/obj/item/ammo_casing/spent
	name = "spent bullet casing"
	BB = null

/obj/item/ammo_casing/Initialize()
	. = ..()
	if(projectile_type)
		BB = new projectile_type(src)
	pixel_x = base_pixel_x + rand(-10, 10)
	pixel_y = base_pixel_y + rand(-10, 10)
	if(auto_rotate)
		transform = transform.Turn(pick(0, 90, 180, 270))
	update_appearance()

/obj/item/ammo_casing/Destroy()
	. = ..()

	if(!BB)
		SSblackbox.record_feedback("tally", "station_mess_destroyed", 1, name)

/obj/item/ammo_casing/update_icon_state()
	icon_state = "[initial(icon_state)][BB ? (bullet_skin ? "-[bullet_skin]" : "") : "-empty"]"
	return ..()

/obj/item/ammo_casing/update_desc()
	desc = "[initial(desc)][BB ? null : " This one is spent."]"
	return ..()

//proc to magically refill a casing with a new projectile
/obj/item/ammo_casing/proc/newshot() //For energy weapons, syringe gun, shotgun shells and wands (!).
	if(!BB)
		BB = new projectile_type(src, src)

/obj/item/ammo_casing/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_box))
		var/obj/item/ammo_box/box = I
		if(isturf(loc))
			var/boolets = 0
			for(var/obj/item/ammo_casing/bullet in loc)
				if (box.stored_ammo.len >= box.max_ammo)
					break
				if (bullet.BB)
					if (box.give_round(bullet, 0))
						boolets++
				else
					continue
			if (boolets > 0)
				box.update_appearance()
				to_chat(user, "<span class='notice'>You collect [boolets] shell\s. [box] now contains [box.stored_ammo.len] shell\s.</span>")
			else
				to_chat(user, "<span class='warning'>You fail to collect anything!</span>")
	else
		return ..()


/obj/item/ammo_casing/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	bounce_away(FALSE, NONE)
	. = ..()

/obj/item/ammo_casing/proc/bounce_away(still_warm = FALSE, bounce_delay = 3)
	if(!heavy_metal)
		return
	update_appearance()
	SpinAnimation(10, 1)
	var/turf/T = get_turf(src)
	if(still_warm && T && T.bullet_sizzle)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.
	else if(T && T.bullet_bounce_sound)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, T.bullet_bounce_sound, 20, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.
