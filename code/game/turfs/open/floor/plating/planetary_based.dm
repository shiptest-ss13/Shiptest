//This file holds all of our basic planetary turf stuff

/turf/open/floor/plating/planetary //I hate Object Oriented Programming
	gender = PLURAL
	name = "bedrock"
	desc = "A thick layer of rock seperating you from the rest of the planet"
	baseturfs = /turf/open/floor/plating/planetary
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	icon_plating = "asteroid"
	postdig_icon_change = TRUE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	attachment_holes = FALSE

	initial_gas_mix = DEFAULT_ATMOS_DETECTOR //this is pure plasma so it's easy to tell if this is being used where it shouldn't be. Think of it like a really shitty canary.
	//what color we are (for the lit var)
	light_color = LIGHT_COLOR_TUNGSTEN
	//how powerful our light is
	var/light_pwr = 0.8
	//they *are* planetary tiles
	planetary_atmos = TRUE
	/// the icon name to be used: for example, asteroid1 - asteroid12 in the icon file
	base_icon_state  = "asteroid"

	//can a floor have a different icon?
	var/floor_variants = TRUE
	/// Probability floor has a different icon state
	var/floor_variance = 20
	/// The max amount of unique icons, plus one
	var/max_icon_states = 12


	/// Itemstack to drop when dug by a shovel
	var/obj/item/stack/digResult = /obj/item/stack/ore/glass
	//we don't want some things to be dug (Yet at least)
	var/can_dig = TRUE
	/// Whether the turf has been dug or not
	var/dug

	//if a tile can be broken, or burnt (they all should be able to eventually, but that's a Lot Of Sprites and a fair bit of logic. Maybe in shiptest 2)
	var/can_burn = FALSE
	var/can_break = FALSE


/turf/open/floor/plating/planetary/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You might be able to build ontop of it with some <i>tiles</i>...</span>"

/turf/open/floor/plating/planetary/Initialize(mapload, inherited_virtual_z)
	var/proper_name = name
	. = ..()
	name = proper_name
	if(floor_variants)
		if(prob(floor_variance))
			icon_state = "[base_icon_state][rand(0,max_icon_states)]"
	if(!lit)
		return
	light_color = light_color
	light_range = 2
	light_power = light_pwr


/// Drops itemstack when dug and changes icon
/turf/open/floor/plating/planetary/proc/getDug()
	new digResult(src, 5)
	if(postdig_icon_change)
		if(!postdig_icon)
			icon_plating = "[base_icon_state]_dug"
			icon_state = "[base_icon_state]_dug"
	dug = TRUE

/// If the user can dig the turf
/turf/open/floor/plating/planetary/proc/can_dig(mob/user)
	if(!can_dig)
		return FALSE
	if(!dug)
		return TRUE
	if(user)
		to_chat(user, "<span class='warning'>You can't dig here!</span>")

/turf/open/floor/plating/planetary/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/planetary/burn_tile()
	if(can_burn)
		. = ..()
	return

/turf/open/floor/plating/planetary/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/planetary/MakeDry()
	return

/turf/open/floor/plating/planetary/crush()
	if(can_crush)
		. = ..()
	return

/turf/open/floor/plating/planetary/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(!.)
		if(W.tool_behaviour == TOOL_SHOVEL || W.tool_behaviour == TOOL_MINING)
			if(!can_dig(user))
				return TRUE

			if(!isturf(user.loc))
				return

			balloon_alert(user, "you start digging...")

			if(W.use_tool(src, user, 40, volume=50))
				if(!can_dig(user))
					return TRUE
				getDug()
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
				return TRUE
		else if(istype(W, /obj/item/storage/bag/ore))
			for(var/obj/item/stack/ore/O in src)
				SEND_SIGNAL(W, COMSIG_PARENT_ATTACKBY, O)

/turf/open/floor/plating/planetary/ex_act(severity, target)
	. = SEND_SIGNAL(src, COMSIG_ATOM_EX_ACT, severity, target)
	contents_explosion(severity, target)


