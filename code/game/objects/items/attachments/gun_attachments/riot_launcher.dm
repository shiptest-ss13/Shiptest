/obj/item/attachment/gun/riot
	name = "underbarrel riot grenade launcher"
	desc = "A multipurpose underbarrel riot grenade launcher, typically issued to law enforcement. Loads any tradionally handthrown grenade. Warranty is voided should a lethal grenade be loaded."
	weapon_type = /obj/item/gun/grenadelauncher

/obj/item/attachment/gun/riot/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	if(toggled)
		if(istype(attack_item, /obj/item/grenade))
			attached_gun.attackby(attack_item, user)

/obj/item/attachment/gun/riot/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/grenade))
		attached_gun.attackby(I, user)
	else
		return ..()


/obj/item/attachment/gun/riot/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/obj/item/gun/grenadelauncher/launcher = attached_gun
	if(launcher.grenades.len)
		examine_list += "The [name] is loaded with a grenade."
