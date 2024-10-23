/obj/item/gun/energy/ionrifle
	name = "ion rifle"
	desc = "A man-portable anti-armor weapon designed to disable mechanical threats at range."
	icon_state = "ionrifle"
	item_state = null	//so the human update icon uses the icon_state instead.
	shaded_charge = FALSE
	ammo_x_offset = 2
	ammo_y_offset = 2
	w_class = WEIGHT_CLASS_HUGE
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/ion)
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/ionrifle/emp_act(severity)
	return

/obj/item/gun/energy/ionrifle/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/ionrifle/carbine
	name = "ion carbine"
	desc = "The MK.II Prototype Ion Projector is a lightweight carbine version of the larger ion rifle, built to be ergonomic and efficient."
	icon_state = "ioncarbine"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	ammo_x_offset = 2
	ammo_y_offset = 0

/obj/item/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon_state = "decloner"
	ammo_type = list(/obj/item/ammo_casing/energy/declone)
	ammo_x_offset = 1

/obj/item/gun/energy/decloner/update_overlays()
	. = ..()
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	if(!QDELETED(cell) && (cell.charge > shot.e_cost))
		. += "decloner_spin"

/obj/item/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon_state = "flora"
	item_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut, /obj/item/ammo_casing/energy/flora/revolution)
	modifystate = TRUE
	ammo_x_offset = 1
	selfcharge = 1
	shaded_charge = TRUE

/obj/item/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon_state = "meteor_gun"
	item_state = "c20r"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	default_ammo_type = /obj/item/stock_parts/cell/potato
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/potato,
	)
	selfcharge = 1

/obj/item/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/energy/mindflayer
	name = "\improper Mind Flayer"
	desc = "A prototype weapon recovered from the ruins of Research-Station Epsilon."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	ammo_x_offset = 2

/obj/item/gun/energy/kinetic_accelerator/crossbow
	name = "mini energy crossbow"
	desc = "A weapon favored by syndicate stealth specialists."
	icon_state = "crossbow"
	item_state = "crossbow"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=2000)
	suppressed = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/bolt)
	weapon_weight = WEAPON_LIGHT
	obj_flags = 0
	overheat_time = 20
	holds_charge = TRUE
	unique_frequency = TRUE
	max_mod_capacity = 0
	manufacturer = MANUFACTURER_SCARBOROUGH

/obj/item/gun/energy/kinetic_accelerator/crossbow/large
	name = "energy crossbow"
	desc = "A reverse engineered weapon using syndicate technology."
	icon_state = "crossbowlarge"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=4000)
	suppressed = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/large)
	manufacturer = MANUFACTURER_NONE


/obj/item/gun/energy/plasmacutter
	name = "plasma cutter"
	desc = "An engineering tool capable of expelling concentrated plasma bursts. You could use it to cut limbs off xenos! Or, you know, cut through walls."
	icon_state = "plasmacutter"
	item_state = "plasmacutter"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "slashed", "cut", "sliced")
	force = 12
	sharpness = IS_SHARP
	can_charge = FALSE

	heat = 3800
	usesound = list('sound/items/welder.ogg', 'sound/items/welder2.ogg')
	tool_behaviour = TOOL_DECONSTRUCT
	wall_decon_damage = 200
	toolspeed = 0.9 //plasmacutters can be used like angle grinders, and are a bit faster
	internal_magazine = TRUE //so you don't cheese through the need for plasma - WS EDIT
	var/charge_cut = 100 //amount of charge used up to start action (multiplied by amount) and per progress_flash_divisor ticks of cutting
	var/adv = FALSE

/obj/item/gun/energy/plasmacutter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 105, 0, 'sound/weapons/plasma_cutter.ogg')
	AddElement(/datum/element/update_icon_blocker)
	AddElement(/datum/element/tool_flash, 1)

/obj/item/gun/energy/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>[src] is [round(cell.percent())]% charged.</span>"

