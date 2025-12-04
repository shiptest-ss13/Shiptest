/datum/map_template/shuttle
	name = "Base Shuttle Template"
	var/category = "Basic"
	var/file_name

	var/description
	var/list/tags

	var/list/movement_force // If set, overrides default movement_force on shuttle

	/// This offsets where the ship is in the transit level.
	var/tranist_x_offset
	/// This offsets where the ship is in the transit level.
	var/tranist_y_offset

	var/port_x_offset
	var/port_y_offset
	var/port_dir

	var/limit = 2
	var/enabled
	var/short_name
	var/list/job_slots = list()
	var/list/name_categories = list("GENERAL")
	/// The icon state the ship usesship_generic
	var/token_icon_state = "ship_generic"
	/// The prefix of the ship's name.
	var/prefix = "ISV"
	/// The name of the ship's manufacturer.
	var/manufacturer = "Unknown"
	/// The faction this ship belongs to.
	var/datum/faction/faction
	/// Whether or not players from other ships can open airlocks.
	var/unique_ship_access = TRUE
	/// Set by config JSON. If true, the template's ships' "default" spawn location (when bought by a player or loaded at roundstart)
	/// will be in the middle of space, instead of at an outpost.
	var/space_spawn = FALSE

	//how much money the ship starts with
	var/starting_funds = 2000

	// Coefficients regulating the amount of necessary Living playtime to spawn this ship or join as an officer.
	// When a player attempts to spawn a ship via the join menu, officer time requirements are ignored even if the "captain" job is an officer.
	var/spawn_time_coeff = 1
	var/officer_time_coeff = 1

	var/static/list/outfits

/datum/map_template/shuttle/proc/prerequisites_met()
	return TRUE

/datum/map_template/shuttle/New(path, rename, cache)
	if(path)
		mappath = path
	else if(category && file_name)
		mappath = "_maps/shuttles/[category]/[file_name].dmm"
	. = ..()

/datum/map_template/shuttle/preload_size(path, cache)
	. = ..(path, TRUE) // Done this way because we still want to know if someone actualy wanted to cache the map
	if(!cached_map)
		return

	discover_port_offset()

	if(!cache)
		cached_map = null

/datum/map_template/shuttle/proc/discover_port_offset()
	var/key
	var/list/models = cached_map.grid_models
	var/start_pos
	var/model_text = models[key]
	for(key in models)
		model_text = models[key]
		start_pos = findtext(model_text, "[/obj/docking_port/mobile]")
		if(start_pos) // Yay compile time checks
			break // This works by assuming there will ever only be one mobile dock in a template at most

	// Finding the dir of the mobile port
	var/dpos = cached_map.find_next_delimiter_position(model_text, start_pos, ",","{","}")
	var/cache_text = trim_reduced(copytext(model_text, start_pos, dpos))
	var/variables_start = findtext(cache_text, "{")
	port_dir = NORTH // Incase something went wrong with variables from the cache
	if(variables_start)
		cache_text = copytext(cache_text, variables_start + length(cache_text[variables_start]), -length(copytext_char(cache_text, -1)))
		var/list/fields = cached_map.readlist(cache_text, ";")
		port_dir = fields["dir"] ? fields["dir"] : NORTH

	for(var/datum/grid_set/gset as anything in cached_map.gridSets)
		var/ycrd = gset.ycrd
		for(var/line in gset.gridLines)
			var/xcrd = gset.xcrd
			for(var/j in 1 to length(line) step cached_map.key_len)
				if(key == copytext(line, j, j + cached_map.key_len))
					port_x_offset = xcrd
					port_y_offset = ycrd
					return
				++xcrd
			--ycrd

