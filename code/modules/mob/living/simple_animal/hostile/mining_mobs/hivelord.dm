/mob/living/simple_animal/hostile/asteroid/hivelord
	name = "hivelord"
	desc = "A truly alien creature, it is a mass of unknown organic material, constantly fluctuating. When attacking, pieces of it split off and attack in tandem with the original."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Hivelord"
	icon_living = "Hivelord"
	icon_aggro = "Hivelord_alert"
	icon_dead = "Hivelord_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	move_to_delay = 14
	ranged = 1
	vision_range = 5
	aggro_vision_range = 9
	speed = 3
	maxHealth = 75
	health = 75
	harm_intent_damage = 5
	melee_damage_lower = 0
	melee_damage_upper = 0
	attack_verb_continuous = "lashes out at"
	attack_verb_simple = "lash out at"
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_message = "falls right through the strange body of the"
	ranged_cooldown = 0
	ranged_cooldown_time = 20
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 3
	minimum_distance = 3
	pass_flags = PASSTABLE
	loot = list(/obj/item/organ/regenerative_core)
	var/brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood
	var/difficulty = 1

/mob/living/simple_animal/hostile/asteroid/hivelord/OpenFire(the_target)
	if(world.time >= ranged_cooldown)
		for(var/i in 1 to difficulty)
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/A = new brood_type(get_turf(src),src)

			A.flags_1 |= (flags_1 & ADMIN_SPAWNED_1)
			A.GiveTarget(target)
			A.friends = friends
			A.faction = faction.Copy()
		ranged_cooldown = world.time + ranged_cooldown_time

/mob/living/simple_animal/hostile/asteroid/hivelord/AttackingTarget()
	OpenFire()
	return TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/spawn_mob_trophy()
	if(mob_trophy)
		loot += mob_trophy //we don't butcher

/mob/living/simple_animal/hostile/asteroid/hivelord/death(gibbed)
	mouse_opacity = MOUSE_OPACITY_ICON
	..(gibbed)

//A fragile but rapidly produced creature
/mob/living/simple_animal/hostile/asteroid/hivelordbrood
	name = "hivelord brood"
	desc = "A fragment of the original Hivelord, rallying behind its original. One isn't much of a threat, but..."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Hivelordbrood"
	icon_living = "Hivelordbrood"
	icon_aggro = "Hivelordbrood"
	icon_dead = "Hivelordbrood"
	icon_gib = "syndicate_gib"
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	move_to_delay = 1
	friendly_verb_continuous = "buzzes near"
	friendly_verb_simple = "buzz near"
	vision_range = 10
	speed = 3
	maxHealth = 1
	health = 1
	movement_type = FLYING
	harm_intent_damage = 5
	melee_damage_lower = 2
	melee_damage_upper = 2
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_message = "falls right through the strange body of the"
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE | PASSMOB
	density = FALSE
	del_on_death = 1
	var/mob/source

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/Initialize(_source)
	. = ..()
	source = source
	addtimer(CALLBACK(src, PROC_REF(death)), 100)
	AddComponent(/datum/component/swarming)

