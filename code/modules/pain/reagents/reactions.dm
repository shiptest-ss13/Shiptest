
/datum/chemical_reaction/medicine/ondansetron
	results = list(/datum/reagent/medicine/ondansetron = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/nitrogen = 1, /datum/reagent/oxygen = 1)
	required_catalysts = list(/datum/reagent/consumable/ethanol = 3)
	optimal_ph_max = 11
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

// move these melbert todo
/datum/chemical_reaction/medicine/morphine
	results = list(/datum/reagent/medicine/painkiller/morphine = 2)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/consumable/ethanol = 1, /datum/reagent/oxygen = 1)
	required_temp = 480
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

/datum/chemical_reaction/medicine/aspirin
	results = list(/datum/reagent/medicine/painkiller/aspirin = 3)
	required_reagents = list(/datum/reagent/medicine/sal_acid = 1, /datum/reagent/acetone = 1, /datum/reagent/oxygen = 1)
	required_catalysts = list(/datum/reagent/toxin/acid = 1)
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

/datum/chemical_reaction/medicine/paracetamol
	results = list(/datum/reagent/medicine/painkiller/paracetamol = 5)
	required_reagents = list(/datum/reagent/phenol = 1, /datum/reagent/acetone = 1, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1, /datum/reagent/toxin/acid/nitracid = 1)
	optimal_temp = 480
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

/datum/chemical_reaction/medicine/ibuprofen
	results = list(/datum/reagent/medicine/painkiller/ibuprofen = 5)
	required_reagents = list(/datum/reagent/propionic_acid = 1, /datum/reagent/phenol = 1, /datum/reagent/oxygen = 1, /datum/reagent/hydrogen = 1)
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

/datum/chemical_reaction/propionic_acid
	results = list(/datum/reagent/propionic_acid = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 1, /datum/reagent/hydrogen = 1)
	required_catalysts = list(/datum/reagent/toxin/acid = 1)
	is_cold_recipe = TRUE
	required_temp = 250
	optimal_temp = 200
	overheat_temp = 50
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/medicine/aspirin_para_coffee
	results = list(/datum/reagent/medicine/painkiller/aspirin_para_coffee = 3)
	required_reagents = list(/datum/reagent/medicine/painkiller/aspirin = 1, /datum/reagent/medicine/painkiller/paracetamol = 1, /datum/reagent/consumable/coffee = 1)
	optimal_ph_min = 2
	optimal_ph_max = 12
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG
	reaction_flags = REACTION_INSTANT

/datum/chemical_reaction/medicine/ibaltifen
	results = list(/datum/reagent/medicine/painkiller/specialized/ibaltifen = 3)
	required_reagents = list(/datum/reagent/propionic_acid = 1, /datum/reagent/chlorine = 1, /datum/reagent/copper = 1)
	required_catalysts = list(/datum/reagent/medicine/c2/libital = 1)
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

/datum/chemical_reaction/medicine/anurifen
	results = list(/datum/reagent/medicine/painkiller/specialized/anurifen = 3)
	required_reagents = list(/datum/reagent/propionic_acid= 1, /datum/reagent/fluorine = 1, /datum/reagent/phosphorus = 1)
	required_catalysts = list(/datum/reagent/medicine/c2/aiuri = 1)
	reaction_tags = REACTION_TAG_MODERATE | REACTION_TAG_HEALING | REACTION_TAG_OTHER | REACTION_TAG_DRUG

// Not really reactions, but I'm leaving these here
// Gain oxycodone from juicing poppies
/obj/item/food/grown/poppy
	juice_results = list(/datum/reagent/medicine/painkiller/oxycodone = 0)

/obj/item/food/grown/poppy/geranium
	juice_results = null

/obj/item/food/grown/poppy/lily
	juice_results = null
