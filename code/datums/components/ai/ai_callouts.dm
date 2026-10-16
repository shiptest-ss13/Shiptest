
/datum/ai_callout_set

	var/list/lines = list()
	// variants for morale versions
	var/list/morale_lines = list()
	// what tells the group something is said near enough always, the rest less often, as our pool of lines is small and they'd soon wear thin
	var/list/chances = list(
		AI_CALLOUT_SPOTTED = 100,
		AI_CALLOUT_HEARD_GUNFIRE = 100,
		AI_CALLOUT_BROKEN = 100,
		AI_CALLOUT_TARGET_KILLED = 75,
		AI_CALLOUT_FLANKING = 60,
		AI_CALLOUT_RALLIED = 60,
		AI_CALLOUT_SUPPRESSING = 50,
		AI_CALLOUT_WARY = 50,
		AI_CALLOUT_EMBOLDENED = 50,
		AI_CALLOUT_TARGET_DOWN = 35,
		AI_CALLOUT_HOLDING = 35,
		AI_CALLOUT_PUSHING = 35,
		AI_CALLOUT_FALLING_BACK = 35,
		AI_CALLOUT_DEATH_RATTLE = 35,
		AI_CALLOUT_HURT = 25,
		AI_CALLOUT_TAUNT = 10, // rolled every couple of seconds in a fight, so it's low
		AI_CALLOUT_MELEE = 10, // every blow, so it's low too
	)
	//chance to say something for events not in chances
	var/default_chance = 50
	// verb they use, like "exclaims" or "yells"
	var/say_verb

/datum/ai_callout_set/New()
	. = ..()
	if(!ispath(parent_type, /datum/ai_callout_set))
		return
	// anything we don't have a line for, we say like the set we're based on
	var/datum/ai_callout_set/parent = get_ai_callout_set(parent_type)
	for(var/event in parent.lines)
		if(!(event in lines))
			lines[event] = parent.lines[event]
	for(var/morale in parent.morale_lines)
		var/list/parent_mood_lines = parent.morale_lines[morale]
		var/list/mood_lines = morale_lines[morale]
		if(!mood_lines)
			morale_lines[morale] = parent_mood_lines.Copy()
			continue
		for(var/event in parent_mood_lines)
			if(!(event in mood_lines))
				mood_lines[event] = parent_mood_lines[event]

// gets shared instance if available, otherwise creates it
/proc/get_ai_callout_set(set_path)
	var/static/list/callout_sets = list()
	var/datum/ai_callout_set/callout_set = callout_sets[set_path]
	if(!callout_set)
		callout_set = new set_path
		callout_sets[set_path] = callout_set
	return callout_set

/proc/get_species_voice(species_path)
	var/static/list/voices_by_species = list()
	var/voice_key = species_path || "none"
	if(voices_by_species[voice_key])
		return voices_by_species[voice_key]
	var/tongue_path = /obj/item/organ/tongue
	if(ispath(species_path, /datum/species))
		var/datum/species/species = new species_path
		tongue_path = species.species_organs?[ORGAN_SLOT_TONGUE] || tongue_path
		qdel(species)
	var/obj/item/organ/tongue/voice = new tongue_path
	voices_by_species[voice_key] = voice
	return voice

/proc/ai_callout(atom/speaker, event, last_words = FALSE, interrupt = FALSE)
	var/datum/component/ai_callouts/callouts = speaker?.GetComponent(/datum/component/ai_callouts)
	return callouts?.speak_about(event, last_words, interrupt)

/datum/component/ai_callouts
	var/callout_set
	//the tongue we talk with, for its accent and speech verbs
	var/obj/item/organ/tongue/voice
	var/hearing_range = 7
	//each wall reduces the range by this many tiles
	var/wall_penalty = AI_HEARING_WALL_PENALTY
	var/list/line_cooldowns
	//the last someone going down we called out so we don't call out the same thing twice
	var/last_downed_callout
	//whoever we last called out going down, watched so we call it out when they die
	var/mob/living/downed_victim
	//stop yapping so much
	COOLDOWN_DECLARE(speech_cooldown)
	var/list/spotted_lines
	var/spotted_chance = 100

/datum/component/ai_callouts/Initialize(callout_set, species_path, list/spotted_lines, spotted_chance = 100)
	. = ..()
	if(!isbasicmob(parent) || !ispath(callout_set, /datum/ai_callout_set))
		return COMPONENT_INCOMPATIBLE
	src.callout_set = callout_set
	voice = get_species_voice(species_path)
	src.spotted_lines = spotted_lines
	src.spotted_chance = spotted_chance

