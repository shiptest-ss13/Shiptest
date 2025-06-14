/mob/living/basic/hivebot
	name = "hivebot"
	desc = "A human-sized automaton clad in the scrap of a dead world. Exposed circuitry sparks subtly as it analyzes the area around it."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "basic"
	icon_living = "basic"
	icon_dead = "basic"
	basic_mob_flags = DEL_ON_DEATH
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC

	health = 35
	maxHealth = 35

	melee_damage_lower = 8
	melee_damage_upper = 12

	speed = 2

	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	verb_say = "states"
	verb_ask = "queries"
	verb_exclaim = "declares"
	verb_yell = "alarms"
	bubble_icon = "machine"
	possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)
	faction = list(FACTION_HIVEBOT)

	speech_span = SPAN_ROBOT

	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)

	habitable_atmos = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minimum_survivable_temperature = TCMB
	ai_controller = /datum/ai_controller/basic_controller/hivebot

	initial_language_holder = /datum/language_holder/ipc

	//cooldown to scrap things
	COOLDOWN_DECLARE(salvage_cooldown)

	var/list/death_loot = list(/obj/effect/decal/cleanable/robot_debris,/obj/effect/spawner/random/waste/hivebot,
		/obj/effect/spawner/random/waste/hivebot/part)

	///does this type do range attacks?
	var/ranged_attacker = FALSE

	///what round does this hivebot use
	var/calibre = /obj/item/ammo_casing/c10mm
	///what does a hivebot shooting sound like
	var/firing_sound = 'sound/weapons/gun/pistol/shot.ogg'

	///aggro phrases on our hivebot
	var/list/aggro_quips = list("CODE 7-34!!",
		"CODE 7-11!!",
		"DEFEND TERMINUS!!",
		"ACTIVITY WITHIN AO!!",
		"INFILTRATOR WITHIN AO!!",
		"TERMINATE HOSTILE!!",
		"PLAN IMPLEMENTATION!!",
		"ASSESS - ENGAGE!!",
		"RECLAIM AREA!!",
		"ENFORCING CLAIM!!"
	)

/mob/living/basic/hivebot/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/death_drops, death_loot)
	AddComponent(/datum/component/appearance_on_aggro, overlay_icon = icon, overlay_state = "[initial(icon_state)]_attack")
	AddComponent(/datum/component/light_on_aggro, 6, 0.4, LIGHT_COLOR_INTENSE_RED)
	AddComponent(/datum/component/aggro_speech, phrase_list = aggro_quips, phrase_chance = 30)
	if(!ranged_attacker)
		return
	AddComponent(/datum/component/ranged_attacks, calibre, null, firing_sound)

/mob/living/basic/hivebot/death(gibbed)
	do_sparks(n = 3, c = TRUE, source = src)
	return ..()

/mob/living/basic/hivebot/ranged
	name = "combat hivebot"
	desc = "A human-sized automaton clad in the scrap of a dead world. A weapon pivots around on its top, searching for a target to engage."
	icon_state = "ranged"
	icon_living = "ranged"
	icon_dead = "ranged"
	ranged_attacker = TRUE
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged

/mob/living/basic/hivebot/rapid
	icon_state = "ranged"
	icon_living = "ranged"
	icon_dead = "ranged"
	ranged_attacker = TRUE
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged/rapid

/mob/living/basic/hivebot/strong
	name = "heavy hivebot"
	desc = "A towering scrap-clad monolith. Hatred radiates out from the sensors that adorn it, beams of subtle light coming from within its sparking core."
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	armor = list("melee" = 30, "bullet" = 40, "laser" = 20, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)
	health = 80
	maxHealth = 80
	ranged_attacker = TRUE
	calibre = /obj/item/ammo_casing/a308

	death_loot = list(/obj/effect/decal/cleanable/robot_debris,/obj/effect/spawner/random/waste/hivebot,
		/obj/effect/spawner/random/waste/hivebot/part/heavy)

	firing_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged

	speed = 6

/mob/living/basic/hivebot/core //slave to the system
	name = "core hivebot"
	desc = "A massive, alien tower of metal and circuitry. Eyes adorn its body, each one casting a ray of electronic light in myriad directions. Slaved to its whim is a scrapped turret mounting, angrily glancing at the world around it."
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	armor = list("melee" = 40, "bullet" = 60, "laser" = 30, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)
	health = 120
	maxHealth = 120
	melee_damage_lower = 25
	melee_damage_upper = 40
	ranged_attacker = TRUE
	calibre = /obj/item/ammo_casing/a308
	firing_sound = 'sound/weapons/gun/rifle/hydra.ogg'
	ai_controller = /datum/ai_controller/basic_controller/hivebot/ranged/core

	death_loot = list(/obj/effect/decal/cleanable/robot_debris,/obj/effect/spawner/random/waste/hivebot/more,
		/obj/effect/spawner/random/waste/hivebot/part/superheavy, /obj/effect/spawner/random/waste/hivebot/part/heavy)

	speed = 8

	aggro_quips = list("CODE 87-22!!",
	"SLAVED TO SYSTEM!!",
	"DEFENDING AREA!!",
	"CONTACT MADE!!",
	"ERADICATE HOSTILES!!",
	"RECEIVING COURSE!!",
	"TARGET LOCKED!!",
	"CANNON ARMED!!",
	)

