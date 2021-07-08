// put race-unique effects here

//Ethereal
/datum/component/swimming/ethereal/enter_pool()
	var/mob/living/L = parent
	L.visible_message("<span class='warning'>Sparks of energy begin coursing around the pool!</span>")

/datum/component/swimming/ethereal/process()
	..()
	var/mob/living/L = parent
	if(prob(2) && L.nutrition > NUTRITION_LEVEL_FED)
		L.adjust_nutrition(-50)
		tesla_zap(L, 7, 2000, ZAP_MOB_STUN)
		playsound(L, 'sound/machines/defib_zap.ogg', 50, TRUE)

//Golem
/datum/component/swimming/golem/enter_pool()
	var/mob/living/M = parent
	M.Paralyze(60)
	M.visible_message("<span class='warning'>[M] crashed violently into the ground!</span>",
		"<span class='warning'>You sink like a rock!</span>")
	playsound(get_turf(M), 'sound/effects/picaxe1.ogg')

/datum/component/swimming/golem/is_drowning()
	return FALSE

/Squid
/datum/component/swimming/squid
	slowdown = 0.7

/datum/component/swimming/squid/enter_pool()
	to_chat(parent, "<span class='notice'>You feel at ease in your natural habitat!</span>")

/datum/component/swimming/squid/is_drowning(mob/living/victim)
	return FALSE
