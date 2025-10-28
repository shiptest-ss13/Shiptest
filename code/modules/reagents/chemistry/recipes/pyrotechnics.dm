/datum/chemical_reaction/reagent_explosion
	var/strengthdiv = 10
	var/modifier = 0

/datum/chemical_reaction/reagent_explosion/on_reaction(datum/reagents/holder, created_volume)
	// We do all this because created_volume is actually the number of time the reaction occurs not the created volume
	var/volume_per_reaction = 0
	if (results.len)
		for(var/reagent in results)
			volume_per_reaction += results[reagent]
	else
		for(var/reagent in required_reagents)
			volume_per_reaction += required_reagents[reagent]

	explode(holder, created_volume*volume_per_reaction)

/datum/chemical_reaction/reagent_explosion/proc/explode(datum/reagents/holder, created_volume)
	if(QDELETED(holder.my_atom))
		return
	var/power = modifier + round(created_volume/strengthdiv, 1)
	if(power > 0)
		var/turf/T = get_turf(holder.my_atom)
		var/inside_msg
		if(ismob(holder.my_atom))
			var/mob/M = holder.my_atom
			inside_msg = " inside [ADMIN_LOOKUPFLW(M)]"
		var/lastkey = holder.my_atom.fingerprintslast
		var/touch_msg = "N/A"
		if(lastkey)
			var/mob/toucher = get_mob_by_key(lastkey)
			touch_msg = "[ADMIN_LOOKUPFLW(toucher)]"
		if(!istype(holder.my_atom, /obj/machinery/plumbing)) //excludes standard plumbing equipment from spamming admins with this shit
			message_admins("Reagent explosion reaction occurred at [ADMIN_VERBOSEJMP(T)][inside_msg]. Last Fingerprint: [touch_msg].")
		log_game("Reagent explosion reaction occurred at [AREACOORD(T)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]." )
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(power , T, 0, 0)
		e.start()
	holder.clear_reagents()

/datum/chemical_reaction/reagent_explosion/nitroglycerin
	results = list(/datum/reagent/nitroglycerin = 2)
	required_reagents = list(/datum/reagent/glycerol = 1, /datum/reagent/toxin/acid/fluacid = 1, /datum/reagent/toxin/acid = 1)
	strengthdiv = 2

/datum/chemical_reaction/reagent_explosion/nitroglycerin/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/nitroglycerin, created_volume*2)
	..()

/datum/chemical_reaction/reagent_explosion/nitroglycerin_explosion
	required_reagents = list(/datum/reagent/nitroglycerin = 1)
	required_temp = 474
	strengthdiv = 2

/datum/chemical_reaction/reagent_explosion/rdx
	results = list(/datum/reagent/rdx = 2)
	required_reagents = list(/datum/reagent/phenol = 2, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/acetone_oxide = 1)
	required_temp = 404
	strengthdiv = 6 //rdx deserves better than being just about equal to nitrous

/datum/chemical_reaction/reagent_explosion/rdx/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/rdx, created_volume*2)
	..()

/datum/chemical_reaction/reagent_explosion/rdx_explosion
	required_reagents = list(/datum/reagent/rdx = 1)
	required_temp = 474
	strengthdiv = 6

/datum/chemical_reaction/reagent_explosion/rdx_explosion2 //makes rdx unique , on its own it is a good bomb, but when combined with liquid electricity it becomes truly destructive
	required_reagents = list(/datum/reagent/rdx = 1 , /datum/reagent/consumable/liquidelectricity = 1)
	strengthdiv = 3
	modifier = 2

/datum/chemical_reaction/reagent_explosion/rdx_explosion2/on_reaction(datum/reagents/holder, created_volume)
	var/fire_range = round(created_volume/50)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(fire_range,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 500
	..()

/datum/chemical_reaction/reagent_explosion/rdx_explosion3
	required_reagents = list(/datum/reagent/rdx = 1 , /datum/reagent/teslium = 1)
	modifier = 6
	strengthdiv = 3

/datum/chemical_reaction/reagent_explosion/rdx_explosion3/on_reaction(datum/reagents/holder, created_volume)
	var/fire_range = round(created_volume/25) // I saw why edge has such a hardon for RDX
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(fire_range,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 750
	..()

/datum/chemical_reaction/reagent_explosion/tatp
	results = list(/datum/reagent/tatp= 1)
	required_reagents = list(/datum/reagent/acetone_oxide = 1, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/pentaerythritol = 1)
	required_temp = 450
	strengthdiv = 3

/datum/chemical_reaction/reagent_explosion/tatp/New()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(UpdateInfo))) //method used by secret sauce.