/*
grass
*/


/turf/open/floor/plating/planetary/grass
	name = "grass"
	desc = "A patch of grass."
	icon_state = "grass0"
	base_icon_state = "grass"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	layer = HIGH_TURF_LAYER
	can_dig = FALSE
	floor_variants = FALSE
	var/smooth_icon = 'icons/turf/floors/grass.dmi'

/turf/open/floor/plating/planetary/grass/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-9, -9)
		transform = translation
		icon = smooth_icon

/*
dirt
*/

/turf/open/floor/plating/planetary/dirt
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon = 'icons/turf/floors.dmi'
	icon_state = "dirt"
	tiled_dirt = FALSE
	floor_variants = FALSE

/turf/open/floor/plating/planetary/dirt/dark
	icon_state = "greenerdirt"

/*
sands
*/

/turf/open/floor/plating/planetary/sand
	name = "sand"
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	floor_variants = FALSE

/*
Ice Ice Baby
*/

/turf/open/floor/plating/planetary/ice
	name = "ice sheet"
	desc = "A sheet of solid ice. Looks slippery."
	icon = 'icons/turf/snow.dmi'
	icon_state = "ice"
	slowdown = 1
	bullet_sizzle = TRUE
	footstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	clawfootstep = FOOTSTEP_ICE
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	floor_variants = FALSE

/turf/open/floor/plating/planetary/ice/Initialize(mapload, inherited_virtual_z)
	. = ..()
	MakeSlippery(TURF_WET_PERMAFROST, INFINITY, 0, INFINITY, TRUE)

/turf/open/floor/plating/planetary/ice/smooth
	icon_state = "ice_turf-255"
	icon = 'icons/turf/floors/ice_turf.dmi'
	base_icon_state = "ice_turf"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ICE)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_ICE)

/*
Snow
*/

/turf/open/floor/plating/planetary/snow
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	icon_state = "snow"
	icon_plating = "snow"
	slowdown = 1.5
	base_icon_state = "snow"
	footstep = FOOTSTEP_SNOW
	barefootstep = FOOTSTEP_SNOW
	clawfootstep = FOOTSTEP_SNOW
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow

	floor_variants = TRUE

	// footprint vars
	var/entered_dirs
	var/exited_dirs

/turf/open/floor/plating/planetary/snow/Entered(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(entered_dirs & AM.dir))
		entered_dirs |= AM.dir
		update_icon()

/turf/open/floor/plating/planetary/snow/Exited(atom/movable/AM)
	. = ..()
	if(!iscarbon(AM) || (AM.movement_type & (FLYING|VENTCRAWLING|FLOATING|PHASING)))
		return
	if(!(exited_dirs & AM.dir))
		exited_dirs |= AM.dir
		update_icon()

