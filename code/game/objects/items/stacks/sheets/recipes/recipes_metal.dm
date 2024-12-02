GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("stool", /obj/structure/chair/stool, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("bar stool", /obj/structure/chair/stool/bar, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe_list("beds", list( \
		new/datum/stack_recipe("bed", /obj/structure/bed, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("double bed", /obj/structure/bed/double, 4, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("bottom bunk", /obj/structure/bed/bunk, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("top bunk", /obj/structure/bed/bunk/top, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("office chairs", list( \
		new/datum/stack_recipe("gray office chair", /obj/structure/chair/office, 5, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("light office chair", /obj/structure/chair/office/light, 5, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("dark office chair", /obj/structure/chair/office/dark, 5, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("purple office chair", /obj/structure/chair/office/purple, 5, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("bench chairs", list( \
		new/datum/stack_recipe("purple bench chair", /obj/structure/chair/bench/purple, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("beige bench chair", /obj/structure/chair/bench/beige, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey bench chair", /obj/structure/chair/bench/grey, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue bench chair", /obj/structure/chair/bench/blue, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red bench chair", /obj/structure/chair/bench/red, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive bench chair", /obj/structure/chair/bench/olive, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("comfy chairs", list( \
		new/datum/stack_recipe("purple comfy chair", /obj/structure/chair/comfy/purple, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("beige comfy chair", /obj/structure/chair/comfy/beige, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey comfy chair", /obj/structure/chair/comfy/grey, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("orange comfy chair", /obj/structure/chair/comfy/orange, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue comfy chair", /obj/structure/chair/comfy/blue, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red comfy chair", /obj/structure/chair/comfy/red, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive comfy chair", /obj/structure/chair/comfy/olive, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("comfy chairs (old)", list( \
		new/datum/stack_recipe("old purple comfy chair", /obj/structure/chair/comfy/purple/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old beige comfy chair", /obj/structure/chair/comfy/beige/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey comfy chair", /obj/structure/chair/comfy/grey/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old orange comfy chair", /obj/structure/chair/comfy/orange/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue comfy chair", /obj/structure/chair/comfy/blue/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red comfy chair", /obj/structure/chair/comfy/red/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive comfy chair", /obj/structure/chair/comfy/olive/old, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("comfy chairs (old - alt)", list( \
		new/datum/stack_recipe("old purple comfy chair (alt)", /obj/structure/chair/comfy/purple/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old beige comfy chair (alt)", /obj/structure/chair/comfy/beige/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey comfy chair (alt)", /obj/structure/chair/comfy/grey/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old orange comfy chair (alt)", /obj/structure/chair/comfy/orange/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue comfy chair (alt)", /obj/structure/chair/comfy/blue/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red comfy chair (alt)", /obj/structure/chair/comfy/red/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive comfy chair (alt)", /obj/structure/chair/comfy/olive/old/alt, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("comfy chairs (corpo)", list( \
		new/datum/stack_recipe("purple corpo chair", /obj/structure/chair/comfy/purple/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("beige corpo chair", /obj/structure/chair/comfy/beige/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey corpo chair", /obj/structure/chair/comfy/grey/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("orange corpo chair", /obj/structure/chair/comfy/orange/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue corpo chair", /obj/structure/chair/comfy/blue/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red corpo chair", /obj/structure/chair/comfy/red/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive corpo chair", /obj/structure/chair/comfy/olive/corpo, 2, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("sofas", list( \
		// New brown Sofa
		new/datum/stack_recipe("brown sofa (middle)", /obj/structure/chair/sofa/brown, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("brown sofa (left)", /obj/structure/chair/sofa/brown/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("brown sofa (right)", /obj/structure/chair/sofa/brown/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("brown sofa (corner)", /obj/structure/chair/sofa/brown/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("brown sofa (internal corner)", /obj/structure/chair/sofa/brown/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// New purple sofa
		new/datum/stack_recipe("purple sofa (middle)", /obj/structure/chair/sofa/purple, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("purple sofa (left)", /obj/structure/chair/sofa/purple/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("purple sofa (right)", /obj/structure/chair/sofa/purple/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("purple sofa (corner)", /obj/structure/chair/sofa/purple/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("purple sofa (internal corner)", /obj/structure/chair/sofa/purple/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// New blue Sofa
		new/datum/stack_recipe("blue sofa (middle)", /obj/structure/chair/sofa/blue, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue sofa (left)", /obj/structure/chair/sofa/blue/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue sofa (right)", /obj/structure/chair/sofa/blue/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue sofa (corner)", /obj/structure/chair/sofa/blue/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("blue sofa (internal corner)", /obj/structure/chair/sofa/blue/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// New red Sofa
		new/datum/stack_recipe("red sofa (middle)", /obj/structure/chair/sofa/red, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red sofa (left)", /obj/structure/chair/sofa/red/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red sofa (right)", /obj/structure/chair/sofa/red/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red sofa (corner)", /obj/structure/chair/sofa/red/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("red sofa (internal corner)", /obj/structure/chair/sofa/red/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// New grey Sofa
		new/datum/stack_recipe("grey sofa (middle)", /obj/structure/chair/sofa/grey, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey sofa (left)", /obj/structure/chair/sofa/grey/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey sofa (right)", /obj/structure/chair/sofa/grey/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey sofa (corner)", /obj/structure/chair/sofa/grey/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("grey sofa (internal corner)", /obj/structure/chair/sofa/grey/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// New olive Sofa
		new/datum/stack_recipe("olive sofa (middle)", /obj/structure/chair/sofa/olive, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive sofa (left)", /obj/structure/chair/sofa/olive/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive sofa (right)", /obj/structure/chair/sofa/olive/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive sofa (corner)", /obj/structure/chair/sofa/olive/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("olive sofa (internal corner)", /obj/structure/chair/sofa/olive/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("sofas (old)", list(
		// Old brown Sofa
		new/datum/stack_recipe("old brown sofa (middle)", /obj/structure/chair/sofa/brown/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old brown sofa (left)", /obj/structure/chair/sofa/brown/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old brown sofa (right)", /obj/structure/chair/sofa/brown/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old brown sofa (corner)", /obj/structure/chair/sofa/brown/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old brown sofa (internal corner)", /obj/structure/chair/sofa/brown/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Old purple Sofa
		new/datum/stack_recipe("old purple sofa (middle)", /obj/structure/chair/sofa/purple/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old purple sofa (left)", /obj/structure/chair/sofa/purple/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old purple sofa (right)", /obj/structure/chair/sofa/purple/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old purple sofa (corner)", /obj/structure/chair/sofa/purple/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old purple sofa (internal corner)", /obj/structure/chair/sofa/purple/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Old blue Sofa
		new/datum/stack_recipe("old blue sofa (middle)", /obj/structure/chair/sofa/blue/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue sofa (left)", /obj/structure/chair/sofa/blue/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue sofa (right)", /obj/structure/chair/sofa/blue/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue sofa (corner)", /obj/structure/chair/sofa/blue/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old blue sofa (internal corner)", /obj/structure/chair/sofa/blue/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Old red Sofa
		new/datum/stack_recipe("old red sofa (middle)", /obj/structure/chair/sofa/red/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red sofa (left)", /obj/structure/chair/sofa/red/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red sofa (right)", /obj/structure/chair/sofa/red/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red sofa (corner)", /obj/structure/chair/sofa/red/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old red sofa (internal corner)", /obj/structure/chair/sofa/red/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Old grey Sofa
		new/datum/stack_recipe("old grey sofa (middle)", /obj/structure/chair/sofa/grey/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey sofa (left)", /obj/structure/chair/sofa/grey/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey sofa (right)", /obj/structure/chair/sofa/grey/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey sofa (corner)", /obj/structure/chair/sofa/grey/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old grey sofa (internal corner)", /obj/structure/chair/sofa/grey/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Old olive Sofa
		new/datum/stack_recipe("old olive sofa (middle)", /obj/structure/chair/sofa/olive/old, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive sofa (left)", /obj/structure/chair/sofa/olive/old/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive sofa (right)", /obj/structure/chair/sofa/olive/old/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive sofa (corner)", /obj/structure/chair/sofa/olive/old/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("old olive sofa (internal corner)", /obj/structure/chair/sofa/olive/old/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe_list("sofas (corpo)", list(
		// Corpo brown Sofa
		new/datum/stack_recipe("corpo brown sofa (middle)", /obj/structure/chair/sofa/brown/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo brown sofa (left)", /obj/structure/chair/sofa/brown/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo brown sofa (right)", /obj/structure/chair/sofa/brown/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo brown sofa (corner)", /obj/structure/chair/sofa/brown/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo brown sofa (internal corner)", /obj/structure/chair/sofa/brown/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Corpo purple Sofa
		new/datum/stack_recipe("corpo purple sofa (middle)", /obj/structure/chair/sofa/purple/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo purple sofa (left)", /obj/structure/chair/sofa/purple/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo purple sofa (right)", /obj/structure/chair/sofa/purple/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo purple sofa (corner)", /obj/structure/chair/sofa/purple/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo purple sofa (internal corner)", /obj/structure/chair/sofa/purple/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Corpo blue Sofa
		new/datum/stack_recipe("corpo blue sofa (middle)", /obj/structure/chair/sofa/blue/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo blue sofa (left)", /obj/structure/chair/sofa/blue/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo blue sofa (right)", /obj/structure/chair/sofa/blue/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo blue sofa (corner)", /obj/structure/chair/sofa/blue/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo blue sofa (internal corner)", /obj/structure/chair/sofa/blue/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Corpo red Sofa
		new/datum/stack_recipe("corpo red sofa (middle)", /obj/structure/chair/sofa/red/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo red sofa (left)", /obj/structure/chair/sofa/red/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo red sofa (right)", /obj/structure/chair/sofa/red/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo red sofa (corner)", /obj/structure/chair/sofa/red/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo red sofa (internal corner)", /obj/structure/chair/sofa/red/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Corpo grey Sofa
		new/datum/stack_recipe("corpo grey sofa (middle)", /obj/structure/chair/sofa/grey/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo grey sofa (left)", /obj/structure/chair/sofa/grey/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo grey sofa (right)", /obj/structure/chair/sofa/grey/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo grey sofa (corner)", /obj/structure/chair/sofa/grey/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo grey sofa (internal corner)", /obj/structure/chair/sofa/grey/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		// Corpo olive Sofa
		new/datum/stack_recipe("corpo olive sofa (middle)", /obj/structure/chair/sofa/olive/corpo, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo olive sofa (left)", /obj/structure/chair/sofa/olive/corpo/left, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo olive sofa (right)", /obj/structure/chair/sofa/olive/corpo/right, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo olive sofa (corner)", /obj/structure/chair/sofa/olive/corpo/corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("corpo olive sofa (internal corner)", /obj/structure/chair/sofa/olive/corpo/internal_corner, 1, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	null, \
	new/datum/stack_recipe("rack parts", /obj/item/rack_parts), \
	new/datum/stack_recipe("crate shelf parts", /obj/item/rack_parts/shelf), \
	new/datum/stack_recipe_list("closets", list(
		new/datum/stack_recipe("closet", /obj/structure/closet, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("emergency closet", /obj/structure/closet/emcloset/empty, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("fire-safety closet", /obj/structure/closet/firecloset/empty, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("tool closet", /obj/structure/closet/toolcloset/empty, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("radiation closet", /obj/structure/closet/radiation/empty, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
		new/datum/stack_recipe_list("crates", list(
		new/datum/stack_recipe("crate", /obj/structure/closet/crate, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("internals crate", /obj/structure/closet/crate/internals, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("engineering crate", /obj/structure/closet/crate/engineering, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("medical crate", /obj/structure/closet/crate/medical, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("science crate", /obj/structure/closet/crate/science, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE),
		new/datum/stack_recipe("hydroponics crate", /obj/structure/closet/crate/hydroponics, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
	new/datum/stack_recipe("canister", /obj/machinery/portable_atmospherics/canister, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("plasteel floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 2, 60), \
	null, \
	new/datum/stack_recipe("wall girders", /obj/structure/girder, 2, time = 40, one_per_turf = TRUE, on_floor = TRUE, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75), \
	null, \
	new/datum/stack_recipe("computer frame", /obj/structure/frame/computer, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("modular console", /obj/machinery/modular_computer/console/buildable/, 10, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("machine frame", /obj/structure/frame/machine, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe_list("airlock assemblies", list( \
		new/datum/stack_recipe("standard airlock assembly", /obj/structure/door_assembly, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("public airlock assembly", /obj/structure/door_assembly/door_assembly_public, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("command airlock assembly", /obj/structure/door_assembly/door_assembly_com, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("security airlock assembly", /obj/structure/door_assembly/door_assembly_sec, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("engineering airlock assembly", /obj/structure/door_assembly/door_assembly_eng, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("mining airlock assembly", /obj/structure/door_assembly/door_assembly_min, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("atmospherics airlock assembly", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("research airlock assembly", /obj/structure/door_assembly/door_assembly_research, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("freezer airlock assembly", /obj/structure/door_assembly/door_assembly_fre, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("science airlock assembly", /obj/structure/door_assembly/door_assembly_science, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("medical airlock assembly", /obj/structure/door_assembly/door_assembly_med, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("virology airlock assembly", /obj/structure/door_assembly/door_assembly_viro, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("maintenance airlock assembly", /obj/structure/door_assembly/door_assembly_mai, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("external airlock assembly", /obj/structure/door_assembly/door_assembly_ext, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("external maintenance airlock assembly", /obj/structure/door_assembly/door_assembly_extmai, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("airtight hatch assembly", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 50, one_per_turf = 1, on_floor = 1), \
		new/datum/stack_recipe("maintenance hatch assembly", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 50, one_per_turf = 1, on_floor = 1), \
	)), \
	null, \
	new/datum/stack_recipe("firelock frame (fulltile)", /obj/structure/firelock_frame, 3, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("firelock frame (directional)", /obj/structure/firelock_frame/border, 1, time = 25, on_floor = TRUE), \
	new/datum/stack_recipe("turret frame", /obj/machinery/porta_turret_construct, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("meatspike frame", /obj/structure/kitchenspike_frame, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("reflector frame", /obj/structure/reflector, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("grenade casing", /obj/item/grenade/chem_grenade), \
	new/datum/stack_recipe("light fixture frame", /obj/item/wallframe/light_fixture, 2), \
	new/datum/stack_recipe("small light fixture frame", /obj/item/wallframe/light_fixture/small, 1), \
	null, \
	new/datum/stack_recipe("apc frame", /obj/item/wallframe/apc, 2), \
	new/datum/stack_recipe("air alarm frame", /obj/item/wallframe/airalarm, 2), \
	new/datum/stack_recipe("airlock controller frame", /obj/item/wallframe/advanced_airlock_controller, 2), \
	new/datum/stack_recipe("fire alarm frame", /obj/item/wallframe/firealarm, 2), \
	new/datum/stack_recipe("extinguisher cabinet frame", /obj/item/wallframe/extinguisher_cabinet, 2), \
	new/datum/stack_recipe("button frame", /obj/item/wallframe/button, 1), \
	null, \
	new/datum/stack_recipe("iron door", /obj/structure/mineral_door/iron, 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("floodlight frame", /obj/structure/floodlight_frame, 5, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("voting box", /obj/structure/votebox, 5, time = 50), \
	new/datum/stack_recipe("mortar", /obj/item/reagent_containers/glass/mortar/metal, 3), \
	new/datum/stack_recipe("pestle", /obj/item/pestle, 1, time = 50), \
	new/datum/stack_recipe("hygienebot assembly", /obj/item/bot_assembly/hygienebot, 2, time = 50), \
	new/datum/stack_recipe_list("weight machines", list( \
		new/datum/stack_recipe("chest press", /obj/structure/weightmachine/stacklifter, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
		new/datum/stack_recipe("bench press", /obj/structure/weightmachine/weightlifter, 5, time = 25, one_per_turf = TRUE, on_floor = TRUE), \
		)), \
	new/datum/stack_recipe("shower", /obj/machinery/shower, 3, time = 25)
))
