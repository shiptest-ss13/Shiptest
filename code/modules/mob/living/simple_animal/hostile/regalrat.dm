/mob/living/simple_animal/hostile/regalrat
	name = "regal rat"
	desc = "An evolved rat, created through some strange science. It leads nearby rats with deadly efficiency to protect its kingdom. Not technically a king."
	icon_state = "regalrat"
	icon_living = "regalrat"
	icon_dead = "regalrat_dead"
	gender = NEUTER
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 70
	health = 70
	see_in_dark = 5
	obj_damage = 10
	butcher_results = list(/obj/item/clothing/head/crown = 1,)
	response_help_continuous = "glares at"
	response_help_simple = "glare at"
	response_disarm_continuous = "skoffs at"
	response_disarm_simple = "skoff at"
	response_harm_continuous = "slashes"
	response_harm_simple = "slash"
	melee_damage_lower = 13
	melee_damage_upper = 15
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/punch1.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	unique_name = TRUE
	faction = list("rat")
	var/datum/action/cooldown/coffer
	var/datum/action/cooldown/riot
	///Number assigned to rats and mice, checked when determining infighting.

/mob/living/simple_animal/hostile/regalrat/Initialize()
	. = ..()
	coffer = new /datum/action/cooldown/coffer
	riot = new /datum/action/cooldown/riot
	coffer.Grant(src)
	riot.Grant(src)
	INVOKE_ASYNC(src, PROC_REF(get_player))

/mob/living/simple_animal/hostile/regalrat/Destroy()
	coffer.Remove(src)
	riot.Remove(src)
	QDEL_NULL(coffer)
	QDEL_NULL(riot)
	return ..()

/mob/living/simple_animal/hostile/regalrat/proc/get_player()
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to play as the Royal Rat, cheesey be his crown?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
	if(LAZYLEN(candidates) && !mind)
		var/mob/dead/observer/C = pick(candidates)
		key = C.key
		notify_ghosts("All rise for the rat king, ascendant to the throne in \the [get_area(src)].", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Sentient Rat Created")

/mob/living/simple_animal/hostile/regalrat/handle_automated_action()
	if(prob(20))
		riot.Trigger()
	else if(prob(50))
		coffer.Trigger()
	return ..()

/mob/living/simple_animal/hostile/regalrat/CanAttack(atom/the_target)
	if(istype(the_target,/mob/living/simple_animal))
		var/mob/living/A = the_target
		if(istype(the_target, /mob/living/simple_animal/hostile/regalrat) && A.stat == CONSCIOUS)
			return TRUE
		if(istype(the_target, /mob/living/basic/mouse/rat) && A.stat == CONSCIOUS)
			var/mob/living/basic/mouse/rat/R = the_target
			if(R.faction_check_mob(src, TRUE))
				return FALSE
			else
				return TRUE
		return ..()

/mob/living/simple_animal/hostile/regalrat/examine(mob/user)
	. = ..()
	if(istype(user,/mob/living/basic/mouse/rat))
		var/mob/living/basic/mouse/rat/ratself = user
		if(ratself.faction_check_mob(src, TRUE))
			. += span_notice("This is your king. Long live his majesty!")
		else
			. += span_warning("This is a false king! Strike him down!")
	else if(istype(user,/mob/living/simple_animal/hostile/regalrat))
		. += span_warning("Who is this foolish false king? This will not stand!")

/**
 *This action creates trash, money, dirt, and cheese.
 */
/datum/action/cooldown/coffer
	name = "Fill Coffers"
	desc = "Your newly granted regality and poise let you scavenge for lost junk, but more importantly, cheese."
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	background_icon_state = "bg_clock"
	button_icon_state = "coffer"
	cooldown_time = 50

/datum/action/cooldown/coffer/Trigger()
	. = ..()
	if(!.)
		return
	var/turf/T = get_turf(owner)
	var/loot = rand(1,100)
	switch(loot)
		if(1 to 5)
			to_chat(owner, span_notice("Score! You find some cheese!"))
			new /obj/item/food/cheese/wedge(T)
		if(6 to 10)
			to_chat(owner, span_notice("You find some leftover coins. More for the royal treasury!"))
			for(var/i = 1 to rand(1,3))
				new /obj/effect/spawner/random/entertainment/coin(T)
		if(11 to 40)
			var/pickedtrash = pick(GLOB.trash_loot)
			to_chat(owner, span_notice("You just find more garbage and dirt. Lovely, but beneath you now."))
			new /obj/effect/decal/cleanable/dirt(T)
			new pickedtrash(T)
		if(41 to 100)
			to_chat(owner, span_notice("Drat. Nothing."))
			new /obj/effect/decal/cleanable/dirt(T)
	StartCooldown()

/**
 *This action checks all nearby mice, and converts them into hostile rats. If no mice are nearby, creates a new one.
 */

/datum/action/cooldown/riot
	name = "Raise Army"
	desc = "Raise an army out of the hordes of mice and pests crawling around the maintenance shafts."
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "riot"
	background_icon_state = "bg_clock"
	cooldown_time = 80
	///Checks to see if there are any nearby mice. Does not count Rats.

/datum/action/cooldown/riot/Trigger()
	. = ..()
	if(!.)
		return
	var/cap = CONFIG_GET(number/ratcap)
	var/something_from_nothing = FALSE
	for(var/mob/living/basic/mouse/M in oview(owner, 5))
		var/mob/living/basic/mouse/rat/new_rat = new(get_turf(M))
		something_from_nothing = TRUE
		if(M.mind && M.stat == CONSCIOUS)
			M.mind.transfer_to(new_rat)
		if(istype(owner,/mob/living/simple_animal/hostile/regalrat))
			var/mob/living/simple_animal/hostile/regalrat/giantrat = owner
			new_rat.faction = giantrat.faction
		qdel(M)
	if(!something_from_nothing)
		if(LAZYLEN(SSmobs.cheeserats) >= cap)
			to_chat(owner,span_warning("There's too many mice in this sector to beckon a new one! Find them first!"))
			return
		new /mob/living/basic/mouse(owner.loc)
		owner.visible_message(span_warning("[owner] commands a mouse to its side!"))
	else
		owner.visible_message(span_warning("[owner] commands its army to action, mutating them into rats!"))
	StartCooldown()
