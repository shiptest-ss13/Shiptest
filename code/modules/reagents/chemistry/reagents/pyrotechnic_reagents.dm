
/datum/reagent/thermite
	name = "Thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	category = "Pyrotechnics"
	reagent_state = SOLID
	color = "#550000"
	taste_description = "sweet tasting metal"
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/thermite/expose_turf(turf/T, reac_volume)
	if(reac_volume >= 1)
		T.AddComponent(/datum/component/thermite, reac_volume)

/datum/reagent/thermite/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(1, 0)
	..()
	return TRUE

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	category = "Pyrotechnics"
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "oil"

/datum/reagent/stabilizing_agent
	name = "Stabilizing Agent"
	description = "Keeps unstable chemicals stable. This does not work on everything."
	reagent_state = LIQUID
	color = "#FFFF00"
	taste_description = "metal"

/datum/reagent/stabilizing_agent/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		myseed.adjust_instability(-1)

/datum/reagent/clf3
	name = "Chlorine Trifluoride"
	description = "Makes a temporary 3x3 fireball when it comes into existence, so be careful when mixing. ClF3 applied to a surface burns things that wouldn't otherwise burn, including typically-robust flooring, potentially exposing it to the vacuum of space."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#FFC8C8"
	metabolization_rate = 4
	taste_description = "burning"
	process_flags = ORGANIC | SYNTHETIC
	accelerant_quality = 20

/datum/reagent/clf3/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(2)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	..()
	return TRUE

/datum/reagent/clf3/expose_turf(turf/T, reac_volume)
	if(isplatingturf(T))
		var/turf/open/floor/plating/F = T
		if(prob(10 + F.burnt + 5*F.broken)) //broken or burnt plating is more susceptible to being destroyed
			F.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	if(isfloorturf(T))
		var/turf/open/floor/F = T
		if(prob(reac_volume))
			F.make_plating()
		else if(prob(reac_volume))
			F.burn_tile()
		if(isfloorturf(F))
			for(var/turf/turf in range(1,F))
				if(!locate(/obj/effect/hotspot) in turf)
					new /obj/effect/hotspot(F)
	if(iswallturf(T))
		var/turf/closed/wall/W = T
		if(prob(reac_volume))
			W.ScrapeAway()

/datum/reagent/clf3/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/5, 10))
			M.IgniteMob()
			if(!locate(/obj/effect/hotspot) in M.loc)
				new /obj/effect/hotspot(M.loc)

/datum/reagent/sorium
	name = "Sorium"
	description = "Sends everything flying from the detonation point."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#5A64C8"
	taste_description = "air and bitterness"

/datum/reagent/liquid_dark_matter
	name = "Liquid Dark Matter"
	description = "Sucks everything into the detonation point."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#210021"
	taste_description = "compressed bitterness"

/datum/reagent/gunpowder
	name = "Gunpowder"
	description = "Explodes. Violently."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.05
	taste_description = "salt"

/datum/reagent/gunpowder/on_mob_life(mob/living/carbon/M)
	. = TRUE
	..()
	if(!isplasmaman(M))
		return
	M.set_drugginess(15)
	if(M.hallucination < volume)
		M.hallucination += 5

/datum/reagent/gunpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(1 + round(volume/6, 1), location, 0, 0, message = 0)
	e.start()
	holder.clear_reagents()

/datum/reagent/rdx
	name = "RDX"
	description = "Military grade explosive"
	category = "Pyrotechnics"
	reagent_state = SOLID
	color = "#FFFFFF"
	taste_description = "salt"

/datum/reagent/tatp
	name = "TaTP"
	description = "Suicide grade explosive"
	category = "Pyrotechnics"
	reagent_state = SOLID
	color = "#FFFFFF"
	taste_description = "death"

/datum/reagent/flash_powder
	name = "Flash Powder"
	description = "Makes a very bright flash."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "salt"

/datum/reagent/smoke_powder
	name = "Smoke Powder"
	description = "Makes a large cloud of smoke that can carry reagents."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "smoke"

/datum/reagent/dense_smoke_powder
	name = "Dense Smoke Powder"
	description = "Makes a large cloud of thick smoke that can carry reagents."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "smoke"

/datum/reagent/sonic_powder
	name = "Sonic Powder"
	description = "Makes a deafening noise."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#C8C8C8"
	taste_description = "loud noises"

/datum/reagent/phlogiston
	name = "Phlogiston"
	description = "Catches you on fire and makes you ignite."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#FA00AF"
	taste_description = "burning"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC
	accelerant_quality = 20

/datum/reagent/phlogiston/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjust_fire_stacks(1)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	M.IgniteMob()
	..()

/datum/reagent/phlogiston/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(1)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg, 0)
	..()
	return TRUE

