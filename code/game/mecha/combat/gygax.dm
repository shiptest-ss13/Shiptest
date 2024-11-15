/obj/mecha/combat/gygax
	desc = "A lightweight, security exosuit. Popular among private and corporate security."
	name = "\improper Gygax"
	icon_state = "gygax"
	step_in = 3
	dir_in = 1 //Facing North.
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

/obj/mecha/combat/gygax/dark
	desc = "A lightweight exosuit, painted in a dark scheme."
	name = "\improper Dark Gygax"
	icon_state = "darkgygax"
	wreckage = /obj/structure/mecha_wreckage/gygax/dark

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

/obj/mecha/combat/gygax/dark/add_cell(obj/item/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/bluespace(src)

/obj/mecha/combat/gygax/inteq
	name = "\improper Basenji"
	desc = "A lightweight security exosuit, modified to IRMG standards. The leg actuators have been maxed out, allowing for powerful short ranged charges."
	icon_state = "inteqgygax"
	charge_break_walls = TRUE
	charge_toss_structures = TRUE
	charge_toss_mobs = TRUE

/obj/mecha/combat/gygax/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Grant(user, src)


/obj/mecha/combat/gygax/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)

/obj/mecha/combat/gygax/inteq/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)
	charge_action.Grant(user,src)

/obj/mecha/combat/gygax/inteq/RemoveActions(mob/living/user, human_occupant)
	. = ..()
	charge_action.Remove(user)
