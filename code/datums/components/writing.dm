/datum/component/writing
	/// Lazylist of raw, unsanitised, unparsed text inputs that have been made to the paper.
	var/list/datum/paper_input/raw_text_inputs
	/// Lazylist of all raw stamp data to be sent to tgui.
	var/list/datum/paper_graphic/raw_graphic_data
	/// Lazylist of all fields that have had some input added to them.
	var/list/datum/paper_field/raw_field_input_data

	/// Helper cache that contains a list of all icon_states that are currently stamped on the paper.
	var/list/graphic_cache
	/// The number of input fields
	var/input_field_count = 0
	/// Readable by blind people
	var/braille

	/// Width of the TGUI window
	var/window_width
	/// Height of the TGUI window
	var/window_height
	/// Whether the TGUI window is resizable
	var/resizable
	/// List of asset datum typepaths used
	var/list/asset_list

	/// Positioning for applied graphics (stamps, icons, etc) in tgui
	var/list/graphics

/datum/component/writing/Initialize(
	raw_text,
	braille = FALSE,
	window_width = 420,
	window_height = 500,
	resizable = TRUE,
	asset_list = list(/datum/asset/spritesheet/simple/paper),
	...
)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	if(raw_text)
		add_raw_text(raw_text)
	src.window_width = window_width
	src.window_height = window_height
	src.asset_list = asset_list
	src.resizable = resizable
	src.braille = braille

	var/atom/parent_atom = parent
	parent_atom.update_appearance()
	return ..()

/datum/component/writing/Destroy(force)
	LAZYNULL(raw_text_inputs)
	LAZYNULL(raw_graphic_data)
	LAZYNULL(raw_field_input_data)
	LAZYNULL(graphic_cache)
	return ..()

/datum/component/writing/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(handle_overlays))
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_attack_self))

/datum/component/writing/UnregisterFromParent()
	if(isitem(parent))
		UnregisterSignal(parent, COMSIG_ITEM_ATTACK_SELF)
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_UPDATE_OVERLAYS))

/datum/component/writing/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!in_range(user, parent) && !isobserver(user))
		examine_list += span_warning("You're too far away to read it!")
		return

	if(!braille && user.is_blind())
		to_chat(user, span_warning("You are blind and can't read anything!"))
		return

	if(user.can_read(parent))
		INVOKE_ASYNC(src, PROC_REF(ui_interact), user)
		return
	examine_list += span_warning("You cannot read it!")

/// Handles attackby interaction
/datum/component/writing/proc/on_attackby(datum/source, obj/item/attacking_item, mob/user, params)
	SIGNAL_HANDLER

	var/atom/parent_atom = parent

	// Handle writing items.
	var/writing_stats = istype(attacking_item) ? attacking_item.get_writing_implement_details() : null

	if(writing_stats?["interaction_mode"] == MODE_WRITING)
		if(!user.can_write(attacking_item))
			return COMPONENT_NO_AFTERATTACK
		if(get_total_length() >= MAX_PAPER_LENGTH)
			to_chat(user, span_warning("This sheet of paper is full!"))
			return COMPONENT_NO_AFTERATTACK

		INVOKE_ASYNC(src, PROC_REF(ui_interact), user)
		return COMPONENT_NO_AFTERATTACK

	// Handle stamping items.
	if(writing_stats?["interaction_mode"] == MODE_STAMPING)
		if(!user.can_read(parent_atom) || user.is_blind())
			//The paper's stampable window area is assumed approx 400x500
			add_graphic(writing_stats["stamp_class"], rand(0, 400), rand(0, 500), rand(0, 360), writing_stats["stamp_icon_state"])
			user.visible_message(span_notice("[user] blindly stamps [parent_atom] with \the [attacking_item]!"))
			to_chat(user, span_notice("You stamp [parent_atom] with \the [attacking_item] the best you can!"))
			playsound(parent_atom, 'sound/items/handling/standard_stamp.ogg', 50, vary = TRUE)
		else
			to_chat(user, span_notice("You ready your stamp over [parent_atom]! "))
			INVOKE_ASYNC(src, PROC_REF(ui_interact), user)
		return COMPONENT_NO_AFTERATTACK

	INVOKE_ASYNC(src, PROC_REF(ui_interact), user)
	return NONE

