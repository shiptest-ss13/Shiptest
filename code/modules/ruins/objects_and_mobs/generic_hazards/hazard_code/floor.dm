/*
sharp floor hazards!
pretty much just the caltrop component, but still useful to have as a standard hazard here, to make mapping easier.
CALTROP_BYPASS_SHOES	//bypasses shoe check
CALTROP_IGNORE_WALKERS	//makes people who walk not take damage.

ids don't work for these! use something else.
also, caltrops and slippery can't mix, sadly. either it does one or the other.
*/

/obj/structure/hazard/floor
	name = "floor hazard"
	desc = "tell a maptainer if you see this. YOWCH!"
	icon_state = "spikepit"
	//these all need to be not dense
	density = FALSE
	//does damage to legs when walked over
	var/caltrop = FALSE
	var/low_damage = 10
	var/high_damage = 20
	var/probability = 100
	//bypass shoes ignores shoes, ignore walkers lets players ignore damage by walking through
	var/caltrop_flags = CALTROP_BYPASS_SHOES | CALTROP_IGNORE_WALKERS

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

/obj/structure/hazard/floor/Initialize()
	if(launcher)
		random_effect = TRUE
	. = ..()

/obj/structure/hazard/floor/do_random_effect()
	if(launcher)
		launch_sequence()

/obj/structure/hazard/floor/Initialize()
	. = ..()
	if(slippery)
		AddComponent(/datum/component/slippery, knockdown_time, slip_flags, _paralyze = paralyze_time, _force_drop = forcedrop)
	if(caltrop)
		AddComponent(/datum/component/caltrop, low_damage, high_damage, probability, caltrop_flags)

/obj/structure/hazard/floor/examine(mob/user)
	. = ..()
	if((caltrop_flags & CALTROP_IGNORE_WALKERS) && caltrop)
		. += span_notice("you could safely get through [src] if you walk.</span>")

/obj/structure/hazard/floor/proc/launch_sequence()
	visible_message(span_warning(launch_warning))
	icon_state = initial(icon_state) + "-launch"
	sleep(10)
	visible_message(span_danger("[src] flies upwards!"))
	animate(src, pixel_z = 32, time = 1)
	for(var/mob/living/carbon/target in src.loc)
		target.Paralyze(20)
		animate(target, pixel_z = 32, time = 1)
		target.apply_damage(launcher_damage, BRUTE, pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG), spread_damage = TRUE)
		SEND_SIGNAL(target, COMSIG_ON_VENDOR_CRUSH)
		target.AddElement(/datum/element/squish, 5 SECONDS)
	sleep(1)
	animate(src, pixel_z = 0, time = 4)
	for(var/mob/living/carbon/target in src.loc)
		animate(target, pixel_z = 0, time = 4)
		target.visible_message("<span class='danger'>[target] falls to the floor with a sickening crunch!</span>", \
								"<span class='userdanger'>You fall to the floor with a sickening crunch!</span>")
		playsound(target, 'sound/effects/blobattack.ogg', 40, TRUE)
	if(rand(1, 10000) == 10000) // 0.01% chance.
		playsound(src, 'sound/effects/gong.ogg', 50, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
	icon_state = initial(icon_state)
