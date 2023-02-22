//Supply modules for MODsuits

///Internal GPS - Extends a GPS you can use.
/obj/item/mod/module/gps
	name = "модуль GPS-трекера"
	desc = "Стандартный GPS-модуль не изменивший свой функционал с 21 века. \
	В большинстве случаев используется для отслеживания местоположения, как своего, так и окружающих сигналов."
	icon_state = "gps"
	module_type = MODULE_USABLE
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/gps)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE

/obj/item/mod/module/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps/item, "MOD0", state = GLOB.deep_inventory_state, overlay_state = FALSE)

/obj/item/mod/module/gps/on_use()
	. = ..()
	if(!.)
		return
	attack_self(mod.wearer)

///Hydraulic Clamp - Lets you pick up and drop crates.
/obj/item/mod/module/clamp
	name = "модуль гидравлического манипулятора"
	desc = "Серия приводов, установленных в обе руки скафандра, с грузоподъемностью почти в тонну. \
		Однако модель захватов поддерживает исключительно крепеж стандартных грузовых ящиков. \
		Многие скажут, что транспортировка груза - скучная работа, но вы с ними не согласитесь."
	icon_state = "clamp"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/clamp)
	cooldown_time = 0.5 SECONDS
	overlay_state_inactive = "module_clamp"
	overlay_state_active = "module_clamp_on"
	/// Time it takes to load a crate.
	var/load_time = 3 SECONDS
	/// The max amount of crates you can carry.
	var/max_crates = 3
	/// The crates stored in the module.
	var/list/stored_crates = list()

/obj/item/mod/module/clamp/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!mod.wearer.Adjacent(target))
		return
	if(istype(target, /obj/structure/closet/crate))// || istype(target, /obj/item/delivery/big))
		var/atom/movable/picked_crate = target
		if(!check_crate_pickup(picked_crate))
			return
		playsound(src, 'sound/mecha/hydraulic.ogg', 25, TRUE)
		if(!do_after(mod.wearer, load_time, target = target))
			balloon_alert(mod.wearer, "Прервано!")
			return
		if(!check_crate_pickup(picked_crate))
			return
		stored_crates += picked_crate
		picked_crate.forceMove(src)
		balloon_alert(mod.wearer, "Поднимаю [picked_crate]")
		drain_power(use_power_cost)
	else if(length(stored_crates))
		var/turf/target_turf = get_turf(target)
		if(target_turf.is_blocked_turf())
			return
		playsound(src, 'sound/mecha/hydraulic.ogg', 25, TRUE)
		if(!do_after(mod.wearer, load_time, target = target))
			balloon_alert(mod.wearer, "Прервано!")
			return
		if(target_turf.is_blocked_turf())
			return
		var/atom/movable/dropped_crate = pop(stored_crates)
		dropped_crate.forceMove(target_turf)
		balloon_alert(mod.wearer, "Опускаю [dropped_crate]")
		drain_power(use_power_cost)
	else
		balloon_alert(mod.wearer, "Неправильная цель!")

/obj/item/mod/module/clamp/on_suit_deactivation(deleting = FALSE)
	if(deleting)
		return
	for(var/atom/movable/crate as anything in stored_crates)
		crate.forceMove(drop_location())
		stored_crates -= crate

/obj/item/mod/module/clamp/proc/check_crate_pickup(atom/movable/target)
	if(length(stored_crates) >= max_crates)
		balloon_alert(mod.wearer, "Слишком много ящиков!")
		return FALSE
	for(var/mob/living/mob in target.get_all_contents())
		if(mob.mob_size < MOB_SIZE_HUMAN)
			continue
		balloon_alert(mod.wearer, "Ящик слишком тяжелый!")
		return FALSE
	return TRUE

