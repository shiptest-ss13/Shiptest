
// Drill, Diamond drill, Mining scanner

#define DRILL_BASIC 1
#define DRILL_HARDENED 2

/obj/item/mecha_parts/mecha_equipment/drill
	name = "exosuit drill"
	desc = "Equipment for engineering and combat exosuits. This is the drill that'll pierce the heavens!"
	icon_state = "mecha_drill"
	equip_cooldown = 15
	energy_drain = 10
	force = 15
	harmful = TRUE
	tool_behaviour = TOOL_DRILL
	toolspeed = 0.9
	var/drill_delay = 7
	var/drill_level = DRILL_BASIC
	wall_decon_damage = 50

/obj/item/mecha_parts/mecha_equipment/drill/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 100, null, null, TRUE)

/obj/item/mecha_parts/mecha_equipment/drill/action(atom/target)
	if(!action_checks(target))
		return
	if(isspaceturf(target))
		return
	if(isobj(target))
		var/obj/target_obj = target
		if(target_obj.resistance_flags & UNACIDABLE)
			return
	target.visible_message(
		span_warning("[chassis] starts to drill [target]."),
		span_userdanger("[chassis] starts to drill [target]..."),
		span_hear("You hear drilling.")
	)

	if(do_after_cooldown(target))
		set_ready_state(FALSE)
		log_message("Started drilling [target]", LOG_MECHA)
		if(isturf(target))
			var/turf/T = target
			T.drill_act(src)
			set_ready_state(TRUE)
			return
		while(do_after_mecha(target, drill_delay))
			if(isliving(target))
				drill_mob(target, chassis.occupant)
				playsound(src,'sound/weapons/drill.ogg',40,TRUE)
			else if(isobj(target))
				var/obj/O = target
				O.take_damage(15, BRUTE, 0, FALSE, get_dir(chassis, target))
				playsound(src,'sound/weapons/drill.ogg',40,TRUE)
			else
				set_ready_state(TRUE)
				return
		set_ready_state(TRUE)

/turf/proc/drill_act(obj/item/mecha_parts/mecha_equipment/drill/drill)
	return

/turf/closed/wall/drill_act(obj/item/mecha_parts/mecha_equipment/drill/drill)
	while(drill.do_after_mecha(src, 15 / drill.drill_level))
		drill.log_message("Drilled through [src]", LOG_MECHA)
		drill.occupant_message(span_notice("You drill through some of the outer plating..."))
		playsound(src,'sound/weapons/drill.ogg',60,TRUE)
		if(!alter_integrity(-drill.wall_decon_damage))
			return TRUE

/turf/closed/wall/r_wall/drill_act(obj/item/mecha_parts/mecha_equipment/drill/drill)
	if(drill.drill_level >= DRILL_HARDENED)
		while(drill.do_after_mecha(src, 20 / drill.drill_level))
			drill.log_message("Drilled through [src]", LOG_MECHA)
			drill.occupant_message(span_notice("You drill through some of the outer plating..."))
			playsound(src,'sound/weapons/drill.ogg',60,TRUE)
			if(!alter_integrity(-drill.wall_decon_damage))
				return TRUE

	else
		drill.occupant_message(span_danger("[src] is too durable to drill through."))

/turf/closed/mineral/drill_act(obj/item/mecha_parts/mecha_equipment/drill/drill)
	for(var/turf/closed/mineral/M in range(drill.chassis,1))
		if(get_dir(drill.chassis,M)&drill.chassis.dir)
			M.gets_drilled()
	drill.log_message("Drilled through [src]", LOG_MECHA)
	drill.move_ores()

/turf/open/floor/plating/asteroid/drill_act(obj/item/mecha_parts/mecha_equipment/drill/drill)
	for(var/turf/open/floor/plating/asteroid/M in range(1, drill.chassis))
		if((get_dir(drill.chassis,M)&drill.chassis.dir) && !M.dug)
			M.getDug()
	drill.log_message("Drilled through [src]", LOG_MECHA)
	drill.move_ores()


