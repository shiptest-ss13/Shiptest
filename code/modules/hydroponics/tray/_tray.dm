/obj/machinery/hydroponics
	name = "hydroponics tray"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "hydrotray"
	density = TRUE
	pixel_z = 1
	pass_flags_self = LETPASSTHROW
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME
	circuit = /obj/item/circuitboard/machine/hydroponics
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_LOW
	active_power_usage = ACTIVE_DRAW_HIGH
	///The amount of water in the tray (max 100)
	var/waterlevel = 100
	///The maximum amount of water in the tray
	var/maxwater = 100
	///How many units of nutrient will be drained in the tray
	var/nutridrain = 1
	///The maximum nutrient of water in the tray
	var/maxnutri = 20
	///The amount of pests in the tray (max: MAX_TRAY_PESTS)
	var/pestlevel = 0
	///The amount of weeds in the tray (max: MAX_TRAY_WEEDS)
	var/weedlevel = 0
	///The trays effect on yield
	var/yieldmod = 1
	///Nutriment's effect on mutations
	var/mutmod = 1
	///Toxicity in the tray?
	var/toxic = 0
	///Current age
	var/age = 0
	///Is it dead?
	var/dead = FALSE
	///Its health
	var/plant_health
	///Last time it was harvested
	var/lastproduce = 0
	///Used for timing of cycles.
	var/lastcycle = 0
	var/cycledelay = HYDROTRAY_CYCLE_DELAY
	///Ready to harvest?
	var/harvest = FALSE
	///The currently planted seed
	var/obj/item/seeds/myseed = null
	var/rating = 1
	var/unwrenchable = TRUE
	///Have we been visited by a bee recently, so bees dont overpollinate one plant
	var/recent_bee_visit = FALSE
	///Last user to add reagents to a tray. Mostly for logging.
	var/datum/weakref/lastuser

	var/can_self_sustatin = FALSE
	///If the tray generates nutrients and water on its own
	var/self_sustaining = FALSE
	///The icon state for the overlay used to represent that this tray is self-sustaining.
	var/self_sustaining_overlay_icon_state = "gaia_blessing"
	///The light level on the tray tile
	var/light_level = 0

/obj/machinery/hydroponics/Initialize()
	if(density)
		AddElement(/datum/element/climbable)
	create_reagents(maxnutri)
	reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, maxnutri/2) //Half filled nutrient trays.
	return ..()

/obj/machinery/hydroponics/Destroy()
	if(myseed)
		QDEL_NULL(myseed)
	return ..()

/obj/machinery/hydroponics/bullet_act(obj/projectile/Proj) //Works with the Somatoray to modify plant variables.
	if(!myseed)
		return ..()
	if(istype(Proj , /obj/projectile/energy/floramut))
		mutate()
		return BULLET_ACT_HIT
	else if(istype(Proj , /obj/projectile/energy/florayield))
		return myseed.bullet_act(Proj)
	else if(istype(Proj , /obj/projectile/energy/florarevolution))
		if(length(myseed.mutatelist))
			myseed.adjust_instability(round(myseed.instability * 0.5))
		mutatespecie()
	else
		return ..()

/obj/machinery/hydroponics/process(seconds_per_tick)
	var/needs_update = FALSE // Checks if the icon needs updating so we don't redraw empty trays every time

	if(!powered() && self_sustaining)
		visible_message(span_warning("[name]'s auto-grow functionality shuts off!"))
		set_idle_power()
		self_sustaining = FALSE
		update_appearance()
	else if(self_sustaining)
		adjustWater(rand(1,2) * seconds_per_tick * 0.5)
		adjustWeeds(-0.5 * seconds_per_tick)
		adjustPests(-0.5 * seconds_per_tick)

	if(isturf(loc))
		var/turf/currentTurf = loc
		light_level = currentTurf.get_lumcount()

	if(world.time > (lastcycle + cycledelay))
		lastcycle = world.time
		if(myseed && !dead)
			// Advance age
			age++
			if(age < myseed.maturation)
				lastproduce = age

			needs_update = TRUE

