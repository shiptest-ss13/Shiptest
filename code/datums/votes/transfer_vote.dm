#define CHOICE_TRANSFER "Initiate Bluespace Jump"
#define CHOICE_CONTINUE "Continue Playing"

/// The fraction of non-voters that will be added to the transfer option when the vote is finalized.
#define TRANSFER_FACTOR clamp((world.time / (1 MINUTES) - 120) / 240, 0, 1)

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
	choices[CHOICE_TRANSFER] += round(length(non_voters) * TRANSFER_FACTOR)

	return ..()

/datum/vote/transfer_vote/get_winner_text(list/all_winners, real_winner, list/non_voters)
	. = ..()
	var/boost = round(length(non_voters) * TRANSFER_FACTOR)
	if(boost)
		. += "\n"
		. += span_bold("Transfer option was boosted by [boost] non-voters ([round(TRANSFER_FACTOR * 100, 0.1)]%) due to round length.")

/datum/vote/transfer_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_TRANSFER)
		SSshuttle.request_jump()
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef TRANSFER_FACTOR

#undef CHOICE_TRANSFER
#undef CHOICE_CONTINUE
