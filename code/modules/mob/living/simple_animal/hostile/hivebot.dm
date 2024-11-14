/mob/living/simple_animal/hostile/hivebot
	name = "hivebot"
	desc = "A human-sized automaton clad in the scrap of a dead world. Exposed circuitry sparks subtly as it analyzes the area around it."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "basic"
	icon_living = "basic"
	icon_dead = "basic"
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	health = 35
	maxHealth = 35
	healable = 0
	melee_damage_lower = 8
	melee_damage_upper = 12

	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	casingtype = /obj/item/ammo_casing/c10mm
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'

	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)

	faction = list("hivebot")
	check_friendly_fire = 1
	atmos_requirements = IMMUNE_ATMOS_REQS
	possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)
	minbodytemp = 0
	verb_say = "states"
	verb_ask = "queries"
	verb_exclaim = "declares"
	verb_yell = "alarms"
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT
	del_on_death = 1
	minbodytemp = 0
	maxbodytemp = 600
	loot = list(/obj/effect/decal/cleanable/robot_debris)

	//yeah so it turns out that /simple_animal/hostile gets upset when you call say because say contains a sleep. so we have to do this on subtypes.
	var/list/aggro_blurb = list("INFILTRATOR WITHIN AO!!", "TERMINATE HOSTILE!!", "DEFEND TERMINUS!!", "CODE 7-34!!")
	var/aggro_blurb_chance = 10

	var/alert_light

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/hivebot/Initialize(mapload)
	. = ..()
	deathmessage = "[src] blows apart!"

/mob/living/simple_animal/hostile/hivebot/Aggro()
	. = ..()
	a_intent_change(INTENT_HARM)
	update_icons()
	if(prob(aggro_blurb_chance))
		say("[pick(aggro_blurb)]", forced = type)


/mob/living/simple_animal/hostile/hivebot/LoseAggro()
	. = ..()
	a_intent_change(INTENT_HELP)

/mob/living/simple_animal/hostile/hivebot/a_intent_change(input as text)
	. = ..()
	update_icons()

/mob/living/simple_animal/hostile/hivebot/update_icons()
	QDEL_NULL(alert_light)
	if(a_intent != INTENT_HELP)
		icon_state = "[initial(icon_state)]_attack"
		alert_light = mob_light(6, 0.4, COLOR_RED_LIGHT)
	else
		icon_state = initial(icon_state)

/mob/living/simple_animal/hostile/hivebot/death(gibbed)
	do_sparks(3, TRUE, src)
	new /obj/effect/spawner/random/waste/hivebot(loc)
	..(TRUE)

/mob/living/simple_animal/hostile/hivebot/ranged
	name = "combat hivebot"
	desc = "A human-sized automaton clad in the scrap of a dead world. A weapon pivots around on its top, searching for a target to engage."
	icon_state = "ranged"
	icon_living = "ranged"
	icon_dead = "ranged"
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5

/mob/living/simple_animal/hostile/hivebot/ranged/rapid
	ranged = TRUE
	rapid = 3
	casingtype = /obj/item/ammo_casing/c57x39mm
	projectilesound = 'sound/weapons/gun/smg/sidewinder.ogg'

/mob/living/simple_animal/hostile/hivebot/strong
	name = "heavy hivebot"
	desc = "A towering scrap-clad monolith. Hatred radiates out from the sensors that adorn it, beams of subtle light coming from within its sparking core."
	armor = list("melee" = 30, "bullet" = 40, "laser" = 20, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	health = 80
	maxHealth = 80
	ranged = TRUE
	casingtype = /obj/item/ammo_casing/mm712x82
	projectilesound = 'sound/weapons/gun/rifle/hydra.ogg'
	melee_damage_lower = 12
	melee_damage_upper = 20
	move_to_delay = 7

/mob/living/simple_animal/hostile/hivebot/defender //slave to the system
	name = "core hivebot"
	desc = "A massive, alien tower of metal and circuitry. Eyes adorn its body, each one casting a ray of electronic light in myriad directions. Slaved to its whim is a scrapped turret mounting, angrily glancing at the world around it."
	armor = list("melee" = 40, "bullet" = 60, "laser" = 30, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 100, "fire" = 50, "acid" = 0)
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	health = 120
	maxHealth = 120
	ranged = TRUE

	casingtype = /obj/item/ammo_casing/mm712x82
	projectilesound = 'sound/weapons/gun/rifle/hydra.ogg'
	rapid = 3

	retreat_distance = 3
	minimum_distance = 5

	melee_damage_lower = 15
	melee_damage_upper = 28

	move_to_delay = 15

/mob/living/simple_animal/hostile/hivebot/defender/Initialize(mapload)
	. = ..()
	transform *= 1.3

/mob/living/simple_animal/hostile/hivebot/mechanic
	name = "hivebot mechanic"
	icon_state = "strong"
	icon_living = "strong"
	icon_dead = "strong"
	desc = "A tidy yet discordant machine of scrap, adorned with analyzers, waldos, and touching eyes."
	health = 60
	maxHealth = 60
	ranged = TRUE
	rapid = 3
	var/datum/action/innate/hivebot/foamwall/foam

/mob/living/simple_animal/hostile/hivebot/mechanic/Initialize(mapload)
	. = ..()
	foam = new
	foam.Grant(src)

/mob/living/simple_animal/hostile/hivebot/mechanic/AttackingTarget()
	if(istype(target, /obj/machinery))
		var/obj/machinery/fixable = target
		if(fixable.obj_integrity >= fixable.max_integrity)
			to_chat(src, "<span class='warning'>Diagnostics indicate that this machine is at peak integrity.</span>")
			return
		to_chat(src, "<span class='warning'>You begin repairs...</span>")
		if(do_after(src, 50, target = fixable))
			fixable.obj_integrity = fixable.max_integrity
			do_sparks(3, TRUE, fixable)
			to_chat(src, "<span class='warning'>Repairs complete.</span>")
		return
	if(istype(target, /mob/living/simple_animal/hostile/hivebot))
		var/mob/living/simple_animal/hostile/hivebot/fixable = target
		if(fixable.health >= fixable.maxHealth)
			to_chat(src, "<span class='warning'>Diagnostics indicate that this unit is at peak integrity.</span>")
			return
		to_chat(src, "<span class='warning'>You begin repairs...</span>")
		if(do_after(src, 50, target = fixable))
			fixable.revive(full_heal = TRUE, admin_revive = TRUE)
			do_sparks(3, TRUE, fixable)
			to_chat(src, "<span class='warning'>Repairs complete.</span>")
		return
	return ..()

/datum/action/innate/hivebot
	background_icon_state = "bg_default"

/datum/action/innate/hivebot/foamwall
	name = "Foam Wall"
	desc = "Creates a foam wall that resists against the vacuum of space."

/datum/action/innate/hivebot/foamwall/Activate()
	var/mob/living/simple_animal/hostile/hivebot/H = owner
	var/turf/T = get_turf(H)
	if(T.density)
		to_chat(H, "<span class='warning'>There's already something on this tile!</span>")
		return
	to_chat(H, "<span class='warning'>You begin to create a foam wall at your position...</span>")
	if(do_after(H, 50, target = H))
		for(var/obj/structure/foamedmetal/FM in T.contents)
			to_chat(H, "<span class='warning'>There's already a foam wall on this tile!</span>")
			return
		new /obj/structure/foamedmetal(H.loc)
		playsound(get_turf(H), 'sound/effects/extinguish.ogg', 50, TRUE, -1)
