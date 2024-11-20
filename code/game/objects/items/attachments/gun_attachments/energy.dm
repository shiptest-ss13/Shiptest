/obj/item/attachment/gun/energy
	name = "underbarrel e-gun"
	desc = "Pew pew laser beam. You probably shouldnt be seeing this."
	icon_state = "energy"
	weapon_type = /obj/item/gun/energy/e_gun
	var/automatic_charge_overlays = TRUE

/obj/item/attachment/gun/energy/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stock_parts/cell/gun))
		attached_gun.attackby(I, user)
		update_appearance()
	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		attached_gun.screwdriver_act(user,I)
		update_appearance()
	else
		return ..()

/obj/item/attachment/gun/energy/on_unique_action(obj/item/gun/gun, mob/user)
	. = ..()
	update_appearance()

/obj/item/attachment/gun/energy/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	. = ..()
	update_appearance()

// /obj/item/attachment/gun/energy/update_icon_state()
// 	var/obj/item/gun/energy/egun = attached_gun
// 	if(initial(item_state))
// 		return ..()
// 	var/ratio = egun.get_charge_ratio()
// 	var/new_item_state = ""
// 	new_item_state = initial(icon_state)
// 	if(modifystate)
// 		var/obj/item/ammo_casing/energy/shot = egun.ammo_type[egun.select]
// 		new_item_state += "[shot.select_name]"
// 	new_item_state += "[ratio]"
// 	item_state = new_item_state
// 	return ..()

/obj/item/attachment/gun/energy/update_overlays()
	. = ..()
	var/obj/item/gun/energy/egun = attached_gun
	if(!automatic_charge_overlays || QDELETED(src))
		return
	var/overlay_icon_state = "[icon_state]_charge"
	var/obj/item/ammo_casing/energy/shot = egun.ammo_type[egun.modifystate ? egun.select : 1]
	var/ratio = egun.get_charge_ratio()
	if(egun.cell)
		. += "[icon_state]_cell"
		if(ratio == 0)
			. += "[icon_state]_cellempty"
	if(ratio == 0)
		if(egun.modifystate)
			. += "[icon_state]_[shot.select_name]"
		. += "[icon_state]_empty"
	else
		if(!egun.shaded_charge)
			if(egun.modifystate)
				. += "[icon_state]_[shot.select_name]"
				overlay_icon_state += "_[shot.select_name]"
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i = ratio, i >= 1, i--)
				charge_overlay.pixel_x = pixel_shift_x * (i - 1)
				charge_overlay.pixel_y = pixel_shift_x * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			if(egun.modifystate)
				. += "[icon_state]_charge[ratio]_[shot.select_name]"
			else
				. += "[icon_state]_charge[ratio]"


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
	return examine_list

/obj/item/attachment/gun/energy/get_cell()
	return attached_gun.cell

/obj/item/attachment/gun/energy/e_gun
	name = "underbarrel energy gun"
	desc = "A compact underbarrel energy gun. The reduction in size makes it less power effiecent per shot than the standard model."
	weapon_type = /obj/item/gun/energy/e_gun/underbarrel

/obj/item/gun/energy/e_gun/underbarrel
	name = "underbarrel energy gun"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/underbarrel, /obj/item/ammo_casing/energy/laser/underbarrel)
	spawn_no_ammo = TRUE

