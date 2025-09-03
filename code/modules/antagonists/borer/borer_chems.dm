/datum/borer_chem
	var/chem
	var/chemname = "chemical"
	var/chem_desc = "This is a chemical. Also a bug. Yell at a coder."
	var/chemuse = 50
	var/quantity = 10

/datum/borer_chem/epinephrine
	chem = /datum/reagent/medicine/epinephrine
	chemname = "epinephrine"
	chem_desc = "Stabilizes hosts in critical condition and slowly restores oxygen damage. If overdosed, it will deal toxin and oxyloss damage."
	chemuse = 30

/datum/borer_chem/leporazine
	chem = /datum/reagent/medicine/leporazine
	chemname = "leporazine"
	chem_desc = "This keeps a host's temperature stable. High doses can allow short periods of unprotected EVA."
	chemuse = 75

/datum/borer_chem/spaceacillin
	chem = /datum/reagent/medicine/spaceacillin
	chemname = "spaceacillin"
	chem_desc = "Prevents your host from spreading diseases, as well as cures some specific types of disease. Also known to hide borers from rudimentary health scans."
	chemuse = 75
	quantity = 5

/datum/borer_chem/mannitol
	chem = /datum/reagent/medicine/mannitol
	chemname = "mannitol"
	chem_desc = "Heals any brain damage the host may have."

/datum/borer_chem/omnizine
	chem = /datum/reagent/medicine/omnizine
	chemname = "omnizine"
	chem_desc = "Slowly heals all damage types in the host. Overdose will cause damage in all types instead."
	quantity = 5

/datum/borer_chem/ephedrine
	chem = /datum/reagent/medicine/ephedrine
	chemname = "ephedrine"
	chem_desc = "Increases the host's stun resistance and movement speed, at the cost of also giving hand cramps. Overdose deals toxin damage and inhibits breathing."

/datum/borer_chem/spacedrugs
	chem = /datum/reagent/drug/space_drugs
	chemname = "space drugs"
	chem_desc = "Induces extremely mild hallucinogenic affects in the host."
	chemuse = 75

/datum/borer_chem/happiness
	chem = /datum/reagent/drug/happiness
	chemname = "happiness"
	chem_desc = "Make your host feel ecstatic while causing minor brain damage."
	quantity = 9

/datum/borer_chem/creagent
	chem = /datum/reagent/colorful_reagent
	chemname = "colorful reagent"
	chem_desc = "Change the colour of your host. Known to be <i>extremely</i> annoying to hosts."
	chemuse = 100

/datum/borer_chem/ethanol
	chem = /datum/reagent/consumable/ethanol
	chemname = "ethanol"
	chem_desc = "The most potent alcoholic 'beverage', with the fastest toxicity."

/datum/borer_chem/formaldehyde
	chem = /datum/reagent/toxin/formaldehyde
	chemname = "formaldehyde"
	chem_desc = "A mildly potent toxin, more importantly used for its ability to preserve dead bodies and their organs."
	quantity = 5

/datum/borer_chem/nutriment
	chem = /datum/reagent/consumable/nutriment
	chemname = "nutriment"
	chem_desc = "A mix of all the nutrients needed to keep a host satiated."
	quantity = 7
