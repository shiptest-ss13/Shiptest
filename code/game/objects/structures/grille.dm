/obj/structure/grille
	desc = "A flimsy framework of metal rods."
	name = "grille"
	icon = 'icons/obj/structures.dmi'
	icon_state = "grille"
	base_icon_state = "grille"
	density = TRUE
	anchored = TRUE
	pass_flags_self = PASSGRILLE
	flags_1 = CONDUCT_1 | RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	pressure_resistance = 5*ONE_ATMOSPHERE
	armor = list("melee" = 50, "bullet" = 70, "laser" = 70, "energy" = 100, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	max_integrity = 50
	integrity_failure = 0.4
	var/rods_type = /obj/item/stack/rods
	var/rods_amount = 2
	var/rods_broken = TRUE
	var/grille_type = null
	var/broken_type = /obj/structure/grille/broken
	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	FASTDMM_PROP(\
		pipe_astar_cost = 1\
	)

/*WS Edit - Revert smartwire
/obj/structure/grille/Destroy()
	update_cable_icons_on_turf(get_turf(src))
	return ..()
*/

/obj/structure/grille/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	update_appearance()

/obj/structure/grille/update_appearance(updates)
	if(QDELETED(src) || broken)
		return

	. = ..()

	if(smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)

/obj/structure/grille/update_icon_state()
	icon_state = "[base_icon_state][((atom_integrity / max_integrity) <= 0.5) ? "50_[rand(0, 3)]" : null]"
	return ..()

/obj/structure/grille/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("It's secured in place with <b>screws</b>. The rods look like they could be <b>cut</b> through.")
	if(!anchored)
		. += span_notice("The anchoring screws are <i>unscrewed</i>. The rods look like they could be <b>cut</b> through.")

/obj/structure/grille/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			if(resistance_flags & INDESTRUCTIBLE)
				return FALSE
			return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 5)
		if(RCD_WINDOWGRILLE)
			if(the_rcd.window_type == /obj/structure/window/reinforced/fulltile)
				return list("mode" = RCD_WINDOWGRILLE, "delay" = 40, "cost" = 12)
			else
				return list("mode" = RCD_WINDOWGRILLE, "delay" = 20, "cost" = 8)
	return FALSE

/obj/structure/grille/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			if(resistance_flags & INDESTRUCTIBLE)
				return FALSE
			to_chat(user, span_notice("You deconstruct the grille."))
			qdel(src)
			return TRUE
		if(RCD_WINDOWGRILLE)
			if(!isturf(loc))
				return FALSE
			var/turf/T = loc
			if(!ispath(the_rcd.window_type, /obj/structure/window))
				CRASH("Invalid window path type in RCD: [the_rcd.window_type]")
			var/obj/structure/window/window_path = the_rcd.window_type
			if(!valid_window_location(T, user.dir, is_fulltile = initial(window_path.fulltile)))
				return FALSE
			to_chat(user, span_notice("You construct the window."))
			var/obj/structure/window/WD = new the_rcd.window_type(T, user.dir)
			WD.set_anchored(TRUE)
			return TRUE
	return FALSE

/obj/structure/grille/Bumped(atom/movable/AM)
	if(!ismob(AM))
		return
	var/mob/M = AM
	shock(M, 70)

/obj/structure/grille/attack_animal(mob/user)
	. = ..()
	if(!.)
		return
	if(!shock(user, 70) && !QDELETED(src)) //Last hit still shocks but shouldn't deal damage to the grille
		take_damage(rand(5,10), BRUTE, "melee", 1)

/obj/structure/grille/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/grille/hulk_damage()
	return 60

/obj/structure/grille/attack_hulk(mob/living/carbon/human/user)
	if(shock(user, 70))
		return
	. = ..()

/obj/structure/grille/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	user.do_attack_animation(src, ATTACK_EFFECT_KICK)
	user.visible_message(span_warning("[user] hits [src]."), null, null, COMBAT_MESSAGE_RANGE)
	log_combat(user, src, "hit")
	if(!shock(user, 70))
		take_damage(rand(5,10), BRUTE, "melee", 1)

/obj/structure/grille/attack_alien(mob/living/user)
	user.do_attack_animation(src)
	user.changeNext_move(CLICK_CD_MELEE)
	user.visible_message(span_warning("[user] mangles [src]."), null, null, COMBAT_MESSAGE_RANGE)
	if(!shock(user, 70))
		take_damage(20, BRUTE, "melee", 1)

/obj/structure/grille/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!. && istype(mover, /obj/projectile))
		return prob(30)

/obj/structure/grille/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/requester)
	. = !density
	if(istype(requester))
		. = . || (requester.pass_flags & PASSGRILLE)

/obj/structure/grille/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(W.tool_behaviour == TOOL_WIRECUTTER)
		if(!shock(user, 100))
			W.play_tool_sound(src, 100)
			deconstruct()
	else if((W.tool_behaviour == TOOL_SCREWDRIVER) && (isturf(loc) || anchored))
		if(!shock(user, 90))
			W.play_tool_sound(src, 100)
			set_anchored(!anchored)
			user.visible_message(
				span_notice("[user] [anchored ? "fastens" : "unfastens"] [src]."), \
				span_notice("You [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor."))
			return
	else if(istype(W, /obj/item/stack/rods) && broken)
		var/obj/item/stack/rods/R = W
		if(!shock(user, 90))
			user.visible_message(
				span_notice("[user] rebuilds the broken grille."), \
				span_notice("You rebuild the broken grille."))
			new grille_type(src.loc)
			R.use(1)
			qdel(src)
			return

