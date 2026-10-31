/datum/ai_callout_set
	var/list/lines = list()
	// variants for morale versions
	var/list/morale_lines = list()
	// variants for when they're alone. prioritised over morale_lines too
	var/list/solo_lines = list()
	// what tells the group something is said near enough always, the rest less often, as our pool of lines is small and they'd soon wear thin
	var/list/chances = list(
		AI_CALLOUT_SPOTTED = 100,
		AI_CALLOUT_HEARD_GUNFIRE = 100,
		AI_CALLOUT_BROKEN = 100,
		AI_CALLOUT_GRENADE = 100,
		AI_CALLOUT_THROW_BACK = 100,
		AI_CALLOUT_GRENADE_OUT = 100, // the warning that it's coming, fair to whoever it's thrown at
		AI_CALLOUT_TARGETS_STUNNED = 100,
		AI_CALLOUT_ENEMY_RELOADING = 100, // the tell that a push is coming, fair to whoever's reloading
		AI_CALLOUT_CHARGE = 100, // the warning that several are about to come at once
		AI_CALLOUT_ORDER_PUSH = 100, // the order, and the warning that a push is coming
		AI_CALLOUT_ORDER_HOLD = 100, // orders are only orders if they're heard
		AI_CALLOUT_PROTECT_COMMANDER = 100, // the warning that going for the one in charge has drawn everyone
		AI_CALLOUT_COMMANDER_DOWN = 100, // news the whole side wants to hear, or doesn't
		AI_CALLOUT_ORDER_RETREAT = 100,
		AI_CALLOUT_SUSPICIOUS = 100, // the warning to whoever's in the box that they've been noticed
		AI_CALLOUT_FOUND_HIDING = 100,
		AI_CALLOUT_LOST_INTEREST = 75,
		AI_CALLOUT_IDLE = 100, // idle chatter rolls its own chance before it asks
		AI_CALLOUT_LAST_STANDING = 100,
		AI_CALLOUT_ALL_CLEAR = 100,
		AI_CALLOUT_GETTING_UP = 100,
		AI_CALLOUT_RAISING_ALARM = 75,
		AI_CALLOUT_BREACHING = 75,
		AI_CALLOUT_GOT_AWAY = 75,
		AI_CALLOUT_CHECK_IN = 100, // whoever got hurt rolls get_checked_on()'s chance before anyone asks
		AI_CALLOUT_STATUS_OK = 100, // a question left hanging sounds wrong
		AI_CALLOUT_STATUS_BAD = 100,
		AI_CALLOUT_LAST_SEEN = 100, // it's news to the one asking
		AI_CALLOUT_COVERING = 100, // only ever said as an answer, so a question isn't left hanging
		AI_CALLOUT_CANT_REACH = 60,
		AI_CALLOUT_NO_SIGN = 100,
		AI_CALLOUT_NO_COVER = 50,
		AI_CALLOUT_FLASHED = 80,
		AI_CALLOUT_KNOCKED_DOWN = 60,
		AI_CALLOUT_GASSED = 60,
		AI_CALLOUT_STAGGERED = 50,
		AI_CALLOUT_TARGET_KILLED = 75,
		AI_CALLOUT_FLANKING = 60,
		AI_CALLOUT_RALLIED = 60,
		AI_CALLOUT_SUPPRESSING = 50,
		AI_CALLOUT_WARY = 50,
		AI_CALLOUT_EMBOLDENED = 50,
		AI_CALLOUT_TARGET_DOWN = 35,
		AI_CALLOUT_HEADSHOT = 80, // only for hits that do enough to the head, see AI_HEADSHOT_CALLOUT_DAMAGE
		AI_CALLOUT_HEADSHOT_DOWN = 80, // the usual down or kill line if these don't come up
		AI_CALLOUT_HEADSHOT_KILLED = 80,
		AI_CALLOUT_TARGET_DROPPED = 50,
		AI_CALLOUT_TARGET_DIED = 50,
		AI_CALLOUT_EXECUTING = 100, // the warning that someone downed is about to be finished off, fair to whoever might save them
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
	var/list/own_lines = lines.Copy()
	for(var/event in parent.lines)
		if(!(event in lines))
			lines[event] = parent.lines[event]
	for(var/event in parent.solo_lines)
		if(!(event in solo_lines) && !(event in own_lines))
			solo_lines[event] = parent.solo_lines[event]
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

// small talk callouts that we can delay if needed
/proc/ai_callout_is_chatter(event)
	var/static/list/chatter = list(
		AI_CALLOUT_TAUNT = TRUE,
		AI_CALLOUT_MELEE = TRUE,
		AI_CALLOUT_HURT = TRUE,
		AI_CALLOUT_IDLE = TRUE,
		AI_CALLOUT_CHECK_IN = TRUE,
		AI_CALLOUT_WARY = TRUE,
		AI_CALLOUT_EMBOLDENED = TRUE,
	)
	return chatter[event]

// use a sound file in a callout, as list(marker = list(sound, volume, extra range, alarm range)).
GLOBAL_LIST_INIT(ai_callout_sounds, list(
	"%WHISTLE" = list('sound/misc/trenchwhistle.ogg', 80, 4, 15),
))

/proc/ai_callout(atom/speaker, event, last_words = FALSE, interrupt = FALSE, atom/subject)
	var/datum/component/ai_callouts/callouts = speaker?.GetComponent(/datum/component/ai_callouts)
	return callouts?.speak_about(event, last_words, interrupt, subject = subject)

/proc/ai_callout_adjective(atom/subject)
	var/mob/living/carbon/human/person = subject
	if(!istype(person) || QDELETED(person) || !person.generic_adjective)
		return null
	var/hides_face = (person.wear_mask && (person.wear_mask.flags_inv & HIDEFACE)) || (person.head && (person.head.flags_inv & HIDEFACE))
	if(hides_face && (person.check_obscured_slots() & ITEM_SLOT_ICLOTHING))
		return null
	return lowertext(person.generic_adjective)

/proc/ai_callout_species(atom/subject)
	var/mob/living/carbon/human/person = subject
	if(!istype(person) || QDELETED(person) || !person.dna?.species)
		return null
	return lowertext(format_text(person.dna.species.name))

/proc/ai_callout_descriptors(atom/subject)
	return list(
		"%ADJ" = ai_callout_adjective(subject),
		"%SPECIES" = ai_callout_species(subject),
	)

/proc/ai_callout_missing_descriptor(line, list/descriptors)
	if(!istext(line) || !findtext(line, "%"))
		return FALSE
	for(var/marker in descriptors)
		if(!descriptors[marker] && findtext(line, marker))
			return TRUE
	return FALSE

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
	//TRUE if downed_victim was put down by an ally who's since died, so we only watch for them getting up, and don't call their death our kill
	var/downed_victim_inherited = FALSE
	//stop yapping so much
	COOLDOWN_DECLARE(speech_cooldown)
	//for chatter, so we can be sure it never stops us calling out what we're doing
	COOLDOWN_DECLARE(chatter_cooldown)
	//when we last said something urgent over everything else, as one thing can set off several at once, but we only want to say one
	var/last_interrupt_time = 0
	var/list/spotted_lines
	var/spotted_chance = 100
	//lines of our own to chat with, for a one-off character set up on a map, in place of our callout set's
	var/list/idle_lines
	//chance each time we're hurt that an ally in earshot asks how we're doing, instead of doing pain lines
	var/check_in_chance = 40
	//when we're due to answer an ally asking how we're doing, so we don't say pain lines in the meantime
	var/check_in_answer_due = 0
	//when the current turn of talk ends, and how many chatter lines have been said in it. any line heard or said starts a turn if none is going
	var/turn_ends_at = 0
	var/turn_chatter = 0
	var/alone = FALSE
	var/alone_checked_until = 0
	//who our shots last hit in the head, how much damage those hits added up to, and until when more hits add to it, see AI_HEADSHOT_CALLOUT_DAMAGE
	var/datum/weakref/head_hits_on
	var/head_hit_damage = 0
	var/head_hits_until = 0
	//who our last headshot was on, and when, so whatever calls out them going down or dying a moment later knows it was one
	var/datum/weakref/headshot_on
	var/headshot_at = 0

/datum/component/ai_callouts/Initialize(callout_set, species_path, list/spotted_lines, spotted_chance = 100, list/idle_lines)
	. = ..()
	if(!isbasicmob(parent) || !ispath(callout_set, /datum/ai_callout_set))
		return COMPONENT_INCOMPATIBLE
	src.callout_set = callout_set
	voice = get_species_voice(species_path)
	src.spotted_lines = spotted_lines
	src.spotted_chance = spotted_chance
	src.idle_lines = idle_lines

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
	if(!ai_is_shooter(shooter))
		return // like grenade shrapnel, which has its own callout
	if(isliving(shooter) && ai_is_ally(parent, shooter))
		return // ignore friendly fire
	if(isatom(shooter) && ai_can_see(parent, shooter, hearing_range))
		return // or someone else we can see plain as day
	speak_about(AI_CALLOUT_TAKING_FIRE)

/datum/component/ai_callouts/proc/on_hurt(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	if(damage <= 0 || world.time < check_in_answer_due || !in_fight())
		return // or we've been asked how we're doing, and our answer says it
	// a moment later, so we don't say the line as we die
	addtimer(CALLBACK(src, PROC_REF(react_to_hurt)), 1, TIMER_UNIQUE)

/datum/component/ai_callouts/proc/react_to_hurt()
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || world.time < check_in_answer_due)
		return // dead or down from it, which has lines of its own
	if(!get_checked_on())
		speak_about(AI_CALLOUT_HURT)

// an ally in earshot asks how we're doing, and we answer a moment later. TRUE if they asked
/datum/component/ai_callouts/proc/get_checked_on()
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || world.time < LAZYACCESS(line_cooldowns, AI_CALLOUT_CHECK_IN) || !prob(check_in_chance))
		return FALSE // cheap checks first, as this is every hit
	if(!COOLDOWN_FINISHED(src, chatter_cooldown))
		return FALSE // we've only just said something, like that we're hit, so asking would be daft
	if(basic_mob.ai_controller && AI_MORALE_IS(basic_mob.ai_controller, AI_MORALE_BROKEN))
		return FALSE // too busy running to chat, and our hurt lines say as much
	var/list/allies = get_allies_in_earshot()
	if(!length(allies))
		return FALSE
	var/datum/component/ai_callouts/asker = pick(allies)
	if(!asker.speak_about(AI_CALLOUT_CHECK_IN))
		return FALSE
	var/answer_delay = AI_CALLOUT_ANSWER_DELAY
	check_in_answer_due = world.time + answer_delay
	addtimer(CALLBACK(src, PROC_REF(answer_check_in)), answer_delay)
	return TRUE

