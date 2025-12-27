/datum/mission/acquire/industrial_drill
	name = "Class 4 Vein Survey"
	desc = ""
	value = 18000
	weight = 2
	num_wanted = 10
	container_type = /obj/item/drill_core_container
	var/obj/machinery/drill/sampler_mission/mission_drill

/datum/mission/acquire/industrial_drill/New(...)
	if(!desc)
		desc = "[SSmissions.get_researcher_name()] has requested that we locate mineral resources for development in the near future. \
		The only suitable mineral deposits for heavy industry are typically far underground. Locate a vein of sufficent depth, place the provided drill, and let it dig until it's produced a mineral sample. Place the sample in the box and return it to us. \
		A bonus will be provided for return of the drill."
	..()

/datum/mission/acquire/industrial_drill/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc, obj/hangar_crate_spawner/cargo_belt)
	. = ..()
	mission_drill = spawn_bound(/obj/machinery/drill/sampler_mission, cargo_belt, VARSET_CALLBACK(src, mission_drill, null))

/datum/mission/acquire/industrial_drill/turn_in()
	//You guys gotta bring the expensive drill back.

	var/obj/docking_port/mobile/scanner_port = SSshuttle.get_containing_shuttle(mission_drill)
	if(mission_drill && (scanner_port?.current_ship == servant))
		value += 2000
		recall_bound(mission_drill)

	return ..()

/datum/mission/acquire/industrial_drill/Destroy()
	. = ..()
	recall_bound(mission_drill, FALSE)

//unfortunately: the behavior for normal mission drills is different than what I want.
/obj/machinery/drill/sampler_mission
	name = "deep-drust sampling drill"
	desc = "A micro-scale laser-assisted deep survey drill. Well-built, given the conditions that they regularly endure. As long as the laser is intact, it'll be an easy fix."
	var/num_current = 0
	var/samples_required = 10

/obj/machinery/drill/sampler_mission/examine(mob/user)
	. = ..()
	if(samples_required == num_current)
		. += span_notice("[src] has finished operation! Bring it back for a bonus!")
	else
		. += span_notice("[src] has drilled [(samples_required/num_current)*100]% of the way to its desired depth!")

/obj/machinery/drill/sampler_mission/start_mining()
	if(our_vein.vein_class < 4)
		say("Error: Insufficient vein depth for operation. Locate a class 4 vein.")
		return
	return ..()

/obj/machinery/drill/sampler_mission/mission/mine_success()
	//add thumping noise? Dune thumper...
	num_current++

	if(num_current == samples_required)
		say("Sample retrieved.")
		new /obj/item/drill_sample(get_step(src, 2))
		if(active)
			stop_mining()

/obj/item/drill_sample
	name = "geological sample"
	desc = "A mineral sample from several kilometers below where you currently are. Ideal for further geological study back at the outpost."
	base_icon_state = "geode"
	//placeholder
	icon = 'icons/obj/nuke_tools.dmi'
	icon_state = "plutonium_core"
	item_state = "plutoniumcore"
	w_class = WEIGHT_CLASS_HUGE //we're rich

/obj/item/drill_sample/Initialize()
	. = ..()
	icon_state = "geode-[pick(rand(1,8))]"

//nuke core box, for carrying the core
/obj/item/drill_core_container
	name = "mineral sample container"
	desc = "A solid container for the secure transportation of a mineral sample from the initial deep-drill of an area."
	icon = 'icons/obj/nuke_tools.dmi'
	icon_state = "core_container_empty"
	item_state = "tile"
	lefthand_file = 'icons/mob/inhands/misc/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/tiles_righthand.dmi'
	var/obj/item/drill_sample/core

/obj/item/drill_core_container/Destroy()
	QDEL_NULL(core)
	return ..()

/obj/item/drill_core_container/proc/load(obj/item/nuke_core/ncore, mob/user)
	if(core || !istype(ncore))
		return FALSE
	ncore.forceMove(src)
	core = ncore
	icon_state = "core_container_loaded"
	to_chat(user, span_warning("Container is sealing..."))
	addtimer(CALLBACK(src, PROC_REF(seal)), 50)
	return TRUE

/obj/item/drill_core_container/proc/seal()
	if(istype(core))
		STOP_PROCESSING(SSobj, core)
		icon_state = "core_container_sealed"
		playsound(src, 'sound/items/deconstruct.ogg', 60, TRUE)
		if(ismob(loc))
			to_chat(loc, span_warning("[src] is permanently sealed, [core]'s has been contained."))

/obj/item/drill_core_container/attackby(obj/item/nuke_core/core, mob/user)
	if(istype(core))
		if(!user.temporarilyRemoveItemFromInventory(core))
			to_chat(user, span_warning("The [core] is stuck to your hand!"))
			return
		else
			load(core, user)
	else
		return ..()