// adapted version of footprints' update_icon code
/turf/open/floor/plating/planetary/snow/update_overlays()
	. = ..()
	for(var/Ddir in GLOB.cardinals)
		if(entered_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["entered-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "ice1", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["entered-conc-[Ddir]"] = print
			. += print
		if(exited_dirs & Ddir)
			var/image/print = GLOB.bloody_footprints_cache["exited-conc-[Ddir]"]
			if(!print)
				print = image('icons/effects/footprints.dmi', "ice2", layer = TURF_DECAL_LAYER, dir = Ddir)
				GLOB.bloody_footprints_cache["exited-conc-[Ddir]"] = print
			. += print

// pretty much ripped wholesale from footprints' version of this proc
/turf/open/floor/plating/planetary/snow/setDir(newdir)
	if(dir == newdir)
		return ..()

	var/ang_change = dir2angle(newdir) - dir2angle(dir)
	var/old_entered_dirs = entered_dirs
	var/old_exited_dirs = exited_dirs
	entered_dirs = 0
	exited_dirs = 0

	for(var/Ddir in GLOB.cardinals)
		var/NDir = angle2dir_cardinal(dir2angle(Ddir) + ang_change)
		if(old_entered_dirs & Ddir)
			entered_dirs |= NDir
		if(old_exited_dirs & Ddir)
			exited_dirs |= NDir

	update_icon()
	return ..()

/turf/open/floor/plating/planetary/snow/getDug()
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/planetary/snow/burn_tile()
	ScrapeAway()
	return TRUE

/turf/open/floor/plating/planetary/snow/ex_act(severity, target)
	. = ..()
	ScrapeAway()

/*
Liquids
*/

/turf/open/floor/plating/planetary/water
	name = "water"
	desc = "Shallow water."
	icon = 'icons/turf/floors.dmi'
	icon_state = "riverwater_motion"
	baseturfs = /turf/open/water
	planetary_atmos = TRUE
	slowdown = 1
	bullet_sizzle = TRUE
	bullet_bounce_sound = null //needs a splashing sound one day.

	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

	floor_variants = FALSE

	var/datum/reagent/reagent_to_extract = /datum/reagent/water
	var/extracted_reagent_visible_name = "water"

/turf/open/floor/plating/planetary/water/attackby(obj/item/tool, mob/user, params)
	if(istype(tool, /obj/item/reagent_containers))
		if(!reagent_to_extract)
			return ..()
		var/obj/item/reagent_containers/glass/container = tool
		if(container.reagents.total_volume >= container.volume)
			to_chat(user, "<span class='danger'>[container] is full.</span>")
			return
		container.reagents.add_reagent(reagent_to_extract, rand(5, 10))
		user.visible_message("<span class='notice'>[user] scoops [extracted_reagent_visible_name] from the [src] with \the [container].</span>", "<span class='notice'>You scoop out [extracted_reagent_visible_name] from the [src] using \the [container].</span>")

	if(istype(tool, /obj/item/fish))
		user.visible_message("<span class='notice'>[user] tosses [tool] into [src].</span>", "<span class='notice'>You release [tool] into [src].</span>")
		playsound(fish, "sound/effects/bigsplash.ogg", 90)
		qdel(fish)

/turf/open/floor/plating/planetary/water/can_have_cabling()
	return FALSE

/turf/open/floor/plating/planetary/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/floor/plating/planetary/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, "<span class='notice'>You build a floor.</span>")
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE




/*
Liquid hot magma
*/

/turf/open/floor/plating/planetary/lava
	name = "lava"
	baseturfs = /turf/open/floor/plating/planetary/lava //lava all the way down
	slowdown = 2

	//gets to ignore out check for being lit because it's mofuckin lava
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_LAVA
	bullet_bounce_sound = 'sound/items/welder2.ogg'

	footstep = FOOTSTEP_LAVA
	barefootstep = FOOTSTEP_LAVA
	clawfootstep = FOOTSTEP_LAVA
	heavyfootstep = FOOTSTEP_LAVA

	floor_variants = FALSE

	var/particle_emitter = /obj/effect/particle_emitter/lava

	icon = 'icons/turf/floors/lava.dmi'
	icon_state = "lava-255"
	base_icon_state = "lava"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_LAVA)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_LAVA)

/turf/open/floor/plating/planetary/lava/Initialize(mapload)
	. = ..()
	particle_emitter = new /obj/effect/particle_emitter/lava(src)

/turf/open/floor/plating/planetary/lava/Destroy()
	. = ..()
	QDEL_NULL(particle_emitter)

/turf/open/floor/plating/planetary/lava/ex_act(severity, target)
	contents_explosion(severity, target)

/turf/open/floor/plating/planetary/lava/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/floor/plating/planetary/lava/acid_act(acidpwr, acid_volume)
	return