/// Handles attack self interaction
/datum/component/writing/proc/on_attack_self(datum/source, mob/user, list/modifiers)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(ui_interact), user)

/// Handles updating overlays
/datum/component/writing/proc/handle_overlays(obj/item/parent, list/overlays)
	SIGNAL_HANDLER

	var/mutable_appearance/graphic_overlay
	for(var/graphic_icon_state in graphic_cache)
		graphic_overlay = mutable_appearance('icons/obj/bureaucracy.dmi', "paper_[graphic_icon_state]")
		graphic_overlay.pixel_x = rand(-2, 2)
		graphic_overlay.pixel_y = rand(-3, 2)
		overlays += graphic_overlay

/// Returns a deep copy list of raw_text_inputs, or null if the list is empty or doesn't exist.
/datum/component/writing/proc/copy_raw_text()
	if(!LAZYLEN(raw_text_inputs))
		return null

	var/list/datum/paper_input/copy_text = list()

	for(var/datum/paper_input/existing_input as anything in raw_text_inputs)
		copy_text += existing_input.make_copy()

	return copy_text

/// Returns a deep copy list of raw_field_input_data, or null if the list is empty or doesn't exist.
/datum/component/writing/proc/copy_field_text()
	if(!LAZYLEN(raw_field_input_data))
		return null

	var/list/datum/paper_field/copy_text = list()

	for(var/datum/paper_field/existing_input as anything in raw_field_input_data)
		copy_text += existing_input.make_copy()

	return copy_text

/// Returns a deep copy list of raw_stamp_data, or null if the list is empty or doesn't exist. Does not copy overlays or stamp_cache, only the tgui rendered stamps.
/datum/component/writing/proc/copy_raw_graphics()
	if(!LAZYLEN(raw_graphic_data))
		return null

	var/list/datum/paper_field/copy_graphics = list()

	for(var/datum/paper_graphic/existing_input as anything in raw_graphic_data)
		copy_graphics += existing_input.make_copy()

	return copy_graphics

/**
 * This proc duplicates all content to another component.
 *
 * Arguments
 * * other_text - The other component to copy to.
 * * colored - If true, the copied paper will be coloured and will inherit all colours.
 * * greyscale_override - If set to a colour string and coloured is false, it will override the default of COLOR_WEBSAFE_DARK_GRAY when copying.
 */

/datum/component/writing/proc/copy_to(datum/component/writing/other_text, colored = TRUE, greyscale_override = null)
	other_text.raw_text_inputs = copy_raw_text()
	other_text.raw_field_input_data = copy_field_text()

	if(!colored)
		var/new_color = greyscale_override || COLOR_WEBSAFE_DARK_GRAY
		for(var/datum/paper_input/text as anything in other_text.raw_text_inputs)
			text.colour = new_color

		for(var/datum/paper_field/text as anything in other_text.raw_field_input_data)
			text.field_data.colour = new_color

	other_text.input_field_count = input_field_count
	other_text.raw_graphic_data = copy_raw_graphics()
	other_text.graphic_cache = graphic_cache?.Copy()

/* This simple helper adds the supplied raw text to the paper, appending to the end of any existing contents.
 *
 * This a God proc that does not care about paper max length and expects sanity checking beforehand if you want to respect it.
 *
 * The caller is expected to handle updating icons and appearance after adding text, to allow for more efficient batch adding loops.
 * * Arguments:
 * * text - The text to append to the component.
 * * font - The font to use.
 * * color - The font color to use.
 * * bold - Whether this text should be rendered completely bold.
 */
/datum/component/writing/proc/add_raw_text(text, font, color, bold, advanced_html)
	var/new_input_datum = new /datum/paper_input(
		text,
		font,
		color,
		bold,
		advanced_html,
	)

	input_field_count += get_input_field_count(text)

	LAZYADD(raw_text_inputs, new_input_datum)