/datum/component/ai_callouts/proc/answer_check_in()
	var/mob/living/basic/basic_mob = parent
	speak_about(basic_mob.health > basic_mob.maxHealth * 0.5 ? AI_CALLOUT_STATUS_OK : AI_CALLOUT_STATUS_BAD, answering = TRUE)

/datum/component/ai_callouts/proc/on_our_projectile_hit(datum/source, atom/movable/firer, atom/hit_target, angle, hit_zone, blocked)
	SIGNAL_HANDLER
	// projectiles tell us they've hit before the damage lands, so see how they're doing a moment later
	if(isliving(hit_target) && !ai_is_ally(parent, hit_target) && ai_is_person(hit_target))
		if(check_zone(hit_zone) == BODY_ZONE_HEAD && blocked < 100 && add_head_hit(hit_target)) // not if a shield took it
			headshot_on = WEAKREF(hit_target)
			headshot_at = world.time
		addtimer(CALLBACK(src, PROC_REF(call_out_downed), WEAKREF(hit_target), REF(hit_target)), 1)

// adds one of our shots to the damage our hits have done to victim's head lately, TRUE once that's enough to call out a headshot
/datum/component/ai_callouts/proc/add_head_hit(mob/living/victim)
	if(world.time > head_hits_until || head_hits_on?.resolve() != victim)
		head_hits_on = WEAKREF(victim)
		head_hit_damage = 0
		head_hits_until = world.time + AI_HEADSHOT_CALLOUT_WINDOW
	var/datum/component/ranged_attacks/ranged_attack = parent.GetComponent(/datum/component/ranged_attacks)
	var/obj/projectile/fired_type = ranged_attack?.get_projectile_type()
	head_hit_damage += fired_type ? initial(fired_type.damage) : 0 // before armour, so a helmet doesn't keep us quiet. we've no gun to multiply it
	// those who aim for the head probably want to call it out
	if(head_hit_damage < AI_HEADSHOT_CALLOUT_DAMAGE && !ranged_attack?.settles_on_head())
		return FALSE
	head_hit_damage = 0 // once per enough, not on every hit after
	return TRUE

