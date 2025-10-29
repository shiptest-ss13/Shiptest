/*
floor hazards!

ids don't work for slipping
*/

/obj/structure/hazard/floor
	name = "floor hazard"
	desc = "tell a maptainer if you see this. YOWCH!"
	icon_state = "spikepit"
	//these all(most) need to be not dense
	density = FALSE
	var/dealt_damage = 20
	var/damage_type = BRUTE
	//does damage to legs when walked over, or arms when bumped
	var/contact_damage = FALSE
	//does chunks of damage while stood on.
	var/random_damage = FALSE

	//slips!
	var/slippery = FALSE
	var/knockdown_time = 3 SECONDS
	//no slip when walking makes walking not slip, slide makes players fly in the direction they were going.
	var/slip_flags = NO_SLIP_WHEN_WALKING | SLIDE
	var/paralyze_time = 0
	//player drops their items
	var/forcedrop = FALSE

	//launches upwards using do_random_effect between random_min and random_max. also flattens players a little. Needs a icon_state-launch state to look right.
	var/launcher = FALSE
	//damage done by launcher, these are very crunchy and have a windup
	var/launcher_damage = 90
	//warning sent 1 second before the launcher does animation & damage
	var/launch_warning = "The floor glows and begins to float!"

/obj/structure/hazard/floor/do_random_effect()
	if(launcher)
		launch_sequence()
	if(random_damage)
		random_damage()

/obj/structure/hazard/floor/Initialize()
	if(contact_damage)
		enter_activated = TRUE
	if(launcher || random_damage)
		random_effect = TRUE
	. = ..()
	if(slippery)
		AddComponent(/datum/component/slippery, knockdown_time, slip_flags, _paralyze = paralyze_time, _force_drop = forcedrop)

/obj/structure/hazard/floor/proc/launch_sequence()
	visible_message(span_warning(launch_warning))
	icon_state = initial(icon_state) + "-launch"
	sleep(10)
	visible_message(span_danger("[src] flies upwards!"))
	animate(src, pixel_z = 32, time = 1)
	var/list/targets = list() //so we don't lose moving targets and leave them upwards.
	for(var/obj/target in src.loc)
		if(target == src)
			continue
		targets += target
	for(var/mob/living/target in src.loc)
		targets += target
	for(var/target in targets)
		animate(target, pixel_z = 32, time = 1)
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/victim = target
			victim.Paralyze(20)
			victim.apply_damage(launcher_damage, BRUTE, pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG), spread_damage = TRUE)
			victim.AddElement(/datum/element/squish, 5 SECONDS)
	sleep(1)
	animate(src, pixel_z = 0, time = 4)
	var/gong = FALSE
	for(var/target in targets)
		animate(target, pixel_z = 0, time = 4)
		if(istype(target, /mob/living/carbon))
			var/mob/living/carbon/victim = target
			victim.visible_message(span_danger("[target] falls to the floor with a sickening crunch!"), \
									span_userdanger("You fall to the floor with a sickening crunch!)"))
			playsound(target, 'sound/effects/blobattack.ogg', 40, TRUE)
			if(rand(1, 1000) == 1000) // 0.1% chance gong.
				playsound(src, 'sound/effects/gong.ogg', 60, TRUE)
				gong = TRUE
	if(!gong)
		playsound(src, 'sound/effects/bang.ogg', 30, TRUE)
	icon_state = initial(icon_state)

/obj/structure/hazard/floor/contact(target)
	if(contact_damage)
		contact_damage(target)

/obj/structure/hazard/floor/proc/floor_checks(mob/living/carbon/target)
	if(!ishuman(target))
		return TRUE
	if(!(target.movement_type & (FLYING|FLOATING)))
		return TRUE
	if(target.buckled) //if you're in an office chair with an extinguisher, that's funny. you go girl.
		return TRUE
	return FALSE

/obj/structure/hazard/floor/proc/contact_damage(mob)
	var/mob/living/carbon/target = mob
	if(floor_checks(target))
		return
	if(!density)
		target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_L_LEG)
		target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_R_LEG)
		to_chat(target, span_userdanger("You step on [src]!"))
	else
		target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_L_ARM)
		target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_R_ARM)
		to_chat(target, span_userdanger("You accidentally bump [src]!"))
	target.Paralyze(30)

/obj/structure/hazard/floor/proc/random_damage()
	for(var/mob/living/carbon/target in src.loc)
		if(floor_checks(target))
			continue
		if(target.body_position == LYING_DOWN)
			target.apply_damage(dealt_damage, damage_type, spread_damage = TRUE)
		else
			target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_L_LEG)
			target.apply_damage(dealt_damage/2, damage_type, BODY_ZONE_R_LEG)
		if(damage_type == BRUTE)
			playsound(target, 'sound/misc/splort.ogg', 20, TRUE)
			to_chat(target, span_userdanger("[src] mangles you!"))
		else //burn, tox, or oxyloss work better with acid burn feedback.
			playsound(target, 'sound/items/welder.ogg', 20, TRUE)
			to_chat(target, span_userdanger("[src] burns you!"))
