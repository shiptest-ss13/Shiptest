/obj/item/gun/ballistic/automatic/smg
	burst_size = 1
	actions_types = list()
	fire_delay = 1
	spread = 4
	spread_unwielded = 10
	wield_slowdown = 0.35
	recoil_unwielded = 4
	w_class = WEIGHT_CLASS_BULKY

	wield_delay = 0.4 SECONDS

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

/obj/item/gun/ballistic/automatic/smg/calculate_recoil(mob/user, recoil_bonus = 0)
	var/gunslinger_bonus = 1
	var/total_recoil = recoil_bonus
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_recoil += gunslinger_bonus
		total_recoil = clamp(total_recoil,0,INFINITY)
	return total_recoil

/obj/item/gun/ballistic/automatic/smg/calculate_spread(mob/user, bonus_spread)
	var/gunslinger_bonus = 4
	var/total_spread = bonus_spread
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_spread += gunslinger_bonus
		total_spread = clamp(total_spread,0,INFINITY)
	return total_spread

/obj/item/gun/ballistic/automatic/smg/proto
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype full-auto 9mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors and a folding stock."
	icon_state = "saber"
	actions_types = list()
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	pin = null
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD

/obj/item/gun/ballistic/automatic/smg/proto/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/proto/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/c20r
	name = "\improper C-20r SMG"
	desc = "A bullpup .45 SMG designated 'C-20r.' Its buttstamp reads 'Scarborough Arms - Per falcis, per pravitas.'"
	icon_state = "c20r"
	item_state = "c20r"
	mag_type = /obj/item/ammo_box/magazine/smgm45
	can_bayonet = TRUE
	can_suppress = FALSE
	knife_x_offset = 26
	knife_y_offset = 12
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

/obj/item/gun/ballistic/automatic/smg/c20r/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/c20r/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/c20r/Initialize()
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/c20r/cobra
	name = "\improper Cobra 20"
	desc = "An older model of SMG manufactured by Scarborough Arms, a predecessor to the military C-20 series. Chambered in .45. "
	can_bayonet = FALSE
	icon_state = "cobra20"
	item_state = "cobra20"

/obj/item/gun/ballistic/automatic/smg/c20r/suns
	desc = "A bullpup .45 SMG designated 'C-20r.' Its buttstamp reads 'Scarborough Arms - Per falcis, per pravitas.' This one is painted in SUNS' colors."
	icon_state = "c20r_suns"
	item_state = "c20r_suns"

/obj/item/gun/ballistic/automatic/smg/wt550
	name = "\improper WT-550 Automatic Rifle"
	desc = "An outdated PDW, used centuries ago by Nanotrasen security elements. Uses 4.6x30mm rounds."
	icon_state = "wt550"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD
	fire_sound = 'sound/weapons/gun/smg/smg_heavy.ogg'

/obj/item/gun/ballistic/automatic/smg/wt550/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "\improper Type U3 Uzi"
	desc = "A lightweight submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	bolt_type = BOLT_TYPE_OPEN
	mag_display = TRUE

	fire_sound = 'sound/weapons/gun/smg/uzi.ogg'
	rack_sound = 'sound/weapons/gun/smg/uzi_cocked.ogg'

	load_sound = 'sound/weapons/gun/smg/uzi_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/uzi_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/uzi_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/uzi_unload.ogg'

	spread = 4
	spread_unwielded = 8
	wield_slowdown = 0.25
	wield_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/smg/mini_uzi/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/obj/item/gun/ballistic/automatic/smg/vector
	name = "\improper Vector carbine"
	desc = "A police carbine based on a pre-Night of Fire SMG design. Most of the complex workings have been removed for reliability. Chambered in 9mm."
	icon_state = "vector"
	item_state = "vector"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

/obj/item/gun/ballistic/automatic/smg/vector/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon_state = "m90"
	item_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m556
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel
	burst_size = 3
	fire_delay = 2
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/rifle/shot_alt.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

	spread = 1
	spread_unwielded = 8
	wield_slowdown = 0.4

