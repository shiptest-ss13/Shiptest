// SOLARIAN GAUSS GUNS //

// These guns use small amounts of power as a replacement for their wear mechanic.
// Penalties to the projectiles are applied once the cell drops below half charge.

/obj/item/gun/ballistic/sol_gauss
	name = "evil gauss rifle"
	desc = "I'm evil as fuuuuuuuuuck."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	icon_state = "model-e-old" // blatantly incorrect
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	burst_size = 1
	fire_delay = 0.3 SECONDS
	spread = 0
	show_magazine_on_sprite = TRUE
	empty_indicator = FALSE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	charge_sections = 4
	ammo_x_offset = 2
	manufacturer = MANUFACTURER_NONE
	light_range = 0 // no explosion, no light
	bad_type = /obj/item/gun/ballistic/sol_gauss
	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	spread = 0
	spread_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = HEAVY_RIFLE_SLOWDOWN
	wield_delay = 1 SECONDS
	fire_select_icon_state_prefix = "pellet_"
	wear_rate = 0 // magnetically accelerated, very little if any wear to the gun

	autowiki_hidden = TRUE

	var/default_cell_type = /obj/item/stock_parts/cell/gun/solgov
	var/allowed_cell_types = list(/obj/item/stock_parts/cell/gun/solgov)
	var/obj/item/stock_parts/cell/gun/cell // type of cell we use
	var/internal_cell = FALSE // can we remove the cell

/obj/item/gun/ballistic/sol_gauss/Initialize()
	. = ..()
	if(default_cell_type)
		cell = new default_cell_type(src)
	update_appearance()

/obj/item/gun/ballistic/sol_gauss/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [name]'s cell has <b>[cell.percent()]%</b> charge remaining.")
	else
		. += span_notice("[src] doesn't seem to have a cell!")
	if(internal_magazine)
		. += span_notice("You can remove the cell by holding the gun and clicking it with your other hand.")
	else
		. += span_notice("You can remove the cell by holding the gun and clicking it with your other hand while the magazine is out.")

/obj/item/gun/ballistic/sol_gauss/can_shoot()
	if(QDELETED(cell))
		return FALSE

	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(!shot)
		return FALSE
	if(cell.charge < shot.energy_cost * burst_size)
		return FALSE
	return ..()

/obj/item/gun/ballistic/sol_gauss/before_firing(atom/target, mob/user)
	var/obj/item/ammo_casing/caseless/gauss/shot = chambered
	if(shot.energy_cost)
		cell.use(shot.energy_cost)
	return ..()

/obj/item/gun/ballistic/sol_gauss/get_cell()
	return cell

//the things below were taken from energy gun code. blame whoever coded this, not me
/obj/item/gun/ballistic/sol_gauss/attackby(obj/item/A, mob/user, params)
	if(..())
		return FALSE
	if (!internal_cell && (A.type in allowed_cell_types))
		var/obj/item/stock_parts/cell/gun/C = A
		if (!cell)
			insert_cell(user, C)

/obj/item/gun/ballistic/sol_gauss/proc/insert_cell(mob/user, obj/item/stock_parts/cell/gun/C)
	if(user.transferItemToLoc(C, src))
		cell = C
		to_chat(user, span_notice("You load the [C] into \the [src]."))
		playsound(src, load_sound, load_sound_volume, load_sound_vary)
		update_appearance()
		return TRUE
	else
		to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
		return FALSE

/obj/item/gun/ballistic/sol_gauss/proc/eject_cell(mob/user, obj/item/stock_parts/cell/gun/tac_load = null)
	playsound(src, load_sound, load_sound_volume, load_sound_vary)
	cell.forceMove(drop_location())
	var/obj/item/stock_parts/cell/gun/old_cell = cell
	cell = null
	user.put_in_hands(old_cell)
	old_cell.update_appearance()
	to_chat(user, span_notice("You pull the cell out of \the [src]."))
	update_appearance()

/obj/item/gun/ballistic/sol_gauss/attack_hand(mob/living/user)
	if(user.is_holding(src) && loc == user)
		if(!magazine || internal_magazine && cell && !internal_cell) // yank cell out if mag is already out
			eject_cell(user)
			return
	return ..()

/obj/item/gun/ballistic/sol_gauss/update_overlays()
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

/obj/item/gun/ballistic/sol_gauss/proc/get_charge_ratio()
	if(!cell)
		return FALSE
	return CEILING(clamp(cell.charge / cell.maxcharge, 0, 1) * charge_sections, 1)// Sets the ratio to 0 if the gun doesn't have enough charge to fire, or if its power cell is removed.

// If we are below half charge, we apply penalties to our projectile.
/obj/item/gun/ballistic/sol_gauss/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(chambered && chambered.BB && cell.charge < cell.maxcharge / 2)
		var/obj/projectile/our_pellet = chambered.BB
		var/penalty = 1 - (cell.charge / (cell.maxcharge / 2))
		our_pellet.speed *= 1 + penalty
		our_pellet.damage *= 0.5 + penalty / 2
	return ..()
