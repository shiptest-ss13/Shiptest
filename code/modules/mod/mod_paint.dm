#define MODPAINT_MAX_COLOR_VALUE 1.25
#define MODPAINT_MIN_COLOR_VALUE 0
#define MODPAINT_MAX_SECTION_COLORS 2
#define MODPAINT_MIN_SECTION_COLORS 0.25
#define MODPAINT_MAX_OVERALL_COLORS 4
#define MODPAINT_MIN_OVERALL_COLORS 1.5

/obj/item/mod/paint
	name = "MOD paint kit"
	desc = "This kit will repaint your MODsuit to something unique."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "paintkit"
	var/obj/item/mod/control/editing_mod
	var/atom/movable/screen/map_view/proxy_view
	var/list/current_color

/obj/item/mod/paint/Initialize(mapload)
	. = ..()
	current_color = color_matrix_identity()

/obj/item/mod/paint/examine(mob/user)
	. = ..()
	. += span_notice("<b>Left-click</b> a MODsuit to change skin.")
	//. += span_notice("<b>Right-click</b> a MODsuit to recolor.")

/obj/item/mod/paint/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		to_chat(user,span_warning("You can't repaint the suit while it's active!"))
		return TRUE
	paint_skin(mod, user)

/*obj/item/mod/paint/pre_attack_secondary(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return .()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		balloon_alert(user, "suit is active!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(editing_mod)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	editing_mod = mod
	proxy_view = new()
	proxy_view.generate_view("color_matrix_proxy_[REF(user.client)]")

	proxy_view.appearance = editing_mod.appearance
	proxy_view.color = null
	proxy_view.display_to(user)
	ui_interact(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN*/

/obj/item/mod/paint/ui_interact(mob/user, datum/tgui/ui)
	if(!editing_mod)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MODpaint", name)
		ui.open()

/obj/item/mod/paint/ui_host()
	return editing_mod

/obj/item/mod/paint/ui_close(mob/user)
	. = ..()
	editing_mod = null
	QDEL_NULL(proxy_view)
	current_color = color_matrix_identity()

/obj/item/mod/paint/ui_status(mob/user)
	if(check_menu(editing_mod, user))
		return ..()
	return UI_CLOSE

/obj/item/mod/paint/ui_static_data(mob/user)
	var/list/data = list()
	data["mapRef"] = proxy_view.assigned_map
	return data

/obj/item/mod/paint/ui_data(mob/user)
	var/list/data = list()
	data["currentColor"] = current_color
	return data

/obj/item/mod/paint/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("transition_color")
			current_color = params["color"]
			animate(proxy_view, time = 0.5 SECONDS, color = current_color)
		if("confirm")
			if(length(current_color) != 20) //20 is the length of a matrix identity list
				return
			for(var/color_value in current_color)
				if(isnum(color_value))
					continue
				return
			var/Total_color_value = 0
			var/list/Total_colors = current_color.Copy()
			Total_colors.Cut(13, length(Total_colors)) // 13 to 20 are just a and c, dont want to count them
			var/red_value = current_color[1] + current_color[5] + current_color[9] //rr + gr + br
			var/green_value = current_color[2] + current_color[6] + current_color[10] //rg + gg + bg
			var/blue_value = current_color[3] + current_color[7] + current_color[11] //rb + gb + bb
			if(red_value > MODPAINT_MAX_SECTION_COLORS)
				to_chat(usr,span_warning("Total red too high! ([red_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)"))
				return
			else if(red_value < MODPAINT_MIN_SECTION_COLORS)
				to_chat(usr,span_warning("Total red too low! ([red_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)"))
				return
			if(green_value > MODPAINT_MAX_SECTION_COLORS)
				to_chat(usr,span_warning("Total green too high! ([green_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)"))
				return
			else if(green_value < MODPAINT_MIN_SECTION_COLORS)
				to_chat(usr,span_warning("Total green too low! ([green_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)"))
				return
			if(blue_value > MODPAINT_MAX_SECTION_COLORS)
				to_chat(usr,span_warning("Total blue too high! ([blue_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)"))
				return
			else if(blue_value < MODPAINT_MIN_SECTION_COLORS)
				to_chat(usr,span_warning("Total blue too low! ([blue_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)"))
				return
			for(var/color_value in Total_colors)
				Total_color_value += color_value
				if(color_value > MODPAINT_MAX_COLOR_VALUE)
					to_chat(usr,span_warning("One of colors too high! ([color_value*100]%/[MODPAINT_MAX_COLOR_VALUE*100]%"))
					return
				else if(color_value < MODPAINT_MIN_COLOR_VALUE)
					to_chat(usr,span_warning("One of colors too low! ([color_value*100]%/[MODPAINT_MIN_COLOR_VALUE*100]%"))
					return
			if(Total_color_value > MODPAINT_MAX_OVERALL_COLORS)
				to_chat(usr,span_warning("Total colors too high! ([Total_color_value*100]%/[MODPAINT_MAX_OVERALL_COLORS*100]%)"))
				return
			else if(Total_color_value < MODPAINT_MIN_OVERALL_COLORS)
				to_chat(usr,span_warning("Total colors too low! ([Total_color_value*100]%/[MODPAINT_MIN_OVERALL_COLORS*100]%)"))
				return
			editing_mod.set_mod_color(current_color)
			SStgui.close_uis(src)

/obj/item/mod/paint/proc/paint_skin(obj/item/mod/control/mod, mob/user)
	if(length(mod.theme.variants) <= 1)
		to_chat(user,span_warning("The suit doesnt have any alternate skins!"))
		return
	var/list/skins = list()
	for(var/mod_skin_name in mod.theme.variants)
		var/list/mod_skin = mod.theme.variants[mod_skin_name]
		skins[mod_skin] = image(icon = mod.icon, icon_state = "[mod_skin]-control")
	var/pick = show_radial_menu(user, mod, skins, custom_check = CALLBACK(src, PROC_REF(check_menu), mod, user), require_near = TRUE)
	if(!pick)
		to_chat(user,span_warning("No skin picked!"))
		return
	mod.theme.set_skin(pick)

/obj/item/mod/paint/proc/check_menu(obj/item/mod/control/mod, mob/user)
	if(user.incapacitated() || !user.is_holding(src) || !mod || mod.active || mod.activating)
		return FALSE
	return TRUE

#undef MODPAINT_MAX_COLOR_VALUE
#undef MODPAINT_MIN_COLOR_VALUE
#undef MODPAINT_MAX_SECTION_COLORS
#undef MODPAINT_MIN_SECTION_COLORS
#undef MODPAINT_MAX_OVERALL_COLORS
#undef MODPAINT_MIN_OVERALL_COLORS

/obj/item/mod/skin_applier
	name = "MOD skin applier"
	desc = "This one-use skin applier will add a skin to MODsuits of a specific type."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "skinapplier"
	var/skin = "civilian"

/obj/item/mod/skin_applier/Initialize(mapload)
	. = ..()
	name = "MOD [skin] skin applier"

/obj/item/mod/skin_applier/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		to_chat(user,span_warning("You can't repaint the suit while it's active!"))
		return TRUE
	if(!(skin in mod.theme.variants))
		to_chat(user,span_warning("Incompatible theme!"))
		return TRUE
	mod.theme.set_skin(skin)
	to_chat(user,span_notice("You apply the skin."))
	qdel(src)
	return TRUE