/datum/chemical_reaction/reagent_explosion/tatp/proc/UpdateInfo() //note to the future: find the PR that refactors this so that we can port more of https://github.com/tgstation/tgstation/pull/50775
	required_temp = 450 + rand(-49,49)  //this gets loaded only on round start

/datum/chemical_reaction/reagent_explosion/tatp/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/tatp, created_volume)
	..()

/datum/chemical_reaction/reagent_explosion/tatp_explosion
	required_reagents = list(/datum/reagent/tatp = 1)
	required_temp = 550 // this makes making tatp before pyro nades, and extreme pain in the ass to make
	strengthdiv = 3

/datum/chemical_reaction/reagent_explosion/tatp_explosion/New() //did i mention i have no idea what i am doing? - zeta
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(UpdateInfo)))

/datum/chemical_reaction/reagent_explosion/tatp_explosion/on_reaction(datum/reagents/holder, created_volume)
	var/strengthdiv_adjust = created_volume / (2100 / initial(strengthdiv))
	strengthdiv = max(initial(strengthdiv) - strengthdiv_adjust + 1.5 ,1.5) //Slightly better than nitroglycerin
	. = ..()
	return

/datum/chemical_reaction/reagent_explosion/tatp_explosion/proc/UpdateInfo()
	required_temp = 550 + rand(-49,49)


/datum/chemical_reaction/reagent_explosion/penthrite_explosion_epinephrine
	required_reagents = list(/datum/reagent/medicine/penthrite = 1, /datum/reagent/medicine/epinephrine = 1)
	strengthdiv = 5

/datum/chemical_reaction/reagent_explosion/penthrite_explosion_atropine
	required_reagents = list(/datum/reagent/medicine/penthrite = 1, /datum/reagent/medicine/atropine = 1)
	strengthdiv = 5
	modifier = 5

/datum/chemical_reaction/reagent_explosion/potassium_explosion
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/potassium = 1)
	strengthdiv = 10

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom
	required_reagents = list(/datum/reagent/water/holywater = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom/on_reaction(datum/reagents/holder, created_volume)
	if(created_volume >= 150)
		playsound(get_turf(holder.my_atom), 'sound/effects/pray.ogg', 80, FALSE, round(created_volume/48))
		strengthdiv = 8
		for(var/mob/living/simple_animal/revenant/R in get_hearers_in_view(7,get_turf(holder.my_atom)))
			var/deity
			if(GLOB.deity)
				deity = GLOB.deity
			else
				deity = "Christ"
			to_chat(R, span_userdanger("The power of [deity] compels you!"))
			R.stun(20)
			R.reveal(100)
			R.adjustHealth(50)
	..()

/datum/chemical_reaction/gunpowder
	results = list(/datum/reagent/gunpowder = 3)
	required_reagents = list(/datum/reagent/saltpetre = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion
	required_reagents = list(/datum/reagent/gunpowder = 1)
	required_temp = 474
	strengthdiv = 6
	modifier = 1
	mix_message = span_boldannounce("Sparks start flying around the gunpowder!")

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion/on_reaction(datum/reagents/holder, created_volume)
	addtimer(CALLBACK(src, PROC_REF(explode), holder, created_volume), rand(5,10) SECONDS)

/datum/chemical_reaction/thermite
	results = list(/datum/reagent/thermite = 3)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/iron = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/emp_pulse
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/iron = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 12), round(created_volume / 7), 1)
	holder.clear_reagents()


/datum/chemical_reaction/beesplosion
	required_reagents = list(/datum/reagent/consumable/honey = 1, /datum/reagent/medicine/strange_reagent = 1, /datum/reagent/uranium/radium = 1)

