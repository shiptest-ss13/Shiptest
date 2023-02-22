//Ninja modules for MODsuits

///Cloaking - Lowers the user's visibility, can be interrupted by being touched or attacked.
/obj/item/mod/module/stealth
	name = "прототип маскировочного модуля"
	desc = "Этот модуль использует технологию искажения потока фотонов и мимикрии для визуальной маскировки носителя. \
		Возможно именно по этому такие модули редко попадаются на глаза."
	icon_state = "cloak"
	module_type = MODULE_TOGGLE
	complexity = 4
	active_power_cost = DEFAULT_CHARGE_DRAIN * 2
	use_power_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/stealth)
	cooldown_time = 5 SECONDS
	/// Whether or not the cloak turns off on bumping.
	var/bumpoff = TRUE
	/// The alpha applied when the cloak is on.
	var/stealth_alpha = 50

/obj/item/mod/module/stealth/on_activation()
	. = ..()
	if(!.)
		return
	if(bumpoff)
		RegisterSignal(mod.wearer, COMSIG_LIVING_MOB_BUMP, PROC_REF(unstealth))
	RegisterSignal(mod.wearer, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(mod.wearer, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_act))
	RegisterSignal(mod.wearer, list(COMSIG_MOB_ITEM_ATTACK, COMSIG_PARENT_ATTACKBY, COMSIG_ATOM_ATTACK_HAND/*, COMSIG_ATOM_HITBY*/, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED), PROC_REF(unstealth))
	animate(mod.wearer, alpha = stealth_alpha, time = 1.5 SECONDS)
	drain_power(use_power_cost)

/obj/item/mod/module/stealth/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(bumpoff)
		UnregisterSignal(mod.wearer, COMSIG_LIVING_MOB_BUMP)
	UnregisterSignal(mod.wearer, list(COMSIG_HUMAN_MELEE_UNARMED_ATTACK, COMSIG_MOB_ITEM_ATTACK, COMSIG_PARENT_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_BULLET_ACT/*, COMSIG_ATOM_HITBY*/, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED))
	animate(mod.wearer, alpha = 255, time = 1.5 SECONDS)

/obj/item/mod/module/stealth/proc/unstealth(datum/source)
	SIGNAL_HANDLER

	to_chat(mod.wearer, span_warning("[src] разрядился от контакта!"))
	do_sparks(2, TRUE, src)
	drain_power(use_power_cost)
	on_deactivation(display_message = TRUE, deleting = FALSE)

/obj/item/mod/module/stealth/proc/on_unarmed_attack(datum/source, atom/target)
	SIGNAL_HANDLER

	if(!isliving(target))
		return
	unstealth(source)

/obj/item/mod/module/stealth/proc/on_bullet_act(datum/source, obj/projectile/projectile)
	SIGNAL_HANDLER

	if(projectile.nodamage)
		return
	unstealth(source)

//Advanced Cloaking - Doesn't turf off on bump, less power drain, more stealthy.
/obj/item/mod/module/stealth/ninja
	name = "продвинутый маскировочный модуль"
	desc = "Последняя модель в технологии маскировки, этот модуль определённо является обновлением по сравнению с предыдущими версиями. \
		Поле было настроено на ещё более быструю и стойкую маскировку, достаточно стойкую для \
		длительной работы поля, даже если пользователь сталкивается с другими объектами. \
		Энергопотребление было значительно сокращено, что делает его идеальным для \
		длительной слежки за своими целями."
	icon_state = "cloak_ninja"
	bumpoff = FALSE
	stealth_alpha = 20
	active_power_cost = DEFAULT_CHARGE_DRAIN
	use_power_cost = DEFAULT_CHARGE_DRAIN * 5
	cooldown_time = 3 SECONDS

///Camera Vision - Prevents flashes, blocks tracking.
/obj/item/mod/module/welding/camera_vision
	name = "модуль шифрования изображения"
	desc = "Этот специализированный модуль нарушает работу камер для маскировки носителя на изображениях, \
		а так же заглушает работу любых программ автоматической слежки и распознования лиц. \
		В комплекте идёт нанодисплей для защиты глаз от резких вспышек. Станьте невидимым."
	icon_state = "welding_camera"
	removable = FALSE
	complexity = 0
	overlay_state_inactive = null

