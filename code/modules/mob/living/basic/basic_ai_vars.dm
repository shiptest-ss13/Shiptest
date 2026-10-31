// Vars a mapper or admin can set on a basic mob to tune its AI, put onto its blackboard by apply_ai_vars(). Null leaves each to the mob's AI controller.
// A mob type that wants them calls setup_ai() once it's set up
/mob/living/basic
	/// Closer than this and the mob backs off, if they fight from range. Null leaves it to their AI, unless engage_distance is set, in which case they never back off
	var/retreat_distance
	/// Further than this and the mob closes in, if they fight from range. Null leaves it to their AI
	var/engage_distance
	/// How far gone someone can be and still be worth attacking, like HARD_CRIT for those who finish people off. See BB_TARGET_MINIMUM_STAT. Null leaves it to their AI
	var/stat_attack
	/// How far the mob sees targets from. Null leaves it to their AI
	var/vision_range
	/// How far from home the mob chases someone before letting them go, twice that while they're fighting. 0 for no leash. Null leaves it to their AI
	var/leash_distance
	/// How far the mob can be heard calling allies to a fight, if further than usual, like someone rallying a whole settlement.
	var/alert_range
	/// If TRUE, the mob makes a show of calling allies to a fight, with a "!" over its head and a chime
	var/summons_backup = FALSE
	/// Things the mob says now and then while there's nobody to fight
	var/list/speak
	/// Emotes the mob does now and then while there's nobody to fight, heard and seen, like "grumbles."
	var/list/emote_hear
	var/list/emote_see
	/// Chance each 2 seconds of a line, ours from speak or our callout set's, or one of emote_hear or emote_see, while there's nobody to fight
	var/speak_chance
	/// What our archetype had on the blackboard for the keys our vars have set, as list(key = value), so setting one of those vars back to null restores the original archetype value
	var/list/archetype_blackboard

/// Sets up what our AI needs from us, once our AI controller's made. Again whenever it's rebuilt, see rebuild_ai()
/mob/living/basic/proc/setup_ai()
	if(istype(ai_controller, /datum/ai_controller))
		apply_ai_vars()

// proc for putting our vars onto the blackboard, so we can use it both at spawn and when rebuilding AI
/mob/living/basic/proc/apply_ai_vars()
	set_ai_var_key(BB_TARGET_MINIMUM_STAT, stat_attack)
	set_ai_var_key(BB_BASIC_MOB_LEASH_DISTANCE, get_ai_leash_distance())
	set_ai_var_key(BB_BASIC_MOB_VISION_RANGE, vision_range || null)
	set_ai_var_key(BB_BASIC_MOB_ALERT_RANGE, alert_range || null)
	set_ai_var_key(BB_BASIC_MOB_SUMMONS_BACKUP, summons_backup || null)
	set_ai_var_key(BB_BASIC_MOB_IDLE_CHATTER_CHANCE, speak_chance || null)
	var/list/idle_emotes
	if(speak_chance && (length(emote_hear) || length(emote_see)))
		idle_emotes = string_list((emote_hear || list()) | (emote_see || list()))
	set_ai_var_key(BB_BASIC_MOB_IDLE_EMOTES, idle_emotes)
	set_ai_var_key(BB_BASIC_MOB_RETREAT_DISTANCE, get_ai_retreat_distance())
	set_ai_var_key(BB_BASIC_MOB_ENGAGE_DISTANCE, engage_distance)

/// Our leash for the blackboard, from leash_distance. Null leaves it to our AI
/mob/living/basic/proc/get_ai_leash_distance()
	return leash_distance

/// How close someone can get before we back off, for the blackboard, from retreat_distance. Null leaves it to our AI
/mob/living/basic/proc/get_ai_retreat_distance()
	if(isnull(retreat_distance) && !isnull(engage_distance))
		return 0
	return retreat_distance

// Sets a blackboard key from one of our vars. Null restores the original archetype value, if it had one.
/mob/living/basic/proc/set_ai_var_key(key, value)
	if(isnull(value))
		if(!(key in archetype_blackboard))
			return // never set it, so it's still our archetype's
		value = archetype_blackboard[key]
	else if(!(key in archetype_blackboard))
		LAZYSET(archetype_blackboard, key, ai_controller.blackboard[key])
	if(islist(ai_controller.blackboard[key]) || isnull(value))
		ai_controller.clear_blackboard_key(key)
	if(!isnull(value))
		ai_controller.set_blackboard_key(key, value)

// Throws our AI away and builds it again from our vars, for bits that only get read as it's set up. To new_controller_type if given, otherwise our type's own
/mob/living/basic/proc/rebuild_ai(new_controller_type)
	if(stat == DEAD)
		return
	var/turf/home
	if(istype(ai_controller, /datum/ai_controller))
		home = ai_controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	take_down_ai()
	if(istype(ai_controller, /datum/ai_controller))
		qdel(ai_controller)
	ai_controller = null
	archetype_blackboard = null
	ai_controller = new_controller_type || initial(ai_controller)
	InitializeAIController()
	setup_ai()
	if(!ai_controller)
		return
	if(home)
		ai_controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, home)

/// Takes away whatever setup_ai() gave us, before rebuild_ai() throws our AI controller away
/mob/living/basic/proc/take_down_ai()
	return

/// The vars apply_ai_vars() puts on the blackboard, so editing one actually affects a mob that already exists
/mob/living/basic/proc/get_live_ai_vars()
	var/static/list/live_ai_vars
	if(!live_ai_vars)
		live_ai_vars = list(
			NAMEOF(src, stat_attack),
			NAMEOF(src, leash_distance),
			NAMEOF(src, vision_range),
			NAMEOF(src, alert_range),
			NAMEOF(src, summons_backup),
			NAMEOF(src, speak_chance),
			NAMEOF(src, emote_hear),
			NAMEOF(src, emote_see),
			NAMEOF(src, retreat_distance),
			NAMEOF(src, engage_distance),
		)
	return live_ai_vars

/mob/living/basic/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, ai_controller))
		if(!ispath(var_value, /datum/ai_controller))
			return FALSE
		rebuild_ai(var_value)
		datum_flags |= DF_VAR_EDITED
		return TRUE
	if(var_name in get_live_ai_vars())
		. = ..()
		if(istype(ai_controller, /datum/ai_controller))
			apply_ai_vars()
		return
	return ..()
