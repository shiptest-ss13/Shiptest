#define SHOULD_DISABLE_FOOTSTEPS(source) ((SSlag_switch.measures[DISABLE_FOOTSTEPS] && !(HAS_TRAIT(source, TRAIT_BYPASS_MEASURES))) || HAS_TRAIT(source, TRAIT_SILENT_FOOTSTEPS))

///Footstep component. Plays footsteps at parents location when it is appropriate.
/datum/component/footstep
	///How many steps the parent has taken since the last time a footstep was played.
	var/steps = 0
	///volume determines the extra volume of the footstep. This is multiplied by the base volume, should there be one.
	var/volume
	///e_range stands for extra range - aka how far the sound can be heard. This is added to the base value and ignored if there isn't a base value.
	var/e_range
	///footstep_type is a define which determines what kind of sounds should get chosen.
	var/footstep_type
	///This can be a list OR a soundfile OR null. Determines whatever sound gets played.
	var/footstep_sounds

/datum/component/footstep/Initialize(footstep_type_ = FOOTSTEP_MOB_BAREFOOT, volume_ = 0.5, e_range_ = -8)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	volume = volume_
	e_range = e_range_
	footstep_type = footstep_type_
	switch(footstep_type)
		if(FOOTSTEP_MOB_HUMAN)
			if(!ishuman(parent))
				return COMPONENT_INCOMPATIBLE
			RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(play_humanstep))
			return
		if(FOOTSTEP_MOB_SLIME)
			footstep_sounds = 'sound/effects/footstep/slime1.ogg'
		else
			footstep_sounds = GLOB.footstep[footstep_type]
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(play_simplestep)) //Note that this doesn't get called for humans.

///Prepares a footstep. Determines if it should get played. Returns the turf it should get played on. Note that it is always a /turf/open
/datum/component/footstep/proc/prepare_step()
	var/turf/open/T = get_turf(parent)
	if(!istype(T))
		return

	var/mob/living/LM = parent

	if(!T.footstep || LM.buckled || LM.throwing || LM.movement_type & (VENTCRAWLING | FLYING) || HAS_TRAIT(LM, TRAIT_IMMOBILIZED))
		return

	if(LM.body_position == LYING_DOWN) //play crawling sound if we're lying
		playsound(T, 'sound/effects/footstep/crawl1.ogg', 15 * volume, falloff_distance = 1)
		return

	if(iscarbon(LM) && LM.m_intent == MOVE_INTENT_WALK)
		return// stealth

	steps++

	if(steps >= 12) //12 chosen to keep a consistent left/right step pattern in nograv where a footstep plays every 6 steps. 0, 4, and 8 are left; 2, 6, and 10 are right.
		steps = 0

	if(steps % 2)
		//only make sound on even (and zero) steps to avoid spam
		return

	if((steps % 6) != 0 && !LM.has_gravity(T)) //don't need to step as often when you hop around, modulo 6 to retain previous behavior of playing sound every 6 steps in no grav
		return
	return T

/datum/component/footstep/proc/play_simplestep(mob/living/source, atom/oldloc, direction)
	SIGNAL_HANDLER

	if (SHOULD_DISABLE_FOOTSTEPS(parent))
		return

	var/turf/open/T = prepare_step()
	if(!T)
		return
	play_fov_effect(source, 5, "footstep", direction, ignore_self = TRUE)
	if(isfile(footstep_sounds) || istext(footstep_sounds))
		playsound(T, footstep_sounds, volume, falloff_distance = 1)
		return
	playsound(T, pick(footstep_sounds[T.footstep][1]), footstep_sounds[T.footstep][2] * volume, TRUE, footstep_sounds[T.footstep][3] + e_range, falloff_distance = 1)

/datum/component/footstep/proc/play_humanstep(mob/living/carbon/human/source, atom/oldloc, direction)
	SIGNAL_HANDLER

	if (SHOULD_DISABLE_FOOTSTEPS(parent))
		return

	var/turf/open/T = prepare_step()
	if(!T)
		return
	var/mob/living/carbon/human/H = parent
	var/feetCover = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) || (H.w_uniform && (H.w_uniform.body_parts_covered & FEET))

	play_fov_effect(H, 5, "footstep", direction, ignore_self = TRUE)

	var/obj/item/bodypart/leg/leg = null //which leg is making the step sound

	if(steps % 4 == 0) //steps 0, 4, and 8
		leg = H.get_bodypart(BODY_ZONE_L_LEG)
	else if((steps + 2) % 4 == 0) //steps 2, 6, and 10
		leg = H.get_bodypart(BODY_ZONE_R_LEG)

	if(leg == null) //no leg?
		return

	var/human_footstep_sound

	if(H.shoes || feetCover) //are we wearing shoes
		human_footstep_sound = GLOB.footstep[FOOTSTEP_MOB_SHOE][T.footstep]
	else //barefoot
		human_footstep_sound = GLOB.footstep[leg.footstep_type][T.footstep]

	playsound(T, pick(human_footstep_sound[1]),
		human_footstep_sound[2] * volume,
		TRUE,
		human_footstep_sound[3] + e_range, falloff_distance = 1)

#undef SHOULD_DISABLE_FOOTSTEPS