/**
 * This simple helper adds the supplied input field data to the paper.
 *
 * It will not overwrite any existing input field data by default and will early return FALSE if this scenario happens unless overwrite is
 * set properly.
 *
 * Other than that, this is a God proc that does not care about max length or out-of-range IDs and expects sanity checking beforehand if
 * you want to respect it.
 *
 * * Arguments:
 * * field_id - The ID number of the field to which this data applies.
 * * text - The text to append to the paper.
 * * font - The font to use.
 * * color - The font color to use.
 * * bold - Whether this text should be rendered completely bold.
 * * overwrite - If TRUE, will overwrite existing field ID's data if it exists.
 */
/datum/component/writing/proc/add_field_input(field_id, text, font, color, bold, signature_name, overwrite = FALSE)
	var/datum/paper_field/field_data_datum = null

	var/is_signature = ((text == "%sign") || (text == "%s"))

	var/field_text = is_signature ? signature_name : text
	var/field_font = is_signature ? SIGNATURE_FONT : font

	for(var/datum/paper_field/field_input in raw_field_input_data)
		if(field_input.field_index == field_id)
			if(!overwrite)
				return FALSE
			field_data_datum = field_input
			break

	if(!field_data_datum)
		var/new_field_input_datum = new /datum/paper_field(
			field_id,
			field_text,
			field_font,
			color,
			bold,
			is_signature,
		)
		LAZYADD(raw_field_input_data, new_field_input_datum)
		return TRUE

	var/new_input_datum = new /datum/paper_input(
		field_text,
		field_font,
		color,
		bold,
	)

	field_data_datum.field_data = new_input_datum;
	field_data_datum.is_signature = is_signature;

	return TRUE

/datum/component/writing/proc/get_input_field_count(raw_text)
	var/static/regex/field_regex = new(@"\[_+\]","g")

	var/counter = 0
	while(field_regex.Find(raw_text))
		counter++

	return counter

/**
 * This simple helper adds the supplied graphic to the paper, appending to the end of any existing graphics.
 *
 * This a God proc that does not care about graphic max count and expects sanity checking beforehand if you want to respect it.
 *
 * It does however respect the overlay limit and will not apply any overlays past the cap.
 *
 * The caller is expected to handle updating icons and appearance after adding text, to allow for more efficient batch adding loops.
 * * Arguments:
 * * graphic_class - Div class for the graphic.
 * * graphic_x - X coordinate to render the graphic in tgui.
 * * graphic_y - Y coordinate to render the graphic in tgui.
 * * rotation - Degrees of rotation for the graphic to be rendered with in tgui.
 * * graphic_icon_state - Icon state for the graphic as part of overlay rendering.
 */
/datum/component/writing/proc/add_graphic(graphic_class, graphic_x, graphic_y, rotation, graphic_icon_state)
	var/new_graphic_datum = new /datum/paper_graphic(graphic_class, graphic_x, graphic_y, rotation)
	LAZYADD(raw_graphic_data, new_graphic_datum);

	if(LAZYLEN(graphic_cache) > MAX_PAPER_GRAPHIC_OVERLAYS)
		return
	var/atom/parent_atom = parent
	LAZYADD(graphic_cache, graphic_icon_state)
	parent_atom.update_overlays()

/datum/component/writing/proc/get_total_length()
	var/total_length = 0
	for(var/datum/paper_input/entry as anything in raw_text_inputs)
		total_length += length(entry.raw_text)

	return total_length

/// Get a single string representing the text on a page
/datum/component/writing/proc/get_raw_text()
	var/paper_contents = ""
	for(var/datum/paper_input/line as anything in raw_text_inputs)
		paper_contents += line.raw_text + "/"
	return paper_contents

// TGUI stuff - allows actually seeing the paper interface

/datum/component/writing/ui_state(mob/user)
	return parent.ui_state(user)

