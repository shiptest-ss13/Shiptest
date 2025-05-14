/obj/effect/spawner/random/maintenance
	name = "maintenance loot spawner"
	desc = "Come on Lady Luck, spawn me a pair of sunglasses."
	icon_state = "loot"
	// see code/_globalvars/lists/maintenance_loot.dm for loot table

/obj/effect/spawner/random/maintenance/Initialize(mapload)
	loot = GLOB.maintenance_loot
	. = ..()

/obj/effect/spawner/random/maintenance/skew_loot_weights(list/loot_list, exponent)
	///We only need to skew the weights once, since it's a global list used by all maint spawners.
	var/static/already_done = FALSE
	if(loot_list == GLOB.maintenance_loot && already_done)
		return
	already_done = TRUE
	return ..()

/obj/effect/spawner/random/maintenance/spawn_loot(lootcount_override)
	if(isnull(lootcount_override))
		lootcount_override = spawn_loot_count
	. = ..()

	/* Fucks everything. Investigate further
	// In addition, closets that are closed will have the maintenance loot inserted inside.
	for(var/obj/structure/closet/closet in get_turf(src))
		if(!closet.opened)
			closet.take_contents()
	*/

/obj/effect/spawner/random/maintenance/two
	name = "2 x maintenance loot spawner"
	spawn_loot_count = 2

/obj/effect/spawner/random/maintenance/three
	name = "3 x maintenance loot spawner"
	spawn_loot_count = 3

/obj/effect/spawner/random/maintenance/four
	name = "4 x maintenance loot spawner"
	spawn_loot_count = 4

/obj/effect/spawner/random/maintenance/five
	name = "5 x maintenance loot spawner"
	spawn_loot_count = 5

/obj/effect/spawner/random/maintenance/six
	name = "6 x maintenance loot spawner"
	spawn_loot_count = 6

/obj/effect/spawner/random/maintenance/seven
	name = "7 x maintenance loot spawner"
	spawn_loot_count = 7

/obj/effect/spawner/random/maintenance/eight
	name = "8 x maintenance loot spawner"
	spawn_loot_count = 8
