//Not to be confused with /obj/item/reagent_containers/food/drinks/bottle

/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical/beakers.dmi'
	world_file = 'icons/obj/chemical/beakers_world.dmi'
	icon_state = "bottle"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	item_state = "atoxinbottle"
	possible_transfer_amounts = list(5,10,15,25,30)
	volume = 30
	fill_icon_thresholds = list(0, 10, 30, 50, 70)
	can_have_cap = TRUE
	cap_icon_state = "bottle_cap"
	cap_on = TRUE
	drop_sound = 'sound/items/handling/beaker_drop.ogg'
	pickup_sound =  'sound/items/handling/beaker_pickup.ogg'
	custom_materials = list(/datum/material/glass = 200)
	var/label = null

	/obj/item/reagent_containers/glass/bottle/examine(mob/user)
		. = ..()
		if(!isnull(label))
			. += custom_boxed_message("red_box center", span_red((span_bold(label))))

/obj/item/reagent_containers/glass/bottle/epinephrine
	name = "epinephrine bottle"
	desc = "A small bottle of epinephrine."
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30)
	label = "A label states: Sympathomimetic - Keep dose under 30 units."

/obj/item/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins."
	list_reagents = list(/datum/reagent/toxin = 30)
	label = "A label states: TOXINS - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide."
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)
	label = "A label states: POISON - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/spewium
	name = "spewium bottle"
	desc = "A small bottle of spewium."
	list_reagents = list(/datum/reagent/toxin/spewium = 30)

/obj/item/reagent_containers/glass/bottle/rezadone
	name = "rezadone bottle"
	desc = "A small bottle of rezadone."
	list_reagents = list(/datum/reagent/medicine/rezadone = 30)
	label = "A label states: Dermal-Restoring Antibiotic - Dose of 10 units at once for extreme infection. Dose of 5u at once for dermal husking. Keep under 30 units."

/obj/item/reagent_containers/glass/bottle/morphine
	name = "morphine bottle"
	desc = "A small bottle of morphine."
	list_reagents = list(/datum/reagent/medicine/morphine = 30)
	label = "A label states: Analgesic Opioid - Dosage must remain under 30 units."

/obj/item/reagent_containers/glass/bottle/dimorlin
	name = "dimorlin bottle"
	desc = "A small bottle of dimorlin."
	list_reagents = list(/datum/reagent/medicine/dimorlin = 30)
	label = "A label states: Analgesic Opioid - Dosage must remain under 15 units."

/obj/item/reagent_containers/glass/bottle/tramal
	name = "tramal bottle"
	desc = "A small bottle of tramal."
	list_reagents = list(/datum/reagent/medicine/tramal = 30)
	label = "A label states: Analgesic Opioid - Dosage must remain under 35 units."

/obj/item/reagent_containers/glass/bottle/chitosan
	name = "chitosan bottle"
	desc = "A small bottle of chitosan."
	list_reagents = list(/datum/reagent/medicine/chitosan = 30)
	label = "A label states: Coagulant - Dosage must remain under 20 units."

/obj/item/reagent_containers/glass/bottle/painkiller_booze
	name = "'painkiller' bottle"
	desc = "A small bottle of an unmarked substance called 'painkiller.' Will this really work?"
	list_reagents = list(/datum/reagent/consumable/ethanol/painkiller = 30)

/obj/item/reagent_containers/glass/bottle/chloralhydrate
	name = "chloral hydrate bottle"
	desc = "A small bottle of Choral Hydrate."
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/glass/bottle/mannitol
	name = "mannitol bottle"
	desc = "A small bottle of Mannitol."
	list_reagents = list(/datum/reagent/medicine/mannitol = 30)
	label = "A label states: Osmotic Diuretic - Brain Damage Treatment - No dosage threshold. "

/obj/item/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/glass/bottle/plasma
	name = "liquid plasma bottle"
	desc = "A small bottle of liquid plasma. Extremely toxic and reacts with micro-organisms inside blood."
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/glass/bottle/synaptizine
	name = "synaptizine bottle"
	desc = "A small bottle of synaptizine."
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle of ammonia."
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle of diethylamine."
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/glass/bottle/facid
	name = "Fluorosulfuric Acid Bottle"
	desc = "A small bottle. Contains a small amount of fluorosulfuric acid."
	list_reagents = list(/datum/reagent/toxin/acid/fluacid = 30)

/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)
	can_have_cap = FALSE
	cap_icon_state = null
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/glass/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

/obj/item/reagent_containers/glass/bottle/traitor
	name = "syndicate bottle"
	desc = "A small bottle. Contains a random nasty chemical."
	var/extra_reagent = null

/obj/item/reagent_containers/glass/bottle/traitor/Initialize()
	. = ..()
	extra_reagent = pick(/datum/reagent/toxin/polonium, /datum/reagent/toxin/histamine, /datum/reagent/toxin/formaldehyde, /datum/reagent/toxin/venom, /datum/reagent/toxin/cyanide)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/glass/bottle/polonium
	name = "polonium bottle"
	desc = "A small bottle. Contains Polonium."
	list_reagents = list(/datum/reagent/toxin/polonium = 30)

