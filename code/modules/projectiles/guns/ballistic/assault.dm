/obj/item/gun/ballistic/automatic/assault
	burst_size = 1
	actions_types = list()
	wield_delay = 0.7 SECONDS
	wield_slowdown = 0.6

	fire_delay = 1

	load_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'

	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'
	spread_unwielded = 20

/obj/item/gun/ballistic/automatic/assault/ak47
	name = "\improper SVG-67"
	desc = "A Frontier-built assault rifle descended from a pattern of unknown provenance. Its low cost, ease of maintenance, and powerful 7.62x39mm cartridge make it a popular choice among a wide variety of outlaws."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/ak47.ogg'

	rack_sound = 'sound/weapons/gun/rifle/ak47_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/ak47_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ak47_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ak47_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ak47_unload.ogg'

	icon_state = "ak47"
	item_state = "ak47"
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/ak47
	spread = 0
	wield_delay = 0.7 SECONDS

/obj/item/gun/ballistic/automatic/assault/ak47/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assault/ak47/nt
	name = "\improper NT-SVG"
	desc = "An even cheaper version of the SVG-67, rechambered for the lightweight 4.6x30mm PDW cartridge. The flimsy folding stock and light construction make for a highly-portable rifle that lacks accuracy and power."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ak47_nt"
	item_state = "ak47_nt"
	mag_type = /obj/item/ammo_box/magazine/aknt
	var/folded = FALSE
	var/unfolded_spread = 2
	var/unfolded_item_state = "ak47_nt"
	var/folded_spread = 20
	var/folded_item_state = "ak47_nt_stockless"

/obj/item/gun/ballistic/automatic/assault/ak47/nt/CtrlClick(mob/user)
	. = ..()
	if((!ishuman(user) || user.stat))
		return
	to_chat(user, "<span class='notice'>You start to [folded ? "unfold" : "fold"] the stock on the [src].</span>")
	if(do_after(user, 10, target = src))
		fold(user)
		user.update_inv_back()
		user.update_inv_hands()
		user.update_inv_s_store()

/obj/item/gun/ballistic/automatic/assault/ak47/nt/proc/fold(mob/user)
	if(folded)
		to_chat(user, "<span class='notice'>You unfold the stock on the [src].</span>")
		spread = unfolded_spread
		item_state = unfolded_item_state
		w_class = WEIGHT_CLASS_BULKY
	else
		to_chat(user, "<span class='notice'>You fold the stock on the [src].</span>")
		spread = folded_spread
		item_state = folded_item_state
		w_class = WEIGHT_CLASS_NORMAL

	folded = !folded
	playsound(src.loc, 'sound/weapons/empty.ogg', 100, 1)
	update_appearance()

/obj/item/gun/ballistic/automatic/assault/ak47/nt/update_overlays()
	. = ..()
	var/mutable_appearance/stock
	if(!folded)
		stock = mutable_appearance(icon, "ak47_nt_stock")
	else
		stock = mutable_appearance(icon, null)
	. += stock

/obj/item/gun/ballistic/automatic/assault/ak47/inteq
	name = "\improper SkM-24"
	desc = "An antique assault rifle seized from Frontiersmen armories then extensively modified to IRMG standards. Chambered in 7.62x39mm."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/akm.ogg'
	icon_state = "akm"
	item_state = "akm"
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'

/obj/item/gun/ballistic/automatic/assault/p16
	name = "\improper P-16"
	desc = "An assault rifle pattern from Sol, existing before the Night of Fire. A favorite of professional mercenaries and well-heeled pirates. Chambered in 5.56mm."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/m16.ogg'
	icon_state = "p16"
	item_state = "p16"
	mag_display = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/p16
	spread = 2
	wield_delay = 0.5 SECONDS
	rack_sound = 'sound/weapons/gun/rifle/m16_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/m16_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/m16_unload.ogg'

/obj/item/gun/ballistic/automatic/assault/p16/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assault/p16/minutemen
	name = "\improper CM-16"
	desc = "The standard-issue rifle of the Colonial Minutemen and an extensively modified reproduction of the P-16. Chambered in 5.56mm."
	icon_state = "cm16"
	item_state = "cm16"

/obj/item/gun/ballistic/automatic/assault/ar
	name = "\improper NT-ARG 'Boarder'"
	desc = "A burst-fire 5.56mm carbine occasionally found in the hands of Nanotrasen marines."
	fire_sound = 'sound/weapons/gun/rifle/shot_alt2.ogg'
	icon_state = "arg"
	item_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/p16
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1

