/obj/item/gun/ballistic/derringer
	name = ".38 Derringer"
	desc = "A easily consealable derringer. Uses .38 ammo"
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	icon_state = "derringer"
	mag_type = /obj/item/ammo_box/magazine/internal/derr38
	fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 60
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/ballistic/derringer/Initialize()
	..()
	transform *= 0.8 //Spriter too lazy to make icons smaller than default revolvers, local coder hacks in solution.

/obj/item/gun/ballistic/derringer/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //legacy var name maturity
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/derringer/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."

/obj/item/gun/ballistic/derringer/traitor
	name = "\improper .357 Syndicate Derringer"
	desc = "An easily consealable derriger, if not for the bright red and black. Uses .357 ammo"
	icon_state = "derringer_syndie"
	mag_type = /obj/item/ammo_box/magazine/internal/derr357
	fire_sound_volume = 50 //Tactical stealth firing

/obj/item/gun/ballistic/derringer/gold
	name = "\improper Golden Derringer"
	desc = "The golden sheen is somewhat counterintuitive as a stealth weapon, but it looks cool. Uses .357 ammo"
	icon_state = "derringer_gold"
	mag_type = /obj/item/ammo_box/magazine/internal/derr357
