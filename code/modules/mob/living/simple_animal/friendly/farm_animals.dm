//goat
/mob/living/simple_animal/hostile/retaliate/goat
	name = "goat"
	desc = "Not known for their pleasant disposition."
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	speak = list("EHEHEHEHEH","eh?")
	speak_emote = list("brays")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 4)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	faction = list("goat")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 40
	maxHealth = 40
	minbodytemp = 180
	melee_damage_lower = 1
	melee_damage_upper = 2
	environment_smash = ENVIRONMENT_SMASH_NONE
	stop_automated_movement_when_pulled = 1
	blood_volume = BLOOD_VOLUME_NORMAL

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/retaliate/goat/Initialize()
	AddComponent(/datum/component/udder)
	. = ..()

/mob/living/simple_animal/hostile/retaliate/goat/Life()
	. = ..()
	if(.)
		//chance to go crazy and start wacking stuff
		if(!enemies.len && prob(1))
			Retaliate()

		if(enemies.len && prob(10))
			enemies = list()
			LoseTarget()
			src.visible_message(span_notice("[src] calms down."))
	if(stat == CONSCIOUS)
		eat_plants()
		if(!pulledby)
			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
				var/step = get_step(src, direction)
				if(step)
					if(locate(/obj/structure/spacevine) in step || locate(/obj/structure/glowshroom) in step)
						Move(step, get_dir(src, step))

/mob/living/simple_animal/hostile/retaliate/goat/Retaliate()
	..()
	src.visible_message(span_danger("[src] gets an evil-looking gleam in [p_their()] eye."))

/mob/living/simple_animal/hostile/retaliate/goat/Move()
	. = ..()
	if(!stat)
		eat_plants()

/mob/living/simple_animal/hostile/retaliate/goat/proc/eat_plants()
	var/eaten = FALSE
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		eaten = TRUE

	var/obj/structure/glowshroom/GS = locate(/obj/structure/glowshroom) in loc
	if(GS)
		qdel(GS)
		eaten = TRUE

	if(eaten && prob(10))
		say("Nom")

/mob/living/simple_animal/hostile/retaliate/goat/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		if(istype(H.dna.species, /datum/species/pod))
			var/obj/item/bodypart/NB = H.get_random_bodypart()
			H.visible_message(
				span_warning("[src] takes a big chomp out of [H]!"), \
				span_userdanger("[src] takes a big chomp out of your [NB]!"))
			NB.dismember()

