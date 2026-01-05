/obj/machinery/porta_turret/ruin
	circuit = /obj/item/circuitboard/machine/turret/ruin
	scan_range = 9
	req_ship_access = FALSE
	turret_respects_id = FALSE
	icon_state = "syndie_off"
	base_icon_state = "syndie"
	turret_flags = TURRET_FLAG_HOSTILE
	lethal = 1

/* Ramzi Turrets */

/obj/machinery/porta_turret/ruin/ramzi
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

/obj/machinery/porta_turret/ruin/ramzi/light
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

/obj/machinery/porta_turret/ruin/ramzi/heavy
	name = "Revolt Turret"
	desc = "A durable turret manufactured by the Gorlex Marauders during the ICW. Some reported examples used anti-vehicle munitions. Most surviving examples are poorly maintained."
	stun_projectile = /obj/projectile/bullet/a65clip/rubber
	stun_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	lethal_projectile = /obj/projectile/bullet/a65clip
	lethal_projectile_sound = 'sound/weapons/gun/sniper/cmf90.ogg'
	scan_range = 12
	shot_delay = 20
	burst_size = 1
	max_integrity = 300
	integrity_failure = 0.6

/obj/machinery/porta_turret/ruin/ramzi/super_heavy
	name = "Rebellion Turret"
	desc = "A durable anti-vehicle turret system manufactured by the Gorlex Marauders during the ICW. Most users are unable to get more parts for the turret, leading to a slow reduction in the amount of redundant, working parts."
	stun_projectile = /obj/projectile/bullet/p50/soporific
	stun_projectile_sound = 'sound/weapons/gun/sniper/shot.ogg'
	lethal_projectile = /obj/projectile/bullet/p50
	lethal_projectile_sound = 'sound/weapons/gun/sniper/shot.ogg'
	scan_range = 14
	shot_delay = 30
	max_integrity = 350
	integrity_failure = 0.7

/* Frontiersmen Turrets */

/obj/machinery/porta_turret/ruin/frontiersmen
	name = "Spitter Turret"
	desc = "A juryrigged mishmash of a 9mm SMG and targetting system. Stand clear!"
	faction = list(FACTION_ANTAG_FRONTIERSMEN, FACTION_TURRET)
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
	shot_delay = 15
	burst_size = 4
	burst_delay = 3
	spread = 30

/obj/machinery/porta_turret/ruin/frontiersmen/light
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

/obj/machinery/porta_turret/ruin/frontiersmen/heavy
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

/* Nanotrasen Derelict Turrets */

/obj/machinery/porta_turret/ruin/nt
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

/obj/machinery/porta_turret/ruin/nt/light
	name = "Sharplite LDS"
	desc = "A cheap and effective 'defensive system' designed by Sharplite for installation on Nanotrasen vessels."
	stun_projectile = /obj/projectile/beam/disabler/weak/sharplite
	lethal_projectile = /obj/projectile/beam/laser/light/sharplite
	lethal_projectile_sound = 'sound/weapons/gun/laser/nt-fire.ogg'
	stun_projectile_sound = 'sound/weapons/taser2.ogg'

/obj/machinery/porta_turret/ruin/nt/light/sniper
	name = "Sharplite Long-Range LDS"
	desc = "A long-ranged 'defensive system' designed by Sharplite for installation on Nanotrasen stations."
	stun_projectile = /obj/projectile/beam/disabler/weak/sharplite
	lethal_projectile = /obj/projectile/beam/laser/light/sharplite
	lethal_projectile_sound = 'sound/weapons/gun/laser/nt-fire.ogg'
	stun_projectile_sound = 'sound/weapons/taser2.ogg'
	shot_delay = 15
	burst_size = 2
	burst_delay = 3

/obj/machinery/porta_turret/ruin/nt/heavy
	name = "Sharplite Defense Cannon"
	desc = "A heavy laser mounting designed by Sharplite for usage on Nanotrasen vessels."
	lethal_projectile = /obj/projectile/beam/laser/heavylaser/sharplite
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'
	max_integrity = 250