/datum/component/ai_callouts/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_shot))
	RegisterSignal(parent, COMSIG_LIVING_NEAR_MISS, PROC_REF(on_shot))
	RegisterSignal(parent, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_hurt))
	RegisterSignal(parent, COMSIG_PROJECTILE_ON_HIT, PROC_REF(on_our_projectile_hit))
	RegisterSignal(parent, COMSIG_HOSTILE_POST_ATTACKINGTARGET, PROC_REF(on_our_melee_hit))
	RegisterSignal(parent, COMSIG_BASICMOB_PRE_DEATH, PROC_REF(on_pre_death))
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/component/ai_callouts/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_BULLET_ACT, COMSIG_LIVING_NEAR_MISS, COMSIG_MOB_APPLY_DAMAGE, COMSIG_PROJECTILE_ON_HIT, COMSIG_HOSTILE_POST_ATTACKINGTARGET, COMSIG_BASICMOB_PRE_DEATH, COMSIG_LIVING_DEATH))
	watch_downed_victim(null)

/datum/component/ai_callouts/proc/sees_target()
	var/mob/living/basic/basic_mob = parent
	var/datum/ai_controller/controller = basic_mob.ai_controller
	if(!controller)
		return FALSE
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target))
		return FALSE
	return controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE

// whether we know who we're up against, can see them or recently enough to have in memory
/datum/component/ai_callouts/proc/in_fight()
	if(sees_target())
		return TRUE
	var/mob/living/basic/basic_mob = parent
	return basic_mob.ai_controller && AI_RECENTLY_SAW_ENEMY(basic_mob.ai_controller, AI_FIGHT_MEMORY)

/datum/component/ai_callouts/proc/on_shot(datum/source, obj/projectile/projectile)
	SIGNAL_HANDLER
	if(in_fight()) // getting hurt by someone we know about is on_hurt()'s
		return
	var/atom/shooter = projectile.firer
	if(isliving(shooter) && ai_is_ally(parent, shooter))
		return // ignore friendly fire
	if(isatom(shooter) && ai_can_see(parent, shooter, hearing_range))
		return // or someone else we can see plain as day
	speak_about(AI_CALLOUT_TAKING_FIRE)

