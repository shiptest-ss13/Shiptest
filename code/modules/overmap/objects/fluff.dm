#define GENERIC_SATELLITE_MESSAGE "NOTICE: Local sector authorities prohibit tampering with satellite. Aborting."
/**
 * # Fluff Object
 *
 * These overmap objects for decoration, unlike /datum/overmap/customizable_object these are premade, and as such are prefered over those for use in static sectors.
 */
/datum/overmap/fluff
	name = "overmap fluff"
	token_icon_state = "customizable"
	char_rep = "~"

	///Fluff means no real interactions
	interaction_options = null

	///Some fluff objects have dir sprites, this is kept in case they are used
	var/dir

	//TODO: move this to /datum/overmap
	///Changes the color taken from the star system when the system's override_object_colors is on.
	var/overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR

	///You can set a custom message when a ship attempts to dock, for flavor
	var/docking_message

	/// Simple var that toggles the flag overlay outposts have on/off, intended to show that this place is "inhabited"
	var/flag_overlay = FALSE

/datum/overmap/fluff/alter_token_appearance()
	. = ..()

	if(flag_overlay)
		token.cut_overlays()
		token.add_overlay("colonized")
	if(dir)
		token.setDir(dir)
	//TODO: move this to /datum/overmap
	if(!current_overmap.override_object_colors)
		return
	//fallback if overmap_color_type is not set
	if(!overmap_color_type)
		token.color = current_overmap.secondary_structure_color
	switch(overmap_color_type)
		if(STARSYSTEM_COLOR_PRIMARY_COLOR)
			token.color = current_overmap.primary_color
		if(STARSYSTEM_COLOR_SECONDARY_COLOR)
			token.color = current_overmap.secondary_color

		if(STARSYSTEM_COLOR_HAZARD_PRIMARY_COLOR)
			token.color = current_overmap.hazard_primary_color
		if(STARSYSTEM_COLOR_HAZARD_SECONDARY_COLOR)
			token.color = current_overmap.hazard_secondary_color

		if(STARSYSTEM_COLOR_PRIMARY_STRUCTURE_COLOR)
			token.color = current_overmap.primary_structure_color
		if(STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR)
			token.color = current_overmap.secondary_structure_color

	current_overmap.post_edit_token_state(src)




/datum/overmap/fluff/pre_docked(datum/overmap/dock_requester, override_dock)
	if(!docking_message)
		return ..()
	return new /datum/docking_ticket(_docking_error = docking_message)

// customizable objects serve no purpose other than for mappers to customize the objects saved into jsons exactly how they want.
/datum/overmap/fluff/customizable_object
	name = "rename me"
	token_icon_state = "customizable"

