
///METEOR STORMS - explodes your ship if you go too fast
/datum/overmap/event/meteor
	name = "asteroid field (moderate)"
	desc = "An area of space rich with asteroids, going fast through here could prove dangerous"
	base_icon_state = "meteor_medium_"
	default_color = "#a08444"
	chance_to_affect = 15
	spread_chance = 50
	interference_power = 15

	spread_types = list(
		/datum/overmap/event/meteor/minor = 30,
		/datum/overmap/event/meteor = 40,
		/datum/overmap/event/meteor/major = 20
	)

	empty_space_mapgen = /datum/map_generator/planet_generator/asteroid

	///how fast can you safely travel in this hazard. Any faster will activate the hazard.
	var/safe_speed = 5

	///weighted table of meteors that this hazard can throw
	var/list/meteor_types = list(
		/obj/effect/meteor/dust=3,
		/obj/effect/meteor/medium=8,
		/obj/effect/meteor/big=1,
		/obj/effect/meteor/irradiated=3
	)
	///The kinds of ores that meteors can have inside them.
	var/primary_ores = list(\
		/obj/item/stack/ore/plasma,
		/obj/item/stack/ore/iron,
		)

/datum/overmap/event/meteor/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()

	var/orestext
	if(primary_ores)
		orestext += span_boldnotice("\nInitial scans show a high concentration of the following ores:\n")
		for(var/obj/ore as anything in primary_ores)
			var/hex = ORES_TO_COLORS_LIST[ore]
			orestext += "<font color='[hex]'>	- [ore.name]\n</font>"
		desc += orestext

		token.desc += span_notice("\nYou could land within the [src] if you were to [span_bold("Dock to Empty Space")] while flying over...\n")

	if(safe_speed)
		token.desc += span_notice("\nYou can safely navigate through this if your ship is travelling under [span_bold("[safe_speed] Gm/s")].")

	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/event/meteor/apply_effect()
	for(var/datum/overmap/ship/controlled/Ship in get_nearby_overmap_objects())
		if(Ship.get_speed() > safe_speed)
			var/how_fast =  (Ship.get_speed() - safe_speed)
			if(prob(chance_to_affect + how_fast))
				affect_ship(Ship)

/datum/overmap/event/meteor/affect_ship(datum/overmap/ship/controlled/Ship)
	spawn_meteor(meteor_types, Ship.shuttle_port.get_virtual_level(), 0, Ship.shuttle_port)

/datum/overmap/event/meteor/minor
	name = "asteroid field (minor)"
	base_icon_state = "meteor_light_"
	interference_power = 10

	mountain_height_override = 0.85

	spread_chance = 60

	meteor_types = list(
		/obj/effect/meteor/dust=12,
		/obj/effect/meteor/medium=4,
	)

	spread_types = list(
		/datum/overmap/event/meteor/dust = 20,
		/datum/overmap/event/meteor/minor = 40,
		/datum/overmap/event/meteor = 30,
		/datum/overmap/event/meteor/major = 10
	)

	safe_speed = 7

/datum/overmap/event/meteor/major
	name = "asteroid field (major)"
	base_icon_state = "meteor_major_"
	spread_chance = 30
	interference_power = 20

	mountain_height_override = 0.5

	meteor_types = list(
		/obj/effect/meteor/medium=50,
		/obj/effect/meteor/big=25,
		/obj/effect/meteor/flaming=10,
	)

	spread_types = list(
		/datum/overmap/event/meteor/minor = 10,
		/datum/overmap/event/meteor = 30,
		/datum/overmap/event/meteor/major = 30
	)

	safe_speed = 4

