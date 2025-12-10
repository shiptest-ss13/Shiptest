// brute chems

/datum/chemical_reaction/indomide
	results = list(/datum/reagent/medicine/indomide = 4)
	required_reagents = list(/datum/reagent/copper = 1, /datum/reagent/acetone = 2,  /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/hadrakine
	results = list(/datum/reagent/medicine/hadrakine = 4)
	required_reagents = list(/datum/reagent/aluminium = 3, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1, /datum/reagent/toxin/acid = 1)
	mix_message = "The solution yields an astringent powder."

/datum/chemical_reaction/silfrine
	results = list(/datum/reagent/medicine/silfrine = 5)
	required_reagents = list(/datum/reagent/silver = 3, /datum/reagent/phenol = 1, /datum/reagent/carbon = 1, /datum/reagent/toxin/acid = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 2)
	required_temp = 450
	mix_message = "The solution rapidly bubbles, before yielding a dark blue compound"

// burn chems

/datum/chemical_reaction/leporazine
	results = list(/datum/reagent/medicine/leporazine = 2)
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/copper = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/alvitane
	results = list(/datum/reagent/medicine/alvitane = 4)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/silicon = 1, /datum/reagent/silver = 2)
	required_catalysts = list(/datum/reagent/cryptobiolin = 5)
	required_temp = 220
	is_cold_recipe = TRUE
	mix_message = "The solution quietly incorporates as the temperatures drop."

/datum/chemical_reaction/quardexane
	results = list(/datum/reagent/medicine/quardexane = 5)
	required_reagents = list(/datum/reagent/cryostylane = 3, /datum/reagent/bromine = 1, /datum/reagent/lye = 1)

/datum/chemical_reaction/ysiltane
	results = list(/datum/reagent/medicine/ysiltane = 5)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/silver = 1, /datum/reagent/sulfur = 1, /datum/reagent/hydrogen = 1, /datum/reagent/chlorine = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 10)
	mix_message = "The solution quickly fizzes, a small cloud of smoke coming out!"

/datum/chemical_reaction/ysiltane/on_reaction(datum/reagents/holder, created_volume)
	var/datum/effect_system/smoke_spread/bad/smoke = new (get_turf(holder.my_atom))
	smoke.set_up(1, src)
	smoke.start()
	qdel(smoke)

// toxin chems

/datum/chemical_reaction/calomel
	results = list(/datum/reagent/medicine/calomel = 2)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/chlorine = 1)
	required_temp = 374

/datum/chemical_reaction/charcoal
	results = list(/datum/reagent/medicine/charcoal = 2)
	required_reagents = list(/datum/reagent/ash = 1, /datum/reagent/consumable/sodiumchloride = 1)
	mix_message = "The mixture yields a fine black powder."
	required_temp = 380

/datum/chemical_reaction/pancrazine
	results = list(/datum/reagent/medicine/pancrazine = 3)
	required_reagents = list(/datum/reagent/nitrogen = 1, /datum/reagent/silicon = 1, /datum/reagent/potassium = 1)
	required_catalysts = list(/datum/reagent/ammonia = 5)

/datum/chemical_reaction/gjalrazine
	results = list(/datum/reagent/medicine/gjalrazine = 10)
	required_reagents = list(/datum/reagent/medicine/pancrazine = 3, /datum/reagent/carbon = 4, /datum/reagent/diethylamine = 3)
	required_catalysts = list(/datum/reagent/toxin/plasma = 1)

// oxygen chems

/datum/chemical_reaction/dexalin
	results = list(/datum/reagent/medicine/dexalin = 5)
	required_reagents = list(/datum/reagent/oxygen = 5)
	required_catalysts = list(/datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/salbutamol
	results = list(/datum/reagent/medicine/salbutamol = 5)
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/aluminium = 1, /datum/reagent/bromine = 1, /datum/reagent/ammonia = 1)
	required_catalysts = list(/datum/reagent/toxin/acid)

///radiation chems

/datum/chemical_reaction/potass_iodide
	results = list(/datum/reagent/medicine/potass_iodide = 2)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/iodine = 1)

/datum/chemical_reaction/pen_acid
	results = list(/datum/reagent/medicine/pen_acid = 6)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/chlorine = 1, /datum/reagent/ammonia = 1, /datum/reagent/toxin/formaldehyde = 1, /datum/reagent/sodium = 1, /datum/reagent/toxin/cyanide = 1)


///Multi-damage chems

/datum/chemical_reaction/synthflesh
	results = list(/datum/reagent/medicine/synthflesh = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/hadrakine = 1)

/datum/chemical_reaction/cryoxadone
	results = list(/datum/reagent/medicine/cryoxadone = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/acetone = 1, /datum/reagent/toxin/mutagen = 1)

/datum/chemical_reaction/cureall
	results = list(/datum/reagent/medicine/cureall = 3)
	required_reagents = list(/datum/reagent/medicine/alvitane = 1, /datum/reagent/medicine/indomide = 1, /datum/reagent/medicine/charcoal = 1)

