/datum/overmap_star_system/zx_spectrum_pallete
	//main colors, used for dockable terrestrials, and background
	primary_color = "#00ffff"
	secondary_color = "#ff00ff"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#ff0000"
	hazard_secondary_color = "#0000ff"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffff00"
	secondary_structure_color = "#00ff00"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

/datum/overmap_star_system/gameboy
	//main colors, used for dockable terrestrials, and background
	primary_color = "#8bad10"
	secondary_color = "#0f380f"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#8bad10"
	hazard_secondary_color = "#306230"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#9bbc0f"
	secondary_structure_color = "#8bad10"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/virtualboy
	//main colors, used for dockable terrestrials, and background
	primary_color = "#aa0000"
	secondary_color = "#ff0000"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#aa0000"
	hazard_secondary_color = "#550000"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ff0000"
	secondary_structure_color = "#aa0000"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

	can_be_selected_randomly = FALSE //this overmap does not play well without the filter

/datum/overmap_star_system/qud //hi lamb
	//main colors, used for dockable terrestrials, and background
	primary_color = "#b1c9c3"
	secondary_color = "#155352"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#d74200"
	hazard_secondary_color = "#e99f10"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffffff"
	secondary_structure_color = "#b154cf"

	override_object_colors = TRUE
	overmap_icon_state = "overmap"

/datum/overmap_star_system/amber_term
	//main colors, used for dockable terrestrials, and background
	primary_color = "#ffb000"
	secondary_color = "#eb7500"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#ffb000"
	hazard_secondary_color = "#eb7500"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#ffcc00"
	secondary_structure_color = "#ffb000"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_black_bg"

	can_be_selected_randomly = FALSE //this overmap does not play well without the filter

/datum/overmap_star_system/amber_term/post_edit_token_state(datum/overmap/datum_to_edit)
	datum_to_edit.token.remove_filter("gloweffect")
	if(datum_to_edit.token.color)
		datum_to_edit.token.add_filter("gloweffect", 5, list("type"="drop_shadow", "color"= datum_to_edit.token.color + "F0", "size"=2, "offset"=1))
	else
		datum_to_edit.token.add_filter("gloweffect", 5, list("type"="drop_shadow", "color"= "#808080", "size"=2, "offset"=1))

/datum/overmap_star_system/c64

	//main colors, used for dockable terrestrials, and background
	primary_color = "#d9ad82"
	secondary_color = "#887ecb"

	//hazard colors, used for the overmap hazards and sun
	hazard_primary_color = "#9f4e44"
	hazard_secondary_color = "#6abfc6"

	//structure colors, used for ships and outposts/colonies
	primary_structure_color = "#a1683c"
	secondary_structure_color = "#5cab5e"

	override_object_colors = TRUE
	overmap_icon_state = "overmap_dark"
