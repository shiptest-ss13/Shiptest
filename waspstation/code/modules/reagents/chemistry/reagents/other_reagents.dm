/datum/reagent/calcium
	name = "Calcium"
	description = "A dull gray metal important to bones."
	reagent_state = SOLID
	color = "#68675c"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/ash_fibers
	name = "Ashen Fibers"
	description = "Ground plant fibers from a cave fern. Useful for medicines."
	reagent_state = SOLID
	color = "#5a4f42"
	taste_mult = 0

/datum/reagent/titanium
	name = "Titanium"
	description = "A light, reflective grey metal used in ship construction."
	reagent_state = SOLID
	color = "#c2c2c2"

/datum/reagent/mutationtoxin/kobold
	name = "Kobold Mutation Toxin"
	description = "An ashen toxin. Something about this seems lesser."
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/lizard/ashwalker/kobold
	process_flags = ORGANIC | SYNTHETIC //WaspStation Edit - IPCs
	taste_description = "short savagery"
