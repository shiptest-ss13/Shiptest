/obj/structure/flora/ash/proc/consume(user)
	if(harvested)
		return 0

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src, .proc/regrow), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/whitesands
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'

/obj/structure/flora/ash/whitesands/fern
	name = "royal fern"
	desc = "A species of purplish fern with highly fibrous leaves, found in moisture-rich enviroments."
	harvested_name = "fern stems"
	harvested_desc = "A few royal fern stems, missing their leaves."
	icon_state = "fern" //needs new sprites.
	harvested_name = "cave fern stems"
	harvested_desc = "A few cave fern stems, missing their leaves."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fern
	harvest_amount_high = 6
	harvest_message_low = "You clip a single, suitable leaf."
	harvest_message_med = "You clip a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You clip quite a lot of suitable leaves."
	regrowth_time_low = 3000
	regrowth_time_high = 5400
	num_sprites = 1

/obj/structure/flora/ash/whitesands/fireblossom
	name = "fire blossom"
	desc = "An odd flower that grows commonly near bodies of lava. The leaves can be ground up for a substance resembling capsaicin."
	icon_state = "fireblossom"
	harvested_name = "fire blossom stems"
	harvested_desc = "A few fire blossom stems, missing their flowers."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fireblossom
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_message_low = "You pluck a single, suitable flower."
	harvest_message_med = "You pluck a number of flowers, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable flowers."
	regrowth_time_low = 2500
	regrowth_time_high = 4000
	num_sprites = 2

/obj/structure/flora/ash/whitesands/puce
	name = "Pucestal Growth"
	desc = "A collection of puce-colored crystal growths. This highly-invasive but surprisingly delicate \"lifeform\" can be found all over the frontier of known space."
	icon_state = "puce"
	harvested_name = "Pucestal fragments"
	harvested_desc = "A few pucestal fragments, slowly regrowing."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/puce
	harvest_amount_high = 6
	harvest_message_low = "You work a single crystal free, discarding several impure or broken ones."
	harvest_message_med = "You cut a number of crystals free, leaving a few small or damaged crystals behind."
	harvest_message_high = "There are a number of large, pure crystals- you cut free quite a harvest."
	regrowth_time_low = 10 MINUTES 				// Fast, for a crystal
	regrowth_time_high = 20 MINUTES
	num_sprites = 1


//SNACKS

/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'

/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fern
	name = "fern leaf"
	desc = "A leaf from a royal-colored fern."
	icon_state = "fern"
	seed = /obj/item/seeds/lavaland/whitesands/fern
	wine_power = 10

/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fireblossom
	name = "fire blossom"
	desc = "A flower from a fire blossom."
	icon_state = "fireblossom"
	seed = /obj/item/seeds/lavaland/whitesands/fireblossom
	wine_power = 40

/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/puce
	name = "Pucestal Crystal"
	desc = "A crystal from a pucestal growth."
	icon_state = "puce"
	seed = /obj/item/seeds/lavaland/whitesands/puce
	wine_power = 0		// It's a crystal

/obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/puce/canconsume(mob/eater, mob/user)
	return FALSE

//SEEDS

/obj/item/seeds/lavaland/whitesands
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'
	growing_icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'
	species = "fern" // begone test
	growthstages = 2

/obj/item/seeds/lavaland/whitesands/fern
	name = "pack of royal fern seeds"
	desc = "These seeds grow into royal ferns."
	plantname = "Royal Fern"
	icon_state = "seed_fern"
	species = "fern"
	growthstages = 2
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fern
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/plant_type/weed_hardy)
	reagents_add = list(/datum/reagent/ash_fibers = 0.10)

/obj/item/seeds/lavaland/whitesands/fern/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)

/obj/item/seeds/lavaland/whitesands/fireblossom
	name = "pack of fire blossom seeds"
	desc = "These seeds grow into fire blossoms."
	plantname = "Fire Blossom"
	icon_state = "seed_fireblossom"
	species = "fireblossom"
	growthstages = 3
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.03, /datum/reagent/carbon = 0.05, /datum/reagent/consumable/pyre_elementum = 0.08)

/obj/item/seeds/lavaland/whitesands/puce
	name = "puce cluster"
	desc = "These crystals can be grown into larger crystals."
	plantname = "Pucestal Growth"
	icon_state = "cluster_puce"
	species = "puce"
	growthstages = 3
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/whitesands/puce
	genes = list(/datum/plant_gene/trait/plant_type/crystal)
	reagents_add = list(/datum/reagent/medicine/puce_essence = 0.10)

/obj/item/seeds/lavaland/whitesands/puce/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_REMOVABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_REMOVABLE)

		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_EXTRACTABLE)
