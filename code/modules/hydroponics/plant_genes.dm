/datum/plant_gene
	var/name
	var/mutability_flags = PLANT_GENE_EXTRACTABLE | PLANT_GENE_REMOVABLE ///These flags tells the genemodder if we want the gene to be extractable, only removable or neither.
	/// The font awesome icon name representing the gene in the seed extractor UI (Once i port that -Fallcon)
	var/icon = "dna"

/datum/plant_gene/proc/get_name() // Used for manipulator display and gene disk name.
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += name
	return formatted_name

/*
 * Check if the seed can accept this plant gene.
 *
 * our_seed - the seed we're adding the gene to
 *
 * Returns TRUE if the seed can take the gene, and FALSE otherwise.
 */
/datum/plant_gene/proc/can_add(obj/item/seeds/our_seed)
	SHOULD_CALL_PARENT(TRUE)
	return TRUE

/// Copies over vars and information about our current gene to a new gene and returns the new instance of gene.
/datum/plant_gene/proc/Copy()
	var/datum/plant_gene/new_gene = new type
	new_gene.mutability_flags = mutability_flags
	return new_gene

/*
 * on_new_seed is called when seed genes are initialized on the /obj/seed.
 *
 * new_seed - the seed being created
 */
/datum/plant_gene/proc/on_new_seed(obj/item/seeds/new_seed)
	return // Not implemented

/*
 * on_removed is called when the gene is removed from a seed.
 * Also called when a seed is qdel'd (and all the genes are removed and deleted).
 *
 * old_seed - our seed, before being removed
 */
/datum/plant_gene/proc/on_removed(obj/item/seeds/old_seed)
	return // Not implemented

// Core plant genes store 5 main variables: lifespan, endurance, production, yield, potency
/datum/plant_gene/core
	var/value

/datum/plant_gene/core/get_name()
	return "[name] [value]"

/datum/plant_gene/core/proc/apply_stat(obj/item/seeds/S)
	return

/datum/plant_gene/core/New(i = null)
	..()
	if(!isnull(i))
		value = i

/datum/plant_gene/core/Copy()
	var/datum/plant_gene/core/C = ..()
	C.value = value
	return C

/datum/plant_gene/core/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	return S.get_gene(src.type)

/datum/plant_gene/core/lifespan
	name = "Lifespan"
	value = 25

/datum/plant_gene/core/lifespan/apply_stat(obj/item/seeds/S)
	S.lifespan = value


/datum/plant_gene/core/endurance
	name = "Endurance"
	value = 15

/datum/plant_gene/core/endurance/apply_stat(obj/item/seeds/S)
	S.endurance = value


/datum/plant_gene/core/production
	name = "Production Speed"
	value = 6

/datum/plant_gene/core/production/apply_stat(obj/item/seeds/S)
	S.production = value


/datum/plant_gene/core/yield
	name = "Yield"
	value = 3

/datum/plant_gene/core/yield/apply_stat(obj/item/seeds/S)
	S.yield = value


/datum/plant_gene/core/potency
	name = "Potency"
	value = 25

/datum/plant_gene/core/potency/apply_stat(obj/item/seeds/S)
	S.potency = value

/datum/plant_gene/core/instability
	name = "Stability"
	value = 10

/datum/plant_gene/core/instability/apply_stat(obj/item/seeds/seed)
	seed.instability = value

/datum/plant_gene/core/weed_rate
	name = "Weed Growth Rate"
	value = 1

/datum/plant_gene/core/weed_rate/apply_stat(obj/item/seeds/S)
	S.weed_rate = value


/datum/plant_gene/core/weed_chance
	name = "Weed Vulnerability"
	value = 5

/datum/plant_gene/core/weed_chance/apply_stat(obj/item/seeds/S)
	S.weed_chance = value


// Reagent genes store reagent ID and reagent ratio. Amount of reagent in the plant = 1 + (potency * rate)
/datum/plant_gene/reagent
	name = "Nutriment"
	var/reagent_id = /datum/reagent/consumable/nutriment
	var/rate = 0.04

