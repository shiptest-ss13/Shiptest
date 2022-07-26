/mob/living/simple_animal/hostile/megafauna/prophet
	name = "\improper False Prophet"
	desc = "Uncanny doesn't even begin to describe this... abomination."
	health = 2000
	maxHealth = 2000
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon = 'icons/mob/lavaland/64x64megafauna.dmi'
	icon_state = "prophet"
	icon_living = "prophet"
	icon_dead = "dragon_dead"
	health_doll_icon = "prophet"
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	speak_emote = list("cries", "whimpers", "screams", "wails", "shrieks")
	armour_penetration = 30
	melee_damage_lower = 30
	melee_damage_upper = 30
	speed = 5
	move_to_delay = 5
	ranged = TRUE
	pixel_x = -16
	crusher_loot = list(/obj/structure/closet/crate/necropolis/dragon/crusher)
	loot = list(/obj/structure/closet/crate/necropolis/dragon)
	butcher_results = list(/obj/item/stack/ore/uranium = 10, /obj/item/stack/ore/diamond = 5, /obj/item/stack/sheet/sinew = 5, /obj/item/stack/sheet/bone = 30, /obj/effect/mob_spawn/human/corpse/damaged/prophet_kobold = 1)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/prophet = 4, /obj/item/crusher_trophy/prophet_spine = 1, /obj/item/tailclub/prophet_tail = 1)
	gps_name = "Entrancing Signal"
	achievement_type = /datum/award/achievement/boss/prophet_kill
	crusher_achievement_type = /datum/award/achievement/boss/prophet_crusher
	score_achievement_type = /datum/award/score/prophet_score
	deathmessage = "collapses into a pile of bones, its flesh sloughing away."
	deathsound = 'sound/magic/demon_dies.ogg'
	footstep_type = FOOTSTEP_MOB_HEAVY
	attack_action_types = list(
		/datum/action/innate/megafauna_attack/stare,
		/datum/action/innate/megafauna_attack/leap,
		/datum/action/innate/megafauna_attack/disorienting_scream,
		/datum/action/innate/megafauna_attack/ponder)
	small_sprite_type = /datum/action/small_sprite/megafauna/drake
	speak = list("Don't Run.", "Behold.", "Drop it.", "Beg.", "This is no place for you.", "Fly away.", "You are mine.", "Break.", "The Irons Melt, the Fire Molds.", "The Mind, weak and vulnerable, bides its time.", "The red birthday harbors a gilded harbinger.", "Feel the Tar that lives under all of us.", "The triple headed one's blind gaze sees nothing, but me.", "They Lie.", "The Puppet pulls the strings.", "The Mirrors tell false ideas.", "The Walls, Take down the walls and it becomes all clear.", "There is no sky.")
	speak_chance = 5

	var/leaping = FALSE
	var/pondering = FALSE
	var/can_move = TRUE

/mob/living/simple_animal/hostile/megafauna/prophet/Move(atom/newloc, dir, step_x, step_y)
	if(!can_move)
		return
	return ..()

/mob/living/simple_animal/hostile/megafauna/prophet/AttackingTarget()
	if(leaping || pondering || !can_move)
		return
	return ..()

/mob/living/simple_animal/hostile/megafauna/prophet/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	. = ..()
	animate(src, pixel_z = rand(5, 15), time = 1, loop = 6)
	animate(pixel_z = 0, time = 1)
	playsound(src, 'sound/magic/demon_dies.ogg', 60, FALSE, 10)

/mob/living/simple_animal/hostile/megafauna/prophet/OpenFire()
	if(leaping || pondering || !can_move)
		return

	anger_modifier = clamp(((maxHealth - health)/50), 0, 20)
	ranged_cooldown = world.time + ranged_cooldown_time

	if(client)
		switch(chosen_attack)
			if(1)
				begin_stare()
			if(2)
				leap_at()
			if(3)
				disorienting_scream()
			if(4)
				ponder()
		return

	if(prob(45 - anger_modifier * 2))
		ponder()
	else if(prob(15 + anger_modifier))
		leap_at()
	else if(prob(30 + anger_modifier))
		disorienting_scream()
	else
		begin_stare()

/mob/living/simple_animal/hostile/megafauna/prophet/examine(mob/user)
	. = ..()
	truly_see(user)

