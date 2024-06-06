// ********************************************************
// Here's all the seeds (plants) that can be used in hydro
// ********************************************************

/obj/item/seeds
	icon = 'icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed"				// Unknown plant seed - these shouldn't exist in-game.
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/plantname = "Plants"		// Name of plant when planted.
	var/obj/item/product			// A type path. The thing that is created when the plant is harvested.
	var/productdesc
	var/species = ""				// Used to update icons. Should match the name in the sprites unless all icon_* are overridden.

	var/growing_icon = 'icons/obj/hydroponics/growing.dmi' //the file that stores the sprites of the growing plant from this seed.
	var/icon_grow					// Used to override grow icon (default is "[species]-grow"). You can use one grow icon for multiple closely related plants with it.
	var/icon_dead					// Used to override dead icon (default is "[species]-dead"). You can use one dead icon for multiple closely related plants with it.
	var/icon_harvest				// Used to override harvest icon (default is "[species]-harvest"). If null, plant will use [icon_grow][growthstages].

	var/lifespan = 25				// How long before the plant begins to take damage from age.
	var/endurance = 15				// Amount of health the plant has.
	var/maturation = 6				// Used to determine which sprite to switch to when growing.
	var/production = 6				// Changes the amount of time needed for a plant to become harvestable.
	var/yield = 3					// Amount of growns created per harvest. If is -1, the plant/shroom/weed is never meant to be harvested.
	var/potency = 10				// The 'power' of a plant. Generally effects the amount of reagent in a plant, also used in other ways.
	var/growthstages = 6			// Amount of growth sprites the plant has.
	var/instability = 5				// Chance that a plant will mutate in each stage of it's life.
	var/rarity = 0					// How rare the plant is. Used for giving points to cargo when shipping off to CentCom.
	var/list/mutatelist = list()	// The type of plants that this plant can mutate into.
	var/list/genes = list()			// Plant genes are stored here, see plant_genes.dm for more info.
	var/list/blacklisted_genes = list()
	var/list/reagents_add = list()
	// A list of reagents to add to product.
	// Format: "reagent_id" = potency multiplier
	// Stronger reagents must always come first to avoid being displaced by weaker ones.
	// Total amount of any reagent in plant is calculated by formula: 1 + round(potency * multiplier)

	var/weed_rate = 1				// If the chance below passes, then this many weeds sprout during growth
	var/weed_chance = 5				// Percentage chance per tray update to grow weeds
	var/research = 0				// Defines "discovery value", which will give a one-time point payout if a seed is given to an R&D console. Seed discovery is determined on a ship-by-ship basis.
	var/seed_flags = MUTATE_EARLY	// Determines if a plant is allowed to mutate early at 30+ instability

/obj/item/seeds/Initialize(mapload, nogenes = 0)
	. = ..()
	pixel_x = base_pixel_y + rand(-8, 8)
	pixel_y = base_pixel_x + rand(-8, 8)

	if(!icon_grow)
		icon_grow = "[species]-grow"

	if(!icon_dead)
		icon_dead = "[species]-dead"

	if(!icon_harvest && !get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism) && yield != -1)
		icon_harvest = "[species]-harvest"

	if(!nogenes) // not used on Copy()
		genes += new /datum/plant_gene/core/lifespan(lifespan)
		genes += new /datum/plant_gene/core/endurance(endurance)
		genes += new /datum/plant_gene/core/weed_rate(weed_rate)
		genes += new /datum/plant_gene/core/weed_chance(weed_chance)
		if(yield != UNHARVESTABLE)
			genes += new /datum/plant_gene/core/yield(yield)
			genes += new /datum/plant_gene/core/production(production)
		if(potency != UNHARVESTABLE)
			genes += new /datum/plant_gene/core/potency(potency)
			genes += new /datum/plant_gene/core/instability(instability)

		for(var/p in genes)
			if(ispath(p))
				genes -= p
				genes += new p

		for(var/reag_id in reagents_add)
			genes += new /datum/plant_gene/reagent(reag_id, reagents_add[reag_id])
		reagents_from_genes() //quality coding