/obj/item/mod/module/welding/camera_vision/on_suit_activation()
	. = ..()
	RegisterSignal(mod.wearer, COMSIG_LIVING_CAN_TRACK, PROC_REF(can_track))

/obj/item/mod/module/welding/camera_vision/on_suit_deactivation(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod.wearer, COMSIG_LIVING_CAN_TRACK)

/obj/item/mod/module/welding/camera_vision/proc/can_track(datum/source, mob/user)
	SIGNAL_HANDLER

	return COMPONENT_CANT_TRACK

//Ninja Star Dispenser - Dispenses ninja stars.
/obj/item/mod/module/dispenser/ninja
	name = "модуль репликатора метальных звёзд"
	desc = "Уникальная разработка Клана Пауков, использующая заряд скафандра для репликации метательных звёзд непосредственно в руке пользователя. \
		Наниты, расположенные в перчатках скафандра, при подаче энергии начинают собиратся в мономолекулярные звёзды, \
		однако, сюрикены собранные таким образом не имеют таких же острых краёв как классические звезды, \
		взамен, однако, неплохо изматывают свою цель."
	dispense_type = /obj/item/throwing_star/stamina
	cooldown_time = 0.5 SECONDS

///Hacker - This module hooks onto your right-clicks with empty hands and causes ninja actions.
/obj/item/mod/module/hacker
	name = "модуль взлома"
	desc = "Модуль созданный для саботажа электронных устройств, \
		Посредством узконаправленной электромагнитной индукции. \
		Данное воздействие на большинство стандартных шлюзов, машин и прочих электронных устройств вызывает короткие замыкания или активацию аварийных протоколов. \
		Он также способен обезвреживать противника точной электростимуляцией нервной системы."
	icon_state = "hacker"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/hacker)
	/// Minimum amount of power we can drain in a single drain action
	var/mindrain = 200
	/// Maximum amount of power we can drain in a single drain action
	var/maxdrain = 400
	/// Whether or not the communication console hack was used to summon another antagonist.
	var/communication_console_hack_success = FALSE
	/// How many times the module has been used to force open doors.
	var/door_hack_counter = 0
	///Used for the research objective (see antagonist file)
	var/datum/techweb/stored_research

/obj/item/mod/module/hacker/on_suit_activation()
	RegisterSignal(mod.wearer, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(hack))

/obj/item/mod/module/hacker/on_suit_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_HUMAN_EARLY_UNARMED_ATTACK)

/obj/item/mod/module/hacker/proc/hack(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	if(!LAZYACCESS(modifiers, RIGHT_CLICK) || !proximity)
		return NONE
	target.add_fingerprint(mod.wearer)
	return target.ninjadrain_act(mod.wearer, src)

/obj/item/mod/module/hacker/proc/charge_message(atom/drained_atom, drain_amount)
	if(drain_amount)
		to_chat(mod.wearer, span_notice("Получено <B>[drain_amount]</B> единиц энергии с [drained_atom]."))
	else
		to_chat(mod.wearer, span_warning("[drained_atom] истощен, необходимо найти другой источник питания!"))

///Weapon Recall - Teleports your katana to you, prevents gun use.
/obj/item/mod/module/weapon_recall
	name = "модуль связи с оружием"
	desc = "Краеугольный камень жизни Клана Пауков как мастеров клинков. Модуль символизирует их вечную связь с оружием. \
		Устройство способно возвращать привязанное оружие обратно к умелым рукам владельца, \
		где бы оно не было. Однако, те, кто делают такую связь с оружием на веки прокляты, \
		связывая своё существование с насилием, для единственной цели: Сократить количество противника. \
		Их рука - клинок, их тело - тень, их разум - беспощадный."
	icon_state = "recall"
	removable = FALSE
	module_type = MODULE_USABLE
	use_power_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/weapon_recall)
	cooldown_time = 0.5 SECONDS
	/// The item linked to the module that will get recalled.
	var/obj/item/linked_weapon
	/// The accepted typepath we can link to.
	var/accepted_type = /obj/item/energy_katana

/obj/item/mod/module/weapon_recall/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_NOGUNS, MOD_TRAIT)

/obj/item/mod/module/weapon_recall/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_NOGUNS, MOD_TRAIT)

