/obj/mecha/combat/gygax
	desc = "A light security exosuit manufactured by Cybersun Biodynamics. The basic version of the 500 Series combat exosuits, the 501p can overload its leg actuators to further enhance mobility."
	name = "\improper 501p Security Exosuit"
	icon_state = "gygax"
	step_in = 3
	dir = NORTH
	dir_in = NORTH
	max_integrity = 300
	deflect_chance = 5
	armor = list("melee" = 40, "bullet" = 60, "laser" = 40, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	max_temperature = 25000
	leg_overload_coeff = 80
	infra_luminosity = 6
	force = 25
	wreckage = /obj/structure/mecha_wreckage/gygax
	internal_damage_threshold = 35
	max_equip = 3
	base_step_energy_drain = 8

/obj/mecha/combat/gygax/mechturn(direction)
	. = ..()
	if(!strafe && !occupant.client.keys_held["Alt"])
		mechstep(direction) //agile mechs get to move and turn in the same step

/obj/mecha/combat/gygax/set_up_unique_action()
	mech_unique_action = overload_action

/obj/mecha/combat/gygax/dark
	desc = "A light combat exosuit manufactured by Cybersun Biodynamics. An exclusive variant of the 500 Series meant for use by Cybersun's own personnel and trusted parties, the 515 EX operates more efficiently in overload mode."
	name = "\improper 515 EX Combat Exosuit"
	icon_state = "darkgygax"
	wreckage = /obj/structure/mecha_wreckage/gygax/dark
	leg_overload_coeff = 50

/obj/mecha/combat/gygax/dark/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/thrusters/ion(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	ME.attach(src)
	max_ammo()

/obj/mecha/combat/gygax/dark/loaded/add_cell(obj/item/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/bluespace(src)

/obj/mecha/combat/gygax/dark/ramzi/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/anticcw_armor_booster
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster
	ME.attach(src)
	max_ammo()

/obj/mecha/combat/gygax/dark/ramzi/add_cell(obj/item/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/hyper(src)

/obj/mecha/combat/gygax/charger
	name = "\improper Modified 501p"
	desc = "A lightweight security exosuit, this one seems to have been modified for short high speed charges instead of enhanced speed."
	charge_break_walls = TRUE
	charge_toss_structures = TRUE
	charge_toss_mobs = TRUE

/obj/mecha/combat/gygax/charger/set_up_unique_action()
	mech_unique_action = charge_action

/obj/mecha/combat/gygax/charger/inteq
	name = "\improper Basenji"
	desc = "A light security exosuit originally manufactured by Cybersun Biodynamics, extensively modified by IRMG artificers. The leg actuators have been maxed out, allowing for powerful short ranged charges capable of breaking walls and other obstacles."
	icon_state = "inteqgygax"

/obj/mecha/combat/gygax/charger/overclock
	name = "\improper Overclocked 501p"
	desc = "A lightweight security exosuit, which has been overclocked to have its leg actuators launch the exosuit forward instead of enhanced speed."
	charge_windup = 1
	charge_cooldown = 100
	charge_power_consume = 250
	charge_distance = 4
	charge_break_walls = FALSE

/obj/mecha/combat/gygax/charger/mp
	name = "\improper NT-501p-MP"
	desc = "An exosuit model derrived from the Cybersun 501p and modified for mass production. This model has had its armor plating reduced to reduce production costs. The leg actuators have been modified to take advantage of the consequently lighter frame, allowing for swift charges over moderate distances without heavily taxing the power supply."
	armor = list("melee" = 25, "bullet" = 30, "laser" = 30, "energy" = 15, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	icon_state = "mpgygax"
	charge_break_walls = FALSE
	charge_toss_structures = FALSE
	charge_distance = 6
	charge_cooldown = 8
	charge_power_consume = 100
	charge_windup = 0

/obj/mecha/combat/gygax/charger/mp/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/carbine(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/thrusters/ion(src)
	ME.attach(src)

/obj/mecha/combat/gygax/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Grant(user, src)


/obj/mecha/combat/gygax/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)

/obj/mecha/combat/gygax/charger/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)
	charge_action.Grant(user,src)

/obj/mecha/combat/gygax/charger/RemoveActions(mob/living/user, human_occupant)
	. = ..()
	charge_action.Remove(user)
