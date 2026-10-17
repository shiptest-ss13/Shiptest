/// Flashlights for AI, used when its dark, turns it off when nothing is happening. Should case same cone as a player's flashlight, and is used for AI vision in dark.
/datum/component/ai_flashlight
	var/obj/item/flashlight/light
	//how long after the last sign of a fight we keep it on
	var/quiet_time = 10 SECONDS
	//when we last had reason to have it on
	var/last_needed = 0
	//if TRUE, we drop it when we die, for lights our corpse wouldn't otherwise have
	var/drops_on_death = FALSE
	//TRUE while we check on it every life tick, only from when there's a fight until the light's back off, so a mob with nobody about costs nothing
	var/ticking = FALSE

/datum/component/ai_flashlight/Initialize(light_type = /obj/item/flashlight/seclite, drops_on_death = FALSE)
	. = ..()
	if(!isbasicmob(parent))
		return COMPONENT_INCOMPATIBLE
	light = new light_type(parent)
	src.drops_on_death = drops_on_death

/datum/component/ai_flashlight/Destroy(force)
	QDEL_NULL(light)
	return ..()

/datum/component/ai_flashlight/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_CURRENT_TARGET), PROC_REF(update_flashlight))
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_LAST_SHOT_TIME), PROC_REF(on_shot_at))
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/component/ai_flashlight/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_LIVING_LIFE,
		COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_CURRENT_TARGET),
		COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_LAST_SHOT_TIME),
		COMSIG_LIVING_DEATH,
	))

/datum/component/ai_flashlight/proc/update_flashlight(datum/source)
	SIGNAL_HANDLER
	if(!light)
		return
	var/mob/living/basic/basic_mob = parent
	var/datum/ai_controller/controller = basic_mob.ai_controller
	if(basic_mob.client || !controller || basic_mob.stat != CONSCIOUS)
		set_light_on(FALSE) // whoever's in control can see to it themselves
		set_ticking(FALSE)
		return
	if(needs_light(controller))
		last_needed = world.time
		set_light_on(TRUE)
	else if(light.on && world.time - last_needed > quiet_time)
		set_light_on(FALSE)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	set_ticking(light.on || !QDELETED(target) || world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < quiet_time)

// only checking on the light every life tick while it might be needed, as most mobs spend most of their time with nobody about
/datum/component/ai_flashlight/proc/set_ticking(should_tick)
	if(ticking == should_tick)
		return
	ticking = should_tick
	if(ticking)
		RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(update_flashlight))
	else
		UnregisterSignal(parent, COMSIG_LIVING_LIFE)

// fighting or looking for someone, and somewhere it matters is dark, like where we are, or where they are or were last
/datum/component/ai_flashlight/proc/needs_light(datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/shot_lately = world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < quiet_time
	if(QDELETED(target) && !shot_lately)
		return FALSE
	if(light.on)
		return TRUE // our own light brightens where we are, so we don't go by that once it's on, or it'd flicker off and on
	if(ai_is_dark(get_turf(parent)))
		return TRUE
	if(!QDELETED(target) && ai_is_dark(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE ? get_turf(target) : controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]))
		return TRUE // they're in the dark, or wherever we're going to look for them is
	return shot_lately && ai_is_dark(controller.blackboard[BB_BASIC_MOB_SHOT_FROM])

/datum/component/ai_flashlight/proc/on_shot_at(datum/source)
	SIGNAL_HANDLER
	var/mob/living/basic/basic_mob = parent
	var/datum/ai_controller/controller = basic_mob.ai_controller
	update_flashlight()
	if(!light?.on || controller?.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		return // we can see who we're fighting, so we face them as we fight
	var/turf/shot_from = controller?.blackboard[BB_BASIC_MOB_SHOT_FROM]
	if(shot_from && shot_from != get_turf(basic_mob))
		basic_mob.setDir(get_dir(basic_mob, shot_from)) // shine it where that came from

/datum/component/ai_flashlight/proc/on_death(datum/source)
	SIGNAL_HANDLER
	set_light_on(FALSE)
	var/turf/our_turf = get_turf(parent)
	if(!drops_on_death || !our_turf)
		return
	var/mob/living/basic/human/human_mob = parent
	var/mob/living/carbon/human/corpse = istype(human_mob) ? human_mob.corpse_ref?.resolve() : null
	if(!stow_on_corpse(corpse))
		light.forceMove(our_turf)
	light = null
	qdel(src)

// puts the light on the corpse we left, where they'd have carried it: a pocket, else their belt, else their bag. FALSE if there's no room anywhere
/datum/component/ai_flashlight/proc/stow_on_corpse(mob/living/carbon/human/corpse)
	if(QDELETED(corpse))
		return FALSE
	for(var/pocket_slot in list(ITEM_SLOT_RPOCKET, ITEM_SLOT_LPOCKET))
		if(corpse.equip_to_slot_if_possible(light, pocket_slot, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
			return TRUE
	for(var/obj/item/container as anything in list(corpse.belt, corpse.back))
		if(container && SEND_SIGNAL(container, COMSIG_TRY_STORAGE_INSERT, light, null, TRUE, FALSE))
			return TRUE
	return FALSE

/datum/component/ai_flashlight/proc/set_light_on(turn_on)
	if(light.on == turn_on)
		return
	light.on = turn_on
	light.update_brightness()
	playsound(parent, turn_on ? light.toggle_on_sound : light.toggle_off_sound, 30, TRUE, SILENCED_SOUND_EXTRARANGE)
	var/mob/living/basic/basic_mob = parent
	AI_LOG_DECISION(basic_mob.ai_controller, "ai_flashlight: [turn_on ? "on, it's dark" : "off, it's been quiet"]")
