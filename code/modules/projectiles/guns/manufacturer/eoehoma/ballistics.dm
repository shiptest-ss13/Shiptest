/obj/item/gun/ballistic/automatic/assault/e40
	name = "\improper E-40 Hybrid Rifle"
	desc = "A Hybrid Assault Rifle, best known for being having a dual ballistic/laser system along with an advanced ammo counter. Once an icon for bounty hunters, age has broken most down, so these end up in collector's hands or as shoddy Frontiersmen laser SMG conversions when in their inheritted stockpiles. But if one were to find one in working condition, it would be just as formidable as back then. Chambered in .299 Eoehoma caseless, and uses energy for lasers."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e40"
	item_state = "e40"
	default_ammo_type = /obj/item/ammo_box/magazine/e40
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/e40,
	)
	var/obj/item/gun/energy/laser/e40_laser_secondary/secondary
	fire_select_icon_state_prefix = "e40_"

	fire_delay = 0.1 SECONDS
	recoil_unwielded = 3

	gun_firenames = list(FIREMODE_FULLAUTO = "full auto ballistic", FIREMODE_OTHER = "full auto laser")
	gun_firemodes = list(FIREMODE_FULLAUTO, FIREMODE_OTHER)
	default_firemode = FIREMODE_OTHER

	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	show_magazine_on_sprite = TRUE
	ammo_counter = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/laser/e40_bal.ogg'
	manufacturer = MANUFACTURER_EOEHOMA

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 45,
			"y" = 20,
		),
	)

/obj/item/gun/ballistic/automatic/assault/e40/Initialize()
	. = ..()
	secondary = new /obj/item/gun/energy/laser/e40_laser_secondary(src)
	RegisterSignal(secondary, COMSIG_ATOM_UPDATE_ICON, PROC_REF(secondary_update_icon))
	SEND_SIGNAL(secondary, COMSIG_GUN_DISABLE_AUTOFIRE)
	update_appearance()

/obj/item/gun/ballistic/automatic/assault/e40/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud/eoehoma) // at long last... the ammo counter on the side of the sprite is functional...

/obj/item/gun/ballistic/automatic/assault/e40/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.do_autofire(source, target, shooter, params)

/obj/item/gun/ballistic/automatic/assault/e40/do_autofire_shot(datum/source, atom/target, mob/living/shooter, params)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.do_autofire_shot(source, target, shooter, params)

/obj/item/gun/ballistic/automatic/assault/e40/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		if(!secondary.latch_closed && secondary.cell && prob(65))
			to_chat(user, span_warning("[src]'s cell falls out!"))
			secondary.eject_cell()
		return ..()
	return secondary.process_fire(target, user, message, params, zone_override, bonus_spread)

/obj/item/gun/ballistic/automatic/assault/e40/can_shoot()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.can_shoot()

/obj/item/gun/ballistic/automatic/assault/e40/afterattack(atom/target, mob/living/user, flag, params)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.afterattack(target, user, flag, params)

/obj/item/gun/ballistic/automatic/assault/e40/attackby(obj/item/attack_obj, mob/user, params)
	if(istype(attack_obj, /obj/item/stock_parts/cell/gun))
		return secondary.attackby(attack_obj, user, params)
	return ..()

/obj/item/gun/ballistic/automatic/assault/e40/attack_hand(mob/user)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode == FIREMODE_OTHER && loc == user && user.is_holding(src) && secondary.cell && !secondary.latch_closed)
		secondary.eject_cell(user)
		return
	if(current_firemode == FIREMODE_OTHER && loc == user && user.is_holding(src) && secondary.cell && secondary.latch_closed)
		to_chat(user, span_warning("The cell retainment clip is latched!"))
		return
	return ..()