/datum/plant_gene/reagent/get_name()
	var/formatted_name
	if(!(mutability_flags & PLANT_GENE_REMOVABLE && mutability_flags & PLANT_GENE_EXTRACTABLE))
		if(mutability_flags & PLANT_GENE_REMOVABLE)
			formatted_name += "Fragile "
		else if(mutability_flags & PLANT_GENE_EXTRACTABLE)
			formatted_name += "Essential "
		else
			formatted_name += "Immutable "
	formatted_name += "[name] production [rate*100]%"
	return formatted_name

/datum/plant_gene/reagent/proc/set_reagent(reag_id)
	reagent_id = reag_id
	name = "UNKNOWN"

	var/datum/reagent/R = GLOB.chemical_reagents_list[reag_id]
	if(R && R.type == reagent_id)
		name = R.name

/datum/plant_gene/reagent/New(reag_id = null, reag_rate = 0)
	..()
	if(reag_id && reag_rate)
		set_reagent(reag_id)
		rate = reag_rate

/datum/plant_gene/reagent/Copy()
	var/datum/plant_gene/reagent/G = ..()
	G.name = name
	G.reagent_id = reagent_id
	G.rate = rate
	return G

/datum/plant_gene/reagent/can_add(obj/item/seeds/S)
	if(!..())
		return FALSE
	for(var/datum/plant_gene/reagent/R in S.genes)
		if(R.reagent_id == reagent_id)
			return FALSE
	return TRUE

/datum/plant_gene/reagent/polypyr
	name = "Polypyrylium Oligomers"
	reagent_id = /datum/reagent/medicine/polypyr
	rate = 0.15

/datum/plant_gene/reagent/liquidelectricity
	name = "Liquid Electricity"
	reagent_id = /datum/reagent/consumable/liquidelectricity
	rate = 0.1

// Various traits affecting the product.
/datum/plant_gene/trait
	/// The rate at which this trait affects something. This can be anything really - why? I dunno.
	var/rate = 0.05
	var/examine_line = ""
	/// Bonus lines displayed on examine.
	var/description = ""
	/// Flag - Traits that share an ID cannot be placed on the same plant.
	var/trait_ids
	/// Flag - Modifications made to the final product.
	var/trait_flags
	/// A blacklist of seeds that a trait cannot be attached to.
	var/list/obj/item/seeds/seed_blacklist

/datum/plant_gene/trait/Copy()
	var/datum/plant_gene/trait/G = ..()
	G.rate = rate
	return G

/datum/plant_gene/trait/can_add(obj/item/seeds/source_seed)
	if(!..())
		return FALSE

	for(var/obj/item/seeds/found_seed as anything in seed_blacklist)
		if(istype(source_seed, found_seed))
			return FALSE

	for(var/datum/plant_gene/trait/trait in source_seed.genes)
		if(trait_ids & trait.trait_ids)
			return FALSE
		if(type == trait.type)
			return FALSE

	return TRUE

/*
 * on_new_plant is called for every plant trait on an /obj/item/grown or /obj/item/food/grown when initialized.
 *
 * our_plant - the source plant being created
 * newloc - the loc of the plant
 */
