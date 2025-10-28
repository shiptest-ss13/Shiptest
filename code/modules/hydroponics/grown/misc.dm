// Starthistle
/obj/item/seeds/starthistle
	name = "pack of starthistle seeds"
	desc = "A robust species of weed that often springs up in-between the cracks of spaceship parking lots."
	icon_state = "seed-starthistle"
	species = "starthistle"
	plantname = "Starthistle"
	lifespan = 70
	endurance = 50 // damm pesky weeds
	maturation = 5
	production = 1
	yield = 2
	potency = 25
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy)
	mutatelist = list(/obj/item/seeds/starthistle/corpse_flower, /obj/item/seeds/galaxythistle)
	research = PLANT_RESEARCH_TIER_0

/obj/item/seeds/starthistle/harvest(mob/user)
	var/obj/machinery/hydroponics/parent = loc
	var/seed_count = yield
	if(prob(getYield() * 20))
		seed_count++
		var/output_loc = parent.Adjacent(user) ? user.loc : parent.loc
		for(var/i in 1 to seed_count)
			var/obj/item/seeds/starthistle/harvestseeds = Copy()
			harvestseeds.forceMove(output_loc)

	parent.update_tray()

// Corpse flower
/obj/item/seeds/starthistle/corpse_flower
	name = "pack of corpse flower seeds"
	desc = "A species of plant that emits a horrible odor. The odor stops being produced in difficult atmospheric conditions."
	icon_state = "seed-corpse-flower"
	species = "corpse-flower"
	plantname = "Corpse flower"
	production = 2
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	genes = list()
	mutatelist = list()
	research = PLANT_RESEARCH_TIER_2
	reagents_add = list(/datum/reagent/toxin/formaldehyde = 0.01, /datum/reagent/toxin/zombiepowder = 0.01, /datum/reagent/liquidgibs = 0.2)//restores, someone must have removed them at some point

//Galaxy Thistle
/obj/item/seeds/galaxythistle
	name = "pack of galaxythistle seeds"
	desc = "An impressive species of weed that is thought to have evolved from the simple milk thistle. Contains flavolignans that can help repair a damaged liver."
	icon_state = "seed-galaxythistle"
	species = "galaxythistle"
	plantname = "Galaxythistle"
	product = /obj/item/food/grown/galaxythistle
	lifespan = 70
	endurance = 40
	maturation = 3
	production = 2
	yield = 2
	potency = 25
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy, /datum/plant_gene/trait/invasive)
	mutatelist = list()
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/medicine/silibinin = 0.1)
	research = PLANT_RESEARCH_TIER_3

/obj/item/seeds/galaxythistle/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/trait/invasive, PLANT_GENE_REMOVABLE)

/obj/item/food/grown/galaxythistle
	seed = /obj/item/seeds/galaxythistle
	name = "galaxythistle flower head"
	desc = "This spiny cluster of florets reminds you of the highlands."
	icon_state = "galaxythistle"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	wine_power = 35
	wine_flavor = "the vast and infinite cosmos" //WS edit: new wine flavors
	tastes = list("thistle" = 2, "artichoke" = 1)

// Cabbage
/obj/item/seeds/cabbage
	name = "pack of cabbage seeds"
	desc = "These seeds grow into cabbages."
	icon_state = "seed-cabbage"
	species = "cabbage"
	plantname = "Cabbages"
	product = /obj/item/food/grown/cabbage
	lifespan = 50
	endurance = 25
	maturation = 3
	production = 5
	yield = 4
	growthstages = 1
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	mutatelist = list(/obj/item/seeds/replicapod)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/cabbage
	seed = /obj/item/seeds/cabbage
	name = "cabbage"
	desc = "Ewwwwwwwwww. Cabbage."
	icon_state = "cabbage"
	foodtypes = VEGETABLES
	wine_power = 20

// Sugarcane
/obj/item/seeds/sugarcane
	name = "pack of sugarcane seeds"
	desc = "These seeds grow into sugarcane."
	icon_state = "seed-sugarcane"
	species = "sugarcane"
	plantname = "Sugarcane"
	product = /obj/item/food/grown/sugarcane
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 60
	endurance = 50
	maturation = 3
	yield = 4
	growthstages = 2
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.04, /datum/reagent/consumable/sugar)
	mutatelist = list(/obj/item/seeds/bamboo)

