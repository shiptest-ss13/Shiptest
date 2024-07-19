/obj/item/gun/ballistic/automatic/smg
	burst_size = 2
	actions_types = list()
	fire_delay = 0.13 SECONDS

	spread = 6
	spread_unwielded = 10
	wield_slowdown = 0.35
	recoil_unwielded = 4
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.5 SECONDS

	load_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/smg_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/smg_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/smg_unload.ogg'

/obj/item/gun/ballistic/automatic/smg/calculate_recoil(mob/user, recoil_bonus = 0)
	var/gunslinger_bonus = 2
	var/total_recoil
	if(.)
		total_recoil += .
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_recoil += gunslinger_bonus
	. = total_recoil
	return ..()

/obj/item/gun/ballistic/automatic/smg/calculate_spread(mob/user, bonus_spread)
	var/gunslinger_bonus = 16
	var/total_spread = bonus_spread
	if(.)
		total_spread += .
	if(HAS_TRAIT(user, TRAIT_GUNSLINGER)) //gunslinger penalty
		total_spread += gunslinger_bonus
	. = total_spread
	return ..()

/obj/item/gun/ballistic/automatic/smg/c20r
	name = "\improper C-20r SMG"
	desc = "A bullpup .45 SMG designated 'C-20r.' Its buttstamp reads 'Scarborough Arms - Per falcis, per pravitas.'"
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "c20r"
	item_state = "c20r"

	mag_type = /obj/item/ammo_box/magazine/smgm45
	can_bayonet = TRUE
	can_suppress = FALSE
	knife_x_offset = 26
	knife_y_offset = 12
	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_SCARBOROUGH

EMPTY_GUN_HELPER(automatic/smg/c20r)

/obj/item/gun/ballistic/automatic/smg/c20r/Initialize()
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/c20r/cobra
	name = "\improper Cobra 20"
	desc = "An older model of SMG manufactured by Scarborough Arms, a predecessor to the military C-20 series. Chambered in .45. "
	can_bayonet = FALSE
	icon_state = "cobra20"
	item_state = "cobra20"

/obj/item/gun/ballistic/automatic/smg/c20r/cobra/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/c20r/suns
	desc = "A bullpup .45 SMG designated 'C-20r.' Its buttstamp reads 'Scarborough Arms - Per falcis, per pravitas.' This one is painted in SUNS' colors."
	icon_state = "c20r_suns"
	item_state = "c20r_suns"

/obj/item/gun/ballistic/automatic/smg/wt550
	name = "\improper WT-550 Automatic Rifle"
	desc = "An outdated PDW, used centuries ago by Nanotrasen security elements. Uses 4.6x30mm rounds."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "wt550"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	can_suppress = FALSE
	actions_types = list()
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12
	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD
	fire_sound = 'sound/weapons/gun/smg/smg_heavy.ogg'

/obj/item/gun/ballistic/automatic/smg/wt550/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "\improper Type U3 Uzi"
	desc = "A lightweight submachine gun, for when you really want someone dead. Uses 9mm rounds."

	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'
	icon_state = "uzi"

	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	bolt_type = BOLT_TYPE_OPEN
	show_magazine_on_sprite = TRUE

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
	fire_delay = 0.1 SECONDS

/obj/item/gun/ballistic/automatic/smg/vector
	name = "\improper Vector carbine"
	desc = "A police carbine based on a pre-Night of Fire SMG design. Most of the complex workings have been removed for reliability. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "vector"
	item_state = "vector"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

/obj/item/gun/ballistic/automatic/smg/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	icon_state = "m90"
	item_state = "m90"

	mag_type = /obj/item/ammo_box/magazine/m556
	can_suppress = FALSE
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "burst fire", FIREMODE_FULLAUTO = "full auto", FIREMODE_OTHER = "underbarrel grenade launcher")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_OTHER)
	default_firemode = FIREMODE_SEMIAUTO
	var/obj/item/gun/ballistic/revolver/grenadelauncher/secondary
	show_magazine_on_sprite = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/rifle/shot_alt.ogg'
	manufacturer = MANUFACTURER_SCARBOROUGH

	burst_size = 3
	burst_delay = 0.1 SECONDS
	fire_delay = 0.2 SECONDS
	spread = 1
	spread_unwielded = 8
	wield_slowdown = 0.4

