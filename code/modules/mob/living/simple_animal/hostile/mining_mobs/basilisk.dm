#define LEGIONVIRUS_TYPE /datum/disease/transformation/legionvirus
#define BULLET_SHELL_DAMAGE 1

//A beast that fire freezing blasts.
/mob/living/simple_animal/hostile/asteroid/basilisk
	name = "basilisk"
	desc = "A territorial beast, covered in a thick shell that absorbs energy. Its stare causes victims to freeze from the inside."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Basilisk"
	icon_living = "Basilisk"
	icon_aggro = "Basilisk_alert"
	icon_dead = "Basilisk_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	move_to_delay = 20
	projectiletype = /obj/projectile/temp/basilisk
	projectilesound = 'sound/weapons/pierce.ogg'
	ranged = 1
	ranged_message = "stares"
	ranged_cooldown_time = 30
	throw_message = "does nothing against the hard shell of"
	vision_range = 2
	speed = 3
	maxHealth = 175
	health = 175
	harm_intent_damage = 5
	obj_damage = 60
	melee_damage_lower = 7
	melee_damage_upper = 15
	attack_verb_continuous = "bites into"
	attack_verb_simple = "bite into"
	speak_emote = list("chitters")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	aggro_vision_range = 9
	turns_per_move = 5
	gold_core_spawnable = HOSTILE_SPAWN
	loot = list(/obj/item/stack/ore/diamond{layer = ABOVE_MOB_LAYER},
				/obj/item/stack/ore/diamond{layer = ABOVE_MOB_LAYER})
	var/lava_drinker = TRUE
	var/warmed_up = FALSE

/obj/projectile/temp/basilisk
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 0
	damage_type = BURN
	nodamage = TRUE
	flag = "energy"
	temperature = -50 // Cools you down! per hit!

/obj/projectile/temp/basilisk/super
	temperature = -100
	damage = 5
	nodamage = FALSE

/obj/projectile/temp/basilisk/super/on_hit(atom/target, blocked)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.Jitter(5)

/obj/projectile/temp/basilisk/heated
	name = "energy blast"
	icon_state= "chronobolt"
	damage = 40
	damage_type = BRUTE
	nodamage = FALSE
	temperature = 0

/mob/living/simple_animal/hostile/asteroid/basilisk/GiveTarget(new_target)
	if(..()) //we have a target
		if(isliving(target) && !target.Adjacent(targets_from) && ranged_cooldown <= world.time)//No more being shot at point blank or spammed with RNG beams
			OpenFire(target)

/mob/living/simple_animal/hostile/asteroid/basilisk/ex_act(severity, target)
	switch(severity)
		if(1)
			gib()
		if(2)
			adjustBruteLoss(140)
		if(3)
			adjustBruteLoss(110)

/mob/living/simple_animal/hostile/asteroid/basilisk/AttackingTarget()
	. = ..()
	if(lava_drinker && !warmed_up && istype(target, /turf/open/lava))
		visible_message("<span class='warning'>[src] begins to drink from [target]...</span>")
		if(do_after(src, 70, target = target))
			visible_message("<span class='warning'>[src] begins to fire up!</span>")
			fully_heal()
			icon_state = "Basilisk_alert"
			set_varspeed(0)
			warmed_up = TRUE
			projectiletype = /obj/projectile/temp/basilisk/heated
			addtimer(CALLBACK(src, .proc/cool_down), 3000)

/mob/living/simple_animal/hostile/asteroid/basilisk/proc/cool_down()
	visible_message("<span class='warning'>[src] appears to be cooling down...</span>")
	if(stat != DEAD)
		icon_state = "Basilisk"
	set_varspeed(3)
	warmed_up = FALSE
	projectiletype = /obj/projectile/temp/basilisk

