/obj/effect/anomaly/flux
	name = "tesla"
	icon_state = "flux"
	desc = "A mysterious anomaly that sends out a near constant stream of electrical arcs."
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/flux
	pulse_delay = 2 SECONDS
	effectrange = 0
	var/canshock = FALSE
	var/shockdamage = 20
	var/explosive = FLUX_EXPLOSIVE
	var/zap_range = 1
	var/zap_power = 1500
	var/zap_flags = ZAP_MOB_DAMAGE

/obj/effect/anomaly/flux/Initialize(mapload, new_lifespan, drops_core = TRUE, explosive = FLUX_EXPLOSIVE)
	. = ..()
	src.explosive = explosive
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/anomaly/flux/anomalyEffect()
	..()
	canshock = TRUE
	for(var/mob/living/Mob in range(effectrange, src))
		mobShock(Mob)

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	tesla_zap(src, zap_range, zap_power, zap_flags)

/obj/effect/anomaly/flux/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	mobShock(AM)
	tesla_zap(src, zap_range, zap_power, zap_flags)
	new /obj/effect/particle_effect/sparks(loc)

/obj/effect/anomaly/flux/Bump(atom/Atom)
	mobShock(Atom)
	tesla_zap(src, zap_range, zap_power, zap_flags)

/obj/effect/anomaly/flux/Bumped(atom/movable/AM)
	mobShock(AM)
	tesla_zap(src, zap_range, zap_power, zap_flags)

/obj/effect/anomaly/flux/proc/mobShock(mob/living/Mob)
	if(canshock && istype(Mob))
		canshock = FALSE
		Mob.electrocute_act(shockdamage, name, flags = SHOCK_NOGLOVES)

/obj/effect/anomaly/flux/detonate()
	switch(explosive)
		if(FLUX_EXPLOSIVE)
			explosion(src, devastation_range = 1, heavy_impact_range = 4, light_impact_range = 16, flash_range = 18) //Low devastation, but hits a lot of stuff.
		if(FLUX_LOW_EXPLOSIVE)
			explosion(src, heavy_impact_range = 1, light_impact_range = 4, flash_range = 6)
		if(FLUX_NO_EXPLOSION)
			new /obj/effect/particle_effect/sparks(loc)

	. = ..()

/obj/effect/anomaly/flux/minor/Initialize(mapload, new_lifespan, drops_core = FALSE, explosive = FLUX_NO_EXPLOSION)
	return ..()


/obj/effect/anomaly/flux/big
	immortal = TRUE
	shockdamage = 30
	pulse_delay = 2
	effectrange = 1

	zap_range = 2
	zap_power = 3000
	zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE

/obj/effect/anomaly/flux/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 1.5


/obj/effect/anomaly/flux/big/Bumped(atom/movable/bumpee)
	. = ..()

	if(isliving(bumpee))
		new /obj/effect/particle_effect/sparks(loc)

/obj/effect/anomaly/flux/planetary
	immortal = TRUE
	immobile = TRUE

/obj/effect/anomaly/flux/big/planetary
	immortal = TRUE
	immobile = TRUE
