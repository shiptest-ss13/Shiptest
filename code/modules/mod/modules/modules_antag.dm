//Antag modules for MODsuits

///Armor Booster - Grants your suit more armor and speed in exchange for EVA protection. Also acts as a welding screen.
/obj/item/mod/module/armor_booster
	name = "модуль усилителя брони"
	desc = "Модифицированная серия выдвижных бронепластин, позволяющая костюму функционировать как, будто это силовая броня, \
		предоставляя пользователю невероятную защиту от обычного огнестрельного оружия или частых атак в ближнем бою. \
		Однако, дополнительная броня не может развертываться вместе с частями костюма, используемыми для вакуумного уплотнения, \
		Таким образом, эта дополнительная броня обеспечивает нулевую способность для внеатмосферной деятельности."
	icon_state = "armor_booster"
	module_type = MODULE_TOGGLE
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	removable = TRUE
	incompatible_modules = list(/obj/item/mod/module/armor_booster, /obj/item/mod/module/welding)
	cooldown_time = 0.5 SECONDS
	overlay_state_inactive = "module_armorbooster_off"
	overlay_state_active = "module_armorbooster_on"
	use_mod_colors = TRUE
	/// Whether or not this module removes pressure protection.
	var/remove_pressure_protection = TRUE
	/// Speed added to the control unit.
	var/speed_added = 0.5
	/// Speed that we actually added.
	var/actual_speed_added = 0
	/// Armor values added to the suit parts.
	var/list/armor_values = list("melee" = 25, "bullet" = 30, "laser" = 15, "energy" = 15)
	/// List of parts of the suit that are spaceproofed, for giving them back the pressure protection.
	var/list/spaceproofed = list()

/obj/item/mod/module/armor_booster/on_suit_activation()
	mod.helmet.flash_protect = FLASH_PROTECTION_WELDER

/obj/item/mod/module/armor_booster/on_suit_deactivation(deleting = FALSE)
	if(deleting)
		return
	mod.helmet.flash_protect = initial(mod.helmet.flash_protect)

