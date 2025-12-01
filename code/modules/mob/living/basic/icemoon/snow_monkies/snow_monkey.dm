// japanese macaque but also japan fucking expoloded and macaque has too many oppurtinuty s for penis jokes
/mob/living/basic/snow_monkey
	name = "snow monkey"
	desc = "Often found in cold planets, snow monkeys are friendly animals with odd behaviors such as rolling snowballs or bathing in hot springs."
	icon = 'icons/mob/basic/snow_monkey.dmi'
	icon_state = "snow_monkey"
	icon_dead = "snow_monkey_dead"

	minimum_survivable_temperature = 170

	ai_controller = /datum/ai_controller/basic_controller/snow_monkey

/mob/living/basic/snow_monkey/Initialize(mapload)
	. = ..()
	if(gender == FEMALE)
		icon_state = "snow_monkey_butt"
		icon_dead = "snow_monkey_butt_dead"

// Copied from mouse. But could definitly be handled better tbh.
/mob/living/basic/snow_monkey/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(!.)
		return

	if(!proximity_flag)
		return

	if(istype(attack_target, /obj/structure/flora/ash/garden))
		try_harvest_garden(attack_target)
		return TRUE

/mob/living/basic/snow_monkey/proc/try_harvest_garden(obj/structure/flora/ash/garden)
	if(!garden.harvested)
		visible_message(
			span_notice("[src] muches on berries from [garden]."),
			span_notice("You eat some berries from [garden][health < maxHealth ? ", restoring your health" : ""].")
		)
		adjust_health(-5)
		garden.harvest(src)