/datum/component/ai_callouts/proc/on_our_melee_hit(datum/source, atom/hit_target, result)
	SIGNAL_HANDLER
	if(!isliving(hit_target) || ai_is_ally(parent, hit_target) || !ai_is_person(hit_target))
		return
	var/mob/living/victim = hit_target
	if(victim.stat == CONSCIOUS)
		speak_about(AI_CALLOUT_MELEE, subject = victim) // still up, so something to go with the blow
		return
	call_out_downed(WEAKREF(hit_target), REF(hit_target))

/datum/component/ai_callouts/proc/call_out_downed(datum/weakref/victim_ref, victim_id)
	var/mob/living/victim = victim_ref?.resolve()
	var/victim_stat = QDELETED(victim) ? DEAD : victim.stat
	// our hit just now was a headshot, whether we're here from it a moment later or from watching them die from it, which comes first
	var/headshot = headshot_on && headshot_on.resolve() == victim && world.time - headshot_at <= 1
	if(victim_stat == CONSCIOUS)
		if(!headshot)
			return
		// still up, or it'd be the down or kill line instead. Floored by it, like by stamina crit, sounds down too, though they'll be up again soon, so we don't watch them like the downed
		if(HAS_TRAIT(victim, TRAIT_FLOORED))
			addtimer(CALLBACK(src, PROC_REF(confirm_floored_headshot), victim_ref), rand(AI_CALLOUT_CONFIRM_DELAY_MIN, AI_CALLOUT_CONFIRM_DELAY_MAX))
		else
			speak_about(AI_CALLOUT_HEADSHOT, subject = victim)
		return
	var/callout = "[victim_id] [victim_stat == DEAD ? "dead" : "down"]" // crit, unconscious and the rest are all just down, so we don't call it out at each
	if(callout == last_downed_callout)
		return
	last_downed_callout = callout
	ai_mark_called_down(callout) // ours to say, so those of us who only saw it leave it be
	// a moment to be sure before we say so, rather than the instant they drop
	addtimer(CALLBACK(src, PROC_REF(confirm_downed), victim_ref, victim_stat == DEAD, headshot), rand(AI_CALLOUT_CONFIRM_DELAY_MIN, AI_CALLOUT_CONFIRM_DELAY_MAX))
	if(victim_stat == DEAD)
		watch_downed_victim(null)
		queue_fight_over_check(AI_CALLOUT_ALL_CLEAR) // and if they were the last of them, we say so
	else
		watch_downed_victim(victim)
		queue_fight_over_check(AI_CALLOUT_ALL_CLEAR, victim_ref) // those of us who leave the downed be are done with them too, unless they get back up

// says we downed or killed them, a moment after, if that's still how it is
/datum/component/ai_callouts/proc/confirm_downed(datum/weakref/victim_ref, killed, headshot)
	var/mob/living/victim = victim_ref?.resolve()
	if(killed)
		if(!QDELETED(victim) && victim.stat != DEAD)
			return // somehow not, after all
		if(!headshot || !speak_about(AI_CALLOUT_HEADSHOT_KILLED, interrupt = TRUE, subject = victim)) // the headshot version if we can, the usual otherwise
			speak_about(AI_CALLOUT_TARGET_KILLED, interrupt = TRUE, subject = victim) // often just after we called them down, so don't let that silence it
		return
	if(QDELETED(victim) || victim.stat == CONSCIOUS || victim.stat == DEAD)
		return // back up already, or dead, which gets its own line
	if(!headshot || !speak_about(AI_CALLOUT_HEADSHOT_DOWN, interrupt = TRUE, subject = victim)) // often just after we called the headshot, so don't let that silence it
		speak_about(AI_CALLOUT_TARGET_DOWN, subject = victim)

