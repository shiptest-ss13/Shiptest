/obj/effect/anomaly/melter
	name = "melter"
	icon_state = "melter"
	desc = "A mysterious anomaly. Everburning green flames with a horrid sizzle, melting what's near"
	effectrange = 4
	pulse_delay = 15
	aSignal = /obj/item/assembly/signaler/anomaly/pyro

/obj/effect/anomaly/melter/anomalyEffect(seconds_per_tick)
	..()


	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return
	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/meltee in range(effectrange, src))
		for(var/X in meltee.get_equipped_items())
			var/obj/item/I = X
			I.acid_level += 3

/obj/effect/anomaly/melter/Bumped(atom/movable/AM)
	if(isobj(AM))
		var/obj/acid = AM
		if(acid.resistance_flags & ACID_PROOF)
			acid.resistance_flags &= ~ACID_PROOF
		if(acid.armor.acid > 50) //*Me copies from lava code
			acid.armor = acid.armor.setRating(fire = 50)
		acid.acid_act(100,20)


/obj/effect/anomaly/melter/detonate()
	for(var/mob/living/carbon/meltee in range(effectrange, src))
		for(var/X in meltee.get_equipped_items())
			var/obj/item/I = X
			I.acid_level += 20
	for(var/obj/item in range(effectrange, src))
		item.acid_act(100,20)
	. = ..()


/obj/effect/anomaly/melter/planetary
	immortal = TRUE
	immobile = TRUE
