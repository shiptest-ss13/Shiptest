#define TRAIT_SPECIES_WHITELIST(ids...) list("type" = "allowed", ids)
#define TRAIT_SPECIES_BLACKLIST(ids...) list("type" = "blocked", ids)
//Used to process and handle roundstart quirks
// - Quirk strings are used for faster checking in code
// - Quirk datums are stored and hold different effects, as well as being a vector for applying trait string
PROCESSING_SUBSYSTEM_DEF(quirks)
	name = "Quirks"
	init_order = INIT_ORDER_QUIRKS
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME

	var/list/quirks = list()		//Assoc. list of all roundstart quirk datum types; "name" = /path/
	var/list/quirk_points = list()	//Assoc. list of quirk names and their "point cost"; positive numbers are good traits, and negative ones are bad
	var/list/quirk_objects = list()	//A list of all quirk objects in the game, since some may process
	var/list/quirk_blacklist = list() //A list a list of quirks that can not be used with each other. Format: list(quirk1,quirk2),list(quirk3,quirk4)
	///List of id-based locks for species, use either TRAIT_SPECIES_WHITELIST or TRAIT_SPECIES_BLACKLIST inputting the species ids to said macros. Example: species_lock = TRAIT_SPECIES_WHITELIST(SPECIES_IPC, SPECIES_MOTH)
	var/list/quirk_species_locks = list()
	var/list/quirk_customization_options = list()

/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	if(!quirks.len)
		SetupQuirks()

	quirk_blacklist = list(list("Blind","Nearsighted"), \
							list("Jolly","Depression","Apathetic","Hypersensitive"), \
							list("Ageusia","Vegetarian","Deviant Tastes"), \
							list("Ananas Affinity","Ananas Aversion"), \
							list("Alcohol Tolerance","Light Drinker"), \
							list("Clown Fan","Mime Fan"), \
							list("Bad Touch", "Friendly"))
	quirk_species_locks = list(
	"Blood Deficiency" = TRAIT_SPECIES_BLACKLIST(SPECIES_IPC, SPECIES_JELLYPERSON, SPECIES_PLASMAMAN, SPECIES_VAMPIRE))
	for(var/client/client in GLOB.clients)
		client?.prefs.check_quirk_compatibility()
		client?.prefs.update_quirk_preferences()
	return ..()

/datum/controller/subsystem/processing/quirks/proc/SetupQuirks()
	// Sort by Positive, Negative, Neutral; and then by name
	var/list/quirk_list = sortList(subtypesof(/datum/quirk), /proc/cmp_quirk_asc)

	for(var/V in quirk_list)
		var/datum/quirk/T = V
		quirks[initial(T.name)] = T
		quirk_points[initial(T.name)] = initial(T.value)
		if(initial(T.additional_values))
			var/list/values = splittext(initial(T.additional_values), ", ")
			var/value_address = 1
			var/list/value_options = list()
			var/handle_options = initial(T.additional_value_options)
			if(handle_options)
				value_options = splittext(handle_options, "; ")
			for(var/value in values)
				var/list/value_split = splittext(value, " = ")
				if(length(value_split) == 2)
					values[value_split[1]] = list("limit" = text2num(value_split[2]))
					values -= value
				else
					values[value] = list("limit" = 1)
				if(value == "Phobia")
					continue
				if(handle_options)
					var/list/value_options_split = splittext(value_options[value_address], ", ")
					for(var/value_option in value_options_split)
						var/value_option_split =  splittext(value_option, " = ")
						switch(length(value_option_split))
							if(1)
								value_options[value_option_split[1]] = list("cost" = 1, "value" = 0)
							if(2)
								value_options[value_option_split[1]] = list("cost" = text2num(value_option_split[2]), "value" = 0)
							if(3)
								value_options[value_option_split[1]] = list("cost" = text2num(value_option_split[2]), "value" = text2num(value_option_split[3]))
						values[value]["options"] = value_options
				value_address++
			quirk_customization_options = values

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/cli, spawn_effects)
	var/badquirk = FALSE
	var/list/conflicting_quirks = cli?.prefs.check_quirk_compatibility()
	conflicting_quirks &= cli?.prefs.all_quirks
	if(length(conflicting_quirks) > 0)
		stack_trace("Conflicting quirks [conflicting_quirks.Join(", ")] in client [cli.ckey] preferences on spawn")
	for(var/V in cli?.prefs.all_quirks)
		var/datum/quirk/Q = quirks[V]
		if(Q)
			user.add_quirk(Q, spawn_effects)
		else
			stack_trace("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			cli?.prefs.all_quirks -= V
			badquirk = TRUE
	if(badquirk)
		cli?.prefs.save_character()

	if(length(conflicting_quirks) > 0)
		alert(user, "Your quirks have been altered because you had a conflicting or invalid quirk, this was likely caused by mood being disabled or the species locks on a quirk being updated!")

#undef TRAIT_SPECIES_BLACKLIST
#undef TRAIT_SPECIES_WHITELIST
