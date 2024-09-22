/obj/item/attachment/gun/ballistic
	name = "ballistic underbarrel gun"
	desc = "A ballistic underbarrel gun. It shoots bullets. Or something."

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