/obj/item/mod/module/armor_booster/on_activation()
	. = ..()
	if(!.)
		return
	playsound(src, 'sound/mecha/mechmove03.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	actual_speed_added = max(0, min(mod.slowdown_active, speed_added))
	mod.slowdown -= actual_speed_added
	mod.wearer.update_equipment_speed_mods()
	var/list/parts = mod.mod_parts + mod
	for(var/obj/item/part as anything in parts)
		part.armor = part.armor.modifyRating(arglist(armor_values))
		if(!remove_pressure_protection || !isclothing(part))
			continue
		var/obj/item/clothing/clothing_part = part
		if(clothing_part.clothing_flags & STOPSPRESSUREDAMAGE)
			clothing_part.clothing_flags &= ~STOPSPRESSUREDAMAGE
			spaceproofed[clothing_part] = TRUE

/obj/item/mod/module/armor_booster/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(!deleting)
		playsound(src, 'sound/mecha/mechmove03.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	mod.slowdown += actual_speed_added
	mod.wearer.update_equipment_speed_mods()
	var/list/parts = mod.mod_parts + mod
	var/list/removed_armor = armor_values.Copy()
	for(var/armor_type in removed_armor)
		removed_armor[armor_type] = -removed_armor[armor_type]
	for(var/obj/item/part as anything in parts)
		part.armor = part.armor.modifyRating(arglist(removed_armor))
		if(!remove_pressure_protection || !isclothing(part))
			continue
		var/obj/item/clothing/clothing_part = part
		if(spaceproofed[clothing_part])
			clothing_part.clothing_flags |= STOPSPRESSUREDAMAGE
	spaceproofed = list()

/obj/item/mod/module/armor_booster/generate_worn_overlay(mutable_appearance/standing)
	overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	overlay_state_active = "[initial(overlay_state_active)]-[mod.skin]"
	return ..()

///Energy Shield - Gives you a rechargeable energy shield that nullifies attacks.
/obj/item/mod/module/energy_shield
	name = "модуль силового щита"
	desc = "Личное защитное силовое поле, обычно используемое в военных целях. \
		Этот продвинутый дефлекторный щит, по сути, является уменьшенной версией тех, какие были установленны на кораблях, \
		о чём говорит их потребление электроэнергии. Однако, он способен блокировать практически любую атаку, \
		впрочем из-за низкого числа зарядов, пользователь всё ещё остаётся смертным."
	icon_state = "energy_shield"
	complexity = 3
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	use_power_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/energy_shield)
	/// Max charges of the shield.
	var/max_charges = 3
	/// The time it takes for the first charge to recover.
	var/recharge_start_delay = 20 SECONDS
	/// How much time it takes for charges to recover after they started recharging.
	var/charge_increment_delay = 1 SECONDS
	/// How much charge is recovered per recovery.
	var/charge_recovery = 1
	/// Whether or not this shield can lose multiple charges.
	var/lose_multiple_charges = FALSE
	/// The item path to recharge this shielkd.
	var/recharge_path = null
	/// The icon file of the shield.
	var/shield_icon_file = 'icons/effects/effects.dmi'
	/// The icon_state of the shield.
	var/shield_icon = "shield-red"
	/// Charges the shield should start with.
	var/charges

/obj/item/mod/module/energy_shield/Initialize(mapload)
	. = ..()
	charges = max_charges

/obj/item/mod/module/energy_shield/on_suit_activation()
	mod.AddComponent(/datum/component/shielded, max_charges = max_charges, recharge_start_delay = recharge_start_delay, charge_increment_delay = charge_increment_delay, \
	charge_recovery = charge_recovery, lose_multiple_charges = lose_multiple_charges, recharge_path = recharge_path, starting_charges = charges, shield_icon_file = shield_icon_file, shield_icon = shield_icon)
	RegisterSignal(mod.wearer, COMSIG_HUMAN_CHECK_SHIELDS, PROC_REF(shield_reaction))

/obj/item/mod/module/energy_shield/on_suit_deactivation(deleting = FALSE)
	var/datum/component/shielded/shield = mod.GetComponent(/datum/component/shielded)
	charges = shield.current_charges
	qdel(shield)
	UnregisterSignal(mod.wearer, COMSIG_HUMAN_CHECK_SHIELDS)

/obj/item/mod/module/energy_shield/proc/shield_reaction(mob/living/carbon/human/owner, atom/movable/hitby, damage = 0, attack_text = "the attack", attack_type = MELEE_ATTACK, armour_penetration = 0)
	if(SEND_SIGNAL(mod, COMSIG_ITEM_HIT_REACT, owner, hitby, attack_text, 0, damage, attack_type) & COMPONENT_HIT_REACTION_BLOCK)
		drain_power(use_power_cost)
		return SHIELD_BLOCK
	return NONE

/obj/item/mod/module/energy_shield/wizard
	name = "силовой щит боевого мага"
	desc = "Заклинатель, владеющий этим заклинанием, получает видимый барьер вокруг себя, направляя магическую силу через \
		специализированные руны, выгравированные на поверхности костюма, что создают силовой щит. \
		Этот щит может полностью нейтрализовать урон от крупнокалиберных винтовок до волшебных стрел, \
		хотя может также быть истощён более простыми нападениями. Однако он не способен защитить вас от насмешек окружающих."
	icon_state = "battlemage_shield"
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0 //magic
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0 //magic too
	max_charges = 15
	recharge_start_delay = 0 SECONDS
	charge_recovery = 8
	shield_icon_file = 'icons/effects/magic.dmi'
	shield_icon = "mageshield"
	recharge_path = /obj/item/wizard_armour_charge

///Magic Nullifier - Protects you from magic.
/obj/item/mod/module/anti_magic
	name = "модуль анти-магии"
	desc = "Комплексное защитное покрытие из алюминиевой фольги и установленных в критических точках по периметру костюма обсидиановых стержней, \
		резонирующих на низкой частоте. Это создает высоконасыщенное анти-магическое поле вокруг пользователя. Используя святую воду как хладоген. \
		Это гарантированно нейтрализует любую магию даже ни смотря на то, что признанные эксперты НаноТрейзен утверждают, что магии не существует."
	icon_state = "magic_nullifier"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/anti_magic)

/obj/item/mod/module/anti_magic/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_HOLY, MOD_TRAIT)

/obj/item/mod/module/anti_magic/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_HOLY, MOD_TRAIT)

/obj/item/mod/module/anti_magic/wizard
	name = "односторонний анти-магический модуль"
	desc = "Маг, владеющий этим заклинанием, получает невидимый барьер вокруг себя, направляя магическую силу через \
		специализированные руны, выгравированые на поверхности костюма, чтобы создать антимагическое поле. \
		Поле нейтрализует любую магию, которая входит в контакт с пользователем. \
		Это не защитит заклинателя от насмешек окружающих."
	icon_state = "magic_neutralizer"

