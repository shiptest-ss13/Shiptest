/turf/closed/wall/concrete
	name = "concrete wall"
	desc = "A thick wall made of concrete, poured around steel supports."
	icon = 'icons/turf/walls/concrete.dmi'
	icon_state = "concrete-0"
	base_icon_state = "concrete"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_CONCRETE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_CONCRETE_WALLS,SMOOTH_GROUP_AIRLOCK)
	rad_insulation = RAD_HEAVY_INSULATION
	hardness = 30 // doesn't matter much; everything that uses it gets overridden
	explosion_block = 3
	break_sound = 'sound/effects/break_stone.ogg'
	sheet_type = null
	girder_type = /obj/structure/grille

	// The wall will ignore damage from weak items, depending on their
	// force, damage type, tool behavior, and sharpness. This is the minimum
	// amount of force that a blunt, brute item must have to damage the wall.
	var/min_dam = 8
	// This should all be handled by integrity should that ever be expanded to walls.
	var/max_health = 650
	var/health
	// used to give mining projectiles a bit of an edge against conc walls
	var/static/list/extra_dam_proj = typecacheof(list(
		/obj/projectile/kinetic,
		/obj/projectile/destabilizer,
		/obj/projectile/plasma
	))

	var/time_to_harden = 30 SECONDS
	// fraction ranging from 0 to 1 -- 0 is fully soft, 1 is fully hardened
	// don't change this in subtypes unless you want them to spawn in soft on maps
	var/harden_lvl = 1

	var/mutable_appearance/crack_overlay

/turf/closed/wall/concrete/Initialize(mapload, ...)
	. = ..()
	if(health == null)
		health = max_health
	check_harden()
	update_stats()

/turf/closed/wall/concrete/copyTurf(turf/T, copy_air, flags)
	. = ..()
	// by this point it's guaranteed to be a concrete wall
	var/turf/closed/wall/concrete/conc_wall = T
	if(conc_wall.health != health || conc_wall.harden_lvl != harden_lvl)
		conc_wall.harden_lvl = harden_lvl
		conc_wall.health = health
		// very much not a fan of all the repetition here,
		// but there's unfortunately no easy way around it
		conc_wall.check_harden()
		conc_wall.update_stats()

/turf/closed/wall/concrete/update_icon()
	. = ..()
	if(!.)
		return
	remove_filter("harden")
	if(harden_lvl == 1)
		return

	var/offset = (1 - harden_lvl) * 0.4
	var/base = 1 - offset
	var/col_filter = list(base,0,0, 0,base,0, 0,0,base, offset, offset, offset)
	add_filter("harden", 1, color_matrix_filter(col_filter, FILTER_COLOR_RGB))
	return

/turf/closed/wall/concrete/update_overlays()
	. = ..()
	var/adj_dam_pct = 1 - (health/(max_health*0.7))
	if(adj_dam_pct <= 0)
		return
	if(!crack_overlay)
		crack_overlay = mutable_appearance('icons/effects/concrete_damage.dmi', "cracks", BULLET_HOLE_LAYER)
	crack_overlay.alpha = adj_dam_pct*255
	. += crack_overlay

// we use this to show health + drying percentage
/turf/closed/wall/concrete/deconstruction_hints(mob/user)
	. = list()
	. += "<span class='notice'>[p_they(TRUE)] look[p_s()] like you could <b>smash</b> [p_them()].</span>"
	switch(harden_lvl)
		if(0.8 to 0.99)
			. += "[p_they(TRUE)] look[p_s()] nearly dry."
		if(0.4 to 0.8)
			. += "[p_they(TRUE)] look[p_s()] a little wet."
		if(0 to 0.4)
			. += "[p_they(TRUE)] look[p_s()] freshly poured."
	switch(health / max_health)
		if(0.5 to 0.99)
			. += "[p_they(TRUE)] look[p_s()] slightly damaged."
		if(0.25 to 0.5)
			. += "[p_they(TRUE)] appear[p_s()] heavily damaged."
		if(0 to 0.25)
			. += "<span class='warning'>[p_theyre(TRUE)] falling apart!</span>"
	return

/turf/closed/wall/concrete/create_girder()
	var/obj/girder = ..()
	if(health < 0)
		girder.take_damage(min(abs(health), 50))
	return girder

/turf/closed/wall/concrete/proc/check_harden()
	harden_lvl = clamp(harden_lvl, 0, 1)
	if(harden_lvl < 1)
		START_PROCESSING(SSobj, src)

/turf/closed/wall/concrete/process(wait)
	harden_lvl = min(harden_lvl + (wait/time_to_harden), 1)
	if(harden_lvl == 1)
		STOP_PROCESSING(SSobj, src)
	update_stats()

/turf/closed/wall/concrete/proc/update_stats()
	// explosion block is diminished on a damaged / soft wall
	explosion_block = (health / max_health) * harden_lvl * initial(explosion_block)
	update_appearance()

/turf/closed/wall/concrete/proc/alter_health(delta)
	// 8x as vulnerable when unhardened
	if(delta < 0)
		delta *= 1 + 7*(1-harden_lvl)
	health += delta
	if(health <= 0)
		// if damage put us 50 points or more below 0, we got proper demolished
		dismantle_wall(health <= -50 ? TRUE : FALSE)
		return FALSE
	health = min(health, max_health)
	update_stats()
	return health

