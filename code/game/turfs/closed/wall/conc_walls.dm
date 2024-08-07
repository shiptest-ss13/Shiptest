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
	attack_hitsound =  'sound/effects/hit_stone.ogg'
	hitsound_type = PROJECTILE_HITSOUND_STONE
	sheet_type = null
	girder_type = /obj/structure/grille

	var/time_to_harden = 30 SECONDS
	// fraction ranging from 0 to 1 -- 0 is fully soft, 1 is fully hardened
	// don't change this in subtypes unless you want them to spawn in soft on maps
	var/harden_lvl = 1

	burn_mod = 0.66
	repair_amount = 0
	//mining projectiles do extra damage
	extra_dam_proj = list(
		/obj/projectile/kinetic,
		/obj/projectile/destabilizer,
		/obj/projectile/plasma)

/turf/closed/wall/concrete/Initialize(mapload, ...)
	. = ..()
	check_harden()
	update_stats()

/turf/closed/wall/concrete/copyTurf(turf/T, copy_air, flags)
	. = ..()
	// by this point it's guaranteed to be a concrete wall
	var/turf/closed/wall/concrete/conc_wall = T
	if(conc_wall.integrity != integrity || conc_wall.harden_lvl != harden_lvl)
		conc_wall.harden_lvl = harden_lvl
		conc_wall.integrity = integrity
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

// we use this to show integrity + drying percentage
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
	return

/turf/closed/wall/concrete/create_girder()
	var/obj/girder = ..()
	if(integrity < 0)
		girder.take_damage(min(abs(integrity), 50))
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

/turf/closed/wall/concrete/update_stats()
	.= .. ()
	// explosion block is diminished on a damaged / soft wall
	explosion_block = (integrity / max_integrity) * harden_lvl * initial(explosion_block)

/turf/closed/wall/concrete/alter_integrity(damage)
	// 8x as vulnerable when unhardened
	if(damage < 0)
		damage *= 1 + 7*(1-harden_lvl)
	.= ..()

/turf/closed/wall/concrete/mech_melee_attack(obj/mecha/M)
	M.do_attack_animation(src)
	switch(M.damtype)
		if(BRUTE)
			M.visible_message("<span class='danger'>[M.name] hits [src]!</span>", \
							"<span class='danger'>You hit [src]!</span>", null, COMBAT_MESSAGE_RANGE)
			playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
			alter_integrity(M.force * -20)
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

/turf/closed/wall/concrete/get_item_damage(obj/item/I, t_min = min_dam)
	t_min = min_dam / (1 + 7*(1-harden_lvl)) // drying walls are more vulnerable
	. = .. ()


/turf/closed/wall/concrete/get_proj_damage(obj/projectile/P, t_min = min_dam)
	t_min = min_dam / (1 + 7*(1-harden_lvl)) // drying walls are more vulnerable
	. = ..()

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
	max_integrity = 1300
	time_to_harden = 60 SECONDS

// requires ENVIRONMENT_SMASH_RWALLS for simplemobs to break
/turf/closed/wall/concrete/reinforced/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if(!M.environment_smash)
		return
	if(M.environment_smash & ENVIRONMENT_SMASH_RWALLS)
		alter_integrity(-600) // 3 hits to kill
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		to_chat(M, "<span class='warning'>This wall is far too strong for you to destroy.</span>")