/obj/item/mecha_parts/mecha_equipment/drill/proc/move_ores()
	if(locate(/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp) in chassis.equipment && istype(chassis, /obj/mecha/working/ripley))
		var/obj/mecha/working/ripley/R = chassis //we could assume that it's a ripley because it has a clamp, but that's ~unsafe~ and ~bad practice~
		R.collect_ore()

/obj/item/mecha_parts/mecha_equipment/drill/can_attach(obj/mecha/M as obj)
	if(..())
		if(istype(M, /obj/mecha/working) || istype(M, /obj/mecha/combat))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/drill/attach(obj/mecha/M)
	..()
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = TRUE
	RegisterSignal(chassis, COMSIG_MOVABLE_BUMP, PROC_REF(bump_mine))

///Called whenever the mech bumps into something; action() handles checking if it is a mineable turf
/obj/item/mecha_parts/mecha_equipment/drill/proc/bump_mine(obj/mecha/bumper, atom/bumped_into)
	SIGNAL_HANDLER

	if(chassis.selected == src)
		if(!chassis.occupant) //prevents exosuit from digging if it pushed with something, like an explosion
			return
		if(istype(bumped_into, /turf/closed/mineral/))
			INVOKE_ASYNC(src, PROC_REF(action), bumped_into, null, TRUE)

/obj/item/mecha_parts/mecha_equipment/drill/detach(atom/moveto)
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = FALSE
	UnregisterSignal(chassis, COMSIG_MOVABLE_BUMP)
	..()

/obj/item/mecha_parts/mecha_equipment/drill/proc/drill_mob(mob/living/target, mob/user)
	target.visible_message(span_danger("[chassis] is drilling [target] with [src]!"), \
						span_userdanger("[chassis] is drilling you with [src]!"))
	log_combat(user, target, "drilled", "[name]", "(INTENT: [uppertext(user.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
	if(target.stat == DEAD && target.getBruteLoss() >= 200)
		log_combat(user, target, "gibbed", name)
		if(LAZYLEN(target.butcher_results) || LAZYLEN(target.guaranteed_butcher_results))
			var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
			butchering.Butcher(chassis, target)
		else
			target.gib()
	else
		//drill makes a hole
		var/obj/item/bodypart/target_part = target.get_bodypart(ran_zone(BODY_ZONE_CHEST))
		target.apply_damage(10, BRUTE, BODY_ZONE_CHEST, target.run_armor_check(target_part, "melee"))

		//blood splatters
		var/splatter_dir = get_dir(chassis, target)
		if(isalien(target))
			new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target.drop_location(), splatter_dir)
		else
			var/splatter_color = null
			if(iscarbon(target))
				var/mob/living/carbon/carbon_target = target
				splatter_color = carbon_target.dna.blood_type.color
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(target.drop_location(), splatter_dir, splatter_color)

		//organs go everywhere
		if(target_part && prob(10 * drill_level))
			target_part.dismember(BRUTE)

/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill
	name = "diamond-tipped exosuit drill"
	desc = "Equipment for engineering and combat exosuits. This is an upgraded version of the drill that'll pierce the heavens!"
	icon_state = "mecha_diamond_drill"
	equip_cooldown = 10
	drill_delay = 4
	drill_level = DRILL_HARDENED
	force = 15
	toolspeed = 0.7
	wall_decon_damage = 100

/obj/item/mecha_parts/mecha_equipment/mining_scanner
	name = "exosuit mining scanner"
	desc = "Equipment for engineering and combat exosuits. It will automatically check surrounding rock for useful minerals."
	icon_state = "mecha_analyzer"
	selectable = 0
	equip_cooldown = 15
	var/scanning_time = 0

/obj/item/mecha_parts/mecha_equipment/mining_scanner/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/obj/item/mecha_parts/mecha_equipment/mining_scanner/process(seconds_per_tick)
	if(!loc)
		STOP_PROCESSING(SSfastprocess, src)
		qdel(src)
	if(istype(loc, /obj/mecha/working) && scanning_time <= world.time)
		var/obj/mecha/working/mecha = loc
		if(!mecha.occupant)
			return
		scanning_time = world.time + equip_cooldown
		mineral_scan_pulse(get_turf(src))

#undef DRILL_BASIC
#undef DRILL_HARDENED

