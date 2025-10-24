///Base anomaly signaller
// Embedded signaller used in anomalies.
/obj/item/assembly/signaler/anomaly
	name = "anomaly core"
	desc = "The stabilized core of an anomaly. It'd probably be valuable for research."
	icon_state = "anomaly core"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	resistance_flags = FIRE_PROOF
	//allows anomaly cores to recieve multiple signals
	var/code_b = DEFAULT_SIGNALER_CODE
	var/anomaly_type = /obj/effect/anomaly
	var/research

/obj/item/assembly/signaler/anomaly/Initialize()
	. = ..()
	set_frequency(frequency)

/obj/item/assembly/signaler/anomaly/attack_self()
	return

/obj/item/assembly/signaler/anomaly/receive_signal(datum/signal/signal)
	if(!signal)
		return FALSE
	if(signal.data["code"] == code)
		for(var/obj/effect/anomaly/Anomaly in get_turf(src))
			Anomaly.anomalyNeutralize()
			return TRUE
	if(signal.data["code"] == code_b )
		for(var/obj/effect/anomaly/Anomaly in get_turf(src))
			Anomaly.detonate()
		anomaly_core_detonation()
		return TRUE
	return FALSE

//extend this on a per anomaly basis.
/obj/item/assembly/signaler/anomaly/proc/anomaly_core_detonation()
	new /obj/effect/particle_effect/smoke/bad(loc)
	qdel(src)

/obj/item/assembly/signaler/anomaly/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_ANALYZER)
		to_chat(user, span_notice("Analyzing... [src]'s stabilized field is fluctuating along frequency [format_frequency(frequency)], code [code]. An unstable frequency is present at code [code_b]."))
	..()

///Bluespace Anomaly
/obj/item/assembly/signaler/anomaly/bluespace
	name = "\improper bluespace anomaly core"
	desc = "The stabilized core of a bluespace anomaly. It keeps phasing in and out of view."
	icon_state = "anomaly core"
	grind_results = list(/datum/reagent/bluespace = 25)

/obj/item/assembly/signaler/anomaly/bluespace/anomaly_core_detonation()
	//just teleports people
	visible_message(span_warning("[src] creates a bluespace fracture around itself!"))
	for(var/mob/living/Mob in range(1,src))
		do_teleport(Mob, locate(Mob.x, Mob.y, Mob.z), 8, channel = TELEPORT_CHANNEL_BLUESPACE)
	..()

//Flux Anomaly
/obj/item/assembly/signaler/anomaly/flux
	name = "\improper flux anomaly core"
	desc = "The stabilized core of a flux anomaly. Touching it makes your skin tingle."
	icon_state = "flux core"
	grind_results = list(/datum/reagent/teslium = 15)

/obj/item/assembly/signaler/anomaly/flux/anomaly_core_detonation()
	//zap
	visible_message(span_warning("Electrical arcs flash off of [src] as it fizzles out!"))
	tesla_zap(src, 5, 7000, ZAP_FUSION_FLAGS)
	..()

///Gravity Anomaly
/obj/item/assembly/signaler/anomaly/grav
	name = "\improper gravitational anomaly core"
	desc = "The stabilized core of a gravitational anomaly. It feels much heavier than it looks."
	icon_state = "grav core"
	grind_results = list(/datum/reagent/gravitum = 20, /datum/reagent/liquid_dark_matter = 10)

/obj/item/assembly/signaler/anomaly/grav/anomaly_core_detonation()
	//throngles u cutely
	visible_message(span_warning("[src] implodes into itself, light itself bending for a split second!"))
	for(var/mob/living/carbon/carbon in range(1,src))
		carbon.apply_damage(30, BRUTE)
	..()

///Hallucination Anomaly
/obj/item/assembly/signaler/anomaly/hallucination
	name = "\improper hallucination anomaly core"
	desc = "The stabilized core of a hallucination anomaly. It's never entirely there."
	icon_state = "hallucination_core"
	grind_results = list(/datum/reagent/toxin/mindbreaker = 20) //LSD orb

///Heartbeat Anomaly
/obj/item/assembly/signaler/anomaly/heartbeat
	name = "\improper heartbeat anomaly core"
	desc = "The stabilized core of a heartbeat anomaly. Pulses of heat run across its shell."
	grind_results = list(/datum/reagent/uranium/radium = 30, /datum/reagent/uranium = 20)

