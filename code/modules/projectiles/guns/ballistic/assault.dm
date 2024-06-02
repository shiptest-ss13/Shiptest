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

/obj/item/gun/ballistic/automatic/assault/calculate_recoil(mob/user, recoil_bonus = 0)
	var/gunslinger_bonus = 2
	var/total_recoil = recoil_bonus
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_recoil += gunslinger_bonus
		total_recoil = clamp(total_recoil,0,INFINITY)
	return total_recoil

/obj/item/gun/ballistic/automatic/assault/calculate_spread(mob/user, bonus_spread)
	var/gunslinger_bonus = 8
	var/total_spread = bonus_spread
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_spread += gunslinger_bonus
		total_spread = clamp(total_spread,0,INFINITY)
	return total_spread

/obj/item/gun/ballistic/automatic/assault/skm
	name = "\improper SKM-24"
	desc = "An obsolete model of assault rifle once used by CLIP. Legendary for its durability and low cost, surplus rifles are commonplace on the Frontier, and the design has been widely copied. Chambered in 7.62x40mm CLIP."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/skm.ogg'

	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'

	icon_state = "skm"
	item_state = "skm"
	mag_display = TRUE
	special_mags = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	manufacturer = MANUFACTURER_IMPORT
	mag_type = /obj/item/ammo_box/magazine/skm_762_40

	spread = 1
	wield_delay = 0.7 SECONDS

/obj/item/gun/ballistic/automatic/assault/skm/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assault/skm/pirate
	name = "\improper Chopper"
	desc = "An SKM-24 in a state of shockingly poor repair: Several parts are missing and the 'grip' is improvised from scrap wood. It's a miracle it still works at all. Chambered in 7.62x40mm CLIP."

	icon_state = "skm_pirate"
	item_state = "skm_pirate"
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/ballistic/automatic/assault/skm/inteq
	name = "\improper SKM-44"
	desc = "An obsolete model of assault rifle once used by CLIP. Most of these were seized from Frontiersmen armories or purchased in CLIP, then modified to IRMG standards. Chambered in 7.62x40mm CLIP."

	icon_state = "skm_inteq"
	item_state = "skm_inteq"
	manufacturer = MANUFACTURER_INTEQ

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
	desc = "The standard-issue rifle of CLIP and an extensively modified reproduction of the P-16. Chambered in 5.56mm."
	icon_state = "cm16"
	item_state = "cm16"

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

//techinically a battle rifle, i'm putting it here for organisation sake

/obj/item/gun/ballistic/automatic/vickland //weapon designed by Apogee-dev
	name = "\improper Vickland"
	desc = "The pride of the Saint-Roumain Militia, the Vickland is a rare semi-automatic battle rifle produced by Hunter's Pride exclusively for SRM use. It is unusual in its class for its internal rotary magazine, which must be reloaded using stripper clips. Chambered in .308."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/vickland.ogg'
	icon_state = "vickland"
	item_state = "vickland"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	internal_magazine = TRUE
	mag_type = /obj/item/ammo_box/magazine/internal/vickland
	fire_sound = 'sound/weapons/gun/rifle/vickland.ogg'
	burst_size = 0
	actions_types = list()
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'

	spread_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = 0.75