/obj/item/seeds/Destroy()
	if(flags_1 & INITIALIZED_1)
		QDEL_LIST(genes)
	return ..()

/obj/item/seeds/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Use a pen on it to rename it or change its description.</span>"
	if(reagents_add && user.can_see_reagents())
		. += "<span class='notice'>- Plant Reagents -</span>"
		for(var/datum/plant_gene/reagent/gene in genes)
			. += "<span class='notice'>- [gene.get_name()] -</span>"

/obj/item/seeds/proc/Copy()
	var/obj/item/seeds/S = new type(null, 1)
	// Copy all the stats
	S.lifespan = lifespan
	S.endurance = endurance
	S.maturation = maturation
	S.production = production
	S.yield = yield
	S.potency = potency
	S.weed_rate = weed_rate
	S.instability = instability
	S.weed_chance = weed_chance
	S.name = name
	S.plantname = plantname
	S.desc = desc
	S.productdesc = productdesc
	S.genes = list()
	for(var/g in genes)
		var/datum/plant_gene/G = g
		S.genes += G.Copy()
	S.reagents_add = reagents_add.Copy() // Faster than grabbing the list from genes.
	return S

/obj/item/seeds/proc/get_gene(typepath)
	return (locate(typepath) in genes)

/obj/item/seeds/proc/reagents_from_genes()
	reagents_add = list()
	for(var/datum/plant_gene/reagent/R in genes)
		reagents_add[R.reagent_id] = R.rate

///This proc adds a mutability_flag to a gene
/obj/item/seeds/proc/set_mutability(typepath, mutability)
	var/datum/plant_gene/g = get_gene(typepath)
	if(g)
		g.mutability_flags |=  mutability

///This proc removes a mutability_flag from a gene
/obj/item/seeds/proc/unset_mutability(typepath, mutability)
	var/datum/plant_gene/g = get_gene(typepath)
	if(g)
		g.mutability_flags &=  ~mutability

/obj/item/seeds/proc/mutate(lifemut = 2, endmut = 5, productmut = 1, yieldmut = 2, potmut = 25, wrmut = 2, wcmut = 5, traitmut = 0, stabmut = 3)
	adjust_lifespan(rand(-lifemut,lifemut))
	adjust_endurance(rand(-endmut,endmut))
	adjust_production(rand(-productmut,productmut))
	adjust_yield(rand(-yieldmut,yieldmut))
	adjust_potency(rand(-potmut,potmut))
	adjust_instability(rand(-stabmut,stabmut))
	adjust_weed_rate(rand(-wrmut, wrmut))
	adjust_weed_chance(rand(-wcmut, wcmut))
	if(prob(traitmut))
		if(prob(50))
			add_random_traits(1, 1)
		else
			add_random_reagents(1, 1)

/obj/item/seeds/bullet_act(obj/projectile/Proj) //Works with the Somatoray to modify plant variables.
	if(istype(Proj, /obj/projectile/energy/florayield))
		var/rating = 1
		if(istype(loc, /obj/machinery/hydroponics))
			var/obj/machinery/hydroponics/H = loc
			rating = H.rating

		if(yield == 0)//Oh god don't divide by zero you'll doom us all.
			adjust_yield(1 * rating)
		else if(prob(1/(yield * yield) * 100))//This formula gives you diminishing returns based on yield. 100% with 1 yield, decreasing to 25%, 11%, 6, 4, 2...
			adjust_yield(1 * rating)
	else
		return ..()


// Harvest procs
/obj/item/seeds/proc/getYield()
	var/return_yield = yield

	var/obj/machinery/hydroponics/parent = loc
	if(istype(loc, /obj/machinery/hydroponics))
		if(parent.yieldmod == 0)
			return_yield = min(return_yield, 1)//1 if above zero, 0 otherwise
		else
			return_yield *= (parent.yieldmod)

	return return_yield