/obj/item/gun/ballistic/automatic/smg/m90/Initialize()
	. = ..()
	secondary = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	RegisterSignal(secondary, COMSIG_ATOM_UPDATE_ICON, PROC_REF(secondary_update_icon))
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	return secondary.pre_fire(target, user, message, params, zone_override, bonus_spread)

/obj/item/gun/ballistic/automatic/smg/m90/can_shoot()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.can_shoot()

/obj/item/gun/ballistic/automatic/smg/m90/afterattack(atom/target, mob/living/user, flag, params)
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.afterattack(target, user, flag, params)

/obj/item/gun/ballistic/automatic/smg/m90/attackby(obj/item/attack_obj, mob/user, params)
	if(istype(attack_obj, secondary.magazine.ammo_type))
		secondary.unique_action()
		return secondary.attackby(attack_obj, user, params)
	return ..()


/obj/item/gun/ballistic/automatic/smg/m90/can_shoot()
	var/current_firemode = gun_firemodes[firemode_index]
	if(current_firemode != FIREMODE_OTHER)
		return ..()
	return secondary.can_shoot()

/obj/item/gun/ballistic/automatic/smg/m90/on_wield(obj/item/source, mob/user)
	wielded = TRUE
	secondary.wielded = TRUE
	INVOKE_ASYNC(src, .proc.do_wield, user)

/obj/item/gun/ballistic/automatic/smg/m90/do_wield(mob/user)
	. = ..()
	secondary.wielded_fully = wielded_fully

/// triggered on unwield of two handed item
/obj/item/gun/ballistic/automatic/smg/m90/on_unwield(obj/item/source, mob/user)
	. = ..()
	secondary.wielded_fully = FALSE
	secondary.wielded = FALSE


/obj/item/gun/ballistic/automatic/smg/m90/proc/secondary_update_icon()
	update_appearance()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)


/obj/item/gun/ballistic/automatic/smg/firestorm //weapon designed by Apogee-dev
	name = "HP Firestorm"
	desc = "An unconventional submachinegun, rarely issued to Saint-Roumain Militia mercenary hunters for outstanding situations where normal hunting weapons fall short. Chambered in .45."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	icon_state = "firestorm"
	item_state = "firestorm"
	mag_type = /obj/item/ammo_box/magazine/c45_firestorm_mag
	can_suppress = FALSE
	unique_mag_sprites_for_variants = TRUE
	burst_size = 1
	actions_types = list()
	fire_delay = 0.13 SECONDS
	bolt_type = BOLT_TYPE_OPEN
	rack_sound = 'sound/weapons/gun/smg/uzi_cocked.ogg'
	fire_sound = 'sound/weapons/gun/smg/firestorm.ogg'


	manufacturer = MANUFACTURER_HUNTERSPRIDE
	wield_slowdown = 0.4

/obj/item/gun/ballistic/automatic/smg/firestorm/pan //spawns with pan magazine, can take sticks instead of just drums, not sure where this would be used, maybe erts?
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smg/firestorm/pan/Initialize()
	. = ..()
	magazine = new /obj/item/ammo_box/magazine/c45_firestorm_mag/pan(src)
	chamber_round()

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
	var/total_recoil = recoil_bonus
	if(!stock_folded)
		total_recoil += stock_recoil_bonus

	return ..(user, total_recoil)

/obj/item/gun/ballistic/automatic/smg/skm_carbine/calculate_spread(mob/user, bonus_spread)
	var/total_spread = bonus_spread

	if(!stock_folded)
		total_spread += stock_spread_bonus

	return ..(user, total_spread)

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
	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
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

/obj/item/gun/ballistic/automatic/smg/skm_carbine/inteq/proto
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype full-auto 9mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors and a folding stock."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "saber"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	bolt_type = BOLT_TYPE_LOCKING
	show_magazine_on_sprite = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD

