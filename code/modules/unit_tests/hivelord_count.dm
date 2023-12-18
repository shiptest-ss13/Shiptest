/datum/unit_test/count_mob_spawn_items/Run()
	var/int total_items_created = 0

	for (var/i in 1 to 100)
		var/obj/effect/mob_spawn/human/corpse/damaged/legioninfested/SpawnEffect = new /obj/effect/mob_spawn/human/corpse/damaged/legioninfested
		SpawnEffect.Initialize()

		for (var/obj/item/I in SpawnEffect.loc.get_contents())
			total_items_created += 1

    world.log << "Total items created from mob_spawn: [total_items_created]"
