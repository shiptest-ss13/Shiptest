/datum/reagent/blood
	data = list("viruses"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	name = "Blood"
	color = COLOR_BLOOD
	metabolization_rate = 5 //fast rate so it disappears fast.
	taste_description = "iron"
	taste_mult = 1.3
	glass_icon_state = "glass_red"
	glass_name = "glass of tomato juice"
	glass_desc = "Are you sure this is tomato juice?"
	shot_glass_icon_state = "shotglassred"

/datum/reagent/blood/expose_mob(mob/living/L, method=TOUCH, reac_volume)
	if(data && data["viruses"])
		for(var/thing in data["viruses"])
			var/datum/disease/D = thing

			if((D.spread_flags & DISEASE_SPREAD_SPECIAL) || (D.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
				continue

			if(((method == TOUCH || method == SMOKE) || method == VAPOR) && (D.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS))
				L.ContactContractDisease(D)
			else //ingest, patch or inject
				L.ForceContractDisease(D)

	if(iscarbon(L))
		var/mob/living/carbon/exposed_carbon = L
		if(exposed_carbon.get_blood_id() == /datum/reagent/blood && (method == INJECT || (method == INGEST && exposed_carbon.dna && exposed_carbon.dna.species && (DRINKSBLOOD in exposed_carbon.dna.species.species_traits))))
			if(data && data["blood_type"])
				var/datum/blood_type/blood_type = data["blood_type"]
				if(blood_type.type in exposed_carbon.dna.blood_type.compatible_types)
					exposed_carbon.blood_volume = min(exposed_carbon.blood_volume + round(reac_volume, 0.1), BLOOD_VOLUME_MAXIMUM)
					return
			exposed_carbon.reagents.add_reagent(/datum/reagent/toxin, reac_volume * 0.5)


/datum/reagent/blood/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)
		var/datum/blood_type/blood_type = data["blood_type"]
		if(blood_type)
			color = blood_type.color

/datum/reagent/blood/on_merge(list/mix_data)
	if(data && mix_data)
		if(data["blood_DNA"] != mix_data["blood_DNA"])
			data["cloneable"] = 0 //On mix, consider the genetic sampling unviable for pod cloning if the DNA sample doesn't match.
		if(data["viruses"] || mix_data["viruses"])

			var/list/mix1 = data["viruses"]
			var/list/mix2 = mix_data["viruses"]

			// Stop issues with the list changing during mixing.
			var/list/to_mix = list()

			for(var/datum/disease/advance/AD in mix1)
				to_mix += AD
			for(var/datum/disease/advance/AD in mix2)
				to_mix += AD

			var/datum/disease/advance/AD = Advance_Mix(to_mix)
			if(AD)
				var/list/preserve = list(AD)
				for(var/D in data["viruses"])
					if(!istype(D, /datum/disease/advance))
						preserve += D
				data["viruses"] = preserve
	return 1

/datum/reagent/blood/proc/get_diseases()
	. = list()
	if(data && data["viruses"])
		for(var/thing in data["viruses"])
			var/datum/disease/D = thing
			. += D

/datum/reagent/blood/expose_turf(turf/T, reac_volume)//splash the blood all over the place
	if(!istype(T))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/B = locate() in T //find some blood here
	if(!B)
		B = new(T)
	if(data["blood_DNA"])
		B.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"]))

/datum/reagent/blood/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustPests(rand(2,3))

/datum/reagent/liquidgibs
	name = "Liquid gibs"
	color = "#CC4633"
	description = "You don't even want to think about what's in here."
	taste_description = "gross iron"
	shot_glass_icon_state = "shotglassred"
	material = /datum/material/meat

/datum/reagent/vaccine
	//data must contain virus type
	name = "Vaccine"
	color = "#C81040" // rgb: 200, 16, 64
	taste_description = "slime"

/datum/reagent/vaccine/expose_mob(mob/living/L, method=TOUCH, reac_volume)
	if(islist(data) && (method == INGEST || method == INJECT))
		for(var/thing in L.diseases)
			var/datum/disease/D = thing
			if(D.GetDiseaseID() in data)
				D.cure()
		L.disease_resistances |= data

/datum/reagent/vaccine/on_merge(list/data)
	if(istype(data))
		src.data |= data.Copy()

/datum/reagent/vaccine/fungal_tb
	name = "Fungal TB Vaccine"

/datum/reagent/vaccine/fungal_tb/New(data)
	. = ..()
	var/list/cached_data
	if(!data)
		cached_data = list()
	else
		cached_data = data
	cached_data |= "[/datum/disease/tuberculosis]"
	src.data = cached_data

/datum/reagent/water
	name = "Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen."
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "water"
	glass_icon_state = "glass_clear"
	glass_name = "glass of water"
	glass_desc = "The father of all refreshments."
	shot_glass_icon_state = "shotglassclear"

	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs //WS Edit - IPCs

/datum/reagent/water/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(M.blood_volume)
		M.blood_volume += 0.1 //full of water...
/*
 *	Water reaction to turf
 */

/datum/reagent/water/expose_turf(turf/open/T, reac_volume)
	if(!istype(T))
		return

	if(reac_volume >= 5)
		T.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume * 1.5 SECONDS, 60 SECONDS))

	for(var/mob/living/simple_animal/slime/M in T)
		M.apply_water()

	T.extinguish_turf(min(reac_volume * 2, 5))

	var/obj/effect/acid/A = (locate(/obj/effect/acid) in T)
	if(A)
		A.acid_level = max(A.acid_level - reac_volume*50, 0)

/*
 *	Water reaction to an object
 */

/datum/reagent/water/expose_obj(obj/O, reac_volume)
	O.extinguish()
	O.acid_level = 0
	// Monkey cube
	if(istype(O, /obj/item/food/monkeycube))
		var/obj/item/food/monkeycube/cube = O
		cube.Expand()

	// Dehydrated carp
	else if(istype(O, /obj/item/toy/plush/carpplushie/dehy_carp))
		var/obj/item/toy/plush/carpplushie/dehy_carp/dehy = O
		dehy.Swell() // Makes a carp

	else if(istype(O, /obj/item/stack/sheet/hairlesshide))
		var/obj/item/stack/sheet/hairlesshide/HH = O
		new /obj/item/stack/sheet/wethide(get_turf(HH), HH.amount)
		qdel(HH)

/*
 *	Water reaction to a mob
 */

/datum/reagent/water/expose_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with water can help put them out!
	if(!istype(M))
		return
	if(method == TOUCH || method == SMOKE)
		M.adjust_fire_stacks(-(reac_volume / 10))
		M.ExtinguishMob()
	..()

///For weird backwards situations where water manages to get added to trays nutrients, as opposed to being snowflaked away like usual.
/datum/reagent/water/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type) * 1))
		//You don't belong in this world, monster!
		chems.remove_reagent(/datum/reagent/water, chems.get_reagent_amount(type))

/datum/reagent/water/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/capacitor))
		var/removed = H.reagents.remove_reagent(/datum/reagent/water, 5*I.get_part_rating())
		H.reagents.add_reagent(/datum/reagent/oxygen, removed/3)
		H.reagents.add_reagent(/datum/reagent/hydrogen, (removed/3)*2)
		return TRUE
	return

/datum/reagent/water/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type)))
		//You don't belong in this world, monster!
		chems.remove_reagent(/datum/reagent/water, chems.get_reagent_amount(type))

/datum/reagent/water/holywater
	name = "Holy Water"
	description = "Water blessed by some deity."
	color = "#E0E8EF" // rgb: 224, 232, 239
	glass_icon_state  = "glass_clear"
	glass_name = "glass of holy water"
	glass_desc = "A glass of holy water."
	self_consuming = TRUE //divine intervention won't be limited by the lack of a liver

/datum/reagent/water/holywater/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_HOLY, type)

/datum/reagent/water/holywater/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_HOLY, type)
	..()

/datum/reagent/water/holywater/expose_turf(turf/T, reac_volume)
	..()
	if(!istype(T))
		return
	T.Bless()

// Holy water. Mostly the same as water, it also heals the plant a little with the power of the spirits. Also ALSO increases instability.
/datum/reagent/water/holywater/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type)))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 0.1))
		if(myseed)
			myseed.adjust_instability(round(chems.get_reagent_amount(type) * 0.15))

/datum/reagent/water/hollowwater
	name = "Hollow Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen, but it looks kinda hollow."
	color = "#88878777"
	taste_description = "emptyiness"

/datum/reagent/hydrogen_peroxide
	name = "Hydrogen peroxide"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen and oxygen." //intended intended
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "burning water"
	var/cooling_temperature = 2
	glass_icon_state = "glass_clear"
	glass_name = "glass of oxygenated water"
	glass_desc = "The father of all refreshments. Surely it tastes great, right?"
	shot_glass_icon_state = "shotglassclear"

/*
 *	Water reaction to turf
 */

/datum/reagent/hydrogen_peroxide/expose_turf(turf/open/T, reac_volume)
	if(!istype(T))
		return
	if(reac_volume >= 5)
		T.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))
/*
 *	Water reaction to a mob
 */

/datum/reagent/hydrogen_peroxide/expose_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with h2o2 can burn them !
	if(!istype(M))
		return
	if(method == TOUCH || method == SMOKE)
		M.adjustFireLoss(2, 0) // burns
	..()

/datum/reagent/lube
	name = "Industrial Lubricant"
	description = "Lubricant is a substance introduced between two moving surfaces to reduce the friction and wear between them."
	color = "#009CA8" // rgb: 0, 156, 168
	taste_description = "cherry" // by popular demand
	var/lube_kind = TURF_WET_LUBE ///What kind of slipperiness gets added to turfs.

/datum/reagent/lube/expose_turf(turf/open/T, reac_volume)
	if (!istype(T))
		return
	if(reac_volume >= 1)
		T.MakeSlippery(lube_kind, 15 SECONDS, min(reac_volume * 2 SECONDS, 120))

/datum/reagent/spraytan
	name = "Spray Tan"
	description = "A substance applied to the skin to darken the skin."
	color = "#FFC080" // rgb: 255, 196, 128  Bright orange
	metabolization_rate = 10 * REAGENTS_METABOLISM // very fast, so it can be applied rapidly.  But this changes on an overdose
	taste_description = "sour oranges"

/datum/reagent/spraytan/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(ishuman(M))
		if(method == PATCH || method == VAPOR)
			var/mob/living/carbon/human/N = M
			if(N.dna.species.id == SPECIES_HUMAN)
				switch(N.skin_tone)
					if("african1")
						N.skin_tone = "african2"
					if("indian")
						N.skin_tone = "african1"
					if("arab")
						N.skin_tone = "indian"
					if("asian2")
						N.skin_tone = "arab"
					if("asian1")
						N.skin_tone = "asian2"
					if("mediterranean")
						N.skin_tone = "african1"
					if("latino")
						N.skin_tone = "mediterranean"
					if("caucasian3")
						N.skin_tone = "mediterranean"
					if("caucasian2")
						N.skin_tone = pick("caucasian3", "latino")
					if("caucasian1")
						N.skin_tone = "caucasian2"
					if ("albino")
						N.skin_tone = "caucasian1"

			if(MUTCOLORS in N.dna.species.species_traits) //take current alien color and darken it slightly
				var/newcolor = ""
				var/string = N.dna.features["mcolor"]
				var/len = length(string)
				var/char = ""
				var/ascii = 0
				for(var/i=1, i<=len, i += length(char))
					char = string[i]
					ascii = text2ascii(char)
					switch(ascii)
						if(48)
							newcolor += "0"
						if(49 to 57)
							newcolor += ascii2text(ascii-1)	//numbers 1 to 9
						if(97)
							newcolor += "9"
						if(98 to 102)
							newcolor += ascii2text(ascii-1)	//letters b to f lowercase
						if(65)
							newcolor += "9"
						if(66 to 70)
							newcolor += ascii2text(ascii+31)	//letters B to F - translates to lowercase
						else
							break
				if(ReadHSV(newcolor)[3] >= ReadHSV("#191919")[3])
					N.dna.features["mcolor"] = newcolor
			N.regenerate_icons()

		if(method == INGEST)
			if(show_message)
				to_chat(M, span_notice("That tasted horrible."))
	..()