/obj/item/gun/energy/plasmacutter/attackby(obj/item/I, mob/user)
	var/charge_multiplier = 0 //2 = Refined stack, 1 = Ore
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		charge_multiplier = 2
	if(istype(I, /obj/item/stack/ore/plasma))
		charge_multiplier = 1
	if(charge_multiplier)
		if(cell.charge == cell.maxcharge)
			to_chat(user, "<span class='notice'>You try to insert [I] into [src], but it's fully charged.</span>") //my cell is round and full
			return
		I.use(1)
		cell.give(500*charge_multiplier)
		to_chat(user, "<span class='notice'>You insert [I] in [src], recharging it.</span>")
	else
		..()

// Can we cut? Plasma cutter does not use charge continuously.
// Amount cannot be defaulted to 1: most of the code specifies 0 in the call.
/obj/item/gun/energy/plasmacutter/tool_use_check(mob/living/user, amount)
	if(QDELETED(cell))
		to_chat(user, "<span class='warning'>[src] does not have a cell, and cannot be used!</span>")
		return FALSE
	// Amount cannot be used if drain is made continuous, e.g. amount = 5, charge_cut = 25
	// Then it'll drain 125 at first and 25 periodically, but fail if charge dips below 125 even though it still can finish action
	// Alternately it'll need to drain amount*charge_cut every period, which is either obscene or makes it free for other uses
	if(amount ? cell.charge < charge_cut * amount : cell.charge < charge_cut)
		to_chat(user, "<span class='warning'>You need more charge to complete this task!</span>")
		return FALSE

	return TRUE

/obj/item/gun/energy/plasmacutter/attack(mob/living/carbon/human/target, mob/user)
	if(!istype(target))
		return ..()
	var/obj/item/bodypart/attackedLimb = target.get_bodypart(check_zone(user.zone_selected))
	if(!attackedLimb || IS_ORGANIC_LIMB(attackedLimb) || (user.a_intent == INTENT_HARM))
		return ..()
	if(!tool_start_check(user, amount = 1))
		return TRUE
	user.visible_message("<span class='notice'>[user] starts to fix some of the dents on [target]'s [parse_zone(attackedLimb.body_zone)].</span>",
			"<span class='notice'>You start fixing some of the dents on [target == user ? "your" : "[target]'s"] [parse_zone(attackedLimb.body_zone)].</span>")
	if(!use_tool(target, user, delay = (target == user ? 5 SECONDS : 0.5 SECONDS), amount = 1, volume = 25))
		return TRUE
	item_heal_robotic(target, user, brute_heal = 15, burn_heal = 0)
	return TRUE

/obj/item/gun/energy/plasmacutter/use(amount)
	return (!QDELETED(cell) && cell.use(amount ? amount * charge_cut : charge_cut))

/obj/item/gun/energy/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	if(amount)
		if(adv)
			target.add_overlay(GLOB.advanced_cutting_effect)
		else
			target.add_overlay(GLOB.cutting_effect)
		. = ..()
		if(adv)
			target.cut_overlay(GLOB.advanced_cutting_effect)
		else
			target.cut_overlay(GLOB.cutting_effect)
	else
		. = ..(amount=1)

/obj/item/gun/energy/plasmacutter/adv
	name = "advanced plasma cutter"
	icon_state = "adv_plasmacutter"
	item_state = "adv_plasmacutter"
	force = 15
	wall_decon_damage = 300
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv)

/obj/item/gun/energy/wormhole_projector
	name = "bluespace wormhole projector"
	desc = "A projector that emits high density quantum-coupled bluespace beams." //WS Edit - Any anomaly core for phazons
	ammo_type = list(/obj/item/ammo_casing/energy/wormhole, /obj/item/ammo_casing/energy/wormhole/orange)
	item_state = null
	icon_state = "wormhole_projector"
	base_icon_state = "wormhole_projector"
	var/obj/effect/portal/p_blue
	var/obj/effect/portal/p_orange
	var/atmos_link = FALSE