/obj/item/gun/ballistic/automatic/smg/m90/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/m90/unrestricted/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/smg/m90/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/gun/ballistic/automatic/smg/m90/update_overlays()
	. = ..()
	switch(select)
		if(0)
			. += "[initial(icon_state)]_semi"
		if(1)
			. += "[initial(icon_state)]_burst"
		if(2)
			. += "[initial(icon_state)]_gren"

/obj/item/gun/ballistic/automatic/smg/m90/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to grenades.</span>")
		if(2)
			select = 0
			burst_size = 1
			fire_delay = 0
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/gun/general/selector.ogg', 100, TRUE)
	update_appearance()
	return

/obj/item/gun/ballistic/automatic/smg/firestorm //weapon designed by Apogee-dev
	name = "HP Firestorm"
	desc = "An unconventional submachinegun, rarely issued to Saint-Roumain Militia mercenary hunters for outstanding situations where normal hunting weapons fall short. Chambered in .45."
	icon = 'icons/obj/guns/48x32guns.dmi'
	icon_state = "firestorm"
	item_state = "firestorm"
	mag_type = /obj/item/ammo_box/magazine/c45_firestorm_mag
	can_suppress = FALSE
	special_mags = TRUE
	burst_size = 1
	actions_types = list()
	fire_delay = 1
	rack_sound = 'sound/weapons/gun/smg/uzi_cocked.ogg'
	fire_sound = 'sound/weapons/gun/smg/firestorm.ogg'

	manufacturer = MANUFACTURER_HUNTERSPRIDE
	wield_slowdown = 0.4

/obj/item/gun/ballistic/automatic/smg/firestorm/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/firestorm/pan //spawns with pan magazine, can take sticks instead of just drums, not sure where this would be used, maybe erts?
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/firestorm/pan/Initialize()
	. = ..()
	magazine = new /obj/item/ammo_box/magazine/c45_firestorm_mag/pan(src)
	chamber_round()

/obj/item/gun/ballistic/automatic/smg/cm5
	name = "\improper CM-5"
	desc = "The standard issue SMG of CLIP. One of the few firearm designs that were left mostly intact from the designs found on the UNSV Lichtenstein. Chambered in 9mm."
	icon_state = "cm5"
	item_state = "cm5"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/smg_heavy.ogg'
	manufacturer = MANUFACTURER_MINUTEMAN

/obj/item/gun/ballistic/automatic/smg/cm5/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)

/obj/item/gun/ballistic/automatic/smg/cm5/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/cm5/compact
	name = "\improper CM-5c"
	desc = "The compact conversion of the CM-5. While not exactly restricted, it is looked down upon due to CLIP's doctrine on medium-longrange combat, however it excels at close range and is very lightweight. You feel like this gun is mildly unfinished. Chambered in 9mm."
	w_class = WEIGHT_CLASS_NORMAL
	spread = 25
	spread_unwielded = 40

	recoil = 1
	recoil_unwielded = 2
	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

/obj/item/gun/ballistic/automatic/smg/cm5/compact/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.8 SECONDS)

/obj/item/gun/ballistic/automatic/smg/skm_carbine
	name = "\improper SKM-24v"
	desc = "The SKM-24v was a carbine modification of the SKM-24 during the Frontiersmen War. This, however, is just a shoddy imitation of that carbine, effectively an SKM-24 with a sawed down barrel and a folding wire stock. Can be fired with the stock folded, though accuracy suffers. Chambered in 4.6x30mm."

	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "skm_carbine"
	item_state = "skm_carbine"

	fire_sound = 'sound/weapons/gun/rifle/skm_smg.ogg'

	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/skm_545_39

	actions_types = list(/datum/action/item_action/fold_stock) //once again, ideally an attatchment in the future

	recoil = 2
	recoil_unwielded = 6

	spread = 8
	spread_unwielded = 14

	wield_delay = 0.6 SECONDS
	wield_slowdown = 0.35

	///is the bipod deployed?
	var/stock_folded = FALSE

	///we add these two values to recoi/spread when we have the bipod deployed
	var/stock_recoil_bonus = -2
	var/stock_spread_bonus = -5

	var/folded_slowdown = 0.6
	var/folded_wield_delay = 0.6 SECONDS

	var/unfolded_slowdown = 0.35
	var/unfolded_wield_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/smg/skm_carbine/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)
	AddElement(/datum/element/update_icon_updates_onmob)