/datum/reagent/mulligan
	name = "Mulligan Toxin"
	description = "This toxin will rapidly change the DNA of human beings. Commonly used by Syndicate spies and assassins in need of an emergency ID change."
	color = "#5EFF3B" //RGB: 94, 255, 59
	metabolization_rate = INFINITY
	taste_description = "slime"

/datum/reagent/mulligan/on_mob_life(mob/living/carbon/human/H)
	..()
	if (!istype(H))
		return
	to_chat(H, span_warning("<b>You grit your teeth in pain as your body rapidly mutates!</b>"))
	H.visible_message("<b>[H]</b> suddenly transforms!")
	randomize_human(H)

/datum/reagent/oxygen
	name = "Oxygen"
	description = "A colorless, odorless gas. Grows on trees but is still pretty valuable."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0 // oderless and tasteless

/datum/reagent/oxygen/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	var/obj/item/stock_parts/cell/current_cell
	if(istype(I, /obj/item/stock_parts/cell))
		if(!current_cell.use(1))
			return
		H.reagents.add_reagent(/datum/reagent/ozone, (H.reagents.remove_reagent(/datum/reagent/oxygen, 0.05*I.get_part_rating())))
		return TRUE
	return

/datum/reagent/oxygen/expose_obj(obj/O, reac_volume)
	if((!O) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	O.atmos_spawn_air("[GAS_O2]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/oxygen/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		var/temp = holder ? holder.chem_temp : T20C
		T.atmos_spawn_air("[GAS_O2]=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/ozone
	name = "Ozone"
	description = "A pale blue gas, with a distinct smell. While it is oxygen with an extra molecule attached, it is quite dangerous."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	color = "#a1a1e6"
	taste_mult = 0

/datum/reagent/ozone/on_mob_life(mob/living/carbon/M)
	if(prob(30))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS,1*REM)
	if(prob(40))
		M.adjustOrganLoss(ORGAN_SLOT_HEART,2*REM)
	. = 1
	return ..()

/datum/reagent/ozone/expose_obj(obj/exposed_object, reac_volume)
	if((!exposed_object) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_object.atmos_spawn_air("[GAS_O3]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/ozone/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("[GAS_O3]=[reac_volume/2];TEMP=[temp]")
	return


/datum/reagent/copper
	name = "Copper"
	description = "A highly ductile metal. Things made out of copper aren't very durable, but it makes a decent material for electrical wiring."
	reagent_state = SOLID
	color = "#6E3B08" // rgb: 110, 59, 8
	taste_description = "metal"

/datum/reagent/copper/expose_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = O
		reac_volume = min(reac_volume, M.amount)
		new/obj/item/stack/tile/bronze(get_turf(M), reac_volume)
		M.use(reac_volume)

/datum/reagent/nitrogen
	name = "Nitrogen"
	description = "A colorless, odorless, tasteless gas. A simple asphyxiant that can silently displace vital oxygen."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0

/datum/reagent/nitrogen/expose_obj(obj/O, reac_volume)
	if((!O) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	O.atmos_spawn_air("[GAS_N2]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/nitrogen/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		var/temp = holder ? holder.chem_temp : T20C
		T.atmos_spawn_air("[GAS_N2]=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/hydrogen
	name = "Hydrogen"
	description = "A colorless, odorless, nonmetallic, tasteless, highly combustible diatomic gas."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_mult = 0

/datum/reagent/potassium
	name = "Potassium"
	description = "A soft, low-melting solid that can easily be cut with a knife. Reacts violently with water."
	reagent_state = SOLID
	color = "#A0A0A0" // rgb: 160, 160, 160
	taste_description = "sweetness"

/datum/reagent/mercury
	name = "Mercury"
	description = "A curious metal that's a liquid at room temperature. Neurodegenerative and very bad for the mind."
	color = "#484848" // rgb: 72, 72, 72A
	taste_mult = 0 // apparently tasteless.

/datum/reagent/mercury/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(src, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc))
		step(M, pick(GLOB.cardinals))
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	..()

/datum/reagent/sulfur
	name = "Sulfur"
	description = "A sickly yellow solid mostly known for its nasty smell. It's actually much more helpful than it looks in biochemisty."
	reagent_state = SOLID
	color = "#f0e518"
	taste_description = "rotten eggs"

/datum/reagent/carbon
	name = "Carbon"
	description = "A crumbly black solid that, while unexciting on a physical level, forms the base of all known life. Kind of a big deal."
	reagent_state = SOLID
	color = "#1C1300" // rgb: 30, 20, 0
	taste_description = "sour chalk"

/datum/reagent/carbon/expose_turf(turf/T, reac_volume)
	if(!isspaceturf(T))
		var/obj/effect/decal/cleanable/dirt/D = locate() in T.contents
		if(!D)
			new /obj/effect/decal/cleanable/dirt(T)

/datum/reagent/chlorine
	name = "Chlorine"
	description = "A pale yellow gas that's well known as an oxidizer. While it forms many harmless molecules in its elemental form it is far from harmless."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	color = "#FFFB89" //pale yellow? let's make it light gray
	taste_description = "caustic"

/datum/reagent/chlorine/on_mob_life(mob/living/carbon/M)
	M.take_bodypart_damage(0, 1*REM, 0, 0)
	if(prob(25))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS,2*REM)
	. = 1
	..()

/datum/reagent/chlorine/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/scanning_module))
		H.reagents.add_reagent(/datum/reagent/fluorine, (H.reagents.remove_reagent(/datum/reagent/chlorine, 5*I.get_part_rating())))
		return TRUE
	return

/datum/reagent/chlorine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type)))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 1.5))
		mytray.adjustWater(-round(chems.get_reagent_amount(type) * 0.5))
		mytray.adjustWeeds(-rand(1,3))

/datum/reagent/chlorine/expose_obj(obj/exposed_object, reac_volume)
	if((!exposed_object) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_object.atmos_spawn_air("[GAS_CHLORINE]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/chlorine/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("[GAS_CHLORINE]=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/hydrogen_chloride
	name = "Hydrogen Chloride"
	description = "A colorless gas that turns into hydrochloric acid in the presence of water."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5
	color = "#f4ffe0"
	taste_description = "acid"

/datum/reagent/hydrogen_chloride/on_mob_life(mob/living/carbon/exposed_mob)
	exposed_mob.take_bodypart_damage(0, 2*REM, 0, 0)
	exposed_mob.adjustOrganLoss(ORGAN_SLOT_LUNGS,1*REM)
	exposed_mob.adjustOrganLoss(ORGAN_SLOT_STOMACH,1*REM)
	. = 1
	..()

/datum/reagent/hydrogen_chloride/expose_obj(obj/exposed_object, reac_volume)
	if((!exposed_object) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_object.atmos_spawn_air("[GAS_HYDROGEN_CHLORIDE]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/hydrogen_chloride/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("[GAS_HYDROGEN_CHLORIDE]=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/fluorine
	name = "Fluorine"
	description = "A comically-reactive chemical element. The universe does not want this stuff to exist in this form in the slightest."
	reagent_state = GAS
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "acid"
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/fluorine/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1*REM, 0)
	. = 1
	..()

/datum/reagent/fluorine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 2))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 2.5))
		mytray.adjustWater(-round(chems.get_reagent_amount(type) * 0.5))
		mytray.adjustWeeds(-rand(1,4))

/datum/reagent/sodium
	name = "Sodium"
	description = "A soft silver metal that can easily be cut with a knife. It's not salt just yet, so refrain from putting it on your chips."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "salty metal"

/datum/reagent/sodium/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/micro_laser))
		H.reagents.add_reagent(/datum/reagent/potassium, (H.reagents.remove_reagent(/datum/reagent/sodium, 10*I.get_part_rating())) /2)//halved volume on refinement
		return TRUE
	return

/datum/reagent/phosphorus
	name = "Phosphorus"
	description = "A ruddy red powder that burns readily. Though it comes in many colors, the general theme is always the same."
	reagent_state = SOLID
	color = "#832828" // rgb: 131, 40, 40
	taste_description = "vinegar"

/datum/reagent/phosphorus/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/micro_laser)) //using a laser instead of a manipulator here, because honestly, i have no idea what will happen if this reaction was called on both the silicon and phosphorus at once, and i dont want to find out.
		if(holder.has_reagent(/datum/reagent/hydrogen))
			var/hydrogen = H.reagents.remove_reagent(/datum/reagent/hydrogen, 5*I.get_part_rating())
			var/base = H.reagents.remove_reagent(/datum/reagent/phosphorus, 5*I.get_part_rating())
			if(hydrogen == base)
				H.reagents.add_reagent(/datum/reagent/sulfur, base)
				return TRUE
			if(hydrogen < base)
				H.reagents.add_reagent(/datum/reagent/sulfur, hydrogen)
				H.reagents.add_reagent(/datum/reagent/phosphorus, (base-hydrogen))
				return TRUE
			if(base < hydrogen)
				H.reagents.add_reagent(/datum/reagent/sulfur, base)
				H.reagents.add_reagent(/datum/reagent/hydrogen, (hydrogen-base))
				return TRUE
	return

/datum/reagent/lithium
	name = "Lithium"
	description = "A silver metal, its claim to fame is its remarkably low density. Using it is a bit too effective in calming oneself down."
	reagent_state = SOLID
	color = "#808080" // rgb: 128, 128, 128
	taste_description = "metal"

/datum/reagent/lithium/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !isspaceturf(M.loc))
		step(M, pick(GLOB.cardinals))
	..()

/datum/reagent/lithium/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/micro_laser))
		H.reagents.add_reagent(/datum/reagent/sodium, (H.reagents.remove_reagent(/datum/reagent/lithium, 10*I.get_part_rating()))/2)//halved volume on refinement
		return TRUE
	return

/datum/reagent/glycerol
	name = "Glycerol"
	description = "Glycerol is a simple polyol compound. Glycerol is sweet-tasting and of low toxicity."
	color = "#D3B913"
	taste_description = "sweetness"

/datum/reagent/space_cleaner/sterilizine
	name = "Sterilizine"
	description = "Sterilizes wounds in preparation for surgery."
	color = "#D0EFEE" // space cleaner but lighter
	taste_description = "bitterness"

/datum/reagent/space_cleaner/sterilizine/expose_mob(mob/living/carbon/C, method=TOUCH, reac_volume)
	if(method in list(TOUCH, VAPOR, PATCH, SMOKE))
		for(var/s in C.surgeries)
			var/datum/surgery/S = s
			S.speed_modifier = max(0.2, S.speed_modifier)
	..()

/datum/reagent/iron
	name = "Iron"
	description = "Pure iron is a metal."
	reagent_state = SOLID
	taste_description = "iron"
	material = /datum/material/iron

	color = "#606060" //pure iron? let's make it violet of course