/obj/item/mod/module/clamp/loader
	name = "модуль гидравлического манипулятора"
	icon_state = "clamp_loader"
	complexity = 0
	removable = FALSE
	overlay_state_inactive = null
	overlay_state_active = "module_clamp_loader"
	load_time = 1 SECONDS
	max_crates = 5
	use_mod_colors = TRUE

///Drill - Lets you dig through rock and basalt.
/obj/item/mod/module/drill
	name = "модуль бура"
	desc = "Встроенный бур, обычно простирающаяся над рукой пользователя. Хоть и бур полезен для бурения через породу, \
		твой бур, несомненно, способен пронзать небеса!"
	icon_state = "drill"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/drill)
	cooldown_time = 0.5 SECONDS
	overlay_state_active = "module_drill"

/obj/item/mod/module/drill/on_activation()
	. = ..()
	if(!.)
		return
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_BUMP, PROC_REF(bump_mine))

/obj/item/mod/module/drill/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_BUMP)

/obj/item/mod/module/drill/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!mod.wearer.Adjacent(target))
		return
	if(istype(target, /turf/closed/mineral))
		var/turf/closed/mineral/mineral_turf = target
		mineral_turf.gets_drilled(mod.wearer)
		drain_power(use_power_cost)
	else if(istype(target, /turf/open/floor/plating/asteroid))
		var/turf/open/floor/plating/asteroid/sand_turf = target
		if(!sand_turf.can_dig(mod.wearer))
			return
		sand_turf.getDug()
		drain_power(use_power_cost)

/obj/item/mod/module/drill/proc/bump_mine(mob/living/carbon/human/bumper, atom/bumped_into, proximity)
	SIGNAL_HANDLER
	if(!istype(bumped_into, /turf/closed/mineral) || !drain_power(use_power_cost))
		return
	var/turf/closed/mineral/mineral_turf = bumped_into
	mineral_turf.gets_drilled(mod.wearer)
	return COMPONENT_CANCEL_ATTACK_CHAIN

///Ore Bag - Lets you pick up ores and drop them from the suit.
/obj/item/mod/module/orebag
	name = "Модуль сумки для руды"
	desc = "Встроенная в костюм система хранения руды, \
		При этом используются точные электромагниты и отсеки для автоматического сбора и сортировки руды. \
		Данная конструкция является заслуженной гордостью компании Накамура Инжиниринг."
	icon_state = "ore"
	module_type = MODULE_USABLE
	complexity = 1
	use_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/orebag)
	cooldown_time = 0.5 SECONDS
	allowed_inactive = TRUE
	/// The ores stored in the bag.
	var/list/ores = list()

/obj/item/mod/module/orebag/on_equip()
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(ore_pickup))

/obj/item/mod/module/orebag/on_unequip()
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)

/obj/item/mod/module/orebag/proc/ore_pickup(atom/movable/source, atom/old_loc, dir, forced)
	SIGNAL_HANDLER

	for(var/obj/item/stack/ore/ore in get_turf(mod.wearer))
		INVOKE_ASYNC(src, PROC_REF(move_ore), ore)
		playsound(src, SFX_RUSTLE, 50, TRUE)

/obj/item/mod/module/orebag/proc/move_ore(obj/item/stack/ore)
	for(var/obj/item/stack/stored_ore as anything in ores)
		if(!ore.can_merge(stored_ore))
			continue
		ore.merge(stored_ore)
		if(QDELETED(ore))
			return
		break
	ore.forceMove(src)
	ores += ore

/obj/item/mod/module/orebag/on_use()
	. = ..()
	if(!.)
		return
	for(var/obj/item/ore as anything in ores)
		ore.forceMove(drop_location())
		ores -= ore
	drain_power(use_power_cost)

