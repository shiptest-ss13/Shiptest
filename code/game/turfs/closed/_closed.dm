/turf/closed
	layer = CLOSED_TURF_LAYER
	opacity = TRUE
	density = TRUE
	blocks_air = TRUE
	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	rad_insulation = RAD_MEDIUM_INSULATION
	pass_flags_self = PASSCLOSEDTURF

	///lower numbers are harder. Used to determine the probability of a hulk smashing through.
	var/hardness = 40
	var/breakdown_duration = 20  //default time it takes for a tool to break the wall

	var/attack_hitsound = 'sound/weapons/smash.ogg'
	var/break_sound = 'sound/items/welder.ogg'
	hitsound_type = PROJECTILE_HITSOUND_METAL

	// The wall will ignore damage from weak items, depending on their
	// force, damage type, tool behavior, and sharpness. This is the minimum
	// amount of force that a blunt, brute item must have to damage the wall.
	var/min_dam = 0
	var/brute_mod = 1
	var/burn_mod = 1
	// Projectiles that do extra damage to the wall
	var/list/extra_dam_proj

	var/mob_smash_flags
	var/proj_bonus_damage_flags

	var/mutable_appearance/damage_overlay
	var/damage_visual = 'icons/effects/wall_damage.dmi'
	var/overlay_layer = BULLET_HOLE_LAYER

	var/list/dent_decals

/turf/closed/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(atom_integrity == null)
		atom_integrity = max_integrity

/turf/closed/copyTurf(turf/T, copy_air, flags)
	. = ..()
	var/turf/closed/wall_copy = T
	if(LAZYLEN(dent_decals))
		wall_copy.dent_decals = dent_decals.Copy()
		wall_copy.update_appearance()

/turf/closed/update_overlays()
	. = ..()
	damage_overlay = null
	var/adj_dam_pct = 1 - (atom_integrity/(max_integrity))
	if(adj_dam_pct < 0)
		adj_dam_pct = 0
	if(!damage_overlay)
		damage_overlay = mutable_appearance(damage_visual, "cracks", overlay_layer)
	damage_overlay.alpha = adj_dam_pct*255
	. += damage_overlay
	for(var/decal in dent_decals)
		. += decal

/turf/closed/proc/add_dent(denttype, x=rand(-8, 8), y=rand(-8, 8))
	if(LAZYLEN(dent_decals) >= MAX_DENT_DECALS)
		return

	var/mutable_appearance/decal = mutable_appearance('icons/effects/effects.dmi', "", BULLET_HOLE_LAYER)
	switch(denttype)
		if(WALL_DENT_SHOT)
			decal.icon_state = "bullet_hole"
		if(WALL_DENT_HIT)
			decal.icon_state = "impact[rand(1, 3)]"

	decal.pixel_x = x
	decal.pixel_y = y
	LAZYADD(dent_decals, decal)
	update_appearance()

/turf/closed/examine(mob/user)
	. = ..()
	. += damage_hints(user)

/turf/closed/proc/damage_hints(mob/user)
	switch(atom_integrity / max_integrity)
		if(0.5 to 0.99)
			return "[p_they(TRUE)] look[p_s()] slightly damaged."
		if(0.25 to 0.5)
			return "[p_they(TRUE)] appear[p_s()] heavily damaged."
		if(0 to 0.25)
			return span_warning("[p_theyre(TRUE)] falling apart!")
	return

/turf/closed/AfterChange()
	. = ..()
	SSair.high_pressure_delta -= src

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

/// Damage Code

// negative values reduce integrity, positive values increase integrity.
// Devastate forces a devestate, safe decon prevents it.
/turf/closed/proc/alter_integrity(damage, mob/user, devastate = FALSE, safe_decon = FALSE)
	atom_integrity += damage
	if(atom_integrity >= max_integrity)
		atom_integrity = max_integrity
	if(atom_integrity <= 0)
		if(safe_decon)
			dismantle_wall(FALSE, user)
			return FALSE
		// if damage put us 50 points or more below 0, and not safe decon we got proper demolished
		if(atom_integrity <= -50)
			dismantle_wall(TRUE, user)
			return FALSE
		if(devastate)
			dismantle_wall(TRUE, user)
			return FALSE
		dismantle_wall(FALSE,user)
		return FALSE
	atom_integrity = min(atom_integrity, max_integrity)
	update_stats()
	return atom_integrity

/turf/closed/proc/set_integrity(amount,devastate = FALSE, mob/user)
	atom_integrity = amount
	update_stats()
	if(atom_integrity <= 0)
		dismantle_wall(devastate, user)

/turf/closed/proc/dismantle_wall(devastate = FALSE, mob/user)
	for(var/obj/structure/sign/poster/P in src.contents) //Eject contents!
		P.roll_and_drop(src)

	ScrapeAway()

/turf/closed/proc/update_stats()
	update_appearance()

/turf/closed/bullet_act(obj/projectile/P)
	. = ..()
	var/dam = get_proj_damage(P)
	var/shooter = P.firer
	if(!dam)
		return
	if(P.suppressed != SUPPRESSED_VERY)
		visible_message(span_danger("[src] is hit by \a [P]!"), null, null, COMBAT_MESSAGE_RANGE)
	if(!QDELETED(src))
		add_dent(WALL_DENT_SHOT)
		alter_integrity(-dam, shooter)

