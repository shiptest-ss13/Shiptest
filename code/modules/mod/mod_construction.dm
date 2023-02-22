/obj/item/mod/construction
	desc = "Часть, используемая в конструкции МОД-Скафандра."
	icon = 'icons/obj/clothing/modsuit/mod_construction.dmi'
	inhand_icon_state = "rack_parts"

/obj/item/mod/construction/helmet
	name = "шлем МОД-Скафандра"
	icon_state = "helmet"

/obj/item/mod/construction/helmet/examine(mob/user)
	. = ..()
	. += span_notice("При внимательном осмотре становятся заметны порты подключения к каркасу...")

/obj/item/mod/construction/chestplate
	name = "нагрудник МОД-Скафандра"
	icon_state = "chestplate"

/obj/item/mod/construction/chestplate/examine(mob/user)
	. = ..()
	. += span_notice("При внимательном осмотре становятся заметны порты подключения к каркасу...")

/obj/item/mod/construction/gauntlets
	name = "перчатки МОД-Скафандра"
	icon_state = "gauntlets"

/obj/item/mod/construction/gauntlets/examine(mob/user)
	. = ..()
	. += span_notice("При внимательном осмотре становятся заметны порты подключения к каркасу...")

/obj/item/mod/construction/boots
	name = "ботинки МОД-Скафандра"
	icon_state = "boots"

/obj/item/mod/construction/boots/examine(mob/user)
	. = ..()
	. += span_notice("При внимательном осмотре становятся заметны порты подключения к каркасу...")

/obj/item/mod/construction/broken_core
	name = "сломанное МОД ядро"
	icon_state = "mod-core"
	desc = "Внутренний источник питания для Модульного Устройства Внешней защиты. На первый взгляд оно сломано, хотя..."

/obj/item/mod/construction/broken_core/examine(mob/user)
	. = ..()
	. += span_notice("Возможно его выйдет починить при помощи <b>отвёртки</b>...")

/obj/item/mod/construction/broken_core/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!tool.use_tool(src, user, 5 SECONDS, volume = 30))
		return
	new /obj/item/mod/core/standard(drop_location())
	qdel(src)

/obj/item/mod/construction/plating
	name = "МОД внешняя обшивка"
	desc = "Внешняя обшивка используется для отделки блока управления МОД-Скафандра."
	icon_state = "standard-plating"
	var/datum/mod_theme/theme = /datum/mod_theme

/obj/item/mod/construction/plating/Initialize(mapload)
	. = ..()
	var/datum/mod_theme/used_theme = GLOB.mod_themes[theme]
	name = "МОД [used_theme.ru_name] внешняя обшивка"
	desc = "[desc] [used_theme.desc]"
	icon_state = "[used_theme.default_skin]-plating"

/obj/item/mod/construction/plating/engineering
	theme = /datum/mod_theme/engineering

/obj/item/mod/construction/plating/atmospheric
	theme = /datum/mod_theme/atmospheric

/obj/item/mod/construction/plating/medical
	theme = /datum/mod_theme/medical

/obj/item/mod/construction/plating/security
	theme = /datum/mod_theme/security

/obj/item/mod/construction/plating/cosmohonk
	theme = /datum/mod_theme/cosmohonk

#define START_STEP "start"
#define CORE_STEP "core"
#define SCREWED_CORE_STEP "screwed_core"
#define HELMET_STEP "helmet"
#define CHESTPLATE_STEP "chestplate"
#define GAUNTLETS_STEP "gauntlets"
#define BOOTS_STEP "boots"
#define WRENCHED_ASSEMBLY_STEP "wrenched_assembly"
#define SCREWED_ASSEMBLY_STEP "screwed_assembly"

/obj/item/mod/construction/shell
	name = "Каркас МОД-Скафандра"
	icon_state = "mod-construction_start"
	desc = "Несущая рама для крепления остальных частей МОД-Скафандра. В центре заметен порт для крепления ядра."
	var/obj/item/core
	var/obj/item/helmet
	var/obj/item/chestplate
	var/obj/item/gauntlets
	var/obj/item/boots
	var/step = START_STEP

/obj/item/mod/construction/shell/examine(mob/user)
	. = ..()
	var/display_text
	switch(step)
		if(START_STEP)
			display_text = "Похоже, здесь не хватает <b>ядра</b>..."
		if(CORE_STEP)
			display_text = "Ядро выглядит <b>свободно болтающейся</b>..."
		if(SCREWED_CORE_STEP)
			display_text = "Похоже, здесь не хватает <b>шлема</b>..."
		if(HELMET_STEP)
			display_text = "Похоже, здесь не хватает <b>нагрудника</b>..."
		if(CHESTPLATE_STEP)
			display_text = "Похоже, здесь не хватает <b>перчаток</b>..."
		if(GAUNTLETS_STEP)
			display_text = "Похоже, здесь не хватает <b>ботинок</b>..."
		if(BOOTS_STEP)
			display_text = "Сборка выглядит <b>незафиксированной</b>..."
		if(WRENCHED_ASSEMBLY_STEP)
			display_text = "Сборка выглядит <b>свободно болтающейся</b>..."
		if(SCREWED_ASSEMBLY_STEP)
			display_text = "Не хватает только <b>внешней обшивки</b>..."
	. += span_notice(display_text)

