/obj/effect/decal/cleanable/blood
	name = "blood"
	desc = "It's weird and gooey. Perhaps it's the chef's cooking?"
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	color = COLOR_BLOOD
	random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	blood_state = BLOOD_STATE_HUMAN
	bloodiness = BLOOD_AMOUNT_PER_DECAL
	beauty = -100
	var/dryname = "dried blood" //when the blood lasts long enough, it becomes dry and gets a new name
	var/drydesc = "Looks like it's been here a while. Eew." //as above
	var/drytime = 0

/obj/effect/decal/cleanable/blood/Initialize()
	. = ..()
	if(bloodiness)
		start_drying()
	else
		dry()

/obj/effect/decal/cleanable/blood/process(seconds_per_tick)
	if(world.time > drytime)
		dry()

/obj/effect/decal/cleanable/blood/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/decal/cleanable/blood/proc/get_timer()
	drytime = world.time + 3 MINUTES

/obj/effect/decal/cleanable/blood/proc/start_drying()
	get_timer()
	START_PROCESSING(SSobj, src)

/obj/effect/decal/cleanable/blood/proc/dry()
	if(bloodiness > 20)
		bloodiness -= BLOOD_AMOUNT_PER_DECAL
		get_timer()
	else
		name = dryname
		desc = drydesc
		bloodiness = 0
		var/temp_color = ReadHSV(RGBtoHSV(color || COLOR_WHITE))
		color = HSVtoRGB(hsv(temp_color[1], temp_color[2], max(temp_color[3] - 100,min(temp_color[3],10))))
		STOP_PROCESSING(SSobj, src)

/obj/effect/decal/cleanable/blood/replace_decal(obj/effect/decal/cleanable/blood/C)
	C.add_blood_DNA(return_blood_DNA())
	if (bloodiness)
		C.bloodiness = min((C.bloodiness + bloodiness), BLOOD_AMOUNT_PER_DECAL)
	return ..()

/obj/effect/decal/cleanable/blood/old
	name = "dried blood"
	desc = "Looks like it's been here a while.  Eew."
	bloodiness = 0
	icon_state = "floor1-old"

/obj/effect/decal/cleanable/blood/old/Initialize(mapload, list/datum/disease/diseases)
	add_blood_DNA(list("Non-human DNA" = random_blood_type())) // Needs to happen before ..()
	. = ..()
	icon_state = "[icon_state]-old" //change from the normal blood icon selected from random_icon_states in the parent's Initialize to the old dried up blood.

/obj/effect/decal/cleanable/blood/splatter
	icon_state = "gibbl1"
	random_icon_states = list("gibbl1", "gibbl2", "gibbl3", "gibbl4", "gibbl5")
	///Absorb the /squirt subtype when it exists on the turf
	var/absorb_squirts = TRUE

/obj/effect/decal/cleanable/blood/tracks
	icon_state = "tracks"
	desc = "They look like tracks left by wheels."
	random_icon_states = null
	beauty = -50

/obj/effect/decal/cleanable/blood/trail_holder //not a child of blood on purpose //nice fucking descriptive comment jackass, fuck you //hello fikou
	name = "blood"
	icon = 'icons/effects/blood.dmi'
	desc = "Your instincts say you shouldn't be following these."
	beauty = -50
	icon_state = null
	random_icon_states = null
	var/list/existing_dirs = list()

/obj/effect/decal/cleanable/blood/gibs
	name = "gibs"
	desc = "They look bloody and gruesome."
	icon = 'icons/effects/blood.dmi'
	icon_state = "gib1"
	layer = LOW_OBJ_LAYER
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6")
	mergeable_decal = FALSE
	turf_loc_check = FALSE
	dryname = "rotting gibs"
	drydesc = "They look bloody and gruesome while some terrible smell fills the air."

/obj/effect/decal/cleanable/blood/gibs/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	reagents.add_reagent(/datum/reagent/liquidgibs, 5)
	var/mutable_appearance/gib_overlay = mutable_appearance(icon, "[icon_state]-overlay", appearance_flags = RESET_COLOR)
	add_overlay(gib_overlay)

/obj/effect/decal/cleanable/blood/gibs/dry()
	. = ..()

/obj/effect/decal/cleanable/blood/gibs/replace_decal(obj/effect/decal/cleanable/C)
	return FALSE //Never fail to place us

/obj/effect/decal/cleanable/blood/gibs/ex_act(severity, target)
	return

