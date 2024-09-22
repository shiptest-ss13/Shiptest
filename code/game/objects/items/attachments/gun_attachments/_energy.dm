/obj/item/attachment/gun/energy
	name = "underbarrel minature energy gun"
	desc = "A compact energy gun designed to be mounted on the underside of another firearm for quick access."
	weapon_type = /obj/item/gun/energy/e_gun/mini

/obj/item/attachment/gun/energy/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	. = ..()
	if(toggled)
		if(attack_item.tool_behaviour == TOOL_SCREWDRIVER)
			attached_gun.screwdriver_act(user,attack_item)

/obj/item/attachment/gun/energy/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	var/obj/item/ammo_casing/energy/shot = attached_gun.ammo_type[attached_gun.select]
	var/obj/item/stock_parts/cell/gun/gun_cell = get_cell()
	if(attached_gun.ammo_type.len > 1)
		examine_list += span_notice("- You can switch firemodes on the [name] by pressing the <b>unique action</b> key. By default, this is <b>space</b>")
	if(attached_gun.cell)
		examine_list += span_notice("- \The [name]'s cell has [gun_cell.percent()]% charge remaining.")
		examine_list += span_notice("- \The [name] has [round(gun_cell.charge/shot.e_cost)] shots remaining on <b>[shot.select_name]</b> mode.")
	else
		. += span_notice("- \The [name] doesn't seem to have a cell!")
	//return

/obj/item/attachment/gun/energy/get_cell()
	return attached_gun.cell
