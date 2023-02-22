/// Global proc that sets up all MOD themes as singletons in a list and returns it.
/proc/setup_mod_themes()
	. = list()
	for(var/path in typesof(/datum/mod_theme))
		var/datum/mod_theme/new_theme = new path()
		.[path] = new_theme

/// MODsuit theme, instanced once and then used by MODsuits to grab various statistics.
/datum/mod_theme
	/// Theme name for the MOD.
	var/name = "standard"
	var/ru_name = "стандартный"
	/// Description added to the MOD.
	var/desc = "Гражданский скафандр от Накамура Инженеринг, не обладает никакими особенным свойствами, кроме немного более быстрой скорости передвижения."
	/// Extended description on examine_more
	var/extended_desc = "Скафандр гражданского класса третьего поколения от Накамура Инженеринг, \
		этот скафандр является основной рабочей лошадкой по всей галактике в гражданском секторе. \
		Эти скафандры предоставляют полную изоляцию от окружающей среды, \
		адаптированы для работы в космосе, устойчивы к огню и химическим угрозам, и защищают \
		от вирусов и биологического оружия. Тем не менее, их боевое применение крайне не эффективно из-за слабой брони. \
		Их сервоприводы способны выдать лишь немного большей скорости, чем их промышленные аналоги."
	/// Default skin of the MOD.
	var/default_skin = "standard"
	/// The slot this mod theme fits on
	var/slot_flags = ITEM_SLOT_BACK
	/// Armor shared across the MOD parts.
	var/armor = list("melee" = 10, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 100, "fire" = 25, "acid" = 25)
	/// Resistance flags shared across the MOD parts.
	var/resistance_flags = NONE
	/// Atom flags shared across the MOD parts.
	var/atom_flags = NONE
	/// Max heat protection shared across the MOD parts.
	var/max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	/// Max cold protection shared across the MOD parts.
	var/min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	/// Siemens shared across the MOD parts.
	var/siemens_coefficient = 0.5
	/// How much modules can the MOD carry without malfunctioning.
	var/complexity_max = DEFAULT_MAX_COMPLEXITY
	/// How much battery power the MOD uses by just being on
	var/charge_drain = DEFAULT_CHARGE_DRAIN
	/// Slowdown of the MOD when not active.
	var/slowdown_inactive = 1.25
	/// Slowdown of the MOD when active.
	var/slowdown_active = 0.75
	/// Theme used by the MOD TGUI.
	var/ui_theme = "ntos"
	/// List of inbuilt modules. These are different from the pre-equipped suits, you should mainly use these for unremovable modules with 0 complexity.
	var/list/inbuilt_modules = list()
	/// Modules blacklisted from the MOD.
	var/list/module_blacklist = list()
	/// Allowed items in the chestplate's suit storage.
	var/list/allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
	)
	/// List of skins with their appropriate clothing flags.
	var/list/skins = list(
		"standard" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
		"civilian" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/engineering
	name = "engineering"
	ru_name = "инженерный"
	desc = "Инженерный МОД-Скафандр с интегрированной защитой от электричества и повышенной термостойкостью. Классика Накамура Инженеринг."
	extended_desc = "Признанная классика Накамура Инженеринг и их заслуженный повод для гордости. Эта модель является \
		переосмыслением довоенных прототипов первого поколения, с множеством возможностей. \
		Модульная гибкость базовой конструкции сочетается с ударо-гасящим внутренним слоем и \
		электро-защищенным внешним слоем, что делает скафандр практически неуязвимым против экстремально высокого напряжения. \
		Однако рамки для модификации остаются такими же, как и в случае гражданских скафандров."
	default_skin = "engineering"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 10, "bio" = 100, "fire" = 100, "acid" = 25)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 1.5
	slowdown_active = 1
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/construction/rcd,
		/obj/item/storage/bag/construction,
	)
	skins = list(
		"engineering" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/atmospheric
	name = "atmospheric"
	ru_name = "атмосферный"
	desc = "Атмосферостойкий скафандр от Накамура Инженеринг, предлагающий экстремальную термостойкость по сравнению с инженерным скафандром."
	extended_desc = "Модифицированная версия инженерной модели от Накамура Инженеринг. \
		Эта модель дополнена новейшими термостойкими сплавами, в сочетании с продвинутыми теплоотводами. \
		Кроме того, материалы, использованные для создания этого скафандра, сделали его чрезвычайно стойким в отношении \
		едких газов и жидкостей. \
		Однако рамки для модификации остаются такими же, как и в случае гражданских скафандров."
	default_skin = "atmospheric"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 15, "bomb" = 10, "bio" = 100, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	slowdown_inactive = 1.5
	slowdown_active = 1
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/analyzer,
		/obj/item/t_scanner,
		/obj/item/pipe_dispenser,
	)
	skins = list(
		"atmospheric" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/advanced
	name = "advanced"
	ru_name = "продвинутый инженерный"
	desc = "Усовершенствованная версия классического скафандра Накамура Инженеринг, покрытая глянцево-белым керамическим огнестойким покрытием."
	extended_desc = "Флагманская версия промышленной линейки от Накамура Инженеринг, и их новейший продукт. \
		Вобрав в себя все лучшие особенности от предыдущих моделей, этот образец так же демонстрирует отличные показатели взрывостойкости, \
		сравнимые с военными образцами. Все это достигается благодаря уникальному белому керамическому лаку, рецепт которого является корпоративной тайной. \
		Это покрытие почти полностью невосприимчиво к коррозии, и, без сомнения, выглядит чертовски круто. \
		Поставляются с предустановленными магнитными ботинками, использующими новейший контролер, что включает и отключает магнитное притяжение только в нужные моменты, тем самым не замедляя владельца."
	default_skin = "advanced"
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 15, "bomb" = 50, "bio" = 100, "fire" = 100, "acid" = 90)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 1
	slowdown_active = 0.5
	inbuilt_modules = list(/obj/item/mod/module/magboot/advanced)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/analyzer,
		/obj/item/t_scanner,
		/obj/item/pipe_dispenser,
		/obj/item/construction/rcd,
		/obj/item/storage/bag/construction,
		/obj/item/melee/classic_baton/telescopic,
	)
	skins = list(
		"advanced" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/mining
	name = "mining"
	ru_name = "шахтёрский"
	desc = "Шахтерская модель скафандра НаноТрейзен. Предоставляет высокую защиту от пылевых бурь и окружающей среды."
	extended_desc = "Высокоэффективный скафандр, разработанный НаноТрейзен на основании наработок Накамура Инженеринг. \
		Несмотря на то, что первоначальные проекты были разработаны для суровых условий добычи астероидов, с встроенными взрывостойкими керамическими пластинами, \
		шахтёрские команды сильно изменили сами скафандры при помощи устройств, полученных от \
		деструктивного анализа неизвестных технологий предтеч, обнаруженных на месте раскопок Лаваленда. \
		Результат превзошел ожидания. Визор был модернизирован системой из семи паукообразных камер, \
		предоставляя пользователю обзор превышающий 270 градусов. Броня была практически полностью демонтирована \
		в пользу гораздо большей приспособленности к экологическим опасностям, чем для борьбы с фауной, однако, \
		это открыло невероятные возможности для защиты от коррозии и термальной защиты, достаточно хорошей для \
		как для скатывания с горок из раскаленной магмы, так и романтических прогулок по промороженной арктической местности. \
		Полноценно раскрыть свои аномальные свойства этот скафандр может путем \
		распределения и склеивания пепла по всей поверхности костюма. Эти слои пепла аблативны и невероятно стойки. \
		Наконец, скафандр способен сжимать и уменьшать массу владельца, а также \
		перестроить свою собственную конструкцию, приняв форму сферы, которая может \
		стать вдвое меньше по сравнению с обычными размерами скафандра. При таком способе передвижения пользователь оставляет за собой след из шлака \
		Тем не менее, всё это создает слишком высокую нагрузку для стандартных батарей НаноТрейзен, \
		и в угоду конструктивных особенностей и автономности было принято решение перевести питание скафандра на твердую плазму. \
		Кроме того, все системы были приведены в состояние, близкое к максимальной нагрузке, что значительно уменьшило возможности для модернизации."
	default_skin = "mining"
	armor = list("melee" = 15, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 30, "bio" = 100, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF|LAVA_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	charge_drain = DEFAULT_CHARGE_DRAIN * 2
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/resonator,
		/obj/item/mining_scanner,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/pickaxe,
		/obj/item/kinetic_crusher,
		/obj/item/stack/ore/plasma,
		/obj/item/storage/bag/ore,
	)
	inbuilt_modules = list(/obj/item/mod/module/ash_accretion, /obj/item/mod/module/sphere_transform)
	skins = list(
		"mining" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
		"asteroid" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/loader
	name = "loader"
	ru_name = "грузовой"
	desc = "Негерметичный экспериментальный экзоскелет разработанный компанией Скарборс Армс для оперативного снабжения боевых экзокостюмов боеприпасами на поле боя."
	extended_desc = "ЭЭтот экзоскелет является экспериментальным ответвлением устаревших, инженерных экзоскелетов не замкнутого цикла. \
		Изначально разрабатывался для оперативного снабжения боевых экзокостюмов боеприпасами на поле боя. \
		Из серьезных недостатков можно признать полное отсутствие защиты от окружающей среды и космоса, однако это компенсируется хорошей защитой и адаптивностью конструкции. Главная особенность \
		этого экзоскелета - два манипулятора, синхронизированных с мыслями пользователя и \
		дублирующих его движения. Такой результат достигается благодаря синтетическим мышцам, управляемых контролером. \
		К недостаткам синтетических мышц можно отнести высокое энергопотребление и энергетические пробои возникающие в шквале искр при чрезмерной нагрузке. \
		Экзоскелет способен поднять до 250 тонн. Сервоприводы опорных конечностей так же способны выдержать огромные нагрузки без потери производительности. \
		Пользователь может работать на больших скоростях гораздо дольше, чем прочие аналоги. \
		Многие скажут, что погрузка груза - скучная работа. Эта модель разубедит вас в этом."
	default_skin = "loader"
	armor = list("melee" = 15, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 10, "fire" = 25, "acid" = 25)
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	siemens_coefficient = 0.25
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	slowdown_inactive = 0.5
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/paper
	)
	inbuilt_modules = list(/obj/item/mod/module/hydraulic, /obj/item/mod/module/clamp/loader, /obj/item/mod/module/magnet)
	skins = list(
		"loader" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
			),
			GAUNTLETS_FLAGS = list(
				SEALED_CLOTHING = THICKMATERIAL,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				SEALED_CLOTHING = THICKMATERIAL,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/medical
	name = "medical"
	ru_name = "медицинский"
	desc = "Легкий скафандр от ДеФорест Мед Корп, с облегченным каркасом и модернизированной двигательной системой."
	extended_desc = "Легкий скафандр производства ДеФорест Мед Корп, основанный на разработках \
		Накамура Инженеринг. Новейшие технологии были использованы в этом скафандре, чтобы максимизировать защиту против \
		аллергенов, воздушных токсинов и обычныех вирусов. При разработке данного скафандра основным приоритетом являлась снижение замедления скорости перемещения. \
		Результат был достигнут благодаря мощным сервоприводам и использованию углеродного волокна в конструкции каркаса. В качестве платы пришлось поскупиться стандартными бронелистами и \
		ограничиться кислотостойкой обшивкой. Энергопотребление так же более повышено по сравнению с гражданскими образцами."
	default_skin = "medical"
	armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 100, "fire" = 60, "acid" = 75)
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	slowdown_inactive = 1
	slowdown_active = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/stack/medical,
		/obj/item/sensor_device,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
	)
	skins = list(
		"medical" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
		"corpsman" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/rescue
	name = "rescue"
	ru_name = "спасательный"
	desc = "Усовершенствованная версия медицинского скафандра ДеФорест Мед Корп, предназначенна для быстрого спасения тел из самых опасных сред."
	extended_desc = "Улучшенная, бронированная версия медицинского скафандра ДеФорест корпорации, \
		предназначен для быстрого спасения тел из самых опасных сред. Те же продвинутые ножные сервоприводы, \
		как и в базовой комплектации, дают парамедикам невероятную скорость, в дополнение к этому аналогичные сервоприводы расположены на руках скафандра, \
		позволяя пользователю быстро переносить даже самых тяжелых членов экипажа с помощью этого скафандра. \
		Предоставляет крайне высокую защиту химических и термальных угроз. \
		Он немного более требователен к мощности, чем гражданские модели."
	default_skin = "rescue"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	slowdown_inactive = 0.75
	slowdown_active = 0.25
	inbuilt_modules = list(/obj/item/mod/module/quick_carry/advanced)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/stack/medical,
		/obj/item/sensor_device,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
		/obj/item/melee/classic_baton/telescopic,
	)
	skins = list(
		"rescue" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/research
	name = "research"
	ru_name = "научный"
	desc = "Военный скафандр специального назначения от Ауссек Армори, предназначенный для работы со взрывчатыми веществами. Тяжелый и очень стойкий."
	extended_desc = "Частный военный скафандр для обезвреживания боеприпасов от Аусек Армори, основанный на работе Накамура Инжениринг. \
		Этот скафандр предназначен для работы со взрывчатыми веществами, что делает его громоздким, но отлично защищенным. \
		Обладает встроенным химическим сканирующим массивом. \
		Скафандр оснащён пласталевой композитной бронёй с промежуточным инертным слоем, \
		призванным рассеивать кинетическую энергию в костюме, отводя её от пользователя. \
		превосходит даже самые лучшие стандартные МОД-Скафандры. Однако, несмотря на свой иммунитет против \
		ракет и артиллериии, всё взрывное сопротивление в основном работает чтобы сохранить тело пользователя целым, а не живым.  \
		Пользователь также найдет узкие дверные рамы которые почти невозможно преодолеть."
	default_skin = "research"
	armor = list("melee" = 20, "bullet" = 15, "laser" = 5, "energy" = 5, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	slowdown_inactive = 1.75
	slowdown_active = 1.25
	inbuilt_modules = list(/obj/item/mod/module/reagent_scanner/advanced)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/analyzer,
		/obj/item/dnainjector,
		/obj/item/storage/bag/bio,
		/obj/item/melee/classic_baton/telescopic,
	)
	skins = list(
		"research" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/security
	name = "security"
	ru_name = "службы безопасности"
	desc = "Защитный скафандр Ападайн Технологии, обеспечивающий защиту от ударов и большую скорость ценой вместимости хранилища."
	extended_desc = "Эта модель МОД-Скафандра была разработана для быстрого реагирования на \
		враждебные единицы. Этот скафандр был создан с покрытием, достаточно прочным для пожаров или агрессивных сред, \
		и поставляется с композитной прокладкой и усовершенствованной сотовой структурой под корпусом, чтобы обеспечить защиту \
		от переломов костей или возможных повреждений. Ноги скафандра получили более прочные приводы, \
		позволяя скафандру выполнять больше работы по переноске веса. однако системы используемые в этих скафандрах устарели на несколько лет, \
		что отразилось на количестве доступных к установке модулей."
	default_skin = "security"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 100, "fire" = 75, "acid" = 75)
	complexity_max = DEFAULT_MAX_COMPLEXITY - 3
	slowdown_inactive = 1
	slowdown_active = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"security" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/safeguard
	name = "safeguard"
	ru_name = "гвардейский"
	desc = "Усовершенствованный боевой скафандр Апдайн Тек предоставляющий высокую скорость перемещения и повышенную термическую защиту, по сравнению со базовой моделью."
	extended_desc = "Новейшая разработка от Апдайн Тек в сфере скафандров повышенного класса защиты. При разработке данной модели \
		было принято решение полностью отказаться от стеклянного забрала, полностью заменив его на цифровой визор, представляющий собой \
		комплекс периферийных камер, проецирующих изображение на интегрированный экран на внутренней стороне шлема. \
		Броневое покрытие было серьезно усилено, а корпус приобрел хищные очертания. \
		Благодаря массивным радиаторам, так же исполняющим роль противоударного каркаса, скафандр отлично противодействует основным видам урона."
	default_skin = "safeguard"
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 40, "bio" = 100, "fire" = 100, "acid" = 95)
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	slowdown_inactive = 0.75
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"safeguard" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/magnate
	name = "magnate"
	ru_name = "роскошный"
	desc = "Элитарный, совершенный и невероятно прочный скафандр для высшего руководящего состава компании НаноТрейзен. Оберегает владельца от огня, кислоты и поражения электрическим током."
	extended_desc = "Вам придется заплатить четыреста тысяч кредитов, чтобы только примерить этот скафандр... на двенадцать секунд... \
		Его главное предназначение - это быть прямым доказательством превосходства его владельца над окружающими его плебеями. \
		Интеллектуальная система климат контроля способна синтезировать более 500 ароматов, для удовлетворения самых изысканных пользователей. \
		Настоящий аристократ с чернью одним воздухом не дышит. На левой перчатке исполнены часы Тралекс ручной работы, \
		а внутренняя подкладка обшита роскошным мехом исчезнувших животных. \
		Корпус инкрустирован редкоземельными металлами, драгоценными камнями и даже гранитной отделкой. Многослойная поляризованная броня \
		защищает владельца от огня, кислоты и поражения электрическим током. Бортовые системы используют метапозитронное обучение \
		и блюспейс изометрию для увеличения спектра бортовых модулей. Ходовая система способна выдержать вес штурмового киборга при сравнимой с ним скорости.\
		Предложение не является офертой. Конечный продукт может отличаться от представленного в каталоге. Любое сходство с Горлекскими Марадерами является совпадением."
	default_skin = "magnate"
	armor = list("melee" = 20, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 50, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	slowdown_inactive = 0.75
	slowdown_active = 0.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"magnate" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/cosmohonk
	name = "cosmohonk"
	ru_name = "комедийный"
	desc = "Скафандр от Хонк Корп. Защищает носителя от плоского юмора. Большая часть инноваций направлена на снижение энергопотребления."
	extended_desc = "Космохонк МОД-Скафандр был первоначально разработан для межзвездной комедии в условиях низкого юмора. \
		Он использует вольфрам электро-керамический корпус и двухполюсный хром, покрытый циркониевой-бор краской под \
		подпространственный сплав Дерматилериан. Несмотря на ярко выраженные оптронные педали вакуумного привода, \
		эта конкретная модель не использует марганцевые биполярные конденсаторные чистящие средства, спасибо Хонкоматере. \
		Все, что вы знаете, это то, что этот скафандр таинственно эффективен и слишком красочен для Мима, чтобы его красть."
	default_skin = "cosmohonk"
	armor = list("melee" = 5, "bullet" = 5, "laser" = 20, "energy" = 20, "bomb" = 10, "bio" = 100, "fire" = 60, "acid" = 30)
	charge_drain = DEFAULT_CHARGE_DRAIN * 0.25
	slowdown_inactive = 1.75
	slowdown_active = 1.25
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/bikehorn,
		/obj/item/reagent_containers/food/snacks/grown/banana,
		/obj/item/reagent_containers/food/snacks/grown/banana/bluespace,
		/obj/item/grown/bananapeel,
		/obj/item/reagent_containers/spray/waterflower,
		/obj/item/instrument,
	)
	skins = list(
		"cosmohonk" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/syndicate
	name = "syndicate"
	ru_name = "синдикатовский"
	desc = "Скафандр, разработанный Марадёрами Горлекса, предлагающим броню, запрещенную в большинстве мест спиральной галактики."
	extended_desc = "Боевой скафандр, выполненный в кроваво-красных тонах. Один только внешний вид способен вызвать оторопь у рядового сотрудника станции. \
		Спроектирован и изготовлен для специальных военных операций в тылу врага, а внутренний подбой усилен кевларом и противоударным слоем дюраткани. \
		Основное бронирование представлено в виде многослойного композита керамо-пласталевых бронепластин, \
		Таким образом достигается максимальный показатель бронирования без потери мобильности. \
		Экспериментальный аблазивный щит, запитанный от бортового питания, практически полностью нивелирует угрозу со стороны энергетического оружия. \
		Рядом с главным ядром закреплена металлическая табличка. Строгий текст, выгравированный на ней гласит: 'Изготовлено Мародерами Горлекса при содействии Киберсан Индастри' \
		Все права защищены, фальсификация скафандра аннулирует гарантию.'"
	default_skin = "syndicate"
	armor = list("melee" = 15, "bullet" = 20, "laser" = 15, "energy" = 15, "bomb" = 35, "bio" = 100, "fire" = 50, "acid" = 90)
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 1
	slowdown_active = 0.5
	ui_theme = "syndicate"
	inbuilt_modules = list(/obj/item/mod/module/armor_booster)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/transforming/energy/sword, //Энергомечи тоже найти надо
		/obj/item/shield/energy,
	)
	skins = list(
		"syndicate" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
		"honkerative" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/elite
	name = "elite"
	ru_name = "элитный"
	desc = "Офицерская версия стандартного боевого скафандра Мародеров Горлекса."
	extended_desc = "Дальнейшая эволюция стандартного боевого скафандра Синдиката. Внешний вид претерпел серьезные отличия - он стал матово черным и еще более угрожающе-хищным. \
		Этот скафандр производится только для высокопоставленных офицеров Синдиката и элитных ударных групп. \
		Все броневые листы были продублированы, уязвимые места перекрыты. \
		Поверхность покрыта поляризированным аблазивным лаком, предоставляющим исключительную защиту от огня и кислоты. \
		Рядом с главным ядром закреплена металлическая табличка. Строгий текст, выгравированный на ней гласит: 'Изготовлено Мародерами Горлекса при содействии Киберсан Индастри' \
		Все права защищены, вмешательство в работу скафандра аннулирует продолжительность жизни.'"
	default_skin = "elite"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 35, "energy" = 35, "bomb" = 55, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 1
	slowdown_active = 0.5
	ui_theme = "syndicate"
	inbuilt_modules = list(/obj/item/mod/module/armor_booster)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/transforming/energy/sword,
		/obj/item/shield/energy,
	)
	skins = list(
		"elite" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/enchanted
	name = "enchanted"
	ru_name = "зачарованный"
	desc = "Относительно низкотехнологичный МОД-Скафандр Федерации Волшебников. Очень защищённый, хотя..."
	extended_desc = "Магически адаптированный МОД-Скафандр Федерации Волшебников. В этой броне не используется \
		банальная пласталь или какое-то там углеродное волокно - что за примитивизм. Настоящий Маг облачится только в шкуру космического дракона. \
		Неофиты обязаны достать материал для его изготовления лично, \
		те же из преуспевших (если уж говорить на чистоту - выживших), еще долго будут по праву будут гордиться новым приобритением. \
		Коллегиальным решением именитых артефакторов убожество, называемое источником питания, \
		было заменено на небольшую сверхновую, помещенную в блюспейс аномалию. \
		Инкрустация из магических кристаллов, зачарованных материалов и кожи экзотических химер сделали этот скафандр отличным артефактом, \
		защищающим от большинства известных угроз как то: горение в пламени дракона, поедание заживо кислотной мухоловкой или же расстрел эскадроном смерти."
	default_skin = "enchanted"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 35, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY - 5
	slowdown_inactive = 0.75
	slowdown_active = 0.25
	ui_theme = "wizard"
	inbuilt_modules = list(/obj/item/mod/module/anti_magic/wizard)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/teleportation_scroll,
		/obj/item/vibro_weapon,
		/obj/item/gun/magic,
	)
	skins = list(
		"enchanted" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL|CASTING_CLOTHES,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL|CASTING_CLOTHES,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/ninja
	name = "ninja"
	ru_name = "ниндзя"
	desc = "Уникальный диверсионный скафандр из нанополимера, используемый убийцами Клана Паука."
	extended_desc = "Уникальный диверсионный скафандр из нанополимера, используемый убийцами Клана Паука. \
		Изготовлен с использованием экспериментальных военных технологий в области маскировки и проникновения. \
		Благодаря нанополимеру - новейшему материалу, состоящему из структурированных наномашин на углеволоконном каркасе, этот костюм \
		способен выдержать значительные нагрузки, а микроскопические радиаторные рёбра служат отличными теплоотводниками, делая сам скафандр \
		почти невосприимчивым даже к вулканической жаре. Он полностью защищен против самых сильных кислот, \
		и миоэлектрические искусственные мышцы скафандра делают его легким, как перо во время движения."
	default_skin = "ninja"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 20, "energy" = 30, "bomb" = 30, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = LAVA_PROOF|FIRE_PROOF|ACID_PROOF
	charge_drain = DEFAULT_CHARGE_DRAIN * 0.5
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	ui_theme = "hackerman"
	inbuilt_modules = list(/obj/item/mod/module/welding/camera_vision, /obj/item/mod/module/hacker, /obj/item/mod/module/weapon_recall, /obj/item/mod/module/adrenaline_boost, /obj/item/mod/module/energy_net)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/gun,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/melee/baton,
		/obj/item/restraints/handcuffs,
	)
	skins = list(
		"ninja" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/prototype
	name = "prototype"
	ru_name = "прототип"
	desc = "Прототип модульного скафандра, работающего на больших внешних моторах. Хотя он удобен и имеет большую вместимость, но остается очень громоздким и неэффективным в плане энергопотребления."
	extended_desc = "Этот прототип экзоскелета, дизайн которого не видели сотни лет, первый модульный скафандр послевоенной эпохи, \
		который когда-либо безопасно использовался оператором. Этот древний драндулет все еще функционирует, \
		хотя в нем не хватает нескольких современных роскошных разработок Накамура Инженеринг. \
		В первую очередь, это полное отсутствие миоэлектрического слоя, а сервоприводы мало что делают для \
		облегчения веса экзоскелета, а смотровой козырёк состоит из голубых непрозрачных дисплеев \
		в зародыше убивая надежду различить что-то кроме очертаний помещения на расстоянии более 10 метров. \
		Однако, то, как шлем убирается, выглядит довольно круто."
	default_skin = "prototype"
	armor = list("melee" = 20, "bullet" = 5, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 100, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 5
	charge_drain = DEFAULT_CHARGE_DRAIN * 2
	slowdown_inactive = 2
	slowdown_active = 1.5
	ui_theme = "hackerman"
	//inbuilt_modules = list(/obj/item/mod/module/anomaly_locked/kinesis/prebuilt/prototype)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/analyzer,
		/obj/item/t_scanner,
		/obj/item/pipe_dispenser,
		/obj/item/construction/rcd,
	)
	skins = list(
		"prototype" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/responsory
	name = "responsory"
	ru_name = "ЕРТ"
	desc = "Высокоскоростной спасательный скафандр от Нанотрэйзен, предназначенный для аварийно-спасательных отрядов."
	extended_desc = "Обтекаемый скафандр от Нанотрэйзен, эти гладкие черные скафандры может носить только \
			элита аварийно-спасательных отрядов. Совмещает в себе тонкий и изящный дизайн костюма, \
			олицетворяющий прочность керамо-аблазивных бронепластин и эргономичный корпус. \
			Носитель будет надежно защищен от холодной пустоты космоса, не потеряв при этом высокую мобильность. \
		    Привнесите спасение, надежду и единственно верное корпоративное мнение."
	default_skin = "responsory"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 100, "acid" = 90)
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"responsory" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
		"inquisitory" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/apocryphal
	name = "apocryphal"
	ru_name = "апокрифический"
	desc = "Высокотехнологичный боевой скафандр, созданный совместными усилиями НаноТрейзен и Апдайн Тек."
	extended_desc = "Тяжелый боевой скафандр прорыва исполненный в зловеще черно-красной раскраске. Используется исключительно \
		Эскадроном Смерти НаноТрейзен. Обладает высокой защитой от всех видов урона, включая самые экзотичные. \
		Так же снабжен мощными боевыми средствами оповещения для его владельца и повышенной емкостью модулей. \
		Этот скафандр скорее всего последнее что вы увидите в своей жизни. \
		Кажется, на запястье есть маленькая надпись, которая гласит: \'карапузик."
	default_skin = "apocryphal"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 60, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	complexity_max = DEFAULT_MAX_COMPLEXITY + 10
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/transforming/energy/sword,
		/obj/item/shield/energy,
	)
	skins = list(
		"apocryphal" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEYES|HIDEFACE|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/corporate
	name = "corporate"
	ru_name = "корпоративный"
	desc = "Модный, высокотехнологичный скафандр для высокопоставленных офицеров НаноТрейзен."
	extended_desc = "Премиум версия скафандра для высшего командного состава НаноТрейзен. \
		Помимо стандартных излишеств от которых страдает офицерский состав, эта модель так же получила модернизацию защитных свойств. \
		Силовые приводы были так же модернизированы и при включении позволяют чувствовать себя практически невесомыми. \
		Соскребать краску с этого скафандра считается военным преступлением и причиной для немедленной казни на более чем пятидесяти космических станциях НаноТрейзен. \
		Предложение не является офертой. Конечный продукт может отличаться от представленного в каталоге. Любое сходство с Горлекскими Марадерами является совпадением."
	default_skin = "corporate"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
	)
	skins = list(
		"corporate" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEYES|HIDEFACE,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/chrono
	name = "chrono"
	ru_name = "хроно"
	desc = "Скафандр за пределами нашего времени, за пределами самого времени. Используется для пересечения временных линий и \"исправлении их курса\"."
	extended_desc = "Скафандр, чья технология выходит за рамки понимания этой эпохи. Внутренние механизмы \
		совершенно выглядят чуждыми для этой временной линии, но их цель довольно проста. Скафандр защищает пользователя от многих невероятно смертоносных \
		и чудовищно болезненных побочных эффектов скачка времени, обеспечивая оборудованием для \
		внесение изменений во линию времени для исправления ошибок."
	default_skin = "chrono"
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 30, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY - 10
	slowdown_inactive = 0
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/restraints/handcuffs,
	)
	skins = list(
		"chrono" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/debug
	name = "debug"
	ru_name = "отладочный"
	desc = "С ностальгией."
	extended_desc = "Продвинутый скафандр с двойным ионным двигателем, достаточно мощным, чтобы обеспечить гуманоида полетом. \
		Содержит внутренний самозарядный конденсатор высокого тока, мощный нас- \
		Погоди, это не скафандр для полета. Чёрт."
	default_skin = "debug"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = 50
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/gun,
	)
	skins = list(
		"debug" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)

/datum/mod_theme/administrative
	name = "administrative"
	ru_name = "административный"
	desc = "Скафандр из админиума. Кто придумал эти дурацкие названия для минералов?"
	extended_desc = "Да, ладно, думаю, это можно назвать событием. То, что я считаю событием на самом деле это \
		веселье и увлечение для игроков - вместо этого, большинство будут сидеть, мертвыми или гибнутыми, в то время как счастливчики получили \
		все удовольствие. Если это продолжит быть шаблоном для ваших  \"ивентов\" (админ абуз) \
		будет подана жалоба на снятие. Вы были предупреждены."
	default_skin = "debug"
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = INDESTRUCTIBLE|LAVA_PROOF|FIRE_PROOF|UNACIDABLE|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	complexity_max = 1000
	charge_drain = DEFAULT_CHARGE_DRAIN * 0
	siemens_coefficient = 0
	slowdown_inactive = 0
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/gun,
	)
	skins = list(
		"debug" = list(
			HELMET_FLAGS = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR|HIDESNOUT,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE|BLOCKS_SHOVE_KNOCKDOWN,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
			),
		),
	)