//Legion
/mob/living/simple_animal/hostile/asteroid/hivelord/legion
	name = "legion"
	desc = "You can still see what was once a human under the shifting mass of corruption."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "legion"
	icon_living = "legion"
	icon_aggro = "legion"
	icon_dead = "legion"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mouse_opacity = MOUSE_OPACITY_ICON
	obj_damage = 60
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "lashes out at"
	attack_verb_simple = "lash out at"
	speak_emote = list("echoes")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_message = "bounces harmlessly off of"
	loot = list(/obj/item/organ/regenerative_core/legion)
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion
	mob_trophy = /obj/item/mob_trophy/legion_skull
	del_on_death = 1
	stat_attack = HARD_CRIT
	robust_searching = 1
	var/dwarf_mob = FALSE
	var/mob/living/carbon/human/stored_mob

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	if(prob(15))
		new /obj/item/mob_trophy/legion_skull(loc)
		visible_message("<span class='warning'>One of the [src]'s skulls looks intact.</span>")
	..()

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf(loc)
	if(prob(5))
		new /mob/living/simple_animal/hostile/big_legion(loc)
		return INITIALIZE_HINT_QDEL

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf
	name = "dwarf legion"
	desc = "You can still see what was once a rather small human under the shifting mass of corruption. It seems quick on its feet."
	icon_state = "dwarf_legion"
	icon_living = "dwarf_legion"
	icon_aggro = "dwarf_legion"
	icon_dead = "dwarf_legion"
	//mob_trophy = /obj/item/mob_trophy/dwarf_skull
	maxHealth = 150
	health = 150
	move_to_delay = 2
	speed = 1 //much faster!
	dwarf_mob = TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/death(gibbed)
	visible_message("<span class='warning'>The skulls on [src] wail in anger as they flee from their dying host!</span>")
	var/turf/T = get_turf(src)
	if(T)
		if(stored_mob)
			stored_mob.forceMove(get_turf(src))
			stored_mob = null
		else if(from_nest)
			new /obj/effect/mob_spawn/human/corpse/charredskeleton(T)
		else if(dwarf_mob)
			new /obj/effect/mob_spawn/human/corpse/damaged/legioninfested/dwarf(T)
		else
			new /obj/effect/mob_spawn/human/corpse/damaged/legioninfested(T)
	..(gibbed)

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest
	from_nest = TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/nest
	from_nest = TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	..()

//Legion skull
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion
	name = "legion"
	desc = "One of many."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "legion_head"
	icon_living = "legion_head"
	icon_aggro = "legion_head"
	icon_dead = "legion_head"
	icon_gib = "syndicate_gib"
	friendly_verb_continuous = "buzzes near"
	friendly_verb_simple = "buzz near"
	vision_range = 10
	maxHealth = 1
	health = 5
	harm_intent_damage = 5
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	speak_emote = list("echoes")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_message = "is shrugged off by"
	del_on_death = TRUE
	stat_attack = SOFT_CRIT
	robust_searching = 1
	var/can_infest_dead = FALSE

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/staff
	name = "emaciated legion"
	desc = "One of many. This one was spawned from a surrogate host, and is quite short-lived and nearsighted. However, it is freindly to humans."
	color = "#c8e6fb"
	melee_damage_lower = 10
	melee_damage_upper = 10
	vision_range = 5

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/staff/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(death)), 5 SECONDS)
	AddComponent(/datum/component/swarming)

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/Life()
	. = ..()
	if(stat == DEAD || !isturf(loc))
		return
	for(var/mob/living/carbon/human/victim in range(src, 1)) //Only for corpse right next to/on same tile
		if(istype(victim.getorganslot(ORGAN_SLOT_REGENERATIVE_CORE), /obj/item/organ/legion_skull)) // no double dipping
			continue
		switch(victim.stat)
			if(UNCONSCIOUS, HARD_CRIT)
				infest(victim)
				return //This will qdelete the legion.
			if(DEAD)
				if(can_infest_dead)
					infest(victim)
					return //This will qdelete the legion.

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/proc/infest(mob/living/carbon/human/H)
	visible_message(span_warning("[name] burrows into [H]!"))
	to_chat(H, span_boldwarning("You feel something digging into your body..."))
	if(H.stat != DEAD)
		var/obj/item/organ/legion_skull/throwyouabone = new()
		throwyouabone.Insert(H)
	else
		var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L
		if(HAS_TRAIT(H, TRAIT_DWARF)) //dwarf legions aren't just fluff!
			L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/dwarf(H.loc)
		else
			L = new(H.loc)
		visible_message(span_warning("[L] staggers to [L.p_their()] feet!"))
		H.adjustBruteLoss(1000)
		L.stored_mob = H
		H.forceMove(L)
	qdel(src)

/obj/item/organ/legion_skull
	name = "legion skull"
	desc = "The skull of a legion, likely torn from a soon-to-be host."
	icon_state = "legion_skull"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_REGENERATIVE_CORE
	grind_results = list(/datum/reagent/medicine/soulus = 2, /datum/reagent/blood = 5)
	var/datum/disease/transformation/legionvirus/malignance
	var/malignance_countdown = 5 MINUTES
	var/malignance_tracker

/obj/item/organ/legion_skull/on_find(mob/living/finder)
	..()
	to_chat(finder, span_warning("You found a skull-shaped growth in [owner]'s [zone]!"))