/obj/item/mod/module/anti_magic/wizard/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_ANTIMAGIC_NO_SELFBLOCK, MOD_TRAIT)

/obj/item/mod/module/anti_magic/wizard/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_ANTIMAGIC_NO_SELFBLOCK, MOD_TRAIT)

///Insignia - Gives you a skin specific stripe.
/obj/item/mod/module/insignia
	name = "модуль идентификации"
	desc = "Несмотря на существование систем радио локационного опонавания, радиокоммюнике и современных методов дедуктивного мышления, включающих \
		собственные глаза владельца, цветовое обозначение остаются популярным способом для различных фракций в галактике, чтобы показать, кто \
		они. Эта система использует серию крошечных движущихся распылителей краски для нанесения и удаления различных \
		цветовых узоров на костюме."
	icon_state = "insignia"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/insignia)
	overlay_state_inactive = "module_insignia"

/obj/item/mod/module/insignia/generate_worn_overlay(mutable_appearance/standing)
	overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	. = ..()
	for(var/mutable_appearance/appearance as anything in .)
		appearance.color = color

/obj/item/mod/module/insignia/commander
	color = "#4980a5"

/obj/item/mod/module/insignia/security
	color = "#b30d1e"

/obj/item/mod/module/insignia/engineer
	color = "#e9c80e"

/obj/item/mod/module/insignia/medic
	color = "#ebebf5"

/obj/item/mod/module/insignia/janitor
	color = "#7925c7"

/obj/item/mod/module/insignia/clown
	color = "#ff1fc7"

/obj/item/mod/module/insignia/chaplain
	color = "#f0a00c"

///Anti Slip - Prevents you from slipping on water.
/obj/item/mod/module/noslip
	name = "модуль анти-скольжения"
	desc = "Это модифицированный вариант стандартных магнитных ботинок, использующих пьезоэлектрические кристаллы на подошвах. \
		Две пластины на дне ботинок размагничиваются по необходимости в процессе движения. \
		Сила магнитного притяжения недостаточна сильна для фиксации в невесомости, однако удовлетворительна, чтобы \
		защитить от того, что вы не увидели знак мокрого пола. Хонк Ко. устраивали многочисленные протесты в попытках признать данный модуль незаконным."
	icon_state = "noslip"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.1
	incompatible_modules = list(/obj/item/mod/module/noslip)

/obj/item/mod/module/noslip/on_suit_activation()
	ADD_TRAIT(mod.boots, NOSLIP, MOD_TRAIT)

/obj/item/mod/module/noslip/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.boots, NOSLIP, MOD_TRAIT)

//Bite of 87 Springlock - Equips faster, disguised as DNA lock.
/obj/item/mod/module/springlock/bite_of_87

/obj/item/mod/module/springlock/bite_of_87/Initialize(mapload)
	. = ..()
	var/obj/item/mod/module/dna_lock/the_dna_lock_behind_the_slaughter = /obj/item/mod/module/dna_lock
	name = initial(the_dna_lock_behind_the_slaughter.name)
	desc = initial(the_dna_lock_behind_the_slaughter.desc)
	icon_state = initial(the_dna_lock_behind_the_slaughter.icon_state)
	complexity = initial(the_dna_lock_behind_the_slaughter.complexity)
	use_power_cost = initial(the_dna_lock_behind_the_slaughter.use_power_cost)

/obj/item/mod/module/springlock/bite_of_87/on_install()
	mod.activation_step_time *= 0.1

/obj/item/mod/module/springlock/bite_of_87/on_uninstall(deleting = FALSE)
	mod.activation_step_time *= 10

/obj/item/mod/module/springlock/bite_of_87/on_suit_activation()
	..()
	if(SSevents.holidays && SSevents.holidays[APRIL_FOOLS] || prob(1))
		mod.set_mod_color("#b17f00")
		mod.wearer.remove_atom_colour(WASHABLE_COLOUR_PRIORITY) // turns purple guy purple
		mod.wearer.add_atom_colour("#704b96", FIXED_COLOUR_PRIORITY)