//Nutrients//////////////////////////////////////////////////////////////
			// Nutrients deplete at a constant rate, since new nutrients can boost stats far easier.
			apply_chemicals(lastuser)
			if(self_sustaining)
				reagents.remove_any(min(0.5, nutridrain))
			else
				reagents.remove_any(nutridrain)

			// Lack of nutrients hurts non-weeds
			if(reagents.total_volume <= 0 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
				adjustHealth(-rand(1,3))

//Photosynthesis/////////////////////////////////////////////////////////
			// Lack of light hurts non-mushrooms
			var/is_fungus = myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism)
			if(light_level < (is_fungus ? 0.2 : 0.4))
				adjustHealth((is_fungus ? -1 : -2) / rating)

//Water//////////////////////////////////////////////////////////////////
			// Drink random amount of water
			adjustWater(-rand(1,5) / rating)

			// If the plant is dry, it loses health pretty fast, unless mushroom
			if(waterlevel <= 10 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
				adjustHealth(-rand(0,1) / rating)
				if(waterlevel <= 0)
					adjustHealth(-rand(0,2) / rating)

			// Sufficient water level and nutrient level = plant healthy but also spawns weeds
			else if(waterlevel > 10 && reagents.total_volume > 0)
				adjustHealth(rand(1,2) / rating)
				if(myseed && prob(myseed.weed_chance))
					adjustWeeds(myseed.weed_rate)
				else if(prob(1))  //1 percent chance the weed population will increase
					adjustWeeds(1 / rating)

//Toxins/////////////////////////////////////////////////////////////////
			// Too much toxins cause harm, but when the plant drinks the contaiminated water, the toxins disappear slowly
			if(toxic >= 50 && toxic < 80)
				adjustHealth(-1 / rating)
				adjustToxic(-rand(1,10) / rating)
			else if(toxic >= 80) // I don't think it ever gets here tbh unless above is commented out
				adjustHealth(-3)
				adjustToxic(-rand(1,10) / rating)

//Pests & Weeds//////////////////////////////////////////////////////////
			if(pestlevel >= 8)
				if(!myseed.get_gene(/datum/plant_gene/trait/carnivory))
					adjustHealth(-2 / rating)

				else
					adjustHealth(2 / rating)
					adjustPests(-1 / rating)

			else if(pestlevel >= 4)
				if(!myseed.get_gene(/datum/plant_gene/trait/carnivory))
					adjustHealth(-1 / rating)

				else
					adjustHealth(1 / rating)
					if(prob(50))
						adjustPests(-1 / rating)

			else if(pestlevel < 4 && myseed.get_gene(/datum/plant_gene/trait/carnivory))
				adjustHealth(-2 / rating)
				if(prob(5))
					adjustPests(-1 / rating)

			// If it's a weed, it doesn't stunt the growth
			if(weedlevel >= 5 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
				adjustHealth(-1 / rating)

//This is where stability mutations exist now.
			if(myseed.instability >= 80)
				var/mutation_chance = myseed.instability - 75
				mutate(0, 0, 0, 0, 0, 0, 0, mutation_chance, 0) //Scaling odds of a random trait or chemical
			if(myseed.instability >= 60)
				if(prob((myseed.instability)/2) && !self_sustaining && length(myseed.mutatelist)) //Minimum 30%, Maximum 50% chance of mutating every age tick when not on autogrow.
					mutatespecie()
					myseed.instability = myseed.instability/2
			if(myseed.instability >= 40)
				if(prob(myseed.instability))
					hardmutate()
			if(myseed.instability >= 20)
				if(prob(myseed.instability))
					mutate()

//Health & Age///////////////////////////////////////////////////////////
			// Plant dies if plant_health <= 0
			if(plant_health <= 0)
				plantdies()
				adjustWeeds(1 / rating) // Weeds flourish

			// If the plant is too old, lose health fast
			if((age / 20) > myseed.lifespan)
				adjustHealth(-rand(1,3) / rating)

			// Harvest code
			if(age > (myseed.production * 1.5) && (age - lastproduce) > (myseed.production * 1.5) && (!harvest && !dead))
				if(myseed && myseed.yield != -1) // Unharvestable shouldn't be harvested
					harvest = TRUE
				else
					lastproduce = age
			if(prob(5))  // On each tick, there's a 5 percent chance the pest population will increase
				adjustPests(1 / rating)
		//No plant or dead
		else
			if(waterlevel > 10 && reagents.total_volume > 0 && prob(10))  // If there's no plant, the percentage chance is 10%
				adjustWeeds(1 / rating)

		// Weeeeeeeeeeeeeeedddssss
		if(weedlevel >= MAX_TRAY_WEEDS && prob(50)) // At this point the plant is kind of fucked. Weeds can overtake the plant spot.
			if(myseed)
				if(!myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy) && !myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism)) // If a normal plant
					weedinvasion()
			else
				weedinvasion() // Weed invasion into empty tray
			needs_update = 1
		if (needs_update)
			update_appearance()

		if(myseed && prob(5 * (11-myseed.production)))
			SEND_SIGNAL(myseed, COMSIG_SEED_ON_GROW, src)
	return