/obj/effect/decal/cleanable/blood/gibs/on_entered(datum/source, atom/movable/L)
	if(isliving(L) && has_gravity(loc))
		playsound(loc, 'sound/effects/gib_step.ogg', HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 20 : 50, TRUE)
	. = ..()

/obj/effect/decal/cleanable/blood/gibs/proc/streak(list/directions)
	set waitfor = FALSE
	var/list/diseases = list()
	SEND_SIGNAL(src, COMSIG_GIBS_STREAK, directions, diseases)
	var/direction = pick(directions)
	for(var/i in 0 to pick(0, 1, 2))
		sleep(2)
		if(i > 0)
			var/obj/effect/decal/cleanable/blood/splatter/splat = new /obj/effect/decal/cleanable/blood/splatter(loc, diseases)
			if(!QDELETED(splat) && HAS_BLOOD_DNA(src))
				splat.add_blood_DNA(src.return_blood_DNA())
		if(!step_to(src, get_step(src, direction), 0))
			break

/obj/effect/decal/cleanable/blood/gibs/up
	icon_state = "gibup1"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6","gibup1","gibup1","gibup1")

/obj/effect/decal/cleanable/blood/gibs/down
	icon_state = "gibdown1"
	random_icon_states = list("gib1", "gib2", "gib3", "gib4", "gib5", "gib6","gibdown1","gibdown1","gibdown1")

/obj/effect/decal/cleanable/blood/gibs/body
	icon_state = "gibtorso"
	random_icon_states = list("gibhead", "gibtorso")

/obj/effect/decal/cleanable/blood/gibs/torso
	icon_state = "gibtorso"
	random_icon_states = null

/obj/effect/decal/cleanable/blood/gibs/limb
	icon_state = "gibleg"
	random_icon_states = list("gibleg", "gibarm")

/obj/effect/decal/cleanable/blood/gibs/core
	icon_state = "gibmid1"
	random_icon_states = list("gibmid1", "gibmid2", "gibmid3")

/obj/effect/decal/cleanable/blood/gibs/old
	name = "old rotting gibs"
	desc = "Space Jesus, why didn't anyone clean this up? They smell terrible."
	icon_state = "gib1-old"
	bloodiness = 0
	dryname = "old rotting gibs"
	drydesc = "Space Jesus, why didn't anyone clean this up? They smell terrible."

/obj/effect/decal/cleanable/blood/gibs/old/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	setDir(pick(1,2,4,8))
	add_blood_DNA(list("Non-human DNA" = random_blood_type()))

/obj/effect/decal/cleanable/blood/drip
	name = "drips of blood"
	desc = "It's red."
	icon_state = "drip5" //using drip5 since the others tend to blend in with pipes & wires.
	random_icon_states = list("drip1","drip2","drip3","drip4","drip5")
	bloodiness = 0
	var/drips = 1
	dryname = "drips of blood"
	drydesc = "It's red."
	var/move_on_init = TRUE

/obj/effect/decal/cleanable/blood/drip/Initialize(mapload, list/datum/disease/diseases)
	. = ..()
	dry()
	add_blood_DNA(list("Non-human DNA" = random_blood_type()))
	if(move_on_init)
		pixel_x = rand(-16,16)
		pixel_y = rand(-16, 16)


/obj/effect/decal/cleanable/blood/drip/can_bloodcrawl_in()
	return TRUE


//BLOODY FOOTPRINTS
/obj/effect/decal/cleanable/blood/footprints
	name = "footprints"
	desc = "WHOSE FOOTPRINTS ARE THESE?"
	icon = 'icons/effects/footprints.dmi'
	icon_state = "blood1"
	random_icon_states = null
	blood_state = BLOOD_STATE_HUMAN //the icon state to load images from
	var/entered_dirs = 0
	var/exited_dirs = 0

	/// List of shoe or other clothing that covers feet types that have made footprints here.
	var/list/shoe_types = list()

	/// List of species that have made footprints here.
	var/list/species_types = list()

	dryname = "dried footprints"
	drydesc = "HMM... SOMEONE WAS HERE!"

/obj/effect/decal/cleanable/blood/footprints/Initialize(mapload)
	. = ..()
	icon_state = "" //All of the footprint visuals come from overlays
	if(mapload)
		entered_dirs |= dir //Keep the same appearance as in the map editor
		update_appearance()