/datum/reagent/iron/on_mob_life(mob/living/carbon/C)
	if(C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5
	..()

/datum/reagent/gold
	name = "Gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	reagent_state = SOLID
	color = "#F7C430" // rgb: 247, 196, 48
	taste_description = "expensive metal"
	material = /datum/material/gold

/datum/reagent/silver
	name = "Silver"
	description = "A soft, white, lustrous transition metal, it has the highest electrical conductivity of any element and the highest thermal conductivity of any metal."
	reagent_state = SOLID
	color = "#D0D0D0" // rgb: 208, 208, 208
	taste_description = "expensive yet reasonable metal"
	material = /datum/material/silver

/datum/reagent/uranium
	name ="Uranium"
	description = "A jade-green metallic chemical element in the actinide series, weakly radioactive."
	reagent_state = SOLID
	color = "#5E9964" //this used to be silver, but liquid uranium can still be green and it's more easily noticeable as uranium like this so why bother?
	taste_description = "the inside of a reactor"
	var/irradiation_level = 1
	material = /datum/material/uranium

	//WS Begin - IPCs
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs
	//WS End

/datum/reagent/uranium/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	mytray.mutation_roll(user)
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 2))

/datum/reagent/uranium/on_mob_life(mob/living/carbon/M)
	M.apply_effect(irradiation_level/M.metabolism_efficiency,EFFECT_IRRADIATE,0)
	..()

/datum/reagent/uranium/expose_turf(turf/T, reac_volume)
	if(reac_volume >= 3)
		if(!isspaceturf(T))
			var/obj/effect/decal/cleanable/greenglow/GG = locate() in T.contents
			if(!GG)
				GG = new/obj/effect/decal/cleanable/greenglow(T)
			if(!QDELETED(GG))
				GG.reagents.add_reagent(type, reac_volume)

/datum/reagent/uranium/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/micro_laser))
		H.reagents.add_reagent(/datum/reagent/uranium/radium, (H.reagents.remove_reagent(/datum/reagent/uranium, 10*I.get_part_rating())) /2)///refining the uranium halves its volume, for reasons
		return TRUE
	return

/datum/reagent/uranium/radium
	name = "Radium"
	description = "Radium is an alkaline earth metal. It is extremely radioactive."
	reagent_state = SOLID
	color = "#00CC00" // ditto
	taste_description = "the colour blue and regret"
	irradiation_level = 2*REM
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs
	material = null

/datum/reagent/uranium/radium/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	return FALSE

/datum/reagent/uranium/radium/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(-round(chems.get_reagent_amount(type) * 2.5))
		mytray.adjustToxic(round(chems.get_reagent_amount(type) * 1.5))
		if(myseed && chems.has_reagent(type, 1))
			myseed.adjust_instability(3)

/datum/reagent/bluespace
	name = "Bluespace Dust"
	description = "A dust composed of microscopic bluespace crystals, with minor space-warping properties."
	reagent_state = SOLID
	color = "#0000CC"
	taste_description = "fizzling blue"
	material = /datum/material/bluespace

	//WS Begin - IPCs
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs
	//WS End

/datum/reagent/bluespace/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE) || method == VAPOR)
		do_teleport(M, get_turf(M), (reac_volume / 5), asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE) //4 tiles per crystal
	..()

/datum/reagent/bluespace/on_mob_life(mob/living/carbon/M)
	if(current_cycle > 10 && prob(15))
		to_chat(M, span_warning("You feel unstable..."))
		M.adjust_timed_status_effect(2 SECONDS * REM, /datum/status_effect/jitter, max_duration = 40 SECONDS)
		current_cycle = 1
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, bluespace_shuffle)), 30)
	..()

/mob/living/proc/bluespace_shuffle()
	do_teleport(src, get_turf(src), 5, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/datum/reagent/aluminium
	name = "Aluminium"
	description = "A silvery white and ductile member of the boron group of chemical elements."
	reagent_state = SOLID
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_description = "metal"

/datum/reagent/silicon
	name = "Silicon"
	description = "A tetravalent metalloid, silicon is less reactive than its chemical analog carbon."
	reagent_state = SOLID
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_mult = 0
	material = /datum/material/glass

/datum/reagent/silicon/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/manipulator)) //using a laser instead of a manipulator here, because honestly, i have no idea what will happen if this reaction was called on both the silicon and phosphorus at once, and i dont want to find out.
		if(holder.has_reagent(/datum/reagent/hydrogen))
			var/hydrogen = H.reagents.remove_reagent(/datum/reagent/hydrogen, 5*I.get_part_rating())
			var/base = H.reagents.remove_reagent(/datum/reagent/silicon, 5*I.get_part_rating())
			if(hydrogen == base)
				H.reagents.add_reagent(/datum/reagent/phosphorus, base)
				return TRUE
			if(hydrogen < base)
				H.reagents.add_reagent(/datum/reagent/phosphorus, hydrogen)
				H.reagents.add_reagent(/datum/reagent/silicon, (base-hydrogen))
				return TRUE
			if(base < hydrogen)
				H.reagents.add_reagent(/datum/reagent/phosphorus, base)
				H.reagents.add_reagent(/datum/reagent/hydrogen, (hydrogen-base))
				return TRUE
	return
/datum/reagent/fuel
	name = "Welding fuel"
	description = "Required for welders. Flammable."
	color = "#660000" // rgb: 102, 0, 0
	taste_description = "gross metal"
	glass_icon_state = "dr_gibb_glass"
	glass_name = "glass of welder fuel"
	glass_desc = "Unless you're an industrial tool, this is probably not safe for consumption."
	process_flags = ORGANIC | SYNTHETIC
	accelerant_quality = 10

/datum/reagent/fuel/expose_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with welding fuel to make them easy to ignite!
	if((method == TOUCH || method == SMOKE) || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 10)
		return
	..()

/datum/reagent/fuel/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1, 0)
	..()
	return TRUE

/datum/reagent/space_cleaner
	name = "Space cleaner"
	description = "A compound used to clean things. Now with 50% more sodium hypochlorite!"
	color = "#A5F0EE" // rgb: 165, 240, 238
	taste_description = "sourness"
	reagent_weight = 0.6 //so it sprays further
	var/clean_types = CLEAN_WASH

/datum/reagent/space_cleaner/expose_obj(obj/O, reac_volume)
	O?.wash(clean_types)

/datum/reagent/space_cleaner/expose_turf(turf/T, reac_volume)
	if(reac_volume >= 1)
		T.wash(clean_types)
		for(var/atom/movable/movable_content in T)
			if(ismopable(movable_content)) // Mopables will be cleaned anyways by the turf wash
				continue
			movable_content.wash(clean_types)

		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(5,10))

/datum/reagent/space_cleaner/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE) || method == VAPOR)
		M.wash(clean_types)

/datum/reagent/space_cleaner/ez_clean
	name = "EZ Clean"
	description = "A powerful, acidic cleaner sold by Waffle Co. Affects organic matter while leaving other objects unaffected."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "acid"

/datum/reagent/space_cleaner/ez_clean/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(3.33)
	M.adjustFireLoss(3.33)
	M.adjustToxLoss(3.33)
	..()

/datum/reagent/space_cleaner/ez_clean/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	..()
	if(((method == TOUCH || method == SMOKE) || method == VAPOR) && !issilicon(M))
		M.adjustBruteLoss(1.5)
		M.adjustFireLoss(1.5)

/datum/reagent/cryptobiolin
	name = "Cryptobiolin"
	description = "Cryptobiolin causes confusion and dizziness."
	color = "#ADB5DB" //i hate default violets and 'crypto' keeps making me think of cryo so it's light blue now
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "sourness"

/datum/reagent/cryptobiolin/on_mob_life(mob/living/carbon/M)
	M.set_timed_status_effect(2 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	if(!M.confused)
		M.confused = 1
	M.confused = max(M.confused, 20)
	..()

/datum/reagent/impedrezene
	name = "Impedrezene"
	description = "Impedrezene is a narcotic that impedes one's ability by slowing down the higher brain cell functions."
	color = "#E07DDD" // pink = happy = dumb
	taste_description = "numbness"

/datum/reagent/impedrezene/on_mob_life(mob/living/carbon/M)
	M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(80))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM)
	if(prob(50))
		M.drowsyness = max(M.drowsyness, 3)
	..()

/datum/reagent/nanomachines
	name = "Nanomachines"
	description = "Microscopic construction robots."
	color = "#535E66" // rgb: 83, 94, 102
	can_synth = FALSE
	taste_description = "sludge"

/datum/reagent/nanomachines/expose_mob(mob/living/L, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(method==PATCH || method==INGEST || method==INJECT || (method == VAPOR && prob(min(reac_volume,100)*(1 - touch_protection))))
		L.ForceContractDisease(new /datum/disease/transformation/robot(), FALSE, TRUE)

/datum/reagent/xenomicrobes
	name = "Xenomicrobes"
	description = "Microbes with an entirely alien cellular structure."
	color = "#535E66" // rgb: 83, 94, 102
	can_synth = FALSE
	taste_description = "sludge"

/datum/reagent/xenomicrobes/expose_mob(mob/living/L, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(method==PATCH || method==INGEST || method==INJECT || (method == VAPOR && prob(min(reac_volume,100)*(1 - touch_protection))))
		L.ForceContractDisease(new /datum/disease/transformation/xeno(), FALSE, TRUE)

/datum/reagent/fungalspores
	name = "Tubercle bacillus Cosmosis microbes"
	description = "Active fungal spores."
	color = "#92D17D" // rgb: 146, 209, 125
	can_synth = FALSE
	taste_description = "slime"

/datum/reagent/fungalspores/expose_mob(mob/living/L, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(method==PATCH || method==INGEST || method==INJECT || (method == VAPOR && prob(min(reac_volume,100)*(1 - touch_protection))))
		L.ForceContractDisease(new /datum/disease/tuberculosis(), FALSE, TRUE)

/datum/reagent/snail
	name = "Agent-S"
	description = "Virological agent that infects the subject with Gastrolosis."
	color = "#003300" // rgb(0, 51, 0)
	taste_description = "goo"
	can_synth = FALSE //special orange man request

/datum/reagent/snail/expose_mob(mob/living/L, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(method==PATCH || method==INGEST || method==INJECT || (method == VAPOR && prob(min(reac_volume,100)*(1 - touch_protection))))
		L.ForceContractDisease(new /datum/disease/gastrolosis(), FALSE, TRUE)

/datum/reagent/fluorosurfactant//foam precursor
	name = "Fluorosurfactant"
	description = "A perfluoronated sulfonic acid that forms a foam when mixed with water."
	color = "#9E6B38" // rgb: 158, 107, 56
	taste_description = "metal"

/datum/reagent/foaming_agent// Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming agent"
	description = "An agent that yields metallic foam when mixed with light metal and a strong acid."
	reagent_state = SOLID
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"

/datum/reagent/smart_foaming_agent //Smart foaming agent. Functions similarly to metal foam, but conforms to walls.
	name = "Smart foaming agent"
	description = "An agent that yields metallic foam which conforms to area boundaries when mixed with light metal and a strong acid."
	reagent_state = SOLID
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"

/datum/reagent/ammonia
	name = "Ammonia"
	description = "A caustic substance commonly used in fertilizer or household cleaners."
	reagent_state = GAS
	color = "#404030" // rgb: 64, 64, 48
	taste_description = "mordant"

/datum/reagent/ammonia/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	// Ammonia is bad ass.
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 0.12))
		if(myseed && prob(10))
			myseed.adjust_yield(0.5)
			myseed.adjust_instability(-0.5)

/datum/reagent/diethylamine
	name = "Diethylamine"
	description = "A secondary amine, mildly corrosive."
	color = "#604030" // rgb: 96, 64, 48
	taste_description = "iron"

/datum/reagent/diethylamine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,2))
		if(myseed)
			myseed.adjust_yield(round(chems.get_reagent_amount(type) * 1))
			myseed.adjust_instability(-round(chems.get_reagent_amount(type) * 1))

