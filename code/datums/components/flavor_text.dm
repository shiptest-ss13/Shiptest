/datum/component/flavor_text
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	/// The flavor text to display when the parent is examined.
	var/flavor_text
	var/portrait_url
	var/portrait_source

	var/static/link_list = list("https://media.discordapp.net", "https://cdn.discordapp.com", "https://i.gyazo.com", "https://i.imgur.com")
	var/static/end_regex = regex("^.jpg|.jpg|.png|.jpeg|.jpeg$") //Regex is terrible, don't touch the duplicate extensions

/datum/component/flavor_text/Initialize(_flavor_text, _portrait_url, _portrait_source)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	flavor_text = _flavor_text

	if(!length(_portrait_url) || !length(_portrait_source))
		return

	if(copytext_char(_portrait_url, 9) != "https://")
		return

	for(var/link in link_list)
		if(findtext(_portrait_url, link))
			break

	portrait_url = _portrait_url
	portrait_source = _portrait_source



/datum/component/flavor_text/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FlavorText", "[user.real_name]'s Guestbook")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/component/flavor_text/ui_state(mob/user)
	return GLOB.always_state

/datum/component/flavor_text/ui_data(mob/user)
	var/list/data = list()
	data["characterName"] = flavor_text
	data["portraitUrl"] = portrait_url
	data["portraitSource"] = portrait_source
	data["flavorText"] = flavor_text
	return data