//Rotate all of the footprint directions too
/obj/effect/decal/cleanable/blood/footprints/setDir(newdir)
	if(dir == newdir)
		return ..()

	var/ang_change = dir2angle(newdir) - dir2angle(dir)
	var/old_entered_dirs = entered_dirs
	var/old_exited_dirs = exited_dirs
	entered_dirs = 0
	exited_dirs = 0

	for(var/Ddir in GLOB.cardinals)
		if(old_entered_dirs & Ddir)
			entered_dirs |= angle2dir_cardinal(dir2angle(Ddir) + ang_change)
		if(old_exited_dirs & Ddir)
			exited_dirs |= angle2dir_cardinal(dir2angle(Ddir) + ang_change)

	update_appearance()
	return ..()

/obj/effect/decal/cleanable/blood/footprints/update_icon()
	. = ..()
	alpha = min(BLOODY_FOOTPRINT_BASE_ALPHA + (255 - BLOODY_FOOTPRINT_BASE_ALPHA) * bloodiness / (BLOOD_ITEM_MAX / 2), 255)

/obj/effect/decal/cleanable/blood/footprints/update_overlays()
	. = ..()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["entered-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]1", dir = Ddir)
			. += bloodstep_overlay

		if(exited_dirs & Ddir)
			var/image/bloodstep_overlay = GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"]
			if(!bloodstep_overlay)
				GLOB.bloody_footprints_cache["exited-[blood_state]-[Ddir]"] = bloodstep_overlay = image(icon, "[blood_state]2", dir = Ddir)
			. += bloodstep_overlay

	alpha = min(BLOODY_FOOTPRINT_BASE_ALPHA + (255 - BLOODY_FOOTPRINT_BASE_ALPHA) * bloodiness / (BLOOD_ITEM_MAX / 2), 255)


/obj/effect/decal/cleanable/blood/footprints/examine(mob/user)
	. = ..()
	if((shoe_types.len + species_types.len) > 0)
		. += "You recognise the footprints as belonging to:"
		for(var/sole in shoe_types)
			var/obj/item/clothing/item = sole
			var/article = initial(item.gender) == PLURAL ? "Some" : "A"
			. += "[icon2html(initial(item.icon), user, initial(item.icon_state))] [article] <B>[initial(item.name)]</B>."
		for(var/species in species_types)
			// god help me
			if(species == "unknown")
				. += "Some <B>feet</B>."
			else if(species == "monkey")
				. += "[icon2html('icons/mob/monkey.dmi', user, "monkey1")] Some <B>monkey feet</B>."
			else if(species == "human")
				. += "[icon2html('icons/mob/human_parts.dmi', user, "default_human_l_leg")] Some <B>human feet</B>."
			else
				. += "[icon2html('icons/mob/human_parts.dmi', user, "[species]_l_leg")] Some <B>[species] feet</B>."

/obj/effect/decal/cleanable/blood/footprints/replace_decal(obj/effect/decal/cleanable/C)
	if(blood_state != C.blood_state) //We only replace footprints of the same type as us
		return FALSE
	return ..()

/obj/effect/decal/cleanable/blood/footprints/can_bloodcrawl_in()
	if((blood_state != BLOOD_STATE_OIL) && (blood_state != BLOOD_STATE_NOT_BLOODY))
		return 1
	return 0

/obj/effect/decal/cleanable/blood/hitsplatter
	name = "blood splatter"
	pass_flags = PASSTABLE | PASSGRILLE
	icon_state = "hitsplatter1"
	random_icon_states = list("hitsplatter1", "hitsplatter2", "hitsplatter3")
	/// The turf we just came from, so we can back up when we hit a wall
	var/turf/prev_loc
	/// The cached info about the blood
	var/list/blood_dna_info
	/// Skip making the final blood splatter when we're done, like if we're not in a turf
	var/skip = FALSE
	/// How many tiles/items/people we can paint red
	var/splatter_strength = 3
	/// Insurance so that we don't keep moving once we hit a stoppoint
	var/hit_endpoint = FALSE

/obj/effect/decal/cleanable/blood/hitsplatter/Initialize(mapload, splatter_strength)
	. = ..()
	prev_loc = loc //Just so we are sure prev_loc exists
	if(splatter_strength)
		src.splatter_strength = splatter_strength

/obj/effect/decal/cleanable/blood/hitsplatter/Destroy()
	if(isturf(loc) && !skip)
		playsound(src, 'sound/effects/splatter.ogg', 60, TRUE, -1)
		if(blood_dna_info)
			loc.add_blood_DNA(blood_dna_info)
	return ..()