/datum/chemical_reaction/cureall_alternative
	results = list(/datum/reagent/medicine/cureall = 5)
	required_reagents = list(/datum/reagent/medicine/panacea/effluvial = 5, /datum/reagent/toxin/plasma = 1)
	mix_message = "The plasma begins tinting the compound as it incorporates into the mix"

/datum/chemical_reaction/panacea
	results = list(/datum/reagent/medicine/panacea = 5)
	required_reagents = list(/datum/reagent/medicine/panacea/effluvial = 3, /datum/reagent/stable_plasma = 1, /datum/reagent/medicine/cryoxadone = 1)
	required_temp = 78
	is_cold_recipe = TRUE

/datum/chemical_reaction/hunter_extract
	results = list(/datum/reagent/medicine/hunter_extract = 5)
	required_reagents = list(/datum/reagent/consumable/vitfro = 1, /datum/reagent/medicine/puce_essence = 2,  /datum/reagent/toxin/plasma = 2)

///Blood chems

/datum/chemical_reaction/chitosan
	results = list(/datum/reagent/medicine/chitosan = 10)
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/consumable/sugar = 2, /datum/reagent/cryptobiolin = 1)
	required_temp = 380

/datum/chemical_reaction/chitosan_failure
	results = list(/datum/reagent/carbon = 1)
	required_reagents = list(/datum/reagent/medicine/chitosan = 1)
	required_temp = 405

/datum/chemical_reaction/salglu_solution
	results = list(/datum/reagent/medicine/salglu_solution = 3)
	required_reagents = list(/datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/water = 1, /datum/reagent/consumable/sugar = 1)

///Organ chems

/datum/chemical_reaction/oculine
	results = list(/datum/reagent/medicine/oculine = 3)
	required_reagents = list(/datum/reagent/medicine/charcoal = 1, /datum/reagent/carbon = 1, /datum/reagent/hydrogen = 1)
	mix_message = "The mixture bubbles noticeably and becomes a dark grey color!"

/datum/chemical_reaction/inacusiate
	results = list(/datum/reagent/medicine/inacusiate = 2)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/charcoal = 1)
	mix_message = "The mixture sputters loudly and becomes a light grey color!"

/datum/chemical_reaction/mannitol
	results = list(/datum/reagent/medicine/mannitol = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/hydrogen = 1, /datum/reagent/water = 1)
	mix_message = "The solution slightly bubbles, becoming thicker."

/datum/chemical_reaction/neurine
	results = list(/datum/reagent/medicine/neurine = 3)
	required_reagents = list(/datum/reagent/medicine/mannitol = 1, /datum/reagent/acetone = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/corazone
	results = list(/datum/reagent/medicine/corazone = 3)
	required_reagents = list(/datum/reagent/phenol = 2, /datum/reagent/lithium = 1)

///pain chems

/datum/chemical_reaction/tramal
	results = list(/datum/reagent/medicine/tramal = 2) // these make me kinda wish i knew irl chem so i could have better recipes.
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 1)
	required_catalysts = list(/datum/reagent/ammonia = 2)
	required_temp = 340

/datum/chemical_reaction/morphine
	results = list(/datum/reagent/medicine/morphine = 2)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/consumable/ethanol = 1, /datum/reagent/oxygen = 1)
	required_temp = 480


/datum/chemical_reaction/carfen
	results = list(/datum/reagent/medicine/carfencadrizine = 4)
	required_reagents = list(/datum/reagent/medicine/dimorlin = 1, /datum/reagent/medicine/synaptizine = 1, /datum/reagent/consumable/sugar = 2)
	required_catalysts = list(/datum/reagent/toxin/plasma = 2)
	required_temp = 127
	is_cold_recipe = TRUE

/datum/chemical_reaction/dimorlin
	results = list(/datum/reagent/medicine/dimorlin = 2, /datum/reagent/hydrogen = 2)
	required_reagents = list(/datum/reagent/carbon = 3, /datum/reagent/diethylamine = 1, /datum/reagent/oxygen = 1, /datum/reagent/phenol = 1)
	required_temp = 730
	mix_message = "The mixture rapidly incorporates, leaving a layer of liquid hydrogen atop!"

/// status chems

/datum/chemical_reaction/spaceacillin
	results = list(/datum/reagent/medicine/spaceacillin = 2)
	required_reagents = list(/datum/reagent/cryptobiolin = 1, /datum/reagent/medicine/epinephrine = 1)

