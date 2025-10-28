/obj/structure/spawner/hivebot
	name = "hivebot fabricator"
	desc = "An active fabrication plant, electrical tendrils reaching into the ground searching for scrap metals, a hunger permeating the world around it."

	icon = 'icons/obj/machines/bsm.dmi'
	icon_state = "bsm_on"

	faction = list("hivebot")
	max_integrity = 250
	mob_types = list(
		/mob/living/basic/hivebot = 40,
		/mob/living/basic/hivebot/ranged = 40,
		/mob/living/basic/hivebot/rapid = 10,
		/mob/living/basic/hivebot/strong = 5,
		/mob/living/basic/hivebot/mechanic = 5,
		/mob/living/basic/hivebot/core = 1,
	)
	spawn_text = "emerges from within"
	spawn_sound = list('sound/effects/suitstep2.ogg')
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	var/obj/effect/light_emitter/hivespawner/emitted_light

/obj/structure/spawner/hivebot/Initialize()
	. = ..()
	emitted_light = new(loc)

/obj/structure/spawner/hivebot/deconstruct(disassembled)
	destroy_effect()
	drop_loot()
	return ..()

/obj/structure/spawner/hivebot/Destroy()
	QDEL_NULL(emitted_light)
	return ..()

/obj/structure/spawner/hivebot/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message(span_boldannounce("[src] begins to rattle and shake, sparks flying off of it!"))


/obj/structure/spawner/hivebot/proc/drop_loot()
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(2, loc)
	smoke.start()
	new /obj/effect/particle_effect/sparks(loc)
	new /obj/effect/spawner/random/waste/hivebot/beacon(loc)

/obj/effect/light_emitter/hivespawner
	set_luminosity = 4
	set_cap = 2.5
	light_color = COLOR_RED_LIGHT
