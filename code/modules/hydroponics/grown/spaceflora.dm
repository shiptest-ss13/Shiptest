/obj/structure/flora/ash/space/voidmelon
	icon_state = "melon"
	name = "Grown void plant"
	desc = "A cluster of strange plants with melonlike fruit attached to their vines."
	harvested_name = "Void plant"
	harvested_desc = "A cluster of strange plants melonlike fruits growing from their vines."
	harvest = /obj/item/reagent_containers/food/snacks/grown/voidmelon
	needs_sharp_harvest = FALSE
	harvest_amount_high = 2
	harvest_time = 10
	harvest_message_low = "You pick a void melon."
	harvest_message_med = "You pick several void melons." //shouldn't show up, because you can't get more than two
	harvest_message_high = "You pick a pair of void melons."
	regrowth_time_low = 4800
	regrowth_time_high = 7200
	num_sprites = 1

/obj/structure/flora/ash/space/voidmelon/Initialize()
	. = ..()
	base_icon = "melon"
	icon_state = base_icon
/obj/item/seeds/voidmelon
	name = "pack of voidmelon seeds"
	desc = "These seeds grow into voidmelon plants."
	icon_state = "seed-voidmelon"
	species = "voidmelon"
	plantname = "voidmelon Vines"
	product = /obj/item/reagent_containers/food/snacks/grown/watermelon
	lifespan = 50
	endurance = 40
	growing_icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_dead = "voidmelon-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/oxygen = 0.1, /datum/reagent/consumable/nutriment = 0.05)
	research = PLANT_RESEARCH_TIER_2

/obj/item/reagent_containers/food/snacks/grown/voidmelon
	seed = /obj/item/seeds/voidmelon
	name = "voidmelon"
	desc = "It weighs less than the size would lead you to think."
	icon_state = "voidmelon"
	dried_type = null
	w_class = WEIGHT_CLASS_SMALL
	filling_color = "#008000"
	bitesize_mod = 3
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 0)
	wine_power = 40
	wine_flavor = "the breath of life" //zedaedit: wine flavor