/obj/item/gun/energy/wormhole_projector/update_icon_state()
	. = ..()
	icon_state = item_state = "[base_icon_state][select]"

/obj/item/gun/energy/wormhole_projector/update_ammo_types()
	. = ..()
	for(var/i in 1 to ammo_type.len)
		var/obj/item/ammo_casing/energy/wormhole/W = ammo_type[i]
		if(istype(W))
			W.gun = WEAKREF(src)
			var/obj/projectile/beam/wormhole/WH = W.BB
			if(istype(WH))
				WH.gun = WEAKREF(src)

/obj/item/gun/energy/wormhole_projector/process_chamber(atom/shooter)
	..()
	select_fire()

/obj/item/gun/energy/wormhole_projector/proc/on_portal_destroy(obj/effect/portal/P)
	if(P == p_blue)
		p_blue = null
	else if(P == p_orange)
		p_orange = null

/obj/item/gun/energy/wormhole_projector/proc/has_blue_portal()
	if(istype(p_blue) && !QDELETED(p_blue))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/has_orange_portal()
	if(istype(p_orange) && !QDELETED(p_orange))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/crosslink()
	if(!has_blue_portal() && !has_orange_portal())
		return
	if(!has_blue_portal() && has_orange_portal())
		p_orange.link_portal(null)
		return
	if(!has_orange_portal() && has_blue_portal())
		p_blue.link_portal(null)
		return
	p_orange.link_portal(p_blue)
	p_blue.link_portal(p_orange)

/obj/item/gun/energy/wormhole_projector/proc/create_portal(obj/projectile/beam/wormhole/W, turf/target)
	var/obj/effect/portal/P = new /obj/effect/portal(target, 300, null, FALSE, null, atmos_link)
	RegisterSignal(P, COMSIG_PARENT_QDELETING, PROC_REF(on_portal_destroy))
	if(istype(W, /obj/projectile/beam/wormhole/orange))
		qdel(p_orange)
		p_orange = P
		P.icon_state = "portal1"
	else
		qdel(p_blue)
		p_blue = P
	crosslink()

/* 3d printer 'pseudo guns' for borgs */

/obj/item/gun/energy/printer
	name = "integrated LMG"
	desc = "A modified energy weapon re-designed to fire 3D-printed flechettes, pulled directly from the cyborg's internal power source."
	icon_state = "l6_cyborg"
	icon = 'icons/obj/guns/projectile.dmi'
	default_ammo_type = /obj/item/stock_parts/cell/secborg
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/secborg,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/c3dbullet)
	can_charge = FALSE
	use_cyborg_cell = TRUE

	fire_delay = 0.3 SECONDS

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

/obj/item/gun/energy/printer/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/gun/energy/printer/emp_act()
	return

//the future of mid-range borg marksmanship. Get tactical.
/obj/item/gun/energy/printer/commando
	name = "integrated TAC-rifle"
	desc = "A shoulder-mounted high-caliber ballistic weapon. Capable of supporting prolonged encounters by printing heavy rounds directly off the host cyborg's power supplies."
	ammo_type = list(/obj/item/ammo_casing/energy/ctac, /obj/item/ammo_casing/energy/csour, /obj/item/ammo_casing/energy/csweet)
	var/tac_ammo = 1

/obj/item/gun/energy/printer/commando/examine()
	. = ..()
	. += "<span class='notice'> Can be reconfigured inhand to print different projectile designs.</span>"

/obj/item/gun/energy/printer/commando/attack_self(mob/living/user as mob)
	if(ammo_type.len > 1)
		tac_fire(user)
		update_appearance()

