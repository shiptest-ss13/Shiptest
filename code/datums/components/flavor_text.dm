/datum/component/flavor_text
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	/// The flavor text to display when the parent is examined.
	var/flavor_text
	var/portrait_url
	var/portrait_source
	var/flavor_snip

	// Imgur removed, as they 404 any img requests with a referrer of 127.0.0.1 for some reason.
	// If we're ever able to change referrerPolicy on the flavor text img, we can readd this to the regex.
	// i\.imgur\.com/[0-9A-z]{7}
	var/static/flavortext_regex = regex(@"https://(?:i\.gyazo\.com/[0-9A-z]{32}|forums\.shiptest\.net/uploads/.+|i\.ibb\.co/[0-9A-z]{8}/.+)\.(?:png|jpe?g)")

/datum/component/flavor_text/Initialize(_flavor_text, _portrait_url, _portrait_source)
	//You could technically use this on any atom, but... no.
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	flavor_text = _flavor_text

	var/list/split = splittext(flavor_text, "\n")
	flavor_snip = replacetext(split[1], regex("\[_*#\]"), "")

	if(length(flavor_snip) > MAX_SHORTFLAVOR_LEN)
		flavor_snip = "[copytext(flavor_snip, 1, MAX_SHORTFLAVOR_LEN)]... <a href=\"byond://?src=[text_ref(src)];flavor_more=1\">More...</a>"
	else if(length(flavor_text) > MAX_SHORTFLAVOR_LEN || portrait_url)
		flavor_snip = "[flavor_snip] <a href=\"byond://?src=[text_ref(src)];flavor_more=1\">More...</a>"

	if(!length(_portrait_url) || !length(_portrait_source))
		return

	if(!findtext(_portrait_url, flavortext_regex))
		return

	portrait_url = _portrait_url
	portrait_source = _portrait_source


/datum/component/flavor_text/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(handle_examine))

/datum/component/flavor_text/UnregisterFromParent()
	SStgui.close_uis(src)
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)

/datum/component/flavor_text/InheritComponent(datum/component/flavor_text/new_comp, original, _flavor_text, _portrait_url, _portrait_source)
	if(new_comp)
		flavor_text = new_comp.flavor_text
		portrait_url = new_comp.portrait_url
		portrait_source = new_comp.portrait_source
	else
		flavor_text = _flavor_text
		portrait_url = _portrait_url
		portrait_source = _portrait_source

/datum/component/flavor_text/proc/handle_examine(mob/living/carbon/human/target, mob/examiner, list/examine_list)
	SIGNAL_HANDLER
	if(!flavor_text)
		return

	if(isobserver(examiner))
		examine_list += span_notice(flavor_snip)
		return

	if(!target.get_face_name(FALSE))
		examine_list += "...?"

	examine_list += span_notice(flavor_snip)

/datum/component/flavor_text/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		var/mob/living/carbon/human/owner = parent
		if(!isobserver(user) && !owner.get_face_name(FALSE))
			to_chat(user, span_warning("You can't make out the details of [owner] for some reason!"))
			return

		ui = new(user, src, "FlavorText", "[parent]")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/component/flavor_text/ui_state(mob/user)
	return GLOB.z_state

/datum/component/flavor_text/ui_data(mob/user)
	var/list/data = list()
	data["characterName"] = "[parent]"
	data["portraitUrl"] = portrait_url
	data["portraitSource"] = portrait_source
	data["flavorText"] = flavor_text
	return data

/datum/component/flavor_text/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, portrait_url) && !findtext(var_value, flavortext_regex))
		return FALSE
	return ..()

/datum/component/flavor_text/Topic(href, list/href_list)
	..()

	if(href_list["flavor_more"])
		ui_interact(usr)