/datum/reagent/carbondioxide
	name = "Carbon Dioxide"
	reagent_state = GAS
	description = "A gas commonly produced by burning carbon fuels. You're constantly producing this in your lungs."
	color = "#B0B0B0" // rgb : 192, 192, 192
	taste_description = "something unknowable"

/datum/reagent/carbondioxide/expose_obj(obj/O, reac_volume)
	if((!O) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	O.atmos_spawn_air("[GAS_CO2]=[reac_volume/5];TEMP=[temp]")

/datum/reagent/carbondioxide/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		var/temp = holder ? holder.chem_temp : T20C
		T.atmos_spawn_air("[GAS_CO2]=[reac_volume/5];TEMP=[temp]")
	return

// This is more bad ass, and pests get hurt by the corrosive nature of it, not the plant. The new trade off is it culls stability.
/datum/reagent/diethylamine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,2))
		if(myseed)
			myseed.adjust_yield(round(chems.get_reagent_amount(type) * 1))
			myseed.adjust_instability(-round(chems.get_reagent_amount(type) * 1))

/datum/reagent/nitrous_oxide
	name = "Nitrous Oxide"
	description = "A potent oxidizer used as fuel in rockets and as an anaesthetic during surgery."
	reagent_state = LIQUID
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#808080"
	taste_description = "sweetness"

/datum/reagent/nitrous_oxide/expose_obj(obj/O, reac_volume)
	if((!O) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	O.atmos_spawn_air("[GAS_NITROUS]=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		var/temp = holder ? holder.chem_temp : T20C
		T.atmos_spawn_air("[GAS_NITROUS]=[reac_volume/5];TEMP=[temp]")

/datum/reagent/nitrous_oxide/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == VAPOR)
		M.drowsyness += max(round(reac_volume, 1), 2)

/datum/reagent/nitrous_oxide/on_mob_life(mob/living/carbon/M)
	M.drowsyness += 2
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.blood_volume = max(H.blood_volume - 10, 0)
	if(prob(20))
		M.losebreath += 2
		M.confused = min(M.confused + 2, 5)
	..()
/* commented out till i make carbon monoxide poisoning a status effect)
/datum/reagent/carbon_monoxide
	name = "Carbon Monoxide"
	description = "A highly dangerous gas for sapients."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM
	color = "#96898c"
	var/accumulation

/datum/reagent/carbon_monoxide/on_mob_life(mob/living/carbon/victim)
	if(holder.has_reagent(/datum/reagent/oxygen))
		holder.remove_reagent(/datum/reagent/carbon_monoxide, 2*REM)
		accumulation = accumulation/4

	accumulation += volume
	switch(accumulation)
		if(10 to 50)
			to_chat(src, span_warning("You feel dizzy."))
		if(50 to 150)
			to_chat(victim, span_warning("[pick("Your head hurts.", "Your head pounds.")]"))
			victim.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE))
		if(150 to 250)
			to_chat(victim, span_userdanger("[pick("Your head hurts!", "You feel a burning knife inside your brain!", "A wave of pain fills your head!")]"))
			victim.Stun(10)
			victim.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE))
			victim.confused = (accumulation/50)
			victim.gain_trauma(/datum/brain_trauma/mild/monoxide_poisoning_stage1)

		if(250 to 350)
			to_chat(victim, span_userdanger("[pick("What were you doing...?", "Where are you...?", "What's going on...?")]"))
			victim.adjustStaminaLoss(3)

			victim.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE))
			victim.confused = (accumulation/50)
			victim.drowsyness = (accumulation/50)

			victim.adjustToxLoss(accumulation/100*REM, 0)

			victim.gain_trauma(/datum/brain_trauma/mild/monoxide_poisoning_stage2)

		if(350 to 1000)
			victim.Unconscious(20 SECONDS)

			victim.drowsyness += (accumulation/100)
			victim.adjustToxLoss(accumulation/100*REM, 0)
		if(1000 to INFINITY) //anti salt measure, if they reach this, just fucking kill them at this point
			victim.death()
			victim.cure_trauma_type(/datum/brain_trauma/mild/monoxide_poisoning_stage1)
			victim.cure_trauma_type(/datum/brain_trauma/mild/monoxide_poisoning_stage2)

			qdel(src)
			return TRUE
	accumulation -= (metabolization_rate * victim.metabolism_efficiency)
	if(accumulation <  0)
		holder.remove_reagent(/datum/reagent/carbon_monoxide, volume)
		return TRUE //to avoid a runtime
	return ..()

/datum/reagent/carbon_monoxide/expose_obj(obj/O, reac_volume)
	if((!O) || (!reac_volume))
		return FALSE
	var/temp = holder ? holder.chem_temp : T20C
	O.atmos_spawn_air("[GAS_CO]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/carbon_monoxide/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		var/temp = holder ? holder.chem_temp : T20C
		T.atmos_spawn_air("[GAS_CO]=[reac_volume/2];TEMP=[temp]")
	return

/datum/reagent/carbon_monoxide/on_mob_delete(mob/living/living_mob)
	var/mob/living/carbon/living_carbon = living_mob
	living_carbon.cure_trauma_type(/datum/brain_trauma/mild/monoxide_poisoning_stage1)
	living_carbon.cure_trauma_type(/datum/brain_trauma/mild/monoxide_poisoning_stage2)

*/

/datum/reagent/stimulum
	name = "Stimulum"
	description = "An unstable experimental gas that greatly increases the energy of those that inhale it." //WS Edit -- No longer references toxin damage.
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl/freon are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "E1A116"
	taste_description = "sourness"

/datum/reagent/stimulum/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_STUNIMMUNE, type)
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)

/datum/reagent/stimulum/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_STUNIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	..()

/datum/reagent/stimulum/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(-2*REM, 0)
	//M.adjustToxLoss(current_cycle*0.1*REM, 0) // 1 toxin damage per cycle at cycle 10 //WS Edit -- Stimulum no longer hurts you
	..()

/datum/reagent/nitryl
	name = "Nitryl"
	description = "A highly reactive gas that makes you feel faster."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl/freon are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "burning"

/datum/reagent/nitryl/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nitryl)

/datum/reagent/nitryl/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nitryl)
	..()

/datum/reagent/freon
	name = "Freon"
	description = "A powerful heat adsorbant."
	reagent_state = GAS
	metabolization_rate = REAGENTS_METABOLISM * 0.5 // Because stimulum/nitryl/freon are handled through gas breathing, metabolism must be lower for breathcode to keep up
	color = "90560B"
	taste_description = "burning"

/datum/reagent/freon/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)

/datum/reagent/freon/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/freon)
	return ..()

/////////////////////////Colorful Powder////////////////////////////
//For colouring in /proc/mix_color_from_reagents

/datum/reagent/colorful_reagent/powder
	name = "Mundane Powder" //the name's a bit similar to the name of colorful reagent, but hey, they're practically the same chem anyway
	var/colorname = "none"
	description = "A powder that is used for coloring things."
	reagent_state = SOLID
	color = "#FFFFFF" // rgb: 207, 54, 0
	taste_description = "the back of class"

/datum/reagent/colorful_reagent/powder/New()
	if(colorname == "none")
		description = "A rather mundane-looking powder. It doesn't look like it'd color much of anything..."
	else if(colorname == "invisible")
		description = "An invisible powder. Unfortunately, since it's invisible, it doesn't look like it'd color much of anything..."
	else
		description = "\An [colorname] powder, used for coloring things [colorname]."

/datum/reagent/colorful_reagent/powder/red
	name = "Red Powder"
	colorname = "red"
	color = "#DA0000" // red
	random_color_list = list("#FC7474")

/datum/reagent/colorful_reagent/powder/orange
	name = "Orange Powder"
	colorname = "orange"
	color = "#FF9300" // orange
	random_color_list = list("#FF9300")

/datum/reagent/colorful_reagent/powder/yellow
	name = "Yellow Powder"
	colorname = "yellow"
	color = "#FFF200" // yellow
	random_color_list = list("#FFF200")

/datum/reagent/colorful_reagent/powder/green
	name = "Green Powder"
	colorname = "green"
	color = "#A8E61D" // green
	random_color_list = list("#A8E61D")

/datum/reagent/colorful_reagent/powder/blue
	name = "Blue Powder"
	colorname = "blue"
	color = "#00B7EF" // blue
	random_color_list = list("#71CAE5")

/datum/reagent/colorful_reagent/powder/purple
	name = "Purple Powder"
	colorname = "purple"
	color = "#DA00FF" // purple
	random_color_list = list("#BD8FC4")

/datum/reagent/colorful_reagent/powder/invisible
	name = "Invisible Powder"
	colorname = "invisible"
	color = "#FFFFFF00" // white + no alpha
	random_color_list = list(null)	//because using the powder color turns things invisible

/datum/reagent/colorful_reagent/powder/black
	name = "Black Powder"
	colorname = "black"
	color = "#1C1C1C" // not quite black
	random_color_list = list("#8D8D8D")	//more grey than black, not enough to hide your true colors

/datum/reagent/colorful_reagent/powder/white
	name = "White Powder"
	colorname = "white"
	color = "#FFFFFF" // white
	random_color_list = list("#FFFFFF") //doesn't actually change appearance at all

/* used by crayons, can't color living things but still used for stuff like food recipes */

/datum/reagent/colorful_reagent/powder/red/crayon
	name = "Red Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/orange/crayon
	name = "Orange Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/yellow/crayon
	name = "Yellow Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/green/crayon
	name = "Green Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/blue/crayon
	name = "Blue Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/purple/crayon
	name = "Purple Crayon Powder"
	can_colour_mobs = FALSE

//datum/reagent/colorful_reagent/powder/invisible/crayon

/datum/reagent/colorful_reagent/powder/black/crayon
	name = "Black Crayon Powder"
	can_colour_mobs = FALSE

/datum/reagent/colorful_reagent/powder/white/crayon
	name = "White Crayon Powder"
	can_colour_mobs = FALSE

//////////////////////////////////Hydroponics stuff///////////////////////////////

/datum/reagent/plantnutriment
	name = "Generic nutriment"
	description = "Some kind of nutriment. You can't really tell what it is. You should probably report it, along with how you obtained it."
	color = "#000000" // RBG: 0, 0, 0
	var/tox_prob = 0
	taste_description = "plant food"

/datum/reagent/plantnutriment/on_mob_life(mob/living/carbon/M)
	if(prob(tox_prob))
		M.adjustToxLoss(1*REM, 0)
		. = 1
	..()

/datum/reagent/plantnutriment/eznutriment
	name = "E-Z-Nutrient"
	description = "Contains electrolytes. It's what plants crave."
	color = "#376400" // RBG: 50, 100, 0
	tox_prob = 10

/datum/reagent/plantnutriment/eznutriment/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		myseed.adjust_instability(0.2)
		myseed.adjust_potency(round(chems.get_reagent_amount(type) * 0.3))
		myseed.adjust_yield(round(chems.get_reagent_amount(type) * 0.1))

/datum/reagent/plantnutriment/left4zednutriment
	name = "Left 4 Zed"
	description = "Unstable nutriment that makes plants mutate more often than usual."
	color = "#1A1E4D" // RBG: 26, 30, 77
	tox_prob = 25

/datum/reagent/plantnutriment/left4zednutriment/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 0.1))
		myseed.adjust_instability(round(chems.get_reagent_amount(type) * 0.2))

/datum/reagent/plantnutriment/robustharvestnutriment
	name = "Robust Harvest"
	description = "Very potent nutriment that slows plants from mutating."
	color = "#9D9D00" // RBG: 157, 157, 0
	tox_prob = 15