/obj/item/seeds/proc/harvest(mob/user)
	///Reference to the tray/soil the seeds are planted in.
	var/obj/machinery/hydroponics/parent = loc //for ease of access
	///Count used for creating the correct amount of results to the harvest.
	var/t_amount = 0
	///List of plants all harvested from the same batch.
	var/list/result = list()
	///Tile of the harvester to deposit the growables.
	var/output_loc = parent.Adjacent(user) ? user.loc : parent.loc //needed for TK
	///Name of the grown products.
	var/product_name
	///The Number of products produced by the plant, typically the yield.
	var/product_count = getYield()

	while(t_amount < product_count)
		var/obj/item/reagent_containers/food/snacks/grown/t_prod
		if(instability >= 30 && (seed_flags & MUTATE_EARLY) && LAZYLEN(mutatelist) && prob(instability/3))
			var/obj/item/seeds/new_prod = pick(mutatelist)
			t_prod = initial(new_prod.product)
			if(!t_prod)
				continue
			t_prod = new t_prod(output_loc, src)
			t_prod.seed = new new_prod
			t_prod.seed.name = initial(new_prod.name)
			t_prod.seed.desc = initial(new_prod.desc)
			t_prod.seed.plantname = initial(new_prod.plantname)
			t_prod.transform = initial(t_prod.transform)
			t_prod.transform *= TRANSFORM_USING_VARIABLE(t_prod.seed.potency, 100) + 0.5
			t_amount++
			if(t_prod.seed)
				//t_prod.seed = new new_prod
				t_prod.seed.instability = round(instability * 0.5)
			continue
		else
			t_prod = new product(output_loc, src)
		if(parent.myseed.plantname != initial(parent.myseed.plantname))
			t_prod.name = lowertext(parent.myseed.plantname)
		if(productdesc)
			t_prod.desc = productdesc
		t_prod.seed.name = parent.myseed.name
		t_prod.seed.desc = parent.myseed.desc
		t_prod.seed.plantname = parent.myseed.plantname
		result.Add(t_prod) // User gets a consumable
		if(!t_prod)
			return
		t_amount++
		product_name = parent.myseed.plantname
	if(getYield() >= 1)
		SSblackbox.record_feedback("tally", "food_harvested", getYield(), product_name)
	parent.update_tray(user)

	return result

/obj/item/seeds/proc/harvest_userless()
	var/obj/machinery/hydroponics/parent = loc //for ease of access
	var/t_amount = 0
	var/list/result = list()
	var/output_loc =  parent.loc
	var/product_name
	while(t_amount < getYield())
		var/obj/item/reagent_containers/food/snacks/grown/t_prod = new product(output_loc, src)
		if(parent.myseed.plantname != initial(parent.myseed.plantname))
			t_prod.name = lowertext(parent.myseed.plantname)
		if(productdesc)
			t_prod.desc = productdesc
		t_prod.seed.name = parent.myseed.name
		t_prod.seed.desc = parent.myseed.desc
		t_prod.seed.plantname = parent.myseed.plantname
		result.Add(t_prod) // User gets a consumable
		if(!t_prod)
			return
		t_amount++
		product_name = parent.myseed.plantname
	if(getYield() >= 1)
		SSblackbox.record_feedback("tally", "food_harvested", getYield(), product_name)
	parent.investigate_log("autmoatic harvest of [getYield()] of [src], with seed traits [english_list(genes)] and reagents_add [english_list(reagents_add)] and potency [potency].", INVESTIGATE_BOTANY)
	parent.update_tray()
	return result