/obj/machinery/hydroponics/update_appearance(updates)
	. = ..()

	if(self_sustaining)
		set_light(3)
		return
	if(myseed?.get_gene(/datum/plant_gene/trait/glow)) // Hydroponics needs a refactor, badly.
		var/datum/plant_gene/trait/glow/G = myseed.get_gene(/datum/plant_gene/trait/glow)
		set_light(G.glow_range(myseed), G.glow_power(myseed), G.glow_color)
		return
	set_light(0)

/obj/machinery/hydroponics/update_overlays()
	. = ..()
	if(myseed)
		. += update_plant_overlay()
		. += update_status_light_overlays()

	if(self_sustaining && self_sustaining_overlay_icon_state)
		. += mutable_appearance(icon, self_sustaining_overlay_icon_state)

/obj/machinery/hydroponics/proc/update_plant_overlay()
	var/mutable_appearance/plant_overlay = mutable_appearance(myseed.growing_icon, layer = OBJ_LAYER + 0.01)
	if(dead)
		plant_overlay.icon_state = myseed.icon_dead
	else if(harvest)
		if(!myseed.icon_harvest)
			plant_overlay.icon_state = "[myseed.icon_grow][myseed.growthstages]"
		else
			plant_overlay.icon_state = myseed.icon_harvest
	else
		var/t_growthstate = clamp(round((age / myseed.maturation) * myseed.growthstages), 1, myseed.growthstages)
		plant_overlay.icon_state = "[myseed.icon_grow][t_growthstate]"
	plant_overlay.pixel_y += 3 //to adjust the plant sprites to the new one without touching every single file
	return plant_overlay

/obj/machinery/hydroponics/proc/update_status_light_overlays()
	. = list()
	if(harvest)
		. += mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_harvest3")
	if(plant_health <= (myseed.endurance / 2))
		. += mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lowhealth3")
	if(weedlevel >= 5 || pestlevel >= 5 || toxic >= 40)
		. += mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_alert3")
	if(reagents.total_volume <= 2)
		. += mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lownutri3")
	if(waterlevel <= 10)
		. += mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lowwater3")


/obj/machinery/hydroponics/examine(user)
	. = ..()
	if(myseed)
		. += span_info("It has [span_name("[myseed.plantname]")] planted.")
		if (dead)
			. += span_warning("It's dead!")
		else if (harvest)
			. += span_info("It's ready to harvest.")
		else if (plant_health <= (myseed.endurance / 2))
			. += span_warning("It looks unhealthy.")
	else
		. += span_info("It's empty.")

	. += "[span_info("Water: [waterlevel]/[maxwater].")]\n"+\
	span_info("Nutrient: [reagents.total_volume]/[maxnutri].")
	if(self_sustaining)
		. += span_info("The tray's autogrow is active, halving active reagent drain, and actively maintaning the plant.")

	if(weedlevel >= 5)
		to_chat(user, span_warning("It's filled with weeds!"))
	if(pestlevel >= 5)
		to_chat(user, span_warning("It's filled with tiny worms!"))



