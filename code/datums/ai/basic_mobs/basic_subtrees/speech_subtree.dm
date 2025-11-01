/datum/ai_planning_subtree/random_speech
	//The chance of an emote occuring each second
	var/speech_chance = 0
	///Hearable emotes
	var/list/emote_hear = list()
	///Unlike speak_emote, the list of things in this variable only show by themselves with no spoken text. IE: Ian barks, Ian yaps
	var/list/emote_see = list()
	///Possible lines of speech the AI can have
	var/list/speak = list()

/datum/ai_planning_subtree/random_speech/New()
	. = ..()
	if(speak)
		speak = string_list(speak)
	if(emote_hear)
		emote_hear = string_list(emote_hear)
	if(emote_see)
		emote_see = string_list(emote_see)

/datum/ai_planning_subtree/random_speech/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(SPT_PROB(speech_chance, seconds_per_tick))
		var/audible_emotes_length = emote_hear?.len
		var/non_audible_emotes_length = emote_see?.len
		var/speak_lines_length = speak?.len

		var/total_choices_length = audible_emotes_length + non_audible_emotes_length + speak_lines_length

		var/random_number_in_range =  rand(1, total_choices_length)

		if(random_number_in_range <= audible_emotes_length)
			controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_hear))
		else if(random_number_in_range <= (audible_emotes_length + non_audible_emotes_length))
			controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emote_see))
		else
			controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(speak))

/datum/ai_planning_subtree/random_speech/cockroach
	speech_chance = 5
	emote_hear = list("chitters.")

/datum/ai_planning_subtree/random_speech/mouse
	speech_chance = 1
	speak = list("Squeak!", "SQUEAK!", "Squeak?")
	emote_hear = list("squeaks.")
	emote_see = list("runs in a circle.", "shakes.")

/datum/ai_planning_subtree/random_speech/cow
	speech_chance = 1
	speak = list("moo?","moo","MOOOOOO")
	//sound = list('sound/mobs/non-humanoids/cow/cow.ogg')
	emote_hear = list("brays.")
	emote_see = list("shakes her head.")

/datum/ai_planning_subtree/random_speech/bear
	speech_chance = 5
	emote_hear = list("rawrs.","grumbles.","grawls.", "stomps!")
	emote_see = list("stares ferociously.")

/datum/ai_planning_subtree/random_speech/monkey
	speech_chance = 1
	emote_hear = list("chimpers.")