/datum/map_template/shuttle/load(turf/T, centered, register=TRUE)
	if(centered)
		T = locate(T.x - round(width/2) , T.y - round(height/2) , T.z)
		centered = FALSE
	//This assumes a non-multi-z shuttle. If you are making a multi-z shuttle, good luck with that, and you'll need to change the z bounds for this block.
	var/list/turfs = block(locate(max(T.x, 1), max(T.y, 1),  T.z),
							locate(min(T.x+width, world.maxx), min(T.y+height, world.maxy), T.z))
	for(var/turf/turf in turfs)
		turfs[turf] = turf.loc
	keep_cached_map = TRUE //We need to access some stuff here below for shuttle skipovers
	. = ..(T, centered, init_atmos = TRUE)
	keep_cached_map = initial(keep_cached_map)
	if(!.)
		cached_map = keep_cached_map ? cached_map : null
		return
	var/obj/docking_port/mobile/my_port
	for(var/turf/place as anything in turfs)
		if(place.loc == turfs[place] || !istype(place.loc, /area/ship)) //If not part of the shuttle, ignore it
			turfs -= place
			continue

		for(var/obj/docking_port/mobile/port in place)
			if(my_port)
				CRASH("[src] loaded with multiple docking ports!")
			my_port = port
			if(register)
				port.register()
			if(isnull(port_x_offset))
				continue
			switch(port.dir) // Yeah this looks a little ugly but mappers had to do this in their head before
				if(NORTH)
					port.width = width
					port.height = height
					port.dwidth = port_x_offset - 1
					port.dheight = port_y_offset - 1
				if(EAST)
					port.width = height
					port.height = width
					port.dwidth = height - port_y_offset
					port.dheight = port_x_offset - 1
				if(SOUTH)
					port.width = width
					port.height = height
					port.dwidth = width - port_x_offset
					port.dheight = height - port_y_offset
				if(WEST)
					port.width = height
					port.height = width
					port.dwidth = port_y_offset - 1
					port.dheight = width - port_x_offset

	if(!my_port)
		CRASH("Shuttle template loaded without a mobile port!")

	for(var/turf/shuttle_turf in turfs)
		//Set up underlying_turf_area and update relevent towed_shuttles
		var/area/ship/turf_loc = turfs[shuttle_turf]
		my_port.underlying_turf_area[shuttle_turf] = turf_loc
		if(istype(turf_loc) && turf_loc.mobile_port)
			turf_loc.mobile_port.towed_shuttles |= my_port

		//Getting the amount of baseturfs added
		var/z_offset = shuttle_turf.z - T.z
		var/y_offset = shuttle_turf.y - T.y
		var/x_offset = shuttle_turf.x - T.x
		//retrieving our cache
		var/line
		var/list/cache
		for(var/datum/grid_set/gset as() in cached_map.gridSets)
			if(gset.zcrd - 1 != z_offset) //Not our Z-level
				continue
			if((gset.ycrd - 1 < y_offset) || (gset.ycrd - length(gset.gridLines) > y_offset)) //Our y coord isn't in the bounds
				continue
			line = gset.gridLines[length(gset.gridLines) - y_offset] //Y goes from top to bottom
			if((gset.xcrd - 1 < x_offset) || (gset.xcrd + (length(line)/cached_map.key_len) - 2 > x_offset)) ///Our x coord isn't in the bounds
				continue
			cache = cached_map.modelCache[copytext(line, 1+((x_offset-gset.xcrd+1)*cached_map.key_len), 1+((x_offset-gset.xcrd+2)*cached_map.key_len))]
			break
		if(!cache) //Our turf isn't in the cached map, something went very wrong
			continue

		//How many baseturfs were added to this turf by the mapload
		var/baseturf_length
		var/turf/P //Typecasted for the initial call
		for(P as() in cache[1])
			if(ispath(P, /turf))
				var/list/added_baseturfs = GLOB.created_baseturf_lists[initial(P.baseturfs)] //We can assume that our turf type will be included here because it was just generated in the mapload.
				if(!islist(added_baseturfs))
					added_baseturfs = list(added_baseturfs)
				baseturf_length = length(added_baseturfs - GLOB.blacklisted_automated_baseturfs)
				break
		if(ispath(P, /turf/template_noop)) //No turf was added, don't add a skipover
			continue

		var/list/sanity = islist(shuttle_turf.baseturfs) ? shuttle_turf.baseturfs.Copy() : list(shuttle_turf.baseturfs)
		sanity.Insert(shuttle_turf.baseturfs.len + 1 - baseturf_length, /turf/baseturf_skipover/shuttle) //The first two are the "real" baseturfs, place above these but below plating.
		shuttle_turf.baseturfs = baseturfs_string_list(sanity, shuttle_turf)

	my_port.load(src)
	cached_map = keep_cached_map ? cached_map : null

/datum/map_template/shuttle/ui_state(mob/user)
	return GLOB.admin_debug_state

/datum/map_template/shuttle/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShipEditor")
		ui.open()

/datum/map_template/shuttle/ui_static_data(mob/user)
	. = list()
	if(!outfits)
		outfits = list()
		for(var/datum/outfit/outfit as anything in subtypesof(/datum/outfit))
			outfits[initial(outfit.name)] = outfit
		outfits = sortList(outfits)

	.["outfits"] = outfits

	.["templateName"] = name
	.["templateShortName"] = short_name
	.["templateDescription"] = description
	.["templateTags"] = tags
	.["templateCategory"] = category
	.["templateLimit"] = limit
	.["templateSpawnCoeff"] = spawn_time_coeff
	.["templateOfficerCoeff"] = officer_time_coeff
	.["templateEnabled"] = enabled

	.["templateJobs"] = list()
	for(var/datum/job/job as anything in job_slots)
		var/list/jobdetails = list()
		jobdetails["ref"] = REF(job)
		jobdetails["name"] = job.name
		jobdetails["officer"] = job.officer
		jobdetails["outfit"] = initial(job.outfit.name)
		jobdetails["slots"] = job_slots[job]
		.["templateJobs"] += list(jobdetails)