/obj/item/food/grown/sugarcane
	seed = /obj/item/seeds/sugarcane
	name = "sugarcane"
	desc = "Sickly sweet."
	icon_state = "sugarcane"
	filling_color = "#FFD700"
	bite_consumption_mod = 2
	foodtypes = VEGETABLES | SUGAR
	distill_reagent = /datum/reagent/consumable/ethanol/rum

// Gatfruit
/obj/item/seeds/gatfruit
	name = "pack of gatfruit seeds"
	desc = "These seeds grow into .357 revolvers."
	icon_state = "seed-gatfruit"
	species = "gatfruit"
	plantname = "Gatfruit Tree"
	product = /obj/item/food/grown/shell/gatfruit
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 20
	endurance = 20
	maturation = 40
	production = 10
	yield = 2
	potency = 60
	growthstages = 2
	rarity = 60 // Obtainable only with xenobio+superluck.
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	reagents_add = list(/datum/reagent/sulfur = 0.1, /datum/reagent/carbon = 0.1, /datum/reagent/nitrogen = 0.07, /datum/reagent/potassium = 0.05)
	research = PLANT_RESEARCH_TIER_5

/obj/item/food/grown/shell/gatfruit
	seed = /obj/item/seeds/gatfruit
	name = "gatfruit"
	desc = "It smells like burning."
	icon_state = "gatfruit"
	trash_type = /obj/item/gun/ballistic/revolver
	bite_consumption_mod = 2
	foodtypes = FRUIT
	tastes = list("gunpowder" = 1)
	wine_power = 90 //It burns going down, too.
	wine_flavor = "the most powerful handgun in the world" //WS edit: new wine flavors

// aloe
/obj/item/seeds/aloe
	name = "pack of aloe seeds"
	desc = "These seeds grow into aloe."
	icon_state = "seed-aloe"
	species = "aloe"
	plantname = "Aloe"
	product = /obj/item/food/grown/aloe
	lifespan = 60
	endurance = 25
	maturation = 4
	production = 4
	yield = 6
	growthstages = 5
	growing_icon = 'icons/obj/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.05)

/obj/item/food/grown/aloe
	seed = /obj/item/seeds/aloe
	name = "aloe"
	desc = "Cut leaves from the aloe plant."
	icon_state = "aloe"
	bite_consumption_mod = 5
	foodtypes = VEGETABLES
	juice_results = list(/datum/reagent/consumable/aloejuice = 0)
	distill_reagent = /datum/reagent/consumable/ethanol/tequila

/obj/item/food/grown/aloe/microwave_act(obj/machinery/microwave/M)
	new /obj/item/stack/medical/aloe(drop_location(), 2)
	qdel(src)

/obj/item/seeds/seaweed
	name = "pack of seaweed seeds" //dude, i pinkypromise! of course seaweed has seeds :)
	desc = "These seeds grow into seaweed."
	icon_state = "seed-seaweed"
	species = "seaweed"
	plantname = "seaweeds"
	product = /obj/item/food/grown/seaweed
	maturation = 2
	yield = 1
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	growthstages = 3
	icon_grow = "seaweed-grow"
	icon_dead = "seaweed-dead"
	reagents_add = list(/datum/reagent/water = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.2)

/obj/item/food/grown/seaweed
	seed = /obj/item/seeds/seaweed
	name = "seaweed"
	desc = "It's so rubbery... is this safe to eat?"
	icon_state = "seaweed"
	bite_consumption_mod = 1
	foodtypes = VEGETABLES
	grind_results = list(/datum/reagent/water = 1, /datum/reagent/consumable/sodiumchloride = 2)

/obj/item/food/grown/seaweed/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/grown/seaweed/sheet)

/obj/item/food/grown/seaweed/sheet
	name = "seaweed sheet"
	desc = "A dried sheet of seaweed used for making sushi."
	icon_state = "seaweedsheet"
	food_reagents = list(
	/datum/reagent/consumable/nutriment = 1,
	/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("seaweed" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
