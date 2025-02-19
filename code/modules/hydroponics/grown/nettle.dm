/obj/item/seeds/nettle
	name = "pack of nettle seeds"
	desc = "These seeds grow into nettles."
	icon_state = "seed-nettle"
	species = "nettle"
	plantname = "Nettles"
	product = /obj/item/reagent_containers/food/snacks/grown/nettle
	lifespan = 30
	endurance = 40 // tuff like a toiger
	yield = 4
	growthstages = 5
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/plant_type/weed_hardy, /datum/plant_gene/trait/attack/nettle_attack, /datum/plant_gene/trait/backfire/nettle_burn)
	mutatelist = list(/obj/item/seeds/nettle/death)
	reagents_add = list(/datum/reagent/toxin/acid = 0.5)

/obj/item/seeds/nettle/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/trait/attack/nettle_attack, PLANT_GENE_REMOVABLE)
		unset_mutability(/datum/plant_gene/trait/backfire/nettle_burn, PLANT_GENE_REMOVABLE)

/obj/item/seeds/nettle/death
	name = "pack of death-nettle seeds"
	desc = "These seeds grow into death-nettles."
	icon_state = "seed-deathnettle"
	species = "deathnettle"
	plantname = "Death Nettles"
	product = /obj/item/reagent_containers/food/snacks/grown/nettle/death
	endurance = 25
	maturation = 8
	yield = 2
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/plant_type/weed_hardy, /datum/plant_gene/trait/stinging, /datum/plant_gene/trait/attack/nettle_attack/death, /datum/plant_gene/trait/backfire/nettle_burn/death)
	mutatelist = list()
	reagents_add = list(/datum/reagent/toxin/acid/fluacid = 0.5, /datum/reagent/toxin/acid = 0.5)
	rarity = 20
	research = PLANT_RESEARCH_TIER_3

/obj/item/seeds/nettle/death/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/trait/attack/nettle_attack/death, PLANT_GENE_REMOVABLE)
		unset_mutability(/datum/plant_gene/trait/backfire/nettle_burn/death, PLANT_GENE_REMOVABLE)

/obj/item/reagent_containers/food/snacks/grown/nettle // "snack"
	seed = /obj/item/seeds/nettle
	name = "nettle"
	desc = "It's probably <B>not</B> wise to touch it with bare hands..."
	icon = 'icons/obj/items.dmi'
	icon_state = "nettle"
	lefthand_file = 'icons/mob/inhands/weapons/plants_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/plants_righthand.dmi'
	damtype = "fire"
	force = 15
	hitsound = 'sound/weapons/bladeslice.ogg'
	throwforce = 5
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3
	attack_verb = list("stung")
	wine_power = 20
	wine_flavor = "tingling itchiness" //WS edit: new wine flavors

/obj/item/reagent_containers/food/snacks/grown/nettle/death
	seed = /obj/item/seeds/nettle/death
	name = "deathnettle"
	desc = "The <span class='danger'>glowing</span> nettle incites <span class='boldannounce'>rage</span> in you just from looking at it!"
	icon_state = "deathnettle"
	force = 30
	throwforce = 15
	wine_power = 50
	wine_flavor = "burning rage" //WS edit: new wine flavors