/datum/component/writing/ui_status(mob/user, datum/ui_state/state)
	if(!in_range(user, parent) && !isobserver(user))
		return UI_CLOSE
	if(user.incapacitated(TRUE, TRUE) || (isobserver(user) && !check_rights_for(user.client, R_ADMIN)))
		return UI_UPDATE
	// Even harder to read if you're blind... unless it has braille!
	// .. or if you cannot read
	if(!braille && user.is_blind())
		to_chat(user, span_warning("You are blind and can't read anything!"))
		return UI_CLOSE
	if(!user.can_read(parent))
		return UI_CLOSE
	// Get the parent atom's UI status
	var/parent_status = parent.ui_status(user, state)
	var/atom/parent_atom = parent
	// If the paper is on an unwritable noticeboard
	if(istype(parent_atom.loc, /obj/structure/noticeboard))
		var/obj/structure/noticeboard/noticeboard = parent_atom.loc
		if(!noticeboard.allowed(user))
			parent_status = min(parent_status, UI_UPDATE)
	return parent_status

/datum/component/writing/ui_host()
	return parent.ui_host()

/datum/component/writing/ui_assets(mob/user)
	var/list/ui_asset_list = list()
	for(var/asset_type in asset_list)
		ui_asset_list += get_asset_datum(asset_type)
	return ui_asset_list

/datum/component/writing/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		var/atom/parent_atom = parent
		ui = new(user, src, "PaperSheet", parent_atom.name)
		ui.open()

/datum/component/writing/ui_static_data(mob/user)
	var/list/static_data = list()

	var/atom/parent_atom = parent

	static_data["user_name"] = user.real_name

	static_data["raw_text_input"] = list()
	for(var/datum/paper_input/text_input as anything in raw_text_inputs)
		static_data["raw_text_input"] += list(text_input.to_list())

	static_data["raw_field_input"] = list()
	for(var/datum/paper_field/field_input as anything in raw_field_input_data)
		static_data["raw_field_input"] += list(field_input.to_list())

	static_data["raw_graphic_input"] = list()
	for(var/datum/paper_graphic/graphic_input as anything in raw_graphic_data)
		static_data["raw_graphic_input"] += list(graphic_input.to_list())

	static_data["max_length"] = MAX_PAPER_LENGTH
	static_data["max_input_field_length"] = MAX_PAPER_INPUT_FIELD_LENGTH
	static_data["paper_color"] = parent_atom.color ? parent_atom.color : COLOR_WHITE
	static_data["paper_name"] = parent_atom
	static_data["paper_width"] = window_width
	static_data["paper_height"] = window_height
	static_data["paper_resizable"] = resizable

	static_data["default_pen_font"] = PEN_FONT
	static_data["default_pen_color"] = COLOR_BLACK
	static_data["signature_font"] = FOUNTAIN_PEN_FONT

	return static_data

/datum/component/writing/ui_data(mob/user)
	var/list/data = list()
	if(!isliving(user))
		return data

	var/atom/parent_atom = parent
	var/obj/item/holding = user.get_active_held_item()
	// Use a clipboard's pen, if applicable
	if(istype(parent_atom.loc, /obj/item/clipboard))
		var/obj/item/clipboard/clipboard = parent_atom.loc
		// This is just so you can still use a stamp if you're holding one. Otherwise, it'll
		// use the clipboard's pen, if applicable.
		if(!istype(holding, /obj/item/stamp) && clipboard.pen)
			holding = clipboard.pen
	data["held_item_details"] = istype(holding) ? holding.get_writing_implement_details() : null

	return data

