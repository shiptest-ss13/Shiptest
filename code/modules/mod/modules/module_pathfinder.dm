///Pathfinder - Can fly the suit from a long distance to an implant installed in someone.
/*
/obj/item/mod/module/pathfinder
	name = "модуль удаленного вызова"
	desc = "Этот экспериментальный модуль от Накамура Инженеринг состоит из двух компонентов. \
		Первый из них это комплекс из ионных двигателей синхронизированный с навигационной системой, \
		подключенной к блоку управления скафандра, позволяющий скафандру быстро передвигаться по станции в беспилотном режиме, \
		стремясь ко второй части комплекса, которая имплантируется \
		непосредственно в основание позвоночника пользователя. \
		При мысленной команде имплант пересылает костюму свои текущие координаты и позволяет вызвать костюм в любой момент. \
		Модуль идет в комплекте с автохирургом импланта, который необходимо установить перед подключением к скафандру. \
		Производитель уверяет в стопроцентной надежности конструкции и наличии системы экстренного торможения."
	icon_state = "pathfinder"
	complexity = 2
	use_power_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/pathfinder)
	/// The pathfinding implant.
	var/obj/item/implant/mod/implant

/obj/item/mod/module/pathfinder/Initialize(mapload)
	. = ..()
	implant = new(src)

/obj/item/mod/module/pathfinder/Destroy()
	implant = null
	return ..()

/obj/item/mod/module/pathfinder/examine(mob/user)
	. = ..()
	if(implant)
		. += span_notice("Используйте на человеке для имплантации.")
	else
		. += span_warning("Имплант отсутсвует.")

/obj/item/mod/module/pathfinder/attack(mob/living/target, mob/living/user, params)
	if(!ishuman(target) || !implant)
		return
	if(!do_after(user, 1.5 SECONDS, target = target))
		balloon_alert(user, "Прервано!")
		return
	if(!implant.implant(target, user))
		balloon_alert(user, "Невозможно имплантировать!")
		return
	if(target == user)
		to_chat(user, span_notice("Имплантирую себе [implant]."))
	else
		target.visible_message(span_notice("[user] имплантирует [target]."), span_notice("[user] имплантирует меня [implant]."))
	playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)
	icon_state = "pathfinder_empty"
	implant = null

/obj/item/mod/module/pathfinder/proc/attach(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(human_user.get_item_by_slot(mod.slot_flags) && !human_user.dropItemToGround(human_user.get_item_by_slot(mod.slot_flags)))
		return
	if(!human_user.equip_to_slot_if_possible(mod, mod.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		return
	mod.quick_deploy(user)
	human_user.update_action_buttons(TRUE)
	balloon_alert(human_user, "[mod] синхронизирован")
	playsound(mod, 'sound/machines/ping.ogg', 50, TRUE)
	drain_power(use_power_cost)

/obj/item/implant/mod
	name = "имплант удаленного вызова"
	desc = "Позволяет вызвать к себе MOD-Скафандр."
	actions_types = list(/datum/action/item_action/mod_recall)
	/// The pathfinder module we are linked to.
	var/obj/item/mod/module/pathfinder/module
	/// The jet icon we apply to the MOD.
	var/image/jet_icon

/obj/item/implant/mod/Initialize(mapload)
	. = ..()
	if(!istype(loc, /obj/item/mod/module/pathfinder))
		return INITIALIZE_HINT_QDEL
	module = loc
	jet_icon = image(icon = 'icons/obj/clothing/modsuit/mod_modules.dmi', icon_state = "mod_jet", layer = LOW_ITEM_LAYER)

/obj/item/implant/mod/Destroy()
	if(module?.mod?.ai_controller)
		end_recall(successful = FALSE)
	module = null
	jet_icon = null
	return ..()

/obj/item/implant/mod/get_data()
	var/dat = {"<b>Спецификация импланта:</b><BR>
				<b>Название:</b> Имплант удаленного вызова от Накамура Инженеринг<BR>
				<b>Описание :</b> Позволяет вызвать Модульное Устройство Внешней защиты к носителю имлпанта.<BR>"}
	return dat

/obj/item/implant/mod/proc/recall()
	if(!module?.mod)
		balloon_alert(imp_in, "Нет синхронизированных скафандров!")
		return FALSE
	if(module.mod.open)
		balloon_alert(imp_in, "Костюм открыт!")
		return FALSE
	if(module.mod.ai_controller)
		balloon_alert(imp_in, "Уже в пути!")
		return FALSE
	if(ismob(get_atom_on_turf(module.mod)))
		balloon_alert(imp_in, "Уже на экипирован кем-то!")
		return FALSE
	if(module.z != z || get_dist(imp_in, module.mod) > MOD_AI_RANGE)
		balloon_alert(imp_in, "Слишком далеко!")
		return FALSE
	var/datum/ai_controller/mod_ai = new /datum/ai_controller/mod(module.mod)
	module.mod.ai_controller = mod_ai
	mod_ai.current_movement_target = imp_in
	mod_ai.blackboard[BB_MOD_TARGET] = imp_in
	mod_ai.blackboard[BB_MOD_IMPLANT] = src
	module.mod.interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	module.mod.AddElement(/datum/element/movetype_handler)
	ADD_TRAIT(module.mod, TRAIT_MOVE_FLYING, MOD_TRAIT)
	animate(module.mod, 0.2 SECONDS, pixel_x = base_pixel_y, pixel_y = base_pixel_y)
	module.mod.add_overlay(jet_icon)
	RegisterSignal(module.mod, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	balloon_alert(imp_in, "Скафандр вызван")
	return TRUE

/obj/item/implant/mod/proc/end_recall(successful = TRUE)
	if(!module?.mod)
		return
	QDEL_NULL(module.mod.ai_controller)
	module.mod.interaction_flags_item |= INTERACT_ITEM_ATTACK_HAND_PICKUP
	REMOVE_TRAIT(module.mod, TRAIT_MOVE_FLYING, MOD_TRAIT)
	module.mod.RemoveElement(/datum/element/movetype_handler)
	module.mod.cut_overlay(jet_icon)
	module.mod.transform = matrix()
	UnregisterSignal(module.mod, COMSIG_MOVABLE_MOVED)
	if(!successful)
		balloon_alert(imp_in, "Скафандр потерял связь!")

/obj/item/implant/mod/proc/on_move(atom/movable/source, atom/old_loc, dir, forced)
	SIGNAL_HANDLER

	var/matrix/mod_matrix = matrix()
	mod_matrix.Turn(get_angle(source, imp_in))
	source.transform = mod_matrix

/datum/action/item_action/mod_recall
	name = "Вызвать MOD"
	desc = "Вызывает MOD-Скафандр, куда угодно, в любое время."
	check_flags = AB_CHECK_CONSCIOUS
	background_icon_state = "bg_tech_blue"
	icon_icon = 'icons/mob/actions/actions_mod.dmi'
	button_icon_state = "recall"
	/// The cooldown for the recall.
	COOLDOWN_DECLARE(recall_cooldown)

/datum/action/item_action/mod_recall/New(Target)
	..()
	if(!istype(Target, /obj/item/implant/mod))
		qdel(src)
		return

/datum/action/item_action/mod_recall/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/implant/mod/implant = target
	if(!COOLDOWN_FINISHED(src, recall_cooldown))
		implant.balloon_alert(implant.imp_in, "Перезарядка!")
		return
	if(implant.recall())
		COOLDOWN_START(src, recall_cooldown, 15 SECONDS)