/datum/chemical_reaction/beesplosion/on_reaction(datum/reagents/holder, created_volume)
	var/location = holder.my_atom.drop_location()
	if(created_volume < 5)
		playsound(location,'sound/effects/sparks1.ogg', 100, TRUE)
	else
		playsound(location,'sound/creatures/bee.ogg', 100, TRUE)
		var/list/beeagents = list()
		for(var/R in holder.reagent_list)
			if(required_reagents[R])
				continue
			beeagents += R
		var/bee_amount = round(created_volume * 0.2)
		for(var/i in 1 to bee_amount)
			var/mob/living/simple_animal/hostile/poison/bees/short/new_bee = new(location)
			if(LAZYLEN(beeagents))
				new_bee.assign_reagent(pick(beeagents))


/datum/chemical_reaction/stabilizing_agent
	results = list(/datum/reagent/stabilizing_agent = 3)
	required_reagents = list(/datum/reagent/iron = 1, /datum/reagent/oxygen = 1, /datum/reagent/hydrogen = 1)

/datum/chemical_reaction/clf3
	results = list(/datum/reagent/clf3 = 4)
	required_reagents = list(/datum/reagent/chlorine = 1, /datum/reagent/fluorine = 3)
	required_temp = 424

/datum/chemical_reaction/clf3/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(1,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 1000 // hot as shit

/datum/chemical_reaction/reagent_explosion/methsplosion
	required_temp = 380 //slightly above the meth mix time.
	required_reagents = list(/datum/reagent/drug/methamphetamine = 1)
	strengthdiv = 6
	modifier = 1
	mob_react = FALSE

/datum/chemical_reaction/reagent_explosion/methsplosion/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(1,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 1000 // hot as shit
	..()

/datum/chemical_reaction/reagent_explosion/methsplosion/methboom2
	required_reagents = list(/datum/reagent/diethylamine = 1, /datum/reagent/iodine = 1, /datum/reagent/phosphorus = 1, /datum/reagent/hydrogen = 1) //diethylamine is often left over from mixing the ephedrine.
	required_temp = 300 //room temperature, chilling it even a little will prevent the explosion

/datum/chemical_reaction/sorium
	results = list(/datum/reagent/sorium = 4)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/oxygen = 1, /datum/reagent/nitrogen = 1, /datum/reagent/carbon = 1)

/datum/chemical_reaction/sorium/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/sorium, created_volume*4)
	var/turf/T = get_turf(holder.my_atom)
	var/range = clamp(sqrt(created_volume*4), 1, 6)
	goonchem_vortex(T, 1, range)

/datum/chemical_reaction/sorium_vortex
	required_reagents = list(/datum/reagent/sorium = 1)
	required_temp = 474

/datum/chemical_reaction/sorium_vortex/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/range = clamp(sqrt(created_volume), 1, 6)
	goonchem_vortex(T, 1, range)

/datum/chemical_reaction/liquid_dark_matter
	results = list(/datum/reagent/liquid_dark_matter = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/carbon = 1)

/datum/chemical_reaction/liquid_dark_matter/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/liquid_dark_matter, created_volume*3)
	var/turf/T = get_turf(holder.my_atom)
	var/range = clamp(sqrt(created_volume*3), 1, 6)
	goonchem_vortex(T, 0, range)

/datum/chemical_reaction/ldm_vortex
	required_reagents = list(/datum/reagent/liquid_dark_matter = 1)
	required_temp = 474

/datum/chemical_reaction/ldm_vortex/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/range = clamp(sqrt(created_volume/2), 1, 6)
	goonchem_vortex(T, 0, range)

/datum/chemical_reaction/flash_powder
	results = list(/datum/reagent/flash_powder = 3)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/potassium = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	var/location = get_turf(holder.my_atom)
	do_sparks(2, TRUE, location)
	var/range = created_volume/3
	if(isatom(holder.my_atom))
		var/atom/A = holder.my_atom
		A.flash_lighting_fx(_range = (range + 2))
	for(var/mob/living/C in get_hearers_in_view(range, location))
		if(C.flash_act(affect_silicon = TRUE))
			if(get_dist(C, location) < 4)
				C.Paralyze(60)
			else
				C.Stun(100)
	holder.remove_reagent(/datum/reagent/flash_powder, created_volume*3)