/obj/item/mod/module/hydraulic
	name = "модуль погрузочных гидравлических рук"
	desc = "Пара мощных гидравлических рук, установленных в скафандр"
	icon_state = "launch_loader"
	module_type = MODULE_ACTIVE
	removable = FALSE
	use_power_cost = DEFAULT_CHARGE_DRAIN*10
	incompatible_modules = list(/obj/item/mod/module/hydraulic)
	cooldown_time = 4 SECONDS
	overlay_state_inactive = "module_hydraulic"
	overlay_state_active = "module_hydraulic_active"
	use_mod_colors = TRUE
	/// Time it takes to launch
	var/launch_time = 2 SECONDS
	/// User overlay
	var/mutable_appearance/lightning

/*obj/item/mod/module/hydraulic/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/atom/game_renderer = mod.wearer.hud_used.get_plane_master(RENDER_PLANE_GAME)
	var/matrix/render_matrix = matrix(game_renderer.transform)
	render_matrix.Scale(1.25, 1.25)
	animate(game_renderer, launch_time, transform = render_matrix)
	var/current_time = world.time
	mod.wearer.visible_message(span_warning("[mod.wearer] заряжает гидравлические руки!"), \
		blind_message = span_hear("Где-то раздаётся звук зарядки."))
	playsound(src, 'sound/items/modsuit/loader_charge.ogg', 75, TRUE)
	lightning = mutable_appearance('icons/effects/effects.dmi', "electricity3", offset_spokesman = src, plane = GAME_PLANE_FOV_HIDDEN)
	mod.wearer.add_overlay(lightning)
	balloon_alert(mod.wearer, "Начинаю зарядку...")
	var/power = launch_time
	if(!do_after(mod.wearer, launch_time, target = mod))
		power = world.time - current_time
		animate(game_renderer)
	drain_power(use_power_cost)
	new /obj/effect/temp_visual/mook_dust(get_turf(src))
	playsound(src, 'sound/items/modsuit/loader_launch.ogg', 75, TRUE)
	game_renderer.transform = game_renderer.transform.Scale(0.8, 0.8)
	mod.wearer.cut_overlay(lightning)
	var/angle = get_angle(mod.wearer, target)
	mod.wearer.transform = mod.wearer.transform.Turn(angle)
	mod.wearer.throw_at(get_ranged_target_turf_direct(mod.wearer, target, power), \
		range = power, speed = max(round(0.2*power), 1), thrower = mod.wearer, spin = FALSE, \
		callback = CALLBACK(src, PROC_REF(on_throw_end), mod.wearer, -angle))*/

/obj/item/mod/module/hydraulic/proc/on_throw_end(mob/user, angle)
	if(!user)
		return
	user.transform = user.transform.Turn(angle)

/obj/item/mod/module/disposal_connector
	name = "модуль этикеровщика назначения"
	desc = "Модуль позволяет наносить специальные метки на ящики для работы пневматической почты. \
		Работает только когда скафандр включен."
	icon_state = "disposal"
	complexity = 2
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/disposal_connector)
	var/disposal_tag = NONE

/obj/item/mod/module/disposal_connector/Initialize(mapload)
	. = ..()
	disposal_tag = pick(GLOB.TAGGERLOCATIONS)

/obj/item/mod/module/disposal_connector/on_suit_activation()
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_DISPOSING, PROC_REF(disposal_handling))

/obj/item/mod/module/disposal_connector/on_suit_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_DISPOSING)

/obj/item/mod/module/disposal_connector/get_configuration()
	. = ..()
	.["disposal_tag"] = add_ui_configuration("Пометка назначения", "Список", GLOB.TAGGERLOCATIONS[disposal_tag], GLOB.TAGGERLOCATIONS)

/obj/item/mod/module/disposal_connector/configure_edit(key, value)
	switch(key)
		if("disposal_tag")
			for(var/tag in 1 to length(GLOB.TAGGERLOCATIONS))
				if(GLOB.TAGGERLOCATIONS[tag] == value)
					disposal_tag = tag
					break

