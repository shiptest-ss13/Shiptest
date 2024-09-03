/obj/item/attachment/laser_sight
	name = "laser sight"
	desc = "Designed to be rail-mounted on a compatible firearm to provide increased accuracy and decreased spread."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS

/obj/item/attachment/laser_sight/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()

	if(toggled)
		gun.spread -= 3
		gun.spread_unwielded -= 3
		gun.wield_delay -= 0.3 SECONDS
	else
		gun.spread += 3
		gun.spread_unwielded += 3
		gun.wield_delay += 0.3 SECONDS

	playsound(user, toggled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)

/obj/item/attachment/laser_sight/on_preattack(obj/item/gun/gun, atom/target, mob/user, list/params)
	if(toggled) //copied from lsaer pointer code, dont kill me
		var/targloc = get_turf(target)
		var/image/laser_image = image('icons/obj/projectiles.dmi',targloc,"red_laser",10)
		var/list/modifiers = params2list(params)
		if(modifiers)
			if(LAZYACCESS(modifiers, ICON_X))
				laser_image.pixel_x = (text2num(LAZYACCESS(modifiers, ICON_X)) - 16)
			if(LAZYACCESS(modifiers, ICON_Y))
				laser_image.pixel_y = (text2num(LAZYACCESS(modifiers, ICON_Y)) - 16)
		else
			laser_image.pixel_x = target.pixel_x + rand(-5,5)
			laser_image.pixel_y = target.pixel_y + rand(-5,5)

		flick_overlay_view(laser_image, targloc, 1 SECONDS)
		return TRUE

	return FALSE
