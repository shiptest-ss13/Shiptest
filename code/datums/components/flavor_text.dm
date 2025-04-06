/datum/component/flavor_text
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	/// The flavor text to display when the parent is examined.
	var/flavor_text
	var/portrait_url
	var/portrait_source

	var/static/flavortext_regex = regex(@"https://(?:i\.imgur\.com/[0-9A-z]{7}|i\.gyazo\.com/[0-9A-z]{32}|forums\.shiptest\.net/uploads/.+)\.(?:png|jpe?g)")

/datum/component/flavor_text/Initialize(_flavor_text, _portrait_url, _portrait_source)
	//You could technically use this on any atom, but... no.
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	flavor_text = _flavor_text

	if(!length(_portrait_url) || !length(_portrait_source))
		return

	if(!findtext(_portrait_url, flavortext_regex))
		return

	portrait_url = _portrait_url
	portrait_source = _portrait_source

/datum/component/flavor_text/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE_MORE, PROC_REF(handle_examine_more))

/datum/component/flavor_text/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE_MORE)

/datum/component/flavor_text/InheritComponent(datum/component/flavor_text/new_comp, original, _flavor_text, _portrait_url, _portrait_source)
	if(new_comp)
		flavor_text = new_comp.flavor_text
		portrait_url = new_comp.portrait_url
		portrait_source = new_comp.portrait_source
	else
		flavor_text = _flavor_text
		portrait_url = _portrait_url
		portrait_source = _portrait_source

/datum/component/flavor_text/proc/handle_examine_more(mob/user, mob/examiner)
	SIGNAL_HANDLER
	if(!flavor_text)
		return

	INVOKE_ASYNC(src, PROC_REF(ui_interact), examiner)

/datum/component/flavor_text/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
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