/obj/item/reagent_containers/glass/bottle/magillitis
	name = "magillitis bottle"
	desc = "A small bottle. Contains a serum known only as 'magillitis'."
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/glass/bottle/venom
	name = "venom bottle"
	desc = "A small bottle. Contains Venom."
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/glass/bottle/formaldehyde
	name = "formaldehyde bottle"
	desc = "A small bottle. Contains formaldehyde, a chemical that prevents organs from decaying."
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/glass/bottle/initropidril
	name = "initropidril bottle"
	desc = "A small bottle. Contains initropidril."
	list_reagents = list(/datum/reagent/toxin/initropidril = 30)
	label = "A label states: POISON - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/pancuronium
	name = "pancuronium bottle"
	desc = "A small bottle. Contains pancuronium."
	list_reagents = list(/datum/reagent/toxin/pancuronium = 30)
	label = "A label states: TOXIN - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/sodium_thiopental
	name = "sodium thiopental bottle"
	desc = "A small bottle. Contains sodium thiopental."
	list_reagents = list(/datum/reagent/toxin/sodium_thiopental = 30)
	label = "A label states: POWERFUL SEDATIVE - UTILIZE CAUTION"

/obj/item/reagent_containers/glass/bottle/coniine
	name = "coniine bottle"
	desc = "A small bottle. Contains coniine."
	list_reagents = list(/datum/reagent/toxin/coniine = 30)
	label = "A label states: TOXIN - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/curare
	name = "curare bottle"
	desc = "A small bottle. Contains curare."
	list_reagents = list(/datum/reagent/toxin/curare = 30)
	label = "A label states: TOXIN - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/amanitin
	name = "amanitin bottle"
	desc = "A small bottle. Contains amanitin."
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)
	label = "A label states: TOXIN - DO NOT INGEST"

/obj/item/reagent_containers/glass/bottle/histamine
	name = "histamine bottle"
	desc = "A small bottle. Contains Histamine."
	list_reagents = list(/datum/reagent/toxin/histamine = 30)

/obj/item/reagent_containers/glass/bottle/diphenhydramine
	name = "antihistamine bottle"
	desc = "A small bottle of diphenhydramine."
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 30)
	label = "A label states: Antihistamine - Utilize in case of allergic reaction."

/obj/item/reagent_containers/glass/bottle/potass_iodide
	name = "anti-radiation bottle"
	desc = "A small bottle of potassium iodide."
	list_reagents = list(/datum/reagent/medicine/potass_iodide = 30)

/obj/item/reagent_containers/glass/bottle/salglu_solution
	name = "saline-glucose solution bottle"
	desc = "A small bottle of saline-glucose solution."
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 30)

/obj/item/reagent_containers/glass/bottle/atropine
	name = "atropine bottle"
	desc = "A small bottle of atropine."
	list_reagents = list(/datum/reagent/medicine/atropine = 30)
	label = "A label states: Anticholinergic - Patient Stabilizer - Dose must remain under 35 units."

/obj/item/reagent_containers/glass/bottle/romerol
	name = "romerol bottle"
	desc = "A small bottle of Romerol."
	list_reagents = list(/datum/reagent/romerol = 30)
	label = "A brightly colored label, with many warning symbols states: DO NOT INGEST UNDER ANY CIRCUMSTANCES."

/obj/item/reagent_containers/glass/bottle/random_virus
	name = "Experimental disease culture bottle"
	desc = "A small bottle. Contains an untested viral culture in synthblood medium."
	spawned_disease = /datum/disease/advance/random
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "A small bottle. Contains XY-rhinovirus culture in synthblood medium."
	spawned_disease = /datum/disease/advance/cold
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "A small bottle. Contains H13N1 flu virion culture in synthblood medium."
	spawned_disease = /datum/disease/advance/flu
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "A small bottle. Contains a retrovirus culture in a synthblood medium."
	spawned_disease = /datum/disease/dna_retrovirus
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS+ culture in synthblood medium."//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "A small bottle. Contains Gravitokinetic Bipotential SADS- culture in synthblood medium."//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "A small bottle. Contains Cryptococcus Cosmosis culture in synthblood medium."
	spawned_disease = /datum/disease/brainrot
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "A small bottle. Contains a small dosage of Fukkos Miracos."
	spawned_disease = /datum/disease/magnitis
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/anxiety
	name = "Severe Anxiety culture bottle"
	desc = "A small bottle. Contains a sample of Lepidopticides."
	spawned_disease = /datum/disease/anxiety
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/fluspanish
	name = "Spanish flu culture bottle"
	desc = "A small bottle. Contains a sample of Inquisitius."
	spawned_disease = /datum/disease/fluspanish
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/tuberculosis
	name = "Fungal Tuberculosis culture bottle"
	desc = "A small bottle. Contains a sample of Fungal Tubercle bacillus."
	spawned_disease = /datum/disease/tuberculosis
	label = "A brightly colored label states: VIRAL CULTURE. DO NOT INGEST."