/obj/machinery/hydroponics/proc/weedinvasion() // If a weed growth is sufficient, this happens.
	dead = 0
	var/oldPlantName
	if(myseed) // In case there's nothing in the tray beforehand
		oldPlantName = myseed.plantname
		QDEL_NULL(myseed)
	else
		oldPlantName = "empty tray"
	switch(rand(0,20))		// randomly pick predominative weed
		if(19 to 20)
			myseed = new /obj/item/seeds/glowshroom(src)
		if(16 to 18)
			myseed = new /obj/item/seeds/reishi(src)
		if(14 to 15)
			myseed = new /obj/item/seeds/nettle(src)
		if(12 to 13)
			myseed = new /obj/item/seeds/harebell(src)
		if(10 to 11)
			myseed = new /obj/item/seeds/amanita(src)
		if(8 to 9)
			myseed = new /obj/item/seeds/chanter(src)
		if(6 to 7)
			myseed = new /obj/item/seeds/tower(src)
		if(4 to 5)
			myseed = new /obj/item/seeds/plump(src)
		else
			myseed = new /obj/item/seeds/starthistle(src)
	age = 0
	plant_health = myseed.endurance
	lastcycle = world.time
	harvest = 0
	weedlevel = 0 // Reset
	pestlevel = 0 // Reset
	update_appearance()
	visible_message(span_warning("The [oldPlantName] is overtaken by some [myseed.plantname]!"))
	name = "hydroponics tray ([myseed.plantname])"
	if(myseed.product)
		desc = initial(myseed.product.desc)
	else
		desc = initial(desc)

/obj/machinery/hydroponics/proc/mutate(lifemut = 2, endmut = 5, productmut = 1, yieldmut = 2, potmut = 25, wrmut = 2, wcmut = 5, traitmut = 0) // Mutates the current seed
	if(!myseed)
		return
	myseed.mutate(lifemut, endmut, productmut, yieldmut, potmut, wrmut, wcmut, traitmut)

/obj/machinery/hydroponics/proc/hardmutate()
	mutate(4, 10, 2, 4, 50, 4, 10, 3)

/obj/machinery/hydroponics/proc/mutatespecie() // Mutagent produced a new plant!
	if(!myseed || dead)
		return

	var/oldPlantName = myseed.plantname
	if(length(myseed.mutatelist))
		var/mutantseed = pick(myseed.mutatelist)
		QDEL_NULL(myseed)
		myseed = new mutantseed(src)
	else
		return

	hardmutate()
	age = 0
	plant_health = myseed.endurance
	lastcycle = world.time
	harvest = TRUE
	weedlevel = 0 // Reset

	sleep(5) // Wait a while
	update_appearance()
	visible_message(span_warning("[oldPlantName] suddenly mutates into [myseed.plantname]!"))
	TRAY_NAME_UPDATE

/obj/machinery/hydroponics/proc/mutateweed() // If the weeds gets the mutagent instead. Mind you, this pretty much destroys the old plant
	if(weedlevel > 5)
		if(myseed)
			QDEL_NULL(myseed)
		var/newWeed = pick(/obj/item/seeds/liberty, /obj/item/seeds/angel, /obj/item/seeds/nettle/death, /obj/item/seeds/kudzu)
		myseed = new newWeed
		dead = 0
		hardmutate()
		age = 0
		plant_health = myseed.endurance
		lastcycle = world.time
		harvest = 0
		weedlevel = 0 // Reset

		sleep(5) // Wait a while
		update_appearance()
		visible_message(span_warning("The mutated weeds in [src] spawn some [myseed.plantname]!"))
		TRAY_NAME_UPDATE
	else
		to_chat(usr, span_warning("The few weeds in [src] seem to react, but only for a moment..."))


/**
 * Plant Death Proc.
 * Cleans up various stats for the plant upon death, including pests, harvestability, and plant health.
 */
/obj/machinery/hydroponics/proc/plantdies()
	plant_health = 0
	harvest = FALSE
	pestlevel = 0 // Pests die
	lastproduce = 0
	if(!dead)
		update_appearance()
		dead = TRUE


/obj/machinery/hydroponics/proc/mutatepest(mob/user)
	if(pestlevel > 5)
		message_admins("[ADMIN_LOOKUPFLW(user)] caused spiderling pests to spawn in a hydro tray")
		log_game("[key_name(user)] caused spiderling pests to spawn in a hydro tray")
		visible_message(span_warning("The pests seem to behave oddly..."))
		spawn_atom_to_turf(/obj/structure/spider/spiderling/hunter, src, 3, FALSE)
	else
		to_chat(user, span_warning("The pests seem to behave oddly, but quickly settle down..."))

