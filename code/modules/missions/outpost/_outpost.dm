/datum/mission/outpost
	acceptable = TRUE

/datum/mission/outpost/New(_outpost)
	source_outpost = _outpost
	RegisterSignal(source_outpost, COMSIG_QDELETING, PROC_REF(on_vital_delete))
	return ..()

/datum/mission/outpost/Destroy()
	UnregisterSignal(source_outpost, COMSIG_QDELETING, COMSIG_OVERMAP_LOADED)
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		UnregisterSignal(servant, COMSIG_QDELETING)
		LAZYREMOVE(servant.missions, src)
		servant = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	deltimer(dur_timer)
	return ..()

/datum/mission/outpost/turn_in()
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "succeeded"))
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", value, list(name, "payout"))
	var/remaining_value = value
	var/payment = floor(value*servant.crew_share)
	for(var/datum/weakref/account in servant.crew_bank_accounts)
		var/datum/bank_account/target_account = account.resolve()
		target_account.adjust_money(payment, CREDIT_LOG_MISSION)
		target_account.bank_card_talk("[payment] credits deposited to account, balance is now [target_account.account_balance]cr.")
		remaining_value = remaining_value - payment
	servant.ship_account.adjust_money(remaining_value, CREDIT_LOG_MISSION)
	qdel(src)

/datum/mission/outpost/proc/give_up()
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "abandoned"))
	qdel(src)

/datum/mission/outpost/can_complete()
	return !failed

/datum/mission/outpost/get_tgui_info()
	. = ..()
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

	var/act_str = "Give up"
	if(!accepted)
		act_str = "Accept"
	else if(can_complete())
		act_str = "Turn in"

	. += list(
		"ref" = REF(src),
		"name" = src.name,
		"desc" = src.desc,
		"value" = src.value,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "hh:mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str
	)

/**
 * Spawns a "bound" atom of the given type at the given location. When the "bound" atom
 * is qdeleted, the passed-in callback is invoked, and, by default, the mission fails.
 *
 * Intended to be used to spawn mission-linked atoms that can have
 * references saved without causing harddels.
 *
 * Arguments:
 * * a_type - The type of the atom to be spawned. Must be of type /atom/movable.
 * * a_loc - The location to spawn the bound atom at.
 * * destroy_cb - The callback to invoke when the bound atom is qdeleted. Default is null.
 * * fail_on_delete - Bool; whether the mission should fail when the bound atom is qdeleted. Default TRUE.
 * * sparks - Whether to spawn sparks after spawning the bound atom. Default TRUE.
 */
/datum/mission/outpost/spawn_bound(atom/movable/a_type, a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!ispath(a_type, /atom/movable))
		CRASH("[src] attempted to spawn bound atom of invalid type [a_type]!")
	var/atom/movable/bound = new a_type(a_loc)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_QDELETING, PROC_REF(bound_deleted))
	return bound