//window placing begin
	else if(is_glass_sheet(W))
		if (!broken)
			var/obj/item/stack/ST = W
			if (ST.get_amount() < 2)
				to_chat(user, span_warning("You need at least two sheets of glass for that!"))
				return
			var/dir_to_set = SOUTHWEST
			if(!anchored)
				to_chat(user, span_warning("[src] needs to be fastened to the floor first!"))
				return
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, span_warning("There is already a window there!"))
				return
			to_chat(user, span_notice("You start placing the window..."))
			if(do_after(user,20, target = src))
				if(!src.loc || !anchored) //Grille broken or unanchored while waiting
					return
				for(var/obj/structure/window/WINDOW in loc) //Another window already installed on grille
					return
				var/obj/structure/window/WD
				if(istype(W, /obj/item/stack/sheet/plasmarglass))
					WD = new/obj/structure/window/plasma/reinforced/fulltile(drop_location()) //reinforced plasma window
				else if(istype(W, /obj/item/stack/sheet/plasmaglass))
					WD = new/obj/structure/window/plasma/fulltile(drop_location()) //plasma window
				else if(istype(W, /obj/item/stack/sheet/rglass))
					WD = new/obj/structure/window/reinforced/fulltile(drop_location()) //reinforced window
				else if(istype(W, /obj/item/stack/sheet/titaniumglass))
					WD = new/obj/structure/window/reinforced/fulltile/shuttle(drop_location())
				else if(istype(W, /obj/item/stack/sheet/plastitaniumglass))
					WD = new/obj/structure/window/plasma/reinforced/plastitanium(drop_location())
				else
					WD = new/obj/structure/window/fulltile(drop_location()) //normal window
				WD.setDir(dir_to_set)
				WD.set_anchored(FALSE)
				WD.state = 0
				ST.use(2)
				to_chat(user, span_notice("You place [WD] on [src]."))
			return
//window placing end

	else if(istype(W, /obj/item/shard) || !shock(user, 70))
		return ..()

/obj/structure/grille/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/effects/grillehit.ogg', 80, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 80, TRUE)


/obj/structure/grille/deconstruct(disassembled = TRUE)
	if(!loc) //if already qdel'd somehow, we do nothing
		return
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/R = new rods_type(drop_location(), rods_amount) || locate(rods_type) in drop_location() // if the rods get merged, find the stack
		transfer_fingerprints_to(R)
		qdel(src)
	..()

/obj/structure/grille/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE
	if(!I.tool_start_check(user, src, amount=0))
		return FALSE
	if (I.use_tool(src, user, 1 SECONDS, volume=100))
		to_chat(user, span_warning("You slice [src] apart."))
		deconstruct(FALSE)
		return TRUE

/obj/structure/grille/atom_break()
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		new broken_type(src.loc)
		var/obj/R = new rods_type(drop_location(), rods_broken) || locate(rods_type) in drop_location() // see above
		transfer_fingerprints_to(R)
		qdel(src)
	. = ..()

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise

/obj/structure/grille/proc/shock(mob/user, prb)
	if(!anchored || broken)		// anchored/broken grilles are never connected
		return FALSE
	if(!prob(prb))
		return FALSE
	if(!in_range(src, user))//To prevent TK and mech users from getting shocked
		return FALSE
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src, 1, TRUE))
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			return TRUE
		else
			return FALSE
	return FALSE

/obj/structure/grille/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!broken)
		if(exposed_temperature > T0C + 1500)
			take_damage(1, BURN, 0, 0)
	..()

/obj/structure/grille/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(isobj(AM))
		if(prob(50) && anchored && !broken)
			var/obj/O = AM
			if(O.throwforce != 0)//don't want to let people spam tesla bolts, this way it will break after time
				var/turf/T = get_turf(src)
				var/obj/structure/cable/C = T.get_cable_node()
				if(C)
					playsound(src, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
					tesla_zap(src, 3, C.newavail() * 0.01, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_ALLOW_DUPLICATES) //Zap for 1/100 of the amount of power. At a million watts in the grid, it will be as powerful as a tesla revolver shot.
					C.add_delayedload(C.newavail() * 0.0375) // you can gain up to 3.5 via the 4x upgrades power is halved by the pole so thats 2x then 1X then .5X for 3.5x the 3 bounces shock.
	return ..()

/obj/structure/grille/get_dumping_location(datum/component/storage/source,mob/user)
	return null

/obj/structure/grille/indestructible
	flags_1 = CONDUCT_1 | NODECONSTRUCT_1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/grille/broken // Pre-broken grilles for map placement
	icon_state = "brokengrille"
	density = FALSE
	atom_integrity = 20
	broken = TRUE
	rods_amount = 1
	rods_broken = FALSE
	grille_type = /obj/structure/grille
	broken_type = null