/datum/plant_gene/trait/proc/on_new_plant(obj/item/food/grown/our_plant, newloc)
	// Plants should always have seeds, but if a plant gene is somehow being instantiated on a plant with no seed, stop initializing genes
	// (Plants hold their genes on their seeds, so we can't really add them to something that doesn't exist)
	if(isnull(our_plant.get_plant_seed()))
		stack_trace("[our_plant] ([our_plant.type]) has a nulled seed value while trying to initialize [src]!")
		return FALSE

	// Add on any bonus lines on examine
	if(description)
		RegisterSignal(our_plant, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	return TRUE

/*
 * on_new_seed is called when seed genes are initialized on the /obj/seed.
 *
 * new_seed - the seed being created
 */
/datum/plant_gene/trait/on_new_seed(obj/item/seeds/new_seed)
	return TRUE

/// Add on any unique examine text to the plant's examine text.
/datum/plant_gene/trait/proc/examine(obj/item/food/grown/our_plant, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_info("[description]")

/datum/plant_gene/trait/proc/on_new(obj/item/food/grown/G, newloc)
	return

/datum/plant_gene/trait/proc/on_consume(obj/item/food/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_slip(obj/item/food/grown/G, mob/living/carbon/target)
	return

/datum/plant_gene/trait/proc/on_squash(obj/item/food/grown/G, atom/target)
	return

/datum/plant_gene/trait/proc/on_squashreact(obj/item/food/grown/G, atom/target)
	return

/datum/plant_gene/trait/proc/on_attackby(obj/item/food/grown/G, obj/item/I, mob/user)
	return

/datum/plant_gene/trait/proc/on_throw_impact(obj/item/food/grown/G, atom/target)
	return

///This proc triggers when the tray processes and a roll is sucessful, the success chance scales with production.
/datum/plant_gene/trait/proc/on_grow(obj/machinery/hydroponics/H)
	return

/// Allows the plant to be squashed when thrown or slipped on, leaving a colored mess and trash type item behind.
/datum/plant_gene/trait/squash
	name = "Liquid Contents"
	icon = "droplet"
	description = "It may burst open from the internal pressure on impact."
	trait_ids = THROW_IMPACT_ID | REAGENT_TRANSFER_ID | ATTACK_SELF_ID
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

// Register a signal that our plant can be squashed on add.
/datum/plant_gene/trait/squash/on_new_plant(obj/item/food/grown/our_plant, newloc)
	. = ..()
	if(!.)
		return

	RegisterSignal(our_plant, COMSIG_PLANT_ON_SLIP, PROC_REF(squash_plant))
	RegisterSignal(our_plant, COMSIG_MOVABLE_IMPACT, PROC_REF(squash_plant))
	RegisterSignal(our_plant, COMSIG_ITEM_ATTACK_SELF, PROC_REF(squash_plant))

/*
 * Signal proc to squash the plant this trait belongs to, causing a smudge, exposing the target to reagents, and deleting it,
 *
 * Arguments
 * our_plant - the plant this trait belongs to.
 * target - the atom being hit by this squashed plant.
 */
/datum/plant_gene/trait/squash/proc/squash_plant(obj/item/food/grown/our_plant, atom/target)
	SIGNAL_HANDLER

	var/turf/our_turf = get_turf(target)
	our_plant.forceMove(our_turf)
	if(istype(our_plant))
		if(ispath(our_plant.splat_type, /obj/effect/decal/cleanable/food/plant_smudge))
			var/obj/plant_smudge = new our_plant.splat_type(our_turf)
			plant_smudge.name = "[our_plant.name] smudge"
			if(our_plant.filling_color)
				plant_smudge.color = our_plant.filling_color
		else if(our_plant.splat_type)
			new our_plant.splat_type(our_turf)
	else
		var/obj/effect/decal/cleanable/food/plant_smudge/misc_smudge = new(our_turf)
		misc_smudge.name = "[our_plant.name] smudge"
		misc_smudge.color = "#82b900"

	our_plant.visible_message(span_warning("[our_plant] is squashed."),span_hear("You hear a smack."))
	SEND_SIGNAL(our_plant, COMSIG_PLANT_ON_SQUASH, target)

	our_plant.reagents?.expose(our_turf)
	for(var/things in our_turf)
		our_plant.reagents?.expose(things)

	qdel(our_plant)

/*
 * Makes plant slippery, unless it has a grown-type trash. Then the trash gets slippery.
 * Applies other trait effects (teleporting, etc) to the target by signal.
 */
/datum/plant_gene/trait/slip
	name = "Slippery Skin"
	description = "Watch your step around this."
	icon = "person-falling"
	rate = 1.6
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/slip/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	var/obj/item/food/grown/grown_plant = our_plant
	if(istype(grown_plant) && ispath(grown_plant.trash_type, /obj/item/grown))
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/stun_len = our_seed.potency * rate

	if(!istype(our_plant, /obj/item/grown/bananapeel) && (!our_plant.reagents || !our_plant.reagents.has_reagent(/datum/reagent/lube)))
		stun_len /= 3

	our_plant.AddComponent(/datum/component/slippery, min(stun_len, 140), NONE, CALLBACK(src, PROC_REF(handle_slip), our_plant))

/// On slip, sends a signal that our plant was slipped on out.
/datum/plant_gene/trait/slip/proc/handle_slip(obj/item/food/grown/our_plant, mob/slipped_target)
	SEND_SIGNAL(our_plant, COMSIG_PLANT_ON_SLIP, slipped_target)


/*
 * Cell recharging trait. Charges all mob's power cells to (potency*rate)% mark when eaten.
 * Generates sparks on squash.
 * Small (potency * rate) chance to shock squish or slip target for (potency * rate) damage.
 * Also affects plant batteries see capatative cell production datum
 */
/datum/plant_gene/trait/cell_charge
	name = "Electrical Activity"
	description = "It can electrocute on interaction or recharge batteries when eaten."
	icon = "bolt"
	rate = 0.2
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/cell_charge/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	if(our_seed.get_gene(/datum/plant_gene/trait/squash))
		// If we have the squash gene, let that handle slipping
		RegisterSignal(our_plant, COMSIG_PLANT_ON_SQUASH, PROC_REF(zap_target))
	else
		RegisterSignal(our_plant, COMSIG_PLANT_ON_SLIP, PROC_REF(zap_target))

	RegisterSignal(our_plant, COMSIG_FOOD_EATEN, PROC_REF(recharge_cells))

/*
 * Zaps the target with a stunning shock.
 *
 * our_plant - our source plant, shocking the target
 * target - the atom being zapped by our plant
 */
/datum/plant_gene/trait/cell_charge/proc/zap_target(obj/item/our_plant, atom/target)
	SIGNAL_HANDLER

	if(!iscarbon(target))
		return

	our_plant.investigate_log("zapped [key_name(target)] at [AREACOORD(target)]. Last touched by: [our_plant.fingerprintslast].", INVESTIGATE_BOTANY)
	var/mob/living/carbon/target_carbon = target
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/power = our_seed.potency * rate
	if(prob(power))
		target_carbon.electrocute_act(round(power), our_plant, 1, SHOCK_NOGLOVES)

/*
 * Recharges every cell the person is holding for a bit based on plant potency.
 *
 * our_plant - our source plant, that we consumed to charge the cells
 * eater - the mob that bit the plant
 * feeder - the mob that feed the eater the plant
 */
/datum/plant_gene/trait/cell_charge/proc/recharge_cells(obj/item/our_plant, mob/living/carbon/eater, mob/feeder)
	SIGNAL_HANDLER

	to_chat(eater, span_notice("You feel energized as you bite into [our_plant]."))
	var/batteries_recharged = FALSE
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	for(var/obj/item/stock_parts/cell/found_cell in eater.get_contents())
		var/newcharge = min(our_seed.potency * 0.01 * found_cell.maxcharge, found_cell.maxcharge)
		if(found_cell.charge < newcharge)
			found_cell.charge = newcharge
			if(isobj(found_cell.loc))
				var/obj/cell_location = found_cell.loc
				cell_location.update_appearance() //update power meters and such
			found_cell.update_appearance()
			batteries_recharged = TRUE
	if(batteries_recharged)
		to_chat(eater, span_notice("Your batteries are recharged!"))

/*
 * Makes the plant glow. Makes the plant in tray glow, too.
 * Adds (1.4 + potency * rate) light range and (potency * (rate + 0.01)) light_power to products.
 */
/datum/plant_gene/trait/glow
	name = "Bioluminescence"
	icon = "lightbulb"
	rate = 0.03
	description = "It emits a soft glow."
	trait_ids = GLOW_ID
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE
	var/glow_color = "#C3E381"

/datum/plant_gene/trait/glow/proc/glow_range(obj/item/seeds/S)
	return 1.4 + S.potency*rate

/datum/plant_gene/trait/glow/proc/glow_power(obj/item/seeds/S)
	return max(S.potency*(rate + 0.01), 0.1)

/datum/plant_gene/trait/glow/on_new_plant(obj/item/food/grown/G, newloc)
	. = ..()
	G.light_system = MOVABLE_LIGHT
	G.AddComponent(/datum/component/overlay_lighting, glow_range(G.seed), glow_power(G.seed), glow_color)

/*
 * Makes plant emit darkness. (Purple-ish shadows)
 * Adds - (potency * (rate * 0.2)) light power to products.
 */
/datum/plant_gene/trait/glow/shadow
	name = "Shadow Emission"
	icon = "lightbulb-o"
	rate = 0.04
	glow_color = "#AAD84B"

/datum/plant_gene/trait/glow/shadow/glow_power(obj/item/seeds/S)
	return -max(S.potency*(rate*0.2), 0.2)

/datum/plant_gene/trait/glow/white
	name = "White Bioluminescence"
	glow_color = "#FFFFFF"

/datum/plant_gene/trait/glow/red
	//Colored versions of bioluminescence.
	name = "Red Bioluminescence"
	glow_color = "#FF3333"

/datum/plant_gene/trait/glow/yellow
	//not the disgusting glowshroom yellow hopefully
	name = "Yellow Bioluminescence"
	glow_color = "#FFFF66"

/datum/plant_gene/trait/glow/green
	//oh no, now i'm radioactive
	name = "Green Bioluminescence"
	glow_color = "#99FF99"

/datum/plant_gene/trait/glow/blue
	//the best one
	name = "Blue Bioluminescence"
	glow_color = "#6699FF"

/datum/plant_gene/trait/glow/purple
	//did you know that notepad++ doesnt think bioluminescence is a word
	name = "Purple Bioluminescence"
	glow_color = "#D966FF"

/datum/plant_gene/trait/glow/pink
	//gay tide station pride
	name = "Pink Bioluminescence"
	glow_color = "#FFB3DA"

/*
 * Makes plant teleport people when squashed or slipped on.
 * Teleport radius is roughly potency / 10.
 */
/datum/plant_gene/trait/teleport
	name = "Bluespace Activity"
	description = "It causes people to teleport on interaction."
	icon = "right-left"
	rate = 0.1
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/teleport/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	if(our_seed.get_gene(/datum/plant_gene/trait/squash))
		// If we have the squash gene, let that handle slipping
		RegisterSignal(our_plant, COMSIG_PLANT_ON_SQUASH, PROC_REF(squash_teleport))
	else
		RegisterSignal(our_plant, COMSIG_PLANT_ON_SLIP, PROC_REF(slip_teleport))

/*
 * When squashed, makes the target teleport.
 *
 * our_plant - our plant, being squashed, and teleporting the target
 * target - the atom targeted by the squash
 */
/datum/plant_gene/trait/teleport/proc/squash_teleport(obj/item/our_plant, atom/target)
	SIGNAL_HANDLER

	if(!isliving(target))
		return

	our_plant.investigate_log("squash-teleported [key_name(target)] at [AREACOORD(target)]. Last touched by: [our_plant.fingerprintslast].", INVESTIGATE_BOTANY)
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/teleport_radius = max(round(our_seed.potency / 10), 1)
	var/turf/T = get_turf(target)
	new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
	do_teleport(target, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)

/*
 * When slipped on, makes the target teleport and either teleport the source again or delete it.
 *
 * our_plant - our plant being slipped on
 * target - the carbon targeted that was slipped and was teleported
 */
/datum/plant_gene/trait/teleport/proc/slip_teleport(obj/item/our_plant, mob/living/carbon/target)
	SIGNAL_HANDLER

	our_plant.investigate_log("slip-teleported [key_name(target)] at [AREACOORD(target)]. Last touched by: [our_plant.fingerprintslast].", INVESTIGATE_BOTANY)
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/teleport_radius = max(round(our_seed.potency / 10), 1)
	var/turf/T = get_turf(target)
	to_chat(target, span_warning("You slip through spacetime!"))
	do_teleport(target, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	if(prob(50))
		do_teleport(our_plant, T, teleport_radius, channel = TELEPORT_CHANNEL_BLUESPACE)
	else
		new /obj/effect/decal/cleanable/molten_object(T) //Leave a pile of goo behind for dramatic effect...
		qdel(our_plant)

/**
 * A plant trait that causes the plant's capacity to double.
 *
 * When harvested, the plant's individual capacity is set to double it's default.
 */
/datum/plant_gene/trait/maxchem
	name = "Densified Chemicals"
	description = "The reagent volume is doubled."
	icon = "flask-vial"
	rate = 2
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/maxchem/on_new_plant(obj/item/food/grown/our_plant, newloc)
	. = ..()
	if(!.)
		return

	our_plant.reagents?.maximum_volume *= rate

/// Allows a plant to be harvested multiple times.
/datum/plant_gene/trait/repeated_harvest
	name = "Perennial Growth"
	description = "It may be harvested multiple times from the same plant."
	icon = "cubes-stacked"
	/// Don't allow replica pods to be multi harvested, please.
	seed_blacklist = list(
		/obj/item/seeds/replicapod,
	)
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/*
 * Allows a plant to be turned into a battery when cabling is applied.
 * 100 potency plants are made into 2 mj batteries.
 * Plants with electrical activity has their capacities massively increased (up to 40 mj at 100 potency)
 */
/datum/plant_gene/trait/battery
	name = "Capacitive Cell Production"
	description = "It can work like a power cell when wired properly."
	icon = "car-battery"
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE
	/// The number of cables needed to make a battery.
	var/cables_needed_per_battery = 5

/datum/plant_gene/trait/battery/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	RegisterSignal(our_plant, COMSIG_ATOM_ATTACKBY, PROC_REF(make_battery))

/*
 * When a plant with this gene is hit (attackby) with cables, we turn it into a battery.
 *
 * our_plant - our plant being hit
 * hit_item - the item we're hitting the plant with
 * user - the person hitting the plant with an item
 */
/datum/plant_gene/trait/battery/proc/make_battery(obj/item/our_plant, obj/item/hit_item, mob/user)
	SIGNAL_HANDLER

	if(!istype(hit_item, /obj/item/stack/cable_coil))
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	var/obj/item/stack/cable_coil/cabling = hit_item
	if(!cabling.use(cables_needed_per_battery))
		to_chat(user, span_warning("You need five lengths of cable to make a [our_plant] battery!"))
		return

	to_chat(user, span_notice("You add some cable to [our_plant] and slide it inside the battery encasing."))
	var/obj/item/stock_parts/cell/potato/pocell = new /obj/item/stock_parts/cell/potato(user.loc)
	pocell.icon = our_plant.icon // Just in case the plant icons get spread out in different files eventually, this trait won't cause error sprites (also yay downstreams)
	pocell.icon_state = our_plant.icon_state
	pocell.maxcharge = our_seed.potency

	// The secret of potato supercells!
	var/datum/plant_gene/trait/cell_charge/electrical_gene = our_seed.get_gene(/datum/plant_gene/trait/cell_charge)
	if(electrical_gene) // Cell charge max is now 40MJ or otherwise known as 400KJ (Same as bluespace power cells)
		pocell.maxcharge *= (electrical_gene.rate * 100)

	pocell.charge = pocell.maxcharge
	pocell.name = "[our_plant.name] battery"
	pocell.desc = "A rechargeable plant-based power cell. This one has a rating of [DisplayEnergy(pocell.maxcharge)], and you should not swallow it."

	if(our_plant.reagents.has_reagent(/datum/reagent/toxin/plasma, 2))
		pocell.rigged = TRUE

	qdel(our_plant)

/*
 * Injects a number of chemicals from the plant when you throw it at someone or they slip on it.
 * At 0 potency it can inject 1 unit of its chemicals, while at 100 potency it can inject 20 units.
 */
/datum/plant_gene/trait/stinging
	name = "Hypodermic Prickles"
	description = "It stings, passing some reagents in the process."
	icon = "syringe"
	trait_ids = REAGENT_TRANSFER_ID
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/stinging/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	RegisterSignal(our_plant, COMSIG_PLANT_ON_SLIP, PROC_REF(prickles_inject))
	RegisterSignal(our_plant, COMSIG_MOVABLE_IMPACT, PROC_REF(prickles_inject))

/*
 * Injects a target with a number of reagents from our plant.
 *
 * our_plant - our plant that's injecting someone
 * target - the atom being hit on thrown or slipping on our plant
 */
/datum/plant_gene/trait/stinging/proc/prickles_inject(obj/item/our_plant, atom/target)
	SIGNAL_HANDLER

	if(!isliving(target) || !our_plant.reagents?.total_volume)
		return

	var/mob/living/living_target = target
	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	if(living_target.reagents && living_target.can_inject())
		var/injecting_amount = max(1, our_seed.potency * 0.2) // Minimum of 1, max of 20
		our_plant.reagents.trans_to(living_target, injecting_amount, methods = INJECT)
		to_chat(target, span_danger("You are pricked by [our_plant]!"))
		log_combat(our_plant, living_target, "pricked and attempted to inject reagents from [our_plant] to [living_target]. Last touched by: [our_plant.fingerprintslast].")
		our_plant.investigate_log("pricked and injected [key_name(living_target)] and injected [injecting_amount] reagents at [AREACOORD(living_target)]. Last touched by: [our_plant.fingerprintslast].", INVESTIGATE_BOTANY)

/// Explodes into reagent-filled smoke when squashed.
/datum/plant_gene/trait/smoke
	name = "Gaseous Decomposition"
	description = "It can be smashed to turn its Liquid Contents into smoke."
	icon = "cloud"
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/smoke/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	RegisterSignal(our_plant, COMSIG_PLANT_ON_SQUASH, PROC_REF(make_smoke))

/*
 * Makes a cloud of reagent smoke.
 *
 * our_plant - our plant being squashed and smoked
 * target - the atom the plant was squashed on
 */
/datum/plant_gene/trait/smoke/proc/make_smoke(obj/item/food/grown/our_plant, atom/target)
	SIGNAL_HANDLER

	our_plant.investigate_log("made smoke at [AREACOORD(target)]. Last touched by: [our_plant.fingerprintslast].", INVESTIGATE_BOTANY)
	var/datum/effect_system/smoke_spread/chem/smoke = new
	var/splat_location = get_turf(target)
	var/smoke_amount = round(sqrt(our_plant.seed.potency * 0.1), 1)
	smoke.attach(splat_location)
	smoke.set_up(our_plant.reagents, smoke_amount, splat_location, 0)
	smoke.start()
	our_plant.reagents.clear_reagents()

/// Makes the plant and its seeds fireproof. From lavaland plants.
/datum/plant_gene/trait/fire_resistance
	name = "Fire Resistance"
	description = "Makes the seeds, plant and produce fireproof."
	icon = "fire"
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/fire_resistance/on_new_seed(obj/item/seeds/new_seed)
	if(!(new_seed.resistance_flags & FIRE_PROOF))
		new_seed.resistance_flags |= FIRE_PROOF

/datum/plant_gene/trait/fire_resistance/on_removed(obj/item/seeds/old_seed)
	if(old_seed.resistance_flags & FIRE_PROOF)
		old_seed.resistance_flags &= ~FIRE_PROOF

/datum/plant_gene/trait/fire_resistance/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	if(!(our_plant.resistance_flags & FIRE_PROOF))
		our_plant.resistance_flags |= FIRE_PROOF

/// Invasive spreading lets the plant jump to other trays, and the spreading plant won't replace plants of the same type.
/datum/plant_gene/trait/invasive
	name = "Invasive Spreading"
	description = "It attempts to spread around if not contained."
	icon = "virus"
	mutability_flags = PLANT_GENE_REMOVABLE | PLANT_GENE_MUTATABLE | PLANT_GENE_EXTRACTABLE

/datum/plant_gene/trait/invasive/on_new_seed(obj/item/seeds/new_seed)
	RegisterSignal(new_seed, COMSIG_SEED_ON_GROW, PROC_REF(try_spread))

/datum/plant_gene/trait/invasive/on_removed(obj/item/seeds/old_seed)
	UnregisterSignal(old_seed, COMSIG_SEED_ON_GROW)

/*
 * Attempt to find an adjacent tray we can spread to.
 *
 * our_seed - our plant's seed, what spreads to other trays
 * our_tray - the hydroponics tray we're currently in
 */
/datum/plant_gene/trait/invasive/proc/try_spread(obj/item/seeds/our_seed, obj/machinery/hydroponics/our_tray)
	SIGNAL_HANDLER

	if(prob(100 - (5 * (11 - our_seed.production))))
		return

	for(var/step_dir in GLOB.alldirs)
		var/obj/machinery/hydroponics/spread_tray = locate() in get_step(our_tray, step_dir)
		if(spread_tray && prob(15))
			if(!our_tray.Adjacent(spread_tray))
				continue //Don't spread through things we can't go through.

			spread_seed(spread_tray, our_tray)

/*
 * Actually spread the plant to the tray we found in try_spread.
 *
 * target_tray - the tray we're spreading to
 * origin_tray - the tray we're currently in
 */
/datum/plant_gene/trait/invasive/proc/spread_seed(obj/machinery/hydroponics/target_tray, obj/machinery/hydroponics/origin_tray)
	if(target_tray.myseed) // Check if there's another seed in the next tray.
		if(target_tray.myseed.type == origin_tray.myseed.type && target_tray.dead != FALSE)
			return FALSE // It should not destroy its own kind.
		target_tray.visible_message(span_warning("The [target_tray.myseed.plantname] is overtaken by [origin_tray.myseed.plantname]!"))
		QDEL_NULL(target_tray.myseed)
	target_tray.myseed = origin_tray.myseed.Copy()
	target_tray.age = 0
	target_tray.plant_health = target_tray.myseed.endurance
	target_tray.lastcycle = world.time
	target_tray.weedlevel = 0
	target_tray.pestlevel = 0
	target_tray.visible_message(span_warning("The [origin_tray.myseed.plantname] spreads!"))
	if(target_tray.myseed)
		target_tray.name = "[initial(target_tray.name)] ([target_tray.myseed.plantname])"
	else
		target_tray.name = initial(target_tray.name)

	return TRUE

/// Makes the plant embed on thrown impact.
/datum/plant_gene/trait/sticky
	name = "Prickly Adhesion"
	description = "It sticks to people when thrown, also passing reagents if stingy."
	icon = "bandage"
	trait_ids = THROW_IMPACT_ID

/datum/plant_gene/trait/sticky/on_new_plant(obj/item/our_plant, newloc)
	. = ..()
	if(!.)
		return

	var/obj/item/seeds/our_seed = our_plant.get_plant_seed()
	if(our_seed.get_gene(/datum/plant_gene/trait/stinging))
		our_plant.embedding = EMBED_POINTY
	else
		our_plant.embedding = EMBED_HARMLESS
	our_plant.updateEmbedding()
	our_plant.throwforce = (our_seed.potency/20)

/datum/plant_gene/trait/carnivory
	name = "Obligate Carnivory"
	description = "Pests have positive effect on the plant health."
	icon = "spider"

/// Plant type traits. Incompatible with one another.
/datum/plant_gene/trait/plant_type
	name = "you shouldn't see this"
	trait_ids = PLANT_TYPE_ID
	mutability_flags = PLANT_GENE_EXTRACTABLE

/// Weeds don't get annoyed by weeds in their tray.
/datum/plant_gene/trait/plant_type/weed_hardy
	name = "Weed Adaptation"
	description = "It is a weed that needs no nutrients and doesn't suffer from other weeds."
	icon = "seedling"

/// Mushrooms need less light and have a minimum yield.
/datum/plant_gene/trait/plant_type/fungal_metabolism
	name = "Fungal Vitality"
	description = "It is a mushroom that needs no water, less light and can't be overtaken by weeds."
	icon = "droplet-slash"

/// Currently unused and does nothing. Appears in strange seeds.
/datum/plant_gene/trait/plant_type/alien_properties
	name ="?????"
	icon = "reddit-alien"

/datum/plant_gene/trait/plant_type/crystal
	name = "Crystalline Growing Patterns"