/obj/item/assembly/signaler/anomaly/heartbeat/anomaly_core_detonation()
	visible_message(span_warning("[src] expands and throbs, before shattering into dozens of fragments!"))
	radiation_pulse(src, 1000, 3)
	new /obj/effect/decal/cleanable/glass/strange(src)
	..()

///Melter Anomaly
/obj/item/assembly/signaler/anomaly/melter
	name = "\improper melter anomaly core"
	desc = "The stabilized core of a melter anomaly. It sizzles and crackles."
	icon_state = "pyro core"
	grind_results = list(/datum/reagent/toxin/acid/nitracid = 10, /datum/reagent/toxin/acid/fluacid = 10, /datum/reagent/toxin/acid = 10) //soup

/obj/item/assembly/signaler/anomaly/melter/anomaly_core_detonation()
	visible_message(span_warning("[src] melts into a glowing residue!"))
	new /obj/effect/decal/cleanable/greenglow(src.loc)
	..()

///Phantom Anomaly
/obj/item/assembly/signaler/anomaly/phantom
	name = "\improper phantom anomaly core"
	desc = "The stabilized core of a phantom anomaly. It quietly screams."
	grind_results = list(/datum/reagent/blood = 20)

/obj/item/assembly/signaler/anomaly/phantom/anomaly_core_detonation()
	playsound(src,'sound/hallucinations/far_noise.ogg', 100, 0, 50, TRUE, TRUE)
	visible_message(span_warning("[src] screams as it fades, trying to lash out!"))
	for(var/mob/living/carbon/handsy in range(5, src))
		if(handsy.stat != DEAD)
			var/grab_dir = turn(handsy.dir, pick(-90, 90, 180, 180))
			var/turf/spawn_turf = get_ranged_target_turf(handsy, grab_dir, 8)
			if(!spawn_turf)
				return
			new /obj/effect/temp_visual/dir_setting/curse/grasp_portal(spawn_turf, handsy.dir)
			playsound(spawn_turf, 'sound/effects/curse2.ogg', 80, TRUE, -1)
			var/obj/projectile/curse_hand/phantom/hand = new (spawn_turf)
			hand.preparePixelProjectile(handsy, spawn_turf)
			if(QDELETED(hand))
				return
			hand.fire()
	..()

///Plasmasoul Anomaly
/obj/item/assembly/signaler/anomaly/plasmasoul
	name = "\improper plasmasoul anomaly core"
	desc = "The stabilized core of a plasmasoul anomaly. The air around it hisses."
	grind_results = list(/datum/reagent/toxin/plasma = 50)

/obj/item/assembly/signaler/anomaly/plasmasoul/anomaly_core_detonation()
	visible_message(span_warning("[src] rapidly delaminates into plasma!"))
	atmos_spawn_air("plasma=500;TEMP=[T20C]")
	..()

///Pulsar Anomaly
/obj/item/assembly/signaler/anomaly/pulsar
	name = "\improper pulsar anomaly core"
	desc = "The stabilized core of a pulsar anomaly. Electromagnetic crackles come off it."
	grind_results = list(/datum/reagent/iron = 25, /datum/reagent/uranium = 25)

/obj/item/assembly/signaler/anomaly/pulsar/anomaly_core_detonation()
	visible_message(span_warning("[src] gives off one last pulse as it melts!"))
	empulse(loc, 3, 1)
	..()

///Pyroclastic Anomaly
/obj/item/assembly/signaler/anomaly/pyro
	name = "\improper plasmaball anomaly core"
	desc = "The stabilized core of a plasmaball anomaly. It almost burns to touch."
	icon_state = "pyro core"
	grind_results = list(/datum/reagent/clf3 = 25, /datum/reagent/toxin/plasma = 15)

//glorified molotov
/obj/item/assembly/signaler/anomaly/pyro/anomaly_core_detonation()
	//this is tg's ash heretic ash heretic ascenscion power tuned down a bit.
	visible_message(span_warning("[src] loses coherence, bursting into brilliant flames!"))
	for(var/i in 0 to 3)
		for(var/turf/nearby_turf as anything in spiral_range_turfs(i + 1, src.loc))
			var/obj/effect/hotspot/flame_tile = locate(nearby_turf) || new(nearby_turf)
			flame_tile.alpha = 125
			nearby_turf.hotspot_expose(750, 25, 1)
	qdel(src)

