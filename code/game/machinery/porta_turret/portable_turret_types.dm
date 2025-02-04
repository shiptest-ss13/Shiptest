
/obj/machinery/porta_turret/syndicate
	circuit = /obj/item/circuitboard/machine/turret/ship
	use_power = NO_POWER_USE
	scan_range = 9
	req_access = list(ACCESS_SYNDICATE)
	lethal = TRUE
	stun_projectile = /obj/projectile/bullet
	lethal_projectile = /obj/projectile/bullet
	lethal_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	stun_projectile_sound = 'sound/weapons/gun/pistol/shot.ogg'
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	faction = list(ROLE_SYNDICATE)
	turret_flags = TURRET_FLAG_HOSTILE
	desc = "A ballistic machine gun auto-turret."

/obj/machinery/porta_turret/syndicate/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/syndicate/energy
	icon_state = "standard_lethal"
	base_icon_state = "standard"
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser
	lethal_projectile_sound = 'sound/weapons/laser.ogg'
	desc = "An energy blaster auto-turret."

/obj/machinery/porta_turret/syndicate/energy/heavy
	icon_state = "standard_lethal"
	base_icon_state = "standard"
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	desc = "An energy blaster auto-turret."

/obj/machinery/porta_turret/syndicate/energy/raven
	stun_projectile =  /obj/projectile/beam/laser
	stun_projectile_sound = 'sound/weapons/laser.ogg'
	faction = list("neutral","silicon","turret")

/obj/machinery/porta_turret/syndicate/pod
	integrity_failure = 0.5
	max_integrity = 40
	stun_projectile = /obj/projectile/bullet/syndicate_turret
	lethal_projectile = /obj/projectile/bullet/syndicate_turret

/obj/machinery/porta_turret/ship
	circuit = /obj/item/circuitboard/machine/turret/ship
	scan_range = 9
	req_ship_access = TRUE
	icon_state = "syndie_off"
	base_icon_state = "syndie"

/obj/machinery/porta_turret/ship/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/ship/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		if(!(machine_stat & BROKEN))
			. += "<span class='notice'>[src] reports its integrity is currently [round((obj_integrity / max_integrity) * 100)] percent.</span>"

/obj/machinery/porta_turret/ship/weak
	max_integrity = 120
	integrity_failure = 0.5
	name = "Old Laser Turret"
	desc = "A turret built with substandard parts and run down further with age. Still capable of delivering lethal lasers to the odd space carp, but not much else."
	stun_projectile = /obj/projectile/beam/disabler/weak
	lethal_projectile = /obj/projectile/beam/weak/penetrator
	faction = list("neutral", "turret")

/obj/machinery/porta_turret/ship/ballistic
	stun_projectile = /obj/projectile/bullet/turret/rubber
	lethal_projectile = /obj/projectile/bullet/turret
	lethal_projectile_sound = 'sound/weapons/gun/smg/shot.ogg'
	stun_projectile_sound = 'sound/weapons/gun/smg/shot.ogg'
	desc = "A ballistic machine gun auto-turret."

//high rof, range, faster projectile speed
/* 'Nanotrasen' turrets */

/obj/machinery/porta_turret/ship/nt
	name = "Sharplite Defense Turret"
	desc = "A cheap and effective turret designed by Sharplite and purchased and installed on most Nanotrasen Vessels."
	faction = list(FACTION_PLAYER_NANOTRASEN, "turret")
	max_integrity = 160
	integrity_failure = 0.6
	icon_state = "standard_lethal"
	base_icon_state = "standard"
	stun_projectile = /obj/projectile/beam/disabler/sharplite
	lethal_projectile = /obj/projectile/beam/laser/sharplite
	lethal_projectile_sound = 'sound/weapons/gun/laser/nt-fire.ogg'
	stun_projectile_sound = 'sound/weapons/taser2.ogg'
	shot_delay = 10
	scan_range = 10

/obj/machinery/porta_turret/ship/nt/light
	name = "Sharplite LDS"
	desc = "A cheap and effective 'defensive system' designed by Sharplite for installation on Nanotrasen vessels."
	stun_projectile = /obj/projectile/beam/disabler/weak/sharplite
	lethal_projectile = /obj/projectile/beam/laser/light/sharplite
	lethal_projectile_sound = 'sound/weapons/gun/laser/nt-fire.ogg'
	stun_projectile_sound = 'sound/weapons/taser2.ogg'

/obj/machinery/porta_turret/ship/nt/heavy
	name = "Sharplite Defense Cannon"
	desc = "A heavy laser mounting designed by Sharplite for usage on Nanotrasen vessels."
	lethal_projectile = /obj/projectile/beam/laser/heavylaser/sharplite
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	max_integrity = 250

/obj/machinery/porta_turret/ship/nt/pulse
	name = "Sharplite Pulse Cannon"
	desc = "A pulse cannon mounting designed by Sharplite. Not sold to any purchasers and exclusively used on Nanotrasen Vessels."
	lethal_projectile = /obj/projectile/beam/pulse/sharplite_turret
	lethal_projectile_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'
	max_integrity = 250