/datum/reagent/plantnutriment/robustharvestnutriment/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		myseed.adjust_instability(-0.25)
		myseed.adjust_potency(round(chems.get_reagent_amount(type) * 0.1))
		myseed.adjust_yield(round(chems.get_reagent_amount(type) * 0.2))

/datum/reagent/plantnutriment/endurogrow
	name = "Enduro Grow"
	description = "A specialized nutriment, which decreases product quantity and potency, but strengthens the plants endurance."
	color = "#a06fa7" // RBG: 160, 111, 167
	tox_prob = 15

/datum/reagent/plantnutriment/endurogrow/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		myseed.adjust_potency(-round(chems.get_reagent_amount(type) * 0.1))
		myseed.adjust_yield(-round(chems.get_reagent_amount(type) * 0.075))
		myseed.adjust_endurance(round(chems.get_reagent_amount(type) * 0.35))

/datum/reagent/plantnutriment/liquidearthquake
	name = "Liquid Earthquake"
	description = "A specialized nutriment, which increases the plant's production speed, as well as it's susceptibility to weeds."
	color = "#912e00" // RBG: 145, 46, 0
	tox_prob = 25

/datum/reagent/plantnutriment/liquidearthquake/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray)
	. = ..()
	if(myseed && chems.has_reagent(type, 1))
		myseed.adjust_weed_rate(round(chems.get_reagent_amount(type) * 0.1))
		myseed.adjust_weed_chance(round(chems.get_reagent_amount(type) * 0.3))
		myseed.adjust_production(-round(chems.get_reagent_amount(type) * 0.075))

// GOON OTHERS

/datum/reagent/fuel/oil
	name = "Oil"
	description = "Burns in a small smoky fire, can be used to get Ash."
	reagent_state = LIQUID
	color = "#2D2D2D"
	taste_description = "oil"
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/stable_plasma
	name = "Stable Plasma"
	description = "Non-flammable plasma locked into a liquid form that cannot ignite or become gaseous/solid."
	reagent_state = LIQUID
	color = "#2D2D2D"
	taste_description = "bitterness"
	taste_mult = 1.5
	process_flags = ORGANIC | SYNTHETIC //WS Edit - IPCs

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/C)
	C.adjustPlasma(10)
	..()

/datum/reagent/iodine
	name = "Iodine"
	description = "Commonly added to table salt as a nutrient. On its own it tastes far less pleasing."
	reagent_state = LIQUID
	color = "#BC8A00"
	taste_description = "metal"

/datum/reagent/iodine/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/scanning_module))
		H.reagents.add_reagent(/datum/reagent/bromine, (H.reagents.remove_reagent(/datum/reagent/iodine, 5*I.get_part_rating())))
		return TRUE
	return

/datum/reagent/carpet
	name = "Carpet"
	description = "For those that need a more creative way to roll out a red carpet."
	reagent_state = LIQUID
	color = "#771100"
	taste_description = "carpet" // Your tounge feels furry.
	var/carpet_type = /turf/open/floor/carpet

/datum/reagent/carpet/expose_turf(turf/T, reac_volume)
	if(isplatingturf(T) || istype(T, /turf/open/floor/plasteel))
		var/turf/open/floor/F = T
		F.PlaceOnTop(carpet_type, flags = CHANGETURF_INHERIT_AIR)
	..()

/datum/reagent/carpet/black
	name = "Black Carpet"
	description = "The carpet also comes in... BLAPCK" //yes, the typo is intentional
	color = "#1E1E1E"
	taste_description = "licorice"
	carpet_type = /turf/open/floor/carpet/black

/datum/reagent/carpet/blue
	name = "Blue Carpet"
	description = "For those that really need to chill out for a while."
	color = "#0000DC"
	taste_description = "frozen carpet"
	carpet_type = /turf/open/floor/carpet/blue

/datum/reagent/carpet/cyan
	name = "Cyan Carpet"
	description = "For those that need a throwback to the years of using poison as a construction material. Smells like asbestos."
	color = "#00B4FF"
	taste_description = "asbestos"
	carpet_type = /turf/open/floor/carpet/cyan

/datum/reagent/carpet/green
	name = "Green Carpet"
	description = "For those that need the perfect flourish for green eggs and ham."
	color = "#A8E61D"
	taste_description = "Green" //the caps is intentional
	carpet_type = /turf/open/floor/carpet/green

/datum/reagent/carpet/orange
	name = "Orange Carpet"
	description = "For those that prefer a healthy carpet to go along with their healthy diet."
	color = "#E78108"
	taste_description = "orange juice"
	carpet_type = /turf/open/floor/carpet/orange

/datum/reagent/carpet/purple
	name = "Purple Carpet"
	description = "For those that need to waste copious amounts of healing jelly in order to look fancy."
	color = "#91D865"
	taste_description = "jelly"
	carpet_type = /turf/open/floor/carpet/purple

/datum/reagent/carpet/red
	name = "Red Carpet"
	description = "For those that need an even redder carpet."
	color = "#731008"
	taste_description = "blood and gibs"
	carpet_type = /turf/open/floor/carpet/red

/datum/reagent/carpet/royal
	name = "Royal Carpet?"
	description = "For those that break the game and need to make an issue report."

/datum/reagent/carpet/royal/black
	name = "Royal Black Carpet"
	description = "For those that feel the need to show off their timewasting skills."
	color = "#000000"
	taste_description = "royalty"
	carpet_type = /turf/open/floor/carpet/royalblack

/datum/reagent/carpet/royal/blue
	name = "Royal Blue Carpet"
	description = "For those that feel the need to show off their timewasting skills.. in BLUE."
	color = "#5A64C8"
	taste_description = "blueyalty" //also intentional
	carpet_type = /turf/open/floor/carpet/royalblue

//the ultimate fertilizer
/datum/reagent/genesis
	name = "Genesis Serum"
	description = "A mysterious substance capable of spontaneously gestating plant life when given a surface to adhere to."
	color = "#328242"
	taste_description = "primordial essence"
	reagent_state = LIQUID
	var/list/turf_whitelist = list(
	/turf/open/floor/plating/asteroid,
	/turf/open/lava,
	/turf/open/water/acid,
	/turf/open/floor/plating/moss,
	)

/datum/reagent/genesis/expose_turf(turf/exposed_turf, reac_volume)
	var/allowed = FALSE //idk how to do this better
	for(var/turf/checked_turf as anything in turf_whitelist)
		if(!istype(exposed_turf, checked_turf))
			continue
		else
			allowed = TRUE
			break
	if(!allowed)
		return ..()

	if(isopenturf(exposed_turf))
		var/turf/open/floor/terraform_target = exposed_turf

		if(istype(terraform_target, /turf/open/lava) || istype(terraform_target, /turf/open/water/acid)) //if hazard, reeplace with basin
			if(istype(terraform_target, /turf/open/lava))
				terraform_target.ChangeTurf(/turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin, flags = CHANGETURF_INHERIT_AIR)
			if(istype(terraform_target, /turf/open/water/acid))
				terraform_target.ChangeTurf(/turf/open/floor/plating/asteroid/whitesands/dried, flags = CHANGETURF_INHERIT_AIR)
			terraform_target.visible_message("<span class='notice'>As the serum touches [terraform_target.name], it all starts drying up, leaving a dry basin behind!</span>")
			playsound(exposed_turf, 'sound/effects/bubbles.ogg', 50)
			return ..()

		if(istype(terraform_target, /turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin) || istype(terraform_target, /turf/open/floor/plating/asteroid/whitesands/dried)|| istype(terraform_target, /turf/open/floor/plating/asteroid/sand)) //if basin, replace with water
			return ..()

		if(istype(terraform_target, /turf/open/floor/plating/asteroid/purple))
			terraform_target.ChangeTurf(/turf/open/floor/plating/asteroid/sand/terraform, flags = CHANGETURF_INHERIT_AIR)
			terraform_target.visible_message("<span class='notice'>The chemicals in the sand disolve, and the sand looks more natural.</span>")
			playsound(exposed_turf, 'sound/effects/bubbles.ogg', 50)
			return ..()

		if(!istype(terraform_target, /turf/open/floor/plating/asteroid/dirt)) // if not dirt, acutally terraform
			terraform_target.ChangeTurf(/turf/open/floor/plating/asteroid/dirt, flags = CHANGETURF_INHERIT_AIR)
			terraform_target.visible_message("<span class='notice'>The harsh land becomes fertile dirt, but more work needs to be done for it to be growable and breathable. Perhaps add grass?</span>")
			playsound(exposed_turf, 'sound/effects/bubbles.ogg', 50)
			return ..()


		if(istype(terraform_target, /turf/open/floor/plating/asteroid/dirt/grass)) //if grass, plant shit
			for(var/obj/object as anything in terraform_target.contents)
				if(!istype(object, /obj/structure/flora))
					continue
				terraform_target.visible_message("<span class='danger'>Theres already flora on the tile!</span>")
				return ..()

			terraform_target.visible_message("<span class='notice'>As the serum touches the grass, suddenly flora grows out of it!</span>")
			playsound(exposed_turf, 'sound/effects/bubbles.ogg', 50)
			if(prob(70))
				new /obj/effect/spawner/random/flower(exposed_turf)
			else if(prob(5))
				new /obj/structure/flora/ash/garden(exposed_turf)
			else
				new /obj/effect/spawner/random/flora(exposed_turf)

	return ..()

/datum/reagent/genesis/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		if(myseed)
			myseed.adjust_potency(round(chems.get_reagent_amount(type)))
			myseed.adjust_yield(round(chems.get_reagent_amount(type) * 0.5))
			myseed.adjust_endurance(round(chems.get_reagent_amount(type) * 0.5))
			myseed.adjust_production(round(chems.get_reagent_amount(type) * 0.5))
			myseed.adjust_lifespan(round(chems.get_reagent_amount(type) * 0.5))

/datum/reagent/bromine
	name = "Bromine"
	description = "A brownish liquid that's highly reactive. Useful for stopping free radicals, but not intended for human consumption."
	reagent_state = LIQUID
	color = "#D35415"
	taste_description = "chemicals"

/datum/reagent/bromine/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/scanning_module))
		H.reagents.add_reagent(/datum/reagent/chlorine, (H.reagents.remove_reagent(/datum/reagent/bromine, 5*I.get_part_rating())))
		return TRUE
	return

/datum/reagent/pentaerythritol
	name = "Pentaerythritol"
	description = "Slow down, it ain't no spelling bee!"
	reagent_state = SOLID
	color = "#E66FFF"
	taste_description = "acid"

/datum/reagent/acetaldehyde
	name = "Acetaldehyde"
	description = "Similar to plastic. Tastes like dead people."
	reagent_state = SOLID
	color = "#EEEEEF"
	taste_description = "dead people" //made from formaldehyde, ya get da joke ?

/datum/reagent/acetone_oxide
	name = "Acetone oxide"
	description = "Enslaved oxygen"
	reagent_state = LIQUID
	color = "#C8A5DC"
	taste_description = "acid"


/datum/reagent/acetone_oxide/expose_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people kills people!
	if(!istype(M))
		return
	if(method == TOUCH || method == SMOKE)
		M.adjustFireLoss(2, FALSE) // burns,
		M.adjust_fire_stacks((reac_volume / 10))
	..()

/datum/reagent/phenol
	name = "Phenol"
	description = "An aromatic ring of carbon with a hydroxyl group. A useful precursor to some medicines, but has no healing properties on its own."
	reagent_state = LIQUID
	color = "#E7EA91"
	taste_description = "acid"