/datum/map_template/shuttle/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("setTemplateName")
			name = params["new_template_name"]
			update_static_data(usr, ui)
			return TRUE
		if("setTemplateShortName")
			short_name = params["new_template_short_name"]
			update_static_data(usr, ui)
			return TRUE
		if("setTemplateIconState")
			token_icon_state = params["new_template_icon_state"]
			update_static_data(usr, ui)
			return TRUE
		if("setTemplateDescription")
			description = params["new_template_description"]
			update_static_data(usr, ui)
			return TRUE
		if("addTemplateTags")
			if(!tags)
				tags = list()
			if(!(params["new_template_tags"] in tags))
				tags.Add(params["new_template_tags"])
			update_static_data(usr, ui)
			return TRUE
		if("removeTemplateTags")
			if(params["new_template_tags"] in tags)
				tags.Remove(params["new_template_tags"])
			update_static_data(usr, ui)
			return TRUE
		if("setTemplateCategory")
			category = params["new_template_category"]
			update_static_data(usr, ui)
			return TRUE
		if("setTemplateLimit")
			limit = params["new_template_limit"]
			update_static_data(usr, ui)
			return TRUE
		if("setSpawnCoeff")
			spawn_time_coeff = params["new_spawn_coeff"]
			update_static_data(usr, ui)
			return TRUE
		if("setOfficerCoeff")
			officer_time_coeff = params["new_officer_coeff"]
			update_static_data(usr, ui)
			return TRUE
		if("toggleTemplateEnabled")
			enabled = !enabled
			if(enabled)
				SSmapping.ship_purchase_list[name] = src
			else
				SSmapping.ship_purchase_list.Remove(name)
			update_static_data(usr, ui)
			return TRUE

		if("addJobSlot")
			job_slots[new /datum/job] = 0
			update_static_data(usr, ui)
			return TRUE

	if("job_ref" in params)
		var/datum/job/job_slot = locate(params["job_ref"]) in job_slots
		if(!job_slot)
			return
		switch(action)
			if("toggleJobOfficer")
				job_slot.officer = !job_slot.officer
			if("setJobName")
				job_slot.name = params["job_name"]
			if("setJobOutfit")
				var/new_outfit = params["job_outfit"]
				if(!(new_outfit in outfits))
					return
				new_outfit = outfits[new_outfit]
				job_slot.outfit = new new_outfit
			if("setJobSlots")
				job_slots[job_slot] = clamp(params["job_slots"], 0, 100)
		update_static_data(usr, ui)
		return TRUE

//Whatever special stuff you want
/datum/map_template/shuttle/post_load(obj/docking_port/mobile/M)
	if(movement_force)
		M.movement_force = movement_force.Copy()

/// Shiptest-specific main maps. Do not make subtypes! Make a json in /_maps/configs/ instead.
/datum/map_template/shuttle/shiptest
	category = "shiptest"

/// Shuttles to be loaded in ruins
/datum/map_template/shuttle/ruin
	category = "ruin"
	starting_funds = 0

//Subshuttles

/datum/map_template/shuttle/subshuttles
	category = "subshuttles"
	faction = /datum/faction/independent
	starting_funds = 0
	unique_ship_access = FALSE

/datum/map_template/shuttle/subshuttles/pill
	file_name = "independent_pill"
	name = "Pill-class Torture Device"
	token_icon_state = "ship_tiny_generic"
	prefix = "Pill"
	name_categories = list("PILLS")

/datum/map_template/shuttle/subshuttles/pillb
	file_name = "independent_blackpill"
	name = "Blackpill-class Manned Torpedo"
	token_icon_state = "ship_tiny_generic"
	prefix = "Pill"
	name_categories = list("PILLS")

/datum/map_template/shuttle/subshuttles/pills
	file_name = "independent_superpill"
	name = "Superpill-class Experimental Engineering Platform"
	token_icon_state = "ship_tiny_generic"
	prefix = "Pill"
	name_categories = list("PILLS")

/datum/map_template/shuttle/subshuttles/kunai
	file_name = "independent_kunai"
	name = "Kunai Dropship"
	token_icon_state = "ship_tiny_generic"
	prefix = "SV"