/obj/item/mod/module/weapon_recall/on_use()
	. = ..()
	if(!.)
		return
	if(!linked_weapon)
		var/obj/item/weapon_to_link = mod.wearer.is_holding_item_of_type(accepted_type)
		if(!weapon_to_link)
			balloon_alert(mod.wearer, "Не могу найти оружие!")
			return
		set_weapon(weapon_to_link)
		balloon_alert(mod.wearer, "[linked_weapon.name] связано")
		return
	if(linked_weapon in mod.wearer.get_all_contents())
		balloon_alert(mod.wearer, "Уже с вами!")
		return
	var/distance = get_dist(mod.wearer, linked_weapon)
	var/in_view = (linked_weapon in view(mod.wearer))
	if(!in_view && !drain_power(use_power_cost * distance))
		balloon_alert(mod.wearer, "Не хватает энергии!")
		return
	linked_weapon.forceMove(linked_weapon.drop_location())
	if(in_view)
		do_sparks(5, FALSE, linked_weapon)
		mod.wearer.visible_message(span_danger("[linked_weapon] прилетает обратно к [mod.wearer]!"),span_warning("Складываю свою руку в специальном жесте и [linked_weapon] прилетает обратно ко мне"))
		linked_weapon.throw_at(mod.wearer, distance+1, linked_weapon.throw_speed, mod.wearer)
	else
		recall_weapon()

/obj/item/mod/module/weapon_recall/proc/set_weapon(obj/item/weapon)
	linked_weapon = weapon
	RegisterSignal(linked_weapon, COMSIG_MOVABLE_IMPACT, PROC_REF(catch_weapon))
	RegisterSignal(linked_weapon, COMSIG_PARENT_QDELETING, PROC_REF(deleted_weapon))

/obj/item/mod/module/weapon_recall/proc/recall_weapon(caught = FALSE)
	linked_weapon.forceMove(get_turf(src))
	var/alert = ""
	if(mod.wearer.put_in_hands(linked_weapon))
		alert = "[linked_weapon.name] телепортируется мне обратно в руки!"
	else if(mod.wearer.equip_to_slot_if_possible(linked_weapon, ITEM_SLOT_BELT, disable_warning = TRUE))
		alert = "[linked_weapon.name] помещается на мой пояс"
	else
		alert = "[linked_weapon.name] телепортируется под меня"
	if(caught)
		if(mod.wearer.is_holding(linked_weapon))
			alert = "Ловлю [linked_weapon.name]"
		else
			alert = "[linked_weapon.name] падает перед мною"
	else
		do_sparks(5, FALSE, linked_weapon)
	if(alert)
		balloon_alert(mod.wearer, alert)

/obj/item/mod/module/weapon_recall/proc/catch_weapon(obj/item/source, atom/hit_atom, datum/thrownthing/thrownthing)
	SIGNAL_HANDLER

	if(!mod)
		return
	if(hit_atom != mod.wearer)
		return
	INVOKE_ASYNC(src, PROC_REF(recall_weapon), TRUE)
	return COMPONENT_MOVABLE_IMPACT_NEVERMIND

/obj/item/mod/module/weapon_recall/proc/deleted_weapon(obj/item/source)
	SIGNAL_HANDLER

	linked_weapon = null

//Reinforced DNA Lock - Gibs if wrong DNA, emp-proof.
/obj/item/mod/module/dna_lock/reinforced
	name = "улучшеный модуль ДНК блокировки"
	desc = "Модуль блокировки центрального ядра костюма, \
		не позволяющий не авторизованному лицу получить доступ без проверки ДНК. \
		Из-за использования экспериментального ингибитора поля, модуль полностью защищен от электромагнитных помех. \
		Он также послушно защищает секреты Клана Пауков от посторонних глаз."
	icon_state = "dnalock_ninja"
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.5

/obj/item/mod/module/dna_lock/reinforced/on_mod_activation(datum/source, mob/user)
	. = ..()
	if(. != MOD_CANCEL_ACTIVATE || !isliving(user))
		return
	var/mob/living/living_user = user
	to_chat(living_user, span_danger("<B>ФАаТальнАя ОшИбка</B>: 382200-*#00КОД <B>КРАСНЫЙ</B>\nНЕАВТОРИЗОВАННОЕ ИСПОЛЬЗОВАНИЕ ОБНАРУЖЕНО\nИСПОЛНЯЮ СУБ-П40ТОК0Л 13...\nУниЧТОЖАЮ ПО-ПОЛЬЗОВАТЕЛЯ..."))
	living_user.gib()

