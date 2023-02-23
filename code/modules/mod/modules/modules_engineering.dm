//Engineering modules for MODsuits

///Welding Protection - Makes the helmet protect from flashes and welding.
/obj/item/mod/module/welding
	name = "MOD welding protection module"
	ru_name = "модуль защиты от вспышек"
	desc = "Модуль, устанавливаемый в смотровой визор шлема и проецирующий \
		поляризованное, голографическое изображение перед глазами пользователя. Оно достаточно \
		устойчиво таким вещам, как точечная и дуговая сварка, солнечные затмения и карманные фонарики."
	icon_state = "welding"
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/welding, /obj/item/mod/module/armor_booster)
	overlay_state_inactive = "module_welding"

/obj/item/mod/module/welding/on_suit_activation()
	mod.helmet.flash_protect = FLASH_PROTECTION_WELDER

/obj/item/mod/module/welding/on_suit_deactivation(deleting = FALSE)
	if(deleting)
		return
	mod.helmet.flash_protect = initial(mod.helmet.flash_protect)

///T-Ray Scan - Scans the terrain for undertile objects.
/obj/item/mod/module/t_ray
	name = "модуль терагерцового сканера"
	desc = "Модуль, установленный в смотровой визор скафандра, позволяющий пользователю использовать импульсы терагерцового излучения \
		для эхолокации объектов под полом, в основном кабелей и труб. \
		Основное направление работы это создание атмосферы и борьба с контрабандой."
	icon_state = "tray"
	module_type = MODULE_TOGGLE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(/obj/item/mod/module/t_ray)
	cooldown_time = 0.5 SECONDS
	/// T-ray scan range.
	var/range = 4

/obj/item/mod/module/t_ray/on_active_process(delta_time)
	t_ray_scan(mod.wearer, 0.8 SECONDS, range)

///Magnetic Stability - Gives the user a slowdown but makes them negate gravity and be immune to slips.
/obj/item/mod/module/magboot
	name = "модуль магнитных ботинок"
	desc = "Это мощные электромагниты, установленные в ботинках костюма, предоставляя пользователям \
		отличное сцепление с поверхностью вне зависимости от гравитации или скользкости пола. \
		Однако базовая модель не имеет контролера для своевременного отключения при передвижении, \
		что вызывает излишнее сцепление с полом и сложности при передвижении."
	icon_state = "magnet"
	module_type = MODULE_TOGGLE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(/obj/item/mod/module/magboot, /obj/item/mod/module/atrocinator)
	cooldown_time = 0.5 SECONDS
	/// Slowdown added onto the suit.
	var/slowdown_active = 0.5

/obj/item/mod/module/magboot/on_activation()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(mod.wearer, TRAIT_NOSLIPWATER, MOD_TRAIT)
	mod.slowdown += slowdown_active
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/magboot/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(mod.wearer, TRAIT_NOSLIPWATER, MOD_TRAIT)
	mod.slowdown -= slowdown_active
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	mod.wearer.update_equipment_speed_mods()

/obj/item/mod/module/magboot/advanced
	name = "продвинутый модуль магнитных ботинок"
	removable = FALSE
	complexity = 0
	slowdown_active = 0

///Emergency Tether - Shoots a grappling hook projectile in 0g that throws the user towards it.
/obj/item/mod/module/tether
	name = "модуль аварийного троса"
	desc = "Изготовленный на заказ крюк для захвата, приводимый в действие лебёдкой, способной поднимать пользователя. \
		Хотя некоторые старые модели грузоориентированных тросов имеют вместимость в несколько тонн, \
		они способны работать только в условиях нулевой гравитации. Благословение для некоторых инженеров."
	icon_state = "tether"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/tether)
	cooldown_time = 1.5 SECONDS

/obj/item/mod/module/tether/on_use()
	if(mod.wearer.has_gravity(get_turf(src)))
		balloon_alert(mod.wearer, "Гравитация мешает!")
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 25, TRUE)
		return FALSE
	return ..()

/obj/item/mod/module/tether/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/obj/projectile/tether = new /obj/projectile/tether(mod.wearer.loc)
	tether.preparePixelProjectile(target, mod.wearer)
	tether.firer = mod.wearer
	playsound(src, 'sound/weapons/batonextend.ogg', 25, TRUE)
	INVOKE_ASYNC(tether, /obj/projectile.proc/fire)
	drain_power(use_power_cost)

/obj/projectile/tether
	name = "tether"
	icon_state = "tether_projectile"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	damage = 0
	nodamage = TRUE
	range = 10
	hitsound = 'sound/weapons/batonextend.ogg'
	hitsound_wall = 'sound/weapons/batonextend.ogg'
	suppressed = SUPPRESSED_VERY
	//hit_threshhold = LATTICE_LAYER
	/// Reference to the beam following the projectile.
	var/line

/obj/projectile/tether/fire(setAngle)
	if(firer)
		line = firer.Beam(src, "line", 'icons/obj/clothing/modsuit/mod_modules.dmi')
	..()