/obj/item/seeds/proc/prepare_result(obj/item/reagent_containers/food/snacks/grown/T)
	if(!T.reagents)
		CRASH("[T] has no reagents.")

	for(var/rid in reagents_add)
		var/amount = 1 + round(potency * reagents_add[rid], 1)

		var/list/data = null
		if(rid == "blood") // Hack to make blood in plants always O-
			data = list("blood_type" = "O-")
		if(istype(T) && (rid == /datum/reagent/consumable/nutriment || rid == /datum/reagent/consumable/nutriment/vitamin))
			// apple tastes of apple.
			data = T.tastes

		T.reagents.add_reagent(rid, amount, data)


/// Setters procs ///
/obj/item/seeds/proc/adjust_yield(adjustamt)
	if(yield != UNHARVESTABLE) // Unharvestable shouldn't suddenly turn harvestable
		yield = clamp(yield + adjustamt, 0, 10)

		if(yield <= 0 && get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
			yield = 1 // Mushrooms always have a minimum yield of 1.
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/yield)
		if(C)
			C.value = yield

/obj/item/seeds/proc/adjust_lifespan(adjustamt)
	lifespan = clamp(lifespan + adjustamt, 10, 100)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/lifespan)
	if(C)
		C.value = lifespan

/obj/item/seeds/proc/adjust_endurance(adjustamt)
	endurance = clamp(endurance + adjustamt, 10, 100)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/endurance)
	if(C)
		C.value = endurance

/obj/item/seeds/proc/adjust_production(adjustamt)
	if(yield != UNHARVESTABLE)
		production = clamp(production + adjustamt, 1, 10)
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/production)
		if(C)
			C.value = production

/obj/item/seeds/proc/adjust_instability(adjustamt)
	if(instability == UNHARVESTABLE)
		return
	instability = clamp(instability + adjustamt, 0, 100)
	var/datum/plant_gene/core/Core = get_gene(/datum/plant_gene/core/instability)
	if(Core)
		Core.value = instability

/obj/item/seeds/proc/adjust_potency(adjustamt)
	if(potency != UNHARVESTABLE)
		potency = clamp(potency + adjustamt, 0, 100)
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/potency)
		if(C)
			C.value = potency

/obj/item/seeds/proc/adjust_weed_rate(adjustamt)
	weed_rate = clamp(weed_rate + adjustamt, 0, 10)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/weed_rate)
	if(C)
		C.value = weed_rate

/obj/item/seeds/proc/adjust_weed_chance(adjustamt)
	weed_chance = clamp(weed_chance + adjustamt, 0, 67)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/weed_chance)
	if(C)
		C.value = weed_chance

//Directly setting stats

/obj/item/seeds/proc/set_yield(adjustamt)
	if(yield != UNHARVESTABLE) // Unharvestable shouldn't suddenly turn harvestable
		yield = clamp(adjustamt, 0, 10)

		if(yield <= 0 && get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
			yield = 1 // Mushrooms always have a minimum yield of 1.
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/yield)
		if(C)
			C.value = yield

/obj/item/seeds/proc/set_lifespan(adjustamt)
	lifespan = clamp(adjustamt, 10, 100)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/lifespan)
	if(C)
		C.value = lifespan

/obj/item/seeds/proc/set_endurance(adjustamt)
	endurance = clamp(adjustamt, 10, 100)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/endurance)
	if(C)
		C.value = endurance

/obj/item/seeds/proc/set_production(adjustamt)
	if(yield != UNHARVESTABLE)
		production = clamp(adjustamt, 1, 10)
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/production)
		if(C)
			C.value = production

/obj/item/seeds/proc/set_potency(adjustamt)
	if(potency != UNHARVESTABLE)
		potency = clamp(adjustamt, 0, 100)
		var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/potency)
		if(C)
			C.value = potency

/obj/item/seeds/proc/set_instability(adjustamt)
	if(instability == UNHARVESTABLE)
		return
	instability = clamp(adjustamt, 0, 100)
	var/datum/plant_gene/core/Core = get_gene(/datum/plant_gene/core/instability)
	if(Core)
		Core.value = instability

/obj/item/seeds/proc/set_weed_rate(adjustamt)
	weed_rate = clamp(adjustamt, 0, 10)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/weed_rate)
	if(C)
		C.value = weed_rate