/datum/reagent/ash
	name = "Ash"
	description = "Supposedly phoenixes rise from these, but you've never seen it."
	reagent_state = LIQUID
	color = "#515151"
	taste_description = "ash"

/datum/reagent/ash/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(istype(I, /obj/item/stock_parts/scanning_module))
		H.reagents.add_reagent(/datum/reagent/carbon, (H.reagents.remove_reagent(/datum/reagent/ash, 10*I.get_part_rating())/3)) ///consistent with the amount of carbon used to make ash
		return TRUE
	return

/datum/reagent/ash/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustWeeds(-1)

/datum/reagent/acetone
	name = "Acetone"
	description = "A slick, slightly carcinogenic liquid. Has a multitude of mundane uses in everyday life."
	reagent_state = LIQUID
	color = "#AF14B7"
	taste_description = "acid"

/datum/reagent/colorful_reagent
	name = "Colorful Reagent"
	description = "Thoroughly sample the rainbow."
	reagent_state = LIQUID
	var/list/random_color_list = list("#00aedb","#a200ff","#f47835","#d41243","#d11141","#00b159","#00aedb","#f37735","#ffc425","#008744","#0057e7","#d62d20","#ffa700")
	color = "#C8A5DC"
	taste_description = "rainbows"
	var/can_colour_mobs = TRUE

/datum/reagent/colorful_reagent/New()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(UpdateColor)))

/datum/reagent/colorful_reagent/proc/UpdateColor()
	color = pick(random_color_list)

/datum/reagent/colorful_reagent/on_mob_life(mob/living/carbon/M)
	if(can_colour_mobs)
		M.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	return ..()

/// Colors anything it touches a random color.
/datum/reagent/colorful_reagent/expose_atom(mob/living/M, reac_volume)
	if(can_colour_mobs)
		M.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	..()

/datum/reagent/hair_dye
	name = "Quantum Hair Dye"
	description = "Has a high chance of making you look like a mad scientist."
	reagent_state = LIQUID
	var/list/potential_colors = list("0ad","a0f","f73","d14","d14","0b5","0ad","f73","fc2","084","05e","d22","fa0") // fucking hair code
	color = "#C8A5DC"
	taste_description = "sourness"

/datum/reagent/hair_dye/New()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(UpdateColor)))

/datum/reagent/hair_dye/proc/UpdateColor()
	color = pick(potential_colors)

/datum/reagent/hair_dye/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE)  || method == VAPOR)
		if(M && ishuman(M))
			var/mob/living/carbon/human/H = M
			H.hair_color = pick(potential_colors)
			H.facial_hair_color = pick(potential_colors)
			H.update_hair()

/datum/reagent/barbers_aid
	name = "Barber's Aid"
	description = "A solution to hair loss across the world."
	reagent_state = LIQUID
	color = "#A86B45" //hair is brown
	taste_description = "sourness"

/datum/reagent/barbers_aid/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE)  || method == VAPOR)
		if(M && ishuman(M) && !HAS_TRAIT(M, TRAIT_BALD))
			var/mob/living/carbon/human/H = M
			var/datum/sprite_accessory/hair/picked_hair = pick(GLOB.hairstyles_list)
			var/datum/sprite_accessory/facial_hair/picked_beard = pick(GLOB.facial_hairstyles_list)
			to_chat(H, span_notice("Hair starts sprouting from your scalp."))
			H.hairstyle = picked_hair
			H.facial_hairstyle = picked_beard
			H.update_hair()

/datum/reagent/concentrated_barbers_aid
	name = "Concentrated Barber's Aid"
	description = "A concentrated solution to hair loss across the world."
	reagent_state = LIQUID
	color = "#7A4E33" //hair is dark browmn
	taste_description = "sourness"

/datum/reagent/concentrated_barbers_aid/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE)  || method == VAPOR)
		if(M && ishuman(M) && !HAS_TRAIT(M, TRAIT_BALD))
			var/mob/living/carbon/human/H = M
			to_chat(H, span_notice("Your hair starts growing at an incredible speed!"))
			H.hairstyle = "Very Long Hair"
			H.facial_hairstyle = "Beard (Very Long)"
			H.update_hair()

/datum/reagent/baldium
	name = "Baldium"
	description = "A major cause of hair loss across the world."
	reagent_state = LIQUID
	color = "#ecb2cf"
	taste_description = "bitterness"

/datum/reagent/baldium/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if((method == TOUCH || method == SMOKE)  || method == VAPOR)
		if(M && ishuman(M))
			var/mob/living/carbon/human/H = M
			to_chat(H, span_danger("Your hair is falling out in clumps!"))
			H.hairstyle = "Bald"
			H.facial_hairstyle = "Shaved"
			H.update_hair()

/datum/reagent/saltpetre
	name = "Saltpetre"
	description = "Volatile. Controversial. Third Thing."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	taste_description = "cool salt"

/datum/reagent/saltpetre/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		var/salt = chems.get_reagent_amount(type)
		mytray.adjustHealth(round(salt * 0.18))
		if(myseed)
			myseed.adjust_production(-round(salt/10)-prob(salt%10))
			myseed.adjust_potency(round(salt))

/datum/reagent/lye
	name = "Lye"
	description = "Also known as sodium hydroxide. As a profession making this is somewhat underwhelming."
	reagent_state = LIQUID
	color = "#FFFFD6" // very very light yellow
	taste_description = "acid"

/datum/reagent/drying_agent
	name = "Drying agent"
	description = "A desiccant. Can be used to dry things."
	reagent_state = LIQUID
	color = "#A70FFF"
	taste_description = "dryness"

/datum/reagent/drying_agent/expose_turf(turf/open/T, reac_volume)
	if(istype(T))
		T.MakeDry(ALL, TRUE, reac_volume * 5 SECONDS)		//50 deciseconds per unit

// Virology virus food chems.

/datum/reagent/toxin/mutagen/mutagenvirusfood
	name = "mutagenic agar"
	color = "#A3C00F" // rgb: 163,192,15
	taste_description = "sourness"

/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar
	name = "sucrose agar"
	color = "#41B0C0" // rgb: 65,176,192
	taste_description = "sweetness"

/datum/reagent/medicine/synaptizine/synaptizinevirusfood
	name = "virus rations"
	color = "#D18AA5" // rgb: 209,138,165
	taste_description = "bitterness"

/datum/reagent/toxin/plasma/plasmavirusfood
	name = "virus plasma"
	color = "#A270A8" // rgb: 166,157,169
	taste_description = "bitterness"
	taste_mult = 1.5

/datum/reagent/toxin/plasma/plasmavirusfood/weak
	name = "weakened virus plasma"
	color = "#A28CA5" // rgb: 206,195,198
	taste_description = "bitterness"
	taste_mult = 1.5

/datum/reagent/uranium/uraniumvirusfood
	name = "decaying uranium gel"
	color = "#67ADBA" // rgb: 103,173,186
	taste_description = "the inside of a reactor"

/datum/reagent/uranium/uraniumvirusfood/unstable
	name = "unstable uranium gel"
	color = "#2FF2CB" // rgb: 47,242,203
	taste_description = "the inside of a reactor"

/datum/reagent/uranium/uraniumvirusfood/stable
	name = "stable uranium gel"
	color = "#04506C" // rgb: 4,80,108
	taste_description = "the inside of a reactor"

// Bee chemicals

/datum/reagent/royal_bee_jelly
	name = "royal bee jelly"
	description = "Royal Bee Jelly, if injected into a Queen Space Bee said bee will split into two bees."
	color = "#00ff80"
	taste_description = "strange honey"

//Misc reagents

/datum/reagent/romerol
	name = "Romerol"
	// the REAL zombie powder
	description = "Romerol is a highly experimental bioterror agent \
		which causes dormant nodules to be etched into the grey matter of \
		the subject. These nodules only become active upon death of the \
		host, upon which, the secondary structures activate and take control \
		of the host body."
	color = "#123524" // RGB (18, 53, 36)
	metabolization_rate = INFINITY
	can_synth = FALSE
	taste_description = "brains"

/datum/reagent/romerol/expose_mob(mob/living/carbon/human/H, method=TOUCH, reac_volume)
	// Silently add the zombie infection organ to be activated upon death
	if(!H.getorganslot(ORGAN_SLOT_ZOMBIE))
		var/obj/item/organ/zombie_infection/nodamage/ZI = new()
		ZI.Insert(H)
	..()

/datum/reagent/magillitis
	name = "Magillitis"
	description = "An experimental serum which causes rapid muscular growth in Hominidae. Side-affects may include hypertrichosis, violent outbursts, and an unending affinity for bananas."
	reagent_state = LIQUID
	color = "#00f041"

/datum/reagent/magillitis/on_mob_life(mob/living/carbon/M)
	..()
	if((ismonkey(M) || ishuman(M)) && current_cycle >= 10)
		M.gorillize()

/datum/reagent/growthserum
	name = "Growth Serum"
	description = "A strange chemical that causes growth, but wears off over time. The growth effect is limited."
	color = "#ff0000"//strong red. rgb 255, 0, 0
	var/current_size = RESIZE_DEFAULT_SIZE
	taste_description = "bitterness"

/datum/reagent/growthserum/on_mob_life(mob/living/carbon/H)
	var/newsize = current_size
	newsize = (1 + (clamp(volume, 0, 25) / 100)) * RESIZE_DEFAULT_SIZE
	H.resize = newsize/current_size
	current_size = newsize
	H.update_transform()
	..()

/datum/reagent/growthserum/on_mob_end_metabolize(mob/living/M)
	M.resize = RESIZE_DEFAULT_SIZE/current_size
	current_size = RESIZE_DEFAULT_SIZE
	M.update_transform()
	..()

/datum/reagent/plastic_polymers
	name = "plastic polymers"
	description = "the petroleum based components of plastic."
	color = "#f7eded"
	taste_description = "plastic"

/datum/reagent/glitter
	name = "generic glitter"
	description = "if you can see this description, contact a coder."
	color = "#FFFFFF" //pure white
	taste_description = "plastic"
	reagent_state = SOLID
	var/glitter_type = /obj/effect/decal/cleanable/glitter

/datum/reagent/glitter/expose_turf(turf/T, reac_volume)
	if(!istype(T))
		return
	new glitter_type(T)

/datum/reagent/glitter/pink
	name = "pink glitter"
	description = "pink sparkles that get everywhere"
	color = "#ff8080" //A light pink color
	glitter_type = /obj/effect/decal/cleanable/glitter/pink

/datum/reagent/glitter/white
	name = "white glitter"
	description = "white sparkles that get everywhere"
	glitter_type = /obj/effect/decal/cleanable/glitter/white

/datum/reagent/glitter/blue
	name = "blue glitter"
	description = "blue sparkles that get everywhere"
	color = "#4040FF" //A blueish color
	glitter_type = /obj/effect/decal/cleanable/glitter/blue

/datum/reagent/pax
	name = "Pax"
	description = "A colorless liquid that suppresses violence in its subjects."
	color = "#AAAAAA55"
	taste_description = "water"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM

/datum/reagent/pax/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PACIFISM, type)

/datum/reagent/pax/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PACIFISM, type)
	..()

/datum/reagent/bz_metabolites
	name = "BZ metabolites"
	description = "A harmless metabolite of BZ gas."
	color = "#FAFF00"
	taste_description = "acrid cinnamon"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM

/datum/reagent/bz_metabolites/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, CHANGELING_HIVEMIND_MUTE, type)

/datum/reagent/bz_metabolites/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, CHANGELING_HIVEMIND_MUTE, type)

/datum/reagent/bz_metabolites/on_mob_life(mob/living/L)
	if(L.mind)
		var/datum/antagonist/changeling/changeling = L.mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling)
			changeling.chem_charges = max(changeling.chem_charges-2, 0)
	return ..()

