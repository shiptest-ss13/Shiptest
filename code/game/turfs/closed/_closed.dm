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
	var/max_integrity = 100
	var/integrity
	var/brute_mod = 1
	var/burn_mod = 1
	var/repair_amount = 50
	// Projectiles that do extra damage to the wall
	var/list/extra_dam_proj

	var/mutable_appearance/damage_overlay
	var/damage_visual = 'icons/effects/wall_damage.dmi'

/turf/closed/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(integrity == null)
		integrity = max_integrity

/turf/closed/update_overlays()
	. = ..()
	damage_overlay = null
	var/adj_dam_pct = 1 - (integrity/(max_integrity))
	if(adj_dam_pct < 0)
		adj_dam_pct = 0
	if(!damage_overlay)
		damage_overlay = mutable_appearance(damage_visual, "cracks", BULLET_HOLE_LAYER)
	damage_overlay.alpha = adj_dam_pct*255
	. += damage_overlay

/turf/closed/examine(mob/user)
	. = ..()
	. += damage_hints(user)

/turf/closed/proc/damage_hints(mob/user)
	switch(integrity / max_integrity)
		if(0.5 to 0.99)
			return "[p_they(TRUE)] look[p_s()] slightly damaged."
		if(0.25 to 0.5)
			return "[p_they(TRUE)] appear[p_s()] heavily damaged."
		if(0 to 0.25)
			return "<span class='warning'>[p_theyre(TRUE)] falling apart!</span>"
	return

/turf/closed/AfterChange()
	. = ..()
	SSair.high_pressure_delta -= src

/turf/closed/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE

// negative values reduce integrity, positive values increase integrity.
// Devastate forces a devestate, safe decon prevents it.
/turf/closed/proc/alter_integrity(damage, devastate = FALSE, safe_decon = FALSE)
	integrity += damage
	if(integrity >= max_integrity)
		integrity = max_integrity
	if(integrity <= 0)
		if(safe_decon)
			dismantle_wall()
			return FALSE
		// if damage put us 50 points or more below 0, and not safe decon we got proper demolished
		if(integrity <= -50)
			dismantle_wall(TRUE)
			return FALSE
		if(devastate)
			dismantle_wall(TRUE)
			return FALSE
		dismantle_wall()
		return FALSE
	integrity = min(integrity, max_integrity)
	update_stats()
	return integrity

/turf/closed/proc/set_integrity(amount,devastate = FALSE)
	integrity = amount
	update_stats()
	if(integrity <= 0)
		dismantle_wall(devastate)

/turf/closed/proc/dismantle_wall(devastate = FALSE)
	for(var/obj/structure/sign/poster/P in src.contents) //Eject contents!
		P.roll_and_drop(src)

	ScrapeAway()

/turf/closed/proc/update_stats()
	update_appearance()

/turf/closed/bullet_act(obj/projectile/P)
	. = ..()
	var/dam = get_proj_damage(P)
	if(!dam)
		return
	if(P.suppressed != SUPPRESSED_VERY)
		visible_message("<span class='danger'>[src] is hit by \a [P]!</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!QDELETED(src))
		alter_integrity(-dam)

// catch-all for using most items on the closed turf -- attempt to smash
/turf/closed/proc/try_destroy(obj/item/W, mob/user, turf/T)
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
			playsound(src,attack_hitsound, 100, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
	alter_integrity(-dam)
	return TRUE

/turf/closed/proc/get_item_damage(obj/item/I, t_min = min_dam)
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
				dam *= burn_mod
			else
				return 0
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/proc/get_proj_damage(obj/projectile/P, t_min = min_dam)
	var/dam = P.damage
	if(is_type_in_list(P, extra_dam_proj))
		dam = max(dam, 30)
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
			alter_integrity(rand(-500, -800))
		if(EXPLODE_LIGHT)
			alter_integrity(rand(-200, -700))

/turf/closed/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	//get the user's location
	if(!isturf(user.loc))
		return	//can't do this stuff whilst inside objects and such

	add_fingerprint(user)

	var/turf/T = user.loc	//get user's location for delay checks

	attack_override(W,user,T)
	return ..()

/turf/closed/proc/attack_override(obj/item/W, mob/user, turf/loc)
	//the istype cascade has been spread among various procs for easy overriding or if we want to call something specific
	if(try_decon(W, user, loc) || try_destroy(W, user, loc))
		return

/turf/closed/proc/try_decon(obj/item/I, mob/user, turf/T)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, "<span class='notice'>You begin slicing through the outer plating...</span>")
		while(I.use_tool(src, user, breakdown_duration, volume=50))
			if(iswallturf(src))
				to_chat(user, "<span class='notice'>You slice through some of the outer plating...</span>")
				alter_integrity(-(I.wall_decon_damage),FALSE,TRUE)

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
		M.visible_message("<span class='danger'>[M.name] hits [src] with great force!</span>", \
					"<span class='danger'>You hit [src] with incredible force!</span>", null, COMBAT_MESSAGE_RANGE)
		dismantle_wall(TRUE)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		M.visible_message("<span class='danger'>[M.name] hits [src]!</span>", \
					"<span class='danger'>You hit [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		alter_integrity(M.force * 20)

/turf/closed/attack_hulk(mob/living/carbon/user)
	..()
	var/obj/item/bodypart/arm = user.hand_bodyparts[user.active_hand_index]
	if(!arm || arm.bodypart_disabled)
		return
	alter_integrity(-250)
	user.visible_message("<span class='danger'>[user] smashes \the [src]!</span>", \
				"<span class='danger'>You smash \the [src]!</span>", \
				"<span class='hear'>You hear a booming smash!</span>")
	return TRUE
