/obj/item/gun/energy/e_gun
	name = "energy rifle"
	desc = "A basic hybrid energy gun with two settings: disable and kill."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "energy"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	modifystate = TRUE
	ammo_x_offset = 2
	dual_wield_spread = 60
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/e_gun/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/e_gun/mini
	name = "miniature energy gun"
	desc = "A small, pistol-sized energy gun with a built-in flashlight. It has two settings: disable and kill."
	icon_state = "mini"
	item_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
	)
	throwforce = 11 //This is funny, trust me.
	ammo_x_offset = 2
	charge_sections = 3
	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

	spread = 2
	spread_unwielded = 5

/obj/item/gun/energy/e_gun/mini/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/e_gun/hades
	name = "SL AL-655 'Hades' energy rifle"
	desc = "The standard issue rifle of Nanotrasen's Security Forces. Most have been put in long term storage following the ICW, and usually aren't issued to low ranking security divisions."
	icon_state = "energytac"
	ammo_x_offset = 2
	charge_sections = 5
	ammo_type = list(/obj/item/ammo_casing/energy/laser/assault, /obj/item/ammo_casing/energy/disabler)
	default_ammo_type = /obj/item/stock_parts/cell/gun/upgraded

	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	fire_delay = 0.2 SECONDS

	wield_delay = 0.7 SECONDS
	wield_slowdown = 0.6
	spread_unwielded = 20

/obj/item/gun/energy/e_gun/old
	name = "prototype energy gun"
	desc = "NT-P:01 Prototype Energy Gun. Early stage development of a unique laser rifle that has a multifaceted energy lens, allowing the gun to alter the form of projectile it fires on command. The project was a dud, and Nanotrasen later acquired Sharplite to suit its laser weapon needs."
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/electrode/old)
	manufacturer = MANUFACTURER_NANOTRASEN_OLD

/obj/item/gun/energy/e_gun/hos
	name = "\improper X-01 MultiPhase Energy Gun"
	desc = "This is an expensive, modern recreation of an antique laser gun. This gun has several unique firemodes, but lacks the ability to recharge over time."
	default_ammo_type = /obj/item/stock_parts/cell/gun/upgraded
	icon_state = "hoslaser"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/ion/hos, /obj/item/ammo_casing/energy/electrode/hos)
	shaded_charge = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/e_gun/hos/brazil
	name = "modified antique laser gun"
	desc = "It's somehow modified to have more firemodes."
	icon_state = "capgun_brazil_hos"
	item_state = "hoslaser"
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/e_gun/hos/brazil/true
	desc = "This genuine antique laser gun, modified with an experimental suite of alternative firing modes based on the X-01 MultiPhase Energy Gun, is now truly one of the finest weapons in the frontier."
	icon_state = "capgun_hos"
	item_state = "hoslaser"
	selfcharge = 1
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/e_gun/dragnet
	name = "\improper DRAGnet"
	desc = "The \"Dynamic Rapid-Apprehension of the Guilty\" net is a revolution in law enforcement technology."
	icon_state = "dragnet"
	item_state = "dragnet"
	lefthand_file = GUN_LEFTHAND_ICON
	righthand_file = GUN_RIGHTHAND_ICON
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/dragnet/snare
	name = "Energy Snare Launcher"
	desc = "Fires an energy snare that slows the target down."
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/gun/energy/e_gun/turret
	name = "hybrid turret gun"
	desc = "A heavy hybrid energy cannon with two settings: Stun and kill."
	icon_state = "turretlaser"
	item_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell."
	icon_state = "nucgun"
	item_state = "nucgun"
	charge_delay = 5
	can_charge = FALSE
	internal_magazine = TRUE
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = 1
	var/reactor_overloaded
	var/fail_tick = 0
	var/fail_chance = 0
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/energy/e_gun/nuclear/process()
	if(fail_tick > 0)
		fail_tick--
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	failcheck()
	update_appearance()
	..()

/obj/item/gun/energy/e_gun/nuclear/proc/failcheck()
	if(prob(fail_chance) && isliving(loc))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				M.rad_act(40)
				to_chat(M, "<span class='userdanger'>Your [name] feels warmer.</span>")
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				M.rad_act(80)
				reactor_overloaded = TRUE
				to_chat(M, "<span class='userdanger'>Your [name]'s reactor overloads!</span>")

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_overlays()
	. = ..()
	if(reactor_overloaded)
		. += "[icon_state]_fail_3"
		return
	switch(fail_tick)
		if(0)
			. += "[icon_state]_fail_0"
		if(1 to 150)
			. += "[icon_state]_fail_1"
		if(151 to INFINITY)
			. += "[icon_state]_fail_2"

/obj/item/gun/energy/e_gun/rdgun
	name = "research director's PDW"
	desc = "A energy revolver made from the power of science, but more importantly booze. Only has 6 shots."
	icon_state = "rdpdw"
	item_state = "gun"
	ammo_x_offset = 2
	charge_sections = 6

	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

	spread = 2
	spread_unwielded = 5

	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hitscan, /obj/item/ammo_casing/energy/ion/cheap)
	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
	)

/obj/item/gun/energy/e_gun/adv_stopping
	name = "advanced stopping revolver"
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon_state = "bsgun"
	item_state = "gun"
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1
	shaded_charge = TRUE

/obj/item/gun/energy/e_gun/smg
	name = "\improper E-TAR SMG"
	desc = "A dual-mode energy gun capable of discharging weaker shots at a much faster rate than the standard energy gun."
	icon_state = "esmg"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smg, /obj/item/ammo_casing/energy/laser/smg)
	ammo_x_offset = 2
	charge_sections = 3
	weapon_weight = WEAPON_LIGHT

	fire_delay = 0.13 SECONDS

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/energy/e_gun/iot
	name = "\improper E-SG 500 Second Edition"
	desc = "A improved version of the E-SG 255. It now includes two firing modes, disable and kill, while still keeping that sweet integrated computer. Please note that the screen is right next to the switch mode button."
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "iotshotgun"
	item_state = "shotgun_combat"
	shaded_charge = TRUE
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/ultima, /obj/item/ammo_casing/energy/laser/ultima)
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal

/obj/item/gun/energy/e_gun/e11
	name = "E-11 hybrid energy rifle"
	desc = "A hybrid energy gun fondly remembered as one of the worst weapons ever made. It hurts, but that's only if it manages to hit its target."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e11"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/eoehoma)
	ammo_x_offset = 0
	spread = 80
	spread_unwielded = 140
	dual_wield_spread = 140
	shaded_charge = TRUE
	manufacturer = MANUFACTURER_EOEHOMA

/obj/item/gun/energy/e_gun/e11/empty_cell
	spawn_no_ammo = TRUE