/obj/item/mod/module/dna_lock/reinforced/on_emp(datum/source, severity)
	return

//EMP Pulse - In addition to normal shielding, can also launch an EMP itself.
/obj/item/mod/module/emp_shield/pulse
	name = "модуль эми импульса"
	desc = "Прототип ингибитора поля, защищающего скафандр от ЭМИ импульсов \
		Носитель может перегрузить и тем самым инвертировать работу модуля, \
		вызвав сильный ЭМИ-импульс, посредством складывания из рук специальной печати."
	icon_state = "emp_pulse"
	module_type = MODULE_USABLE
	use_power_cost = DEFAULT_CHARGE_DRAIN * 10
	cooldown_time = 8 SECONDS

/obj/item/mod/module/emp_shield/pulse/on_use()
	. = ..()
	if(!.)
		return
	playsound(src, 'sound/effects/empulse.ogg', 60, TRUE)
	empulse(src, heavy_range = 4, light_range = 6)
	drain_power(use_power_cost)

///Status Readout - Puts a lot of information including health, nutrition, fingerprints, temperature to the suit TGUI.
/obj/item/mod/module/status_readout
	name = "модуль биомонитора"
	desc = "Судя по всему когда-то это было обычным гражданским медицинским модулем подвергшимся серьезной модификации. \
		Клан Паука адаптировал данное устройство под мониторинг основных жизненных показателей носителя, \
		от стандартных биометрических данных, до уровня насыщения и общего состояния."
	icon_state = "status"
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.1
	incompatible_modules = list(/obj/item/mod/module/status_readout)
	tgui_id = "status_readout"

/obj/item/mod/module/status_readout/add_ui_data()
	. = ..()
	.["statustime"] = station_time_timestamp()
	.["statusid"] = GLOB.round_id
	.["statushealth"] = mod.wearer?.health || 0
	.["statusmaxhealth"] = mod.wearer?.getMaxHealth() || 0
	.["statusbrute"] = mod.wearer?.getBruteLoss() || 0
	.["statusburn"] = mod.wearer?.getFireLoss() || 0
	.["statustoxin"] = mod.wearer?.getToxLoss() || 0
	.["statusoxy"] = mod.wearer?.getOxyLoss() || 0
	.["statustemp"] = mod.wearer?.bodytemperature || 0
	.["statusnutrition"] = mod.wearer?.nutrition || 0
	//.["statusfingerprints"] = mod.wearer ? md5(mod.wearer.dna.unique_identity) : null
	.["statusdna"] = mod.wearer?.dna.unique_enzymes
	.["statusviruses"] = null
	if(!length(mod.wearer?.diseases))
		return
	var/list/viruses = list()
	for(var/datum/disease/virus as anything in mod.wearer.diseases)
		var/list/virus_data = list()
		virus_data["name"] = virus.name
		virus_data["type"] = virus.spread_text
		virus_data["stage"] = virus.stage
		virus_data["maxstage"] = virus.max_stages
		virus_data["cure"] = virus.cure_text
		viruses += list(virus_data)
	.["statusviruses"] = viruses

///Energy Net - Ensnares enemies in a net that prevents movement.
/obj/item/mod/module/energy_net
	name = "модуль энергосети"
	desc = "Хитроумное устройство для запуска энергетической ловчей сети из мономолекулярного волокна и удержания противника на месте."
	icon_state = "energy_net"
	removable = FALSE
	module_type = MODULE_ACTIVE
	use_power_cost = DEFAULT_CHARGE_DRAIN * 6
	incompatible_modules = list(/obj/item/mod/module/energy_net)
	cooldown_time = 1.5 SECONDS