///Flamethrower - Launches fire across the area.
/obj/item/mod/module/flamethrower
	name = "модуль огнемёта"
	desc = "Интегрированный в скафандр огнемет, используемый для сжигания всего на вашем пути."
	icon_state = "flamethrower"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = DEFAULT_CHARGE_DRAIN * 3
	incompatible_modules = list(/obj/item/mod/module/flamethrower)
	cooldown_time = 2.5 SECONDS
	overlay_state_inactive = "module_flamethrower"
	overlay_state_active = "module_flamethrower_on"

/obj/item/mod/module/flamethrower/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/obj/projectile/flame = new /obj/projectile/bullet/incendiary(mod.wearer.loc)
	flame.preparePixelProjectile(target, mod.wearer)
	flame.firer = mod.wearer
	playsound(src, 'sound/items/modsuit/flamethrower.ogg', 75, TRUE)
	INVOKE_ASYNC(flame, /obj/projectile.proc/fire)
	drain_power(use_power_cost)

///Power kick - Lets the user launch themselves at someone to kick them.
/obj/item/mod/module/power_kick
	name = "MOD модуль силового удара"
	desc = "Этот модуль использует мощный маймер, чтобы сгенерировать невероятное количество энергии и передать её в удар"
	icon_state = "power_kick"
	module_type = MODULE_ACTIVE
	removable = FALSE
	use_power_cost = DEFAULT_CHARGE_DRAIN*5
	incompatible_modules = list(/obj/item/mod/module/power_kick)
	cooldown_time = 5 SECONDS
	/// Damage on kick.
	var/damage = 20
	/// The wound bonus of the kick.
	var/wounding_power = 35
	/// How long we knockdown for on the kick.
	var/knockdown_time = 2 SECONDS

/obj/item/mod/module/power_kick/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	mod.wearer.visible_message(span_warning("[mod.wearer] начинает заряжать удар!"), \
		blind_message = span_hear("Слышу звук накапливаемой энергии."))
	playsound(src, 'sound/items/modsuit/loader_charge.ogg', 75, TRUE)
	balloon_alert(mod.wearer, "Накапливаю заряд...")
	animate(mod.wearer, 0.3 SECONDS, pixel_z = 16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_OUT)
	addtimer(CALLBACK(mod.wearer, TYPE_PROC_REF(/atom, SpinAnimation), 3, 2), 0.3 SECONDS)
	if(!do_after(mod.wearer, 1 SECONDS, target = mod))
		animate(mod.wearer, 0.2 SECONDS, pixel_z = -16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_OUT)
		return
	animate(mod.wearer)
	drain_power(use_power_cost)
	playsound(src, 'sound/items/modsuit/loader_launch.ogg', 75, TRUE)
	var/angle = get_angle(mod.wearer, target) + 180
	mod.wearer.transform = mod.wearer.transform.Turn(angle)
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_IMPACT, PROC_REF(on_throw_impact))
	mod.wearer.throw_at(target, range = 7, speed = 2, thrower = mod.wearer, spin = FALSE, gentle = TRUE, callback = CALLBACK(src, PROC_REF(on_throw_end), mod.wearer, -angle))

/obj/item/mod/module/power_kick/proc/on_throw_end(mob/user, angle)
	if(!user)
		return
	user.transform = user.transform.Turn(angle)
	animate(user, 0.2 SECONDS, pixel_z = -16, flags = ANIMATION_RELATIVE, easing = SINE_EASING|EASE_OUT)

/obj/item/mod/module/power_kick/proc/on_throw_impact(mob/living/source, obj/target, datum/thrownthing/thrownthing)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_MOVABLE_IMPACT)
	if(!mod?.wearer)
		return
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_damage(damage, BRUTE, mod.wearer.zone_selected)
		living_target.Knockdown(knockdown_time)
	else if(target.obj_integrity)
		target.take_damage(damage, BRUTE)
	else
		return
	mod.wearer.do_attack_animation(target, ATTACK_EFFECT_SMASH)

///Chameleon - lets the suit disguise as any item that would fit on that slot.
/obj/item/mod/module/chameleon
	name = "модуль хамелеона"
	desc = "Модуль, использующий технологию хамелеона, чтобы замаскировать костюм под другой объект."
	icon_state = "chameleon"
	module_type = MODULE_USABLE
	complexity = 2
	incompatible_modules = list(/obj/item/mod/module/chameleon)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE
	/// A list of all the items the suit can disguise as.
	var/list/possible_disguises = list()
	/// The path of the item we're disguised as.
	var/obj/item/current_disguise

