// Reworks toggle_move_intent to cycle rather than go back and forth
/mob/living/toggle_move_intent(backwards)
	if(backwards)
		switch(m_intent)
			if(MOVE_INTENT_RUN)
				m_intent = MOVE_INTENT_WALK
			if(MOVE_INTENT_WALK)
				m_intent = MOVE_INTENT_SNEAK
			if(MOVE_INTENT_SNEAK)
				m_intent = MOVE_INTENT_RUN
	else
		switch(m_intent)
			if(MOVE_INTENT_RUN)
				m_intent = MOVE_INTENT_SNEAK
			if(MOVE_INTENT_SNEAK)
				m_intent = MOVE_INTENT_WALK
			if(MOVE_INTENT_WALK)
				m_intent = MOVE_INTENT_RUN
	for(var/atom/movable/screen/mov_intent/selector in hud_used?.static_inventory)
		selector.update_appearance()
	update_move_intent_slowdown()

/// Sets the mob's move intent to the passed intent
/mob/living/proc/set_move_intent(new_intent)
	if(m_intent == new_intent)
		return
	m_intent = new_intent
	for(var/atom/movable/screen/mov_intent/selector in hud_used?.static_inventory)
		selector.update_appearance()
	update_move_intent_slowdown()

// Adds sneak movespeed modifier as an option
/mob/living/update_move_intent_slowdown()
	switch(m_intent)
		if(MOVE_INTENT_WALK)
			add_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk)
		if(MOVE_INTENT_RUN)
			add_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/run)
		if(MOVE_INTENT_SNEAK)
			add_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk/sneak)

// Movespeed modifier for sneaking. It's just 1.5x the slowness of walking.
/datum/movespeed_modifier/config_walk_run/walk/sneak/sync()
	var/mod = CONFIG_GET(number/movedelay/walk_delay)
	multiplicative_slowdown = (isnum(mod) ? mod : initial(multiplicative_slowdown)) * 1.5

// Syncs the sneak movespeed modifier with the walk movespeed modifier
/datum/config_entry/number/movedelay/walk_delay/ValidateAndSet()
	. = ..()
	var/datum/movespeed_modifier/config_walk_run/sneak = get_cached_movespeed_modifier(/datum/movespeed_modifier/config_walk_run/walk/sneak)
	sneak.sync()

// Keybind for sneak intent
/datum/keybinding/living/opposite_toggle_move_intent
	hotkey_keys = list("Alt")
	name = "opposite_toggle_move_intent"
	full_name = "Hold to toggle sneak"
	description = "Hold down to enable sneaking. Releasing will return you to walk."
	keybind_signal = "keybinding_mob_oppositetogglemoveintent_down"

/datum/keybinding/living/opposite_toggle_move_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	M.set_move_intent(MOVE_INTENT_SNEAK)
	return TRUE

/datum/keybinding/living/opposite_toggle_move_intent/up(client/user)
	var/mob/living/M = user.mob
	M.set_move_intent(MOVE_INTENT_WALK)
	return TRUE

/datum/keybinding/living/set_move_intent
	hotkey_keys = list("Unbound")
	name = "set_move_intent"
	full_name = "Toggle Run"
	description = "Press to start sprinting. Press again to stop."
	keybind_signal = "keybinding_mob_setmoveintent"

/datum/keybinding/living/set_move_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	if(M.m_intent == MOVE_INTENT_RUN)
		M.set_move_intent(MOVE_INTENT_WALK)
	else
		M.set_move_intent(MOVE_INTENT_RUN)
	return TRUE

/datum/keybinding/living/opposite_set_move_intent
	hotkey_keys = list("Unbound")
	name = "opposite_set_move_intent"
	full_name = "Toggle Sneak"
	description = "Press to start sneaking. Press again to stop."
	keybind_signal = "keybinding_mob_oppositesetmoveintent"

/datum/keybinding/living/opposite_set_move_intent/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/M = user.mob
	if(M.m_intent == MOVE_INTENT_SNEAK)
		M.set_move_intent(MOVE_INTENT_WALK)
	else
		M.set_move_intent(MOVE_INTENT_SNEAK)
	return TRUE