/datum/reagent/pax/peaceborg
	name = "Synthpax"
	description = "A colorless liquid that suppresses violence in its subjects. Cheaper to synthesize than normal Pax, but wears off faster."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM

/datum/reagent/peaceborg
	name = "Abstract Peaceborg Reagent"
	can_synth = FALSE

/datum/reagent/peaceborg/confuse
	name = "Dizzying Solution"
	description = "Makes the target off balance and dizzy"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "dizziness"
	can_synth = TRUE

/datum/reagent/peaceborg/confuse/on_mob_life(mob/living/carbon/M)
	if(M.confused < 6)
		M.confused = clamp(M.confused + 3, 0, 5)
	M.adjust_timed_status_effect(-6 SECONDS, /datum/status_effect/dizziness)
	if(prob(20))
		to_chat(M, "You feel confused and disoriented.")
	..()

/datum/reagent/peaceborg/tire
	name = "Tiring Solution"
	description = "An extremely weak stamina-toxin that tires out the target. Completely harmless."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "tiredness"
	can_synth = TRUE

/datum/reagent/peaceborg/tire/on_mob_life(mob/living/carbon/M)
	var/healthcomp = (100 - M.health)	//DOES NOT ACCOUNT FOR ADMINBUS THINGS THAT MAKE YOU HAVE MORE THAN 200/210 HEALTH, OR SOMETHING OTHER THAN A HUMAN PROCESSING THIS.
	if(M.getStaminaLoss() < (45 - healthcomp))	//At 50 health you would have 200 - 150 health meaning 50 compensation. 60 - 50 = 10, so would only do 10-19 stamina.)
		M.adjustStaminaLoss(10)
	if(prob(30))
		to_chat(M, "You should sit down and take a rest...")
	..()

/datum/reagent/spider_extract
	name = "Spider Extract"
	description = "A highly specialized extract coming from the Australicus sector, used to create broodmother spiders."
	color = "#ED2939"
	taste_description = "upside down"
	can_synth = FALSE

/// Improvised reagent that induces vomiting. Created by dipping a dead mouse in welder fluid.
/datum/reagent/yuck
	name = "Organic Slurry"
	description = "A mixture of various colors of fluid. Induces vomiting."
	glass_name = "glass of ...yuck!"
	glass_desc = "It smells like a carcass, and doesn't look much better."
	color = "#545000"
	taste_description = "insides"
	taste_mult = 4
	can_synth = FALSE
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	var/yuck_cycle = 0 //! The `current_cycle` when puking starts.

/datum/reagent/yuck/on_mob_add(mob/living/L)
	if(HAS_TRAIT(L, TRAIT_NOHUNGER)) //they can't puke
		holder.del_reagent(type)

#define YUCK_PUKE_CYCLES 3 		// every X cycle is a puke
#define YUCK_PUKES_TO_STUN 3 	// hit this amount of pukes in a row to start stunning
/datum/reagent/yuck/on_mob_life(mob/living/carbon/C)
	if(!yuck_cycle)
		if(prob(8))
			var/dread = pick("Something is moving in your stomach...", \
				"A wet growl echoes from your stomach...", \
				"For a moment you feel like your surroundings are moving, but it's your stomach...")
			to_chat(C, span_userdanger("[dread]"))
			yuck_cycle = current_cycle
	else
		var/yuck_cycles = current_cycle - yuck_cycle
		if(yuck_cycles % YUCK_PUKE_CYCLES == 0)
			if(yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
				holder.remove_reagent(type, 5)
			C.vomit(rand(14, 26), stun = yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
	if(holder)
		return ..()
#undef YUCK_PUKE_CYCLES
#undef YUCK_PUKES_TO_STUN

/datum/reagent/yuck/on_mob_end_metabolize(mob/living/L)
	yuck_cycle = 0 // reset vomiting
	return ..()

/datum/reagent/yuck/on_transfer(atom/A, method=TOUCH, trans_volume)
	if(method == INGEST || !iscarbon(A))
		return ..()

	A.reagents.remove_reagent(type, trans_volume)
	A.reagents.add_reagent(/datum/reagent/fuel, trans_volume * 0.75)
	A.reagents.add_reagent(/datum/reagent/water, trans_volume * 0.25)

	return ..()

//monkey powder heehoo
/datum/reagent/monkey_powder
	name = "Monkey Powder"
	description = "Just add water!"
	color = "#9C5A19"
	taste_description = "bananas"
	can_synth = TRUE

/datum/reagent/wittel
	name = "Wittel"
	description = "An extremely rare metallic-white substance only found on demon-class planets."
	color = "#FFFFFF" // rgb: 255, 255, 255
	taste_mult = 0 // oderless and tasteless

/datum/reagent/metalgen
	name = "Metalgen"
	data = list("material"=null)
	description = "A purple metal morphic liquid, said to impose it's metallic properties on whatever it touches."
	color = "#b000aa"
	taste_mult = 0 // oderless and tasteless
	var/applied_material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	var/minumum_material_amount = 100

/datum/reagent/metalgen/expose_obj(obj/O, volume)
	metal_morph(O)
	return

/datum/reagent/metalgen/expose_turf(turf/T, volume)
	metal_morph(T)
	return

///turn an object into a special material
/datum/reagent/metalgen/proc/metal_morph(atom/A)
	var/metal_ref = data["material"]
	if(!metal_ref)
		return
	var/metal_amount = 0

	for(var/B in A.custom_materials) //list with what they're made of
		metal_amount += A.custom_materials[B]

	if(!metal_amount)
		metal_amount = minumum_material_amount //some stuff doesn't have materials at all. To still give them properties, we give them a material. Basically doesnt exist

	var/list/metal_dat = list()
	metal_dat[metal_ref] = metal_amount //if we pass the list directly, byond turns metal_ref into "metal_ref" kjewrg8fwcyvf

	A.material_flags = applied_material_flags
	A.set_custom_materials(metal_dat)

/datum/reagent/gravitum
	name = "Gravitum"
	description = "A rare kind of null fluid, capable of temporalily removing all weight of whatever it touches." //i dont even
	color = "#050096" // rgb: 5, 0, 150
	taste_mult = 0 // oderless and tasteless
	metabolization_rate = 0.1 * REAGENTS_METABOLISM //20 times as long, so it's actually viable to use
	var/time_multiplier = 1 MINUTES //1 minute per unit of gravitum on objects. Seems overpowered, but the whole thing is very niche

/datum/reagent/gravitum/expose_obj(obj/O, volume)
	O.AddElement(/datum/element/forced_gravity, 0)

	addtimer(CALLBACK(O, PROC_REF(_RemoveElement), list(/datum/element/forced_gravity, 0)), volume * time_multiplier)

/datum/reagent/gravitum/on_mob_add(mob/living/L)
	L.AddElement(/datum/element/forced_gravity, 0) //0 is the gravity, and in this case weightless

/datum/reagent/gravitum/on_mob_end_metabolize(mob/living/L)
	L.RemoveElement(/datum/element/forced_gravity, 0)

/datum/reagent/cellulose
	name = "Cellulose Fibers"
	description = "A crystaline polydextrose polymer, plants swear by this stuff."
	reagent_state = SOLID
	color = "#E6E6DA"
	taste_mult = 0

/datum/reagent/consumable/gravy
	name = "Gravy"
	description = "A mixture of flour, water, and the juices of cooked meat."
	taste_description = "gravy"
	color = "#623301"
	taste_mult = 1.2


/datum/reagent/liquidadamantine
	name = "Liquid Adamantine"
	description = "A legengary lifegiving metal liquified."
	color = "#10cca6" //RGB: 16, 204, 166
	taste_description = "lifegiving metal"
	can_synth = FALSE

/datum/reagent/determination
	name = "Determination"
	description = "For when you need to push on a little more. Do NOT allow near plants."
	reagent_state = LIQUID
	color = "#D2FFFA"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM // 5u (WOUND_DETERMINATION_CRITICAL) will last for ~17 ticks
	self_consuming = TRUE
	taste_description = "pure determination"
	overdose_threshold = 45
	/// Whether we've had at least WOUND_DETERMINATION_SEVERE (2.5u) of determination at any given time. No damage slowdown immunity or indication we're having a second wind if it's just a single moderate wound
	var/significant = FALSE

/datum/reagent/determination/on_mob_life(mob/living/carbon/M)
	if(!significant && volume >= WOUND_DETERMINATION_SEVERE)
		significant = TRUE
		M.apply_status_effect(STATUS_EFFECT_DETERMINED) // in addition to the slight healing, limping cooldowns are divided by 4 during the combat high

	volume = min(volume, WOUND_DETERMINATION_MAX)

	for(var/thing in M.all_wounds)
		var/datum/wound/W = thing
		var/obj/item/bodypart/wounded_part = W.limb
		if(wounded_part)
			wounded_part.heal_damage(0.25, 0.25)
		M.adjustStaminaLoss(-0.25*REM) // the more wounds, the more stamina regen
	..()

/datum/reagent/determination/on_mob_end_metabolize(mob/living/carbon/M)
	if(significant)
		var/stam_crash = 0
		for(var/thing in M.all_wounds)
			var/datum/wound/W = thing
			stam_crash += (W.severity + 1) * 3 // spike of 3 stam damage per wound severity (moderate = 6, severe = 9, critical = 12) when the determination wears off if it was a combat rush
		M.adjustStaminaLoss(stam_crash)
	M.remove_status_effect(STATUS_EFFECT_DETERMINED)
	..()

/datum/reagent/determination/overdose_process(mob/living/carbon/human/H)
	to_chat(H,span_danger("You feel your heart rupturing in two!"))
	H.adjustStaminaLoss(10)
	H.adjustOrganLoss(ORGAN_SLOT_HEART,100)
	H.set_heartattack(TRUE)

/datum/reagent/crystal_reagent
	name = "Crystal Reagent"
	description = "A strange crystalline substance with an impressive healing factor."
	reagent_state = LIQUID
	color = "#1B9681"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 20
	taste_description = "sharp rocks"
	var/healing = 2

/datum/reagent/crystal_reagent/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-healing*REM, 0)
	M.adjustOxyLoss(-healing*REM, 0)
	M.adjustBruteLoss(-healing*REM, 0)
	M.adjustFireLoss(-healing*REM, 0)
	..()
	. = 1

/datum/reagent/crystal_reagent/overdose_process(mob/living/carbon/human/H)
	to_chat(H,span_danger("You feel your heart rupturing in two!"))
	H.adjustStaminaLoss(10)
	H.adjustOrganLoss(ORGAN_SLOT_HEART,100)
	H.set_heartattack(TRUE)

/datum/reagent/three_eye
	name = "Three Eye"
	taste_description = "liquid starlight"
	taste_mult = 100
	description = "Out on the edge of human space, at the limits of scientific understanding and \
	cultural taboo, people develop and dose themselves with substances that would curl the hair on \
	a brinker's vatgrown second head. Three Eye is one of the most notorious narcotics to ever come \
	out of the independant habitats, and has about as much in common with recreational drugs as a \
	Stok does with an Unathi strike trooper. It is equally effective on humans, Skrell, dionaea and \
	probably the Captain's cat, and distributing it will get you guaranteed jail time in every \
	human territory."
	reagent_state = LIQUID
	color = "#ccccff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 25
	var/worthy = FALSE

	var/static/list/dose_messages = list(
		"Your name is called. It is your time.",
		"You are dissolving. Your hands are wax...",
		"It all runs together. It all mixes.",
		"It is done. It is over. You are done. You are over.",
		"You won't forget. Don't forget. Don't forget.",
		"Light seeps across the edges of your vision...",
		"Something slides and twitches within your sinus cavity...",
		"Your bowels roil. It waits within.",
		"Your gut churns. You are heavy with potential.",
		"Your heart flutters. It is winged and caged in your chest.",
		"There is a precious thing, behind your eyes.",
		"Everything is ending. Everything is beginning.",
		"Nothing ends. Nothing begins.",
		"Wake up. Please wake up.",
		"Stop it! You're hurting them!",
		"It's too soon for this. Please go back.",
		"We miss you. Where are you?",
		"Come back from there. Please.",
		"Is it really you?",
		"He isn't like us. He doesn't belong.",
		"Don't leave... please...",
		"You hear a clock ticking. It's getting faster."
	)
	var/static/list/overdose_messages = list(
		"THE SIGNAL THE SIGNAL THE SIGNAL THE SIGNAL",
		"IT CRIES IT CRIES IT WAITS IT CRIES",
		"NOT YOURS NOT YOURS NOT YOURS NOT YOURS",
		"THAT IS NOT FOR YOU",
		"IT RUNS IT RUNS IT RUNS IT RUNS",
		"THE BLOOD THE BLOOD THE BLOOD THE BLOOD",
		"THE LIGHT THE DARK A STAR IN CHAINS",
		"GET OUT GET OUT GET OUT GET OUT",
		"NO MORE NO MORE NO MORE"
	)
/datum/reagent/three_eye/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_client_colour(/datum/client_colour/thirdeye)
	if(L.client?.holder) //You are worthy.
		worthy = TRUE
		L.visible_message(span_danger("[L] grips their head and dances around, collapsing to the floor!"), \
		span_danger("Visions of a realm BYOND your own flash across your eyes, before it all goes black..."))
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, set_sleeping), 40 SECONDS), 10 SECONDS)
		addtimer(CALLBACK(L.reagents, TYPE_PROC_REF(/datum/reagents, remove_reagent), src.type, src.volume,), 10 SECONDS)
		return

