///DEBRIS FIELDS - explodes your ship if you go too fast
//asteroid field right now. Bailey change this when you fix that.
/datum/overmap/event/meteor/debris
	name = "debris field (moderate)"
	desc = "An area full of scrap metal, going fast through here could prove dangerous"
	base_icon_state = "debris_medium_"
	default_color = "#b8ccbf"
	chance_to_affect = 15
	spread_chance = 50
	interference_power = 25

	safe_speed = 6

	var/blocks_sight = TRUE

	empty_space_mapgen = /datum/map_generator/planet_generator/debris

	spread_types = list(
		/datum/overmap/event/meteor/debris = 40,
		/datum/overmap/event/meteor/debris/minor = 20,
		/datum/overmap/event/meteor/debris/major = 20
	)


/datum/overmap/event/meteor/debris/alter_token_appearance()
	. = ..()
	if(blocks_sight)
		token.opacity = TRUE
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/meteor/debris/minor
	name = "debris field (minor)"
	base_icon_state = "debris_light_"
	interference_power = 15

	mountain_height_override = 0.85

	blocks_sight = FALSE

	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
	)

	safe_speed = 8

	spread_types = list(
		/datum/overmap/event/meteor/dust = 20,
		/datum/overmap/event/meteor/debris = 20,
		/datum/overmap/event/meteor/debris/minor = 40,
		/datum/overmap/event/meteor/debris/major = 10
	)


/datum/overmap/event/meteor/debris/major
	name = "debris field (major)"
	base_icon_state = "debris_major_"
	spread_chance = 25
	interference_power = 35

	mountain_height_override = 0.5

	safe_speed = 4

	meteor_types = list(
		/obj/effect/meteor/medium=50,
		/obj/effect/meteor/big=25,
		/obj/effect/meteor/flaming=10,
	)

	spread_types = list(
		/datum/overmap/event/meteor/debris = 30,
		/datum/overmap/event/meteor/debris/minor = 10,
		/datum/overmap/event/meteor/debris/major = 40
	)
