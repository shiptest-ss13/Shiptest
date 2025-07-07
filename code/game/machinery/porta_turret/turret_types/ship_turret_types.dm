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
			. += span_notice("[src] reports its integrity is currently [round((obj_integrity / max_integrity) * 100)] percent.")

/obj/machinery/porta_turret/ship/weak
	max_integrity = 120
	integrity_failure = 0.5
	name = "Old Laser Turret"
	desc = "A turret built with substandard parts and run down further with age. Still capable of delivering lethal lasers to the odd space carp, but not much else."
	stun_projectile = /obj/projectile/beam/disabler/weak
	lethal_projectile = /obj/projectile/beam/weak/penetrator
	faction = list("neutral", FACTION_TURRET)

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
	faction = list(FACTION_PLAYER_NANOTRASEN, FACTION_TURRET)
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

/* New Gorlex Republic Turrets */
// Midline ballistic turrets

/obj/machinery/porta_turret/ship/ngr
	name = "Oasis Turret"
	desc = "A turret manufactured by the New Gorlex Republic for its ships and installations. Proudly manufactured within the nation!"
	stun_projectile = /obj/projectile/bullet/c57x39mm/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	lethal_projectile = /obj/projectile/bullet/c57x39mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	faction = list(FACTION_NGR, FACTION_TURRET)
	shot_delay = 20
	burst_delay = 3
	burst_size = 3

/obj/machinery/porta_turret/ship/ngr/light
	name = "Sonoran Turret"
	desc = "A light turret manufactured by the New Gorlex Republic for its ships and installations. Proudly manufactured within the Nation, using locally produced munitions!"
	stun_projectile = /obj/projectile/bullet/c45/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	lethal_projectile = /obj/projectile/bullet/c45
	lethal_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	scan_range = 7
	shot_delay = 12
	burst_delay = 4
	burst_size = 2

/obj/machinery/porta_turret/ship/ngr/heavy
	name = "Cliff Turret"
	desc = "A heavy turret manufactured by the New Gorlex Republic for its ships and installations. Has a reputation of being extremely dangerous."
	stun_projectile = /obj/projectile/bullet/a65clip/rubber
	stun_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	lethal_projectile = /obj/projectile/bullet/a65clip
	lethal_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	burst_size = 1
	scan_range = 14
	shot_delay = 30

/* Hardliner Turrets */
/* Same as NGR turrets (mostly) until we get cybersun weapons */

/obj/machinery/porta_turret/ship/hardliners
	name = "Verdict Turret"
	desc = "A turret traditionally found mounted on mercenary vessels in the frontier. Reported to be of good make by Turret Lover Monthly (December, 502FSC)"
	stun_projectile = /obj/projectile/bullet/c57x39mm/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	lethal_projectile = /obj/projectile/bullet/c57x39mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/sidewinder.ogg'
	faction = list(FACTION_HARDLINERS, FACTION_PLAYER_SYNDICATE, FACTION_TURRET)
	shot_delay = 25
	burst_delay = 5
	burst_size = 4

/obj/machinery/porta_turret/ship/hardliners/light
	name = "Discharge Turret" //prime candidate to be a weird cybersun electro-gun toy.
	desc = "A light turret typically found mounted on mercenary and independent vessels as a cheap, aftermarket modification." //do not put these on indie vessels
	stun_projectile = /obj/projectile/bullet/c45/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	lethal_projectile = /obj/projectile/bullet/c45
	lethal_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	scan_range = 7
	shot_delay = 12
	burst_delay = 4
	burst_size = 2

/obj/machinery/porta_turret/ship/hardliners/heavy
	name = "Acquittal Turret"
	desc = "A heavy turret often found mounted as an after-market modification on mercenary vessels."
	stun_projectile = /obj/projectile/bullet/a308/rubber
	stun_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	lethal_projectile = /obj/projectile/bullet/a308
	lethal_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	scan_range = 14
	shot_delay = 30
	burst_delay = 3
	burst_size = 2

/* Ramzi Turrets */
/* Near NGR turrets in power. Easier to destroy */

