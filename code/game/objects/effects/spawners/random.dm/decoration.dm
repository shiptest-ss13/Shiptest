/obj/effect/spawner/random/decoration/glowstick
	name = "random colored glowstick"
	icon_state = "glowstick"
	loot_type_path = /obj/item/flashlight/glowstick
	loot = list()

/obj/effect/spawner/random/decoration/glowstick/on
	name = "random colored glowstick (on)"
	icon_state = "glowstick"

/obj/effect/spawner/random/decoration/glowstick/on/make_item(spawn_loc, type_path_to_make)
	. = ..()

	var/obj/item/flashlight/glowstick = .

	glowstick.set_light_on(TRUE)

/obj/effect/spawner/random/flora
	name = "random flora spawner"
	loot = list(
		/obj/structure/flora/tree/chapel,
		/obj/structure/flora/tree/pine,
		/obj/structure/flora/tree/jungle/small,
		/obj/structure/flora/tree/jungle,
		/obj/structure/flora/ash/puce,
		/obj/structure/flora/ash/fireblossom,
		/obj/structure/flora/ash/fern,
		/obj/structure/flora/ash/tall_shroom,
		/obj/structure/flora/ash/stem_shroom,
		/obj/structure/flora/ash/space/voidmelon,
		/obj/structure/flora/ash/leaf_shroom,
		/obj/structure/flora/junglebush/large,
		/obj/structure/flora/junglebush/b,
		/obj/structure/flora/junglebush/c,
		/obj/structure/flora/ausbushes/fernybush,
		/obj/structure/flora/ausbushes/genericbush,
		/obj/structure/flora/ausbushes/grassybush,
		/obj/structure/flora/ausbushes/leafybush,
		/obj/structure/flora/ausbushes/palebush,
		/obj/structure/flora/ausbushes/pointybush,
		/obj/structure/flora/ausbushes/reedbush,
		/obj/structure/flora/ausbushes/stalkybush,
		/obj/structure/flora/ausbushes/sunnybush,
		/obj/structure/flora/bush,
		/obj/structure/flora/grass/jungle,
		/obj/structure/flora/junglebush,
		/obj/structure/flora/junglebush/b,
		/obj/structure/flora/junglebush/c,
		/obj/structure/flora/ash,
		/obj/structure/flora/ash/cacti,
		/obj/structure/flora/ash/cap_shroom,
		/obj/structure/flora/ash/chilly,
		/obj/structure/flora/tree/palm
		)
	spawn_loot_count = 1

/obj/effect/spawner/random/flower
	name = "random flower spawner"
	loot = list(
		/obj/structure/flora/ausbushes/brflowers,
		/obj/structure/flora/ausbushes/ywflowers,
		/obj/structure/flora/ausbushes/ppflowers,
		/obj/structure/flora/ausbushes/fullgrass,
		/obj/structure/flora/ausbushes/sparsegrass
		)
	spawn_loot_count = 1
