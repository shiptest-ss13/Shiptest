/*
/obj/item/attachment/gun/riot
	name = "underbarrel riot grenade launcher"
	desc = "A multipurpose underbarrel riot grenade launcher, typically issued to law enforcement. Loads any tradionally handthrown grenade. Warranty is voided should a lethal grenade be loaded."
	underbarrel_prefix = "launcher_"
	icon_state = "riotlauncher"
	weapon_type = /obj/item/gun/grenadelauncher/underbarrel

/obj/item/attachment/gun/riot/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/grenade))
		attached_gun.attackby(I, user)
	else
		return ..()

/obj/item/attachment/gun/riot/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/obj/item/gun/grenadelauncher/launcher = attached_gun
	if(launcher.grenades.len)
		examine_list += "The [name] is loaded with a grenade."
	examine_list += span_notice("-You can eject a grenade from the [src] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")
	return examine_list

/obj/item/gun/grenadelauncher/underbarrel
	name = "underbarrel riot grenade launcher"
	desc = "An even more terrible thing. Just despicable, really. You shouldn't be seeing this."
	max_grenades = 1

*/
