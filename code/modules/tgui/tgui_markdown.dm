/proc/tgui_markdown(mob/user, title, datum/callback/callback, initial_value)
	if (!user)
		user = usr
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return
	var/datum/tgui_markdown_input/input = new(user, title, callback, initial_value)
	input.ui_interact(user)
	return input

/datum/tgui_markdown_input
	/// The title of the TGUI window
	var/title
	/// The callback to be invoked when the editor is saved
	var/datum/callback/on_save
	/// The original value of the input
	var/initial_value


/datum/tgui_markdown_input/New(mob/user, title, datum/callback/on_save, initial_value)
	src.title = title
	src.on_save = on_save
	src.initial_value = initial_value

/datum/tgui_markdown_input/Destroy(force)
	SStgui.close_uis(src)
	. = ..()

/datum/tgui_markdown_input/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MarkdownEditor")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/tgui_markdown_input/ui_state(mob/user)
	return GLOB.always_state

/datum/tgui_markdown_input/ui_data(mob/user)
	return list(
		"editorName" = title,
		"inputText" = initial_value
	)

/datum/tgui_markdown_input/ui_act(action, list/params)
	. = ..()
	if (.)
		return
	switch(action)
		if("saveInput")
			var/markdown = params["inputText"]
			if (markdown == initial_value)
				return
			on_save.Invoke(markdown)
			initial_value = markdown
			return TRUE

/datum/tgui_markdown_input/ui_close(mob/user)
	. = ..()
	qdel(src)
