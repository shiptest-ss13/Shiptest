/obj/mecha/combat/combat_tank
	name = "\improper Armored Combat Vehicle \"Tank\""
	desc = "While exosuits have taken over armored vehicles in performance in ground combat, factions that can not afford expensive exosuits have to rely on these old relics. The 207 was exclusively mass produced for a Kalixcian war, however an abrupt surrender left many of these to gain dust in warehouses."

	icon = 'icons/mecha/mecha_96x96.dmi'
	icon_state = "five_stars"

	stepsound = 'sound/mecha/mechstep.ogg'
	turnsound = 'sound/mecha/mechturn.ogg'

	armor = list("melee" = 80, "bullet" = 65, "laser" = 35, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)

	wreckage = /obj/structure/mecha_wreckage/tank
	exit_delay = 40
	step_in = 5
	dir_in = 1 //Facing North.
	max_integrity = 800
	pixel_x = -32
	pixel_y = -32

/obj/mecha/combat/combat_tank/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/tank(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/mounted(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/generator(src)
	ME.attach(src)

/obj/mecha/combat/combat_tank/loaded/Initialize()
	. = ..()
	max_ammo()

/obj/mecha/combat/combat_tank/minutemen
	name = "\improper Type 325 Armored Combat Vehicle \"Blueberry\""
	desc = "A heavily modified Type 207 brought up to modern standards. Usually, third-parties can't afford to purchase exosuits, so they have to rely on refitting old 207s."
	icon_state = "blue"

/obj/mecha/combat/combat_tank/minutemen/loaded/Initialize()
	. = ..()
	max_ammo()