/obj/item/organ/legion_skull/Insert(mob/living/carbon/M, special = 0)
	..()
	malignance = new()
	malignance.infect(M, FALSE) //we handle all the fancy virus stuff in the organ, so we need a reference for it
	malignance_tracker = addtimer(CALLBACK(src, PROC_REF(update_stage)), malignance_countdown, TIMER_STOPPABLE|TIMER_DELETE_ME)
	M.heal_overall_bleeding(12) //stop dying so fast

/obj/item/organ/legion_skull/Remove(mob/living/carbon/M, special = 0)
	malignance_countdown = initial(malignance_countdown)
	deltimer(malignance_tracker)
	malignance_tracker = null
	malignance.cure()
	..()

/obj/item/organ/legion_skull/on_life()
	. = ..()
	skull_check()

/obj/item/organ/legion_skull/on_death()
	. = ..()
	skull_check()

/// track our timers and reagents
/obj/item/organ/legion_skull/proc/skull_check()
	if(!owner)
		return
	if(!malignance)
		malignance = new()
		malignance.infect(owner, FALSE)
	if(owner.reagents.has_reagent(/datum/reagent/medicine/synaptizine, needs_metabolizing = TRUE) || owner.reagents.has_reagent(/datum/reagent/medicine/spaceacillin, needs_metabolizing = TRUE))
		if(isnull(timeleft(malignance_tracker))) //ruhehehehehe
			malignance_countdown = min(malignance_countdown + 1 SECONDS, initial(malignance_countdown)) //slightly improve our resistance to dying so we don't turn the second a treatment runs out
			return
		malignance_countdown = timeleft(malignance_tracker) //pause our timer if we have the reagents
		deltimer(malignance_tracker)
		malignance_tracker = null //you would think deltimer would do this but it actually doesn't track a direct reference!
		return
	if(!malignance_tracker)
		malignance_tracker = addtimer(CALLBACK(src, PROC_REF(update_stage)), malignance_countdown, TIMER_STOPPABLE|TIMER_DELETE_ME) //and resume if we run out

/// Updates the stage of our tied disease
/obj/item/organ/legion_skull/proc/update_stage()
	malignance.update_stage(min(malignance.stage + 1, malignance.max_stages))
	if(malignance.stage == 5)
		malignance.stage_act() //force the transformation here, then delete everything
		qdel(malignance)
		qdel(src)
		return
	malignance_countdown = initial(malignance_countdown)
	malignance_tracker = addtimer(CALLBACK(src, PROC_REF(update_stage)), malignance_countdown, TIMER_STOPPABLE|TIMER_DELETE_ME)

//Advanced Legion is slightly tougher to kill and can raise corpses (revive other legions)
/mob/living/simple_animal/hostile/asteroid/hivelord/legion/advanced
	name = "Signifer"
	desc = "A shrunken legion, carring the remnants of a mouldering battle standard. The cadre of lackeys surrounding it seem particularly attentive."
	stat_attack = DEAD
	maxHealth = 120
	health = 120
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/advanced
	icon_state = "dwarf_legion"
	icon_living = "dwarf_legion"
	icon_aggro = "dwarf_legion"
	icon_dead = "dwarf_legion"

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/advanced
	stat_attack = DEAD
	can_infest_dead = TRUE

//Legion that spawns Legions
/mob/living/simple_animal/hostile/big_legion
	name = "Legate"
	desc = "A rare and incredibly dangerous legion mutation, forming from a plethora of legion joined in union around a young necropolis spire. It's looking particularly self-confident."
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	icon_state = "legion"
	icon_living = "legion"
	icon_dead = "legion"
	health_doll_icon = "legion"
	health = 500
	maxHealth = 500
	melee_damage_lower = 30
	melee_damage_upper = 30
	anchored = FALSE
	AIStatus = AI_ON
	obj_damage = 150
	stop_automated_movement = FALSE
	wander = TRUE
	attack_verb_continuous = "brutally slams"
	attack_verb_simple = "brutally slam"
	layer = MOB_LAYER
	del_on_death = TRUE
	sentience_type = SENTIENCE_BOSS
	loot = list(/obj/item/organ/regenerative_core/legion = 3, /obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 5, /obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 5, /obj/effect/mob_spawn/human/corpse/damaged/legioninfested = 5)
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = INFINITY
	move_to_delay = 7
	vision_range = 4
	aggro_vision_range = 4
	speed = 8
	faction = list("mining")
	weather_immunities = list("lava","ash")
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE

/mob/living/simple_animal/hostile/big_legion/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	visible_message("<span class='userwarning'>[src] falls over with a mighty crash, the remaining legions within it falling apart!</span>")
	new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(loc)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(loc)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(loc)
	..(gibbed)

/mob/living/simple_animal/hostile/big_legion/Initialize()
	.=..()
	AddComponent(/datum/component/spawner, list(/mob/living/simple_animal/hostile/asteroid/hivelord/legion/nest), 200, faction, "peels itself off from", 3)

// Snow Legion
/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow
	name = "snow legion"
	desc = "You can still see what was once a human under the shifting snowy mass, clearly decorated by a clown."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "snowlegion"
	icon_living = "snowlegion"
	icon_aggro = "snowlegion_alive"
	icon_dead = "snowlegion"
	mob_trophy = /obj/item/mob_trophy/legion_skull
	loot = list(/obj/item/organ/regenerative_core/legion)
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/snow

// Snow Legion skull
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/snow
	name = "snow legion"
	desc = "One of many."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "snowlegion_head"
	icon_living = "snowlegion_head"
	icon_aggro = "snowlegion_head"
	icon_dead = "snowlegion_head"

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow/nest
	from_nest = TRUE

/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal
	name = "disfigured legion"
	desc = "Disfigured, contorted, and corrupted. This thing was once part of the legion, now it has a different vile and twisted allegiance."
	icon_state = "disfigured_legion"
	icon_living = "disfigured_legion"
	icon_aggro = "disfigured_legion"
	icon_dead = "disfigured_legion"
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/crystal
	loot = list(/obj/item/organ/regenerative_core/legion/crystal)

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/crystal
	name = "disfigured legion"
	desc = "One of none."
	icon_state = "disfigured_legion_head"
	icon_living = "disfigured_legion_head"
	icon_aggro = "disfigured_legion_head"
	icon_dead = "disfigured_legion_head"
	speed = 3
	move_to_delay = 3

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/crystal/death(gibbed)
	for(var/i in 0 to 5)
		var/obj/projectile/P = new /obj/projectile/goliath(get_turf(src))
		P.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
		P.firer = source
		P.fire(i*(360/5))
	return ..()

//nest-spawned Legion remains, the charred skeletons of those whose bodies sank into lava or fell into chasms.
/obj/effect/mob_spawn/human/corpse/charredskeleton
	name = "charred skeletal remains"
	burn_damage = 1000
	mob_name = "ashen skeleton"
	mob_gender = NEUTER
	husk = FALSE
	mob_species = /datum/species/skeleton
	mob_color = "#454545"

//Legion infested mobs

/obj/effect/mob_spawn/human/corpse/damaged/legioninfested/dwarf/equip(mob/living/carbon/human/H)
	. = ..()
	H.transform = H.transform.Scale(0.8, 1)//somehow dwarf squashing is borked when not roundstart. I hate WS code

/obj/effect/mob_spawn/human/corpse/damaged/legioninfested/Initialize() //in an ideal world, these would generate, the legion would overlay over the corpse, and we'd get cool sprites
	mob_species = pick_weight(list(
			/datum/species/human = 50,
			/datum/species/lizard = 20,
			/datum/species/ipc = 10,
			/datum/species/elzuose = 10,
			/datum/species/moth = 5,
			/datum/species/spider = 5
		)
	)
	var/type = pick_weight(list(
		"Miner" = 40,
		"Assistant" = 10,
		"Engineer" = 5,
		"Doctor" = 5,
		"Scientist" = 5,
		"Cargo" = 5,
		"Security" = 5
		)
	)

	var/outfit_map = list(
			"Miner" = /datum/outfit/generic/miner,
			"Assistant" = /datum/outfit/generic,
			"Engineer" = /datum/outfit/generic/engineer,
			"Doctor" = /datum/outfit/generic/doctor,
			"Scientist" = /datum/outfit/generic/science,
			"Cargo" = /datum/outfit/generic/cargo,
			"Security" = /datum/outfit/generic/security
		)

	outfit = outfit_map[type]  // Access outfit directly

	. = ..()