/mob/living/simple_animal/hostile/megafauna/prophet/proc/begin_stare(mob/victim = target)
	can_move = FALSE
	visible_message("<span class='danger'>[src] begins looking towards [victim]!<span>", "<span class='notice'>You move to stare at [victim].</span>")
	add_overlay("prophetaggro")
	addtimer(CALLBACK(src, .proc/truly_see, victim), 8 SECONDS)

/mob/living/simple_animal/hostile/megafauna/prophet/proc/truly_see(mob/victim = target)
	can_move = TRUE
	cut_overlay("prophetaggro")
	if(stat == DEAD) //we close our eyes if we're dead, they clearly do not want to see
		return
	if(get_dir(src, victim) & victim.dir) //if they aren't looking upon our beautiful face
		return
	if(!istype(victim, /mob/living/carbon)) //we only wish for somewhat intelligent beings
		return
	var/mob/living/carbon/C = victim
	new /obj/effect/temp_visual/mark(get_turf(victim))

	if(C.is_blind()) //the blind ones cannot behold our visage
		return

	if(!C.hypnosis_vulnerable() && !pondering) //if they've stared, they may be willing to learn to understand us
		C.hallucination = max(C.hallucination + 15, 50)
		to_chat("<span class='danger'>You feel uneasy looking at [src]...</span>")
		return

	to_chat("<span class='userdanger'>You accidentally glance into [src]'s eyes, and lose yourself...</span>")
	C.apply_damage(15, BRAIN) //a small price for them to pay for their understanding
	if(prob(20) && C.get_damage_amount(BRAIN) > BRAIN_DAMAGE_SEVERE)
		C.gain_trauma(/datum/brain_trauma/severe/hypnotic_stupor) //they will understand us better this way
	C.apply_status_effect(/datum/status_effect/trance, 5 SECONDS, FALSE)
	C.Immobilize(2 SECONDS) //we transfix them with our gaze
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "prophet_hypno", /datum/mood_event/prophet_hypno)
	add_target(C)

/mob/living/simple_animal/hostile/megafauna/prophet/proc/leap_at(atom/at = target)
	if((mobility_flags & (MOBILITY_MOVE | MOBILITY_STAND)) != (MOBILITY_MOVE | MOBILITY_STAND) || leaping)
		return

	if(!has_gravity() || !at.has_gravity())
		to_chat(src, "<span class='danger'>It is unsafe to leap without gravity!</span>")
		//It's also extremely buggy visually, so it's balance+bugfix
		return

	else
		leaping = TRUE
		throw_at(at, 10, 1, src, FALSE, TRUE, callback = VARSET_CALLBACK(src, leaping, FALSE))

/mob/living/simple_animal/hostile/megafauna/prophet/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!isliving(hit_atom))
		return
	var/mob/living/L = hit_atom
	L.visible_message("<span class='danger'>[src] pounces on [L]!</span>", "<span class='userdanger'>[src] pounces on you!</span>")
	L.Paralyze(3 SECONDS)

/// Applies dizziness to all nearby enemies that can hear the scream and animates the wendigo shaking up and down
/mob/living/simple_animal/hostile/megafauna/prophet/proc/disorienting_scream()
	can_move = FALSE
	playsound(src, 'sound/magic/demon_dies.ogg', 600, FALSE, 10)
	animate(src, pixel_z = rand(5, 15), time = 1, loop = 6)
	animate(pixel_z = 0, time = 1)
	for(var/mob/living/L in get_hearers_in_view(7, src) - src)
		L.hallucination += rand(6, 12)
		to_chat(L, "<span class='danger'>[src] shrieks a sound not from this world!</span>")
	SetRecoveryTime(30, 0)
	addtimer(VARSET_CALLBACK(src, can_move, TRUE), 12)

/mob/living/simple_animal/hostile/megafauna/prophet/proc/ponder()
	pondering = TRUE
	can_move = FALSE
	visible_message("<span class='danger'>[src] begins looking around wildly...</span>", "<span class='notice'>We start looking around wildly.</span>")
	SetRecoveryTime(30, 0)
	add_overlay("prophetaggro")
	addtimer(CALLBACK(src, .proc/ponder_end), 5 SECONDS)

/mob/living/simple_animal/hostile/megafauna/prophet/proc/ponder_end()
	visible_message("<span class='notice'>[src] stops looking around wildly.</span>", "<span class='notice'>We stop looking around wildly.</span>")
	cut_overlay("prophetaggro")
	pondering = FALSE
	can_move = TRUE
	handle_automated_speech(TRUE) //we share an insight we thought of

