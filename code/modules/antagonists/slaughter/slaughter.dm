//////////////////The Monster

/mob/living/simple_animal/slaughter
	name = "slaughter demon"
	real_name = "slaughter demon"
	desc = "A large, menacing creature covered in armored black scales."
	speak_emote = list("gurgles")
	emote_hear = list("wails","screeches")
	response_help_continuous = "thinks better of touching"
	response_help_simple = "think better of touching"
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	icon = 'icons/mob/mob.dmi'
	icon_state = "daemon"
	icon_living = "daemon"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speed = 1
	a_intent = INTENT_HARM
	stop_automated_movement = 1
	status_flags = CANPUSH
	attack_sound = 'sound/magic/demon_attack1.ogg'
	var/feast_sound = 'sound/magic/demon_consume.ogg'
	deathsound = 'sound/magic/demon_dies.ogg'
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = INFINITY
	faction = list("slaughter")
	attack_verb_continuous = "wildly tears into"
	attack_verb_simple = "wildly tear into"
	maxHealth = 200
	health = 200
	healable = 0
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	obj_damage = 50
	melee_damage_lower = 30
	melee_damage_upper = 30
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	var/playstyle_string = "<span class='big bold'>You are a slaughter demon,</span><B> a terrible creature from another realm. You have a single desire: To kill. \
							You may use the \"Blood Crawl\" ability near blood pools to travel through them, appearing and disappearing from the station at will. \
							Pulling a dead or unconscious mob while you enter a pool will pull them in with you, allowing you to feast and regain your health. \
							You move quickly upon leaving a pool of blood, but the material world will soon sap your strength and leave you sluggish. </B>"

	loot = list(/obj/effect/decal/cleanable/blood, \
				/obj/effect/decal/cleanable/blood/innards, \
				/obj/item/organ/heart/demon)
	del_on_death = 1
	deathmessage = "screams in anger as it collapses into a puddle of viscera!"

/mob/living/simple_animal/slaughter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_BLOODCRAWL_EAT, "innate")
	var/obj/effect/proc_holder/spell/bloodcrawl/bloodspell = new
	AddSpell(bloodspell)
	if(istype(loc, /obj/effect/dummy/phased_mob/slaughter))
		bloodspell.phased = TRUE

/obj/effect/decal/cleanable/blood/innards
	name = "pile of viscera"
	desc = "A repulsive pile of guts and gore."
	gender = NEUTER
	icon = 'icons/obj/surgery.dmi'
	icon_state = "innards"
	random_icon_states = null

/mob/living/simple_animal/slaughter/phasein()
	. = ..()
	add_movespeed_modifier(/datum/movespeed_modifier/slaughter)
	addtimer(CALLBACK(src, PROC_REF(remove_movespeed_modifier), /datum/movespeed_modifier/slaughter), 6 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

//The loot from killing a slaughter demon - can be consumed to allow the user to blood crawl
/obj/item/organ/heart/demon
	name = "demon heart"
	desc = "Still it beats furiously, emanating an aura of utter hate."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "demon_heart-on"
	decay_factor = 0

/obj/item/organ/heart/demon/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/heart/demon/attack(mob/M, mob/living/carbon/user, obj/target)
	if(M != user)
		return ..()
	user.visible_message(
		span_warning("[user] raises [src] to [user.p_their()] mouth and tears into it with [user.p_their()] teeth!"), \
		span_danger("An unnatural hunger consumes you. You raise [src] your mouth and devour it!"))
	playsound(user, 'sound/magic/demon_consume.ogg', 50, TRUE)
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == /obj/effect/proc_holder/spell/bloodcrawl)
			to_chat(user, span_warning("...and you don't feel any different."))
			qdel(src)
			return
	user.visible_message(
		span_warning("[user]'s eyes flare a deep crimson!"), \
		span_userdanger("You feel a strange power seep into your body... you have absorbed the demon's blood-travelling powers!"))
	user.temporarilyRemoveItemFromInventory(src, TRUE)
	src.Insert(user) //Consuming the heart literally replaces your heart with a demon heart. H A R D C O R E

/obj/item/organ/heart/demon/Insert(mob/living/carbon/M, special = 0)
	..()
	if(M.mind)
		M.mind.AddSpell(new /obj/effect/proc_holder/spell/bloodcrawl(null))

/obj/item/organ/heart/demon/Remove(mob/living/carbon/M, special = 0)
	..()
	if(M.mind)
		M.mind.RemoveSpell(/obj/effect/proc_holder/spell/bloodcrawl)

/obj/item/organ/heart/demon/Stop()
	return 0 // Always beating.