/datum/reagent/three_eye/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(worthy)
		return

	for(var/datum/reagent/medicine/mannitol/chem in M.reagents.reagent_list)
		M.reagents.remove_reagent(chem.type, chem.volume)

	M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	if(prob(0.1) && ishuman(M))
		var/mob/living/carbon/human/H = M
		H.seizure()
		H.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(2, 4))
	if(prob(7))
		to_chat(M, span_warning("[pick(dose_messages)]"))

/datum/reagent/three_eye/overdose_start(mob/living/M)
	on_mob_metabolize(M) //set worthy
	if(worthy)
		overdosed = FALSE
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living, seizure)), rand(1 SECONDS, 5 SECONDS))

/datum/reagent/three_eye/overdose_process(mob/living/M)
	. = ..()
	if(worthy)
		return

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1, 2))
	if(prob(7))
		to_chat(M, span_danger("<font size = [rand(2,4)]>[pick(overdose_messages)]</font>"))

/datum/reagent/three_eye/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_client_colour(/datum/client_colour/thirdeye)
	if(overdosed && !worthy)
		to_chat(L, span_danger("<font size = 6>Your mind reels and the world begins to fade away...</font>"))
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			addtimer(CALLBACK(C, TYPE_PROC_REF(/mob/living/carbon, adjustOrganLoss), ORGAN_SLOT_BRAIN, 200), 5 SECONDS) //Deathblow to the brain
		else
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, gib)), 5 SECONDS)

/datum/reagent/concrete_mix
	name = "Concrete Mix"
	description = "Pre-made concrete mix, ideal for lazy engineers."
	color = "#c4c0bc"
	taste_description = "chalky concrete"
	harmful = TRUE
	reagent_state = SOLID

/datum/reagent/cement
	name = "Cement"
	description = "A sophisticated binding agent used to produce concrete."
	color = "#c4c0bc"
	taste_description = "cement"
	harmful = TRUE
	var/potency = 2
	var/concrete_type = /datum/reagent/concrete
	var/units_per_aggregate = 5

// make changes to dip_object -- remove H?
/datum/reagent/cement/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	if(!istype(I, /obj/item/stack/ore/glass))
		return FALSE
	var/obj/item/stack/ore/glass/aggregate = I
	// the maximum amount of aggregate we can use
	var/agg_used = min(round(volume / units_per_aggregate), aggregate.get_amount())
	if(!agg_used)
		return FALSE
	var/amt = agg_used * units_per_aggregate
	aggregate.use(agg_used)
	H.reagents.remove_reagent(src.type, amt)
	H.reagents.add_reagent(concrete_type, amt)
	return TRUE

/datum/reagent/cement/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	. = ..()
	if(!. || method != INGEST)
		return
	var/age = 6
	if(ishuman(M))
		var/mob/living/carbon/human/conc_eater = M
		age = conc_eater.age
	message_admins("[M] was forced to eat cement when [M.p_they()] [M.p_were()] [age]!")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "cement", /datum/mood_event/cement)

/datum/reagent/cement/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(prob(min(current_cycle/2, 5)))
		M.adjustToxLoss(potency*REM)
	if(prob(min(current_cycle/4, 10)))
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN,potency*REM)

/datum/reagent/cement/hexement
	name = "Hexement"
	description = "An advanced, space-age binding agent used to produce reinforced concrete."
	color = "#969390"
	potency = 4
	concrete_type = /datum/reagent/concrete/hexacrete
	units_per_aggregate = 2

/datum/reagent/cement/roadmix
	name = "Road mixture"
	description = "A mix of cement and asphalt. Looks less tasty than normal cement."
	color = "#5c6361"
	potency = 3
	concrete_type = /datum/reagent/concrete/pavement

/datum/reagent/concrete
	name = "Concrete"
	description = "A mix of cement and aggregate, commonly used as a bulk building material."
	color = "#a8988a"
	taste_description = "rocks"
	var/units_per_wall = 10
	var/units_per_floor = 2
	var/turf/closed/wall/concrete/wall_type = /turf/closed/wall/concrete
	var/turf/open/floor/concrete/floor_type = /turf/open/floor/concrete

/datum/reagent/concrete/expose_obj(obj/O, volume)
	var/girder_type = initial(wall_type.girder_type)
	if(istype(O, girder_type))
		return concify_girder(O, volume)
	if(istype(O, /obj/structure/catwalk))
		return concify_catwalk(O, volume)

/datum/reagent/concrete/proc/concify_girder(obj/O, volume)
	if(volume < units_per_wall)
		return
	var/turf/open/wall_turf = get_turf(O)
	if(!istype(wall_turf))
		return
	var/turf/closed/wall/concrete/conc_wall = wall_turf.PlaceOnTop(wall_type)
	O.transfer_fingerprints_to(conc_wall)
	conc_wall.harden_lvl = 0
	conc_wall.check_harden()
	conc_wall.update_stats()
	qdel(O)
	return

/datum/reagent/concrete/proc/concify_catwalk(obj/O, volume)
	if(volume < units_per_floor)
		return
	var/turf/open/floor/plating/floor_turf = get_turf(O)
	if(!istype(floor_turf))
		return
	var/turf/open/floor/concrete/conc_floor = floor_turf.PlaceOnTop(floor_type)
	O.transfer_fingerprints_to(conc_floor)
	conc_floor.harden_lvl = 0
	conc_floor.check_harden()
	conc_floor.update_appearance()
	qdel(O)
	return

/datum/reagent/concrete/hexacrete
	name = "Hexacrete"
	description = "Made with fortified cement, this mix of binder and aggregate is a useful, sturdy building material."
	color = "#7b6e60"
	wall_type = /turf/closed/wall/concrete/reinforced
	floor_type = /turf/open/floor/concrete/reinforced

/datum/reagent/concrete/pavement
	name = "Pavement"
	description = "Road surface, blacktop, asphalt concrete, whatever you call it, it's the most common material used in constructing runways for ships and roadways for vehicles."
	color = "#3f4543"
	floor_type = /turf/open/floor/concrete/pavement

/datum/reagent/calcium
	name = "Calcium"
	description = "A dull gray metal important to bones."
	reagent_state = SOLID
	color = "#68675c"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/ash_fibers
	name = "Ashen Fibers"
	description = "Ground plant fibers from a cave fern. Useful for medicines."
	reagent_state = SOLID
	color = "#5a4f42"
	taste_mult = 0

/datum/reagent/titanium
	name = "Titanium"
	description = "A light, reflective grey metal used in ship construction."
	reagent_state = SOLID
	color = "#c2c2c2"

/datum/reagent/asphalt
	name = "Asphalt"
	description = "A dark, viscous liquid. Often found in oil deposits, although sometimes it can seep to the surface."
	color = "#111212"
	taste_description = "petroleum"

/datum/reagent/asphalt/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(prob(min(current_cycle/2, 5)))
		M.adjustToxLoss(2*REM)
	if(prob(min(current_cycle/4, 10)))
		M.adjustOrganLoss(ORGAN_SLOT_STOMACH,3*REM)

/datum/reagent/polar_bear_fur //used for icewine crafting
	name = "Polar Bear Fur"
	description = "Fur obtained from griding up a polar bears hide"
	reagent_state = SOLID
	color = "#eeeeee" // rgb: 238, 238, 238

/datum/reagent/srm_bacteria
	name = "Illestren Bacteria"
	description = "Bacteria native to the Saint-Roumain Militia home planet."
	color = "#5a4f42"
	taste_description = "sour"

//anti rad foam
/datum/reagent/anti_radiation_foam
	name = "Anti-Radiation Foam"
	description = "A tried and tested foam, used for decontaminating nuclear disasters."
	reagent_state = LIQUID
	color = "#A6FAFF55"
	taste_description = "bitter, foamy awfulness."

/datum/reagent/anti_radiation_foam/expose_turf(turf/open/T, reac_volume)
	if (!istype(T))
		return

	if(reac_volume >= 1)
		var/obj/effect/particle_effect/foam/antirad/F = (locate(/obj/effect/particle_effect/foam/antirad) in T)
		if(!F)
			F = new(T)
		else if(istype(F))
			F.lifetime = initial(F.lifetime) //the foam is what does the cleaning here

/datum/reagent/anti_radiation_foam/expose_obj(obj/O, reac_volume)
	O.wash(CLEAN_RAD)

/datum/reagent/anti_radiation_foam/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method in list(TOUCH, VAPOR))
		M.radiation = M.radiation - rand(max(M.radiation * 0.07, 0)) //get the hose
		M.ExtinguishMob()
	..()


/datum/reagent/anti_radiation_foam/on_mob_life(mob/living/carbon/M)
	M.radiation = M.radiation - rand(max(M.radiation * 0.03, 0))
	..()
	. = 1

/datum/reagent/sulfur_dioxide
	name = "Sulfur Dioxide"
	description = "A transparent gas produced by geological activity and burning certain fuels."
	reagent_state = GAS
	color = "#f0e518"
	taste_mult = 0 // tasteless

/datum/reagent/sulfur_dioxide/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(1*REM, 0)
	if(prob(40))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS,1*REM)
	. = 1
	..()

/datum/reagent/sulfur_dioxide/expose_obj(obj/exposed_object, reac_volume)
	if((!exposed_object) || (!reac_volume))
		return 0
	var/temp = holder ? holder.chem_temp : T20C
	exposed_object.atmos_spawn_air("[GAS_SO2]=[reac_volume/2];TEMP=[temp]")

/datum/reagent/sulfur_dioxide/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		var/temp = holder ? holder.chem_temp : T20C
		exposed_turf.atmos_spawn_air("[GAS_SO2]=[reac_volume/2];TEMP=[temp]")
	return