/mob/living/basic/hivebot/core/Initialize(mapload)
	. = ..()
	transform *= 1.3

/mob/living/basic/hivebot/core/death(gibbed)
	//once we get better sprites i want this to be like the claw's death. aka fucking cool.
	radiation_pulse(src, 500)
	explosion(src, 0,1,3,3,)
	..(TRUE)

/mob/living/basic/hivebot/mechanic
	name = "hivebot mechanic"
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	desc = "A tidy, discordant machine made of scrap, adorned with analyzers, waldos, and touching eyes."
	health = 60
	maxHealth = 60
	ranged_attacker = TRUE
	ai_controller = /datum/ai_controller/basic_controller/hivebot/mechanic
	///cooldown to repair machines
	COOLDOWN_DECLARE(repair_cooldown)
	var/datum/action/innate/hivebot/foamwall/foam

/mob/living/basic/hivebot/mechanic/Initialize(mapload)
	. = ..()
	foam = new
	foam.Grant(src)
	RegisterSignal(src, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(pre_attack))

/mob/living/basic/hivebot/mechanic/proc/pre_attack(mob/living/fixer, atom/target)
	SIGNAL_HANDLER

	if(ismachinery(target))
		repair_machine(target)
		return COMPONENT_HOSTILE_NO_ATTACK

	if(istype(target, /mob/living/basic/hivebot))
		repair_hivebot(target)
		return COMPONENT_HOSTILE_NO_ATTACK

/mob/living/basic/hivebot/mechanic/proc/repair_machine(obj/machinery/fixable)
	if(fixable.obj_integrity >= fixable.max_integrity)
		to_chat(src, span_warning("Diagnostics indicate that this machine is at peak integrity."))
		return
	if(!COOLDOWN_FINISHED(src, repair_cooldown))
		balloon_alert(src, "recharging!")
		return
	fixable.obj_integrity = fixable.max_integrity
	do_sparks(n = 3, c = TRUE, source = fixable)
	to_chat(src, span_warning("Repairs complete!"))
	COOLDOWN_START(src, repair_cooldown, 50 SECONDS)

/mob/living/basic/hivebot/mechanic/proc/repair_hivebot(mob/living/basic/bot_target)
	if(bot_target.health >= bot_target.maxHealth)
		to_chat(src, span_warning("Diagnostics indicate that this unit is at peak integrity."))
		return
	if(!COOLDOWN_FINISHED(src, repair_cooldown))
		balloon_alert(src, "recharging!")
		return
	bot_target.revive(TRUE)
	do_sparks(n = 3, c = TRUE, source = bot_target)
	to_chat(src, span_warning("Repairs complete!"))
	COOLDOWN_START(src, repair_cooldown, 50 SECONDS)

/mob/living/basic/hivebot/proc/salvage_machine(obj/structure/salvageable/scrap)
	if(!COOLDOWN_FINISHED(src, salvage_cooldown))
		balloon_alert(src, "recharging!")
		return
	if(scrap.salvageable_parts)
		for(var/path in scrap.salvageable_parts)
			maxHealth += 5
		scrap.salvageable_parts = null
	scrap.dismantle(src)
	do_sparks(n = 3, c = TRUE, source = scrap)
	to_chat(src, span_warning("Salvaging complete!"))
	COOLDOWN_START(src, salvage_cooldown, 50 SECONDS)

/datum/action/innate/hivebot/foamwall/Activate()
	var/mob/living/basic/hivebot/our_hivebot = owner
	var/turf/T = get_turf(our_hivebot)
	if(T.density)
		to_chat(our_hivebot, span_warning("There's already something on this tile!"))
		return
	to_chat(our_hivebot, span_warning("You begin to create a foam wall at your position..."))
	if(do_after(our_hivebot, 50, target = our_hivebot))
		for(var/obj/structure/foamedmetal/FM in T.contents)
			to_chat(our_hivebot, span_warning("There's already a foam wall on this tile!"))
			return
		new /obj/structure/foamedmetal(our_hivebot.loc)
		playsound(get_turf(our_hivebot), 'sound/effects/extinguish.ogg', 50, TRUE, -1)

