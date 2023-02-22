//Visor modules for MODsuits

///Base Visor - Adds a specific HUD and traits to you.
/obj/item/mod/module/visor
	name = "модуль визора"
	desc = "В шлем скафандра встраивается дисплей."
	module_type = MODULE_TOGGLE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/visor)
	cooldown_time = 0.5 SECONDS
	/// The HUD type given by the visor.
	var/hud_type
	/// The traits given by the visor.
	var/list/visor_traits = list()

/obj/item/mod/module/visor/on_activation()
	. = ..()
	if(!.)
		return
	if(hud_type)
		var/datum/atom_hud/hud = GLOB.huds[hud_type]
		hud.add_hud_to(mod.wearer)
	for(var/trait in visor_traits)
		ADD_TRAIT(mod.wearer, trait, MOD_TRAIT)
	mod.wearer.update_sight()

/obj/item/mod/module/visor/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(hud_type)
		var/datum/atom_hud/hud = GLOB.huds[hud_type]
		hud.remove_hud_from(mod.wearer)
	for(var/trait in visor_traits)
		REMOVE_TRAIT(mod.wearer, trait, MOD_TRAIT)
	mod.wearer.update_sight()

//Medical Visor - Gives you a medical HUD.
/obj/item/mod/module/visor/medhud
	name = "модуль медицинского визора"
	desc = "Встраиваемый в шлем медицинский HUD-интерфейс позволяет пользователю визуализировать текущее состояние органических форм жизни, \
		а так же доступ к медицинским картам пациентов в удобной для считывания виде."
	icon_state = "medhud_visor"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	visor_traits = list(TRAIT_MEDICAL_HUD)

//Diagnostic Visor - Gives you a diagnostic HUD.
/obj/item/mod/module/visor/diaghud
	name = "модуль диагностирующего визора"
	desc = "Встраиваемый в шлем диагностирующий HUD-интерфейс позволяет пользователю визуализировать текущее состояние механических единиц, \
		в удобном для считывания виде"
	icon_state = "diaghud_visor"
	hud_type = DATA_HUD_DIAGNOSTIC_ADVANCED
	visor_traits = list(TRAIT_DIAGNOSTIC_HUD)

//Security Visor - Gives you a security HUD.
/obj/item/mod/module/visor/sechud
	name = "модуль визора охраны"
	desc = "Встраиваемый в шлем HUD-интерфейс службы безопасности, \
		подключеный к различным базам данных преступников, чтобы иметь возможность просматривать записи арестов, управлять простыми роботами, ориентированными на охрану, \
		и вообще знать, в кого стрелять."
	icon_state = "sechud_visor"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	visor_traits = list(TRAIT_SECURITY_HUD)

//Meson Visor - Gives you meson vision.
/obj/item/mod/module/visor/meson
	name = "MOD модуль мезонного визора"
	desc = "В шлем скафандра встраивается дисплей. Этот модуль основан на хорошо любимом мезонном сканере,\
		используемые строительными рабочими и шахтерами по всей галактике, чтобы увидеть основные структурные и ландшафтные виды \
		через стены, независимо от условий освещения."
	icon_state = "meson_visor"
	visor_traits = list(SEE_TURFS)

//Thermal Visor - Gives you thermal vision.
/obj/item/mod/module/visor/thermal
	name = "MOD модуль термального визора"
	desc = "В шлем скафандра встраивается дисплей. Для этого используется небольшой ИК-сканер для обнаружения и идентификации \
		вывода теплового излучения объектов вблизи пользователя. Хотя он может обнаружить тепловую отдачу даже чего-то \
		небольшого, такого как крыса, он все еще создаёт раздражающее красное наложение. Говорят, он также позволяет видеть сзади."
	icon_state = "thermal_visor"
	visor_traits = list(SEE_MOBS)

//Night Visor - Gives you night vision.
/obj/item/mod/module/visor/night
	name = "MOD модуль ночного зрения"
	desc = "В шлем скафандра встраивается дисплей. Типичный для гражданского и военного применения, \
		он позволяет пользователю видеть окружение в полной тьме, увеличивая освещение в десять раз. \
		И всё это превращается в жуткое зелёное свечение. Говорят, он также позволяет видеть сзади. \
		Помехи странного характера в данном секторе вызвали критический сбой во всех модулях ПНВ, \
		в следствие чего, модули не имеют никакого эффекта на восприятие."
	icon_state = "night_visor"
	//visor_traits = list(TRAIT_TRUE_NIGHT_VISION)
