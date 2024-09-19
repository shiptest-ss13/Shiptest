/// Makes sure objects actually have icons that exist!
/datum/unit_test/missing_icons
	var/static/list/possible_icon_states = list()
	/// additional_icon_location is for downstream modularity support.
	/// Make sure this location is also present in tools/deploy.sh
	/// If you need additional paths ontop of this second one, you can add another generate_possible_icon_states_list("your/folder/path/") below the if(additional_icon_location) block in Run(), and make sure to add that path to tools/deploy.sh as well.
	var/additional_icon_location = null

/datum/unit_test/missing_icons/proc/generate_possible_icon_states_list(directory_path)
	if(!directory_path)
		directory_path = "icons/obj/"
	for(var/file_path in flist(directory_path))
		if(findtext(file_path, ".dmi"))
			for(var/sprite_icon in icon_states("[directory_path][file_path]", 1)) //2nd arg = 1 enables 64x64+ icon support, otherwise you'll end up with "sword0_1" instead of "sword"
				possible_icon_states[sprite_icon] += list("[directory_path][file_path]")
		else
			possible_icon_states += generate_possible_icon_states_list("[directory_path][file_path]")

/datum/unit_test/missing_icons/Run()
	generate_possible_icon_states_list()
	generate_possible_icon_states_list("icons/effects/")
	if(additional_icon_location)
		generate_possible_icon_states_list(additional_icon_location)

	//Add EVEN MORE paths if needed here!
	//generate_possible_icon_states_list("your/folder/path/")
	var/list/bad_list = list()
	for(var/obj/obj_path as anything in subtypesof(/obj))
		var/list/icons_to_find = list()
		var/search_for_w = FALSE
		var/search_for_on = FALSE

		if(isbadpath(obj_path))
			continue
		if(ispath(obj_path, /obj/item))
			var/obj/item/item_path = obj_path
			if(initial(item_path.item_flags) & ABSTRACT)
				continue
			if(ispath(obj_path, /obj/item/melee))
				if(obj_path != /obj/item/melee/sword/supermatter)
					var/obj/item/melee/melee_item = new item_path()
					if(melee_item.GetComponent(/datum/component/two_handed))
						search_for_w = TRUE
					if(melee_item.GetComponent(/datum/component/transforming))
						search_for_on = TRUE

		var/icon = initial(obj_path.icon)
		var/init_icon_path = initial(obj_path.icon_state)
		icons_to_find += init_icon_path
		if(!isnull(init_icon_path))
			if(search_for_w)
				icons_to_find += "[init_icon_path]_w"
			if(search_for_on)
				icons_to_find += "[init_icon_path]_on"

		for(var/icon_state in icons_to_find)
			if(isnull(icon))
				continue
			if(isnull(icon_state))
				continue

			if(length(bad_list) && (icon_state in bad_list[icon]))
				continue

			if(icon_exists(icon, icon_state))
				continue

			if(icon_state == "nothing")
				continue

			bad_list[icon] += list(icon_state)

			var/match_message
			if(icon_state in possible_icon_states)
				for(var/file_place in possible_icon_states[icon_state])
					match_message += (match_message ? " & '[file_place]'" : " - Matching sprite found in: '[file_place]'")
			TEST_FAIL("Missing icon_state for [obj_path] in '[icon]'.\n\ticon_state = \"[icon_state]\"[match_message]")
