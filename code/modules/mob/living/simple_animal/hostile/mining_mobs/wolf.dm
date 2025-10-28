/mob/living/simple_animal/hostile/asteroid/wolf
	name = "white wolf"
	desc = "A beast that survives by feasting on weaker opponents, they're much stronger with numbers. Watch out for the lunge!"
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "whitewolf"
	icon_living = "whitewolf"
	icon_dead = "whitewolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_ICON
	friendly_verb_continuous = "howls at"
	friendly_verb_simple = "howl at"
	speak_emote = list("howls")
	speed = 25
	move_to_delay = 25
	ranged = 1
	ranged_cooldown_time = 90
	maxHealth = 50
	health = 50
	obj_damage = 15
	melee_damage_lower = 7
	melee_damage_upper = 7
	rapid_melee = 2 // every second attack
	dodging = TRUE
	dodge_prob = 50
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	sharpness = SHARP_POINTY
	vision_range = 7
	aggro_vision_range = 7
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
	butcher_results = list(/obj/item/food/meat/slab = 2, /obj/item/stack/sheet/sinew/wolf = 2, /obj/item/stack/sheet/bone = 2, /obj/item/mob_trophy/wolf_ear = 0.5)
	loot = list()
	mob_trophy = /obj/item/mob_trophy/wolf_ear
	stat_attack = HARD_CRIT
	knockdown_time = 1 SECONDS
	robust_searching = TRUE
	footstep_type = FOOTSTEP_MOB_CLAW
	var/charging = FALSE
	var/revving_charge = FALSE
	var/charge_range = 10
	/// Message for when the wolf decides to start running away
	var/retreat_message_said = FALSE

/mob/living/simple_animal/hostile/asteroid/wolf/proc/charge(atom/chargeat = target, delay = 10, chargepast = 2)
	if(!chargeat)
		return
	var/chargeturf = get_turf(chargeat)
	if(!chargeturf)
		return
	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, chargepast)
	if(!T)
		return
	charging = TRUE
	revving_charge = TRUE
	walk(src, 0)
	setDir(dir)
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#5a5858", transform = matrix()*2, time = 3)
	SLEEP_CHECK_DEATH(delay)
	revving_charge = FALSE
	var/movespeed = 0.7
	walk_towards(src, T, movespeed)
	SLEEP_CHECK_DEATH(get_dist(src, T) * movespeed)
	walk(src, 0) // cancel the movement
	charging = FALSE

/mob/living/simple_animal/hostile/asteroid/wolf/OpenFire()
	var/tturf = get_turf(target)
	var/dist = get_dist(src, target)
	if(!isturf(tturf) || !isliving(target))
		return
	else if(dist <= charge_range)		//Screen range check, so you can't get charged offscreen
		charge()

/mob/living/simple_animal/hostile/asteroid/wolf/Bump(atom/A)
	. = ..()
	if(charging && isclosedturf(A))				// We slammed into a wall while charging
		wall_slam(A)

/mob/living/simple_animal/hostile/asteroid/wolf/proc/wall_slam(atom/A)
	charging = FALSE
	walk(src, 0)		// Cancel the movement
	if(ismineralturf(A))
		var/turf/closed/mineral/M = A
		if(M.mineralAmt < 7)
			M.mineralAmt++

/mob/living/simple_animal/hostile/asteroid/wolf/Move(atom/newloc)
	if(newloc && newloc.z == z && (islava(newloc) || ischasm(newloc)))
		return FALSE
	return ..()

/mob/living/simple_animal/hostile/asteroid/wolf/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(stat == DEAD || health > maxHealth*0.1)
		retreat_distance = initial(retreat_distance)
		return
	if(!retreat_message_said && target)
		visible_message(span_danger("The [name] tries to flee from [target]!"))
		retreat_message_said = TRUE
	retreat_distance = 30

//alpha wolf- smaller chance to spawn, practically a miniboss. Has the ability to do a short, untelegraphed lunge with a stun. Be careful!
/mob/living/simple_animal/hostile/asteroid/wolf/alpha
	name = "alpha wolf"
	desc = "An old wolf with matted, dirty fur and a missing eye, trophies of many won battles and successful hunts. Seems like they're the leader of the pack around here. Watch out for the lunge!"
	icon = 'icons/mob/icemoon/icemoon_monsters.dmi'
	icon_state = "alphawolf"
	icon_living = "alphawolf"
	icon_dead = "alphawolf_dead"
	speed = 15
	move_to_delay = 15
	vision_range = 4
	aggro_vision_range = 12
	maxHealth = 100
	health = 100
	melee_damage_lower = 10
	melee_damage_upper = 10
	dodging = TRUE
	dodge_prob = 75
	charger = TRUE
	charge_distance = 7
	knockdown_time = 1 SECONDS
	charge_frequency = 20 SECONDS
	butcher_results = list(/obj/item/food/meat/slab = 2, /obj/item/stack/sheet/sinew/wolf = 4, /obj/item/stack/sheet/sinew/wolf = 4, /obj/item/stack/sheet/bone = 5)
	loot = list()
	mob_trophy = /obj/item/mob_trophy/fang

/mob/living/simple_animal/hostile/asteroid/wolf/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/wolf/alpha(loc)
		return INITIALIZE_HINT_QDEL
