/mob/living/simple_animal/hostile/asteroid/ice_demon
	name = "demonic watcher"
	desc = "A creature formed entirely out of ice, bluespace energy emanates from inside of it."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "ice_demon"
	icon_living = "ice_demon"
	icon_dead = "ice_demon_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	speak_emote = list("telepathically cries")
	speed = 7
	move_to_delay = 7
	projectiletype = /obj/projectile/temp/basilisk/ice
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = TRUE
	ranged_message = "manifests ice"
	ranged_cooldown_time = 30
	minimum_distance = 4
	retreat_distance = 1
	maxHealth = 150
	health = 150
	obj_damage = 40
	environment_smash = ENVIRONMENT_SMASH_MINERALS
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	vision_range = 8
	aggro_vision_range = 8
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	del_on_death = TRUE
	loot = list()
	crusher_loot = /obj/item/crusher_trophy/ice_wing
	deathmessage = "fades as the energies that tied it to this world dissipate."
	deathsound = 'sound/magic/demon_dies.ogg'
	stat_attack = HARD_CRIT
	movement_type = FLYING
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	/// Distance the demon will teleport from the target
	var/teleport_distance = 3

/obj/projectile/temp/basilisk/ice
	name = "ice blast"
	damage = 5
	nodamage = FALSE
	temperature = -75

/mob/living/simple_animal/hostile/asteroid/ice_demon/OpenFire()
	// Sentient ice demons teleporting has been linked to server crashes
	if(client)
		return ..()
	if(teleport_distance <= 0)
		return ..()
	var/list/possible_ends = list()
	for(var/turf/T in view(teleport_distance, target.loc) - view(teleport_distance - 1, target.loc))
		if(isclosedturf(T))
			continue
		possible_ends |= T
	if(!possible_ends.len)
		return ..()
	var/turf/end = pick(possible_ends)
	do_teleport(src, end, 0,  channel=TELEPORT_CHANNEL_BLUESPACE, forced = TRUE)
	SLEEP_CHECK_DEATH(8)
	return ..()

/mob/living/simple_animal/hostile/asteroid/ice_demon/Life()
	. = ..()
	if(!. || target)
		return
	adjustHealth(-maxHealth*0.025)

/mob/living/simple_animal/hostile/asteroid/ice_demon/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	new /obj/item/stack/ore/bluespace_crystal(loc, 3)
	if(prob(5))
		new /obj/item/assembly/signaler/anomaly/bluespace(loc)
	if(prob(5))
		new /obj/item/gem/fdiamond(loc)
	return ..()

/mob/living/simple_animal/hostile/asteroid/old_demon
	name = "primordial demon"
	desc = "At the beginning, there was nothing but emptiness. \
	From the emptiness, there came monsters."
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "old_demon"
	icon_living = "old_demon"
	icon_dead = "ice_demon_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	speak_emote = list("telepathically shrieks")
	speed = 2
	move_to_delay = 2
	projectiletype = /obj/projectile/temp/basilisk/ice
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = TRUE
	ranged_message = "manifests ice"
	ranged_cooldown_time = 15
	minimum_distance = 3
	retreat_distance = 1
	maxHealth = 300
	health = 300
	obj_damage = 100
	environment_smash = ENVIRONMENT_SMASH_WALLS
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "cleaves"
	attack_verb_simple = "cleave"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	vision_range = 8
	aggro_vision_range = 8
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	del_on_death = TRUE
	loot = list()
	crusher_loot = /obj/item/crusher_trophy/ice_crystal
	deathmessage = "screeches in rage as it falls back into nullspace."
	deathsound = 'sound/magic/demon_dies.ogg'
	stat_attack = HARD_CRIT
	movement_type = FLYING
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	/// Distance the demon will teleport from the target
	var/teleport_distance = 3
	crusher_drop_mod = 75

/obj/projectile/temp/basilisk/ice
	name = "ice blast"
	damage = 10
	nodamage = FALSE
	temperature = -75

/mob/living/simple_animal/hostile/asteroid/ice_demon/OpenFire()
	// Sentient ice demons teleporting has been linked to server crashes
	if(client)
		return ..()
	if(teleport_distance <= 0)
		return ..()
	var/list/possible_ends = list()
	for(var/turf/T in view(teleport_distance, target.loc) - view(teleport_distance - 1, target.loc))
		if(isclosedturf(T))
			continue
		possible_ends |= T
	if(!possible_ends.len)
		return ..()
	var/turf/end = pick(possible_ends)
	do_teleport(src, end, 0,  channel=TELEPORT_CHANNEL_BLUESPACE, forced = TRUE)
	SLEEP_CHECK_DEATH(8)
	return ..()

/mob/living/simple_animal/hostile/asteroid/ice_demon/Life()
	. = ..()
	if(!. || target)
		return
	adjustHealth(-maxHealth*0.025)

/mob/living/simple_animal/hostile/asteroid/ice_demon/death(gibbed)
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT
	new /obj/item/stack/ore/bluespace_crystal(loc, 10)
	if(prob(20))
		new /obj/item/assembly/signaler/anomaly/bluespace(loc)
	if(prob(20))
		new /obj/item/gem/fdiamond(loc)
	return ..()

/mob/living/simple_animal/hostile/asteroid/ice_demon/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/old_demon(loc)
		return INITIALIZE_HINT_QDEL

/obj/item/crusher_trophy/ice_crystal
	name = "frost gem"
	icon = 'icons/obj/lavaland/elite_trophies.dmi'
	desc = "The glowing remnant of an ancient ice demon- so cold that it hurts to touch."
	icon_state = "ice_crystal"
	denied_type = /obj/item/crusher_trophy/ice_crystal

/obj/item/crusher_trophy/ice_crystal/effect_desc()
	return "waveform collapse to freeze a creature in a block of ice for a period, preventing them from moving"

/obj/item/crusher_trophy/ice_crystal/on_mark_detonation(mob/living/target, mob/living/user)
	target.apply_status_effect(/datum/status_effect/ice_crystal)

/datum/status_effect/ice_crystal
	id = "ice_crystal"
	duration = 20
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/ice_crystal
	/// Stored icon overlay for the hit mob, removed when effect is removed
	var/icon/cube

/atom/movable/screen/alert/status_effect/ice_crystal
	name = "Frozen Solid"
	desc = "You're frozen inside an ice cube, and cannot move!"
	icon_state = "frozen"

/datum/status_effect/ice_crystal/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, .proc/owner_moved)
	if(!owner.stat)
		to_chat(owner, "<span class='userdanger'>You become frozen in a cube!</span>")
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	var/icon/size_check = icon(owner.icon, owner.icon_state)
	cube.Scale(size_check.Width(), size_check.Height())
	owner.add_overlay(cube)
	return ..()

/// Blocks movement from the status effect owner
/datum/status_effect/ice_crystal/proc/owner_moved()
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/status_effect/ice_crystal/on_remove()
	if(!owner.stat)
		to_chat(owner, "<span class='notice'>The cube melts!</span>")
	owner.cut_overlay(cube)
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)