/obj/item/gun/ballistic/automatic/assault/e40/unique_action(mob/living/user)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode == FIREMODE_OTHER)
		if(secondary.latch_closed)
			to_chat(user, span_notice("You start to unlatch the [src]'s power cell retainment clip..."))
			if(do_after(user, secondary.latch_toggle_delay, src, IGNORE_USER_LOC_CHANGE))
				to_chat(user, span_notice("You unlatch [src]'s power cell retainment clip " + span_red("OPEN") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_play.ogg', 50, FALSE)
				secondary.tac_reloads = TRUE
				secondary.latch_closed = FALSE
				update_appearance()
				return
		else
			to_chat(user, span_warning("You start to latch the [src]'s power cell retainment clip..."))
			if (do_after(user, secondary.latch_toggle_delay, src, IGNORE_USER_LOC_CHANGE))
				to_chat(user, span_notice("You latch [src]'s power cell retainment clip " + span_green("CLOSED") + "."))
				playsound(src, 'sound/items/taperecorder/taperecorder_close.ogg', 50, FALSE)
				secondary.tac_reloads = FALSE
				secondary.latch_closed = TRUE
				update_appearance()
				return
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	secondary.wielded = TRUE
	INVOKE_ASYNC(src, PROC_REF(do_wield), user)

/obj/item/gun/ballistic/automatic/assault/e40/do_wield(mob/user)
	. = ..()
	secondary.wielded_fully = wielded_fully

/// triggered on unwield of two handed item
/obj/item/gun/ballistic/automatic/assault/e40/on_unwield(obj/item/source, mob/user)
	. = ..()
	secondary.wielded_fully = FALSE
	secondary.wielded = FALSE


/obj/item/gun/ballistic/automatic/assault/e40/proc/secondary_update_icon()
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/automatic/assault/e40/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	secondary.pre_fire(target, user, message, flag, params, zone_override, bonus_spread)


/obj/item/gun/ballistic/automatic/assault/e40/get_cell()
	return secondary.get_cell()

/obj/item/gun/ballistic/automatic/assault/e40/update_overlays()
	. = ..()
	//handle laser gunn overlays
	if(!secondary)
		return
	var/ratio = secondary.get_charge_ratio()
	if(ratio == 0)
		. += "[icon_state]_chargeempty"
	else
		. += "[icon_state]_charge[ratio]"
	if(secondary.cell)
		. += "[icon_state]_cell"
	if(ismob(loc))
		var/mutable_appearance/latch_overlay
		latch_overlay = mutable_appearance('icons/obj/guns/cell_latch.dmi')
		if(secondary.latch_closed)
			if(secondary.cell)
				latch_overlay.icon_state = "latch-on-full"
			else
				latch_overlay.icon_state = "latch-on-empty"
		else
			if(secondary.cell)
				latch_overlay.icon_state = "latch-off-full"
			else
				latch_overlay.icon_state = "latch-off-empty"
		. += latch_overlay


/obj/item/gun/ballistic/automatic/assault/e40/toggle_safety(mob/user, silent=FALSE)
	. = ..()
	secondary.safety = safety

/obj/item/gun/ballistic/automatic/assault/e40/fire_select(mob/living/carbon/human/user)
	. = ..()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode == FIREMODE_OTHER)
		SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
		SEND_SIGNAL(src, COMSIG_GUN_SET_AUTOFIRE_SPEED, secondary.fire_delay)
	else
		SEND_SIGNAL(src, COMSIG_GUN_SET_AUTOFIRE_SPEED, fire_delay)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/ballistic/automatic/assault/e40/examine(mob/user)
	. = ..()
	if(!secondary.internal_magazine)
		. += "The cell retainment latch is [secondary.latch_closed ? span_green("CLOSED") : span_red("OPEN")]. Use the Unique Action Key to toggle the latch while on laser mode. By default, this is <b>space</b>."
	var/obj/item/ammo_casing/energy/shot = secondary.ammo_type[select]
	if(secondary.cell)
		. += "\The [name]'s cell has [secondary.cell.percent()]% charge remaining."
		. += "\The [name] has [round(secondary.cell.charge/shot.e_cost)] shots remaining on <b>[shot.select_name]</b> mode."
	else
		. += span_notice("\The [name] doesn't seem to have a cell!")

/obj/item/ammo_box/magazine/e40
	name = "E-40 magazine (.299 Eoehoma caseless)"
	icon_state = "e40_mag-1"
	base_icon_state = "e40_mag"
	ammo_type = /obj/item/ammo_casing/caseless/c299
	caliber = ".299 caseless"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

//laser

/obj/item/gun/energy/laser/e40_laser_secondary
	name = "secondary e40 laser gun"
	desc = "The laser component of a E-40 Hybrid Rifle. You probably shouldn't see this. If you can though, you should probably know lorewise, this is primary, the ballistic compontent in universe is secondary. Unfortunately, we cannot simulate this, So codewise this is secondary."
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault)
	fire_delay = 0.2 SECONDS
	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO
	latch_toggle_delay = 0.6 SECONDS
	valid_attachments = list()

	spread_unwielded = 20
