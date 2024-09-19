/obj/item/melee/transforming
	sharpness = IS_SHARP
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

	var/active = FALSE
	/// Force while active.
	var/active_force = 30
	/// Throwforce while active.
	var/active_throwforce = 20
	/// Sharpness while active.
	var/active_sharpness = IS_SHARP
	/// Hitsound played attacking while active.
	var/active_hitsound = 'sound/weapons/blade1.ogg'
	/// Weight class while active.
	var/active_w_class = WEIGHT_CLASS_BULKY
	/// The heat given off when active.
	var/active_heat = 3500

	var/list/attack_verb_on = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/melee/transforming/Initialize(mapload)
	. = ..()
	make_transformable()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(sharpness)
		AddComponent(/datum/component/butchering, 50, 100, 0, hitsound)

/obj/item/melee/transforming/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/*
 * Gives our item the transforming component, passing in our various vars.
 */
/obj/item/melee/transforming/proc/make_transformable()
	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
		throwforce_on = active_throwforce, \
		throw_speed_on = 4, \
		sharpness_on = active_sharpness, \
		hitsound_on = active_hitsound, \
		w_class_on = active_w_class, \
		attack_verb_on = attack_verb_on, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/transforming/process(seconds_per_tick)
	if(heat)
		open_flame()

/obj/item/melee/transforming/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(active)
		heat = active_heat
		START_PROCESSING(SSobj, src)
	else
		heat = initial(heat)
		STOP_PROCESSING(SSobj, src)

	tool_behaviour = (active ? TOOL_SAW : NONE) //Lets energy weapons cut trees. Also lets them do bonecutting surgery, which is kinda metal!
	if(user)
		balloon_alert(user, "[name] [active ? "enabled":"disabled"]")
	playsound(src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	set_light_on(active)
	update_appearance(UPDATE_ICON_STATE)
	return COMPONENT_NO_DEFAULT_MESSAGE