/datum/component/writing/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	var/mob/user = ui.user

	var/atom/parent_atom = parent

	switch(action)
		if("add_stamp")
			var/obj/item/holding = user.get_active_held_item()
			var/stamp_info = holding?.get_writing_implement_details()
			if(!stamp_info || (stamp_info["interaction_mode"] != MODE_STAMPING))
				return TRUE

			var/stamp_class = stamp_info["stamp_class"];

			// If the paper is on an unwritable noticeboard, this usually shouldn't be possible.
			if(istype(parent_atom.loc, /obj/structure/noticeboard))
				var/obj/structure/noticeboard/noticeboard = parent_atom.loc
				if(!noticeboard.allowed(user))
					log_paper("[key_name(user)] tried to add stamp to [parent_atom] when it was on an unwritable noticeboard: \"[stamp_class]\"")
					return TRUE

			var/stamp_x = text2num(params["x"])
			var/stamp_y = text2num(params["y"])
			var/stamp_rotation = text2num(params["rotation"])
			var/stamp_icon_state = stamp_info["stamp_icon_state"]

			if (LAZYLEN(raw_graphic_data) >= MAX_PAPER_GRAPHICS)
				to_chat(usr, pick("You try to stamp but you miss!", "There is no where else you can stamp!"))
				return TRUE

			add_graphic(stamp_class, stamp_x, stamp_y, stamp_rotation, stamp_icon_state)
			user.visible_message(span_notice("[user] stamps [parent_atom] with \the [holding.name]!"), span_notice("You stamp [parent_atom] with \the [holding.name]!"))
			playsound(parent_atom, 'sound/items/handling/standard_stamp.ogg', 50, vary = TRUE)
			parent_atom.update_appearance()
			update_static_data_for_all_viewers()
			return TRUE
		if("add_text")
			var/paper_input = params["text"]
			var/this_input_length = length(paper_input)

			if(this_input_length == 0)
				to_chat(user, pick("Writing block strikes again!", "You forgot to write anything!"))
				return TRUE

			// If the paper is on an unwritable noticeboard, this usually shouldn't be possible.
			if(istype(parent_atom.loc, /obj/structure/noticeboard))
				var/obj/structure/noticeboard/noticeboard = parent_atom.loc
				if(!noticeboard.allowed(user))
					log_paper("[key_name(user)] tried to write to [parent_atom] when it was on an unwritable noticeboard: \"[paper_input]\"")
					return TRUE

			var/obj/item/holding = user.get_active_held_item()
			// Use a clipboard's pen, if applicable
			if(istype(parent_atom.loc, /obj/item/clipboard))
				var/obj/item/clipboard/clipboard = parent_atom.loc
				// This is just so you can still use a stamp if you're holding one. Otherwise, it'll
				// use the clipboard's pen, if applicable.
				if(!istype(holding, /obj/item/stamp) && clipboard.pen)
					holding = clipboard.pen

			// As of the time of writing, can_write outputs a message to the user so we don't have to.
			if(!user.can_write(holding))
				return TRUE

			var/current_length = get_total_length()
			var/new_length = current_length + this_input_length

			// tgui should prevent this outcome.
			if(new_length > MAX_PAPER_LENGTH)
				log_paper("[key_name(user)] tried to write to [parent_atom] when it would exceed the length limit by [new_length - MAX_PAPER_LENGTH] characters: \"[paper_input]\"")
				return TRUE

			// Safe to assume there are writing implement details as user.can_write(...) fails with an invalid writing implement.
			var/writing_implement_data = holding.get_writing_implement_details()

			add_raw_text(paper_input, writing_implement_data["font"], writing_implement_data["color"], writing_implement_data["use_bold"], check_rights_for(user?.client, R_FUN))

			log_paper("[key_name(user)] wrote to [parent_atom]: \"[paper_input]\"")
			to_chat(user, "You have added to your paper masterpiece!");

			update_static_data_for_all_viewers()
			parent_atom.update_appearance()
			return TRUE
		if("fill_input_field")
			// If the paper is on an unwritable noticeboard, this usually shouldn't be possible.
			if(istype(parent_atom.loc, /obj/structure/noticeboard))
				var/obj/structure/noticeboard/noticeboard = parent_atom.loc
				if(!noticeboard.allowed(user))
					log_paper("[key_name(user)] tried to write to the input fields of [parent_atom] when it was on an unwritable noticeboard!")
					return TRUE

			var/obj/item/holding = user.get_active_held_item()
			// Use a clipboard's pen, if applicable
			if(istype(parent_atom.loc, /obj/item/clipboard))
				var/obj/item/clipboard/clipboard = parent_atom.loc
				// This is just so you can still use a stamp if you're holding one. Otherwise, it'll
				// use the clipboard's pen, if applicable.
				if(!istype(holding, /obj/item/stamp) && clipboard.pen)
					holding = clipboard.pen

			// As of the time of writing, can_write outputs a message to the user so we don't have to.
			if(!user.can_write(holding))
				return TRUE

			// Safe to assume there are writing implement details as user.can_write(...) fails with an invalid writing implement.
			var/writing_implement_data = holding.get_writing_implement_details()
			var/list/field_data = params["field_data"]

			for(var/field_key in field_data)
				var/field_text = field_data[field_key]
				var/text_length = length(field_text)
				if(text_length > MAX_PAPER_INPUT_FIELD_LENGTH)
					log_paper("[key_name(user)] tried to write to field [field_key] with text over the max limit ([text_length] out of [MAX_PAPER_INPUT_FIELD_LENGTH]) with the following text: [field_text]")
					return TRUE
				if(text2num(field_key) >= input_field_count)
					log_paper("[key_name(user)] tried to write to invalid field [field_key] (when the paper only has [input_field_count] fields) with the following text: [field_text]")
					return TRUE

				if(!add_field_input(field_key, field_text, writing_implement_data["font"], writing_implement_data["color"], writing_implement_data["use_bold"], user.real_name))
					log_paper("[key_name(user)] tried to write to field [field_key] when it already has data, with the following text: [field_text]")

			update_static_data_for_all_viewers()
			return TRUE