/******************************************
		New whitesands varient
******************************************/

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands
	desc = "A native beast of sand planets. This unique mutation has evolved to develop a shell around it's body, deflecting all attacks until broken."
	icon_state = "basilisk_whitesands"
	icon_living = "basilisk_whitesands"
	icon_aggro = "basilisk_whitesands"
	icon_dead = "basilisk_whitesands_dead"
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	attack_same = TRUE		// So we'll attack watchers
	butcher_results = list(/obj/item/stack/sheet/sinew = 4, /obj/item/stack/sheet/bone = 2)
	lava_drinker = FALSE
	maxHealth = 40
	health = 40
	var/shell_health = 80 //Tough to crack, easy to kill.
	var/has_shell = TRUE
	var/list/shell_loot = list(/obj/item/stack/ore/diamond, /obj/item/stack/ore/diamond)
	var/shell_snap_message = FALSE

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/proc/shell_damage(dam_amount)
	if(has_shell)
		shell_health -= dam_amount
		if(shell_health <= 0)
			has_shell = FALSE
			armor = null		// Armor comes from the shell
			for(var/l in shell_loot)
				new l(loc)
			if(!shell_snap_message)
				playsound(src, "shatter", 80, FALSE)
				audible_message("<span class='danger'>[src]'s shell violently cracks as it's armor is shattered!</span>")
				throw_message = "bounces off of"
				shell_snap_message = TRUE //so it doesnt repeat
		update_appearance()
		return TRUE
	update_appearance()
	return FALSE

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/CanAttack(atom/the_target)
	. = ..()
	if(!.)
		return FALSE
	if(istype(the_target, /mob/living/simple_animal/hostile/asteroid))
		if(istype(the_target, /mob/living/simple_animal/hostile/asteroid/basilisk/watcher))
			return TRUE
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/attacked_by(obj/item/I, mob/living/user)
	if(I.force)
		if(shell_damage(I.force))			// Damage was absorbed by the shell, no need to go further
			send_item_attack_message(I, user)
			return TRUE
	return ..()

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/bullet_act(obj/projectile/P)
	shell_damage(BULLET_SHELL_DAMAGE)
	if(has_shell)
		playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 85, TRUE)
		visible_message("<span class='notice'>The [P] is absorbed by the [src]'s shell, dealing minimal damage!</span>") //make it less confusing when bullets do no damage
	return ..()

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(istype(AM, /obj/item))
		shell_damage(BULLET_SHELL_DAMAGE)
	..()

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/drop_loot()
	if(has_shell)
		for(var/l in shell_loot)		// You get the stuff anyways
			new l(loc)
	..()

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/Aggro()
	..()
	var/mutable_appearance/angry = mutable_appearance(icon, "basilisk_sands_charge")
	add_overlay(angry)

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/LoseAggro()
	..()
	cut_overlays()

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/update_appearance()
	. = ..()
	if(stat == CONSCIOUS)
		if(has_shell)
			if(shell_health >= initial(shell_health)*0.5)
				icon_state = "basilisk_whitesands"
			else if(shell_health < initial(shell_health)*0.5)
				icon_state = "basilisk_whitesands_shell50"
		else
			icon_state = "basilisk_whitesands_shell0"
	else
		icon_state = "basilisk_whitesands_dead"

/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands/heat
	name = "glowing basilisk"
	projectiletype = /obj/projectile/temp/basilisk/heated

#undef BULLET_SHELL_DAMAGE
#undef LEGIONVIRUS_TYPE

