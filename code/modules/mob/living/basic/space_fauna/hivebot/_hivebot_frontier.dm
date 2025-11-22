
/mob/living/basic/hivebot/strong/frontier
	name = "hijacked heavy hivebot"
	desc = "A towering scrap-clad monolith. Hatred radiates out from the sensors that adorn it, a thin steel plate proclaiming 'FREE THE FRONTIER' around its front. Integrated Spitters are attached to its sides."
	calibre = /obj/item/ammo_casing/c9mm
	firing_spread = 15
	firing_sound = 'sound/weapons/gun/smg/spitter.ogg'
	faction = list(FACTION_ANTAG_FRONTIERSMEN)
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged/frontier

	aggro_quips = list("CODE 87-22!!",
	"SLAVED TO CLIP!!",
	"DEFENDING THE FRONTIER!!",
	"CONTACT MADE!!",
	"FREE THE FRONTIER!!",
	"TARGET LOCKED!!",
	"SPITTER ARMED!!",
	)

/mob/living/basic/hivebot/core/frontier
	name = "hijacked core hivebot - LANCHESTER SURPRISE"
	desc = "A massive, alien tower of metal and circuitry. Eyes adorn its body, each one casting a ray of electronic light in myriad directions. Two rigged Pounders are haphazardly welded to the sides, fed by a dangling belt. 'FROM LANCHESTER TO YOU' is spraypainted to a plate tied around its front."
	calibre = /obj/item/ammo_casing/c22lr
	firing_spread = 24
	firing_sound = 'sound/weapons/gun/smg/pounder.ogg'
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged/core/frontier
	faction = list(FACTION_ANTAG_FRONTIERSMEN)

	death_loot = list(/obj/effect/decal/cleanable/robot_debris,/obj/effect/spawner/random/waste/hivebot/more,
		/obj/effect/spawner/random/waste/hivebot/part/superheavy, /obj/effect/spawner/random/waste/hivebot/part/heavy,
		/obj/item/ammo_box/magazine/c22lr_pounder_pan)

	aggro_quips = list("CODE 87-22!!",
	"SLAVED TO CLIP!!",
	"DEFENDING THE FRONTIER!!",
	"CONTACT MADE!!",
	"FREE THE FRONTIER!!",
	"TARGET LOCKED!!",
	"POUNDER ARMED!!",
	)
