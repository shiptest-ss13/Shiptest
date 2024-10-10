/obj/effect/anomaly/plasmasoul
	name = "plasma soul"
	icon_state = "plasmasoul"
	desc = "A plasmatic pool, small crystals growing around it, spreading into the ground."
	density = TRUE
	core = /obj/item/assembly/signaler/anomaly/plasmasoul
	effectrange = 3
	pulse_delay = 6 SECONDS
	var/reagent_amount = 5

/obj/effect/anomaly/plasmasoul/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	harm_surrounding_mobs()

/obj/effect/anomaly/plasmasoul/Bumped(atom/movable/AM)
	var/turf/open/spot = locate(rand(src.x-effectrange, src.x+effectrange), rand(src.y-effectrange, src.y+effectrange), src.z)
	harm_surrounding_mobs()
	if(istype(spot))
		spot.atmos_spawn_air("plasma=300;TEMP=200")

/obj/effect/anomaly/plasmasoul/proc/harm_surrounding_mobs()
	for(var/mob/living/carbon/human/H in range(effectrange, src))

		if(!(H.dna?.species.reagent_tag & PROCESS_ORGANIC))
			H.adjustFireLoss(20)
			to_chat(H, span_warning("Something bubbles and hisses under your plating..."))
			playsound(H, 'sound/items/welder.ogg', 150)
			continue

		H.reagents?.add_reagent(/datum/reagent/toxin/plasma, reagent_amount)
		to_chat(H, span_warning("Your blood feels thick..."))
		playsound(H, 'sound/effects/bubbles.ogg', 50)

/obj/effect/anomaly/plasmasoul/detonate()
	for(var/mob/living/carbon/human/H in range(effectrange*2, src))
		if(H.run_armor_check(attack_flag = "bio") <= 40)
			continue

		if(!(H.dna?.species.reagent_tag & PROCESS_ORGANIC))
			H.adjustFireLoss(60)
			to_chat(H, span_warning("Plasma flashes and ignites inside of your chassis!"))
			playsound(H, 'sound/items/welder.ogg', 150)
			continue

		H.reagents?.add_reagent(/datum/reagent/toxin/plasma, reagent_amount*3)
		to_chat(H, span_warning("Your blood thickens and bubbles in your veins!"))
		playsound(H, 'sound/effects/bubbles.ogg', 50)

	var/turf/open/tile = get_turf(src)

	if(istype(tile))
		tile.atmos_spawn_air("o2=600;plasma=3000;TEMP=2000")

	return ..()

/obj/effect/anomaly/plasmasoul/planetary
	immortal = TRUE
	immobile = TRUE
