/*
/obj/item/attachment/gun/ballistic
	name = "ballistic underbarrel gun"
	desc = "A ballistic underbarrel gun. It shoots bullets. Or something."
	underbarrel_prefix = "bullet_"

/obj/item/attachment/gun/ballistic/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/ammo_casing) || istype(I, /obj/item/ammo_box))
		attached_gun.attackby(I, user)
	else
		return ..()

/obj/item/attachment/gun/ballistic/hand_attack_interaction(mob/user)
	var/obj/item/gun/ballistic/ballistic_gun = attached_gun
	if(ballistic_gun.magazine)
		ballistic_gun.eject_magazine(user)
		return ..()

/obj/item/attachment/gun/ballistic/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/obj/item/gun/ballistic/ballistic_gun = attached_gun
	var/gun_bolt = ballistic_gun.bolt_type
	var/count_chambered = !(gun_bolt == BOLT_TYPE_NO_BOLT || gun_bolt == BOLT_TYPE_OPEN)
	examine_list += span_notice("-The [name] has [ballistic_gun.get_ammo(count_chambered)] round\s remaining.")
	if (!attached_gun.chambered)
		examine_list += span_notice("-The [name] does not seem to have a round chambered.")
	if (attached_gun.bolt_locked)
		examine_list += span_notice("-The [name]'s [ballistic_gun.bolt_wording] is locked back and needs to be released before firing.")
	examine_list += span_notice("-You can [ballistic_gun.bolt_wording] [src] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")
	return examine_list

/obj/item/gun/ballistic/shotgun/underbarrel
	bad_type = /obj/item/gun/ballistic/shotgun/underbarrel
	name = "underbarrel ballistic gun"
	desc = "You shouldnt be seeing this."
	semi_auto = FALSE
	casing_ejector = TRUE
	gunslinger_recoil_bonus = 0
	default_ammo_type  = /obj/item/ammo_box/magazine/internal/shot/underbarrel
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/underbarrel,
	)
	wear_rate = 0

/obj/item/attachment/gun/ballistic/shotgun
	name = "underbarrel shotgun"
	desc = "A two shot pump underbarrel shotgun for warding off anyone who gets too close for comfort."
	underbarrel_prefix = "sg_"
	weapon_type = /obj/item/gun/ballistic/shotgun/underbarrel

/obj/item/attachment/gun/ballistic/launcher
	name = "underbarrel 40mm grenade launcher"
	desc = "A single shot 40mm underbarel grenade launcher. A compact way to deliver a big boom."
	underbarrel_prefix = "launcher_"
	icon_state = "glauncher"
	weapon_type = /obj/item/gun/ballistic/shotgun/underbarrel/grenadelauncher

/obj/item/gun/ballistic/shotgun/underbarrel/grenadelauncher
	bad_type = /obj/item/gun/ballistic/shotgun/underbarrel/grenadelauncher
	name = "underbarrel grenade launcher"
	fire_sound = 'sound/weapons/gun/general/grenade_launch.ogg'
	always_chambers = TRUE
	default_ammo_type  = /obj/item/ammo_box/magazine/internal/grenadelauncher
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/grenadelauncher
	)

/obj/item/attachment/gun/ballistic/hognose
	name = "PC-22 \"Hognose\""
	desc = "A compact underbarrel pistol chambered in 22lr. Holds eight rounds."
	icon_state = "hognose"
	weapon_type = /obj/item/gun/ballistic/automatic/pistol/himehabu/underbarrel
	allow_hand_interaction = TRUE

/obj/item/gun/ballistic/automatic/pistol/himehabu/underbarrel
	name = "PC-22 \"Hognose\""
	desc = "You shouldn't be seeing this."
	default_ammo_type = /obj/item/ammo_box/magazine/m22lr_himehabu/hognose
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m22lr_himehabu/hognose,
	)
	wear_rate = 0

/obj/item/ammo_box/magazine/m22lr_himehabu/hognose
	name = "Hognose magazine (.22 LR)"
	max_ammo = 8

/obj/item/ammo_box/magazine/m22lr_himehabu/hognose/empty
	start_empty = TRUE

*/
