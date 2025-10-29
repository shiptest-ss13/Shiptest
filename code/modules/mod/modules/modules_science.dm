///Anti-Gravity - Makes the user weightless.
/obj/item/mod/module/anomaly_locked/antigrav
	name = "MOD anti-gravity module"
	desc = "A module that uses a gravitational core to make the user completely weightless."
	icon_state = "antigrav"
	module_type = MODULE_TOGGLE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.7
	incompatible_modules = list(/obj/item/mod/module/anomaly_locked)
	cooldown_time = 0.5 SECONDS
	accepted_anomalies = list(/obj/item/assembly/signaler/anomaly/grav)

/obj/item/mod/module/anomaly_locked/antigrav/on_activation()
	. = ..()
	if(!.)
		return
	if(mod.wearer.has_gravity())
		new /obj/effect/temp_visual/mook_dust(get_turf(src))
	mod.wearer.AddElement(/datum/element/forced_gravity, 0)
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	playsound(src, 'sound/effects/gravhit.ogg', 50)

/obj/item/mod/module/anomaly_locked/antigrav/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	mod.wearer.RemoveElement(/datum/element/forced_gravity, 0)
	mod.wearer.update_gravity(mod.wearer.has_gravity())
	if(deleting)
		return
	if(mod.wearer.has_gravity())
		new /obj/effect/temp_visual/mook_dust(get_turf(src))
	playsound(src, 'sound/effects/gravhit.ogg', 50)

/obj/item/mod/module/anomaly_locked/antigrav/prebuilt
	prebuilt = TRUE

///Teleporter - Lets the user teleport to a nearby location.
/obj/item/mod/module/anomaly_locked/teleporter
	name = "MOD teleporter module"
	desc = "A module that uses a bluespace core to let the user transport their particles elsewhere."
	icon_state = "teleporter"
	module_type = MODULE_ACTIVE
	complexity = 3
	use_power_cost = DEFAULT_CHARGE_DRAIN * 5
	cooldown_time = 5 SECONDS
	accepted_anomalies = list(/obj/item/assembly/signaler/anomaly/bluespace)
	/// Time it takes to teleport
	var/teleport_time = 3 SECONDS

/obj/item/mod/module/anomaly_locked/teleporter/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/turf/open/target_turf = get_turf(target)
	if(!istype(target_turf) || target_turf.is_blocked_turf() || !(target_turf in view(mod.wearer)))
		to_chat(mod.wearer,span_warning("\The [target_turf] is an invalid target!"))
		return
	var/matrix/pre_matrix = matrix()
	pre_matrix.Scale(4, 0.25)
	var/matrix/post_matrix = matrix()
	post_matrix.Scale(0.25, 4)
	animate(mod.wearer, teleport_time, color = COLOR_CYAN, transform = pre_matrix.Multiply(mod.wearer.transform), easing = SINE_EASING|EASE_OUT)
	if(!do_after(mod.wearer, teleport_time, target = mod))
		animate(mod.wearer, teleport_time*0.1, color = null, transform = post_matrix.Multiply(mod.wearer.transform), easing = SINE_EASING|EASE_OUT)
		return
	animate(mod.wearer, teleport_time*0.1, color = null, transform = post_matrix.Multiply(mod.wearer.transform), easing = SINE_EASING|EASE_OUT)
	if(!do_teleport(mod.wearer, target_turf, asoundin = 'sound/effects/phasein.ogg'))
		return
	drain_power(use_power_cost)

/obj/item/mod/module/anomaly_locked/teleporter/prebuilt
	prebuilt = TRUE
