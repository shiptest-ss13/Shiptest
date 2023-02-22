#define MODPAINT_MAX_COLOR_VALUE 1.25
#define MODPAINT_MIN_COLOR_VALUE 0
#define MODPAINT_MAX_SECTION_COLORS 2
#define MODPAINT_MIN_SECTION_COLORS 0.25
#define MODPAINT_MAX_OVERALL_COLORS 4
#define MODPAINT_MIN_OVERALL_COLORS 1.5

/obj/item/mod/paint
	name = "набор покраски MOD-Скафандра"
	desc = "Этот комплект перекрасит ваш скафандр во что-то уникальное."
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
	. += span_notice("<b>Левый-клик</b> на MOD-Скаф для смены вида.")
	. += span_notice("<b>Правый-клик</b> На MOD-Скаф для смены цвета.")

/obj/item/mod/paint/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		balloon_alert(user, "Скафандр активен!")
		return TRUE
	paint_skin(mod, user)

/*obj/item/mod/paint/pre_attack_secondary(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return .()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		balloon_alert(user, "Скафндр активен!")
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
			var/total_color_value = 0
			var/list/total_colors = current_color.Copy()
			total_colors.Cut(13, length(total_colors)) // 13 to 20 are just a and c, dont want to count them
			var/red_value = current_color[1] + current_color[5] + current_color[9] //rr + gr + br
			var/green_value = current_color[2] + current_color[6] + current_color[10] //rg + gg + bg
			var/blue_value = current_color[3] + current_color[7] + current_color[11] //rb + gb + bb
			if(red_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "красного слишком много! ([red_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)")
				return
			else if(red_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "красного слишком мало! ([red_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)")
				return
			if(green_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "зелёного слишком много! ([green_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)")
				return
			else if(green_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "зелёного слишком мало! ([green_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)")
				return
			if(blue_value > MODPAINT_MAX_SECTION_COLORS)
				balloon_alert(usr, "синего слишком много! ([blue_value*100]%/[MODPAINT_MAX_SECTION_COLORS*100]%)")
				return
			else if(blue_value < MODPAINT_MIN_SECTION_COLORS)
				balloon_alert(usr, "синего слишком мало! ([blue_value*100]%/[MODPAINT_MIN_SECTION_COLORS*100]%)")
				return
			for(var/color_value in total_colors)
				total_color_value += color_value
				if(color_value > MODPAINT_MAX_COLOR_VALUE)
					balloon_alert(usr, "одного цвета слишком много! ([color_value*100]%/[MODPAINT_MAX_COLOR_VALUE*100]%")
					return
				else if(color_value < MODPAINT_MIN_COLOR_VALUE)
					balloon_alert(usr, "одного цвета слишком мало! ([color_value*100]%/[MODPAINT_MIN_COLOR_VALUE*100]%")
					return
			if(total_color_value > MODPAINT_MAX_OVERALL_COLORS)
				balloon_alert(usr, "в общем цветов слишком много! ([total_color_value*100]%/[MODPAINT_MAX_OVERALL_COLORS*100]%)")
				return
			else if(total_color_value < MODPAINT_MIN_OVERALL_COLORS)
				balloon_alert(usr, "в общем цветов слишком мало! ([total_color_value*100]%/[MODPAINT_MIN_OVERALL_COLORS*100]%)")
				return
			editing_mod.set_mod_color(current_color)
			SStgui.close_uis(src)

/obj/item/mod/paint/proc/paint_skin(obj/item/mod/control/mod, mob/user)
	if(length(mod.theme.skins) <= 1)
		balloon_alert(user, "Нет альтернативных оболочек!")
		return
	var/list/skins = list()
	for(var/mod_skin in mod.theme.skins)
		skins[mod_skin] = image(icon = mod.icon, icon_state = "[mod_skin]-control")
	var/pick = show_radial_menu(user, mod, skins, custom_check = CALLBACK(src, PROC_REF(check_menu), mod, user), require_near = TRUE)
	if(!pick)
		balloon_alert(user, "Оболочка не выбрана!")
		return
	mod.set_mod_skin(pick)

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
	name = "Набор смены внешнего вида MOD-Скафандра"
	desc = "Этот модуль изменит внешний вид к костюмам определенного типа."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	icon_state = "skinapplier"
	var/skin = "civilian"
	var/compatible_theme = /datum/mod_theme

/obj/item/mod/skin_applier/Initialize(mapload)
	. = ..()
	name = "MOD [skin] смена внешнего вида"

/obj/item/mod/skin_applier/pre_attack(atom/attacked_atom, mob/living/user, params)
	if(!istype(attacked_atom, /obj/item/mod/control))
		return ..()
	var/obj/item/mod/control/mod = attacked_atom
	if(mod.active || mod.activating)
		balloon_alert(user, "Скафандр активен!")
		return TRUE
	if(!istype(mod.theme, compatible_theme))
		balloon_alert(user, "Неподходящий вид!")
		return TRUE
	mod.set_mod_skin(skin)
	balloon_alert(user, "Внешний вид изменён")
	qdel(src)
	return TRUE

/obj/item/mod/skin_applier/honkerative
	skin = "honkerative"
	compatible_theme = /datum/mod_theme/syndicate