/// A single instance of a saved raw input onto paper.
/datum/paper_input
	/// Raw, unsanitised, unparsed text for an input.
	var/raw_text = ""
	/// Font to draw the input with.
	var/font = ""
	/// Colour to draw the input with.
	var/colour = ""
	/// Whether to render the font bold or not.
	var/bold = FALSE
	/// Whether the creator of this input field has the R_FUN permission, thus allowing less sanitization
	var/advanced_html = FALSE

/datum/paper_input/New(_raw_text, _font, _colour, _bold, _advanced_html)
	raw_text = _raw_text
	font = _font
	colour = _colour
	bold = _bold
	advanced_html = _advanced_html

/datum/paper_input/proc/make_copy()
	return new /datum/paper_input(raw_text, font, colour, bold, advanced_html);

/datum/paper_input/proc/to_list()
	return list(
		raw_text = raw_text,
		font = font,
		color = colour,
		bold = bold,
		advanced_html = advanced_html,
	)

/// A single instance of a saved graphic on paper.
/datum/paper_graphic
	/// Asset class of the for rendering in tgui
	var/class = ""
	/// X position of graphic.
	var/graphic_x = 0
	/// Y position of stamp.
	var/graphic_y = 0
	/// Rotation of stamp in degrees. 0 to 359.
	var/rotation = 0

/datum/paper_graphic/New(_class, _graphic_x, _graphic_y, _rotation)
	class = _class
	graphic_x = _graphic_x
	graphic_y = _graphic_y
	rotation = _rotation

/datum/paper_graphic/proc/make_copy()
	return new /datum/paper_graphic(class, graphic_x, graphic_y, rotation)

/datum/paper_graphic/proc/to_list()
	return list(
		class = class,
		x = graphic_x,
		y = graphic_y,
		rotation = rotation,
	)

/// A reference to some data that replaces a modifiable input field at some given index in paper raw input parsing.
/datum/paper_field
	/// When tgui parses the raw input, if it encounters a field_index matching the nth user input field, it will disable it and replace it with the field_data.
	var/field_index = -1
	/// The data that tgui should substitute in-place of the input field when parsing.
	var/datum/paper_input/field_data = null
	/// If TRUE, requests tgui to render this field input in a more signature-y style.
	var/is_signature = FALSE

/datum/paper_field/New(_field_index, raw_text, font, colour, bold, _is_signature)
	field_index = _field_index
	field_data = new /datum/paper_input(raw_text, font, colour, bold)
	is_signature = _is_signature

/datum/paper_field/proc/make_copy()
	return new /datum/paper_field(field_index, field_data.raw_text, field_data.font, field_data.colour, field_data.bold, is_signature)

/datum/paper_field/proc/to_list()
	return list(
		field_index = field_index,
		field_data = field_data.to_list(),
		is_signature = is_signature,
	)
