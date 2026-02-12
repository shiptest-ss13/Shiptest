GLOBAL_LIST_INIT(ai_names, world.file2list("strings/names/ai.txt"))
GLOBAL_LIST_INIT(wizard_first, world.file2list("strings/names/wizardfirst.txt"))
GLOBAL_LIST_INIT(wizard_second, world.file2list("strings/names/wizardsecond.txt"))
GLOBAL_LIST_INIT(ninja_titles, world.file2list("strings/names/ninjatitle.txt"))
GLOBAL_LIST_INIT(ninja_names, world.file2list("strings/names/ninjaname.txt"))
GLOBAL_LIST_INIT(commando_names, world.file2list("strings/names/death_commando.txt"))
GLOBAL_LIST_INIT(twinkle_names, world.file2list("strings/names/twinkle.txt"))
GLOBAL_LIST_INIT(first_names, world.file2list("strings/names/first.txt"))
GLOBAL_LIST_INIT(first_names_male, world.file2list("strings/names/first_male.txt"))
GLOBAL_LIST_INIT(first_names_female, world.file2list("strings/names/first_female.txt"))
GLOBAL_LIST_INIT(last_names, world.file2list("strings/names/last.txt"))
GLOBAL_LIST_INIT(lizard_names_male, world.file2list("strings/names/lizard_male.txt"))
GLOBAL_LIST_INIT(lizard_names_female, world.file2list("strings/names/lizard_female.txt"))
GLOBAL_LIST_INIT(spider_names, world.file2list("strings/names/spider_names.txt"))
GLOBAL_LIST_INIT(kepori_names, world.file2list("strings/names/kepori_names.txt"))
GLOBAL_LIST_INIT(carp_names, world.file2list("strings/names/carp.txt"))
GLOBAL_LIST_INIT(plasmaman_names, world.file2list("strings/names/plasmaman.txt"))
GLOBAL_LIST_INIT(squid_names, world.file2list("strings/names/squid.txt"))
GLOBAL_LIST_INIT(posibrain_names, world.file2list("strings/names/posibrain.txt"))
GLOBAL_LIST_INIT(nightmare_names, world.file2list("strings/names/nightmare.txt"))
GLOBAL_LIST_INIT(megacarp_first_names, world.file2list("strings/names/megacarp1.txt"))
GLOBAL_LIST_INIT(megacarp_last_names, world.file2list("strings/names/megacarp2.txt"))

GLOBAL_LIST_INIT(verbs, world.file2list("strings/names/verbs.txt"))
GLOBAL_LIST_INIT(ing_verbs, world.file2list("strings/names/ing_verbs.txt"))
GLOBAL_LIST_INIT(adverbs, world.file2list("strings/names/adverbs.txt"))
GLOBAL_LIST_INIT(adjectives, world.file2list("strings/names/adjectives.txt"))
GLOBAL_LIST_INIT(organic_preference_adjectives, world.file2list("strings/human_adjectives/organic_adjectives.txt") + world.file2list("strings/human_adjectives/abstract_adjectives.txt"))
GLOBAL_LIST_INIT(ipc_preference_adjectives, world.file2list("strings/human_adjectives/ipc_adjectives.txt") + world.file2list("strings/human_adjectives/abstract_adjectives.txt"))
GLOBAL_LIST_INIT(dream_strings, world.file2list("strings/dreamstrings.txt"))
//loaded on startup because of "
//would include in rsc if ' was used

/*
List of configurable names in preferences and their metadata
"id" = list(
	"pref_name" = "name", //pref label
	"qdesc" =  "name", //popup question text
	"group" = "whatever", // group (these will be grouped together on pref ui ,order still follows the list so they need to be concurrent to be grouped)
	"allow_null" = FALSE // if empty name is entered it's replaced with default value
	),
*/
GLOBAL_LIST_INIT(preferences_custom_names, list(
	"cyborg" = list("pref_name" = "Cyborg", "qdesc" = "cyborg name (Leave empty to use default naming scheme)", "group" = "silicons", "allow_null" = TRUE),
	"ai" = list("pref_name" = "AI", "qdesc" = "ai name", "group" = "silicons", "allow_null" = FALSE),
))