/obj/item/mod/construction/shell/attackby(obj/item/part, mob/user, params)
	. = ..()
	switch(step)
		if(START_STEP)
			if(!istype(part, /obj/item/mod/core))
				return
			if(!user.transferItemToLoc(part, src))
				balloon_alert(user, "Ядро прилипло к вашей руке!")
				return
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "Ядро вставлено")
			core = part
			step = CORE_STEP
		if(CORE_STEP)
			if(part.tool_behaviour == TOOL_SCREWDRIVER) //Construct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Ядро закручено")
				step = SCREWED_CORE_STEP
			else if(part.tool_behaviour == TOOL_CROWBAR) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					core.forceMove(drop_location())
					balloon_alert(user, "Ядро извлечено")
				step = START_STEP
		if(SCREWED_CORE_STEP)
			if(istype(part, /obj/item/mod/construction/helmet)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "Шлем прилип к вашей руке!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "Шлем закреплен")
				helmet = part
				step = HELMET_STEP
			else if(part.tool_behaviour == TOOL_SCREWDRIVER) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Ядро раскручено")
					step = CORE_STEP
		if(HELMET_STEP)
			if(istype(part, /obj/item/mod/construction/chestplate)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "Нагрудник прилип к вашей руке!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "Нагрудник закреплен")
				chestplate = part
				step = CHESTPLATE_STEP
			else if(part.tool_behaviour == TOOL_CROWBAR) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					helmet.forceMove(drop_location())
					balloon_alert(user, "Шлеп извлечён")
					helmet = null
					step = SCREWED_CORE_STEP
		if(CHESTPLATE_STEP)
			if(istype(part, /obj/item/mod/construction/gauntlets)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "Перчатки прилипли к вашей руке!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "Перчатки закреплены")
				gauntlets = part
				step = GAUNTLETS_STEP
			else if(part.tool_behaviour == TOOL_CROWBAR) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					chestplate.forceMove(drop_location())
					balloon_alert(user, "Нагрудник извлечён")
					chestplate = null
					step = HELMET_STEP
		if(GAUNTLETS_STEP)
			if(istype(part, /obj/item/mod/construction/boots)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "Ботинки закреплены")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "Вы прицепили [part] к [src].")
				boots = part
				step = BOOTS_STEP
			else if(part.tool_behaviour == TOOL_CROWBAR) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					gauntlets.forceMove(drop_location())
					balloon_alert(user, "Перчатки извлечены")
					gauntlets = null
					step = CHESTPLATE_STEP
		if(BOOTS_STEP)
			if(part.tool_behaviour == TOOL_WRENCH) //Construct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Сборка зафиксирована")
					step = WRENCHED_ASSEMBLY_STEP
			else if(part.tool_behaviour == TOOL_CROWBAR) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					boots.forceMove(drop_location())
					balloon_alert(user, "Ботинки извлечены")
					boots = null
					step = GAUNTLETS_STEP
		if(WRENCHED_ASSEMBLY_STEP)
			if(part.tool_behaviour == TOOL_SCREWDRIVER) //Construct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Сборка зафиксирована")
					step = SCREWED_ASSEMBLY_STEP
			else if(part.tool_behaviour == TOOL_WRENCH) //Deconstruct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Сборка раскручена")
					step = BOOTS_STEP
		if(SCREWED_ASSEMBLY_STEP)
			if(istype(part, /obj/item/mod/construction/plating)) //Construct
				var/obj/item/mod/construction/plating/external_plating = part
				if(!user.transferItemToLoc(part, src))
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "Скафандр готов")
				var/obj/item/mod = new /obj/item/mod/control(drop_location(), external_plating.theme, null, core)
				core = null
				qdel(src)
				user.put_in_hands(mod)
			else if(part.tool_behaviour == TOOL_SCREWDRIVER) //Construct
				if(part.use_tool(src, user, 0, volume=30))
					balloon_alert(user, "Сборка раскручена")
					step = SCREWED_ASSEMBLY_STEP
	update_icon_state()

/obj/item/mod/construction/shell/update_icon_state()
	. = ..()
	icon_state = "mod-construction_[step]"

/obj/item/mod/construction/shell/Destroy()
	QDEL_NULL(core)
	QDEL_NULL(helmet)
	QDEL_NULL(chestplate)
	QDEL_NULL(gauntlets)
	QDEL_NULL(boots)
	return ..()

/obj/item/mod/construction/shell/handle_atom_del(atom/deleted_atom)
	if(deleted_atom == core)
		core = null
	if(deleted_atom == helmet)
		helmet = null
	if(deleted_atom == chestplate)
		chestplate = null
	if(deleted_atom == gauntlets)
		gauntlets = null
	if(deleted_atom == boots)
		boots = null
	return ..()

#undef START_STEP
#undef CORE_STEP
#undef SCREWED_CORE_STEP
#undef HELMET_STEP
#undef CHESTPLATE_STEP
#undef GAUNTLETS_STEP
#undef BOOTS_STEP
#undef WRENCHED_ASSEMBLY_STEP
#undef SCREWED_ASSEMBLY_STEP
