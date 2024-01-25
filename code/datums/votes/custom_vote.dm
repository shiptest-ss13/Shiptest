/// The max amount of options someone can have in a custom vote.
#define MAX_CUSTOM_VOTE_OPTIONS 10

/datum/vote/custom_vote/single
	name = "Custom Standard"
	message = "Click here to start a custom vote (one selection per voter)"

/datum/vote/custom_vote/multi
	name = "Custom Multi"
	message = "Click here to start a custom multi vote (multiple selections per voter)"
	count_method = VOTE_COUNT_METHOD_MULTI

// Custom votes ares always accessible.
/datum/vote/custom_vote/is_accessible_vote()
	return TRUE

/datum/vote/custom_vote/reset()
	default_choices = null
	override_question = null
	return ..()

/datum/vote/custom_vote/can_be_initiated(mob/by_who, forced = FALSE)
	. = ..()
	if(!.)
		return FALSE

	// Custom votes can only be created if they're forced to be made.
	// (Either an admin makes it, or otherwise.)
	return forced

/datum/vote/custom_vote/create_vote(mob/vote_creator)
	var/custom_win_method = tgui_input_list(
		vote_creator,
		"How should the vote winner be determined?",
		"Winner Method",
		list("Simple", "Weighted Random", "No Winner"),
	)
	if(!custom_win_method)
		custom_win_method = "Simple"
	switch(custom_win_method)
		if("Simple")
			winner_method = VOTE_WINNER_METHOD_SIMPLE
		if("Weighted Random")
			winner_method = VOTE_WINNER_METHOD_WEIGHTED_RANDOM
		if("No Winner")
			winner_method = VOTE_WINNER_METHOD_NONE
		else
			to_chat(vote_creator, span_boldwarning("Unknown winner method. Contact a coder."))
			return FALSE

	override_question = input(vote_creator, "What is the vote for?", "Custom Vote") as text|null
	if(!override_question)
		return FALSE

	default_choices = list()
	for(var/i in 1 to MAX_CUSTOM_VOTE_OPTIONS)
		var/option = input(vote_creator, "Please enter an option, or hit cancel to finish. [MAX_CUSTOM_VOTE_OPTIONS] max.", "Options") as text|null
		option = copytext(option, 1, MAX_NAME_LEN)
		if(!vote_creator?.client)
			return FALSE
		if(!option)
			break

		default_choices += capitalize(option)

	if(!length(default_choices))
		return FALSE

	return ..()

/datum/vote/custom_vote/initiate_vote(initiator, duration)
	. = ..()
	. += "\n[override_question]"

#undef MAX_CUSTOM_VOTE_OPTIONS
