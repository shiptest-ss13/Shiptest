//the base mining mob
/mob/living/simple_animal/hostile/asteroid
	vision_range = 2
	atmos_requirements = IMMUNE_ATMOS_REQS
	faction = list("mining")
	weather_immunities = list("lava","ash")
	obj_damage = 30
	environment_smash = ENVIRONMENT_SMASH_MINERALS
	minbodytemp = 0
	maxbodytemp = INFINITY
	response_harm_continuous = "strikes"
	response_harm_simple = "strike"
	status_flags = 0
	a_intent = INTENT_HARM
	var/mob_trophy
	var/throw_message = "bounces off of"
	var/throw_deflection = 20		//WS edit - Whitesands
	var/from_nest = FALSE
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	mob_size = MOB_SIZE_LARGE
	var/icon_aggro = null
	var/trophy_drop_mod = 25

/mob/living/simple_animal/hostile/asteroid/Initialize(mapload)
	. = ..()
	apply_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)

/mob/living/simple_animal/hostile/asteroid/Aggro()
	..()
	if(vision_range != aggro_vision_range)
		icon_state = icon_aggro

/mob/living/simple_animal/hostile/asteroid/LoseAggro()
	..()
	if(stat == DEAD)
		return
	icon_state = icon_living

/mob/living/simple_animal/hostile/asteroid/bullet_act(obj/projectile/P)//Reduces damage from most projectiles to curb off-screen kills
	if(!stat)
		Aggro()
	/* if(P.damage < 30 && P.damage_type != BRUTE)		//WS Edit Begin - Whitesands
		P.damage = (P.damage / 3)
		visible_message("<span class='danger'>[P] has a reduced effect on [src]!</span>")	*/		//WS Edit End
	..()

/mob/living/simple_animal/hostile/asteroid/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum) //No floor tiling them to death, wiseguy
	if(istype(AM, /obj/item))
		var/obj/item/T = AM
		if(!stat)
			Aggro()
		if(T.throwforce <= throw_deflection)		//WS Edit - Whitesands
			visible_message("<span class='notice'>The [T.name] [throw_message] [src.name]!</span>")
			return
	..()

/mob/living/simple_animal/hostile/asteroid/death(gibbed)
	SSblackbox.record_feedback("tally", "mobs_killed_mining", 1, type)
	if(prob(trophy_drop_mod)) //on average, you'll need to kill 5 creatures before getting the item
		spawn_mob_trophy()
	..(gibbed)

/mob/living/simple_animal/hostile/asteroid/proc/spawn_mob_trophy()
	if(mob_trophy)
		butcher_results[mob_trophy] = 1

/mob/living/simple_animal/hostile/asteroid/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(2)
		throw_alert("temp", /atom/movable/screen/alert/cold, 1)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(20)
		throw_alert("temp", /atom/movable/screen/alert/hot, 3)
	else
		clear_alert("temp")
