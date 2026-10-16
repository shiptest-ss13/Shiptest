/datum/component/ai_dodging

	var/dodge_chance = 30
	var/sidesteps = 1
	//chance to jink to one side when we're shot
	var/jink_chance = 0
	//TRUE while we're swerving, so we don't swerve while swerving
	var/swerving = FALSE
	// cooldown for jinking, so we don't jink every shot
	COOLDOWN_DECLARE(jink_cooldown)
	//after swerving or jinking, how long we keep straight on before we will again, so we make ground between them
	var/straight_run_time = 1.5 SECONDS
	COOLDOWN_DECLARE(straight_run)

/datum/component/ai_dodging/Initialize(dodge_chance = 30, sidesteps = 1, jink_chance = 0)
	. = ..()
	if(!isbasicmob(parent))
		return COMPONENT_INCOMPATIBLE
	src.dodge_chance = dodge_chance
	src.sidesteps = sidesteps
	src.jink_chance = jink_chance

/datum/component/ai_dodging/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_pre_move))
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_shot))

/datum/component/ai_dodging/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_MOVABLE_PRE_MOVE, COMSIG_ATOM_BULLET_ACT))

/datum/component/ai_dodging/proc/on_pre_move(mob/living/basic/source, atom/newloc)
	SIGNAL_HANDLER
	if(swerving || source.moving_diagonally || !isturf(source.loc) || !isturf(newloc) || !COOLDOWN_FINISHED(src, straight_run) || !prob(dodge_chance))
		return NONE
	var/atom/target = source.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target) || source.Adjacent(target) || get_dist(newloc, target) >= get_dist(source, target))
		return NONE // only while we're closing in on them
	var/move_dir = get_dir(source.loc, newloc)
	var/our_distance = get_dist(source, target)
	for(var/angle in shuffle(list(45, -45)))
		var/turf/swerve_spot = get_step(source.loc, turn(move_dir, angle))
		if(!swerve_spot || get_dist(swerve_spot, target) >= our_distance)
			continue // a swerve that doesn't get us any closer only slows us down
		if(dodge_to(swerve_spot))
			COOLDOWN_START(src, straight_run, straight_run_time)
			return COMPONENT_MOVABLE_BLOCK_PRE_MOVE
	return NONE // if we couldn't swerve, we just carry on

/datum/component/ai_dodging/proc/queue_sidesteps(atom/target, window)
	if(sidesteps > 1)
		for(var/sidestep in 1 to sidesteps)
			addtimer(CALLBACK(src, PROC_REF(sidestep), target), (sidestep - 1) * window / sidesteps)
	else if(sidesteps == 1)
		addtimer(CALLBACK(src, PROC_REF(sidestep), target), rand(1, window))

/datum/component/ai_dodging/proc/sidestep(atom/target)
	var/mob/living/basic/basic_mob = parent
	if(QDELETED(target) || !isturf(target.loc) || !isturf(basic_mob.loc) || basic_mob.stat != CONSCIOUS || basic_mob.incapacitated())
		return
	var/static/list/cardinal_sidestep_directions = list(-90, -45, 0, 45, 90)
	var/static/list/diagonal_sidestep_directions = list(-45, 0, 45)
	var/target_dir = get_dir(basic_mob, target)
	var/chosen_angle = pick((target_dir & (target_dir - 1)) ? diagonal_sidestep_directions : cardinal_sidestep_directions)
	if(!chosen_angle)
		return
	dodge_to(get_step(basic_mob, turn(target_dir, chosen_angle)))
	basic_mob.face_atom(target) // looks better if they keep looking at you when dodging

// jinks to one side when we're shot, across the line of fire, so the next shot's more likely to miss
/datum/component/ai_dodging/proc/on_shot(mob/living/basic/source, obj/projectile/projectile)
	SIGNAL_HANDLER
	if(!jink_chance || !COOLDOWN_FINISHED(src, jink_cooldown) || !COOLDOWN_FINISHED(src, straight_run) || !prob(jink_chance))
		return
	var/turf/shot_from = get_turf(projectile.starting)
	if(!shot_from || !isturf(source.loc) || source.stat != CONSCIOUS || source.incapacitated())
		return
	var/datum/ai_controller/controller = source.ai_controller
	if(controller && (source.loc == controller.blackboard[BB_BASIC_MOB_TAKING_COVER_TURF] || source.loc == controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]))
		return // we'd only be jinking out of our cover
	COOLDOWN_START(src, jink_cooldown, 1 SECONDS)
	var/shot_dir = get_dir(shot_from, source)
	if(!shot_dir)
		return
	// if we can't go straight across, we go across and forward if we're closing in to hit them, or across and back if we fight from range
	var/list/diagonals = source.GetComponent(/datum/component/ranged_attacks) ? list(45, -45) : list(135, -135)
	for(var/angle in shuffle(list(90, -90)) + shuffle(diagonals))
		if(dodge_to(get_step(source, turn(shot_dir, angle))))
			COOLDOWN_START(src, straight_run, straight_run_time)
			break

// Returns TRUE if we dodge successfully (nothing blocked us)
/datum/component/ai_dodging/proc/dodge_to(turf/spot)
	var/mob/living/basic/basic_mob = parent
	if(!spot || (locate(/mob/living) in spot))
		return FALSE
	if(spot.is_blocked_turf(TRUE, basic_mob) || is_ai_hazard_turf(spot))
		return FALSE // cancel the entire dodge if it can't complete the full move, so it doesnt do a half move
	swerving = TRUE
	if(basic_mob.ai_controller)
		basic_mob.set_glide_size(DELAY_TO_GLIDE_SIZE(basic_mob.ai_controller.movement_delay)) // movement smoothing hopefully?
	. = basic_mob.Move(spot, get_dir(basic_mob, spot))
	swerving = FALSE