/datum/map_template/shuttle/subshuttles/sugarcube
	file_name = "independent_sugarcube"
	name = "Sugarcube Transport"
	token_icon_state = "ship_tiny_generic"
	prefix = "ISV"

//your subshuttle here //why is my subshuttle here // its no longer there

/datum/map_template/shuttle/subshuttles/crux
	file_name = "minutemen_crux"
	name = "Crux Dropship"
	token_icon_state = "ship_tiny_generic"
	faction = /datum/faction/clip
	prefix = "CMSV"

/datum/map_template/shuttle/subshuttles/hestia
	file_name = "minutemen_hestia"
	name = "Hestia-class Emergency Shuttle"
	token_icon_state = "ship_tiny_generic"
	faction = /datum/faction/clip
	prefix = "CLSV"

/datum/map_template/shuttle/subshuttles/ancon
	file_name = "nanotrasen_ancon"
	name = "Nanotrasen Ancon-class Command Ship"
	token_icon_state = "ship_tiny_generic"
	faction = /datum/faction/nt
	prefix = "NTSV"
	name_categories = list("GENERAL", "SPACE")

/datum/map_template/shuttle/subshuttles/frontiersmen_gut //i need to give this a better name at some point
	file_name = "frontiersmen_gut"
	name = "Gut Combat Freighter"
	token_icon_state = "ship_tiny_generic"
	prefix = "ISV"

/datum/map_template/shuttle/subshuttles/javelin
	file_name = "inteq_javelin"
	name = "Javelin-class Mobile Operations Shuttle"
	faction = /datum/faction/inteq
	token_icon_state = "ship_tiny_generic"
	prefix = "IRMV"
	name_categories = list("GENERAL", "SPACE")

/datum/map_template/shuttle/subshuttles/runner
	file_name = "syndicate_runner"
	name = "Runner-class Ambulance"
	faction = /datum/faction/syndicate/cybersun
	token_icon_state = "ship_tiny_generic"
	prefix = "CSSV"
	name_categories = list("GENERAL", "SPACE")

/datum/map_template/shuttle/subshuttles/nail
	file_name = "pgf_nail"
	name = "Nail-class Boarding Vessel"
	faction = /datum/faction/pgf
	token_icon_state = "ship_tiny_generic"
	prefix = "PGF"

/datum/map_template/shuttle/subshuttles/tanto
	file_name = "independent_tanto"
	name = "Tanto-class Drop Pod"
	prefix = "SV"

/datum/map_template/shuttle/subshuttles/brawler
	file_name = "frontiersmen_brawler"
	name = "Brawler-class Dropship"
	token_icon_state = "ship_tiny_generic"
	prefix = "SV"

/datum/map_template/shuttle/subshuttles/haymaker
	file_name = "frontiersmen_haymaker"
	name = "Haymaker-class Command Post"
	prefix = "SV"

/datum/map_template/shuttle/subshuttles/skink
	file_name = "nanotrasen_skink"
	name = "Skink-class Cargo Runner"
	faction = /datum/faction/nt
	token_icon_state = "ship_tiny_generic"
	prefix = "NTSV"

/datum/map_template/shuttle/subshuttles/bambulance
	file_name = "cybersun_bambulance"
	name = "Gauze-class Ambulance Pod"
	faction = /datum/faction/syndicate/cybersun
	prefix = "CSSV"

/datum/map_template/shuttle/subshuttles/thunder
	file_name = "inteq_thunder"
	name = "Thunder-class Interceptor"
	faction = /datum/faction/inteq
	token_icon_state = "ship_tiny_generic"
	prefix = "IRMV"

/datum/map_template/shuttle/subshuttles/bonnie
	file_name = "independent_bonnie"
	name = "Bonnie-class Cargo Hauler"
	token_icon_state = "ship_tiny_generic"
	prefix = "SV"

/datum/map_template/shuttle/subshuttles/flea
	file_name = "ramzi_flea"
	name = "Flea-class Boarding Cutter"
	faction = /datum/faction/ramzi
	token_icon_state = "ship_tiny_generic"
	prefix = "ISV"

/datum/map_template/shuttle/subshuttles/shortbow
	file_name = "srm_shortbow"
	name = "Shortbow-class Dropship"
	faction = /datum/faction/srm
	token_icon_state = "ship_tiny_generic"
	prefix = "SRSV"

/datum/map_template/shuttle/subshuttles/karst
	file_name = "ngr_karst"
	name = "Karst-class Drop Pod"
	faction = /datum/faction/syndicate/ngr
	token_icon_state = "ship_tiny_generic"
	prefix = "NGRV"
