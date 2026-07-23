// dust clouds throw dust if you go Way Fast

/datum/overmap/event/meteor/dust
	name = "dust cloud"
	desc = "A cloud of spaceborne dust. Relatively harmless, unless you're travelling at relative speeds"
	base_icon_state = "dust"
	default_color = "#506469"
	chance_to_affect = 90
	spread_chance = 50
	safe_speed = 10
	interference_power = 0
	meteor_types = list(
		/obj/effect/meteor/dust=3,
	)
	primary_ores = null

	spread_types = list(
		/datum/overmap/event/meteor/dust = 80,
		/datum/overmap/event/meteor/minor = 20
	)

/datum/overmap/event/meteor/dust/alter_token_appearance()
	icon_suffix = "[rand(1, 4)]"
	..()
	if(current_overmap.override_object_colors)
		token.color = current_overmap.hazard_secondary_color
	current_overmap.post_edit_token_state(src)