/datum/component/ai_callouts/proc/confirm_floored_headshot(datum/weakref/victim_ref)
	var/mob/living/victim = victim_ref?.resolve()
	if(!QDELETED(victim) && victim.stat == CONSCIOUS && HAS_TRAIT(victim, TRAIT_FLOORED))
		speak_about(AI_CALLOUT_HEADSHOT_DOWN, interrupt = TRUE, subject = victim)

// who's been called down or dead lately, by anyone, as list("[REF] down" or "[REF] dead" = world.time), so those who only saw it happen leave it to whoever did it
GLOBAL_LIST_EMPTY(ai_called_down)

/proc/ai_mark_called_down(callout)
	if(length(GLOB.ai_called_down) > 200) // forget the old ones, so this doesn't grow forever
		for(var/old_callout in GLOB.ai_called_down)
			if(world.time - GLOB.ai_called_down[old_callout] > 1 MINUTES)
				GLOB.ai_called_down -= old_callout
	GLOB.ai_called_down[callout] = world.time

// witness saw victim, someone it was fighting, go down or die
/proc/ai_witness_downed(atom/witness, mob/living/victim)
	var/datum/component/ai_callouts/callouts = witness?.GetComponent(/datum/component/ai_callouts)
	callouts?.witness_downed(victim)

// someone we're fighting went down or died where we could see. Whoever of ours put them there calls that out, so we wait a moment, and if nobody did, like when they bled out, one of us who saw it says so
/datum/component/ai_callouts/proc/witness_downed(mob/living/victim)
	if(!ai_is_person(victim) || ai_is_ally(parent, victim))
		return
	addtimer(CALLBACK(src, PROC_REF(call_out_witnessed), WEAKREF(victim), REF(victim)), AI_CALLOUT_WITNESS_DELAY)

/datum/component/ai_callouts/proc/call_out_witnessed(datum/weakref/victim_ref, victim_id)
	var/mob/living/victim = victim_ref?.resolve()
	var/mob/living/basic/basic_mob = parent
	if(QDELETED(victim) || victim.stat == CONSCIOUS || basic_mob.stat != CONSCIOUS)
		return // back up already, or gone
	var/callout = "[victim_id] [victim.stat == DEAD ? "dead" : "down"]"
	var/called_at = GLOB.ai_called_down[callout]
	if(!isnull(called_at) && world.time - called_at < 2 SECONDS)
		return // whoever put them there said so, or another of us who saw it did
	if(!ai_can_see(basic_mob, victim, AI_VISION_RANGE(basic_mob.ai_controller)))
		return
	last_downed_callout = callout
	ai_mark_called_down(callout) // one of us to say it, whether or not the line comes up
	if(victim.stat == DEAD)
		if(downed_victim == victim)
			watch_downed_victim(null)
		speak_about(AI_CALLOUT_TARGET_DIED, subject = victim)
		queue_fight_over_check(AI_CALLOUT_ALL_CLEAR)
		return
	if(!downed_victim)
		watch_downed_victim(victim, inherited = TRUE) // for them getting up, or dying, which isn't our kill to call
	speak_about(AI_CALLOUT_TARGET_DROPPED, subject = victim)
	queue_fight_over_check(AI_CALLOUT_ALL_CLEAR, victim_ref)

/proc/ai_queue_fight_over_check(atom/speaker, event)
	var/datum/component/ai_callouts/callouts = speaker?.GetComponent(/datum/component/ai_callouts)
	callouts?.queue_fight_over_check(event)

/datum/component/ai_callouts/proc/queue_fight_over_check(event, datum/weakref/downed_ref)
	addtimer(CALLBACK(src, PROC_REF(check_fight_over), event, downed_ref), AI_CALLOUT_FIGHT_OVER_DELAY, TIMER_UNIQUE)

// if neither we nor any of ours in earshot have anyone to fight, or have been shot at lately, it's over as far as we know, and we say so
/datum/component/ai_callouts/proc/check_fight_over(event, datum/weakref/downed_ref)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || world.time < LAZYACCESS(line_cooldowns, event) || still_fighting(basic_mob))
		return
	var/mob/living/downed = downed_ref?.resolve()
	if(downed && downed.stat == CONSCIOUS)
		return // enemy is back up somehow, so it's not over
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(basic_mob, hearing_range, wall_penalty))
		if(still_fighting(ally))
			return
	if(!COOLDOWN_FINISHED(src, speech_cooldown))
		// delay lines to after cooldown is over
		addtimer(CALLBACK(src, PROC_REF(check_fight_over), event, downed_ref), COOLDOWN_TIMELEFT(src, speech_cooldown), TIMER_UNIQUE)
		return
	speak_about(event)

/datum/component/ai_callouts/proc/still_fighting(mob/living/someone)
	var/datum/ai_controller/controller = someone.ai_controller
	if(!controller)
		return FALSE
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		return TRUE
	return world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < 5 SECONDS // someone we haven't found yet is still shooting

