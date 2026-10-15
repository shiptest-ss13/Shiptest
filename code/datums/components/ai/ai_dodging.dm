/datum/component/ai_dodging

	var/dodge_chance = 30
	var/sidesteps = 1
	//chance to jink to one side when we're shot
	var/jink_chance = 0
	//TRUE while we're swerving, so we don't swerve while swerving
	var/swerving = FALSE
	// cooldown for jinking, so we don't jink every shot
	COOLDOWN_DECLARE(jink_cooldown)

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
	if(swerving || source.moving_diagonally || !isturf(source.loc) || !isturf(newloc) || !prob(dodge_chance))
		return NONE
	var/atom/target = source.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target) || source.Adjacent(target) || get_dist(newloc, target) >= get_dist(source, target))
		return NONE // only while we're closing in on them
	var/move_dir = get_dir(source.loc, newloc)
	return dodge_to(get_step(source.loc, turn(move_dir, pick(45, -45)))) ? COMPONENT_MOVABLE_BLOCK_PRE_MOVE : NONE // if we couldn't swerve that way, we just carry on

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
	if(!jink_chance || !COOLDOWN_FINISHED(src, jink_cooldown) || !prob(jink_chance))
		return
	var/turf/shot_from = get_turf(projectile.starting)
	if(!shot_from || !isturf(source.loc) || source.stat != CONSCIOUS || source.incapacitated())
		return
	var/datum/ai_controller/controller = source.ai_controller
	if(controller && (source.loc == controller.blackboard[BB_BASIC_MOB_COVER_TURF] || source.loc == controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]))
		return // we'd only be jinking out of our cover
	COOLDOWN_START(src, jink_cooldown, 1 SECONDS)
	var/shot_dir = get_dir(shot_from, source)
	if(!shot_dir)
		return
	for(var/angle in shuffle(list(90, -90)) + shuffle(list(45, -45)))
		if(dodge_to(get_step(source, turn(shot_dir, angle))))
			break

// Returns TRUE if we dodge successfully (nothing blocked us)
/datum/component/ai_dodging/proc/dodge_to(turf/spot)
	var/mob/living/basic/basic_mob = parent
	if(!spot || (locate(/mob/living) in spot))
		return FALSE
	swerving = TRUE
	. = basic_mob.Move(spot, get_dir(basic_mob, spot))
	swerving = FALSE