/datum/reagent/napalm
	name = "Napalm"
	description = "Very flammable."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#FA00AF"
	taste_description = "burning"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC
	accelerant_quality = 20

/datum/reagent/napalm/on_mob_life(mob/living/carbon/M)
	M.adjust_fire_stacks(1)
	..()

/datum/reagent/napalm/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/4, 20))

/datum/reagent/napalm/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		if(myseed && !(myseed.resistance_flags & FIRE_PROOF))
			mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 6))
			mytray.adjustToxic(round(chems.get_reagent_amount(type) * 7))
		mytray.adjustWeeds(-rand(5,9)) //At least give them a small reward if they bother.

/datum/reagent/cryostylane
	name = "Cryostylane"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Cryostylane slowly cools all other reagents in the container 0K."
	category = "Pyrotechnics"
	color = "#0000DC"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs


/datum/reagent/cryostylane/on_mob_life(mob/living/carbon/M) //TODO: code freezing into an ice cube
	if(M.has_reagent(/datum/reagent/oxygen))
		M.remove_reagent(/datum/reagent/oxygen, 0.5)
		M.adjust_bodytemperature(-5)
	..()

/datum/reagent/cryostylane/expose_turf(turf/T, reac_volume)
	if(reac_volume >= 5)
		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(15,30))

/datum/reagent/pyrosium
	name = "Pyrosium"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Pyrosium slowly heats all other reagents in the container."
	category = "Pyrotechnics"
	color = "#64FAC8"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	self_consuming = TRUE
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/pyrosium/on_mob_life(mob/living/carbon/M)
	if(M.has_reagent(/datum/reagent/oxygen))
		M.remove_reagent(/datum/reagent/oxygen, 0.5)
		M.adjust_bodytemperature(5)
	..()

/datum/reagent/teslium //Teslium. Causes periodic shocks, and makes shocks against the target much more effective.
	name = "Teslium"
	description = "An unstable, electrically-charged metallic slurry. Periodically electrocutes its victim, and makes electrocutions against them more deadly. Excessively heating teslium results in dangerous destabilization. Do not allow to come into contact with water."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#20324D" //RGB: 32, 50, 77
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "charged metal"
	self_consuming = TRUE
	var/shock_timer = 0
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/teslium/on_mob_life(mob/living/carbon/M)
	shock_timer++
	if(shock_timer >= rand(5,30)) //Random shocks are wildly unpredictable
		shock_timer = 0
		M.electrocute_act(rand(5,20), "Teslium in their body", 1, SHOCK_NOGLOVES) //SHOCK_NOGLOVES because it's caused from INSIDE of you
		playsound(M, "sparks", 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	..()

/datum/reagent/teslium/on_mob_metabolize(mob/living/carbon/human/L)
	. = ..()
	if(!istype(L))
		return
	L.physiology.siemens_coeff *= 2

/datum/reagent/teslium/on_mob_end_metabolize(mob/living/carbon/human/L)
	. = ..()
	if(!istype(L))
		return
	L.physiology.siemens_coeff *= 0.5

/datum/reagent/teslium/energized_jelly
	name = "Energized Jelly"
	description = "Electrically-charged jelly. Boosts jellypeople's nervous system, but only shocks other lifeforms."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#CAFF43"
	taste_description = "jelly"

/datum/reagent/teslium/energized_jelly/on_mob_life(mob/living/carbon/M)
	if(isjellyperson(M))
		shock_timer = 0 //immune to shocks
		M.AdjustAllImmobility(-40)
		M.adjustStaminaLoss(-2, 0)
	..()

/datum/reagent/firefighting_foam
	name = "Firefighting Foam"
	description = "A historical fire suppressant. Originally believed to simply displace oxygen to starve fires, it actually interferes with the combustion reaction itself. Vastly superior to the cheap water-based extinguishers found on NT vessels."
	category = "Pyrotechnics"
	reagent_state = LIQUID
	color = "#A6FAFF55"
	taste_description = "the inside of a fire extinguisher"

/datum/reagent/firefighting_foam/expose_turf(turf/open/T, reac_volume)
	if (!istype(T))
		return

	if(reac_volume >= 1)
		var/obj/effect/particle_effect/foam/firefighting/F = (locate(/obj/effect/particle_effect/foam) in T)
		if(!F)
			F = new(T)
		else if(istype(F))
			F.lifetime = initial(F.lifetime) //reduce object churn a little bit when using smoke by keeping existing foam alive a bit longer

	T.extinguish_turf()

/datum/reagent/firefighting_foam/expose_obj(obj/O, reac_volume)
	O.extinguish()

/datum/reagent/firefighting_foam/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method in list(VAPOR, TOUCH, SMOKE))
		M.adjust_fire_stacks(-reac_volume)
		M.ExtinguishMob()
	..()
