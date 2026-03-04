/proc/tgui_markdown(mob/user, title, datum/callback/callback, initial_value, max_length, prompt, placeholder)
	if (!user)
		user = usr
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return
	var/datum/tgui_markdown_input/input = new(user, title, callback, initial_value, max_length, prompt, placeholder)
	input.ui_interact(user)
	return input

/datum/tgui_markdown_input
	/// The title of the TGUI window
	var/title
	/// The callback to be invoked when the editor is saved
	var/datum/callback/on_save
	/// The original value of the input
	var/initial_value
	/// The prompt shown at the top of the dialog
	var/prompt
	/// The placeholder text to show
	var/placeholder
	/// The maximum amount of characters allowed
	var/max_length


/datum/tgui_markdown_input/New(mob/user, title, datum/callback/on_save, initial_value, max_length, prompt, placeholder)
	src.title = title
	src.on_save = on_save
	src.initial_value = initial_value
	src.max_length = max_length
	src.prompt = prompt
	src.placeholder = placeholder

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
		"inputText" = initial_value,
		"prompt" = prompt,
		"placeholder" = placeholder,
		"maxLength" = max_length
	)

/datum/tgui_markdown_input/ui_act(action, list/params)
	. = ..()
	if (.)
		return
	switch(action)
		if("saveInput")
			var/markdown = params["text"]
			markdown = strip_html_simple(markdown, max_length)
			if (markdown == initial_value)
				return
			on_save.Invoke(usr, markdown)
			initial_value = markdown
			return TRUE

/datum/tgui_markdown_input/ui_close(mob/user)
	. = ..()
	qdel(src)
