// everyone with the element, so gunfire only has to check them rather than everything in range. ELEMENT_DETACH takes them off when they're deleted
GLOBAL_LIST_EMPTY(ai_gunfire_listeners)

/datum/element/ai_hears_gunfire
	element_flags = ELEMENT_DETACH

/datum/element/ai_hears_gunfire/Attach(datum/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	ADD_TRAIT(target, TRAIT_AI_HEARS_GUNFIRE, ELEMENT_TRAIT(type))
	GLOB.ai_gunfire_listeners |= target

/datum/element/ai_hears_gunfire/Detach(datum/source, ...)
	REMOVE_TRAIT(source, TRAIT_AI_HEARS_GUNFIRE, ELEMENT_TRAIT(type))
	GLOB.ai_gunfire_listeners -= source
	return ..()

// edit GUNFIRE_ALERT_COOLDOWN if we need to tweak how often it checks
/proc/alert_ai_to_gunfire(mob/living/shooter, suppression, is_laser, atom/fired_from)
	if(!istype(shooter) || suppression >= SUPPRESSED_VERY)
		return
	if(!suppression)
		ai_reveal_in_dark(shooter, 2 SECONDS) // the muzzle flash gives them away, 2 seconds so it doesnt hide between ai thinking ticks
	// guns say how loud they are. Mobs shooting without one go by what they're firing
	var/obj/item/gun/gun = fired_from
	if(!istype(gun))
		gun = null
	var/hearing_range = gun ? gun.gunfire_hearing_range : (is_laser ? LASER_HEARING_RANGE : GUNFIRE_HEARING_RANGE)
	if(suppression)
		if(!isnull(gun?.suppressed_gunfire_hearing_range))
			hearing_range = gun.suppressed_gunfire_hearing_range // like a built-in suppressor that's quieter than most
		else
			hearing_range = hearing_range ? max(1, round(hearing_range / SUPPRESSED_HEARING_REDUCTION)) : 0 // quieter, but only a gun that's silent anyway is silent suppressed
	var/turf/origin = get_turf(shooter)
	if(!origin || hearing_range < 1)
		return
	// each shooter's last alert, as list(when it stops covering their shots, where it was from, how far it carried)
	var/static/list/last_alert_by_shooter = list()
	var/shooter_ref = REF(shooter)
	var/list/last_alert = last_alert_by_shooter[shooter_ref]
	if(last_alert && world.time < last_alert[1] && get_dist(origin, last_alert[2]) <= 1 && hearing_range <= last_alert[3])
		return
	if(length(last_alert_by_shooter) > 200) // forget shooters whose alerts are long over, so this doesn't grow forever
		for(var/old_ref in last_alert_by_shooter)
			var/list/old_alert = last_alert_by_shooter[old_ref]
			if(old_alert[1] < world.time)
				last_alert_by_shooter -= old_ref
	last_alert_by_shooter[shooter_ref] = list(world.time + GUNFIRE_ALERT_COOLDOWN, origin, hearing_range)
	for(var/mob/living/listener as anything in GLOB.ai_gunfire_listeners)
		// only those out on a turf, like range() would give us, so not someone shut in a locker
		if(listener == shooter || QDELETED(listener) || !isturf(listener.loc) || listener.z != origin.z || get_dist(origin, listener) > hearing_range || !HAS_TRAIT(listener, TRAIT_AI_HEARS_GUNFIRE))
			continue
		var/heard_distance = get_heard_distance(origin, listener, hearing_range, AI_HEARING_WALL_PENALTY)
		if(!isnull(heard_distance))
			ai_hear_gunfire(listener, shooter, origin, heard_distance)

// goes after someone we heard shooting, if they're an enemy and we're not busy. heard_distance is how far away it sounded, walls and all
/proc/ai_hear_gunfire(mob/living/listener, mob/living/shooter, turf/origin, heard_distance)
	var/datum/ai_controller/controller = listener.ai_controller
	if(!controller || controller.ai_status == AI_STATUS_OFF || listener.stat != CONSCIOUS || listener.client)
		return
	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(current_target == shooter)
		return // already on them
	if(!QDELETED(current_target) && (controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE || AI_RECENTLY_SAW_ENEMY(controller, AI_FIGHT_MEMORY)))
		return // busy with someone we can see, or just could
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	if(!targetting_datum?.can_attack(listener, shooter))
		return // one of ours, or someone we wouldn't fight anyway
	AI_LOG_DECISION(controller, "ai_hears_gunfire: heard [shooter] shooting at [origin], [round(heard_distance)] tiles away by ear")
	// we only roughly know where it came from, so we'll have a look around there once we arrive
	var/inaccuracy = round(heard_distance / 4)
	var/turf/guess = guess_sound_origin(origin, inaccuracy, somewhere_to_stand = TRUE)
	if(controller.learn_of_target(shooter, guess, AI_LEARNED_HEARD))
		return
	controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_CENTER, guess)
	controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_RADIUS, max(inaccuracy, 2))
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_SPOTS_LEFT)
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_PAUSE_UNTIL)
