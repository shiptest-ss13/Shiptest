/datum/chemical_reaction/space_drugs
	results = list(/datum/reagent/drug/space_drugs = 3)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1)

/datum/chemical_reaction/crank
	results = list(/datum/reagent/drug/crank = 5)
	required_reagents = list(/datum/reagent/medicine/diphenhydramine = 1, /datum/reagent/ammonia = 1, /datum/reagent/lithium = 1, /datum/reagent/toxin/acid = 1, /datum/reagent/fuel = 1)
	mix_message = "The mixture violently reacts, leaving behind a few crystalline shards."
	required_temp = 390

/datum/chemical_reaction/methamphetamine
	results = list(/datum/reagent/drug/methamphetamine = 4)
	required_reagents = list(/datum/reagent/medicine/ephedrine = 1, /datum/reagent/iodine = 1, /datum/reagent/phosphorus = 1, /datum/reagent/hydrogen = 1)
	required_temp = 374

/datum/chemical_reaction/mammoth
	results = list(/datum/reagent/drug/mammoth = 7)
	required_reagents = list(/datum/reagent/toxin/bad_food = 1, /datum/reagent/saltpetre = 1, /datum/reagent/consumable/nutriment = 1, /datum/reagent/space_cleaner = 1, /datum/reagent/consumable/enzyme = 1, /datum/reagent/consumable/tea = 1, /datum/reagent/mercury = 1)
	required_temp = 374

/datum/chemical_reaction/aranesp
	results = list(/datum/reagent/drug/aranesp = 3)
	required_reagents = list(/datum/reagent/medicine/epinephrine = 1, /datum/reagent/medicine/atropine = 1, /datum/reagent/medicine/morphine = 1)

/datum/chemical_reaction/happiness
	results = list(/datum/reagent/drug/happiness = 4)
	required_reagents = list(/datum/reagent/nitrous_oxide = 2, /datum/reagent/medicine/epinephrine = 1, /datum/reagent/consumable/ethanol = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/pumpup
	results = list(/datum/reagent/drug/pumpup = 5)
	required_reagents = list(/datum/reagent/medicine/epinephrine = 2, /datum/reagent/consumable/coffee = 5)

/datum/chemical_reaction/finobranc
	results = list(/datum/reagent/drug/finobranc = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/acetone = 1, /datum/reagent/medicine/mannitol = 1, /datum/reagent/phenol = 1, /datum/reagent/toxin/acid = 1)
	required_temp = 290

/datum/chemical_reaction/shoalmix
	results = list(/datum/reagent/drug/combat_drug = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vimukti = 1, /datum/reagent/medicine/dimorlin = 2, /datum/reagent/phenol = 1, /datum/reagent/medicine/atropine = 2)
	required_catalysts = list(/datum/reagent/stable_plasma = 5)
	required_temp = 451

/datum/chemical_reaction/alt_shoalmix
	results = list(/datum/reagent/drug/combat_drug = 2)
	required_reagents = list(/datum/reagent/consumable/vitfro = 4, /datum/reagent/medicine/dimorlin = 1, /datum/reagent/medicine/atropine = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)
	required_temp = 400

/datum/chemical_reaction/stardrop
	results = list(/datum/reagent/drug/stardrop = 5)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/acetone = 1, /datum/reagent/consumable/carrotjuice = 2)
	required_catalysts = list(/datum/reagent/stable_plasma = 5)

/datum/chemical_reaction/starlight
	results = list(/datum/reagent/drug/stardrop/starlight = 1)
	required_reagents = list(/datum/reagent/drug/stardrop = 1, /datum/reagent/phenol = 1, /datum/reagent/sulfur = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)
	mix_message = "The mixture concentrates into itself, taking on a deep coloration!"
	required_temp = 150
	is_cold_recipe = TRUE

/datum/chemical_reaction/cinesia
	results = list(/datum/reagent/drug/cinesia = 6)
	required_reagents = list(/datum/reagent/phenol = 1, /datum/reagent/medicine/ephedrine = 2)
	mix_message = "The mixture rapidly takes on a brown coloration!"
	required_temp = 347