/obj/item/mod/module/chameleon/on_install()
	var/list/all_disguises = sortList(subtypesof(get_path_by_slot(mod.slot_flags)), GLOBAL_PROC_REF(cmp_typepaths_asc))
	for(var/clothing_path in all_disguises)
		var/obj/item/clothing = clothing_path
		if(!initial(clothing.icon_state))
			continue
		var/chameleon_item_name = "[initial(clothing.name)] ([initial(clothing.icon_state)])"
		possible_disguises[chameleon_item_name] = clothing_path

/obj/item/mod/module/chameleon/on_uninstall(deleting = FALSE)
	if(current_disguise)
		return_look()
	possible_disguises = null

/obj/item/mod/module/chameleon/on_use()
	if(mod.active || mod.activating)
		balloon_alert(mod.wearer, "Костюм активен!")
		return
	. = ..()
	if(!.)
		return
	if(current_disguise)
		return_look()
		return
	var/picked_name = tgui_input_list(mod.wearer, "Выберите чем стать", "Настройки хамелеона", possible_disguises)
	if(!possible_disguises[picked_name] || mod.active || mod.activating)
		return
	current_disguise = possible_disguises[picked_name]
	update_look()

/obj/item/mod/module/chameleon/proc/update_look()
	mod.name = initial(current_disguise.name)
	mod.desc = initial(current_disguise.desc)
	mod.icon_state = initial(current_disguise.icon_state)
	mod.icon = initial(current_disguise.icon)
	mod.mob_overlay_icon = initial(current_disguise.mob_overlay_icon)
	mod.alternate_worn_layer = initial(current_disguise.alternate_worn_layer)
	mod.lefthand_file = initial(current_disguise.lefthand_file)
	mod.righthand_file = initial(current_disguise.righthand_file)
	//mod.mob_overlay_state = initial(current_disguise.mob_overlay_state)
	mod.item_state = initial(current_disguise.item_state)
	mod.wearer.update_inv_back(mod.slot_flags)
	RegisterSignal(mod, COMSIG_MOD_ACTIVATE, PROC_REF(return_look))

/obj/item/mod/module/chameleon/proc/return_look()
	mod.name = "[mod.theme.name] [initial(mod.name)]"
	mod.desc = "[initial(mod.desc)] [mod.theme.desc]"
	mod.icon_state = "[mod.skin]-[initial(mod.icon_state)]"
	var/list/mod_skin = mod.theme.skins[mod.skin]
	mod.icon = mod_skin[MOD_ICON_OVERRIDE] || 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	mod.mob_overlay_icon = mod_skin[MOD_WORN_ICON_OVERRIDE] || 'icons/mob/clothing/modsuit/mod_clothing.dmi'
	mod.alternate_worn_layer = mod_skin[CONTROL_LAYER]
	mod.lefthand_file = initial(mod.lefthand_file)
	mod.righthand_file = initial(mod.righthand_file)
	//___callbacknewmod.worn_icon_state = null
	mod.item_state = null
	mod.wearer.update_inv_back(mod.slot_flags)
	current_disguise = null
	UnregisterSignal(mod, COMSIG_MOD_ACTIVATE)

///Plate Compression - Compresses the suit to normal size
/obj/item/mod/module/plate_compression
	name = "модуль сверхкомпактности"
	desc = "Модуль перестраивающий структуру МОД-Скафа в крайне малые габариты, уменьшая общий размер.  \
		Из-за давления на все детали, модули инвентаря не работают."
	icon_state = "plate_compression"
	complexity = 2
	incompatible_modules = list(/obj/item/mod/module/plate_compression, /obj/item/mod/module/storage)
	/// The size we set the suit to.
	var/new_size = WEIGHT_CLASS_NORMAL
	/// The suit's size before the module is installed.
	var/old_size

/obj/item/mod/module/plate_compression/on_install()
	old_size = mod.w_class
	mod.w_class = new_size

/obj/item/mod/module/plate_compression/on_uninstall(deleting = FALSE)
	mod.w_class = old_size
	old_size = null
	if(!mod.loc)
		return
	var/datum/storage/holding_storage = mod.loc.atom_storage
	if(!holding_storage || holding_storage.max_specific_storage >= mod.w_class)
		return
	mod.forceMove(drop_location())