/obj/item/gun/energy/printer/commando/proc/tac_fire(mob/living/user)
	select++
	if (select > ammo_type.len)
		select = 1
	var/obj/item/ammo_casing/energy/shot = ammo_type[select]
	fire_sound = shot.fire_sound
	fire_delay = shot.delay
	if (shot.select_name)
		playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
		if(shot.select_name == "tactical")
			to_chat(user, "<span class='notice'>You configure the [src] to fire CY-TACTICAL high-velocity impact rounds.</span>")
		if(shot.select_name == "sweet")
			to_chat(user, "<span class='notice'>You set your [src] to fire CY-SWEET distruptor rounds, which travel slowly and do little damage, but irradiate and ignite targets.</span>")
		if(shot.select_name == "sour")
			to_chat(user, "<span class='notice'>You rearm your [src] with CY-SOUR nonlethal rounds, which cause stamina damage and distrupt the focus of enemies.</span>")
	chambered = null
	recharge_newshot(TRUE)
	update_appearance()
	return

/obj/item/gun/energy/temperature
	name = "temperature gun"
	icon_state = "freezegun"
	desc = "A gun that changes temperatures."
	ammo_type = list(/obj/item/ammo_casing/energy/temp, /obj/item/ammo_casing/energy/temp/hot)
	default_ammo_type = /obj/item/stock_parts/cell/gun/upgraded
	ammo_x_offset = 2

/obj/item/gun/energy/temperature/security
	name = "security temperature gun"
	desc = "A weapon that can only be used to its full potential by the truly robust."

/obj/item/gun/energy/laser/instakill
	name = "instakill rifle"
	icon_state = "instagib"
	item_state = "instagib"
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit."
	ammo_type = list(/obj/item/ammo_casing/energy/instakill)
	force = 60
	charge_sections = 5
	ammo_x_offset = 2
	shaded_charge = FALSE

/obj/item/gun/energy/laser/instakill/red
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a red design."
	icon_state = "instagibred"
	item_state = "instagibred"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/red)

/obj/item/gun/energy/laser/instakill/blue
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a blue design."
	icon_state = "instagibblue"
	item_state = "instagibblue"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/blue)

/obj/item/gun/energy/laser/instakill/emp_act() //implying you could stop the instagib
	return

/obj/item/gun/energy/gravity_gun
	name = "one-point gravitational manipulator"
	desc = "An experimental, multi-mode device that fires bolts of Zero-Point Energy, causing local distortions in gravity. Requires an anomaly core to function." //WS Edit - Any anomaly core for phazons
	ammo_type = list(/obj/item/ammo_casing/energy/gravity/repulse, /obj/item/ammo_casing/energy/gravity/attract, /obj/item/ammo_casing/energy/gravity/chaos)
	item_state = "gravity_gun"
	icon_state = "gravity_gun"
	var/power = 4
	var/firing_core = FALSE

/obj/item/gun/energy/gravity_gun/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly)) //WS Edit - Any anomaly core for phazons
		to_chat(user, "<span class='notice'>You insert [C] into the gravitational manipulator and the weapon gently hums to life.</span>")
		firing_core = TRUE
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		qdel(C)
		return
	return ..()

/obj/item/gun/energy/gravity_gun/can_shoot(visuals)
	if(!firing_core)
		return FALSE
	return ..()

/obj/item/gun/energy/tesla_cannon
	name = "tesla cannon"
	icon_state = "tesla"
	item_state = "tesla"
	desc = "A gun that shoots balls of \"tesla\", whatever that is."
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_cannon)
	shaded_charge = TRUE
	weapon_weight = WEAPON_HEAVY

	fire_delay = 0.1 SECONDS
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

/obj/item/gun/energy/buster
	name = "replica buster cannon"
	icon_state = "buster"
	item_state = "buster"
	desc = "A replica of T4L1's buster cannon from the popular webseries RILENA. Fires a harmless energy pellet at the target."
	ammo_type = list(/obj/item/ammo_casing/energy/buster)
	weapon_weight = WEAPON_LIGHT