/obj/machinery/hydroponics/attackby(obj/item/O, mob/user, params)
	//Called when mob user "attacks" it with object O
	if(IS_EDIBLE(O) || istype(O, /obj/item/reagent_containers)) // Syringe stuff (and other reagent containers now too)
		var/obj/item/reagent_containers/reagent_source = O
		lastuser = REF(user)

		if(!reagent_source.reagents.total_volume)
			to_chat(user, span_notice("[reagent_source] is empty."))
			return 1

		var/list/trays = list(src)//makes the list just this in cases of syringes and compost etc
		var/target = myseed ? myseed.plantname : src
		var/visi_msg = ""
		var/transfer_amount

		if(IS_EDIBLE(reagent_source) || istype(reagent_source, /obj/item/reagent_containers/pill))
			visi_msg = "[user] composts [reagent_source], spreading it through [target]"
			transfer_amount = reagent_source.reagents.total_volume
			SEND_SIGNAL(reagent_source, COMSIG_ITEM_ON_COMPOSTED, user)
		else
			transfer_amount = reagent_source.amount_per_transfer_from_this
			if(istype(reagent_source, /obj/item/reagent_containers/syringe/))
				var/obj/item/reagent_containers/syringe/syr = reagent_source
				visi_msg = "[user] injects [target] with [syr]"
			// Beakers, bottles, buckets, etc.
			if(reagent_source.is_drainable())
				playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)

		if(visi_msg)
			visible_message(span_notice("[visi_msg]."))


		for(var/obj/machinery/hydroponics/H in trays)
		//cause I don't want to feel like im juggling 15 tamagotchis and I can get to my real work of ripping flooring apart in hopes of validating my life choices of becoming a space-gardener
			//This was originally in apply_chemicals, but due to apply_chemicals only holding nutrients, we handle it here now.
			if(reagent_source.reagents.has_reagent(/datum/reagent/water, 1))
				var/water_amt = reagent_source.reagents.get_reagent_amount(/datum/reagent/water) * transfer_amount / reagent_source.reagents.total_volume
				H.adjustWater(round(water_amt))
				reagent_source.reagents.remove_reagent(/datum/reagent/water, water_amt)
			reagent_source.reagents.trans_to(H.reagents, transfer_amount)
			if(IS_EDIBLE(reagent_source) || istype(reagent_source, /obj/item/reagent_containers/pill))
				qdel(reagent_source)
				lastuser = user
				H.update_appearance()
				return 1
			H.update_appearance()
		if(reagent_source) // If the source wasn't composted and destroyed
			reagent_source.update_appearance()
		return 1

	else if(istype(O, /obj/item/seeds) && !istype(O, /obj/item/seeds/sample))
		if(!myseed)
			if(istype(O, /obj/item/seeds/kudzu))
				investigate_log("had Kudzu planted in it by [key_name(user)] at [AREACOORD(src)]","kudzu")
			if(!user.transferItemToLoc(O, src))
				return
			to_chat(user, span_notice("You plant [O]."))
			dead = FALSE
			myseed = O
			TRAY_NAME_UPDATE
			age = 1
			plant_health = myseed.endurance
			lastcycle = world.time
			update_appearance()
			return
		else
			to_chat(user, span_warning("[src] already has seeds in it!"))
			return

	else if(istype(O, /obj/item/plant_analyzer))
		var/obj/item/plant_analyzer/P_analyzer = O
		var/msg = ""
		if(myseed)
			if(P_analyzer.scan_mode == PLANT_SCANMODE_STATS)
				msg += "<B>[myseed.plantname]</B>\n"
				msg += "- Plant Age: [span_notice("[age]\n")]"
				var/list/text_string = myseed.get_analyzer_text()
				if(text_string)
					msg += "[text_string]\n"
			if(myseed.reagents_add && P_analyzer.scan_mode == PLANT_SCANMODE_CHEMICALS)
				msg += "<B>Plant Reagents</B>\n"
				for(var/datum/plant_gene/reagent/Gene in myseed.genes)
					msg += "[span_notice("- [Gene.get_name()] -")]\n"
		else
			msg +=  "<B>No plant found.</B>\n"
		msg += "Weed level: [span_notice("[weedlevel] / [MAX_TRAY_WEEDS]")]\n"
		msg += "Pest level: [span_notice("[pestlevel] / [MAX_TRAY_PESTS]")]\n"
		msg += "Toxicity level: [span_notice("[toxic] / [MAX_TRAY_TOXINS]")]\n"
		msg += "Water level: [span_notice("[waterlevel] / [maxwater]")]\n"
		msg += "Nutrition level: [span_notice("[reagents.total_volume] / [maxnutri]")]\n"
		to_chat(user, boxed_message(msg))
		return

	else if(istype(O, /obj/item/cultivator))
		if(weedlevel > 0)
			user.visible_message("[user] uproots the weeds.", span_notice("You remove the weeds from [src]."))
			weedlevel = 0
			update_appearance()
		else
			to_chat(user, span_warning("This plot is completely devoid of weeds! It doesn't need uprooting."))

	else if(istype(O, /obj/item/storage/bag/plants))
		attack_hand(user)
		for(var/obj/item/food/grown/G in locate(user.x,user.y,user.z))
			SEND_SIGNAL(O, COMSIG_TRY_STORAGE_INSERT, G, user, TRUE)

	else if(default_unfasten_wrench(user, O))
		return

	else if(istype(O, /obj/item/shovel/spade))
		if(!myseed && !weedlevel)
			to_chat(user, span_warning("[src] doesn't have any plants or weeds!"))
			return
		user.visible_message(span_notice("[user] starts digging out [src]'s plants..."),
			span_notice("You start digging out [src]'s plants..."))
		if(O.use_tool(src, user, 50, volume=50) || (!myseed && !weedlevel))
			user.visible_message(span_notice("[user] digs out the plants in [src]!"), span_notice("You dig out all of [src]'s plants!"))
			if(myseed) //Could be that they're just using it as a de-weeder
				age = 0
				plant_health = 0
				if(harvest)
					harvest = FALSE //To make sure they can't just put in another seed and insta-harvest it
				QDEL_NULL(myseed)
				name = initial(name)
				desc = initial(desc)
			weedlevel = 0 //Has a side effect of cleaning up those nasty weeds
			update_appearance()
	else if(istype(O, /obj/item/gun/energy/floragun))
		var/obj/item/gun/energy/floragun/flowergun = O
		if(flowergun.cell.charge < REVOLUTION_CHARGE) // In case an admin var edits the gun or guns gain the ability to have their cell upgraded
			to_chat(user, span_notice("[flowergun] must be charged to lock in a mutation!"))
			return
		if(!myseed)
			to_chat(user, span_warning("[src] is empty!"))
			return
		if(myseed.endurance <= 20)
			to_chat(user, span_warning("[myseed.plantname] isn't hardy enough to sequence its mutation!"))
			return
		if(!myseed.mutatelist)
			to_chat(user, span_warning("[myseed.plantname] has nothing else to mutate into!"))
			return
		else
			var/list/fresh_mut_list = list()
			for(var/muties in myseed.mutatelist)
				var/obj/item/seeds/another_mut = new muties
				fresh_mut_list[another_mut.plantname] =  muties
			var/locked_mutation = (input(user, "Select a mutation to lock.", "Plant Mutation Locks") as null|anything in sortList(fresh_mut_list))
			if(!user.canUseTopic(src, BE_CLOSE) || !locked_mutation)
				return
			myseed.mutatelist = list(fresh_mut_list[locked_mutation])
			myseed.endurance = (myseed.endurance/2)
			flowergun.cell.use(REVOLUTION_CHARGE)
			flowergun.update_appearance()
			to_chat(user, span_notice("[myseed.plantname]'s mutation was set to [locked_mutation], depleting [flowergun]'s cell!"))
			return
	else
		return ..()