/obj/item/mod/module/disposal_connector/proc/disposal_handling(datum/disposal_source, obj/structure/disposalholder/disposal_holder, obj/machinery/disposal/disposal_machine, hasmob)
	SIGNAL_HANDLER

	disposal_holder.destinationTag = disposal_tag

/obj/item/mod/module/magnet
	name = "модуль погрузочных магнитов"
	desc = "Мощный гидравлический электромагнит, способный притягивать ящики и шкафчики к пользователю, и держать их притянутыми."
	icon_state = "magnet_loader"
	module_type = MODULE_ACTIVE
	removable = FALSE
	use_power_cost = DEFAULT_CHARGE_DRAIN*3
	incompatible_modules = list(/obj/item/mod/module/magnet)
	cooldown_time = 1.5 SECONDS
	overlay_state_active = "module_magnet"
	use_mod_colors = TRUE

/obj/item/mod/module/magnet/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(istype(mod.wearer.pulling, /obj/structure/closet))
		var/obj/structure/closet/locker = mod.wearer.pulling
		playsound(locker, 'sound/effects/gravhit.ogg', 75, TRUE)
		locker.forceMove(mod.wearer.loc)
		locker.throw_at(target, range = 7, speed = 4, thrower = mod.wearer)
		return
	if(!istype(target, /obj/structure/closet) || !(target in view(mod.wearer)))
		balloon_alert(mod.wearer, "Неправильная цель!")
		return
	var/obj/structure/closet/locker = target
	if(locker.anchored || locker.move_resist >= MOVE_FORCE_OVERPOWERING)
		balloon_alert(mod.wearer, "Цель зафиксирована!")
		return
	new /obj/effect/temp_visual/mook_dust(get_turf(locker))
	playsound(locker, 'sound/effects/gravhit.ogg', 75, TRUE)
	locker.throw_at(mod.wearer, range = 7, speed = 3, force = MOVE_FORCE_WEAK, \
		callback = CALLBACK(src, PROC_REF(check_locker), locker))

/obj/item/mod/module/magnet/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(istype(mod.wearer.pulling, /obj/structure/closet))
		mod.wearer.stop_pulling()

/obj/item/mod/module/magnet/proc/check_locker(obj/structure/closet/locker)
	if(!mod?.wearer)
		return
	if(!locker.Adjacent(mod.wearer) || !isturf(locker.loc) || !isturf(mod.wearer.loc))
		return
	mod.wearer.start_pulling(locker)
	//locker.strong_grab = TRUE
	RegisterSignal(locker, COMSIG_ATOM_NO_LONGER_PULLED, PROC_REF(on_stop_pull))

/obj/item/mod/module/magnet/proc/on_stop_pull(obj/structure/closet/locker, atom/movable/last_puller)
	SIGNAL_HANDLER

	//locker.strong_grab = FALSE
	UnregisterSignal(locker, COMSIG_ATOM_NO_LONGER_PULLED)

/obj/item/mod/module/ash_accretion
	name = "модуль пепельной защиты"
	desc = "Модуль, собирающий пепельную взвесь с окружающей местности и покрывающий скафандр дополнительным защитным слоем. Пепельная защита со временем спадает."
	icon_state = "ash_accretion"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/ash_accretion)
	overlay_state_inactive = "module_ash"
	use_mod_colors = TRUE
	/// How many tiles we can travel to max out the armor.
	var/max_traveled_tiles = 10
	/// How many tiles we traveled through.
	var/traveled_tiles = 0
	/// Armor values per tile.
	var/list/armor_values = list("melee" = 4, "bullet" = 1, "laser" = 2, "energy" = 2, "bomb" = 4)
	/// Speed added when you're fully covered in ash.
	var/speed_added = 0.5
	/// Speed that we actually added.
	var/actual_speed_added = 0
	/// Turfs that let us accrete ash.
	var/static/list/accretion_turfs
	/// Turfs that let us keep ash.
	var/static/list/keep_turfs

