/obj/item/gun/energy/e_gun
	name = "energy rifle"
	desc = "A basic hybrid energy gun with two settings: disable and kill."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "energy"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/sharplite, /obj/item/ammo_casing/energy/laser/sharplite)
	modifystate = TRUE
	ammo_x_offset = 2
	dual_wield_spread = 60
	wield_slowdown = LASER_RIFLE_SLOWDOWN
	manufacturer = MANUFACTURER_SHARPLITE_NEW
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/e_gun/empty_cell
	spawn_no_ammo = TRUE



/obj/item/gun/energy/e_gun/turret
	name = "hybrid turret gun"
	desc = "A heavy hybrid energy cannon with two settings: Stun and kill. ...It doesn't seem have a trigger, seems it can only be used as a turret."
	lefthand_file = GUN_LEFTHAND_ICON
	righthand_file = GUN_RIGHTHAND_ICON
	icon_state = "turretlaser"
	item_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	default_ammo_type = null
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/turret/pre_fire(atom/target, mob/living/user, message, flag, params, zone_override, bonus_spread, dual_wielded_gun)
	to_chat(user, span_notice("[src] is not designed to be fired by hand."))
	return FALSE

/obj/item/gun/energy/e_gun/rdgun
	name = "research director's PDW"
	desc = "A custom energy revolver made from the power of science, but more importantly booze. Only has 6 shots. It looks well worn, however that was long, long ago."
	icon_state = "rdpdw"
	item_state = "gun"
	ammo_x_offset = 2
	charge_sections = 6

	wield_delay = 0.2 SECONDS
	wield_slowdown = LASER_PISTOL_SLOWDOWN

	spread = 2
	spread_unwielded = 5

	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan, /obj/item/ammo_casing/energy/ion/cheap)
	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
	)


