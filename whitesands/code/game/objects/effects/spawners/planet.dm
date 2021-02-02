/* Spawns an item dependent on which mining planet is chosen *\
	- Combine with obj/effect/spawner/lootdrop for more complex lootdroppings
\**/
/obj/effect/spawner/planet
	name = "Planet Loot"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	layer = OBJ_LAYER
	// List keys the GLOB.current_mining_map to the item path to spawn.
	var/list/droplist = list(
		"lavaland" = /obj/item/toy/plush/bubbleplush,
		"icemoon" = /obj/item/toy/plush/goatplushie,
		"whitesands" = /obj/item/toy/plush/snakeplushie
	)

/obj/effect/spawner/planet/Initialize(mapload)
	..()
	var/turf/T = get_turf(src)
	var/path = droplist[GLOB.current_mining_map]
	if(path)
		new path(T)
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/planet/soda
	droplist = list(
		"lavaland" = /obj/item/reagent_containers/food/drinks/soda_cans/molten,
		"icemoon" = /obj/item/reagent_containers/food/drinks/soda_cans/plasma,
		"whitesands" = /obj/item/reagent_containers/food/drinks/bottle/sarsaparilla
	)
