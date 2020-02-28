/datum/chemical_reaction/blackpowder
	results = list(/datum/reagent/blackpowder = 3)
	required_reagents = list(/datum/reagent/saltpetre = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/reagent_explosion/blackpowder_explosion
	required_reagents = list(/datum/reagent/blackpowder = 1)
	required_temp = 474
	strengthdiv = 6
	modifier = 1
	mix_message = "<span class='boldannounce'>Sparks start flying around the blackpowder!</span>"