/obj/machinery/porta_turret/ship/ramzi
	name = "Resistance Turret"
	desc = "A midline turret manufactured by the Gorlex Marauders during the ICW. Most surviving examples have experienced less than stellar upkeep."
	stun_projectile = /obj/projectile/bullet/a556_42/rubber
	stun_projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	lethal_projectile = /obj/projectile/bullet/a556_42
	lethal_projectile_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	faction = list(FACTION_RAMZI, FACTION_TURRET)
	max_integrity = 180
	shot_delay = 16
	burst_delay = 8
	burst_size = 2
	integrity_failure = 0.6

/obj/machinery/porta_turret/ship/ramzi/light
	name = "Strike Turret"
	desc = "A light turret manufactured by the Gorlex Marauders during the ICW. Most surviving examples are poorly maintained."
	stun_projectile = /obj/projectile/bullet/c45/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	lethal_projectile = /obj/projectile/bullet/c45
	lethal_projectile_sound = 'sound/weapons/gun/smg/cobra.ogg'
	scan_range = 8
	shot_delay = 16
	burst_delay = 6
	burst_size = 2
	max_integrity = 140
	integrity_failure = 0.6

/obj/machinery/porta_turret/ship/ramzi/heavy
	name = "Revolt Turret"
	desc = "A durable turret manufactured by the Gorlex Marauders during the ICW. Some reported examples used anti-vehicle munitions. Most surviving examples are poorly maintained."
	stun_projectile = /obj/projectile/bullet/a65clip/rubber
	stun_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	lethal_projectile = /obj/projectile/bullet/a65clip
	lethal_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	scan_range = 12
	shot_delay = 20
	max_integrity = 300
	integrity_failure = 0.6
	burst_size = 1

/obj/machinery/porta_turret/ship/ramzi/super_heavy
	name = "Rebellion Turret"
	desc = "A durable anti-vehicle turret system manufactured by the Gorlex Marauders during the ICW. Most users are unable to get more parts for the turret, leading to a slow reduction in the amount of redundant, working parts."
	stun_projectile = /obj/item/ammo_casing/p50/soporific
	stun_projectile_sound = 'sound/weapons/gun/sniper/shot.ogg'
	lethal_projectile = /obj/item/ammo_casing/p50
	lethal_projectile_sound = 'sound/weapons/gun/sniper/shot.ogg'
	scan_range = 14
	shot_delay = 30
	max_integrity = 350
	integrity_failure = 0.7
	burst_size = 1

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
	faction = list(FACTION_PLAYER_INTEQ, FACTION_TURRET)

/obj/machinery/porta_turret/ship/inteq/light
	name = "Close-In Vanguard Turret"
	desc = "A light turret designed by IRMG engineers for the the task of defending from close-in encounters. Low power, high speed."
	stun_projectile = /obj/projectile/bullet/c10mm/rubber
	stun_projectile_sound = 'sound/weapons/gun/smg/vector_fire.ogg'
	lethal_projectile = /obj/projectile/bullet/c10mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/vector_fire.ogg'
	scan_range = 5
	burst_size = 4
	burst_delay = 5
	shot_delay = 20

/obj/machinery/porta_turret/ship/inteq/heavy
	name = "Vanguard Overwatch Turret"
	desc = "A turret designed by IRMG engineers to provide long range defensive fire on their installations. Has a habit of leaving big holes."
	stun_projectile = /obj/projectile/bullet/a308/rubber
	stun_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	lethal_projectile = /obj/projectile/bullet/a308
	lethal_projectile_sound = 'sound/weapons/gun/rifle/f4.ogg'
	scan_range = 12
	shot_delay = 20

/* SolCon Turrets */
/* Gauss with no non-lethal option */
/* Effective at long range */

/obj/machinery/porta_turret/ship/solcon
	name = "Type Fauchard Emplacement" // <- women who cannot do solcon names good
	desc = "A long range turret manufactured by the Solarbundswaffenkammer. It is rated for combat usage, and has a higher than average lethality index."
	faction = list(FACTION_PLAYER_SOLCON, FACTION_TURRET)
	stun_projectile = /obj/projectile/bullet/gauss/hc
	stun_projectile_sound = 'sound/weapons/gun/gauss/claris.ogg'
	lethal_projectile = /obj/projectile/bullet/gauss
	lethal_projectile_sound = 'sound/weapons/gun/gauss/claris.ogg'
	max_integrity = 200
	integrity_failure = 0.6
	scan_range = 14
	shot_delay = 40
	burst_size = 4
	burst_delay = 3
	spread = 10

