/obj/item/attachment/laser_sight
	name = "laser sight"
	desc = "Designed to be rail-mounted on a compatible firearm to provide increased accuracy and decreased spread."
	icon_state = "laserpointer"

	allow_icon_state_prefixes = TRUE
	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS

/obj/item/attachment/laser_sight/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()

	if(toggled)
		gun.spread -= 1
		gun.spread_unwielded -= 2
		gun.wield_delay -= 0.3 SECONDS
	else
		gun.spread += 1
		gun.spread_unwielded += 2
		gun.wield_delay += 0.3 SECONDS

	playsound(user, toggled ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)

/obj/item/attachment/laser_sight/on_fireliveshot(obj/item/gun/gun, user, pointblank, atom/pbtarget, message, params)
	if(toggled)
		make_laser(gun, user, pointblank, pbtarget, message, params)
	return FALSE

/obj/item/attachment/laser_sight/proc/make_laser(obj/item/gun/gun, user, pointblank, atom/pbtarget, message, params)
	var/obj/projectile/beam/beam_rifle/hitscan/aiming_beam/fake_laser_projectile = new
	fake_laser_projectile.gun = src

	var/turf/curloc = (get_turf(user) || get_turf(src))
	var/turf/targloc = get_turf(pbtarget)

	var/mouse_modifiers = params2list(params)

	if(user)
		fake_laser_projectile.preparePixelProjectile(targloc, curloc, mouse_modifiers, 0)
	else
		fake_laser_projectile.preparePixelProjectile(targloc, user, mouse_modifiers, 0)

	fake_laser_projectile.fire()
