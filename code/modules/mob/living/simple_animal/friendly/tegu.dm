/mob/living/simple_animal/hostile/retaliate/tegu
	name = "tegu"
	desc = "Thats a tegu."
	icon = 'icons/mob/pets.dmi'
	icon_state = "tegu"
	icon_living = "tegu"
	icon_dead ="tegu_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("waits apprehensively.", "walks around.")
	speak_chance = 1
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "rolls over"
	response_disarm_simple = "roll over"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	melee_damage_lower = 18
	melee_damage_upper = 22
	health = 75
	maxHealth = 75
	speed = 5
	footstep_type = FOOTSTEP_MOB_CLAW
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	var/obj/item/clothing/head/caphat/current_hat
	var/obj/item/card/id/captains_spare/current_id

/mob/living/simple_animal/hostile/retaliate/tegu/atlas
	name = "Atlas"
	desc = "That's the captain's small, but mighty pet tegu. They might have the blood of greytiders on them."
	gender = MALE
	gold_core_spawnable = NO_SPAWN

/mob/living/simple_animal/hostile/retaliate/tegu/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!(user.a_intent == INTENT_HELP))
		return
	if(!user.transferItemToLoc(I, src))
		to_chat(user, "<span class='warning'>[I] is stuck to your hand.</span>")
		return

	if(istype(I, /obj/item/clothing/head/caphat))
		if(current_hat)
			to_chat(user, "<span class='warning'>[src] already has a hat!</span>")
		to_chat(user, "<span class='notice'>You put on the [I] on \the [src].</span>")
		current_hat = I
		update_icon()

	if(istype(I, /obj/item/card/id/captains_spare))
		if(current_id)
			to_chat(user, "<span class='warning'>[src] is already protecting [current_id]!</span>")
		to_chat(user, "<span class='notice'>You put the [I] in \the [src]'s mouth. Perfect. [src] will keep this safe.</span>")
		current_id = I
		update_icon()

/mob/living/simple_animal/hostile/retaliate/tegu/death(gibbed)
	. = ..()
	var/atom/tegu_turf = drop_location()
	if(current_hat)
		current_hat.forceMove(tegu_turf)
		current_hat = null

	if(current_id)
		current_id.forceMove(tegu_turf)
		current_id = null
	update_icon()

/mob/living/simple_animal/hostile/retaliate/tegu/update_overlays()
	. = ..()
	if(current_hat)
		. += "captain_overlay"
	if(current_id)
		. += "spare_id_overlay"