/datum/component/ai_callouts/proc/on_hurt(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	if(damage > 0 && in_fight())
		speak_about(AI_CALLOUT_HURT)

/datum/component/ai_callouts/proc/on_our_projectile_hit(datum/source, atom/movable/firer, atom/hit_target, angle)
	SIGNAL_HANDLER
	// projectiles tell us they've hit before the damage lands, so see how they're doing a moment later
	if(isliving(hit_target) && !ai_is_ally(parent, hit_target) && ai_is_person(hit_target))
		addtimer(CALLBACK(src, PROC_REF(call_out_downed), WEAKREF(hit_target), REF(hit_target)), 1)

/datum/component/ai_callouts/proc/on_our_melee_hit(datum/source, atom/hit_target, result)
	SIGNAL_HANDLER
	if(!isliving(hit_target) || ai_is_ally(parent, hit_target) || !ai_is_person(hit_target))
		return
	var/mob/living/victim = hit_target
	if(victim.stat == CONSCIOUS)
		speak_about(AI_CALLOUT_MELEE) // still up, so something to go with the blow
		return
	call_out_downed(WEAKREF(hit_target), REF(hit_target))

/datum/component/ai_callouts/proc/call_out_downed(datum/weakref/victim_ref, victim_id)
	var/mob/living/victim = victim_ref?.resolve()
	var/victim_stat = QDELETED(victim) ? DEAD : victim.stat
	if(victim_stat == CONSCIOUS)
		return
	var/callout = "[victim_id] [victim_stat == DEAD ? "dead" : "down"]" // crit, unconscious and the rest are all just down, so we don't call it out at each
	if(callout == last_downed_callout)
		return
	last_downed_callout = callout
	if(victim_stat == DEAD)
		watch_downed_victim(null)
		speak_about(AI_CALLOUT_TARGET_KILLED, interrupt = TRUE) // often just after we called them down, so don't let that silence it
	else
		watch_downed_victim(victim)
		speak_about(AI_CALLOUT_TARGET_DOWN)

/datum/component/ai_callouts/proc/watch_downed_victim(mob/living/victim)
	if(downed_victim)
		UnregisterSignal(downed_victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	downed_victim = victim
	if(downed_victim)
		RegisterSignal(downed_victim, COMSIG_LIVING_DEATH, PROC_REF(on_downed_victim_died))
		RegisterSignal(downed_victim, COMSIG_QDELETING, PROC_REF(on_downed_victim_deleted))

/datum/component/ai_callouts/proc/on_downed_victim_died(mob/living/victim)
	SIGNAL_HANDLER
	var/datum/weakref/victim_ref = WEAKREF(victim)
	var/victim_id = REF(victim)
	watch_downed_victim(null)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || !ai_can_see(basic_mob, victim, hearing_range))
		return
	INVOKE_ASYNC(src, PROC_REF(call_out_downed), victim_ref, victim_id)

/datum/component/ai_callouts/proc/on_downed_victim_deleted(datum/source)
	SIGNAL_HANDLER
	watch_downed_victim(null)

/datum/component/ai_callouts/proc/on_pre_death(datum/source, gibbed)
	SIGNAL_HANDLER
	if(!gibbed)
		speak_about(AI_CALLOUT_DEATH_RATTLE, last_words = TRUE) // before we're dead, or it'd go to deadchat

/datum/component/ai_callouts/proc/on_death(datum/source)
	SIGNAL_HANDLER
	for(var/datum/component/ai_callouts/ally as anything in get_allies_in_earshot())
		ally.speak_about(AI_CALLOUT_ALLY_DOWN)

// allies_in_earshot is get_ai_allies_in_earshot() if we've already got it to hand
/datum/component/ai_callouts/proc/get_allies_in_earshot(list/allies_in_earshot)
	. = list()
	if(isnull(allies_in_earshot))
		allies_in_earshot = get_ai_allies_in_earshot(parent, hearing_range, wall_penalty)
	for(var/mob/living/ally as anything in allies_in_earshot)
		var/datum/component/ai_callouts/ally_callouts = ally.GetComponent(/datum/component/ai_callouts)
		if(ally_callouts)
			. += ally_callouts

// runechat over body
/datum/component/ai_callouts/proc/show_last_words_over_corpse(line, list/spans)
	var/mob/living/basic/human/human_mob = parent
	if(!istype(human_mob))
		return
	var/mob/living/carbon/human/corpse = human_mob.corpse_ref?.resolve()
	if(!corpse)
		return
	// as far as a whisper carries
	var/starred_line = stars(line)
	for(var/mob/listener in get_hearers_in_view(1 + EAVESDROP_EXTRA_RANGE, corpse))
		if(listener.client?.prefs.chat_on_map && listener.can_hear())
			var/heard_line = (get_dist(corpse, listener) > 1 && listener.stat != DEAD) ? starred_line : line
			listener.create_chat_message(corpse, /datum/language/galactic_common, heard_line, spans + list("italics"))

/datum/component/ai_callouts/proc/speak_about(event, last_words = FALSE, interrupt = FALSE)
	// how long a callout goes on cooldown for a group
	var/static/list/group_line_cooldowns = list(
		AI_CALLOUT_SPOTTED = 15 SECONDS,
		AI_CALLOUT_TARGET_DOWN = 20 SECONDS,
		AI_CALLOUT_TARGET_KILLED = 20 SECONDS,
		AI_CALLOUT_ALLY_DOWN = 10 SECONDS,
		AI_CALLOUT_LOST_THEM = 20 SECONDS,
		AI_CALLOUT_HOLDING = 30 SECONDS,
		AI_CALLOUT_SUPPRESSING = 20 SECONDS,
		AI_CALLOUT_RELOADING = 6 SECONDS,
		AI_CALLOUT_HEARD_GUNFIRE = 15 SECONDS,
		AI_CALLOUT_FLANKING = 25 SECONDS,
		AI_CALLOUT_BAD_AIR = 15 SECONDS,
		AI_CALLOUT_TOO_HOT = 15 SECONDS,
		AI_CALLOUT_TOO_COLD = 15 SECONDS,
		AI_CALLOUT_WARY = 30 SECONDS,
		AI_CALLOUT_EMBOLDENED = 30 SECONDS,
		AI_CALLOUT_BROKEN = 6 SECONDS, // a few voices when a group breaks, not every one of them
		AI_CALLOUT_RALLIED = 30 SECONDS,
		AI_CALLOUT_PUSHING = 25 SECONDS,
		AI_CALLOUT_FALLING_BACK = 25 SECONDS,
		AI_CALLOUT_TAUNT = 25 SECONDS,
		AI_CALLOUT_MELEE = 8 SECONDS,
	)
	// what we'd only say about people
	var/static/list/about_people = list(
		AI_CALLOUT_SPOTTED = TRUE,
		AI_CALLOUT_LOST_THEM = TRUE,
		AI_CALLOUT_TAUNT = TRUE,
		AI_CALLOUT_MELEE = TRUE,
		AI_CALLOUT_FLANKING = TRUE,
		AI_CALLOUT_PUSHING = TRUE,
		AI_CALLOUT_SUPPRESSING = TRUE,
		AI_CALLOUT_TARGET_DOWN = TRUE,
		AI_CALLOUT_TARGET_KILLED = TRUE,
	)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || basic_mob.client)
		return FALSE
	if(about_people[event])
		var/atom/target = basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(target && !ai_is_person(target))
			return FALSE
	var/datum/ai_callout_set/callouts = get_ai_callout_set(callout_set)
	var/lines
	var/datum/ai_controller/controller = basic_mob.ai_controller
	var/morale = controller?.blackboard[BB_BASIC_MOB_MORALE]
	if(morale && AI_MORALE_IS(controller, morale))
		var/list/mood_lines = callouts.morale_lines[morale]
		lines = mood_lines?[event] // how we'd say it in this mood, if we've a line for that
	lines ||= callouts.lines[event]
	var/chance = callouts.chances[event]
	var/own_lines = event == AI_CALLOUT_SPOTTED && length(spotted_lines)
	if(own_lines)
		lines = spotted_lines
		chance = spotted_chance
	if(!lines || (!last_words && !interrupt && !COOLDOWN_FINISHED(src, speech_cooldown)))
		return FALSE
	if(!own_lines && world.time < LAZYACCESS(line_cooldowns, event))
		return FALSE // someone in earshot's just said it
	if(!prob(isnull(chance) ? callouts.default_chance : chance))
		return FALSE
	var/line = islist(lines) ? pick_weight_recursive(lines) : lines
	if(!line)
		return FALSE
	COOLDOWN_START(src, speech_cooldown, 5 SECONDS)
	var/list/speech_args = list(line, null, list(), null, /datum/language/galactic_common)
	if(voice.modifies_speech)
		voice.handle_speech(basic_mob, speech_args)
	line = speech_args[SPEECH_MESSAGE]
	var/list/spans = speech_args[SPEECH_SPANS]
	var/verb = callouts.say_verb
	if(!verb)
		if(last_words)
			verb = voice.whisper_mod
		else
			switch(copytext_char(line, -1))
				if("!")
					verb = voice.exclaim_mod
				if("?")
					verb = voice.ask_mod
				else
					verb = voice.say_mod
	var/message = "[verb]*[line]"
	if(last_words)
		INVOKE_ASYNC(basic_mob, TYPE_PROC_REF(/mob, whisper), message, null, spans)
		show_last_words_over_corpse(line, spans)
	else
		INVOKE_ASYNC(basic_mob, TYPE_PROC_REF(/atom/movable, say), message, null, spans)
	var/list/allies_in_earshot
	if(event == AI_CALLOUT_TARGET_DOWN || event == AI_CALLOUT_TARGET_KILLED)
		allies_in_earshot = get_ai_allies_in_earshot(basic_mob, hearing_range, wall_penalty)
		for(var/mob/living/ally as anything in allies_in_earshot)
			ai_try_embolden(ally)
	var/group_cooldown = group_line_cooldowns[event]
	if(group_cooldown)
		LAZYSET(line_cooldowns, event, world.time + group_cooldown) // so we don't repeat ourselves either
		for(var/datum/component/ai_callouts/ally as anything in get_allies_in_earshot(allies_in_earshot))
			LAZYSET(ally.line_cooldowns, event, world.time + group_cooldown)
	return TRUE

/// whether thing is someone worth calling out like a person: humans and human NPCs, anyone a player's controlling, and mechs, as there's someone inside
/proc/ai_is_person(atom/thing)
	if(ismecha(thing))
		return TRUE
	var/mob/living/someone = thing
	if(!istype(someone))
		return FALSE
	return ishuman(someone) || istype(someone, /mob/living/basic/human) || someone.client