/turf/closed/wall/concrete/ex_act(severity, target)
	if(target == src || !density)
		return ..()
	switch(severity)
		if(EXPLODE_DEVASTATE)
			alter_health(-2000)
		if(EXPLODE_HEAVY)
			alter_health(rand(-500, -800))
		if(EXPLODE_LIGHT)
			alter_health(rand(-200, -700))

/turf/closed/wall/concrete/bullet_act(obj/projectile/P)
	. = ..()
	var/dam = get_proj_damage(P)
	if(!dam)
		return
	if(P.suppressed != SUPPRESSED_VERY)
		visible_message("<span class='danger'>[src] is hit by \a [P]!</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!QDELETED(src))
		alter_health(-dam)

/turf/closed/wall/concrete/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if((M.environment_smash & ENVIRONMENT_SMASH_WALLS) || (M.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
		alter_health(-400)
		return

/turf/closed/wall/concrete/attack_hulk(mob/living/carbon/user)
	SEND_SIGNAL(src, COMSIG_ATOM_HULK_ATTACK, user)
	log_combat(user, src, "attacked")
	var/obj/item/bodypart/arm = user.hand_bodyparts[user.active_hand_index]
	if(!arm || arm.bodypart_disabled)
		return FALSE
	playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	user.visible_message("<span class='danger'>[user] smashes \the [src]!</span>", \
				"<span class='danger'>You smash \the [src]!</span>", \
				"<span class='hear'>You hear a booming smash!</span>")
	user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
	alter_health(-250)
	return TRUE

/turf/closed/wall/concrete/mech_melee_attack(obj/mecha/M)
	M.do_attack_animation(src)
	switch(M.damtype)
		if(BRUTE)
			M.visible_message("<span class='danger'>[M.name] hits [src]!</span>", \
							"<span class='danger'>You hit [src]!</span>", null, COMBAT_MESSAGE_RANGE)
			playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			alter_health(M.force * -20)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
		if(TOX)
			playsound(src, 'sound/effects/spray2.ogg', 100, TRUE)

// can't weld out the dents
/turf/closed/wall/concrete/try_clean(obj/item/W, mob/user, turf/T)
	return null

// only way to deconstruct is to smash through
/turf/closed/wall/concrete/try_decon(obj/item/W, mob/user, turf/T)
	return null

// catch-all for using most items on the wall -- attempt to smash
/turf/closed/wall/concrete/try_destroy(obj/item/W, mob/user, turf/T)
	var/dam = get_item_damage(W)
	user.do_attack_animation(src)
	if(!dam)
		to_chat(user, "<span class='warning'>[W] isn't strong enough to damage [src]!</span>")
		playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		return TRUE
	log_combat(user, src, "attacked", W)
	user.visible_message("<span class='danger'>[user] hits [src] with [W]!</span>", \
				"<span class='danger'>You hit [src] with [W]!</span>", null, COMBAT_MESSAGE_RANGE)
	switch(W.damtype)
		if(BRUTE)
			playsound(src, 'sound/effects/hit_stone.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
	alter_health(-dam)
	return TRUE

/turf/closed/wall/concrete/proc/get_item_damage(obj/item/I)
	var/dam = I.force
	if(istype(I, /obj/item/clothing/gloves/gauntlets))
		dam = 20
	else if(I.tool_behaviour == TOOL_MINING)
		dam *= (4/3)
	else
		switch(I.damtype)
			if(BRUTE)
				if(I.get_sharpness())
					dam *= 2/3
			if(BURN)
				dam *= 2/3
			else
				return 0
	var/t_min = min_dam / (1 + 7*(1-harden_lvl)) // drying walls are more vulnerable
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/wall/concrete/proc/get_proj_damage(obj/projectile/P)
	var/dam = P.damage
	// mining projectiles have an edge
	if(is_type_in_typecache(P, extra_dam_proj))
		dam = max(dam, 30)
	else
		switch(P.damage_type)
			if(BRUTE)
				dam *= 1
			if(BURN)
				dam *= 2/3
			else
				return 0
	var/t_min = min_dam / (1 + 7*(1-harden_lvl)) // drying walls are more vulnerable
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/wall/concrete/reinforced
	name = "hexacrete wall"
	desc = "A thick wall made of steel-reinforced hexacrete. Sturdier than a normal concrete wall."
	icon = 'icons/turf/walls/hexacrete.dmi'
	icon_state = "hexacrete-0"
	base_icon_state = "hexacrete"

	rad_insulation = RAD_EXTREME_INSULATION
	hardness = 15
	explosion_block = 4 // good for bunkers
	girder_type = /obj/structure/girder

	min_dam = 13
	max_health = 1300
	time_to_harden = 60 SECONDS

// requires ENVIRONMENT_SMASH_RWALLS for simplemobs to break
/turf/closed/wall/concrete/reinforced/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if(!M.environment_smash)
		return
	if(M.environment_smash & ENVIRONMENT_SMASH_RWALLS)
		alter_health(-600) // 3 hits to kill
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		to_chat(M, "<span class='warning'>This wall is far too strong for you to destroy.</span>")