/obj/item/mod/module/ash_accretion/Initialize(mapload)
	. = ..()
	if(!accretion_turfs)
		accretion_turfs = typecacheof(list(
			/turf/open/floor/plating/asteroid,
			/turf/open/floor/plating/ashplanet,
			/turf/open/floor/plating/dirt,
		))
	if(!keep_turfs)
		keep_turfs = typecacheof(list(
			/turf/open/floor/plating/grass,
			/turf/open/floor/plating/snowed,
			/turf/open/floor/plating/sandy_dirt,
			/turf/open/floor/plating/ironsand,
			/turf/open/floor/plating/ice,
			/turf/open/floor/plating/moss,
			/turf/open/indestructible/hierophant,
			/turf/open/indestructible/boss,
			/turf/open/indestructible/necropolis,
			/turf/open/lava,
			/turf/open/water,
		))

/obj/item/mod/module/ash_accretion/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_SANDSTORM_IMMUNE, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_ASHSTORM_IMMUNE, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_SNOWSTORM_IMMUNE, MOD_TRAIT)
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/obj/item/mod/module/ash_accretion/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_SANDSTORM_IMMUNE, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_ASHSTORM_IMMUNE, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_SNOWSTORM_IMMUNE, MOD_TRAIT)
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	if(!traveled_tiles)
		return
	var/list/parts = mod.mod_parts + mod
	var/list/removed_armor = armor_values.Copy()
	for(var/armor_type in removed_armor)
		removed_armor[armor_type] = -removed_armor[armor_type] * traveled_tiles
	for(var/obj/item/part as anything in parts)
		part.armor = part.armor.modifyRating(arglist(removed_armor))
	if(traveled_tiles == max_traveled_tiles)
		mod.slowdown += speed_added
		mod.wearer.update_equipment_speed_mods()
	traveled_tiles = 0

/obj/item/mod/module/ash_accretion/generate_worn_overlay(mutable_appearance/standing)
	overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	return ..()

/obj/item/mod/module/ash_accretion/proc/on_move(atom/source, atom/oldloc, dir, forced)
	if(!isturf(mod.wearer.loc)) //dont lose ash from going in a locker
		return
	if(traveled_tiles) //leave ash every tile
		new /obj/effect/temp_visual/light_ash(get_turf(src))
	if(is_type_in_typecache(mod.wearer.loc, accretion_turfs))
		if(traveled_tiles >= max_traveled_tiles)
			return
		traveled_tiles++
		var/list/parts = mod.mod_parts + mod
		for(var/obj/item/part as anything in parts)
			part.armor = part.armor.modifyRating(arglist(armor_values))
		if(traveled_tiles >= max_traveled_tiles)
			balloon_alert(mod.wearer, "Полностью покрыт пеплом")
			mod.wearer.color = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,3) //make them super light
			animate(mod.wearer, 1 SECONDS, color = null, flags = ANIMATION_PARALLEL)
			playsound(src, 'sound/effects/sparks1.ogg', 100, TRUE)
			actual_speed_added = max(0, min(mod.slowdown_active, speed_added))
			mod.slowdown -= actual_speed_added
			mod.wearer.update_equipment_speed_mods()
	else if(is_type_in_typecache(mod.wearer.loc, keep_turfs))
		return
	else
		if(traveled_tiles <= 0)
			return
		if(traveled_tiles == max_traveled_tiles)
			mod.slowdown += actual_speed_added
			mod.wearer.update_equipment_speed_mods()
		traveled_tiles--
		var/list/parts = mod.mod_parts + mod
		var/list/removed_armor = armor_values.Copy()
		for(var/armor_type in removed_armor)
			removed_armor[armor_type] = -removed_armor[armor_type]
		for(var/obj/item/part as anything in parts)
			part.armor = part.armor.modifyRating(arglist(removed_armor))
		if(traveled_tiles <= 0)
			balloon_alert(mod.wearer, "Пепел закончился!")

