/obj/item/gun/grenadelauncher
	name = "grenade launcher"
	desc = "A terrible, terrible thing. It's really awful!"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "riotgun"
	item_state = "riotgun"
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 7
	var/fire_range = 10
	force = 5
	var/list/grenades = new/list()
	var/max_grenades = 3
	custom_materials = list(/datum/material/iron=2000)

/obj/item/gun/grenadelauncher/examine(mob/user)
	. = ..()
	. += "[grenades.len] / [max_grenades] grenades loaded."
	. += span_notice("You can eject a grenade from the [src] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")

/obj/item/gun/grenadelauncher/unique_action(mob/living/user)
	// there are no grenades
	if(!can_shoot())
		return
	var/obj/item/grenade/F = grenades[1]
	grenades -= F
	user.put_in_hands(F)
	playsound(src,'sound/weapons/gun/shotgun/rack.ogg',100)
	to_chat(user, span_notice("You unload the [F] from the [src]."))


/obj/item/gun/grenadelauncher/attackby(obj/item/I, mob/user, params)
	if((istype(I, /obj/item/grenade)))
		if(grenades.len < max_grenades)
			if(!user.transferItemToLoc(I, src))
				return
			grenades += I
			to_chat(user, span_notice("You put the grenade in the grenade launcher."))
			to_chat(user, span_notice("[grenades.len] / [max_grenades] Grenades."))
			playsound(src,'sound/weapons/gun/shotgun/insert_shell.ogg',100)
		else
			to_chat(usr, span_warning("The grenade launcher cannot hold more grenades!"))

/obj/item/gun/grenadelauncher/can_shoot()
	return grenades.len

/obj/item/gun/grenadelauncher/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(!can_shoot())
		return
	user.visible_message(span_danger("[user] fired a grenade!"), \
						span_danger("You fire the grenade launcher!"))
	var/obj/item/grenade/F = grenades[1] //Now with less copypasta!
	grenades -= F
	F.forceMove(user.loc)
	F.throw_at(target, fire_range, 2, user)
	message_admins("[ADMIN_LOOKUPFLW(user)] fired a grenade ([F.name]) from a grenade launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
	log_game("[key_name(user)] fired a grenade ([F.name]) with a grenade launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
	F.active = 1
	F.icon_state = initial(F.icon_state) + "_active"
	playsound(user.loc, 'sound/weapons/armbomb.ogg', 75, TRUE, -3)
	addtimer(CALLBACK(F, TYPE_PROC_REF(/obj/item/grenade, prime)), 45)