/* Syndicate Turrets */

/obj/machinery/porta_turret/ship/syndicate
	faction = list(FACTION_PLAYER_SYNDICATE, "turret")
	icon_state = "standard_lethal"
	base_icon_state = "standard"

/obj/machinery/porta_turret/ship/syndicate/weak
	name = "Light Laser Turret"
	desc = "A low powered turret designed by the Gorlex Maurauders during the ICW. Effectively weaponizes mining equipment."
	stun_projectile = /obj/projectile/beam/disabler/weak
	lethal_projectile = /obj/projectile/beam/weak/penetrator
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	scan_range = 7
	shot_delay = 5

/obj/machinery/porta_turret/ship/syndicate/heavy
	name = "Heavy Laser Turret"
	desc = "Produced by Cybersun, this turret is a duel mount of a propietary heavy laser, and crowd control taser system."
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	scan_range = 12
	shot_delay = 20
	max_integrity = 300

/* New Gorlex Republic Turrets */
// Midline ballistic turrets

/obj/machinery/porta_turret/ship/ngr
	name = "Oasis Turret"
	desc = "A turret manufactured by the New Gorlex Republic for its ships and installations. Proudly manufactured within the nation!"
	stun_projectile = /obj/projectile/bullet/c57x39mm/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	lethal_projectile = /obj/projectile/bullet/c57x39mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	faction = list(FACTION_NGR, FACTION_PLAYER_SYNDICATE, "turret") //player_syndicate is just to be safe

/obj/machinery/porta_turret/ship/ngr/light
	name = "Sonoran Turret"
	desc = "A light turret manufactured by the New Gorlex Republic for its ships and installations. Proudly manufactured within the Nation, using locally produced munitions!"
	stun_projectile = /obj/projectile/bullet/c45/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	lethal_projectile = /obj/projectile/bullet/c45
	lethal_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	scan_range = 7
	shot_delay = 10

/obj/machinery/porta_turret/ship/ngr/heavy
	name = "Cliff Turret"
	desc = "A heavy turret manufactured by the New Gorlex Republic for its ships and installations. Has a reputation of being extremely dangerous."
	stun_projectile = /obj/projectile/bullet/a65clip/rubber
	stun_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	lethal_projectile = /obj/projectile/bullet/a65clip
	lethal_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	scan_range = 14
	shot_delay = 30


/* Inteq Turrets */
//slower rof, higher damage + range

/obj/machinery/porta_turret/ship/inteq
	name = "Vanguard Turret"
	desc = "A turret designed by IRMG engineers for defending ships from hostile flora, fauna, and people (and Elzousa, which count as flora and people)."
	stun_projectile = /obj/projectile/bullet/a762_40/rubber
	stun_projectile_sound = 'sound/weapons/gun/rifle/skm.ogg'
	lethal_projectile = /obj/projectile/bullet/a762_40
	lethal_projectile_sound = 'sound/weapons/gun/rifle/skm.ogg'
	scan_range = 9
	shot_delay = 20
	integrity_failure = 0.4
	faction = list(FACTION_PLAYER_INTEQ, "turret")

/obj/machinery/porta_turret/ship/inteq/light
	name = "Close-In Vanguard Turret"
	desc = "A light turret designed by IRMG engineers for the the task of defending from close-in encounters. Low power, high speed."
	stun_projectile = /obj/projectile/bullet/c10mm/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/vector_fire.ogg'
	lethal_projectile = /obj/projectile/bullet/c10mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/vector_fire.ogg'
	scan_range = 5
	shot_delay = 5

/obj/machinery/porta_turret/ship/inteq/heavy
	name = "Vanguard Overwatch Turret"
	desc = "A turret designed by IRMG engineers to provide long range defensive fire on their installations. Has a habit of leaving big holes."
	stun_projectile = /obj/projectile/bullet/a308/rubber
	stun_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	lethal_projectile = /obj/projectile/bullet/a308
	lethal_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	scan_range = 12
	shot_delay = 20

/* Solcon Turrets */

/obj/machinery/porta_turret/ship/solgov
	faction = list(FACTION_PLAYER_SOLCON, "turret")

/* Pan Gezena Federation Turrets */
//midline but hitscan

/obj/machinery/porta_turret/ship/pgf
	name = "Etherbor Defensive Mount"
	desc = "A less portable Etherbor offering, the EDM is a self-directed linkage of energy weapons, designed to keep intruders away from Gezenan vessels."
	faction = list(FACTION_PLAYER_GEZENA, "Turret")
	stun_projectile = /obj/projectile/beam/hitscan/disabler
	stun_projectile_sound = 'sound/weapons/gun/energy/kalixpistol.ogg'
	lethal_projectile = /obj/projectile/beam/hitscan/kalix/pgf/assault
	lethal_projectile_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'
	icon_state = "standard_lethal"
	base_icon_state = "standard"
	max_integrity = 250
	integrity_failure = 0.4

