/obj/effect/mine
	name = "dummy mine"
	desc = "Better stay away from that thing."
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "uglymine"
	var/triggered = 0

/obj/effect/mine/proc/mineEffect(mob/victim)
	to_chat(victim, "<span class='danger'>*click*</span>")

/obj/effect/mine/Crossed(AM as mob|obj)
	. = ..()
	if(isturf(loc))
		if(ismob(AM))
			var/mob/MM = AM
			if(!(MM.movement_type & FLYING))
				triggermine(AM)
		else
			triggermine(AM)

/obj/effect/mine/proc/triggermine(mob/victim)
	if(triggered)
		return
	visible_message("<span class='danger'>[victim] sets off [icon2html(src, viewers(src))] [src]!</span>")
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	mineEffect(victim)
	SEND_SIGNAL(src, COMSIG_MINE_TRIGGERED)
	triggered = 1
	qdel(src)


/obj/effect/mine/explosive
	name = "explosive mine"
	var/range_devastation = 0
	var/range_heavy = 1
	var/range_light = 2
	var/range_flash = 3

/obj/effect/mine/explosive/mineEffect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash)

/obj/effect/mine/stun
	name = "stun mine"
	var/stun_time = 80

/obj/effect/mine/shrapnel
	name = "shrapnel mine"
	var/shrapnel_type = /obj/projectile/bullet/shrapnel
	var/shrapnel_magnitude = 3

/obj/effect/mine/shrapnel/mineEffect(mob/victim)
	AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_magnitude)

/obj/effect/mine/shrapnel/human_only
	name = "sophisticated shrapnel mine"
	desc = "A deadly mine, this one seems to be modified to trigger for humans only?"

/obj/effect/mine/shrapnel/human_only/Crossed(atom/movable/AM)
	if(!ishuman(AM))
		return
	. = ..()

/obj/effect/mine/shrapnel/sting
	name = "stinger mine"
	shrapnel_type = /obj/projectile/bullet/pellet/stingball

/obj/effect/mine/stun/mineEffect(mob/living/victim)
	if(isliving(victim))
		victim.Paralyze(stun_time)

/obj/effect/mine/kickmine
	name = "kick mine"

/obj/effect/mine/kickmine/mineEffect(mob/victim)
	if(isliving(victim) && victim.client)
		to_chat(victim, "<span class='userdanger'>You have been kicked FOR NO REISIN!</span>")
		qdel(victim.client)


/obj/effect/mine/gas
	name = "oxygen mine"
	var/gas_amount = 360
	var/gas_type = "o2"

/obj/effect/mine/gas/mineEffect(mob/victim)
	atmos_spawn_air("[gas_type]=[gas_amount]")


/obj/effect/mine/gas/plasma
	name = "plasma mine"
	gas_type = "plasma"


/obj/effect/mine/gas/n2o
	name = "\improper N2O mine"
	gas_type = "n2o"


/obj/effect/mine/gas/water_vapor
	name = "chilled vapor mine"
	gas_amount = 500
	gas_type = "water_vapor"

/obj/effect/mine/sound
	name = "honkblaster 1000"
	var/sound = 'sound/items/bikehorn.ogg'

/obj/effect/mine/sound/mineEffect(mob/victim)
	playsound(loc, sound, 100, TRUE)


/obj/effect/mine/sound/bwoink
	name = "bwoink mine"
	sound = 'sound/effects/adminhelp.ogg'

/obj/effect/mine/pickup
	name = "pickup"
	desc = "pick me up"
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity2"
	density = FALSE
	var/duration = 0

/obj/effect/mine/pickup/Initialize()
	. = ..()
	animate(src, pixel_y = 4, time = 20, loop = -1)

/obj/effect/mine/pickup/triggermine(mob/victim)
	if(triggered)
		return
	triggered = 1
	invisibility = INVISIBILITY_ABSTRACT
	mineEffect(victim)
	qdel(src)


/obj/effect/mine/pickup/bloodbath
	name = "Red Orb"
	desc = "You feel angry just looking at it."
	duration = 1200 //2min
	color = "#FF0000"
	var/mob/living/doomslayer
	var/obj/item/chainsaw/doomslayer/chainsaw

/obj/effect/mine/pickup/bloodbath/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='reallybig redtext'>RIP AND TEAR</span>")

	INVOKE_ASYNC(src, .proc/blood_delusion, victim)

	chainsaw = new(victim.loc)
	victim.log_message("entered a blood frenzy", LOG_ATTACK)

	ADD_TRAIT(chainsaw, TRAIT_NODROP, CHAINSAW_FRENZY_TRAIT)
	victim.drop_all_held_items()
	victim.put_in_hands(chainsaw, forced = TRUE)
	chainsaw.attack_self(victim)
	victim.reagents.add_reagent(/datum/reagent/medicine/adminordrazine,25)
	to_chat(victim, "<span class='warning'>KILL, KILL, KILL! YOU HAVE NO ALLIES ANYMORE, KILL THEM ALL!</span>")

	var/datum/client_colour/colour = victim.add_client_colour(/datum/client_colour/bloodlust)
	QDEL_IN(colour, 11)
	doomslayer = victim
	RegisterSignal(src, COMSIG_PARENT_QDELETING, .proc/end_blood_frenzy)
	QDEL_IN(WEAKREF(src), duration)

/obj/effect/mine/pickup/bloodbath/proc/end_blood_frenzy()
	if(doomslayer)
		to_chat(doomslayer, "<span class='notice'>Your bloodlust seeps back into the bog of your subconscious and you regain self control.</span>")
		doomslayer.log_message("exited a blood frenzy", LOG_ATTACK)
	if(chainsaw)
		qdel(chainsaw)

/obj/effect/mine/pickup/bloodbath/proc/blood_delusion(mob/living/carbon/victim)
	new /datum/hallucination/delusion(victim, TRUE, "demon", duration, 0)

/obj/effect/mine/pickup/healing
	name = "Blue Orb"
	desc = "You feel better just looking at it."
	color = "#0000FF"

/obj/effect/mine/pickup/healing/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='notice'>You feel great!</span>")
	victim.revive(full_heal = TRUE, admin_revive = TRUE)

/obj/effect/mine/pickup/speed
	name = "Yellow Orb"
	desc = "You feel faster just looking at it."
	color = "#FFFF00"
	duration = 300

/obj/effect/mine/pickup/speed/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='notice'>You feel fast!</span>")
	victim.add_movespeed_modifier(/datum/movespeed_modifier/yellow_orb)
	sleep(duration)
	victim.remove_movespeed_modifier(/datum/movespeed_modifier/yellow_orb)
	to_chat(victim, "<span class='notice'>You slow down.</span>")