/obj/machinery/porta_turret/ship/solcon/slug
	name = "Type Guisarme Emplacement"
	desc = "A short range turret emplacement manufactured by the Solarbundswaffenkammer. The slug rounds used have given it a reputation for incredible effect against unarmored targets, and performance issues at range."
	faction = list(FACTION_PLAYER_SOLCON, FACTION_TURRET)
	stun_projectile = /obj/projectile/bullet/gauss/slug/hc
	stun_projectile_sound = 'sound/weapons/gun/gauss/claris.ogg'
	lethal_projectile = /obj/projectile/bullet/gauss/slug
	lethal_projectile_sound = 'sound/weapons/gun/gauss/claris.ogg'
	max_integrity = 300
	integrity_failure = 0.6
	scan_range = 8
	shot_delay = 25
	burst_size = 2
	burst_delay = 5

/obj/machinery/porta_turret/ship/solcon/lance
	name = "Type Glaive Emplacement"
	desc = "A heavy turret emplacement manufactured by the Solarbundswaffenkammer. Long cycle time between volleys is the only weakness attributed to the turret, as it is effective against targets up to exo-armor."
	faction = list(FACTION_PLAYER_SOLCON, FACTION_TURRET)
	stun_projectile = /obj/projectile/bullet/gauss/lance/hc
	stun_projectile_sound = 'sound/weapons/gun/gauss/gar.ogg'
	lethal_projectile = /obj/projectile/bullet/gauss/lance
	lethal_projectile_sound = 'sound/weapons/gun/gauss/gar.ogg'
	max_integrity = 300
	integrity_failure = 0.5
	scan_range = 16
	shot_delay = 60
	burst_size = 3
	burst_delay = 4

/* Pan Gezena Federation Turrets */
//midline but hitscan

/obj/machinery/porta_turret/ship/pgf
	name = "Etherbor Defensive Mount"
	desc = "A less portable Etherbor offering, the EDM is a self-directed linkage of energy weapons, designed to keep intruders away from Gezenan vessels."
	faction = list(FACTION_PLAYER_GEZENA, FACTION_TURRET)
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
	faction = list(FACTION_PLAYER_MINUTEMAN, FACTION_TURRET)
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
	burst_delay = 4
	burst_size = 2
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
	faction = list(FACTION_FRONTIERSMEN, FACTION_TURRET)
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	integrity_failure = 0.6
	max_integrity = 180

	icon_state = "standard_lethal"
	base_icon_state = "standard"

	stun_projectile = /obj/projectile/bullet/c9mm
	stun_projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	lethal_projectile = /obj/projectile/bullet/c9mm
	lethal_projectile_sound = 'sound/weapons/gun/smg/spitter.ogg'
	scan_range = 6
	shot_delay = 15
	burst_size = 4
	burst_delay = 3
	spread = 30

	turret_flags = TURRET_FLAG_HOSTILE

/obj/machinery/porta_turret/ship/frontiersmen/light
	name = "Pounder Turret"
	desc = "A low caliber SMG with an atrociously high cycle rate, frankensteined together with a targetting assembly."
	stun_projectile = /obj/projectile/bullet/c22lr
	stun_projectile_sound = 'sound/weapons/gun/smg/pounder.ogg'
	lethal_projectile = /obj/projectile/bullet/c22lr
	lethal_projectile_sound = 'sound/weapons/gun/smg/pounder.ogg'
	shot_delay = 15
	burst_delay = 1
	burst_size = 10
	spread = 45

/obj/machinery/porta_turret/ship/frontiersmen/heavy
	name = "Mulcher Turret"
	desc = "An abombination made out of the components of a Shredder and an automatic targetting system. Careful now."
	stun_projectile = /obj/projectile/bullet/slug/beanbag
	stun_projectile_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	lethal_projectile = /obj/projectile/bullet/slug
	lethal_projectile_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	shot_delay = 20
	scan_range = 8
	burst_size = 6
	burst_delay = 2