/datum/action/innate/megafauna_attack/stare
	name = "Stare"
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "god_transmit"
	chosen_message = "<span class='colossus'>You are now staring at your target with your hypnotic eyes.</span>"
	chosen_attack_num = 1

/datum/action/innate/megafauna_attack/leap
	name = "Leap"
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "jetboot"
	chosen_message = "<span class='colossus'>You are now leaping at targets.</span>"
	chosen_attack_num = 2

// slot 3 is disorienting scream

/datum/action/innate/megafauna_attack/ponder
	name = "Ponder"
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "telepathy"
	chosen_message = "<span class='colossus'>You are now standing still and staring all around you.</span>"
	chosen_attack_num = 4

/obj/effect/mob_spawn/human/corpse/damaged/prophet_kobold
	mob_species = /datum/species/lizard/ashwalker/kobold
	uniform = /obj/item/clothing/under/costume/gladiator/ash_walker
	l_hand = /obj/item/storage/bag/money/vault

/obj/effect/mob_spawn/human/corpse/damaged/prophet_kobold/Initialize()
	if(prob(95))
		head = /obj/item/clothing/head/helmet/gladiator
	else
		head = /obj/item/clothing/head/helmet/skull
		suit = /obj/item/clothing/suit/armor/bone
		gloves = /obj/item/clothing/gloves/bracer
	if(prob(5))
		back = pickweight(list(/obj/item/spear/bonespear = 3, /obj/item/fireaxe/boneaxe = 2))
	if(prob(10))
		belt = /obj/item/storage/belt/mining/primitive
	if(prob(30))
		r_pocket = /obj/item/kitchen/knife/combat/bone
	if(prob(30))
		l_pocket = /obj/item/kitchen/knife/combat/bone
	return ..()

/obj/item/tailclub/prophet_tail
	name = "Prophet's Tail"
	desc = "The tail of a false prophet. It feels weird and fleshy, but makes an okay weapon.\n<span class='notice'>It seems you could SKIN the tail with something sharp...</span>"

/obj/item/tailclub/prophet_tail/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(I.sharpness < IS_SHARP)
		return
	playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
	if(!do_after(user, 10 SECONDS, target = src))
		return
	new /obj/item/reagent_containers/food/snacks/meat/slab/prophet_tail(loc)
	new /obj/item/clothing/neck/cloak/prophet(loc)
	qdel(src)

/obj/item/organ/eyes/false_prophet
	name = "Eyes of the False Prophet"
	desc = "Eyes with the power of hypnotism.\n<span class='warning'>You feel uneasy looking at them, even now...</span>"

/obj/item/organ/eyes/false_prophet/proc/truly_see(mob/living/carbon/owner, mob/living/victim, list/examine_list)
	SIGNAL_HANDLER
	if(victim == owner) //hey me
		return
	if(owner.stat == DEAD) //oh fuck I died nevermind
		return
	new /obj/effect/temp_visual/mark(get_turf(victim))
	if(!istype(victim, /mob/living/carbon)) //josh I don't think you're that intelligent honestly but still come look
		return
	var/mob/living/carbon/C = victim

	if(C.is_blind()) //josh do your eyes still work
		return

	if(!C.hypnosis_vulnerable()) //josh you just got trolled
		C.hallucination = max(C.hallucination + 15, 50)
		examine_list += "<span class='danger'>You feel uneasy looking at [owner]...</span>"
		return

	examine_list += "<span class='userdanger'>You accidentally glance into [owner]'s eyes, and lose yourself...</span>"
	C.apply_damage(15, BRAIN) //okay maybe a little too much trolling
	if(prob(20) && C.get_damage_amount(BRAIN) > BRAIN_DAMAGE_SEVERE)
		C.gain_trauma(/datum/brain_trauma/severe/hypnotic_stupor) //oh fuck
	C.apply_status_effect(/datum/status_effect/trance, 5 SECONDS, FALSE)
	C.Immobilize(2 SECONDS) //gottem
	SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "prophet_hypno", /datum/mood_event/prophet_hypno)

/obj/item/organ/eyes/false_prophet/Insert(mob/living/carbon/M, special, drop_if_replaced, initialising)
	. = ..()
	RegisterSignal(M, COMSIG_PARENT_EXAMINE, .proc/truly_see)

/obj/item/organ/eyes/false_prophet/Remove(mob/living/carbon/M, special)
	. = ..()
	UnregisterSignal(M, COMSIG_PARENT_EXAMINE)
