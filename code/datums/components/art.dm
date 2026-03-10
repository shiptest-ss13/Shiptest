/datum/component/art
	var/impressiveness = 0

/datum/component/art/Initialize(impress)
	impressiveness = impress
	if(isobj(parent))
		RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_obj_examine))
	else
		RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_other_examine))
	if(isstructure(parent))
		RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	if(isitem(parent))
		RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(apply_moodlet))

/datum/component/art/proc/apply_moodlet(mob/M, impress)
	SIGNAL_HANDLER

	M.visible_message(
		span_notice("[M] stops and looks intently at [parent]."),
		span_notice("You stop to take in [parent].")
	)
	switch(impress)
		if (0 to BAD_ART)
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "artbad", /datum/mood_event/artbad)
		if (BAD_ART to GOOD_ART)
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "artok", /datum/mood_event/artok)
		if (GOOD_ART to GREAT_ART)
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "artgood", /datum/mood_event/artgood)
		if(GREAT_ART to INFINITY)
			SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "artgreat", /datum/mood_event/artgreat)


/datum/component/art/proc/on_other_examine(datum/source, mob/M)
	SIGNAL_HANDLER

	apply_moodlet(M, impressiveness)

/datum/component/art/proc/on_obj_examine(datum/source, mob/M)
	SIGNAL_HANDLER

	var/obj/O = parent
	apply_moodlet(M, impressiveness *(O.atom_integrity/O.max_integrity))

/datum/component/art/proc/on_attack_hand(datum/source, mob/M)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(examine), source, M)

/datum/component/art/proc/examine(datum/source, mob/M)

	to_chat(M, span_notice("You start examining [parent]..."))
	if(!do_after(M, 20, target = parent))
		return
	on_obj_examine(source, M)

/datum/component/art/rilena

/datum/component/art/rilena/apply_moodlet(mob/living/user, impress)
	var/msg
	if(HAS_TRAIT(user, TRAIT_FAN_RILENA))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "artgreat", /datum/mood_event/artgreat)
		msg = "You love this franchise!"
	else
		msg = "You don't get it. At least it's not ugly."
	user.visible_message(
		span_notice("[user] stops and looks intently at [parent]."),
		span_notice("You stop to take in [parent]. [msg]")
	)