/datum/component/ai_callouts/proc/watch_downed_victim(mob/living/victim, inherited = FALSE)
	if(downed_victim)
		UnregisterSignal(downed_victim, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_MOB_STATCHANGE))
	downed_victim = victim
	downed_victim_inherited = inherited
	if(downed_victim)
		RegisterSignal(downed_victim, COMSIG_LIVING_DEATH, PROC_REF(on_downed_victim_died))
		RegisterSignal(downed_victim, COMSIG_QDELETING, PROC_REF(on_downed_victim_deleted))
		RegisterSignal(downed_victim, COMSIG_MOB_STATCHANGE, PROC_REF(on_downed_victim_stat_change))

// someone we put down is back on their feet, like from meds they had on them, so calling them down again is news again
/datum/component/ai_callouts/proc/on_downed_victim_stat_change(mob/living/victim, new_stat)
	SIGNAL_HANDLER
	if(new_stat != CONSCIOUS)
		return
	watch_downed_victim(null)
	last_downed_callout = null
	INVOKE_ASYNC(src, PROC_REF(call_out_getting_up), victim)

// someone who sees a downed target get up says so, whoever they're fighting.
/datum/component/ai_callouts/proc/call_out_getting_up(mob/living/victim)
	if(QDELETED(victim))
		return
	for(var/datum/component/ai_callouts/witness as anything in list(src) + get_allies_in_earshot())
		var/mob/living/witness_mob = witness.parent
		if(witness_mob.stat == CONSCIOUS && ai_can_see(witness_mob, victim, witness.hearing_range) && witness.speak_about(AI_CALLOUT_GETTING_UP, interrupt = TRUE, subject = victim))
			return

/datum/component/ai_callouts/proc/on_downed_victim_died(mob/living/victim)
	SIGNAL_HANDLER
	var/datum/weakref/victim_ref = WEAKREF(victim)
	var/victim_id = REF(victim)
	var/inherited = downed_victim_inherited
	watch_downed_victim(null)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || !ai_can_see(basic_mob, victim, hearing_range))
		return
	if(inherited)
		witness_downed(victim) // not ours to call, if whoever downed them is dead, or we only saw them go down. But we saw them die, so we say so if nobody else does
		return
	// ours if they bled out from it, but if someone else's hit finished them, it's theirs, and they call it a moment after it lands, so we wait to see
	addtimer(CALLBACK(src, PROC_REF(call_out_watched_death), victim_ref, victim_id), AI_CALLOUT_WITNESS_DELAY)

// someone we downed has died, and nobody else has called it their kill, so it's ours
/datum/component/ai_callouts/proc/call_out_watched_death(datum/weakref/victim_ref, victim_id)
	var/called_at = GLOB.ai_called_down["[victim_id] dead"]
	if(!isnull(called_at) && world.time - called_at < 2 SECONDS)
		return
	call_out_downed(victim_ref, victim_id)

/datum/component/ai_callouts/proc/on_downed_victim_deleted(datum/source)
	SIGNAL_HANDLER
	watch_downed_victim(null)

/datum/component/ai_callouts/proc/on_pre_death(datum/source, gibbed)
	SIGNAL_HANDLER
	if(!gibbed)
		speak_about(AI_CALLOUT_DEATH_RATTLE, last_words = TRUE) // before we're dead, or it'd go to deadchat

/datum/component/ai_callouts/proc/on_death(datum/source)
	SIGNAL_HANDLER
	var/list/allies = get_allies_in_earshot()
	if(downed_victim)
		// watch the downed
		for(var/datum/component/ai_callouts/ally as anything in allies)
			if(!ally.downed_victim)
				ally.watch_downed_victim(downed_victim, inherited = TRUE)
				break
		watch_downed_victim(null)
	var/mob/living/basic/basic_mob = parent
	var/was_commander = basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_COMMANDER]
	for(var/datum/component/ai_callouts/ally as anything in allies)
		// the last of us left, so we call for help, whether or not any's coming
		if(!length(get_ai_allies_in_earshot(ally.parent, ally.hearing_range, ally.wall_penalty)) && ally.speak_about(AI_CALLOUT_LAST_STANDING, interrupt = TRUE))
			continue
		if(was_commander && ally.speak_about(AI_CALLOUT_COMMANDER_DOWN, interrupt = TRUE))
			continue // the one giving the orders, which is worse news than any of the rest of us
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