/obj/machinery/porta_turret/ship/pgf/light
	name = "Etherbor Deterrent System"
	desc = "A light turret manufactured by Etherbor. It offers a lightweight assembly of energy weapons to accost nearby foes."
	lethal_projectile = /obj/projectile/beam/hitscan/kalix/pgf
	lethal_projectile_sound = 'sound/weapons/gun/energy/kalixsmg.ogg'

/obj/machinery/porta_turret/ship/pgf/heavy
	name = "Etherbor Point-Defense System"
	desc = "A high-powered defensive turret manufactured by Etherbor. The EPDS contains heavy energy weapons linked in tandem."
	scan_range = 12
	stun_projectile = /obj/projectile/beam/hitscan/disabler/heavy
	stun_projectile_sound = 'sound/weapons/gun/energy/kalixpistol.ogg'
	lethal_projectile = /obj/projectile/beam/hitscan/kalix/pgf/sniper //fwoom
	lethal_projectile_sound = 'sound/weapons/gun/laser/heavy_laser.ogg'

///CLIP Turrets

//high damage low range

/obj/machinery/porta_turret/ship/clip
	name = "Clover Mintaka"
	desc = "Clover Photonic's offering for the Confederated League's 476FS \"Defense System\" competition, the Mintaka (and its sister systems, the Alnitak and Ori) handily beat out the Lunatex \"Vigil\" line during the final round of testing, and earned a prestigous contract."
	faction = list(FACTION_PLAYER_MINUTEMAN, "Turret")
	stun_projectile = /obj/projectile/beam/disabler
	stun_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	lethal_projectile = /obj/projectile/beam/laser/assault
	lethal_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	icon_state = "standard_lethal"
	base_icon_state = "standard"

	scan_range = 8
	shot_delay = 10
	max_integrity = 200
	integrity_failure = 0.3

/obj/machinery/porta_turret/ship/clip/light
	name = "Clover Alnitak"
	desc = "Clover Photonic's light turret system, unveiled as part of Clover's defense line-up in the early 470s. While lacking the punch of its sister systems, it still presents a hassle to circumvent."
	stun_projectile = /obj/projectile/beam/disabler
	stun_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	lethal_projectile = /obj/projectile/beam/laser/light
	lethal_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'

	scan_range = 6
	shot_delay = 10
	max_integrity = 200
	integrity_failure = 0.4

/obj/machinery/porta_turret/ship/clip/heavy
	name = "Clover Ori"
	desc = "Clover Photonic's heaviest entry in the Confederated League's 476FS \"Defense System\" competition, the Ori's results demolished the handily beat out the Lunatex \"Vigil Sword\" during testing, earning better marks on durability, effectiveness, and reaction rate."
	stun_projectile = /obj/projectile/beam/disabler
	stun_projectile_sound = 'sound/weapons/gun/laser/e-fire.ogg'
	lethal_projectile = /obj/projectile/beam/laser/heavylaser/assault
	lethal_projectile_sound = 'sound/weapons/gun/laser/e40_las.ogg'

	scan_range = 10
	shot_delay = 20
	max_integrity = 300
	integrity_failure = 0.3


/// Frontiersmen Turrets

// fast and spitty

/obj/machinery/porta_turret/ship/frontiersmen
	name = "Spitter Turret"
	desc = "A juryrigged mishmash of a 9mm SMG and targetting system. Stand clear!"
	faction = list(FACTION_FRONTIER, "Turret")
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	integrity_failure = 0.6
	max_integrity = 180

	icon_state = "standard_lethal"
	base_icon_state = "standard"

	stun_projectile = /obj/projectile/bullet/c9mm
	stun_projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	lethal_projectile = /obj/projectile/bullet/c9mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	shot_delay = 2
	scan_range = 6

	turret_flags = TURRET_FLAG_HOSTILE

/obj/machinery/porta_turret/ship/frontiersmen/light
	name = "Pounder Turret"
	desc = "A low caliber SMG with an atrociously high cycle rate, frankensteined together with a targetting assembly."
	stun_projectile = /obj/projectile/bullet/c22lr
	stun_projectile_sound = 'sound/weapons/gun/smg/pounder.ogg'
	lethal_projectile = /obj/projectile/bullet/c22lr
	lethal_projectile_sound = 'sound/weapons/gun/smg/pounder.ogg'
	shot_delay = 1

/obj/machinery/porta_turret/ship/frontiersmen/heavy
	name = "Mulcher Turret"
	desc = "An abombination made out of the components of a Shredder and an automatic targetting system. Careful now."
	stun_projectile = /obj/projectile/bullet/slug/beanbag
	stun_projectile_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	lethal_projectile = /obj/projectile/bullet/slug
	lethal_projectile_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	shot_delay = 3
	scan_range = 8