/obj/machinery/hydroponics/attackby_secondary(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if (istype(weapon, /obj/item/reagent_containers/syringe))
		to_chat(user, span_warning("You can't get any extract out of this plant."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return SECONDARY_ATTACK_CALL_NORMAL

/obj/machinery/hydroponics/can_be_unfasten_wrench(mob/user, silent)
	if (!unwrenchable) // case also covered by NODECONSTRUCT checks in default_unfasten_wrench
		return CANT_UNFASTEN
	return ..()

/obj/machinery/hydroponics/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(issilicon(user)) //How does AI know what plant is?
		return
	if(harvest)
		myseed.harvest(user)
		return

	else if(dead)
		dead = FALSE
		to_chat(user, span_notice("You remove the dead plant from [src]."))
		QDEL_NULL(myseed)
		update_appearance()
		TRAY_NAME_UPDATE
	else
		if(user)
			examine(user)

/obj/machinery/hydroponics/CtrlClick(mob/user)
	. = ..()
	if(!can_self_sustatin)
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(!powered())
		to_chat(user, span_warning("[name] has no power."))
		return
	if(!anchored)
		return
	self_sustaining = !self_sustaining
	if(self_sustaining)
		set_active_power()
	else
		set_idle_power()
	to_chat(user, "<span class='notice'>You [self_sustaining ? "activate" : "deactivated"] [src]'s autogrow function[self_sustaining ? ", maintaining the tray's health while using high amounts of power" : ""].")
	update_appearance()

/obj/machinery/hydroponics/AltClick(mob/user)
	. = ..()
	if(!anchored)
		update_appearance()
		return FALSE
	var/warning = tgui_alert(user, "Are you sure you wish to empty the tray's nutrient beaker?","Empty Tray Nutrients?", list("Yes", "No"))
	if(warning == "Yes" && user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		reagents.clear_reagents()
		to_chat(user, span_warning("You empty [src]'s nutrient tank."))

/obj/machinery/hydroponics/proc/update_tray(mob/user)
	harvest = FALSE
	lastproduce = age
	if(istype(myseed, /obj/item/seeds/replicapod))
		to_chat(user, span_notice("You harvest from the [myseed.plantname]."))
	else if(myseed.getYield() <= 0)
		to_chat(user, span_warning("You fail to harvest anything useful!"))
	else
		to_chat(user, span_notice("You harvest [myseed.getYield()] items from the [myseed.plantname]."))
	if(!myseed.get_gene(/datum/plant_gene/trait/repeated_harvest))
		qdel(myseed)
		myseed = null
		dead = FALSE
		name = initial(name)
		desc = initial(desc)
		TRAY_NAME_UPDATE
		if(self_sustaining) //No reason to pay for an empty tray.
			set_idle_power()
			self_sustaining = FALSE
	update_appearance()

/// Tray Setters - The following procs adjust the tray or plants variables, and make sure that the stat doesn't go out of bounds.///
/obj/machinery/hydroponics/proc/adjustWater(adjustamt)
	waterlevel = clamp(waterlevel + adjustamt, 0, maxwater)

	if(adjustamt>0)
		adjustToxic(-round(adjustamt/4))//Toxicity dilutation code. The more water you put in, the lesser the toxin concentration.

/obj/machinery/hydroponics/proc/adjustHealth(adjustamt)
	if(myseed && !dead)
		plant_health = clamp(plant_health + adjustamt, 0, myseed.endurance)

/obj/machinery/hydroponics/proc/adjustToxic(adjustamt)
	toxic = clamp(toxic + adjustamt, 0, MAX_TRAY_TOXINS)

/obj/machinery/hydroponics/proc/adjustPests(adjustamt)
	pestlevel = clamp(pestlevel + adjustamt, 0, MAX_TRAY_PESTS)

/obj/machinery/hydroponics/proc/adjustWeeds(adjustamt)
	weedlevel = clamp(weedlevel + adjustamt, 0, MAX_TRAY_WEEDS)

/obj/machinery/hydroponics/proc/spawnplant() // why would you put strange reagent in a hydro tray you monster I bet you also feed them blood
	var/list/livingplants = list(/mob/living/simple_animal/hostile/tree, /mob/living/simple_animal/hostile/killertomato)
	var/chosen = pick(livingplants)
	var/mob/living/simple_animal/hostile/C = new chosen
	C.faction = list("plants")

/obj/machinery/hydroponics/proc/get_tgui_info()
	var/list/data = list()
	data["name"] = name
	data["weeds"] = weedlevel
	data["pests"] = pestlevel
	data["toxic"] = toxic
	data["water"] = waterlevel
	data["maxwater"] = maxwater
	data["nutrients"] = reagents.total_volume
	data["maxnutri"] = maxnutri
	data["age"] = age
	data["status"] = get_plant_status()
	data["self_sustaining"] = self_sustaining
	return data

/obj/machinery/hydroponics/proc/get_plant_status()
	if(!myseed)
		return HYDROTRAY_NO_PLANT
	else if(dead)
		return HYDROTRAY_PLANT_DEAD
	else if(harvest)
		return HYDROTRAY_PLANT_HARVESTABLE
	else
		return HYDROTRAY_PLANT_GROWING

