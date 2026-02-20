/**
 * # Fluff Object
 *
 * These overmap objects for decoration, unlike /datum/overmap/customizable_object these are premade, and as such are prefered over those for use in static sectors.
 */
/datum/overmap/mapping_helper
	name = "mapping helper"
	char_rep = "+"

/datum/overmap/mapping_helper/wild_sector_jumppoint_helper
	name = "wild sector jump point spawn location"
	token_icon_state = "wild_jumppoint_helper"
	var/dir

/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()

	current_overmap.jump_spawnlocs += list(list("x" = x, "y" = y, "dir" = dir))
	//if we are on a local build dont clean these up, so a mapper may edit the map in a json file
	#ifdef FULL_INIT
		qdel(jumppoint_spawnloc)
	#endif

/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/alter_token_appearance()
	. = ..()

	if(dir)
		token.setDir(dir)

	desc = {"
	[span_boldnotice("How to use")]
	Set the dir of this object when spawning with [span_notice("MODIF. OVERMAP")] Buildmode, or set the dir var with VV
	If one or more of these helpers exist on load, then the game will pick one at random to spawn the jump point to the wild sector to
	If none are found, then the old behavior of wild being jumpable to anywhere is used instead
	If [span_notice("FULL_INIT")] (AKA live server) is defined, then these self-delete after the game inits.
	If during editing the dir var you need to see the icon state update, call [span_notice("alter_token_appearance()")] with no arguments on the datum.\n
	Any var edits minus the dir var do nothing.
	"}


/datum/overmap/mapping_helper/ez_export_button
	name = "export overmap to file"
	token_icon_state = "export"

/datum/overmap/mapping_helper/ez_export_button/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()
	SEND_SIGNAL(token, COMSIG_CLICK, location, control, params, usr)

/datum/overmap/mapping_helper/ez_export_button/alter_token_appearance()
	. = ..()
	desc = {"
	[span_boldnotice("How to use")]
	Click on this while having [span_notice("R_SPAWN")]
	A file save dialogue will open to save the overmap as a json
	The file can be then loaded with [span_notice("Spawn-Overmap-with-JSON ")] or by defining it in code
	If [span_notice("FULL_INIT")] is NOT defined (AKA localhost), then these spawn at X1, Y1 for ease of access.
	"}