/obj/projectile/tether/on_hit(atom/target)
	. = ..()
	if(firer)
		firer.throw_at(target, 10, 1, firer, FALSE, FALSE, null, MOVE_FORCE_NORMAL, TRUE)

/obj/projectile/tether/Destroy()
	QDEL_NULL(line)
	return ..()

///Radiation Protection - Protects the user from radiation, gives them a geiger counter and rad info in the panel.
/obj/item/mod/module/rad_protection
	name = "модуль радиационной защиты"
	desc = "Модуль использующий отражающие полимеры для защиты пользователя от ионизирующего излучения, \
		весьма распространенной угрозы в космическом вакууме." 
	// Поставляется с программным обеспечением, чтобы уведомить пользователя, что они находятся в радиоактивной области,
	//давая голос безмолвному убийце.
	icon_state = "radshield"
	complexity = 2
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/rad_protection)
	tgui_id = "rad_counter"
	var/current_tick_amount = 0
	var/radiation_count = 0
	//var/grace = RAD_GEIGER_GRACE_PERIOD
	var/datum/looping_sound/geiger/soundloop

/obj/item/mod/module/rad_protection/on_suit_activation()
	soundloop = new(src, FALSE, TRUE)
	soundloop.volume = 5
	START_PROCESSING(SSobj, src)
	for(var/obj/item/part in mod.mod_parts)
		part.armor = part.armor.modifyRating(arglist(list("rad" = 100)))

/obj/item/mod/module/rad_protection/on_suit_deactivation(deleting = FALSE)
	QDEL_NULL(soundloop)
	STOP_PROCESSING(SSobj, src)
	for(var/obj/item/part in mod.mod_parts)
		part.armor = part.armor.modifyRating(arglist(list("rad" = -100)))

/*obj/item/mod/module/rad_protection/process(delta_time)
	radiation_count = LPFILTER(radiation_count, current_tick_amount, delta_time, RAD_GEIGER_RC)

	if(current_tick_amount)
		grace = RAD_GEIGER_GRACE_PERIOD
	else
		grace -= delta_time
		if(grace <= 0)
			radiation_count = 0

	current_tick_amount = 0

	soundloop.last_radiation = radiation_count*/

/obj/item/mod/module/rad_protection/add_ui_data()
	. = ..()
	.["userradiated"] = mod.wearer?.radiation || FALSE
	.["usertoxins"] = mod.wearer?.getToxLoss() || 0
	.["usermaxtoxins"] = mod.wearer?.getMaxHealth() || 0
	.["threatlevel"] = radiation_count

///Constructor - Lets you build quicker and create RCD holograms.
/obj/item/mod/module/constructor
	name = "модуль строительного сканера"
	desc = "Этот модуль полностью занимает предплечье владельца, особенно вызывая проблемы \
		при переноской членов экипажа. Однако, он функционирует как \
		ультрасовременный строительный голографический сканер, содержащий \
		последние технические схемы в сочетании со встроенной памятью, чтобы ускорить постройку разрушенного окружения ."
	icon_state = "constructor"
	module_type = MODULE_USABLE
	complexity = 2
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	use_power_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/constructor, /obj/item/mod/module/quick_carry)
	cooldown_time = 11 SECONDS

/obj/item/mod/module/constructor/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_QUICK_BUILD, MOD_TRAIT)

/obj/item/mod/module/constructor/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_QUICK_BUILD, MOD_TRAIT)

/*obj/item/mod/module/constructor/on_use()
	. = ..()
	if(!.)
		return
	rcd_scan(src, fade_time = 10 SECONDS)
	drain_power(use_power_cost)*/

///Mister - Sprays water over an area.
/obj/item/mod/module/mister
	name = "модуль пульверизатора"
	desc = "Модуль, содержащий пульверизатор, способный распылять воду в области вокруг."
	icon_state = "mister"
	module_type = MODULE_ACTIVE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/reagent_containers/spray/mister
	incompatible_modules = list(/obj/item/mod/module/mister)
	cooldown_time = 0.5 SECONDS
	/// Volume of our reagent holder.
	var/volume = 500

/obj/item/mod/module/mister/Initialize(mapload)
	create_reagents(volume, OPENCONTAINER)
	return ..()

///Resin Mister - Sprays resin over an area.
/obj/item/mod/module/mister/atmos
	name = "модуль огнеборца"
	desc = "Распылитель, содержащий специальную противопожарную пену, образующую после застывания твердый биполимер, что стабилизирует температуру в помещении и быстро залатывает пробоины."
	device = /obj/item/extinguisher/mini/nozzle/mod
	volume = 250

/obj/item/mod/module/mister/atmos/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/water, volume)

/obj/item/extinguisher/mini/nozzle/mod
	name = "пожарный ствол"
	desc = "Пожарный ствол соединенный рукавом с рюкзаком огнеборца. Имеет 3 режима работы, меняющиеся при нажатии."