/obj/item/mod/module/sphere_transform
	name = "модуль трансформации в сферу"
	desc = "Модуль, способный перемещать части скафандра, превращая его и пользователя в сферу. \
		Сфера может двигаться быстро, даже через лаву, и запускать шахтёрские бомбы, чтобы уничтожать местность."
	icon_state = "sphere"
	module_type = MODULE_ACTIVE
	removable = FALSE
	active_power_cost = DEFAULT_CHARGE_DRAIN*0.5
	use_power_cost = DEFAULT_CHARGE_DRAIN*3
	incompatible_modules = list(/obj/item/mod/module/sphere_transform)
	cooldown_time = 1.25 SECONDS
	/// Time it takes us to complete the animation.
	var/animate_time = 0.25 SECONDS

/obj/item/mod/module/sphere_transform/on_activation()
	if(!mod.wearer.has_gravity())
		balloon_alert(mod.wearer, "Нет гравитации!")
		return FALSE
	. = ..()
	if(!.)
		return
	playsound(src, 'sound/items/modsuit/ballin.ogg', 100, TRUE)
	mod.wearer.add_filter("mod_ball", 1, alpha_mask_filter(icon = icon('icons/mob/clothing/modsuit/mod_modules.dmi', "ball_mask"), flags = MASK_INVERSE))
	mod.wearer.add_filter("mod_blur", 2, angular_blur_filter(size = 15))
	mod.wearer.add_filter("mod_outline", 3, outline_filter(color = "#000000AA"))
	mod.wearer.base_pixel_y -= 4
	animate(mod.wearer, animate_time, pixel_y = mod.wearer.base_pixel_y, flags = ANIMATION_PARALLEL)
	mod.wearer.SpinAnimation(1.5)
	ADD_TRAIT(mod.wearer, TRAIT_LAVA_IMMUNE, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_HANDS_BLOCKED, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_FORCED_STANDING, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_NOSLIPALL, MOD_TRAIT)
	//mod.wearer.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	//mod.wearer.AddElement(/datum/element/footstep, FOOTSTEP_OBJ_ROBOT, 1, -6, sound_vary = TRUE)
	mod.wearer.add_movespeed_modifier(/datum/movespeed_modifier/sphere)
	RegisterSignal(mod.wearer, COMSIG_MOB_STATCHANGE, PROC_REF(on_statchange))

/obj/item/mod/module/sphere_transform/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	if(!deleting)
		playsound(src, 'sound/items/modsuit/ballin.ogg', 100, TRUE, frequency = -1)
	mod.wearer.base_pixel_y = 0
	animate(mod.wearer, animate_time, pixel_y = mod.wearer.base_pixel_y)
	addtimer(CALLBACK(mod.wearer, TYPE_PROC_REF(/atom, remove_filter), list("mod_ball", "mod_blur", "mod_outline")), animate_time)
	REMOVE_TRAIT(mod.wearer, TRAIT_LAVA_IMMUNE, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_HANDS_BLOCKED, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_FORCED_STANDING, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_NOSLIPALL, MOD_TRAIT)
	mod.wearer.remove_movespeed_mod_immunities(MOD_TRAIT, /datum/movespeed_modifier/damage_slowdown)
	//mod.wearer.RemoveElement(/datum/element/footstep, FOOTSTEP_OBJ_ROBOT, 1, -6, sound_vary = TRUE)
	//mod.wearer.AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 1, -6)
	mod.wearer.remove_movespeed_modifier(/datum/movespeed_modifier/sphere)
	UnregisterSignal(mod.wearer, COMSIG_MOB_STATCHANGE)

/obj/item/mod/module/sphere_transform/on_use()
	if(!lavaland_equipment_pressure_check(get_turf(src)))
		balloon_alert(mod.wearer, "Слишком высокое давление!")
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 25, TRUE)
		return FALSE
	return ..()

