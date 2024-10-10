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
