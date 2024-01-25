#define CHOICE_TRANSFER "Initiate Bluespace Jump"
#define CHOICE_CONTINUE "Continue Playing"

/datum/vote/transfer_vote
	name = "Transfer"
	default_choices = list(
		CHOICE_TRANSFER,
		CHOICE_CONTINUE,
	)

/datum/vote/transfer_vote/toggle_votable(mob/toggler)
	if(!toggler)
		CRASH("[type] wasn't passed a \"toggler\" mob to toggle_votable.")
	if(!check_rights_for(toggler.client, R_ADMIN))
		return FALSE

	CONFIG_SET(flag/allow_vote_transfer, !CONFIG_GET(flag/allow_vote_transfer))
	return TRUE

/datum/vote/transfer_vote/is_config_enabled()
	return CONFIG_GET(flag/allow_vote_transfer)

/datum/vote/transfer_vote/can_be_initiated(mob/by_who, forced)
	. = ..()
	if(!.)
		return FALSE

	if(SSshuttle.jump_mode != BS_JUMP_IDLE)
		return FALSE

	if(!forced && !CONFIG_GET(flag/allow_vote_transfer))
		if(by_who)
			to_chat(by_who, span_warning("Transfer voting is disabled."))
		return FALSE

	return TRUE

/datum/vote/transfer_vote/get_vote_result(list/non_voters)
	var/factor = 1
	switch(world.time / (1 HOURS))
		if(0 to 1)
			factor = 0.5
		if(1 to 2)
			factor = 0.8
		if(2 to 3)
			factor = 1
		if(3 to 4)
			factor = 1.5
		else
			factor = 2
	choices[CHOICE_TRANSFER] += round(length(non_voters) * factor)

	return ..()

/datum/vote/transfer_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_TRANSFER)
		SSshuttle.request_jump()
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_TRANSFER
#undef CHOICE_CONTINUE
