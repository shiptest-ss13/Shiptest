// ***********************************************************
// Foods that are produced from hydroponics ~~~~~~~~~~
// Data from the seeds carry over to these grown foods
// ***********************************************************

// Base type. Subtypes are found in /grown dir. Lavaland-based subtypes can be found in mining/ash_flora.dm
/obj/item/reagent_containers/food/snacks/grown
	icon = 'icons/obj/hydroponics/harvest.dmi'
	name = "fresh produce" // so recipe text doesn't say 'snack'
	var/obj/item/seeds/seed = null // type path, gets converted to item on New(). It's safe to assume it's always a seed item.
	var/plantname = ""
	var/bitesize_mod = 0
	var/splat_type = /obj/effect/decal/cleanable/food/plant_smudge
	// If set, bitesize = 1 + round(reagents.total_volume / bitesize_mod)
	dried_type = -1
	// Saves us from having to define each stupid grown's dried_type as itself.
	// If you don't want a plant to be driable (watermelons) set this to null in the time definition.
	resistance_flags = FLAMMABLE
	var/dry_grind = FALSE //If TRUE, this object needs to be dry to be ground up
	var/can_distill = TRUE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/wine_flavor //If NULL, this is automatically set to the fruit's flavor. Determines the flavor of the wine if distill_reagent is NULL.
	var/wine_power = 10 //Determines the boozepwr of the wine if distill_reagent is NULL.

/obj/item/reagent_containers/food/snacks/grown/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	if(!tastes)
		tastes = list("[name]" = 1)

	if(new_seed)
		seed = new_seed.Copy()
	else if(ispath(seed))
		// This is for adminspawn or map-placed growns. They get the default stats of their seed type.
		seed = new seed()
		seed.adjust_potency(50-seed.potency)

	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

	if(dried_type == -1)
		dried_type = src.type

	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			T.on_new(src, loc)
		seed.prepare_result(src)
		transform *= TRANSFORM_USING_VARIABLE(seed.potency, 100) + 0.5 //Makes the resulting produce's sprite larger or smaller based on potency!
		add_juice()



/obj/item/reagent_containers/food/snacks/grown/proc/add_juice()
	if(reagents)
		if(bitesize_mod)
			bitesize = 1 + round(reagents.total_volume / bitesize_mod)
		return 1
	return 0

/obj/item/reagent_containers/food/snacks/grown/examine(user)
	. = ..()
	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			if(T.examine_line)
				. += T.examine_line

/obj/item/reagent_containers/food/snacks/grown/attackby(obj/item/O, mob/user, params)
	..()
	if (istype(O, /obj/item/plant_analyzer))
		var/msg = "<span class='info'>*---------*\n This is \a <span class='name'>[src]</span>.\n"
		if(seed)
			msg += seed.get_analyzer_text()
		var/reag_txt = ""
		if(seed)
			for(var/reagent_id in seed.reagents_add)
				var/datum/reagent/R  = GLOB.chemical_reagents_list[reagent_id]
				var/amt = reagents.get_reagent_amount(reagent_id)
				reag_txt += "\n<span class='info'>- [R.name]: [amt]</span>"

		if(reag_txt)
			msg += reag_txt
			msg += "<br><span class='info'>*---------*</span>"
		to_chat(user, msg)
	else
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_attackby(src, O, user)

/proc/flamingmoai(obj/item/O, t_max, mob/living/user)
	var/t_amount = 0
	var/list/seeds = list()

	var/seedloc = O.loc
	if(user)
		seedloc = user.drop_location()

	if(istype(O, /obj/item/reagent_containers/food/snacks/grown/))
		var/obj/item/reagent_containers/food/snacks/grown/F = O
		if(F.seed)
			if(user && !user.temporarilyRemoveItemFromInventory(O)) //couldn't drop the item
				return
			while(t_amount < t_max)
				var/obj/item/seeds/t_prod = F.seed.Copy()
				seeds.Add(t_prod)
				t_prod.forceMove(seedloc)
				t_amount++
			qdel(O)
			return seeds
