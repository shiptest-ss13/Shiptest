/obj/effect/anomaly/transfusion
	name = "transfusion"
	icon_state = "transfusion"
	desc = "A throbbing field floating mid-air, crimson particulate hovering within it."
	density = TRUE
	core = /obj/item/assembly/signaler/anomaly/transfusion
	effectrange = 3
	pulse_delay = 5 SECONDS

/obj/effect/anomaly/transfusion/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	blood_music()
	return

/obj/effect/anomaly/transfusion/proc/blood_music() //by greg bear
	//this is hacky *because* in an ideal world - it would involve making the core have a reagent container for the blood
	//however - I am a lazy bitch
	for(var/mob/living/carbon/victim in range(effectrange, src))
		//if we're not hungry, we're not hungry.
		if (core?:get_blood_max() < core?:get_blood_stored())
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(src.loc, rand(1, 8))
			visible_message(span_boldwarning("[src] vomits up blood, seemingly satiated!"))
			core?:set_blood_stored(core?:get_blood_max())
			return
		//if there's blood to take, take it
		if (victim.blood_volume > BLOOD_VOLUME_SAFE)
			var/bleeder
			bleeder = rand(10,30)
			victim.bleed(bleeder)
			victim.spray_blood(get_dir(victim, src), splatter_strength = 1) //slurp
			visible_message(span_boldwarning("Ichor flows out of [victim], and into [src]!"))
			core?:set_blood_stored(bleeder)
			break
		//but if there's blood to give, share.
		if(victim.blood_volume < BLOOD_VOLUME_SAFE && core?:get_blood_stored() > (core?:get_blood_max() / 2))
			var/present_time
			present_time = rand((core?:get_blood_stored() / 10), (core?:get_blood_stored() / 2))
			visible_message(span_boldwarning("Globules of ichor fly away from [src], and into [victim]!"))
			core?:set_blood_stored(-present_time)
			victim.blood_volume += present_time
			break
	return

/obj/effect/anomaly/transfusion/Bumped(atom/movable/AM)
	if(!COOLDOWN_FINISHED(src, pulse_secondary_cooldown))
		return
	COOLDOWN_START(src, pulse_secondary_cooldown, 10)
	if(istype(AM, /mob/living/carbon))
		var/mob/living/carbon/victim = AM
		visible_message(span_boldwarning("[victim] touches [src], and as they pull away their blood flows away from them!"))
		var/amount = rand(50, 200)
		victim.bleed(amount)
		core?:set_blood_stored(amount)

/obj/effect/anomaly/transfusion/detonate()
	for(var/mob/living/carbon/victim in range(effectrange, src))
		victim.bleed(rand(100, 250))
		victim.spray_blood(get_dir(src, victim), splatter_strength = 3) //slurp
	visible_message(span_boldwarning("[src] screams as it tries to pull all the blood around into itself!"))
	. = ..()

/obj/effect/anomaly/transfusion/planetary
	immortal = TRUE
	immobile = TRUE
