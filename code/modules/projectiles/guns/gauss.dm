/obj/item/gun/ballistic/automatic/gauss
	name = "prototype gauss rifle"
	desc = "A NT experimental rifle with high capacity. Useful for putting down crowds. Chambered in ferromagnetic pellets."
	icon_state = "gauss"
	item_state = "arg"
	force = 10
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/mmag
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	load_empty_sound = 'sound/weapons/gun/gauss/mg_reload.ogg'
	can_suppress = FALSE
	burst_size = 1
	actions_types = null
	fire_delay = 3
	spread = 0
	recoil = 0.1
	casing_ejector = FALSE
	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	var/obj/item/stock_parts/cell/cell
	var/cell_type = /obj/item/stock_parts/cell/gun
	var/charge_sections = 4
	ammo_x_offset = 2

	var/shaded_charge = FALSE //if this gun uses a stateful charge bar for more detail
	var/automatic_charge_overlays = TRUE	//Do we handle overlays with base update_icon()?

	var/internal_cell = FALSE ///if the gun's cell cannot be replaced
	var/small_gun = FALSE ///if the gun is small and can only fit the small gun cell
	var/big_gun = FALSE ///if the gun is big and can fit the comically large gun cell
	var/unscrewing_time = 20 ///Time it takes to unscrew the cell
	var/sound_volume = 40 //Volume of loading/unloading cell sounds


/obj/item/gun/ballistic/automatic/gauss/Initialize()
	. = ..()
	if(cell_type)
		cell = new cell_type(src)
	else
		cell = new(src)
	update_icon()

/obj/item/gun/ballistic/automatic/gauss/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[src]'s cell is [round(cell.charge / cell.maxcharge, 0.1) * 100]% full.</span>"
	else
		. += "<span class='notice'>[src] doesn't seem to have a cell!</span>"

/obj/item/gun/ballistic/automatic/gauss/can_shoot()
	if(QDELETED(cell))
		return 0

	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(!shot)
		return 0
	if(cell.charge < shot.energy_cost * burst_size)
		return 0
	. = ..()

/obj/item/gun/ballistic/automatic/gauss/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	cell.use(shot.energy_cost)
	. = ..()

/obj/item/gun/ballistic/automatic/gauss/get_cell()
	return cell

/obj/item/gun/ballistic/automatic/gauss/nopin
	pin = null
	spawnwithmagazine = FALSE

//the things below were taken from energy gun code. blame whoever coded this, not me
/obj/item/gun/ballistic/automatic/gauss/attackby(obj/item/A, mob/user, params)
	if (!cell && istype(A, /obj/item/stock_parts/cell/gun))
		var/obj/item/stock_parts/cell/gun/C = A
		if (!cell)
			insert_cell(user, C)
	return ..()

/obj/item/gun/ballistic/automatic/gauss/proc/insert_cell(mob/user, obj/item/stock_parts/cell/gun/C)
	if(small_gun && !istype(C, /obj/item/stock_parts/cell/gun/mini))
		to_chat(user, "<span class='warning'>\The [C] doesn't seem to fit into \the [src]...</span>")
		return FALSE
	if(!big_gun && istype(C, /obj/item/stock_parts/cell/gun/large))
		to_chat(user, "<span class='warning'>\The [C] doesn't seem to fit into \the [src]...</span>")
		return FALSE
	if(user.transferItemToLoc(C, src))
		cell = C
		to_chat(user, "<span class='notice'>You load the [C] into \the [src].</span>")
		playsound(src, load_sound, sound_volume, load_sound_vary)
		update_icon()
		return TRUE
	else
		to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")
		return FALSE

/obj/item/gun/ballistic/automatic/gauss/proc/eject_cell(mob/user, obj/item/stock_parts/cell/gun/tac_load = null)
	playsound(src, load_sound, sound_volume, load_sound_vary)
	cell.forceMove(drop_location())
	var/obj/item/stock_parts/cell/gun/old_cell = cell
	cell = null
	user.put_in_hands(old_cell)
	old_cell.update_icon()
	to_chat(user, "<span class='notice'>You pull the cell out of \the [src].</span>")
	update_icon()

/obj/item/gun/ballistic/automatic/gauss/screwdriver_act(mob/living/user, obj/item/I)
	if(cell && !bayonet && (!gun_light || !can_flashlight))
		to_chat(user, "<span class='notice'>You begin unscrewing and pulling out the cell...</span>")
		if(I.use_tool(src, user, unscrewing_time, volume=100))
			to_chat(user, "<span class='notice'>You remove the power cell.</span>")
			eject_cell(user)
	return ..()

/obj/item/gun/ballistic/automatic/gauss/update_overlays()
	. = ..()
	if(!automatic_charge_overlays)
		return
	var/overlay_icon_state = "[icon_state]_charge"
	var/ratio = get_charge_ratio()
	if(ratio == 0)
		. += "[icon_state]_cellempty"
	else
		if(!shaded_charge)
			var/mutable_appearance/charge_overlay = mutable_appearance(icon, overlay_icon_state)
			for(var/i = ratio, i >= 1, i--)
				charge_overlay.pixel_x = ammo_x_offset * (i - 1)
				charge_overlay.pixel_y = ammo_y_offset * (i - 1)
				. += new /mutable_appearance(charge_overlay)
		else
			. += "[icon_state]_charge[ratio]"

/obj/item/gun/ballistic/automatic/gauss/proc/get_charge_ratio()
	if(!cell)
		return 0
	return CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1)// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.