/turf/open/floor/plating/planetary/lava/Entered(atom/movable/AM)
	. = ..()
	if(burn_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/floor/plating/planetary/lava/Exited(atom/movable/Obj, atom/newloc)
	. = ..()
	if(isliving(Obj))
		var/mob/living/L = Obj
		if(!islava(newloc) && !L.on_fire)
			L.update_fire()

/turf/open/floor/plating/planetary/lava/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	if(burn_stuff(AM))
		START_PROCESSING(SSobj, src)

/turf/open/floor/plating/planetary/lava/process()
	if(!burn_stuff())
		STOP_PROCESSING(SSobj, src)

/turf/open/floor/plating/planetary/lava/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 0, "cost" = 3)
	return FALSE

/turf/open/floor/plating/planetary/lava/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, "<span class='notice'>You build a floor.</span>")
			PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
			return TRUE
	return FALSE

/turf/open/floor/plating/planetary/lava/singularity_act()
	return

/turf/open/floor/plating/planetary/lava/singularity_pull(S, current_size)
	return

/turf/open/floor/plating/planetary/lava/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'icons/turf/floors.dmi'
	underlay_appearance.icon_state = "basalt"
	return TRUE

/turf/open/floor/plating/planetary/lava/GetHeatCapacity()
	. = 700000

/turf/open/floor/plating/planetary/lava/GetTemperature()
	. = 5000