// answering is for answering an ally, which we do even if we've just said something. direction goes where the line says %DIRECTION
// subject is who it's about, if anyone in particular, so lines with %ADJ or %SPECIES can say what they look like, and are left out if we can't tell
/datum/component/ai_callouts/proc/speak_about(event, last_words = FALSE, interrupt = FALSE, answering = FALSE, direction, atom/subject)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS || basic_mob.client)
		return FALSE
	var/list/descriptors = ai_callout_descriptors(subject)
	var/line = pick_line(event, last_words, interrupt, answering, descriptors)
	if(!line)
		return FALSE
	var/is_commander = basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_COMMANDER]
	var/sounds_alarm = is_commander && event == AI_CALLOUT_RAISING_ALARM && world.time >= basic_mob.ai_controller.blackboard[BB_BASIC_MOB_NEXT_ALARM_SOUNDED]
	if(is_commander && event == AI_CALLOUT_RAISING_ALARM)
		line = get_alarm_line(event, carries_alarm = sounds_alarm, descriptors = descriptors) || line
	if(direction)
		line = replacetext(line, "%DIRECTION", direction)
	for(var/marker in descriptors)
		if(descriptors[marker])
			line = replacetext(line, marker, descriptors[marker])
	line = replacetext(line, "%PLANET", pick(GLOB.major_planets))
	if(interrupt)
		last_interrupt_time = world.time
	COOLDOWN_START(src, chatter_cooldown, 5 SECONDS)
	if(!ai_callout_is_chatter(event))
		COOLDOWN_START(src, speech_cooldown, 5 SECONDS)
	//we do this after the cooldown because its mildly more intensive
	//any marker in GLOB.ai_callout_sounds, so another sound's a line there rather than adding snowflakes here
	var/alarm_range = 0
	if(findtext(line, "%"))
		for(var/marker in GLOB.ai_callout_sounds)
			if(!findtext(line, marker))
				continue
			var/list/marker_sound = GLOB.ai_callout_sounds[marker]
			line = trim(replacetext(line, marker, "")) // and the space it leaves
			if(marker_sound[4] && !is_commander)
				continue // one that carries an alarm is a commander's, like the whistle, so it means something when it's heard. Anyone else just says the line
			playsound(basic_mob, marker_sound[1], marker_sound[2], FALSE, marker_sound[3])
			alarm_range = max(alarm_range, marker_sound[4] || 0)
	say_line(line, last_words)
	if(alarm_range && sounds_alarm)
		sound_the_alarm(alarm_range) // only a commander's, or a sentry spotting someone far off would have everyone run out across open ground to them
		basic_mob.ai_controller.set_blackboard_key(BB_BASIC_MOB_NEXT_ALARM_SOUNDED, world.time + AI_COMMANDER_ALARM_COOLDOWN)
	var/list/allies_in_earshot = get_ai_allies_in_earshot(basic_mob, hearing_range, wall_penalty)
	var/list/listening_callouts = get_allies_in_earshot(allies_in_earshot)
	var/is_chatter = ai_callout_is_chatter(event)
	note_line_heard(is_chatter)
	for(var/datum/component/ai_callouts/listener as anything in listening_callouts)
		listener.note_line_heard(is_chatter)
	var/static/list/good_news = list(
		AI_CALLOUT_TARGET_DOWN = TRUE,
		AI_CALLOUT_TARGET_KILLED = TRUE,
		AI_CALLOUT_HEADSHOT_DOWN = TRUE,
		AI_CALLOUT_HEADSHOT_KILLED = TRUE,
		AI_CALLOUT_TARGET_DROPPED = TRUE,
		AI_CALLOUT_TARGET_DIED = TRUE,
	)
	if(good_news[event])
		for(var/mob/living/ally as anything in allies_in_earshot)
			ai_try_embolden(ally)
	else if(event == AI_CALLOUT_LOST_THEM || event == AI_CALLOUT_RELOADING)
		prompt_answer(event)
	share_line_cooldown(event, listening_callouts)
	return TRUE

// one of our lines for event that carries an alarm, like with a whistle in it, see GLOB.ai_callout_sounds, or if carries_alarm is FALSE, one that doesn't. Null if we've none
/datum/component/ai_callouts/proc/get_alarm_line(event, carries_alarm = TRUE, list/descriptors)
	var/datum/ai_callout_set/callouts = get_ai_callout_set(callout_set)
	var/list/fitting_lines = list()
	for(var/candidate in callouts.lines[event])
		if(!istext(candidate) || ai_callout_missing_descriptor(candidate, descriptors))
			continue
		var/has_alarm = FALSE
		for(var/marker in GLOB.ai_callout_sounds)
			var/list/marker_sound = GLOB.ai_callout_sounds[marker]
			if(marker_sound[4] && findtext(candidate, marker))
				has_alarm = TRUE
				break
		if(has_alarm == carries_alarm)
			fitting_lines += candidate
	return length(fitting_lines) ? pick(fitting_lines) : null

/datum/component/ai_callouts/proc/sound_the_alarm(range)
	var/mob/living/basic/basic_mob = parent
	var/datum/ai_controller/controller = basic_mob.ai_controller
	var/atom/target = controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/our_turf = get_turf(basic_mob)
	if(QDELETED(target) || !our_turf)
		return
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(basic_mob, range, wall_penalty))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		var/atom/their_target = ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(!QDELETED(their_target) || AI_RECENTLY_SAW_ENEMY(ally_controller, AI_FIGHT_MEMORY))
			continue
		AI_LOG_DECISION(ally_controller, "heard [basic_mob] raise the alarm, rallying on them against [target]")
		ally_controller.learn_of_target(target, guess_sound_origin(our_turf, 3, somewhere_to_stand = TRUE), AI_LEARNED_TOLD) // round us, so they don't all pile onto the one tile
		ally_controller.set_blackboard_key(BB_BASIC_MOB_RALLYING, TRUE) // so they walk to it, rather than firing at it, until they see who they're after

/datum/component/ai_callouts/proc/note_line_heard(is_chatter)
	if(world.time >= turn_ends_at)
		turn_ends_at = world.time + AI_CALLOUT_TURN_GAP
		turn_chatter = 0
	if(is_chatter)
		turn_chatter++

// a moment after we say event, one of ours in earshot answers it, for the lines that get one
/datum/component/ai_callouts/proc/prompt_answer(event)
	var/mob/living/basic/basic_mob = parent
	var/atom/target = basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	addtimer(CALLBACK(src, PROC_REF(get_answered), event, target ? WEAKREF(target) : null), AI_CALLOUT_ANSWER_DELAY)