///Sparkler Anomaly
/obj/item/assembly/signaler/anomaly/sparkler
	name = "\improper sparkler anomaly core"
	desc = "The stabilized core of a sparkler anomaly. Tiny electrical sparks arc off it."
	grind_results = list(/datum/reagent/teslium = 10)

/obj/item/assembly/signaler/anomaly/sparkler/anomaly_core_detonation()
	visible_message(span_warning("[src] shoots out one last assortment of sparks!"))
	tesla_zap(src, 2, 5000, ZAP_FUSION_FLAGS)
	..()

///Static Anomaly
/obj/item/assembly/signaler/anomaly/tvstatic
	name = "\improper static anomaly core"
	desc = "The stabilized core of a static anomaly. Your head hurts just staring at it"
	grind_results = list(/datum/reagent/three_eye = 5)

/obj/item/assembly/signaler/anomaly/tvstatic/anomaly_core_detonation()
	visible_message(span_warning("[src] withdraws into itself, one last message escaping it!"))
	say(pick(GLOB.tvstatic_sayings))
	for(var/mob/living/carbon/human/looking in range(4, src))
		if (!HAS_TRAIT(looking, TRAIT_MINDSHIELD) && looking.stat != DEAD)
			looking.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20, 40)
			playsound(src, 'sound/effects/stall.ogg', 100)
	..()

///Transfusion Anomaly
/obj/item/assembly/signaler/anomaly/transfusion
	name = "\improper transfusion anomaly core"
	desc = "The stabilized core of a tranfusion anomaly. Crimson slowly seeps out of the containment unit."
	icon_state = "pyro core"
	grind_results = list(/datum/reagent/toxin/heparin = 15, /datum/reagent/blood = 35)
	var/blood_stored
	var/blood_max

/obj/item/assembly/signaler/anomaly/transfusion/Initialize()
	. = ..()
	blood_max = rand(400, 1200)

/obj/item/assembly/signaler/anomaly/transfusion/proc/set_blood_stored(int)
	blood_stored += int

/obj/item/assembly/signaler/anomaly/transfusion/proc/set_blood_max(int)
	blood_max = int

/obj/item/assembly/signaler/anomaly/transfusion/proc/get_blood_stored()
	return blood_stored

/obj/item/assembly/signaler/anomaly/transfusion/proc/get_blood_max()
	return blood_max

/obj/item/assembly/signaler/anomaly/transfusion/anomaly_core_detonation()
	visible_message(span_warning("Ichor flies out of [src], trying to force itself into everything around!"))
	while(blood_stored > 0)
		for(var/mob/living/carbon/victim in range(2, src))
			var/present_time
			present_time = rand((blood_stored / 10), (blood_stored / 2))
			visible_message(span_boldwarning("[victim] finds themselves transfused with the crimson ichor!"))
			victim.blood_volume += present_time
			blood_stored += -present_time
	..()

///Veins Anomaly
/obj/item/assembly/signaler/anomaly/veins
	name = "\improper fountain anomaly core"
	desc = "The stabilized core of a fountain anomaly. It's slippery, like an intestine."
	grind_results = list(/datum/reagent/medicine/strange_reagent = 1)

/obj/item/assembly/signaler/anomaly/veins/Initialize()
	. = ..()
	grind_results = list(/datum/reagent/medicine/strange_reagent = rand(10,20))

/obj/item/assembly/signaler/anomaly/veins/anomaly_core_detonation()
	//goreshit
	var/obj/effect/gibspawner/mess = pick(list(
		/obj/effect/gibspawner/human,
		/obj/effect/gibspawner/xeno,
		/obj/effect/gibspawner/generic/animal
	))
	visible_message(span_warning("[src] erupts into a fountain of gore and viserca!"))
	for(var/i in 1 to 4)
		new mess(src.loc)
	..()

///Vortex Anomaly
/obj/item/assembly/signaler/anomaly/vortex
	name = "\improper vortex anomaly core"
	desc = "The stabilized core of a vortex anomaly. It won't sit still, as if some invisible force is acting on it."
	icon_state = "vortex core"
	grind_results = list(/datum/reagent/liquid_dark_matter = 30)

/obj/item/assembly/signaler/anomaly/vortex/anomaly_core_detonation()
	//disappears bigly
	playsound(src,'sound/effects/phasein.ogg', 100, 0, 50, TRUE, TRUE)
	new /obj/effect/particle_effect/sparks/quantum(loc)
	visible_message(span_warning("[src] shakes violently and - hey, where'd it go?"))
	..()
