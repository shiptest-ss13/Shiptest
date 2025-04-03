/datum/autowiki/ship
	page = "Template:Autowiki/Content/Ships"
	var/mob/living/carbon/human/dummy/consistent/wiki_dummy = new()

/datum/autowiki/ship/generate()
	var/list/output = list()

	for(var/shipname in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/ship = SSmapping.shuttle_templates[shipname]

		if(!length(ship.job_slots))
			continue

		var/size = "Unknown"
		var/ship_area = (ship.width * ship.height)
		switch(ship_area)
			if(0 to 749)
				size = "Small"
			if(750 to 1249)
				size = "Medium"
			if(1250 to INFINITY)
				size = "Large"

		var/ship_name = escape_value(ship.name)
		output[ship_name] = include_template("Autowiki/Ship", list(
			"name" = ship_name,
			"shortname" = escape_value(ship.short_name) || ship_name,
			"description" = escape_value(ship.description),
			"manufacturer" = escape_value(ship.manufacturer),
			"prefix" = escape_value(ship.prefix),
			"faction" = escape_value(ship.faction.name),
			"color" = escape_value(copytext_char(ship.faction.color, 2)), // The wiki doesn't want the leading #
			"tags" = escape_value(ship.tags?.Join(", ")),
			"startingFunds" = ship.starting_funds,
			"limit" = ship.limit,
			"crewCount" = count_crew(ship.job_slots),
			"crew" = format_crew_list(ship.job_slots),
			"officerCoeff" = ship.officer_time_coeff,
			"spawnCoeff" = ship.spawn_time_coeff,
			"enabled" = ship.enabled ? "Yes" : "No",
			"size" = "[size] ([ship.width]x[ship.height])"
		))

		//Other fields: manufacturer

	return output

/datum/autowiki/ship/proc/count_crew(list/crew)
	var/output = 0
	var/officers = 0

	for(var/datum/job/job as anything in crew)
		if(job.officer)
			officers += crew[job]
		output += crew[job]

	return "[length(crew)] ([officers] officer[length(officers) != 1 ? "s" : ""])"

/datum/autowiki/ship/proc/format_crew_list(list/crew)
	var/output = ""

	var/static/list/job_icon_list = list()
	var/mob/living/carbon/human/dummy/wiki_dummy = new(locate(1,1,1))
	wiki_dummy.setDir(SOUTH)
	for(var/datum/job/job as anything in crew)
		var/filename = SANITIZE_FILENAME(escape_value(format_text(initial(job.outfit.name))))
		var/hudname = "[filename]-hud"

		output += include_template("Autowiki/ShipCrewMember", list(
			"name" = escape_value(job.name),
			"officer" = job.officer ? "Yes" : "No",
			"slots" = crew[job],
			"icon" = filename,
			"hudicon" = hudname
		))

		//Only generate each unique outfit once
		if(!(filename in job_icon_list))
			upload_icon(get_dummy_image(job), filename)
			job_icon_list += filename
		if(!(hudname in job_icon_list))
			var/icon/hudicon = get_hud_image(job)
			if(hudicon)
				upload_icon(hudicon, hudname)
			job_icon_list += hudname


	return output

/datum/autowiki/ship/proc/get_dummy_image(datum/job/to_equip)
	//Controlled randomisation
	wiki_dummy.seeded_randomization("[to_equip.outfit]", list(/datum/species/elzuose, /datum/species/human, /datum/species/ipc, /datum/species/lizard, /datum/species/moth, /datum/species/spider))
	//Delete all the old stuff they had
	wiki_dummy.wipe_state()

	to_equip.equip(wiki_dummy, TRUE, FALSE)
	wiki_dummy.regenerate_icons()
	var/icon/wiki_icon = icon(getFlatIcon(wiki_dummy), frame = 1)

	//Make all icons 32x32 for wiki sizing consistency
	if(wiki_icon.Height() != 32 || wiki_icon.Width() != 32)
		wiki_icon.Crop(1, 1, 32, 32)

	return wiki_icon

/datum/autowiki/ship/proc/get_hud_image(datum/job/to_equip)
	if(!icon_exists('icons/mob/hud.dmi', "hud[initial(to_equip.outfit.faction_icon)]"))
		return FALSE

	var/icon/hudicon = icon('icons/mob/hud.dmi', "hud[initial(to_equip.outfit.faction_icon)]")
	hudicon.Blend(icon('icons/mob/hud.dmi', "hud[initial(to_equip.outfit.job_icon)]"), ICON_OVERLAY)
	hudicon.Crop(1, 17, 8, 24)

	return hudicon