/datum/chemical_reaction/flash_powder_flash
	required_reagents = list(/datum/reagent/flash_powder = 1)
	required_temp = 374

/datum/chemical_reaction/flash_powder_flash/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	do_sparks(2, TRUE, location)
	var/range = created_volume/10
	if(isatom(holder.my_atom))
		var/atom/A = holder.my_atom
		A.flash_lighting_fx(_range = (range + 2))
	for(var/mob/living/C in get_hearers_in_view(range, location))
		if(C.flash_act(affect_silicon = TRUE))
			if(get_dist(C, location) < 4)
				C.Paralyze(60)
			else
				C.Stun(100)

/datum/chemical_reaction/smoke_powder
	results = list(/datum/reagent/smoke_powder = 3)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/smoke_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/smoke_powder, created_volume*3)
	var/smoke_radius = round(sqrt(created_volume * 1.5), 1)
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/smoke_spread/chem/thin/S = new
	S.attach(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	if(S)
		S.set_up(holder, smoke_radius, location, 0)
		S.start()
	if(holder && holder.my_atom)
		holder.clear_reagents()

/datum/chemical_reaction/smoke_powder_smoke
	required_reagents = list(/datum/reagent/smoke_powder = 1)
	required_temp = 374
	mob_react = FALSE

/datum/chemical_reaction/smoke_powder_smoke/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	var/smoke_radius = round(sqrt(created_volume / 2), 1)
	var/datum/effect_system/smoke_spread/chem/thin/S = new
	S.attach(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	if(S)
		S.set_up(holder, smoke_radius, location, 0)
		S.start()
	if(holder && holder.my_atom)
		holder.clear_reagents()

/datum/chemical_reaction/dense_smoke_powder
	results = list(/datum/reagent/dense_smoke_powder = 4)
	required_reagents = list(/datum/reagent/smoke_powder = 3, /datum/reagent/carbon = 1)

/datum/chemical_reaction/dense_smoke_powder_smoke
	required_reagents = list(/datum/reagent/dense_smoke_powder = 1)
	required_temp = 374
	mob_react = FALSE

/datum/chemical_reaction/dense_smoke_powder_smoke/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	var/smoke_radius = round(sqrt(created_volume / 2), 1)
	var/datum/effect_system/smoke_spread/chem/S = new
	S.attach(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	if(S)
		S.set_up(holder, smoke_radius, location, 0)
		S.start()
	if(holder && holder.my_atom)
		holder.clear_reagents()

/datum/chemical_reaction/sonic_powder
	results = list(/datum/reagent/sonic_powder = 3)
	required_reagents = list(/datum/reagent/oxygen = 1, /datum/reagent/consumable/space_cola = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/sonic_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/sonic_powder, created_volume*3)
	var/location = get_turf(holder.my_atom)
	playsound(location, 'sound/effects/bang.ogg', 25, TRUE)
	for(var/mob/living/carbon/C in get_hearers_in_view(created_volume/3, location))
		C.soundbang_act(1, 100, rand(0, 5))

/datum/chemical_reaction/sonic_powder_deafen
	required_reagents = list(/datum/reagent/sonic_powder = 1)
	required_temp = 374

/datum/chemical_reaction/sonic_powder_deafen/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	playsound(location, 'sound/effects/bang.ogg', 25, TRUE)
	for(var/mob/living/carbon/C in get_hearers_in_view(created_volume/10, location))
		C.soundbang_act(1, 100, rand(0, 5))

/datum/chemical_reaction/phlogiston
	results = list(/datum/reagent/phlogiston = 3)
	required_reagents = list(/datum/reagent/phosphorus = 1, /datum/reagent/toxin/acid = 1, /datum/reagent/stable_plasma = 1)

/datum/chemical_reaction/phlogiston/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	var/turf/open/T = get_turf(holder.my_atom)
	if(istype(T))
		T.atmos_spawn_air("plasma=[created_volume];TEMP=1000")
	holder.clear_reagents()
	return

/datum/chemical_reaction/napalm
	results = list(/datum/reagent/napalm = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/cryostylane
	results = list(/datum/reagent/cryostylane = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/nitrogen = 1)

/datum/chemical_reaction/cryostylane/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = 20 // cools the fuck down
	return

/datum/chemical_reaction/cryostylane_oxygen
	results = list(/datum/reagent/cryostylane = 1)
	required_reagents = list(/datum/reagent/cryostylane = 1, /datum/reagent/oxygen = 1)
	mob_react = FALSE

/datum/chemical_reaction/cryostylane_oxygen/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = max(holder.chem_temp - 10*created_volume,0)

/datum/chemical_reaction/pyrosium_oxygen
	results = list(/datum/reagent/pyrosium = 1)
	required_reagents = list(/datum/reagent/pyrosium = 1, /datum/reagent/oxygen = 1)
	mob_react = FALSE

/datum/chemical_reaction/pyrosium_oxygen/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp += 10*created_volume

/datum/chemical_reaction/pyrosium
	results = list(/datum/reagent/pyrosium = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/pyrosium/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = 20 // also cools the fuck down
	return

/datum/chemical_reaction/teslium
	results = list(/datum/reagent/teslium = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/silver = 1, /datum/reagent/gunpowder = 1)
	mix_message = span_danger("A jet of sparks flies from the mixture as it merges into a flickering slurry.")
	required_temp = 400

/datum/chemical_reaction/energized_jelly
	results = list(/datum/reagent/teslium/energized_jelly = 2)
	required_reagents = list(/datum/reagent/toxin/slimejelly = 1, /datum/reagent/teslium = 1)
	mix_message = span_danger("The slime jelly starts glowing intermittently.")

/datum/chemical_reaction/reagent_explosion/teslium_lightning
	required_reagents = list(/datum/reagent/teslium = 1, /datum/reagent/water = 1)
	strengthdiv = 100
	modifier = -100
	mix_message = span_boldannounce("The teslium starts to spark as electricity arcs away from it!")
	mix_sound = 'sound/machines/defib_zap.ogg'
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN

/datum/chemical_reaction/reagent_explosion/teslium_lightning/on_reaction(datum/reagents/holder, created_volume)
	var/T1 = created_volume * 20		//100 units : Zap 3 times, with powers 2000/5000/12000. Tesla revolvers have a power of 10000 for comparison.
	var/T2 = created_volume * 50
	var/T3 = created_volume * 120
	var/added_delay = 0.5 SECONDS
	if(created_volume >= 75)
		addtimer(CALLBACK(src, PROC_REF(zappy_zappy), holder, T1), added_delay)
		added_delay += 1.5 SECONDS
	if(created_volume >= 40)
		addtimer(CALLBACK(src, PROC_REF(zappy_zappy), holder, T2), added_delay)
		added_delay += 1.5 SECONDS
	if(created_volume >= 10)			//10 units minimum for lightning, 40 units for secondary blast, 75 units for tertiary blast.
		addtimer(CALLBACK(src, PROC_REF(zappy_zappy), holder, T3), added_delay)
	addtimer(CALLBACK(src, PROC_REF(explode), holder, created_volume), added_delay)

/datum/chemical_reaction/reagent_explosion/teslium_lightning/proc/zappy_zappy(datum/reagents/holder, power)
	if(QDELETED(holder.my_atom))
		return
	tesla_zap(holder.my_atom, 7, power, zap_flags)
	playsound(holder.my_atom, 'sound/machines/defib_zap.ogg', 50, TRUE)

/datum/chemical_reaction/reagent_explosion/teslium_lightning/heat
	required_temp = 474
	required_reagents = list(/datum/reagent/teslium = 1)

/datum/chemical_reaction/reagent_explosion/nitrous_oxide
	required_reagents = list(/datum/reagent/nitrous_oxide = 1)
	strengthdiv = 7
	required_temp = 575
	modifier = 1

/datum/chemical_reaction/firefighting_foam
	results = list(/datum/reagent/firefighting_foam = 3)
	required_reagents = list(/datum/reagent/stabilizing_agent = 1,/datum/reagent/fluorosurfactant = 1,/datum/reagent/carbon = 1)
	required_temp = 200
	is_cold_recipe = TRUE
