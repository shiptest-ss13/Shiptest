/obj/item/gun/ballistic/automatic/powered
	mag_type = /obj/item/ammo_box/magazine/gauss
	can_suppress = FALSE

	var/obj/item/stock_parts/cell/cell
	var/cell_type = /obj/item/stock_parts/cell/gun
	var/charge_sections = 3
	var/empty_battery_sound = FALSE // play empty alarm if no battery

	var/shaded_charge = FALSE //if this gun uses a stateful charge bar for more detail
	var/automatic_charge_overlays = TRUE	//Do we handle overlays with base update_appearance()?

	var/internal_cell = FALSE ///if the gun's cell cannot be replaced
	var/small_gun = FALSE ///if the gun is small and can only fit the small gun cell
	var/big_gun = FALSE ///if the gun is big and can fit the comically large gun cell
	var/unscrewing_time = 2 SECONDS ///Time it takes to unscrew the cell
	var/sound_volume = 40 //Volume of loading/unloading cell sounds


/obj/item/gun/ballistic/automatic/powered/Initialize()
	. = ..()
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/powered/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[src]'s cell is [round(cell.charge / cell.maxcharge, 0.1) * 100]% full.</span>"
	else
		. += "<span class='notice'>[src] doesn't seem to have a cell!</span>"

/obj/item/gun/ballistic/automatic/powered/can_shoot()
	if(QDELETED(cell))
		return FALSE

	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(!shot)
		return FALSE
	if(cell.charge < shot.energy_cost * burst_size)
		return FALSE
	return ..()

/obj/item/gun/ballistic/automatic/powered/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(shot?.energy_cost)
		cell.use(shot.energy_cost)
	return ..()

/obj/item/gun/ballistic/automatic/powered/get_cell()
	return cell

/obj/item/gun/ballistic/automatic/powered/nopin
	pin = null
	spawnwithmagazine = FALSE

//the things below were taken from energy gun code. blame whoever coded this, not me
/obj/item/gun/ballistic/automatic/powered/attackby(obj/item/A, mob/user, params)
	if (!internal_cell && istype(A, /obj/item/stock_parts/cell/gun))
		var/obj/item/stock_parts/cell/gun/C = A
		if (!cell)
			insert_cell(user, C)
	return ..()

/obj/item/gun/ballistic/automatic/powered/proc/insert_cell(mob/user, obj/item/stock_parts/cell/gun/C)
	if(small_gun && !istype(C, /obj/item/stock_parts/cell/gun/mini))
		to_chat(user, "<span class='warning'>[C] doesn't seem to fit into [src]...</span>")
		return FALSE
	if(!big_gun && istype(C, /obj/item/stock_parts/cell/gun/large))
		to_chat(user, "<span class='warning'>[C] doesn't seem to fit into [src]...</span>")
		return FALSE
	if(user.transferItemToLoc(C, src))
		cell = C
		to_chat(user, "<span class='notice'>You load [C] into [src].</span>")
		playsound(src, load_sound, sound_volume, load_sound_vary)
		update_appearance()
		return TRUE
	else
		to_chat(user, "<span class='warning'>You cannot seem to get [src] out of your hands!</span>")
		return FALSE

/obj/item/gun/ballistic/automatic/powered/proc/eject_cell(mob/user, obj/item/stock_parts/cell/gun/tac_load = null)
	playsound(src, load_sound, sound_volume, load_sound_vary)
	cell.forceMove(drop_location())
	var/obj/item/stock_parts/cell/gun/old_cell = cell
	cell = null
	user.put_in_hands(old_cell)
	old_cell.update_appearance()
	to_chat(user, "<span class='notice'>You pull the cell out of \the [src].</span>")
	update_appearance()

/obj/item/gun/ballistic/automatic/powered/screwdriver_act(mob/living/user, obj/item/I)
	if(cell && !internal_cell && !bayonet && (!gun_light || !can_flashlight))
		to_chat(user, "<span class='notice'>You begin unscrewing and pulling out the cell...</span>")
		if(I.use_tool(src, user, unscrewing_time, volume=100))
			to_chat(user, "<span class='notice'>You remove the power cell.</span>")
			eject_cell(user)
	return ..()

/obj/item/gun/ballistic/automatic/powered/update_overlays()
	. = ..()
	if(!automatic_charge_overlays)
		return
	var/overlay_icon_state = "[icon_state]_charge"
	var/charge_ratio = get_charge_ratio()
	if(cell)
		. += "[icon_state]_cell"
	if(charge_ratio == 0)
		. += "[icon_state]_cellempty"
	else
		if(!shaded_charge)
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i in 1 to charge_ratio)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			. += "[icon_state]_charge[charge_ratio]"

/obj/item/gun/ballistic/automatic/powered/proc/get_charge_ratio()
	if(!cell)
		return FALSE
	return CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1)// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.