/datum/action/item_action/fold_stock
	name = "Fold/Unfold stock"
	desc = "Fold or unfold the stock for easier storage."

/obj/item/gun/ballistic/automatic/smg/skm_carbine/ui_action_click(mob/user, action)
	if(!istype(action, /datum/action/item_action/fold_stock))
		return ..()
	fold(user)


/obj/item/gun/ballistic/automatic/smg/skm_carbine/proc/fold(mob/user)
	if(stock_folded)
		to_chat(user, "<span class='notice'>You unfold the stock on the [src].</span>")
		w_class = WEIGHT_CLASS_BULKY
		wield_delay = folded_wield_delay
		wield_slowdown = folded_slowdown
	else
		to_chat(user, "<span class='notice'>You fold the stock on the [src].</span>")
		w_class = WEIGHT_CLASS_NORMAL
		wield_delay = unfolded_wield_delay
		wield_slowdown = unfolded_slowdown

	if(wielded)
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/gun, multiplicative_slowdown = wield_slowdown)

	stock_folded = !stock_folded
	playsound(src, 'sound/weapons/empty.ogg', 100, 1)
	update_appearance()


/obj/item/gun/ballistic/automatic/smg/skm_carbine/calculate_recoil(mob/user, recoil_bonus = 0)
	var/gunslinger_bonus = 1
	var/total_recoil = recoil_bonus
	if(!stock_folded)
		total_recoil += stock_recoil_bonus
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_recoil += gunslinger_bonus

	total_recoil = clamp(total_recoil,0,INFINITY)
	return total_recoil

/obj/item/gun/ballistic/automatic/smg/skm_carbine/calculate_spread(mob/user, bonus_spread)
	var/gunslinger_bonus = 4
	var/total_spread = bonus_spread
	if(!stock_folded)
		total_spread += stock_spread_bonus
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_spread += gunslinger_bonus

	total_spread = clamp(total_spread,0,INFINITY)
	return total_spread

/obj/item/gun/ballistic/automatic/smg/skm_carbine/update_icon_state()
	. = ..()
	item_state = "[initial(item_state)][stock_folded ? "_nostock" : ""]"
	mob_overlay_state = "[initial(item_state)][stock_folded ? "_nostock" : ""]"

/obj/item/gun/ballistic/automatic/smg/skm_carbine/update_overlays()
	. = ..()
	. += "[base_icon_state || initial(icon_state)][stock_folded ? "_nostock" : "_stock"]"

/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq
	name = "\improper SKM-44v Mongrel"
	desc = "An SKM-44, further modified into a sub-machine gun by Inteq artificers with a new magazine well, collapsing stock, and shortened barrel. Faced with a surplus of SKM-44s and a shortage of other firearms, IRMG has made the most of their available materiel with conversions such as this. Chambered in 10mm."
	icon_state = "skm_inteqsmg"
	item_state = "skm_inteqsmg"

	mag_type = /obj/item/ammo_box/magazine/smgm10mm
	manufacturer = MANUFACTURER_INTEQ

	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

	spread = 7
	recoil_unwielded = 10

	recoil = 0
	recoil_unwielded = 4

	stock_spread_bonus = -4
	stock_recoil_bonus = -1

	wield_delay = 0.4 SECONDS

	folded_slowdown = 0.15
	folded_wield_delay = 0.2 SECONDS

	unfolded_slowdown = 0.35
	unfolded_wield_delay = 0.4 SECONDS


/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.13 SECONDS)