/obj/item/reagent_containers/glass/bottle/tuberculosiscure
	name = "BVAK bottle"
	desc = "A small bottle containing Bio Virus Antidote Kit."
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 30)
	label = "A label states: Virus Antidote - Antidote for Fungal Tuberculosis."

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/glass/bottle/hydrogen
	name = "hydrogen bottle"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/glass/bottle/lithium
	name = "lithium bottle"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/glass/bottle/carbon
	name = "carbon bottle"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/glass/bottle/nitrogen
	name = "nitrogen bottle"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/glass/bottle/oxygen
	name = "oxygen bottle"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/glass/bottle/fluorine
	name = "fluorine bottle"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/glass/bottle/sodium
	name = "sodium bottle"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/glass/bottle/aluminium
	name = "aluminium bottle"
	list_reagents = list(/datum/reagent/aluminium = 30)

/obj/item/reagent_containers/glass/bottle/silicon
	name = "silicon bottle"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/glass/bottle/phosphorus
	name = "phosphorus bottle"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/glass/bottle/sulfur
	name = "sulfur bottle"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/glass/bottle/chlorine
	name = "chlorine bottle"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/glass/bottle/potassium
	name = "potassium bottle"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/glass/bottle/iron
	name = "iron bottle"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/glass/bottle/copper
	name = "copper bottle"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/glass/bottle/mercury
	name = "mercury bottle"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/glass/bottle/radium
	name = "radium bottle"
	list_reagents = list(/datum/reagent/uranium/radium = 30)

/obj/item/reagent_containers/glass/bottle/water
	name = "water bottle"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/glass/bottle/ethanol
	name = "ethanol bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/glass/bottle/sugar
	name = "sugar bottle"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/glass/bottle/sacid
	name = "sulphuric acid bottle"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/glass/bottle/welding_fuel
	name = "welding fuel bottle"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/glass/bottle/silver
	name = "silver bottle"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/glass/bottle/iodine
	name = "iodine bottle"
	list_reagents = list(/datum/reagent/iodine = 30)

/obj/item/reagent_containers/glass/bottle/bromine
	name = "bromine bottle"
	list_reagents = list(/datum/reagent/bromine = 30)

/obj/item/reagent_containers/glass/bottle/thermite
	name = "thermite bottle"
	list_reagents = list(/datum/reagent/thermite = 30)

/obj/item/reagent_containers/glass/bottle/nitroglycerin
	name = "nitroglycerin bottle"
	desc = "A small bottle of nitroglycerin."
	list_reagents = list(/datum/reagent/nitroglycerin = 30)
	label = "A red warning label states: NITRATED GLYCEROL - EXPLOSIVE - UTILIZE CAUTION."

/obj/item/reagent_containers/glass/bottle/epinephrine
	name = "epinephrine bottle"
	desc = "A small bottle. Contains epinephrine - used to stabilize patients."
	volume = 50
	list_reagents = list(/datum/reagent/medicine/epinephrine = 50)

/obj/item/reagent_containers/glass/bottle/indomide
	name = "indomide bottle"
	desc = "A small bottle. Contains indomide, used to treat minor bruising."
	volume = 50
	list_reagents = list(/datum/reagent/medicine/indomide = 50)

/obj/item/reagent_containers/glass/bottle/alvitane
	name = "alvitane bottle"
	desc = "A small bottle. Contains alvitane, used for minor burns and skin damage. Best used as injection!"
	volume = 50
	list_reagents = list(/datum/reagent/medicine/alvitane = 50)

/obj/item/reagent_containers/glass/bottle/charcoal
	name = "charcoal bottle"
	desc = "A small bottle of charcoal, which removes toxins and other chemicals from the bloodstream."
	list_reagents = list(/datum/reagent/medicine/charcoal = 30)

/obj/item/reagent_containers/glass/bottle/dexalin
	name = "dexalin bottle"
	desc = "A small bottle. Contains dexalin, used to treat minor oxygen deprivation."
	volume = 50
	list_reagents = list(/datum/reagent/medicine/dexalin = 50)
	label = "A label states: Dose must remain under 30 units."

/obj/item/reagent_containers/glass/bottle/gjalrazine
	name = "gjalrazine bottle"
	desc = "A small bottle. Contains gjalrazine, used to treat major toxic damage."
	volume = 50
	list_reagents = list(/datum/reagent/medicine/gjalrazine = 50)
	label = "A label states: Dose must remain under 12 units."

/obj/item/reagent_containers/glass/bottle/cureall
	name = "cureall bottle"
	desc = "A small bottle. Contains cureall, used to treat small amounts of brute, burn, and toxins."
	volume = 50
	list_reagents = list(/datum/reagent/medicine/cureall = 50)
	label = "A label states: Dose must remain under 30 units."

/obj/item/reagent_containers/glass/bottle/epinephrine/sleeper
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/indomide/sleeper
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/alvitane/sleeper
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/charcoal/sleeper
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/dexalin/sleeper
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/morphine/sleeper
	cap_on = FALSE
