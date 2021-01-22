/datum/chemical_reaction/bicaridine
	results = list(/datum/reagent/medicine/bicaridine = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/bicaridinep
	results = list(/datum/reagent/medicine/bicaridinep = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sodiumchloride = 1)

/datum/chemical_reaction/kelotane
	results = list(/datum/reagent/medicine/kelotane = 2)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/silicon = 1)

/datum/chemical_reaction/dermaline
	results = list(/datum/reagent/medicine/dermaline = 3)
	required_reagents = list(/datum/reagent/medicine/kelotane = 1, /datum/reagent/acetone = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/antitoxin
	results = list(/datum/reagent/medicine/antitoxin = 3)
	required_reagents = list(/datum/reagent/nitrogen = 1, /datum/reagent/silicon = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/dexalin
	results = list(/datum/reagent/medicine/dexalin = 5)
	required_reagents = list(/datum/reagent/oxygen = 5)
	required_catalysts = list(/datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/dexalinp
	results = list(/datum/reagent/medicine/dexalinp = 3)
	required_reagents = list(/datum/reagent/medicine/dexalin = 1, /datum/reagent/carbon = 1, /datum/reagent/iron = 1)

/datum/chemical_reaction/tricordrazine
	results = list(/datum/reagent/medicine/tricordrazine = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/medicine/kelotane = 1, /datum/reagent/medicine/antitoxin = 1)

/datum/chemical_reaction/tetracordrazine
	results = list(/datum/reagent/medicine/tetracordrazine = 4)
	required_reagents = list(/datum/reagent/medicine/tricordrazine = 3, /datum/reagent/medicine/dexalin = 1)
/datum/chemical_reaction/synthflesh
	results = list(/datum/reagent/medicine/synthflesh = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/styptic_powder = 1)

/datum/chemical_reaction/styptic_powder
	results = list(/datum/reagent/medicine/styptic_powder = 4)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1, /datum/reagent/toxin/acid = 1)
	mix_message = "The solution yields an astringent powder."

/datum/chemical_reaction/corazone
	results = list(/datum/reagent/medicine/corazone = 3)
	required_reagents = list(/datum/reagent/phenol = 2, /datum/reagent/lithium = 1)

/datum/chemical_reaction/carthatoline
	results = list(/datum/reagent/medicine/carthatoline = 3)
	required_reagents = list(/datum/reagent/medicine/antitoxin = 1, /datum/reagent/carbon = 2)
	required_catalysts = list(/datum/reagent/toxin/plasma = 1)

/*/datum/chemical_reaction/hepanephrodaxon //waspstation edit: temporary removal of an overloaded chem
	results = list(/datum/reagent/medicine/hepanephrodaxon = 5)
	required_reagents = list(/datum/reagent/medicine/carthatoline = 2, /datum/reagent/carbon = 2, /datum/reagent/lithium = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)*/

/datum/chemical_reaction/system_cleaner
	results = list(/datum/reagent/medicine/system_cleaner = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 1, /datum/reagent/phenol = 2, /datum/reagent/potassium = 1)

/datum/chemical_reaction/liquid_solder
	results = list(/datum/reagent/medicine/liquid_solder = 3)
	required_reagents = list( /datum/reagent/consumable/ethanol = 1, /datum/reagent/copper = 1, /datum/reagent/silver = 1)
	required_temp = 370
	mix_message = "The mixture becomes a metallic slurry."

/datum/chemical_reaction/perfluorodecalin
	results = list(/datum/reagent/medicine/perfluorodecalin = 3)
	required_reagents = list(/datum/reagent/hydrogen = 1, /datum/reagent/fluorine = 1, /datum/reagent/fuel/oil = 1)
	required_temp = 370
	mix_message = "The mixture rapidly turns into a dense pink liquid."

/datum/chemical_reaction/trophazole
	results = list(/datum/reagent/medicine/trophazole = 4)
	required_reagents = list(/datum/reagent/copper = 1, /datum/reagent/acetone = 2,  /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/rhigoxane
	results = list(/datum/reagent/medicine/rhigoxane/ = 5)
	required_reagents = list(/datum/reagent/cryostylane = 3, /datum/reagent/bromine = 1, /datum/reagent/lye = 1)

/datum/chemical_reaction/thializid
	results = list(/datum/reagent/medicine/thializid = 5)
	required_reagents = list(/datum/reagent/sulfur = 1, /datum/reagent/fluorine = 1, /datum/reagent/toxin = 1, /datum/reagent/nitrous_oxide = 2)

/datum/chemical_reaction/medsuture/ash
	required_reagents = list(/datum/reagent/ash_fibers = 10, /datum/reagent/toxin/formaldehyde = 20, /datum/reagent/medicine/polypyr = 15)

/datum/chemical_reaction/medmesh/ash
	required_reagents = list(/datum/reagent/ash_fibers = 20, /datum/reagent/consumable/aloejuice = 20, /datum/reagent/space_cleaner/sterilizine = 10)

/datum/chemical_reaction/lavaland_extract
	results = list(/datum/reagent/medicine/lavaland_extract = 5)
	required_reagents = list(/datum/reagent/consumable/vitfro = 1, /datum/reagent/medicine/puce_essence = 2,  /datum/reagent/toxin/plasma = 2)

/datum/chemical_reaction/bonefixingjuice
	results = list(/datum/reagent/medicine/bonefixingjuice = 3)
	required_reagents = list(/datum/reagent/consumable/entpoly = 1, /datum/reagent/calcium = 1, /datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/skele_boon
	results = list(/datum/reagent/medicine/skeletons_boon = 5)
	required_reagents = list(/datum/reagent/medicine/lavaland_extract = 1, /datum/reagent/medicine/bonefixingjuice = 1, /datum/reagent/titanium = 5)

/datum/chemical_reaction/pure_soulus_dust_hollow
	results = list(/datum/reagent/medicine/soulus/pure = 10, )
	required_reagents = list(/datum/reagent/medicine/soulus = 20, /datum/reagent/medicine/system_cleaner = 1, /datum/reagent/water/hollowwater = 10)

/datum/chemical_reaction/pure_soulus_dust_holy
	results = list(/datum/reagent/medicine/soulus/pure = 10, )
	required_reagents = list(/datum/reagent/medicine/soulus = 20, /datum/reagent/medicine/system_cleaner = 1, /datum/reagent/water/holywater = 10)

/datum/chemical_reaction/chartreuse
	results = list(/datum/reagent/medicine/chartreuse = 10)
	required_reagents = list(/datum/reagent/medicine/puce_essence = 5, /datum/reagent/consumable/tinlux = 5, /datum/reagent/consumable/entpoly = 1)

/datum/chemical_reaction/molten_bubbles
	results = list(/datum/reagent/medicine/molten_bubbles = 30)
	required_reagents = list(/datum/reagent/clf3 = 10, /datum/reagent/consumable/space_cola = 20, /datum/reagent/medicine/leporazine = 1, /datum/reagent/medicine/lavaland_extract = 1)

/datum/chemical_reaction/plasma_bubbles
	results = list(/datum/reagent/medicine/molten_bubbles/plasma = 3)
	required_reagents = list(/datum/reagent/medicine/molten_bubbles = 3, /datum/reagent/toxin/plasma = 2)

/datum/chemical_reaction/sand_bubbles
	results = list(/datum/reagent/medicine/molten_bubbles/sand = 3)
	required_reagents = list(/datum/reagent/medicine/molten_bubbles = 3, /datum/reagent/silicon = 2)

/datum/chemical_reaction/sand_bubbles/plasma			// Subbing plasma bubbles for reg
	required_reagents = list(/datum/reagent/medicine/molten_bubbles/plasma = 3, /datum/reagent/silicon = 2)
