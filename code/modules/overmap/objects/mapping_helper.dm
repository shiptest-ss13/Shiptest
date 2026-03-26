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

/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/alter_token_appearance()
	if(dir)
		token.setDir(dir)
		add_jump_spawnloc()

	desc = {"
[span_boldnotice("How to use")]\n
- Set the dir of this object when spawning with [span_notice("MODIF. OVERMAP")] Buildmode, or set the dir var with VV
- If one or more of these helpers exist on load, then the game will pick one at random to spawn the jump point to the wild sector to
- If none are found, then the old behavior of wild being jumpable to anywhere is used instead
- If [span_notice("FULL_INIT")] (AKA live server) is defined, then these self-delete after the game inits.
- If during editing the dir var you need to see the icon state update, call [span_notice("alter_token_appearance()")] with no arguments on the datum.\n
- Any var edits minus the dir var do nothing.
	"}
	return ..()

/datum/overmap/mapping_helper/wild_sector_jumppoint_helper/proc/add_jump_spawnloc()
	current_overmap.jump_spawnlocs += list(list("x" = x, "y" = y, "dir" = dir))
	//if we are on a local build dont clean these up, so a mapper may edit the map in a json file
	#ifdef FULL_INIT
	return INITIALIZE_HINT_QDEL
	#endif

/datum/overmap/mapping_helper/ez_export_button
	name = "export overmap to file"
	token_icon_state = "export"

/datum/overmap/mapping_helper/ez_export_button/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()
	RegisterSignal(token, COMSIG_CLICK, PROC_REF(onclick))

/datum/overmap/mapping_helper/ez_export_button/proc/onclick(atom/movable/source, location, control, params, user)
	SIGNAL_HANDLER
	usr = user
	var/list/modifiers = params2list(params)

	//probably examining
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return

	if(!check_rights(R_ADMIN) || !check_rights(R_SPAWN))
		return

	INVOKE_ASYNC(current_overmap, TYPE_PROC_REF(/datum/overmap_star_system, export_to_json), user)


/datum/overmap/mapping_helper/ez_export_button/alter_token_appearance()
	desc = {"
[span_boldnotice("How to use")]\n
- Click on this while having [span_notice("R_SPAWN")]
- A file save dialogue will open to save the overmap as a json
- The file can be then loaded with [span_notice("Spawn-Overmap-with-JSON ")] or by defining it in code
- If [span_notice("FULL_INIT")] is NOT defined (AKA localhost), then these spawn at X1, Y1 for ease of access.
	"}
	return ..()

/datum/overmap/mapping_helper/ez_varedit_system
	name = "VV starsystem"
	token_icon_state = "system_info"

/datum/overmap/mapping_helper/ez_varedit_system/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
	. = ..()
	RegisterSignal(token, COMSIG_CLICK, PROC_REF(onclick))

/datum/overmap/mapping_helper/ez_varedit_system/proc/onclick(atom/movable/source, location, control, params, user)
	SIGNAL_HANDLER
	usr = user
	var/list/modifiers = params2list(params)

	//probably examining
	if(LAZYACCESS(modifiers, SHIFT_CLICK))
		return

	if(!check_rights(R_ADMIN) || !check_rights(R_VAREDIT))
		return
	var/client/user_client = usr.client

	INVOKE_ASYNC(user_client, TYPE_PROC_REF(/client, debug_variables), current_overmap)

/datum/overmap/mapping_helper/ez_varedit_system/alter_token_appearance()
	desc = {"
[span_boldnotice("How to use")]\n
- Click on this while having [span_notice("R_VAREDIT")]
- A View Variables dialogue will open for the starsystem itself
- If [span_notice("FULL_INIT")] is NOT defined (AKA localhost), then these spawn at X2, Y1 for ease of access.
	"}
	return ..()
