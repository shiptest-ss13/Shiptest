/obj/mecha/medical/odysseus
	desc = "A high-end utility exosuit manufactured by Cybersun Biodynamics. The general medical variant of the 200 Series, the 202r features a high-speed leg design and advanced stabilization system to move patients safely over rough terrain."
	name = "\improper 202r Medical exosuit"
	icon_state = "odysseus"
	step_in = 2
	max_temperature = 15000
	max_integrity = 120
	wreckage = /obj/structure/mecha_wreckage/odysseus
	internal_damage_threshold = 35
	deflect_chance = 15
	base_step_energy_drain = 11

/obj/mecha/medical/odysseus/moved_inside(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		hud.add_hud_to(H)

/obj/mecha/medical/odysseus/go_out()
	if(isliving(occupant))
		var/mob/living/L = occupant
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		hud.remove_hud_from(L)
	..()

/obj/mecha/medical/odysseus/mmi_moved_inside(obj/item/mmi/M, mob/user)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		var/mob/living/brain/B = M.brainmob
		hud.add_hud_to(B)