/obj/item/seeds/proc/set_weed_chance(adjustamt)
	weed_chance = clamp(adjustamt, 0, 67)
	var/datum/plant_gene/core/C = get_gene(/datum/plant_gene/core/weed_chance)
	if(C)
		C.value = weed_chance


/obj/item/seeds/proc/get_analyzer_text()  //in case seeds have something special to tell to the analyzer
	var/text = ""
	if(!get_gene(/datum/plant_gene/trait/plant_type/weed_hardy) && !get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism) && !get_gene(/datum/plant_gene/trait/plant_type/alien_properties))
		text += "- Plant type: [span_notice("Normal plant\n")]"
	if(get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
		text += "- Plant type: [span_notice("Weed. Can grow in nutrient-poor soil.\n")]"
	if(get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
		text += "- Plant type: [span_notice("Mushroom. Can grow in dry soil.\n")]"
	if(get_gene(/datum/plant_gene/trait/plant_type/crystal))
		text += "- Plant type: [span_notice("Crystal. Revitalizes soil.\n")]"
	if(get_gene(/datum/plant_gene/trait/plant_type/alien_properties))
		text += "- Plant type: [span_warning("UNKNOWN\n")]"
	if(potency != UNHARVESTABLE)
		text += "- Potency: [span_notice("[potency]\n")]"
	if(yield != UNHARVESTABLE)
		text += "- Yield: [span_notice("[yield]\n")]"
	text += "- Maturation speed: [span_notice("[maturation]\n")]"
	if(yield != UNHARVESTABLE)
		text += "- Production speed: [span_notice("[production]\n")]"
	text += "- Endurance: [span_notice("[endurance]\n")]"
	text += "- Lifespan: [span_notice("[lifespan]\n")]"
	text += "- Instability: [span_notice("[instability]\n")]"
	text += "- Weed Growth Rate: [span_notice("[weed_rate]\n")]"
	text += "- Weed Vulnerability: [span_notice("[weed_chance]\n")]"
	if(rarity)
		text += "- Species Discovery Value: [span_notice("[rarity]\n")]"
	var/all_traits = ""
	for(var/datum/plant_gene/trait/traits in genes)
		if(istype(traits, /datum/plant_gene/trait/plant_type))
			continue
		all_traits += " [traits.get_name()]"
	text += "- Plant Traits:[all_traits]\n"
	text += "*---------*"
	return text

/obj/item/seeds/proc/on_chem_reaction(datum/reagents/S)  //in case seeds have some special interaction with special chems
	return

/obj/item/seeds/attackby(obj/item/O, mob/user, params)
	if (istype(O, /obj/item/plant_analyzer))
		var/msg = "This is \a <span class='name'>[src]</span>."
		var/text
		var/obj/item/plant_analyzer/P_analyzer = O
		if(P_analyzer.scan_mode == PLANT_SCANMODE_STATS)
			text = get_analyzer_text()
			if(text)
				msg += "\n[text]"
		if(reagents_add && P_analyzer.scan_mode == PLANT_SCANMODE_CHEMICALS)
			msg += "\n- Plant Reagents -"
			msg += "\n*---------*"
			for(var/datum/plant_gene/reagent/Gene in genes)
				msg += "\n<span class='notice'>- [Gene.get_name()] -</span>"
			msg += "\n*---------*"
		to_chat(user, examine_block(msg))

		return

	if(istype(O, /obj/item/pen))
		var/choice = input("What would you like to change?") in list("Plant Name", "Seed Description", "Product Description", "Cancel")
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		switch(choice)
			if("Plant Name")
				var/newplantname = reject_bad_text(stripped_input(user, "Write a new plant name:", name, plantname))
				if(!user.canUseTopic(src, BE_CLOSE))
					return
				if (length(newplantname) > 20)
					to_chat(user, "That name is too long!")
					return
				if(!newplantname)
					to_chat(user, "That name is invalid.")
					return
				else
					name = "[lowertext(newplantname)]"
					plantname = newplantname
			if("Seed Description")
				var/newdesc = stripped_input(user, "Write a new description:", name, desc)
				if(!user.canUseTopic(src, BE_CLOSE))
					return
				if (length(newdesc) > 180)
					to_chat(user, "That description is too long!")
					return
				if(!newdesc)
					to_chat(user, "That description is invalid.")
					return
				else
					desc = newdesc
			if("Product Description")
				if(product && !productdesc)
					productdesc = initial(product.desc)
				var/newproductdesc = stripped_input(user, "Write a new description:", name, productdesc)
				if(!user.canUseTopic(src, BE_CLOSE))
					return
				if (length(newproductdesc) > 180)
					to_chat(user, "That description is too long!")
					return
				if(!newproductdesc)
					to_chat(user, "That description is invalid.")
					return
				else
					productdesc = newproductdesc
			else
				return

	..() // Fallthrough to item/attackby() so that bags can pick seeds up

// Checks plants for broken tray icons. Use Advanced Proc Call to activate.
// Maybe some day it would be used as unit test.
/proc/check_plants_growth_stages_icons()
	var/list/states = icon_states('icons/obj/hydroponics/growing.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_fruits.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_flowers.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_mushrooms.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_vegetables.dmi')
	var/list/paths = typesof(/obj/item/seeds) - /obj/item/seeds - typesof(/obj/item/seeds/sample)

	for(var/seedpath in paths)
		var/obj/item/seeds/seed = new seedpath

		for(var/i in 1 to seed.growthstages)
			if("[seed.icon_grow][i]" in states)
				continue
			to_chat(world, "[seed.name] ([seed.type]) lacks the [seed.icon_grow][i] icon!")

		if(!(seed.icon_dead in states))
			to_chat(world, "[seed.name] ([seed.type]) lacks the [seed.icon_dead] icon!")

		if(seed.icon_harvest) // mushrooms have no grown sprites, same for items with no product
			if(!(seed.icon_harvest in states))
				to_chat(world, "[seed.name] ([seed.type]) lacks the [seed.icon_harvest] icon!")

/obj/item/seeds/proc/randomize_stats()
	set_lifespan(rand(25, 60))
	set_endurance(rand(15, 35))
	set_production(rand(2, 10))
	set_yield(rand(1, 10))
	set_potency(rand(10, 35))
	set_weed_rate(rand(1, 10))
	set_weed_chance(rand(5, 100))
	maturation = rand(6, 12)

/obj/item/seeds/proc/add_random_reagents(lower = 0, upper = 2)
	var/amount_random_reagents = rand(lower, upper)
	for(var/i in 1 to amount_random_reagents)
		var/random_amount = rand(4, 15) * 0.01 // this must be multiplied by 0.01, otherwise, it will not properly associate
		var/datum/plant_gene/reagent/R = new(get_random_reagent_id(), random_amount)
		if(R.can_add(src))
			genes += R
		else
			qdel(R)
	reagents_from_genes()

/obj/item/seeds/proc/add_random_traits(lower = 0, upper = 2)
	var/amount_random_traits = rand(lower, upper)
	for(var/i in 1 to amount_random_traits)
		var/random_trait = pick((subtypesof(/datum/plant_gene/trait)-typesof(/datum/plant_gene/trait/plant_type)))
		var/datum/plant_gene/trait/T = new random_trait
		if(T.can_add(src) && !(T in blacklisted_genes))
			genes += T
		else
			qdel(T)

/obj/item/seeds/proc/add_random_plant_type(normal_plant_chance = 75)
	if(prob(normal_plant_chance))
		var/random_plant_type = pick(subtypesof(/datum/plant_gene/trait/plant_type))
		var/datum/plant_gene/trait/plant_type/P = new random_plant_type
		if(P.can_add(src))
			genes += P
		else
			qdel(P)
