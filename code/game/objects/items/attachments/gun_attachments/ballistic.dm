/obj/item/attachment/gun/ballistic
	name = "ballistic underbarrel gun"
	desc = "A ballistic underbarrel gun. It shoots bullets. Or something."

/obj/item/attachment/gun/ballistic/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	if(toggled)
		if(istype(attack_item,/obj/item/ammo_casing) || istype(attack_item, /obj/item/ammo_box))
			attached_gun.attackby(attack_item, user)

/obj/item/attachment/gun/ballistic/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/ammo_casing) || istype(I, /obj/item/ammo_box))
		attached_gun.attackby(I, user)
	else
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

/obj/item/attachment/gun/ballistic/launcher
	name = "underbarrel 40mm grenade launcher"
	desc = "A break action, single shot 40mm underbarel grenade launcher. A compact way to deliver a big boom."
	weapon_type = /obj/item/gun/ballistic/revolver/grenadelauncher

/obj/item/attachment/gun/ballistic/shotgun
	name = "underbarrel shotgun"
	desc = "A single shot underbarrel shotgun for warding off anyone who gets too close for comfort."
	weapon_type = /obj/item/gun/ballistic/shotgun/doublebarrel/underbarrel

/obj/item/gun/ballistic/shotgun/doublebarrel/underbarrel
	name = "underbarrel shotgun"
	desc = "You probably shouldn't be seeing this."
	mag_type = /obj/item/ammo_box/magazine/internal/shot/underbarrel
	gun_firemodes = list(FIREMODE_SEMIAUTO)

/obj/item/attachment/gun/ballistic/shotgun/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	. = ..()
	if(!(attached_gun.bolt_locked))
		examine_list += span_notice("\The [name]'s [attached_gun.bolt_wording] is closed.")
	else
		examine_list += span_notice("\The [name]'s [attached_gun.bolt_wording] is open, and can be loaded.")