// whoever's still about to answer does, picked now rather than when we asked, as whoever we'd have picked may be down or gone by now
/datum/component/ai_callouts/proc/get_answered(event, datum/weakref/target_ref)
	var/mob/living/basic/basic_mob = parent
	if(basic_mob.stat != CONSCIOUS)
		return // nobody to answer
	var/atom/target = target_ref?.resolve()
	for(var/datum/component/ai_callouts/answerer as anything in shuffle(get_allies_in_earshot()))
		switch(event)
			if(AI_CALLOUT_LOST_THEM)
				if(!QDELETED(target) && answerer.answer_where_they_went(src, target))
					return
			if(AI_CALLOUT_RELOADING)
				if(answerer.answer_reloading())
					return

// an ally lost sight of target and asked where they went, so we tell them which way, if we know better than they do, and they go and look there. TRUE if we answered
/datum/component/ai_callouts/proc/answer_where_they_went(datum/component/ai_callouts/asker, atom/target)
	var/mob/living/basic/basic_mob = parent
	var/mob/living/asking_mob = asker?.parent
	var/datum/ai_controller/our_controller = basic_mob.ai_controller
	var/datum/ai_controller/their_controller = asking_mob?.ai_controller
	if(QDELETED(target) || !our_controller || !their_controller || asking_mob.stat != CONSCIOUS)
		return FALSE
	var/turf/known_turf
	var/known_time
	if(our_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == target && our_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		known_turf = get_turf(target)
		known_time = world.time
	else if(our_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TARGET] == target)
		known_turf = our_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
		known_time = our_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME]
	var/their_known_time = their_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TARGET] == target ? their_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME] : null
	var/turf/their_turf = get_turf(asking_mob)
	if(!known_turf || !their_turf || known_turf.z != their_turf.z || get_dist(their_turf, known_turf) < 3 || (!isnull(their_known_time) && known_time <= their_known_time))
		return speak_about(AI_CALLOUT_NO_SIGN, answering = TRUE) // nothing they don't already know
	if(!speak_about(AI_CALLOUT_LAST_SEEN, answering = TRUE, direction = dir2text(get_dir(their_turf, known_turf)), subject = target))
		return FALSE
	their_controller.learn_of_target(target, known_turf, AI_LEARNED_TOLD) // so they go where we said, not somewhere else
	return TRUE

// an ally's reloading, and we can see who we're fighting, so we say we've got them. TRUE if we did
/datum/component/ai_callouts/proc/answer_reloading()
	return sees_target() && speak_about(AI_CALLOUT_COVERING, answering = TRUE)

// what we'd say about event right now, or null if we'd keep quiet. Lines with %ADJ or %SPECIES only if descriptors, from ai_callout_descriptors(), has it for who it's about
/datum/component/ai_callouts/proc/pick_line(event, last_words = FALSE, interrupt = FALSE, answering = FALSE, list/descriptors)
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
		AI_CALLOUT_HEADSHOT_DOWN = TRUE,
		AI_CALLOUT_HEADSHOT_KILLED = TRUE,
		AI_CALLOUT_TARGET_DROPPED = TRUE,
		AI_CALLOUT_TARGET_DIED = TRUE,
		AI_CALLOUT_EXECUTING = TRUE,
	)
	var/mob/living/basic/basic_mob = parent
	if(about_people[event])
		var/atom/target = basic_mob.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(target && !ai_is_person(target))
			return null
	var/datum/ai_callout_set/callouts = get_ai_callout_set(callout_set)
	var/lines
	var/datum/ai_controller/controller = basic_mob.ai_controller
	var/morale = controller?.blackboard[BB_BASIC_MOB_MORALE]
	if(callouts.solo_lines[event] && is_alone())
		lines = callouts.solo_lines[event] // nobody of ours to say it to, so we say it to ourselves, or to them
	else if(morale && AI_MORALE_IS(controller, morale))
		var/list/mood_lines = callouts.morale_lines[morale]
		lines = mood_lines?[event] // how we'd say it in this mood, if we've a line for that
	lines ||= callouts.lines[event]
	var/chance = callouts.chances[event]
	var/own_lines = event == AI_CALLOUT_SPOTTED && length(spotted_lines)
	if(own_lines)
		lines = spotted_lines
		chance = spotted_chance
	else if(event == AI_CALLOUT_IDLE && length(idle_lines))
		lines = idle_lines // still paced with the group, unlike our own spotted lines
	if(!lines)
		return null
	if(!last_words && !interrupt && !answering)
		if(!COOLDOWN_FINISHED(src, speech_cooldown))
			return null
		if(ai_callout_is_chatter(event) && (!COOLDOWN_FINISHED(src, chatter_cooldown) || (world.time < turn_ends_at && turn_chatter >= AI_CALLOUT_CHATTER_PER_TURN)))
			return null // chatter waits its turn
	if(interrupt && !last_words && world.time < last_interrupt_time + AI_CALLOUT_INTERRUPT_GAP)
		return null // we've only just said something urgent, which covers this too
	if(!own_lines && world.time < LAZYACCESS(line_cooldowns, event))
		return null // someone in earshot's just said it
	if(!prob(isnull(chance) ? callouts.default_chance : chance))
		return null
	var/line = islist(lines) ? pick_weight_recursive(lines) : lines
	// one that says what they look like, when we can't tell, so another. Lines can be weighted and nested, so we pick again rather than filter
	for(var/attempt in 1 to 5)
		if(!islist(lines) || !ai_callout_missing_descriptor(line, descriptors))
			break
		line = pick_weight_recursive(lines)
	if(ai_callout_missing_descriptor(line, descriptors))
		return null
	return line