/turf/open/floor/plating/planetary/lava/attackby(obj/item/C, mob/user, params)
	..()
	if(istype(C, /obj/item/stack/rods/lava))
		var/obj/item/stack/rods/lava/R = C
		var/obj/structure/lattice/lava/H = locate(/obj/structure/lattice/lava, src)
		if(H)
			to_chat(user, "<span class='warning'>There is already a lattice here!</span>")
			return
		if(R.use(1))
			to_chat(user, "<span class='notice'>You construct a lattice.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /obj/structure/lattice/lava(locate(x, y, z))
		else
			to_chat(user, "<span class='warning'>You need one rod to build a heatproof lattice.</span>")
		return

/turf/open/floor/plating/planetary/lava/proc/is_safe()
	//if anything matching this typecache is found in the lava, we don't burn things
	var/static/list/lava_safeties_typecache = typecacheof(list(/obj/structure/catwalk, /obj/structure/stone_tile, /obj/structure/lattice/lava))
	var/list/found_safeties = typecache_filter_list(contents, lava_safeties_typecache)
	for(var/obj/structure/stone_tile/S in found_safeties)
		if(S.fallen)
			LAZYREMOVE(found_safeties, S)
	return LAZYLEN(found_safeties)


/turf/open/floor/plating/planetary/lava/proc/burn_stuff(AM)
	. = 0

	if(is_safe())
		return FALSE

	var/thing_to_check = src
	if (AM)
		thing_to_check = list(AM)
	for(var/thing in thing_to_check)
		if(isobj(thing))
			var/obj/O = thing
			if((O.resistance_flags & (LAVA_PROOF|INDESTRUCTIBLE)) || O.throwing)
				continue
			. = 1
			if((O.resistance_flags & (ON_FIRE)))
				continue
			if(!(O.resistance_flags & FLAMMABLE))
				O.resistance_flags |= FLAMMABLE //Even fireproof things burn up in lava
			if(O.resistance_flags & FIRE_PROOF)
				O.resistance_flags &= ~FIRE_PROOF
			if(O.armor.fire > 50) //obj with 100% fire armor still get slowly burned away.
				O.armor = O.armor.setRating(fire = 50)
			O.fire_act(10000, 1000)

		else if (isliving(thing))
			. = 1
			var/mob/living/L = thing
			if(L.movement_type & FLYING)
				continue	//YOU'RE FLYING OVER IT
			var/buckle_check = L.buckling
			if(!buckle_check)
				buckle_check = L.buckled
			if(isobj(buckle_check))
				var/obj/O = buckle_check
				if(O.resistance_flags & LAVA_PROOF)
					continue
			else if(isliving(buckle_check))
				var/mob/living/live = buckle_check
				if("lava" in live.weather_immunities)
					continue

			if(!L.on_fire)
				L.update_fire()

			if(iscarbon(L))
				var/mob/living/carbon/C = L
				var/obj/item/clothing/S = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
				var/obj/item/clothing/H = C.get_item_by_slot(ITEM_SLOT_HEAD)

				if(S && H && S.clothing_flags & LAVAPROTECT && H.clothing_flags & LAVAPROTECT)
					return

			if("lava" in L.weather_immunities)
				continue

			L.adjustFireLoss(20)
			if(L) //mobs turning into object corpses could get deleted here.
				L.adjust_fire_stacks(20)
				L.IgniteMob()

/turf/open/floor/plating/planetary/lava/plasma
	name = "liquid plasma"
	desc = "A flowing stream of chilled liquid plasma. You probably shouldn't get in."
	icon_state = "liquidplasma"
	baseturfs = /turf/open/floor/plating/planetary/lava/plasma
	light_range = 3
	light_power = 0.75
	light_color = LIGHT_COLOR_PURPLE
	particle_emitter = null
	floor_variants = FALSE

/turf/open/floor/plating/planetary/lava/plasma/attackby(obj/item/I, mob/user, params)
	. = ..()
	var/obj/item/reagent_containers/glass/C = I
	if(C.reagents.total_volume >= C.volume)
		to_chat(user, "<span class='danger'>[C] is full.</span>")
		return
	C.reagents.add_reagent(/datum/reagent/toxin/plasma, rand(5, 10))
	user.visible_message("<span class='notice'>[user] scoops some plasma from the [src] with \the [C].</span>", "<span class='notice'>You scoop out some plasma from the [src] using \the [C].</span>")
	return TRUE

/turf/open/floor/plating/planetary/lava/plasma/burn_stuff(AM)
	. = 0

	if(is_safe())
		return FALSE

	var/thing_to_check = src
	if (AM)
		thing_to_check = list(AM)
	for(var/thing in thing_to_check)
		if(isobj(thing))
			var/obj/O = thing
			if((O.resistance_flags & (FREEZE_PROOF)) || O.throwing)
				continue

		else if (isliving(thing))
			. = 1
			var/mob/living/L = thing
			if(L.movement_type & FLYING)
				continue	//YOU'RE FLYING OVER IT
			if("snow" in L.weather_immunities)
				continue

			var/buckle_check = L.buckling
			if(!buckle_check)
				buckle_check = L.buckled
			if(isobj(buckle_check))
				var/obj/O = buckle_check
				if(O.resistance_flags & FREEZE_PROOF)
					continue

			else if(isliving(buckle_check))
				var/mob/living/live = buckle_check
				if("snow" in live.weather_immunities)
					continue

			L.adjustFireLoss(2)
			if(L)
				L.adjust_fire_stacks(20) //dipping into a stream of plasma would probably make you more flammable than usual
				L.adjust_bodytemperature(-rand(50,65)) //its cold, man
				if(ishuman(L))//are they a carbon?
					var/list/plasma_parts = list()//a list of the organic parts to be turned into plasma limbs
					var/list/robo_parts = list()//keep a reference of robotic parts so we know if we can turn them into a plasmaman
					var/mob/living/carbon/human/PP = L
					var/S = PP.dna.species
					if(istype(S, /datum/species/plasmaman) || istype(S, /datum/species/android)) //ignore plasmamen/robotic species
						continue

					for(var/BP in PP.bodyparts)
						var/obj/item/bodypart/NN = BP
						if(IS_ORGANIC_LIMB(NN) && NN.limb_id != "plasmaman") //getting every organic, non-plasmaman limb (augments/androids are immune to this)
							plasma_parts += NN
						if(!IS_ORGANIC_LIMB(NN))
							robo_parts += NN

					if(prob(35)) //checking if the delay is over & if the victim actually has any parts to nom
						PP.adjustToxLoss(15)
						PP.adjustFireLoss(25)
						if(plasma_parts.len)
							var/obj/item/bodypart/NB = pick(plasma_parts) //using the above-mentioned list to get a choice of limbs for dismember() to use
							PP.emote("scream")
							NB.limb_id = "plasmaman"//change the species_id of the limb to that of a plasmaman
							NB.no_update = TRUE
							NB.change_bodypart_status()
							PP.visible_message(
								"<span class='warning'>[L] screams in pain as [L.p_their()] [NB] melts down to the bone!</span>",
								"<span class='userdanger'>You scream out in pain as your [NB] melts down to the bone, leaving an eerie plasma-like glow where flesh used to be!</span>")
						if(!plasma_parts.len && !robo_parts.len) //a person with no potential organic limbs left AND no robotic limbs, time to turn them into a plasmaman
							PP.IgniteMob()
							PP.set_species(/datum/species/plasmaman)
							PP.visible_message(
								"<span class='warning'>[L] bursts into a brilliant purple flame as [L.p_their()] entire body is that of a skeleton!</span>",
								"<span class='userdanger'>Your senses numb as all of your remaining flesh is turned into a purple slurry, sloshing off your body and leaving only your bones to show in a vibrant purple!</span>")

/turf/open/floor/plating/planetary/lava/acid
	name = "acid lake"
	icon_state = "acid"
	baseturfs = /turf/open/floor/plating/planetary/lava/acid

	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_SLIME_LAMP

/turf/open/acid/attackby(obj/item/C, mob/user, params)
	..()
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/H = locate(/obj/structure/lattice, src)
		if(H)
			to_chat(user, "<span class='warning'>There is already a lattice here!</span>")
			return
		if(R.use(2))
			to_chat(user, "<span class='notice'>You construct a catwalk.</span>")
			playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
			new /obj/structure/lattice/catwalk(locate(x, y, z))
		else
			to_chat(user, "<span class='warning'>You need one rod to build a lattice.</span>")
		return
		//to-do, acidproof containers can scoop up acid.

/turf/open/acid/proc/melt_stuff(thing_to_melt)
	if(is_safe_to_cross())
		return FALSE
	. = FALSE
	var/thing_to_check = src
	if (thing_to_melt)
		thing_to_check = list(thing_to_melt)
	for(var/thing in thing_to_check)
		if(isobj(thing))
			var/obj/object_to_melt = thing
			if((object_to_melt.resistance_flags & (ACID_PROOF|INDESTRUCTIBLE)) || object_to_melt.throwing)
				continue
			. = TRUE
			if((object_to_melt.acid_level))
				continue
			if(object_to_melt.resistance_flags & UNACIDABLE)
				object_to_melt.resistance_flags &= ~UNACIDABLE
			if(object_to_melt.armor.acid == 100) //acid proof armor will probably be acid proof
				continue
			object_to_melt.acid_act(10, 20)

		else if (isliving(thing))
			. = TRUE
			var/mob/living/L = thing
			if(L.movement_type & FLYING)
				continue	//YOU'RE FLYING OVER IT
			var/buckle_check = L.buckling
			if(!buckle_check)
				buckle_check = L.buckled
			if(isobj(buckle_check))
				var/obj/O = buckle_check
				if(O.resistance_flags & LAVA_PROOF)
					continue
			else if(isliving(buckle_check))
				var/mob/living/live = buckle_check
				if("acid" in live.weather_immunities)
					continue

			if(iscarbon(L))
				var/mob/living/carbon/C = L
				var/obj/item/clothing/S = C.get_item_by_slot(ITEM_SLOT_OCLOTHING)
				var/obj/item/clothing/H = C.get_item_by_slot(ITEM_SLOT_HEAD)

				if(S && H && S.armor.acid == 100 && H.armor.acid == 100)
					return

			if("acid" in L.weather_immunities)
				continue

			L.adjustFireLoss(20)
			if(L) //mobs turning into object corpses could get deleted here.
				L.acid_act(50, 100)
