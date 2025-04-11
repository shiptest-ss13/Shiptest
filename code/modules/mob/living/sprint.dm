/atom/movable/screen/mov_intent
	name = "run/walk/sneak cycle"
	desc = "Cycles between move intents. Right click to cycle backwards."
	maptext_width = 64
	maptext_x = -15
	maptext_y = 20
	/// Style applied to the maptext used on the selector
	var/maptext_style = "text-align:center; -dm-text-outline: 1px black"
	/// The sprint bar that appears over the bottom of our move selector
	var/mutable_appearance/sprint_bar

/atom/movable/screen/mov_intent/Click(location, control, params)
	var/list/modifiers = params2list(params)
	cycle_intent(backwards = LAZYACCESS(modifiers, RIGHT_CLICK))

/atom/movable/screen/mov_intent/update_overlays()
	. = ..()
	if(!ishuman(hud?.mymob))
		return

	if(isnull(sprint_bar))
		sprint_bar = mutable_appearance('icons/effects/progressbar.dmi')
		sprint_bar.pixel_y -= 2

	var/mob/living/carbon/human/runner = hud.mymob
	sprint_bar.icon_state = "prog_bar_[round(((runner.dna.species.sprint_length / runner.dna.species.sprint_length_max) * 100), 5)]"
	. += sprint_bar

/atom/movable/screen/mov_intent/proc/cycle_intent(backwards = FALSE)
	var/mob/living/cycler = hud?.mymob
	if(!istype(cycler))
		return
	cycler.toggle_move_intent(backwards)

/datum/movespeed_modifier/momentum
	movetypes = GROUND
	flags = IGNORE_NOSLOW
	multiplicative_slowdown = -0.1

/mob/living/carbon/human/Life(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return
	if(m_intent == MOVE_INTENT_RUN || dna.species.sprint_length >= dna.species.sprint_length_max)
		return

	adjust_sprint_left(dna.species.sprint_regen_per_second * seconds_per_tick * (body_position == LYING_DOWN ? 2 : 1))

/mob/living/carbon/proc/adjust_sprint_left(amount)
	return

/mob/living/carbon/human/adjust_sprint_left(amount)
	dna.species.sprint_length = clamp(dna.species.sprint_length + amount, 0, dna.species.sprint_length_max)
	for(var/atom/movable/screen/mov_intent/selector in hud_used?.static_inventory)
		selector.update_appearance(UPDATE_OVERLAYS)

/mob/living/carbon/proc/drain_sprint()
	return

/mob/living/carbon/human/drain_sprint()
	adjust_sprint_left(-1)
	// Sprinting when out of sprint will cost stamina
	if(dna.species.sprint_length > 0)
		return

	// Okay you're gonna stamcrit yourself, slow your roll
	if(getStaminaLoss() >= maxHealth * 0.9)
		set_move_intent(MOVE_INTENT_WALK)
		return

	adjustStaminaLoss(1)

/mob/living/carbon/human/fully_heal(admin_revive = FALSE)
	. = ..()
	adjust_sprint_left(INFINITY)

// Minor stamina regeneration effects, such as stimulants, will replenish sprint capacity
/mob/living/carbon/human/adjustStaminaLoss(amount, updating_health, forced)
	. = ..()
	if(amount < 0 && amount >= -20)
		adjust_sprint_left(amount * 0.25)

// Entering stamina critical will drain your sprint capacity entirely
/mob/living/carbon/human/enter_stamcrit()
	. = ..()
	if(HAS_TRAIT_FROM(src, TRAIT_FLOORED, STAMINA))
		adjust_sprint_left(-INFINITY)