/obj/item/mod/module/sphere_transform/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/obj/projectile/bomb = new /obj/projectile/bullet/reusable/mining_bomb(mod.wearer.loc)
	bomb.preparePixelProjectile(target, mod.wearer)
	bomb.firer = mod.wearer
	playsound(src, 'sound/weapons/gun/general/grenade_launch.ogg', 75, TRUE)
	INVOKE_ASYNC(bomb, /obj/projectile.proc/fire)
	drain_power(use_power_cost)

/obj/item/mod/module/sphere_transform/on_active_process(delta_time)
	animate(mod.wearer) //stop the animation
	mod.wearer.SpinAnimation(1.5) //start it back again
	if(!mod.wearer.has_gravity())
		on_deactivation() //deactivate in no grav

/obj/item/mod/module/sphere_transform/proc/on_statchange(datum/source)
	SIGNAL_HANDLER

	if(!mod.wearer.stat)
		return
	on_deactivation()

/obj/projectile/bullet/reusable/mining_bomb
	name = "Шахтёрская бомба"
	desc = "Бомба. Почему вы осматриваете это?"
	icon_state = "mine_bomb"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	damage = 0
	nodamage = TRUE
	range = 6
	suppressed = SUPPRESSED_VERY
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_LIGHT_ORANGE
	ammo_type = /obj/structure/mining_bomb

/obj/projectile/bullet/reusable/mining_bomb/handle_drop()
	if(dropped)
		return
	dropped = TRUE
	new ammo_type(get_turf(src), firer)

/obj/structure/mining_bomb
	name = "Шахтёрская бомба"
	desc = "Бомба. Почему вы осматриваете это?"
	icon_state = "mine_bomb"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	anchored = TRUE
	resistance_flags = FIRE_PROOF|LAVA_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_LIGHT_ORANGE
	/// Time to prime the explosion
	var/prime_time = 0.5 SECONDS
	/// Time to explode from the priming
	var/explosion_time = 1 SECONDS
	/// Damage done on explosion.
	var/damage = 15
	/// Damage multiplier on hostile fauna.
	var/fauna_boost = 4
	/// Image overlaid on explosion.
	var/static/image/explosion_image

/obj/structure/mining_bomb/Initialize(mapload, atom/movable/firer)
	. = ..()
	generate_image()
	addtimer(CALLBACK(src, PROC_REF(prime), firer), prime_time)

/obj/structure/mining_bomb/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	if(same_z_layer)
		return ..()
	explosion_image = null
	generate_image()
	return ..()

/obj/structure/mining_bomb/proc/generate_image()
	explosion_image = image('icons/effects/96x96.dmi', "judicial_explosion")
	explosion_image.pixel_x = -32
	explosion_image.pixel_y = -32
	SET_PLANE_EXPLICIT(explosion_image, ABOVE_GAME_PLANE, src)

/obj/structure/mining_bomb/proc/prime(atom/movable/firer)
	add_overlay(explosion_image)
	addtimer(CALLBACK(src, PROC_REF(boom), firer), explosion_time)

/obj/structure/mining_bomb/proc/boom(atom/movable/firer)
	visible_message(span_danger("[src] взрывается!"))
	playsound(src, 'sound/magic/magic_missile.ogg', 200, vary = TRUE)
	for(var/turf/closed/mineral/rock in circle_range_turfs(src, 2))
		rock.gets_drilled()
	for(var/mob/living/mob in range(1, src))
		mob.apply_damage(12 * (ishostile(mob) ? fauna_boost : 1), BRUTE, spread_damage = TRUE)
		if(!ishostile(mob) || !firer)
			continue
		var/mob/living/simple_animal/hostile/hostile_mob = mob
		hostile_mob.GiveTarget(firer)
	for(var/obj/object in range(1, src))
		object.take_damage(damage, BRUTE, "bomb")//, BOMB)
	qdel(src)