/turf/closed/proc/get_item_damage(obj/item/used_item, mob/user, t_min = min_dam)
	used_item.closed_turf_attack(src,user)
	var/damage = used_item.force * used_item.demolition_mod
	// if dam is below t_min, then the hit has no effect
	return (damage < t_min ? 0 : damage)

/turf/closed/proc/get_proj_damage(obj/projectile/P, t_min = min_dam)
	var/dam = P.damage
	if(proj_bonus_damage_flags & P.wall_damage_flags)
		dam = P.wall_damage_override
	else
		switch(P.damage_type)
			if(BRUTE)
				dam *= brute_mod
			if(BURN)
				dam *= burn_mod
			else
				return 0
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/ex_act(severity, target)
	if(target == src || !density)
		return ..()
	switch(severity)
		if(EXPLODE_DEVASTATE)
			// SN src = null
			var/turf/NT = ScrapeAway()
			NT.contents_explosion(severity, target)
			return
		if(EXPLODE_HEAVY)
			alter_integrity(rand(-300, -500))
		if(EXPLODE_LIGHT)
			alter_integrity(rand(-100, -200))

/turf/closed/attack_paw(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	return attack_hand(user)

/turf/closed/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	to_chat(user, span_notice("You push \the [src] but nothing happens!"))
	playsound(src, 'sound/weapons/genhit.ogg', 25, TRUE)
	add_fingerprint(user)

/turf/closed/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(W.attack_cooldown)
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return

	//get the user's location
	if(!isturf(user.loc))
		return	//can't do this stuff whilst inside objects and such

	add_fingerprint(user)

	var/turf/T = user.loc	//get user's location for delay checks

	attack_override(W,user,T)
	return ..()

/turf/closed/proc/attack_override(obj/item/W, mob/user, turf/loc)
	if(!isclosedturf(src))
		return
	//the istype cascade has been spread among various procs for easy overriding or if we want to call something specific
	if(try_decon(W, user, loc) || try_destroy(W, user, loc))
		return

// catch-all for using most items on the closed turf -- attempt to smash
/turf/closed/proc/try_destroy(obj/item/used_item, mob/user, turf/T)
	var/total_damage = get_item_damage(used_item, user)
	user.do_attack_animation(src)
	if(total_damage <= 0)
		to_chat(user, span_warning("[used_item] isn't strong enough to damage [src]!"))
		playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		return TRUE
	log_combat(user, src, "attacked", used_item)
	user.visible_message(span_danger("[user] hits [src] with [used_item]!"), \
				span_danger("You hit [src] with [used_item]!</span>"), null, COMBAT_MESSAGE_RANGE)
	switch(used_item.damtype)
		if(BRUTE)
			playsound(src,attack_hitsound, 100, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
	add_dent(WALL_DENT_HIT)
	//used_item.closed_turf_attack(T,user)
	alter_integrity(-total_damage, user)
	return TRUE

/turf/closed/proc/try_decon(obj/item/I, mob/user, turf/T)
	var/act_duration = breakdown_duration
	if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, src, amount=0))
			return FALSE
		to_chat(user, span_notice("You begin slicing through the outer plating..."))
		while(I.use_tool(src, user, act_duration, volume=50))
			if(iswallturf(src))
				to_chat(user, span_notice("You slice through some of the outer plating..."))
				if(!alter_integrity(-(I.wall_decon_damage),user,FALSE,TRUE))
					return TRUE
			else
				break

	return FALSE

/turf/closed/deconstruct_act(mob/living/user, obj/item/I)
	var/act_duration = breakdown_duration
	if(breakdown_duration == -1)
		to_chat(user, span_warning("[src] cannot be deconstructed!"))
		return FALSE
	if(!I.tool_start_check(user, src, amount=0))
		return FALSE
	to_chat(user, span_notice("You begin slicing through the outer plating..."))
	while(I.use_tool(src, user, act_duration, volume=100))
		if(iswallturf(src))
			to_chat(user, span_notice("You slice through some of the outer plating..."))
			if(!alter_integrity(-(I.wall_decon_damage),user,FALSE,TRUE))
				return TRUE
		else
			break

	return FALSE

/turf/closed/mech_melee_attack(obj/mecha/M)
	M.do_attack_animation(src)
	switch(M.damtype)
		if(BRUTE)
			playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
		if(TOX)
			playsound(src, 'sound/effects/spray2.ogg', 100, TRUE)


	if(prob(hardness + M.force) && M.force > 20)
		M.visible_message(span_danger("[M.name] hits [src] with great force!"), \
					span_danger("You hit [src] with incredible force!"), null, COMBAT_MESSAGE_RANGE)
		dismantle_wall(TRUE)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		M.visible_message(span_danger("[M.name] hits [src]!"), \
					span_danger("You hit [src]!"), null, COMBAT_MESSAGE_RANGE)
		alter_integrity(M.force * 20)

/turf/closed/attack_hulk(mob/living/carbon/user)
	..()
	var/obj/item/bodypart/arm = user.hand_bodyparts[user.active_hand_index]
	if(!arm || arm.bodypart_disabled)
		return
	alter_integrity(-250,user)
	user.visible_message(span_danger("[user] smashes \the [src]!"), \
				span_danger("You smash \the [src]!"), \
				span_hear("You hear a booming smash!"))
	return TRUE

/turf/closed/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if((M.environment_smash & mob_smash_flags))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
		alter_integrity(-400)
		return

/turf/closed/zap_act(power, zap_flags, shocked_targets)
	if(QDELETED(src))
		return FALSE
	if(alter_integrity(-power) >= 0)
		return TRUE
	return power / 2