/obj/item/mod/module/energy_net/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!isliving(target))
		balloon_alert(mod.wearer, "Неправильная цель!")
		return
	var/mob/living/living_target = target
	if(locate(/obj/structure/energy_net) in get_turf(living_target))
		balloon_alert(mod.wearer, "Уже закован!")
		return
	for(var/turf/between_turf as anything in get_line(get_turf(mod.wearer), get_turf(living_target)))
		if(between_turf.density)
			balloon_alert(mod.wearer, "За препятствием!")
			return
	//if(IS_SPACE_NINJA(mod.wearer))
	//	mod.wearer.say("А ну иди сюда!", forced = type)
	mod.wearer.Beam(living_target, "n_beam", time = 1.5 SECONDS)
	var/obj/structure/energy_net/net = new /obj/structure/energy_net(living_target.drop_location())
	net.affecting = living_target
	mod.wearer.visible_message(span_danger("[mod.wearer] поймал [living_target] энергосетью!"), span_notice("Вы поймали [living_target] энергосетью!"))
	if(living_target.buckled)
		living_target.buckled.unbuckle_mob(living_target, force = TRUE)
	net.buckle_mob(living_target, force = TRUE)
	drain_power(use_power_cost)

///Adrenaline Boost - Stops all stuns the ninja is affected with, increases his speed.
/obj/item/mod/module/adrenaline_boost
	name = "модуль адреналинового усиления"
	desc = "У Клана Паука множество секретов. Точные характеристики их костюмов, \
		техники, которые они используют, чтобы сделать каждый шаг со взмахом клинка. \
		Но одна из их величайших тайн - это химическое соединение, которое используют убийцы-диверсанты в случае необходимости. \
		нейтрализовать эффект полной парализации. Все, что о ней известно, это то, что для синтеза химиката необходимо радиоактивное излучение."
	icon_state = "adrenaline_boost"
	removable = FALSE
	module_type = MODULE_USABLE
	incompatible_modules = list(/obj/item/mod/module/adrenaline_boost)
	cooldown_time = 12 SECONDS
	/// What reagent we need to refill?
	var/reagent_required = /datum/reagent/uranium/radium
	/// How much of a reagent we need to refill the boost.
	var/reagent_required_amount = 20

/obj/item/mod/module/adrenaline_boost/Initialize(mapload)
	. = ..()
	create_reagents(reagent_required_amount)
	reagents.add_reagent(reagent_required, reagent_required_amount)

/obj/item/mod/module/adrenaline_boost/on_use()
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "Нет энергии!")
		return
	. = ..()
	if(!.)
		return
	//if(IS_SPACE_NINJA(mod.wearer))
	//	mod.wearer.say(pick_list_replacements(NINJA_FILE, "lines"), forced = type)
	to_chat(mod.wearer, span_notice("Использовал адреналиновое усиление."))
	mod.wearer.SetUnconscious(0)
	mod.wearer.SetStun(0)
	mod.wearer.SetKnockdown(0)
	mod.wearer.SetImmobilized(0)
	mod.wearer.SetParalyzed(0)
	mod.wearer.adjustStaminaLoss(-200)
	mod.wearer.stuttering = 0
	mod.wearer.reagents.add_reagent(/datum/reagent/medicine/stimulants, 5)
	reagents.remove_reagent(reagent_required, reagents.total_volume * 0.75)
	addtimer(CALLBACK(src, PROC_REF(boost_aftereffects), mod.wearer), 7 SECONDS)

/obj/item/mod/module/adrenaline_boost/on_install()
	RegisterSignal(mod, COMSIG_PARENT_ATTACKBY, PROC_REF(on_attackby))

/obj/item/mod/module/adrenaline_boost/on_uninstall(deleting)
	UnregisterSignal(mod, COMSIG_PARENT_ATTACKBY)

/obj/item/mod/module/adrenaline_boost/attackby(obj/item/attacking_item, mob/user, params)
	if(charge_boost(attacking_item, user))
		return TRUE
	return ..()

/obj/item/mod/module/adrenaline_boost/proc/on_attackby(datum/source, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER

	if(charge_boost(attacking_item, user))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/item/mod/module/adrenaline_boost/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "Уже заряжено!")
		return FALSE
	if(!attacking_item.reagents.trans_id_to(src, reagent_required, reagent_required_amount))
		return FALSE
	balloon_alert(mod.wearer, "Модуль [reagents.has_reagent(reagent_required, reagent_required_amount) ? "полностью" : "частично"] заряжен")
	return TRUE

/obj/item/mod/module/adrenaline_boost/proc/boost_aftereffects(mob/affected_mob)
	if(!affected_mob)
		return
	reagents.trans_to(affected_mob, reagents.total_volume)
	to_chat(affected_mob, span_danger("Чувствую последствия усиления."))