//Watcher
/mob/living/simple_animal/hostile/asteroid/basilisk/watcher
	name = "watcher"
	desc = "A levitating, eye-like creature held aloft by winglike formations of sinew. A sharp spine of crystal protrudes from its body."
	icon = 'icons/mob/lavaland/lavaland_monsters_wide.dmi'
	icon_state = "watcher"
	icon_living = "watcher"
	icon_aggro = "watcher"
	icon_dead = "watcher_dead"
	health_doll_icon = "watcher"
	pixel_x = -12
	base_pixel_x = -12
	throw_message = "bounces harmlessly off of"
	melee_damage_lower = 5
	melee_damage_upper = 12
	attack_verb_continuous = "impales"
	attack_verb_simple = "impale"
	a_intent = INTENT_HARM
	speak_emote = list("telepathically cries")
	attack_sound = 'sound/weapons/bladeslice.ogg'
	stat_attack = UNCONSCIOUS
	movement_type = FLYING
	robust_searching = 1
	attack_same = TRUE		// So we'll fight basilisks
	crusher_loot = /obj/item/crusher_trophy/watcher_wing
	gold_core_spawnable = NO_SPAWN
	loot = list()
	butcher_results = list(/obj/item/stack/ore/diamond = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 1)
	lava_drinker = FALSE
	search_objects = 1
	wanted_objects = list(/obj/item/pen/survival, /obj/item/stack/ore/diamond)

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/gib()
	move_force = MOVE_FORCE_DEFAULT
	move_resist = MOVE_RESIST_DEFAULT
	pull_force = PULL_FORCE_DEFAULT

	if(prob(5))
		new /obj/item/gem/fdiamond(loc)
		visible_message("<span class='warning'>The focusing diamond in [src]'s eye looks intact!</span>")
	..()

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/Life()
	. = ..()
	if(stat == CONSCIOUS)
		consume_bait()

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/CanAttack(atom/the_target)
	. = ..()
	if(!.)
		return FALSE
	if(istype(the_target, /mob/living/simple_animal/hostile/asteroid))
		if(istype(the_target, /mob/living/simple_animal/hostile/asteroid/basilisk/whitesands))
			return TRUE
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/proc/consume_bait()
	for(var/obj/potential_consumption in view(1, src))
		if(istype(potential_consumption, /obj/item/stack/ore/diamond))
			qdel(potential_consumption)
			visible_message("<span class='notice'[src] consumes [potential_consumption], and it disappears! ...At least, you think.</span>")
		else if(istype(potential_consumption, /obj/item/pen/survival))
			qdel(potential_consumption)
			visible_message("<span class='notice'[src] examines [potential_consumption] closer, and telekinetically shatters the pen.</span>")

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random/Initialize()
	. = ..()
	if(prob(15))
		if(prob(75))
			new /mob/living/simple_animal/hostile/asteroid/basilisk/watcher/magmawing(loc)
		else
			new /mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing(loc)
		return INITIALIZE_HINT_QDEL

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/magmawing
	name = "magmawing watcher"
	desc = "When raised very close to lava, some watchers adapt to the extreme heat and use lava as both a weapon and wings."
	icon_state = "watcher_magmawing"
	icon_living = "watcher_magmawing"
	icon_aggro = "watcher_magmawing"
	icon_dead = "watcher_magmawing_dead"
	maxHealth = 250 //Compensate for the lack of slowdown on projectiles with a bit of extra health
	health = 250
	light_range = 3
	light_power = 2.5
	light_color = LIGHT_COLOR_LAVA
	projectiletype = /obj/projectile/temp/basilisk/magmawing
	crusher_loot = /obj/item/crusher_trophy/magma_wing
	crusher_drop_mod = 75

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing
	name = "icewing watcher"
	desc = "Very rarely, some watchers will eke out an existence far from heat sources. In the absence of warmth, they become icy and fragile but fire much stronger freezing blasts."
	icon_state = "watcher_icewing"
	icon_living = "watcher_icewing"
	icon_aggro = "watcher_icewing"
	icon_dead = "watcher_icewing_dead"
	maxHealth = 170
	health = 170
	ranged_cooldown_time = 20
	projectiletype = /obj/projectile/temp/basilisk/icewing
	butcher_results = list(/obj/item/stack/ore/diamond = 5, /obj/item/stack/sheet/bone = 1) //No sinew; the wings are too fragile to be usable
	crusher_loot = /obj/item/crusher_trophy/ice_wing
	crusher_drop_mod = 75

/obj/projectile/temp/basilisk/magmawing
	name = "scorching blast"
	icon_state = "lava"
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	temperature = 250 // Heats you up! per hit!

/obj/projectile/temp/basilisk/magmawing/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(.)
		var/mob/living/L = target
		if (istype(L))
			L.adjust_fire_stacks(0.1)
			L.IgniteMob()

/obj/projectile/temp/basilisk/icewing
	damage = 15
	damage_type = BURN
	nodamage = FALSE

/obj/projectile/temp/basilisk/icewing/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(.)
		var/mob/living/L = target
		if(istype(L))
			L.apply_status_effect(/datum/status_effect/freon/watcher)

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/tendril
	fromtendril = TRUE

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten
	name = "forgotten watcher"
	desc = "This watcher has a cancerous crystal growth on it, forever scarring it and deforming it into this twisted form."
	icon = 'icons/mob/lavaland/watcher.dmi'
	icon_state = "forgotten"
	icon_living = "forgotten"
	icon_aggro = "forgotten"
	icon_dead = "forgotten_dead"
	aggro_vision_range = 10
	vision_range = 5
	maxHealth = 250
	health = 250
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 1
	projectiletype = /obj/projectile/temp/basilisk/super
	ranged_cooldown_time = 10
	butcher_results = list(/obj/item/stack/ore/diamond = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 1, /obj/item/strange_crystal = 1)