/datum/overmap/fluff/customizable_object/alter_token_appearance()
	. = ..()
	if(!desc)
		desc = {"
		[span_boldnotice("To customize this object for preperation to export it")]
		[span_notice("View Variables")] this object.
		[span_notice("Select option")] --> [span_notice("View Variables Of Parent Datum")].
		Edit the vars '[span_notice("name, desc, token_icon_state, interference_power, overmap_color_type, default_color, and/or docking_message")]'
		If during editing you need to see the icon state update, call [span_notice("alter_token_appearance()")] with no arguments on the datum.
		After this, the object should up as-is once you import it ingame.
		"}


/datum/overmap/fluff/satellite
	name = "satellite"
	desc = "Metal scaffolding runs alongside unfurled solar panels, forming into a satellite. The locals have placed it out here for a reason unknown to you. It's smart to leave it as you found it."
	docking_message = GENERIC_SATELLITE_MESSAGE
	token_icon_state = "satellite"
	overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR
	flag_overlay = TRUE
	interference_power = 5

/datum/overmap/fluff/satellite/abandoned
	name = "abandoned satellite"
	desc = "Paneling breaks and decays in solitude, each year left alone another coating of microscopic holes in this satellite's abandoned hull. One day it'll break into debris, until then it floats here."
	docking_message = null
	default_color = "#b8ccbf"
	overmap_color_type = STARSYSTEM_COLOR_HAZARD_SECONDARY_COLOR
	flag_overlay = FALSE
	interference_power = 0

/datum/overmap/fluff/commsat
	name = "communications relay satellite"
	desc = "A collection of scintillating antenna stretched out into the heavens. Every signal coming from the stars, they hear, and their brethren relay. The closer you are, the clearer you can hear them sing." + span_notice("You can get closer to reduce the interference aboard your vessel!")
	docking_message = GENERIC_SATELLITE_MESSAGE
	token_icon_state = "commsat"
	overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR
	flag_overlay = TRUE
	interference_power = -50

/datum/overmap/fluff/commsat/abandoned
	name = "abandoned communications relay satellite"
	desc = "Damaged metallic spires still try to catch and hear what travels by them, even as their foundation crumbles around them. " + span_notice("You can get closer to reduce the interference aboard your vessel!")
	docking_message = null
	default_color = "#b8ccbf"
	overmap_color_type = STARSYSTEM_COLOR_HAZARD_SECONDARY_COLOR
	flag_overlay = FALSE
	interference_power = -25

/datum/overmap/fluff/spacecolony
	name = "o'neill cylinder"
	desc = "A habitation station for an colony comprised of a cluster of cylinders. Despite the low cost of modern gravity generators, these are still used as very cheap prefabricated stations, or sold off to a new owner once the previous owner has outgrown them." + span_warning("It would be an exceedingly bad idea to drop this on a planetoid.")
	docking_message = "Colony is not accepting visitors at the moment."
	token_icon_state = "colony"
	overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR
	flag_overlay = FALSE
	interference_power = -20
	dir = SOUTH

/datum/overmap/fluff/spacecolony/abandoned
	name = "abandoned o'neill cylinder"
	desc = "An abandoned habitat, taken from its cluster by cosmic calamity. It's unusual to see an abandoned cylinder, as they are scrapped as soon as possible due to the extreme danger of letting such a large structure drift aimlessly." + span_warning("It would be an exceedingly bad idea to drop this on a planetoid.")
	docking_message = "Cylinder's docking section is far too damaged to land in. Aborting."
	default_color = "#b8ccbf"
	overmap_color_type = STARSYSTEM_COLOR_HAZARD_SECONDARY_COLOR
	flag_overlay = FALSE
	interference_power = 10
//d
/datum/overmap/fluff/dud
	name = "dud missile"
	desc = "Inactive munitions from the wars of modernity. It stays still no matter how provoked it gets. That doesn't mean it's safe."
	docking_message = "NOTICE: Local sector authorities prohibit tampering with dud. Aborting."
	token_icon_state = "missile_stationary"
	overmap_color_type = STARSYSTEM_COLOR_HAZARD_PRIMARY_COLOR
	interference_power = 5
	dir = SOUTH

/datum/overmap/fluff/fakeplanet
	name = "planet"
	desc = "An unremarkable planet of average size and below average danger, with a completely average atmosphere. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	docking_message = "planet cannot be landed on."
	token_icon_state = "globe"
	overmap_color_type = STARSYSTEM_COLOR_PRIMARY_COLOR

/datum/overmap/fluff/fakeplanet/lava
	name = "lava planet"
	desc = "A planet rife with seismic and volcanic activity. High temperatures render it dangerous for the unprepared. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "lava"
	default_color = COLOR_ORANGE
	interference_power = 5

/datum/overmap/fluff/fakeplanet/ice
	name = "frozen planet"
	desc = "A frozen planet covered in thick snow and thicker ice. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "ice"
	default_color = COLOR_BLUE_LIGHT

/datum/overmap/fluff/fakeplanet/jungle
	name = "jungle planet"
	desc = "A densely forested world, filled with vines, animals, and underbrush. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "jungle"
	default_color = COLOR_LIME

/datum/overmap/fluff/fakeplanet/redjungle
	name = "red jungle planet"
	desc = "A densely forested world, with strikingly red flora evolved to absorb the unusual blue sunlight. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "jungle"
	default_color = COLOR_MOSTLY_PURE_RED

/datum/overmap/fluff/fakeplanet/rock
	name = "rock planet"
	desc = "A rocky red world in the midst of terraforming. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "rock"
	default_color = "#bd1313"

/datum/overmap/fluff/fakeplanet/sand
	name = "salty sand planet"
	desc = "A desert planet covered in salty to sand. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "whitesands"
	default_color = COLOR_GRAY

/datum/overmap/fluff/fakeplanet/sand/sunset
	name = "Sunset"
	desc = "Once a vibrant colony with the fastest growing population, now the site of the 5 battles of Sunset, the most infamous stalemate of the ICW. Debris often rains down, bombarding what is left, numerous vessels litter the landscape, along with the SBC Starfury's crashed remains. Naturally, you can't visit here. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "battlefield"
	default_color = COLOR_GRAY

/datum/overmap/fluff/fakeplanet/beach
	name = "ocean planet"
	desc = "A warm and comfortable planet with an especially breathable atmosphere. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "ocean"
	default_color = "#c6b597"

/datum/overmap/fluff/fakeplanet/sand/blacksand
	desc = "A warm and comfortable planet with black sand beaches due to volcanic activity. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	default_color = "#8485cf"

/datum/overmap/fluff/fakeplanet/waste
	name = "waste disposal planet"
	desc = "A highly oxygenated world, coated in garbage, radiation, and rust. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "waste"
	default_color = "#a9883e"
	interference_power = 0

//i only endorse using real gas giant dymanic encounters for decorating. Please use real gas giants instead of this.
/datum/overmap/fluff/fakeplanet/gas_giant
	name = "gas giant"
	desc = "A floating ball of gas, with high gravity and even higher pressure. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "giant"
	default_color = COLOR_DARK_MODERATE_ORANGE
	interference_power = 10

/datum/overmap/fluff/fakeplanet/plasma_giant
	name = "plasma giant"
	desc = "The backbone of interstellar travel, the mighty plasma giant allows fuel collection to take place. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "giant"
	default_color = COLOR_PURPLE
	interference_power = 10

/datum/overmap/fluff/fakeplanet/plasma_giant
	name = "aqua planet"
	desc = "A planet entirely covered in water with caves with oxygen pockets. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "water"
	default_color = LIGHT_COLOR_DARK_BLUE

/datum/overmap/fluff/fakeplanet/desert
	name = "desert planet"
	desc = "A very hot and dry planet, but a prefered climate of some. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "desert"
	default_color = "#f3c282"

/datum/overmap/fluff/fakeplanet/shrouded
	name = "shrouded planet"
	desc = "A planet shrouded in a perpetual storm of bizzare particles that absorb almost all waves on the electromagnetic spectrum. Naturally, you can't visit it. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "shrouded"
	default_color = "#783ca4"
	interference_power = 100

/datum/overmap/fluff/fakeplanet/battlefield
	name = "battlefield planet"
	desc = "The site of a major ICW battlefield. The remminants of a major city, colony, or nature reserve, reduced to a muddy hellscape by decades of fighing. Naturally, you can't visit it. " + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "battlefield"
	default_color = "#b32048"

/datum/overmap/fluff/fakeplanet/moon
	name = "moon"
	desc = "A terrestrial satellite orbiting a nearby planet." + span_notice("\nThere is likely nothing of interest here. Traveling here is a waste of time.")
	token_icon_state = "moon"
	default_color = "#d1c3c3"

/datum/overmap/fluff/fakeship
	name = "SV Ship"
	desc = span_boldnotice("IFF is reporting the following:") +\
	span_bold("Affiliation: ") + "Independent" +\
	span_bold("Class: ") + "Falcon-Class" +\
	span_bold("Velocity: ") + "0 Gm/s"

	docking_message = "Vessel is not expecting any visitors. Aborting."
	token_icon_state = "ship_npc"
	overmap_color_type = STARSYSTEM_COLOR_PRIMARY_STRUCTURE_COLOR

/datum/overmap/fluff/fakeship/inteq
	name = "IRMV Attack Dog"
	desc = span_boldnotice("IFF is reporting the following:\n") +\
	span_bold("Affiliation: ") + "Inteq Risk Management Group\n" +\
	span_bold("Class: ") + "Custom Galaxy-Class Mobile Research Station\n" +\
	span_bold("Velocity: ") + "0 Gm/s"

	docking_message = "Hangar doors are not open to land in. Aborting."
	token_icon_state = "ship_massive_war"
	flag_overlay = TRUE
	interference_power = -60

/datum/overmap/fluff/fakeship/makosso
	name = "MWSV Galaxy"
	desc = span_boldnotice("IFF is reporting the following:\n") +\
	span_bold("Affiliation: ") + "Makosso-Warra Corporation\n" +\
	span_bold("Class: ") + "Galaxy-Class Mobile Research Station\n" +\
	span_bold("Velocity: ") + "0 Gm/s"

	docking_message = "Hangar doors are not open to land in. Aborting."
	token_icon_state = "ship_massive_generic"
	flag_overlay = TRUE
	interference_power = -60

/datum/overmap/fluff/fakeship/clip
	name = "CMBS From The Spear to The Grave"
	desc = span_boldnotice("IFF is reporting the following:\n") +\
	span_bold("Affiliation: ") + "Confederated League of Independent Planets\n" +\
	span_bold("Class: ") + "Paladin IV-Class\n" +\
	span_bold("Velocity: ") + "0 Gm/s"

	docking_message = "Hangar doors are not open to land in. Aborting."
	token_icon_state = "ship_massive_war"
	flag_overlay = TRUE
	interference_power = -60

/datum/overmap/fluff/fakestation
	name = "station"
	desc = "An average, run of the mill station. It doesn't appear to be open at the moment"

	docking_message = "Station is not accepting visitors at the moment."
	flag_overlay = TRUE

	token_icon_state = "station_cylinder"

/datum/overmap/fluff/fakestation/boxstation
	name = "research station MWSS-13 'Box'"
	desc = "What's left of the infamous MWSS-13 station. The parts that haven't joined the debris ring around it are untouched by living hands, only haunted by the specters of radiation and other unknowable horrors. Even now, no one is sure what happened here."

	flag_overlay = FALSE
	token_icon_state = "station_classic"
	overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR
	docking_message = "Extreme radiation and debris prevents docking. Aborting."
	interference_power = 10


/datum/overmap/fluff/fakestation/packedstation
	name = "supply station MWSS-104 'Packed'"
	desc = "What's left of the less famous MWSS-104, sister station to 'Box'. It was used to aid the various cities on Sunset during initial colonization. The smaller crew size compared to 'Box' resulted in a full evacuation before everything went south. It's too dangerous to land here."

	flag_overlay = FALSE
	token_icon_state = "outpost_small"
	overmap_color_type = STARSYSTEM_COLOR_SECONDARY_STRUCTURE_COLOR
	docking_message = "Extreme munition hazards and debris prevents docking. Aborting."
	interference_power = 5