// actually says line, in our voice, or whispers it if it's our last words
/datum/component/ai_callouts/proc/say_line(line, last_words = FALSE)
	var/mob/living/basic/basic_mob = parent
	if(!last_words && length(line) > 1)
		switch(copytext(line, 1, 2))
			if("*") //whistle
				basic_mob.manual_emote(copytext(line, 2))
				return
			if("%") //singing
				if(!(text2ascii(line, 2) in 65 to 90))
					INVOKE_ASYNC(basic_mob, TYPE_PROC_REF(/atom/movable, say), line)
					return
	var/datum/ai_callout_set/callouts = get_ai_callout_set(callout_set)
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

// puts event on cooldown for us and everyone in earshot, so the group doesn't all say it at once. listening_callouts is get_allies_in_earshot() if we've already got it to hand
/datum/component/ai_callouts/proc/share_line_cooldown(event, list/listening_callouts)
	// how long a callout goes on cooldown for a group
	var/static/list/group_line_cooldowns = list(
		AI_CALLOUT_SPOTTED = 15 SECONDS,
		AI_CALLOUT_TARGET_DOWN = 20 SECONDS,
		AI_CALLOUT_TARGET_KILLED = 20 SECONDS,
		AI_CALLOUT_HEADSHOT_DOWN = 20 SECONDS,
		AI_CALLOUT_HEADSHOT_KILLED = 20 SECONDS,
		AI_CALLOUT_TARGET_DROPPED = 20 SECONDS,
		AI_CALLOUT_TARGET_DIED = 20 SECONDS,
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
		AI_CALLOUT_GRENADE = 4 SECONDS, // one or two voices for it, not the whole room
		AI_CALLOUT_GRENADE_OUT = 4 SECONDS,
		AI_CALLOUT_TARGETS_STUNNED = 10 SECONDS,
		AI_CALLOUT_ENEMY_RELOADING = 10 SECONDS,
		AI_CALLOUT_CHARGE = 15 SECONDS,
		AI_CALLOUT_ORDER_PUSH = 20 SECONDS,
		AI_CALLOUT_ORDER_HOLD = 20 SECONDS,
		AI_CALLOUT_PROTECT_COMMANDER = 10 SECONDS,
		AI_CALLOUT_COMMANDER_DOWN = 10 SECONDS, // one voice for it
		AI_CALLOUT_ORDER_RETREAT = 20 SECONDS,
		AI_CALLOUT_SUSPICIOUS = 8 SECONDS,
		AI_CALLOUT_FOUND_HIDING = 8 SECONDS,
		AI_CALLOUT_LOST_INTEREST = 15 SECONDS,
		AI_CALLOUT_IDLE = 20 SECONDS, // one of a group chatting now and then, not all of them at once
		AI_CALLOUT_KNOCKED_DOWN = 6 SECONDS,
		AI_CALLOUT_FLASHED = 8 SECONDS, // a flashbang likely gets a whole group at once, so one of us says so
		AI_CALLOUT_GASSED = 10 SECONDS,
		AI_CALLOUT_STAGGERED = 15 SECONDS,
		AI_CALLOUT_NO_COVER = 20 SECONDS,
		AI_CALLOUT_LAST_STANDING = 30 SECONDS,
		AI_CALLOUT_ALL_CLEAR = 30 SECONDS, // one voice for it, not everyone who got a kill at the end
		AI_CALLOUT_GOT_AWAY = 30 SECONDS,
		AI_CALLOUT_GETTING_UP = 8 SECONDS,
		AI_CALLOUT_RAISING_ALARM = 15 SECONDS,
		AI_CALLOUT_BREACHING = 20 SECONDS, // said each time we start on something, so not every pane of glass
		AI_CALLOUT_CANT_REACH = 20 SECONDS,
		AI_CALLOUT_CHECK_IN = 15 SECONDS, // asking after someone every hit would wear thin fast
	)
	var/group_cooldown = group_line_cooldowns[event]
	if(!group_cooldown)
		return
	LAZYSET(line_cooldowns, event, world.time + group_cooldown) // so we don't repeat ourselves either
	for(var/datum/component/ai_callouts/ally as anything in listening_callouts || get_allies_in_earshot())
		LAZYSET(ally.line_cooldowns, event, world.time + group_cooldown)

/// whether thing is someone worth calling out like a person: humans and human NPCs, anyone a player's controlling, and mechs, as there's someone inside
/proc/ai_is_person(atom/thing)
	if(ismecha(thing))
		return TRUE
	var/mob/living/someone = thing
	if(!istype(someone))
		return FALSE
	return ishuman(someone) || istype(someone, /mob/living/basic/human) || someone.client

// whether there's none of ours in earshot to hear us
/datum/component/ai_callouts/proc/is_alone()
	if(world.time < alone_checked_until)
		return alone
	alone = !length(get_ai_allies_in_earshot(parent, hearing_range, wall_penalty))
	alone_checked_until = world.time + 2 SECONDS
	return alone

// how many lines we've got to chat with, our own or our callout set's, for idle chatter to weigh against our emotes
/datum/component/ai_callouts/proc/idle_line_count()
	if(length(idle_lines))
		return length(idle_lines)
	var/datum/ai_callout_set/callouts = get_ai_callout_set(callout_set)
	return length(callouts.lines[AI_CALLOUT_IDLE])