//Ghetto Seed Extraction
/obj/item/reagent_containers/food/snacks/grown/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message("<span class='notice'>[user] starts slicing apart \the [src].</span>", "<span class='notice'>You start slicing apart \the [src]...</span>", "<span class='hear'>You hear the sound of a sharp object slicing some plant matter.</span>")
		if(do_after(user, 50, target = src))
			to_chat(user, "<span class='notice'>You slice apart the [src]! You went too far and the tiny remaining scraps are worthless!</span>")
			/*	new /obj/item/reagent_containers/food/snacks/grown/sliced(user.drop_location(), 1)
			use(1) */
			flamingmoai(src, 1, user)
	else
		switch(W.tool_behaviour)
			if(TOOL_SCREWDRIVER)
				playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
				user.visible_message("<span class='notice'>[user] starts digging into \the [src].</span>", "<span class='notice'>You start digging into \the [src]...</span>", "<span class='hear'>You hear the sound of a sharp object penetrating some plant matter.</span>")
				if(do_after(user, 50, target = src))
					to_chat(user, "<span class='notice'>You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!</span>")
					/*	new /obj/item/reagent_containers/food/snacks/grown/chipped(user.drop_location(), 1)
					use(1) */
					flamingmoai(src, 1, user)
			if(TOOL_HEMOSTAT)
				playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
				user.visible_message("<span class='notice'>[user] starts digging into \the [src].</span>", "<span class='notice'>You start digging into \the [src]...</span>", "<span class='hear'>You hear the sound of a sharp object penetrating some plant matter.</span>")
				if(do_after(user, 50, target = src))
					to_chat(user, "<span class='notice'>You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!</span>")
					/*	new /obj/item/reagent_containers/food/snacks/grown/chipped(user.drop_location(), 1)
					use(1) */
					flamingmoai(src, 1, user)
			if(TOOL_WIRECUTTER)
				playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
				user.visible_message("<span class='notice'>[user] starts chipping into \the [src].</span>", "<span class='notice'>You start chipping into \the [src]...</span>", "<span class='hear'>You hear the sound of a sharp object penetrating some plant matter.</span>")
				if(do_after(user, 50, target = src))
					to_chat(user, "<span class='notice'>You dig into the [src] to collect it's seeds! It's all gross and unusuable now, ew!</span>")
					flamingmoai(src, 1, user)
			if(TOOL_CROWBAR)
				playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
				user.visible_message("<span class='notice'>[user] starts splitting \the [src].</span>", "<span class='notice'>You dig into \the [src] and start to split it...</span>", "<span class='hear'>You hear the sound of a sharp object digging into some plant matter.</span>")
				if(do_after(user, 50, target = src))
					to_chat(user, "<span class='notice'>You split apart the [src]! Sadly you put too much force and it's remains are unusable, but hey, you got your seeds!</span>")
					/*	new /obj/item/reagent_containers/food/snacks/grown/split(user.drop_location(), 1)
					use(1) */
					flamingmoai(src, 1, user)
			if(TOOL_WRENCH)
				playsound(loc, 'sound/weapons/smash.ogg', 50, TRUE, -1)
				user.visible_message("<span class='notice'>[user] starts wackng \the [src].</span>", "<span class='notice'>You start wacking \the [src]...</span>", "<span class='hear'>You hear the sound of a plant being wacked violently.</span>")
				if(do_after(user, 50, target = src))
					to_chat(user, "<span class='notice'>You smash [src]! Sadly there's nothing left of it other than the seeds.</span>")
					/*	new /obj/item/reagent_containers/food/snacks/grown/smacked(user.drop_location(), 1)
					use(1) */
					flamingmoai(src, 1, user)
			else
				return ..()

// Various gene procs
/obj/item/reagent_containers/food/snacks/grown/attack_self(mob/user)
	if(seed && seed.get_gene(/datum/plant_gene/trait/squash))
		squash(user)
	..()

/obj/item/reagent_containers/food/snacks/grown/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_throw_impact(src, hit_atom)
			if(seed.get_gene(/datum/plant_gene/trait/squash))
				squash(hit_atom)

/obj/item/reagent_containers/food/snacks/grown/proc/squash(atom/target)
	var/turf/T = get_turf(target)
	forceMove(T)
	if(ispath(splat_type, /obj/effect/decal/cleanable/food/plant_smudge))
		if(filling_color)
			var/obj/O = new splat_type(T)
			O.color = filling_color
			O.name = "[name] smudge"
	else if(splat_type)
		new splat_type(T)

	if(trash)
		generate_trash(T)

	visible_message("<span class='warning'>[src] is squashed.</span>","<span class='hear'>You hear a smack.</span>")
	if(seed)
		for(var/datum/plant_gene/trait/trait in seed.genes)
			trait.on_squash(src, target)

	reagents.expose(T)
	for(var/A in T)
		reagents.expose(A)

	qdel(src)

/obj/item/reagent_containers/food/snacks/grown/On_Consume()
	if(iscarbon(usr))
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_consume(src, usr)
	..()

/obj/item/reagent_containers/food/snacks/grown/generate_trash(atom/location)
	if(trash && (ispath(trash, /obj/item/grown) || ispath(trash, /obj/item/reagent_containers/food/snacks/grown)))
		. = new trash(location, seed)
		trash = null
		return
	return ..()

/obj/item/reagent_containers/food/snacks/grown/grind_requirements()
	if(dry_grind && !dry)
		to_chat(usr, "<span class='warning'>[src] needs to be dry before it can be ground up!</span>")
		return
	return TRUE

/obj/item/reagent_containers/food/snacks/grown/on_grind()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(grind_results&&grind_results.len)
		for(var/i in 1 to grind_results.len)
			grind_results[grind_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

/obj/item/reagent_containers/food/snacks/grown/on_juice()
	var/nutriment = reagents.get_reagent_amount(/datum/reagent/consumable/nutriment)
	if(juice_results&&juice_results.len)
		for(var/i in 1 to juice_results.len)
			juice_results[juice_results[i]] = nutriment
		reagents.del_reagent(/datum/reagent/consumable/nutriment)
		reagents.del_reagent(/datum/reagent/consumable/nutriment/vitamin)

/*
 * Attack self for growns
 *
 * Spawns the trash item at the growns drop_location()
 *
 * Then deletes the grown object
 *
 * Then puts trash item into the hand of user attack selfing, or drops it back on the ground
 */
/obj/item/reagent_containers/food/snacks/grown/shell/attack_self(mob/user)
	var/obj/item/T
	if(trash)
		T = generate_trash(drop_location())
		//Delete grown so our hand is free
		qdel(src)
		//put trash obj in hands or drop to ground
		user.put_in_hands(T, user.active_hand_index, TRUE)
		to_chat(user, "<span class='notice'>You open [src]\'s shell, revealing \a [T].</span>")