/datum/chemical_reaction/synaptizine
	results = list(/datum/reagent/medicine/synaptizine = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/mutadone
	results = list(/datum/reagent/medicine/mutadone = 3)
	required_reagents = list(/datum/reagent/toxin/mutagen = 1, /datum/reagent/acetone = 1, /datum/reagent/bromine = 1)

/datum/chemical_reaction/antihol
	results = list(/datum/reagent/medicine/antihol = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/copper = 1)

/datum/chemical_reaction/haloperidol
	results = list(/datum/reagent/medicine/haloperidol = 5)
	required_reagents = list(/datum/reagent/chlorine = 1, /datum/reagent/fluorine = 1, /datum/reagent/aluminium = 1, /datum/reagent/medicine/potass_iodide = 1, /datum/reagent/fuel/oil = 1)

/datum/chemical_reaction/modafinil
	results = list(/datum/reagent/medicine/modafinil = 5)
	required_reagents = list(/datum/reagent/diethylamine = 1, /datum/reagent/ammonia = 1, /datum/reagent/phenol = 1, /datum/reagent/acetone = 1, /datum/reagent/toxin/acid = 1)
	required_catalysts = list(/datum/reagent/bromine = 1) // as close to the real world synthesis as possible

/datum/chemical_reaction/psicodine
	results = list(/datum/reagent/medicine/psicodine = 5)
	required_reagents = list(/datum/reagent/medicine/mannitol = 2, /datum/reagent/water = 2, /datum/reagent/impedrezene = 1)

/datum/chemical_reaction/diphenhydramine
	results = list(/datum/reagent/medicine/diphenhydramine = 4)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/carbon = 1, /datum/reagent/bromine = 1, /datum/reagent/diethylamine = 1, /datum/reagent/consumable/ethanol = 1)
	mix_message = "The mixture dries into a pale blue powder."

/datum/chemical_reaction/lithium_carbonate
	results = list(/datum/reagent/medicine/lithium_carbonate = 3)
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/carbon = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/synaptizine
	results = list(/datum/reagent/medicine/synaptizine = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1, /datum/reagent/water = 1)

/// crit chems

/datum/chemical_reaction/atropine
	results = list(/datum/reagent/medicine/atropine = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/acetone = 1, /datum/reagent/diethylamine = 1, /datum/reagent/phenol = 1, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/epinephrine
	results = list(/datum/reagent/medicine/epinephrine = 6)
	required_reagents = list(/datum/reagent/phenol = 1, /datum/reagent/acetone = 1, /datum/reagent/diethylamine = 1, /datum/reagent/oxygen = 1, /datum/reagent/chlorine = 1, /datum/reagent/hydrogen = 1)

///things im not going to organize right now (This means they should be in another file)

/datum/chemical_reaction/rezadone
	results = list(/datum/reagent/medicine/rezadone = 3)
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 1, /datum/reagent/cryptobiolin = 1, /datum/reagent/copper = 1)

/datum/chemical_reaction/stasis
	results = list(/datum/reagent/medicine/stasis = 5)
	required_reagents = list(/datum/reagent/phenol = 1, /datum/reagent/copper = 1, /datum/reagent/medicine/salglu_solution = 3)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)
	required_temp = 207
	is_cold_recipe = TRUE

/datum/chemical_reaction/liquid_solder
	results = list(/datum/reagent/medicine/liquid_solder = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/copper = 1, /datum/reagent/silver = 1)
	required_temp = 370
	mix_message = "The mixture becomes a metallic slurry."

/datum/chemical_reaction/bonefixingjuice
	results = list(/datum/reagent/medicine/bonefixingjuice = 3)
	required_reagents = list(/datum/reagent/consumable/entpoly = 1, /datum/reagent/calcium = 1, /datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/mine_salve
	results = list(/datum/reagent/medicine/mine_salve = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/water = 1, /datum/reagent/iron = 1)

/datum/chemical_reaction/mine_salve2
	results = list(/datum/reagent/medicine/mine_salve = 15)
	required_reagents = list(/datum/reagent/toxin/plasma = 5, /datum/reagent/iron = 5, /datum/reagent/consumable/sugar = 1) // A sheet of plasma, a twinkie and a sheet of metal makes four of these

/datum/chemical_reaction/ephedrine
	results = list(/datum/reagent/medicine/ephedrine = 4)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/fuel/oil = 1, /datum/reagent/hydrogen = 1, /datum/reagent/diethylamine = 1)
	mix_message = "The solution fizzes and gives off toxic fumes."

/datum/chemical_reaction/pure_soulus_dust_hollow
	results = list(/datum/reagent/medicine/soulus/pure = 20,)
	required_reagents = list(/datum/reagent/medicine/soulus = 20, /datum/reagent/water/hollowwater = 10)

/datum/chemical_reaction/pure_soulus_dust_holy
	results = list(/datum/reagent/medicine/soulus/pure = 20,)
	required_reagents = list(/datum/reagent/medicine/soulus = 20, /datum/reagent/water/holywater = 10)

/datum/chemical_reaction/chartreuse
	results = list(/datum/reagent/medicine/chartreuse = 10)
	required_reagents = list(/datum/reagent/medicine/puce_essence = 5, /datum/reagent/consumable/tinlux = 5, /datum/reagent/consumable/entpoly = 1)
