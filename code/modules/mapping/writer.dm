/**Map exporter
* Inputting a list of turfs into convert_map_to_tgm() will output a string
* with the turfs and their objects / areas on said turf into the TGM mapping format
* for .dmm files. This file can then be opened in the map editor or imported
* back into the game.
* ============================
* This has been made semi-modular so you should be able to use these functions
* elsewhere in code if you ever need to get a file in the .dmm format
**/
/atom/proc/get_save_vars()
	return list("pixel_x", "pixel_y", "dir", "name", "req_access", "req_access_txt", "piping_layer", "color", "icon", "icon_state", "pipe_color", "amount")

GLOBAL_LIST_INIT(save_file_chars, list(
	"a","b","c","d","e",
	"f","g","h","i","j",
	"k","l","m","n","o",
	"p","q","r","s","t",
	"u","v","w","x","y",
	"z","A","B","C","D",
	"E","F","G","H","I",
	"J","K","L","M","N",
	"O","P","Q","R","S",
	"T","U","V","W","X",
	"Y","Z"
))

//Converts a list of turfs into TGM file format
/proc/write_map(minx as num, \
				miny as num, \
				minz as num, \
				maxx as num, \
				maxy as num, \
				maxz as num, \
				save_flag = SAVE_ALL, \
				shuttle_area_flag = SAVE_SHUTTLEAREA_DONTCARE, \
				list/obj_blacklist = list())

	var/width = maxx - minx
	var/height = maxy - miny
	var/depth = maxz - minz

	//Step 0: Calculate the amount of letters we need (26 ^ n > turf count)
	var/turfsNeeded = (width + 1) * (height + 1)
	var/layers = FLOOR(log(GLOB.save_file_chars.len, turfsNeeded) + 0.999,1)

	//Step 1: Run through the area and generate file data
	var/list/header_chars	= list()	//The characters of the header
	var/list/header_dat 	= list()	//The data of the header, lines up with chars
	var/header				= ""		//The actual header in text
	var/contents			= ""		//The contents in text (bit at the end)
	var/index = 1
	for(var/z in 0 to depth)
		for(var/x in 0 to width)
			contents += "\n([x + 1],1,[z + 1]) = {\"\n"
			for(var/y in height to 0 step -1)
				CHECK_TICK
				//====Get turfs Data====
				var/turf/place_turf = locate((minx + x), (miny + y), (minz + z))
				var/turf_type = /turf/template_noop
				var/area/place_area = get_area(place_turf)
				var/area_type = /area/template_noop
				var/is_shuttle_area = istype(place_area, /area/ship)
				//If there is nothing there, save as a noop (For odd shapes)
				if(!place_turf)
					turf_type = /turf/template_noop
					area_type = /area/template_noop
					place_turf = null
				//Ignore things in space, must be a space turf
				else if(istype(place_turf, /turf/open/space) && !(save_flag & SAVE_SPACE))
					turf_type = /turf/template_noop
					area_type = /area/template_noop
				//====Saving shuttles only / non shuttles only====
				else if((is_shuttle_area && shuttle_area_flag == SAVE_SHUTTLEAREA_IGNORE) || (!is_shuttle_area && shuttle_area_flag == SAVE_SHUTTLEAREA_ONLY))
					turf_type = /turf/template_noop
					area_type = /area/template_noop
				//Stuff to add
				else if(save_flag & SAVE_TURFS)
					turf_type = place_turf.type
					area_type = place_area.type

				//====For toggling not saving areas and turfs====
				if(!(save_flag & SAVE_AREAS))
					area_type = /area/template_noop
				else if(turf_type != /turf/template_noop)
					//====Saving turfs====
					var/turf_metadata = generate_tgm_metadata(place_turf)
					var/custom_data = place_turf.on_turf_saved()
					turf_type = "[turf_type][turf_metadata][custom_data ? ",\n[custom_data]" : ""]"
				//====Generate Header Character====
				var/header_char = calculate_tgm_header_index(index, layers)	//The characters of the header
				var/current_header = "(\n"										//The actual stuff inside the header
				//Add objects to the header file
				var/empty = TRUE
				//====SAVING OBJECTS====
				if(save_flag & SAVE_OBJECTS)
					for(var/obj/thing in place_turf)
						CHECK_TICK
						if(thing.type in obj_blacklist)
							continue
						var/metadata = generate_tgm_metadata(thing)
						current_header += "[empty?"":",\n"][thing.type][metadata]"
						empty = FALSE
						//====SAVING SPECIAL DATA====
						//This is what causes lockers and machines to save stuff inside of them
						if(save_flag & SAVE_OBJECT_PROPERTIES)
							var/custom_data = thing.on_object_saved()
							current_header += "[custom_data ? ",\n[custom_data]" : ""]"
				//====SAVING MOBS====
				if(save_flag & SAVE_MOBS)
					for(var/mob/living/thing in place_turf)
						CHECK_TICK
						if(istype(thing, /mob/living/carbon))		//Ignore people, but not animals
							for(var/obj/object in thing.contents)
								if(object.type in obj_blacklist)
									continue
								var/metadata = generate_tgm_metadata(object)
								current_header += "[empty?"":",\n"][object.type][metadata]"
								empty = FALSE
								//====SAVING SPECIAL DATA====
								//This is what causes lockers and machines to save stuff inside of them
								if(save_flag & SAVE_OBJECT_PROPERTIES)
									var/custom_data = object.on_object_saved()
									current_header += "[custom_data ? ",\n[custom_data]" : ""]"
							continue
						var/metadata = generate_tgm_metadata(thing)
						current_header += "[empty?"":",\n"][thing.type][metadata]"
						empty = FALSE
				current_header += "[empty?"":",\n"][turf_type],\n[area_type])\n"
				//====Fill the contents file====
				//Compression is done here
				var/position_of_header = header_dat.Find(current_header)
				if(position_of_header)
					//If the header has already been saved, change the character to the other saved header
					header_char = header_chars[position_of_header]
				else
					header += "\"[header_char]\" = [current_header]"
					header_chars += header_char
					header_dat += current_header
					index ++
				contents += "[header_char]\n"
			contents += "\"}"
	return "//MAP CONVERTED BY dmm2tgm.py THIS HEADER COMMENT PREVENTS RECONVERSION, DO NOT REMOVE\n[header][contents]"