/// Set the splatter up to fly through the air until it rounds out of steam or hits something. Contains sleep() pending imminent moveloop rework, don't call without async'ing it
/obj/effect/decal/cleanable/blood/hitsplatter/proc/fly_towards(turf/target_turf, range)
	splatter_strength = range
	for(var/i in 1 to range)
		step_towards(src,target_turf)
		sleep(2) // Will be resolved pending Potato's moveloop rework
		for(var/atom/iter_atom in get_turf(src))
			if(hit_endpoint)
				return
			if(splatter_strength <= 0)
				break

			if(isitem(iter_atom))
				iter_atom.add_blood_DNA(blood_dna_info)
				splatter_strength--
			else if(ishuman(iter_atom))
				var/mob/living/carbon/human/splashed_human = iter_atom
				if(splashed_human.wear_suit)
					splashed_human.wear_suit.add_blood_DNA(blood_dna_info)
					splashed_human.update_inv_wear_suit()    //updates mob overlays to show the new blood (no refresh)
				if(splashed_human.w_uniform)
					splashed_human.w_uniform.add_blood_DNA(blood_dna_info)
					splashed_human.update_inv_w_uniform()    //updates mob overlays to show the new blood (no refresh)
				splatter_strength--

		if(splatter_strength <= 0) // we used all the puff so we delete it.
			qdel(src)
			return

		var/obj/effect/decal/cleanable/blood/newsplatter
		if(splatter_strength <= 3.5)
			newsplatter = new /obj/effect/decal/cleanable/blood/squirt(get_turf(src), get_dir(prev_loc, loc), blood_dna_info)
		else
			newsplatter = new /obj/effect/decal/cleanable/blood/splatter(get_turf(src))
		newsplatter.add_blood_DNA(blood_dna_info)
		prev_loc = loc

	qdel(src)
	return

/obj/effect/decal/cleanable/blood/hitsplatter/Bump(atom/bumped_atom)
	if(!iswallturf(bumped_atom) && !istype(bumped_atom, /obj/structure/window))
		qdel(src)
		return

	if(istype(bumped_atom, /obj/structure/window))
		var/obj/structure/window/bumped_window = bumped_atom
		if(!bumped_window.fulltile)
			qdel(src)
			return

	hit_endpoint = TRUE
	if(isturf(prev_loc))
		abstract_move(bumped_atom)
		skip = TRUE
		//Adjust pixel offset to make splatters appear on the wall
		if(istype(bumped_atom, /obj/structure/window))
			land_on_window(bumped_atom)
		else
			var/obj/effect/decal/cleanable/blood/splatter/over_window/final_splatter = new(prev_loc)
			final_splatter.pixel_x = (dir == EAST ? 32 : (dir == WEST ? -32 : 0))
			final_splatter.pixel_y = (dir == NORTH ? 32 : (dir == SOUTH ? -32 : 0))
	else // This will only happen if prev_loc is not even a turf, which is highly unlikely.
		abstract_move(bumped_atom)
		qdel(src)

/// A special case for hitsplatters hitting windows, since those can actually be moved around, store it in the window and slap it in the vis_contents
/obj/effect/decal/cleanable/blood/hitsplatter/proc/land_on_window(obj/structure/window/the_window)
	if(!the_window.fulltile)
		return
	var/obj/effect/decal/cleanable/blood/splatter/over_window/final_splatter = new
	final_splatter.forceMove(the_window)
	the_window.vis_contents += final_splatter
	the_window.bloodied = TRUE
	qdel(src)

/obj/effect/decal/cleanable/blood/squirt
	name = "blood trail"
	icon_state = "squirt"
	random_icon_states = null

/obj/effect/decal/cleanable/blood/squirt/Initialize(mapload, direction, list/blood_dna)
	. = ..()
	dir = direction
	var/obj/effect/decal/cleanable/blood/splatter/existing_blood = locate() in get_turf(src)
	if(existing_blood?.absorb_squirts)
		if(blood_dna)
			existing_blood.add_blood_DNA(blood_dna)
			existing_blood.bloodiness = min((existing_blood.bloodiness + bloodiness), BLOOD_AMOUNT_PER_DECAL)
		return INITIALIZE_HINT_QDEL

/obj/effect/decal/cleanable/blood/splatter/over_window // special layer/plane set to appear on windows
	layer = ABOVE_WINDOW_LAYER
	plane = GAME_PLANE
	turf_loc_check = FALSE
	alpha = 180
	absorb_squirts = FALSE