/mob/living/simple_animal/chick
	name = "\improper chick"
	desc = "Adorable! They make such a racket though."
	icon_state = "chick"
	icon_living = "chick"
	icon_dead = "chick_dead"
	icon_gib = "chick_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("Cherp.","Cherp?","Chirrup.","Cheep!")
	speak_emote = list("cheeps")
	emote_hear = list("cheeps.")
	emote_see = list("pecks at the ground.","flaps its tiny wings.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 2
	butcher_results = list(/obj/item/food/meat/slab/chicken = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 3
	maxHealth = 3
	ventcrawler = VENTCRAWLER_ALWAYS
	var/amount_grown = 0
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chick/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-6, 6)
	pixel_y = base_pixel_y + rand(0, 10)

/mob/living/simple_animal/chick/Life()
	. =..()
	if(!.)
		return
	if(!stat && !ckey)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/chicken(src.loc)
			qdel(src)

/mob/living/simple_animal/chick/holo/Life()
	..()
	amount_grown = 0

/mob/living/simple_animal/chicken
	name = "\improper chicken"
	desc = "Hopefully the eggs are good this season."
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!","Bwaak bwak.")
	speak_emote = list("clucks","croons")
	emote_hear = list("clucks.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/food/meat/slab/chicken = 2)
	var/egg_type = /obj/item/food/egg
	food_type = list(/obj/item/food/grown/wheat)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 15
	maxHealth = 15
	ventcrawler = VENTCRAWLER_ALWAYS
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	var/list/feedMessages = list("It clucks happily.","It clucks happily.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	var/static/chicken_count = 0

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chicken/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/chicken/attackby(obj/item/O, mob/user, params)
	if(is_type_in_list(O, food_type)) //feedin' dem chickens
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, span_warning("[name] doesn't seem hungry!"))
	else
		..()

/mob/living/simple_animal/chicken/Life()
	. =..()
	if(!.)
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message(span_alertalien("[src] [pick(layMessage)]"))
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = E.base_pixel_x + rand(-6,6)
		E.pixel_y = E.base_pixel_y + rand(-6,6)
		if(eggsFertile)
			if(chicken_count < MAX_CHICKENS && prob(25))
				START_PROCESSING(SSobj, E)

/obj/item/food/egg/var/amount_grown = 0
/obj/item/food/egg/process(seconds_per_tick)
	if(isturf(loc))
		amount_grown += rand(1,2) * seconds_per_tick
		if(amount_grown >= 200)
			visible_message(span_notice("[src] hatches with a quiet cracking sound."))
			new /mob/living/simple_animal/chick(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)

//junglefowl
/mob/living/simple_animal/hostile/retaliate/chicken
	name = "\improper junglefowl"
	desc = "A small, fierce, feathered beast."
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!","Bwaak bwak.")
	speak_emote = list("clucks","croons")
	emote_hear = list("clucks.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/food/meat/slab/chicken = 2)
	var/egg_type = /obj/item/food/egg
	food_type = list(/obj/item/food/grown/wheat)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "scratches"
	response_harm_simple = "scratch"
	attack_verb_continuous = "scratches"
	attack_verb_simple = "scratch"
	health = 25
	maxHealth = 25
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	var/list/feedMessages = list("It clucks happily.","It clucks happily.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	var/static/chicken_count = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	melee_damage_lower = 3
	melee_damage_upper = 10

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/retaliate/chicken/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/hostile/retaliate/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/hostile/retaliate/chicken/attackby(obj/item/O, mob/user, params)
	if(is_type_in_list(O, food_type))
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, span_warning("[name] doesn't seem hungry!"))
	else
		..()

/mob/living/simple_animal/hostile/retaliate/chicken/Life()
	. =..()
	if(!.)
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message(span_alertalien("[src] [pick(layMessage)]"))
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = E.base_pixel_x + rand(-6,6)
		E.pixel_y = E.base_pixel_y + rand(-6,6)
		if(eggsFertile)
			if(chicken_count < MAX_CHICKENS && prob(25))
				START_PROCESSING(SSobj, E)


/mob/living/simple_animal/deer
	name = "doe"
	desc = "A gentle, peaceful forest animal. How did this get into space?"
	icon_state = "deer-doe"
	icon_living = "deer-doe"
	icon_dead = "deer-doe-dead"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("Weeeeeeee?","Weeee","WEOOOOOOOOOO")
	speak_emote = list("grunts","grunts lowly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 3)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently nudges"
	response_disarm_simple = "gently nudges aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "bucks"
	attack_verb_simple = "buck"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 75
	maxHealth = 75
	blood_volume = BLOOD_VOLUME_NORMAL
	food_type = list(/obj/item/food/grown/apple)
	footstep_type = FOOTSTEP_MOB_SHOE

//Now that they cant lay eggs I will want to repath these at some point
/mob/living/simple_animal/chicken/rabbit
	name = "\improper rabbit"
	desc = "The hippiest hop around."
	icon = 'icons/mob/easter.dmi'
	icon_state = "b_rabbit"
	icon_living = "b_rabbit"
	icon_dead = "b_rabbit_dead"
	icon_prefix = "b_rabbit"
	speak = list()
	speak_emote = list("sniffles","twitches")
	emote_hear = list("hops.")
	emote_see = list("hops around","bounces up and down")
	butcher_results = list(/obj/item/food/meat/slab = 1)
	food_type = /obj/item/food/grown/carrot
	minbodytemp = 0
	eggsFertile = FALSE
	eggsleft = 0
	egg_type = null
	feedMessages = list("It nibbles happily.","It noms happily.")
	layMessage = list("hides an egg.","scampers around suspiciously.","begins making a huge racket.","begins shuffling.")