/obj/item/gun/ballistic/automatic/assault/ar/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assault/swiss_cheese
	name = "\improper Swiss Cheese"
	desc = "An ancient longarm famous for its boxy, modular design. The DMA on this unit is, sadly, broken. Uses 5.56mm ammunition for Matter mode."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/swiss.ogg'
	icon_state = "swiss"
	item_state = "swiss"
	mag_display = TRUE
	empty_indicator = TRUE
	burst_size = 3
	fire_delay = 1.5
	spread = 8
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/swiss
	actions_types = list(/datum/action/item_action/toggle_firemode)
	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = 8
	spread_unwielded = 15

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.65 SECONDS)

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		to_chat(user, "<span class='danger'>You hear a strange sound from the DMA unit. It doesn't appear to be operational.</span>")
		return
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to Hybrid.</span>")
		if(2)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd Matter.</span>")

	playsound(user, 'sound/weapons/gun/general/selector.ogg', 100, TRUE)
	update_appearance()
	for(var/datum/action/action as anything in actions)
		action.UpdateButtonIcon()

#define E40_BALLISTIC_MODE 1
#define E40_LASER_MODE 2

/obj/item/gun/ballistic/automatic/assault/e40
	name = "\improper E-40 Hybrid Rifle"
	desc = "A Hybrid Assault Rifle, best known for being having a dual ballistic and laser system. Chambered in .229 Eoehoma caseless, and uses energy for lasers."
	icon = 'icons/obj/guns/48x32guns.dmi'
	icon_state = "e40"
	item_state = "e40"
	mag_type = /obj/item/ammo_box/magazine/e40
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	var/obj/item/gun/energy/laser/e40_laser_secondary/secondary

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/laser/e40_bal.ogg'
	manufacturer = MANUFACTURER_EOEHOMA

/obj/item/gun/ballistic/automatic/assault/e40/Initialize()
	. = ..()
	secondary = new /obj/item/gun/energy/laser/e40_laser_secondary(src)
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)
	RegisterSignal(secondary, COMSIG_ATOM_UPDATE_ICON, PROC_REF(secondary_update_icon))
	SEND_SIGNAL(secondary, COMSIG_GUN_DISABLE_AUTOFIRE)
	update_appearance()

/obj/item/gun/ballistic/automatic/assault/e40/do_autofire(datum/source, atom/target, mob/living/shooter, params)
	if(select == E40_LASER_MODE)
		secondary.do_autofire(source, target, shooter, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/do_autofire_shot(datum/source, atom/target, mob/living/shooter, params)
	if(select == E40_LASER_MODE)
		secondary.do_autofire_shot(source, target, shooter, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(select == E40_LASER_MODE)
		secondary.process_fire(target, user, message, params, zone_override, bonus_spread)
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/can_shoot()
	if(select == E40_LASER_MODE)
		return secondary.can_shoot()
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/afterattack(atom/target, mob/living/user, flag, params)
	if(select == E40_LASER_MODE)
		secondary.afterattack(target, user, flag, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/assault/e40/attackby(obj/item/attack_obj, mob/user, params)
	if(istype(attack_obj, /obj/item/stock_parts/cell/gun))
		secondary.attackby(attack_obj, user, params)
	if(istype(attack_obj, /obj/item/screwdriver))
		secondary.screwdriver_act(user, attack_obj,)
	else
		..()

/obj/item/gun/ballistic/automatic/assault/e40/can_shoot()
	if(select == E40_LASER_MODE)
		return secondary.can_shoot()
	return ..()

/obj/item/gun/ballistic/automatic/assault/e40/proc/secondary_update_icon()
	update_icon()

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


/obj/item/gun/ballistic/automatic/assault/e40/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(NONE)
			select = E40_BALLISTIC_MODE
			to_chat(user, "<span class='notice'>You switch to full automatic ballistic.</span>")
		if(E40_BALLISTIC_MODE)
			select = E40_LASER_MODE
			to_chat(user, "<span class='notice'>You switch to full auto laser.</span>")
			SEND_SIGNAL(src, COMSIG_GUN_DISABLE_AUTOFIRE)
			SEND_SIGNAL(secondary, COMSIG_GUN_ENABLE_AUTOFIRE)
		if(E40_LASER_MODE)
			select = E40_BALLISTIC_MODE
			to_chat(user, "<span class='notice'>You switch to full automatic ballistic.</span>")
			SEND_SIGNAL(src, COMSIG_GUN_ENABLE_AUTOFIRE)
			SEND_SIGNAL(secondary, COMSIG_GUN_DISABLE_AUTOFIRE)
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_icon()
	return



/obj/item/gun/ballistic/automatic/assault/e40/toggle_safety(mob/user, silent=FALSE)
	. = ..()
	secondary.toggle_safety(user, silent=TRUE)

//laser

/obj/item/gun/energy/laser/e40_laser_secondary
	name = "secondary e40 laser gun"
	desc = "The laser component of a E-40 Hybrid Rifle. You probably shouldn't see this."
	fire_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault)
	fire_delay = 2
