/obj/structure/spider_player
    name = "large web"
    icon = 'icons/effects/effects.dmi'
    desc = "It's stringy and sticky, but the threads are larger than what spiderlings could produce."
    anchored = TRUE
    density = FALSE
    max_integrity = 20

/obj/structure/spider_player/New()
	..()
	icon_state = pick(list("stickyweb1", "stickyweb2"))


/obj/structure/spider_player/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	if(damage_type == BURN)//the stickiness of the web mutes all attack sounds except fire damage type
		playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/spider_player/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == "melee")
		switch(damage_type)
			if(BURN)
				damage_amount *= 2
			if(BRUTE)
				damage_amount *= 0.5
	. = ..()

/obj/structure/spider_player/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		take_damage(5, BURN, 0, 0)

/obj/structure/spider_player/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(isspiderperson(mover))

		return TRUE
	else if(isliving(mover))
		if(isspiderperson(mover.pulledby))

			return TRUE
		if(prob(50))
			to_chat(mover, "<span class='danger'>You get stuck in \the [src] for a moment.</span>")
			return FALSE
	else if(istype(mover, /obj/projectile))
		return prob(30)

/obj/structure/spider_player/cocoon
	name = "cocoon"
	desc = "Something wrapped in silky spider web."
	icon_state = "cocoon1"
	anchored = FALSE
	density = FALSE
	max_integrity = 60

/obj/structure/spider_player/cocoon/Initialize()
	icon_state = pick("cocoon1","cocoon2","cocoon3")
	. = ..()

/obj/structure/spider_player/cocoon/container_resist(mob/living/user)
	var/breakout_time = 1000 // DECI not DECA ffs
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, "<span class='notice'>You struggle against the tight bonds... (This will take about [DisplayTimeText(breakout_time)].)</span>")
	visible_message("<span class='notice'>You see something struggling and writhing in \the [src]!</span>")
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src)
			return
		qdel(src)

/obj/structure/spider_player/cocoon/Destroy()
	var/turf/T = get_turf(src)
	src.visible_message("<span class='warning'>\The [src] splits open.</span>")
	for(var/atom/movable/A in contents)
		A.forceMove(T)
	return ..()