//vars_to_save = list() to save all vars
/proc/generate_tgm_metadata(atom/O)
	var/dat = ""
	var/data_to_add = list()
	var/list/vars_to_save = O.get_save_vars()
	if(!vars_to_save)
		return
	for(var/V in O.vars)
		if(!(V in vars_to_save))
			continue
		var/value = O.vars[V]
		if(!value)
			continue
		if(value == initial(O.vars[V]) || !issaved(O.vars[V]))
			continue
		if(V == "icon_state" && O.smoothing_flags)
			continue
		var/symbol = ""
		if(istext(value))
			symbol = "\""
			value = sanitize_simple(value, list("{"="", "}"="", "\""="", ";"="", ","=""))
		else if(islist(value))
			value = to_list_string(value)
		else if(isicon(value) || isfile(value))
			symbol = "'"
		else if(!(isnum(value) || ispath(value)))
			continue
		//Prevent symbols from being because otherwise you can name something [";},/obj/item/gun/energy/laser/instakill{name="da epic gun] and spawn yourself an instakill gun.
		data_to_add += "[V] = [symbol][value][symbol]"
	//Process data to add
	var/first = TRUE
	for(var/data in data_to_add)
		dat += "[first ? "" : ";\n"]\t[data]"
		first = FALSE
	if(dat)
		dat = "{\n[dat]\n\t}"
	return dat

/proc/calculate_tgm_header_index(index, layers)
	var/output = ""
	for(var/i in 1 to layers)
		var/l = GLOB.save_file_chars.len
		var/c = FLOOR((index-1) / (l ** (i - 1)), 1)
		c = (c % l) + 1
		output = "[GLOB.save_file_chars[c]][output]"
	return output
