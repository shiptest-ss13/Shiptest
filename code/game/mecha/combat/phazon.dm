/obj/mecha/combat/phazon
	desc = "This is a Phazon exosuit. The pinnacle of scientific research and pride of Nanotrasen, it uses cutting edge bluespace technology and expensive materials."
	name = "\improper Phazon"
	icon_state = "phazon"
	step_in = 2
	dir_in = 2 //Facing South.
	base_step_energy_drain = 8
	max_integrity = 200
	armor = list("melee" = 40, "bullet" = 50, "laser" = 40, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 50, "fire" = 100, "acid" = 100)
	max_temperature = 25000
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/phazon
	add_req_access = 1
	internal_damage_threshold = 25
	force = 15
	max_equip = 3
	phase_state = "phazon-phase"

	facing_modifiers = list(
		MECHA_FRONT_ARMOUR = list(75, 0.5, 50),
		MECHA_SIDE_ARMOUR = list(50, 1, 35),
		MECHA_BACK_ARMOUR = list(60, 1.5, 40)
	)

/obj/mecha/combat/phazon/set_up_unique_action()
	mech_unique_action = phasing_action

/obj/mecha/combat/phazon/GrantActions(mob/living/user, human_occupant = 0)
	..()
	switch_damtype_action.Grant(user, src)
	phasing_action.Grant(user, src)


/obj/mecha/combat/phazon/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	switch_damtype_action.Remove(user)
	phasing_action.Remove(user)
