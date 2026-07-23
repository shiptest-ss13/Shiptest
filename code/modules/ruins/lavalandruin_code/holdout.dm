/datum/outfit/job/syndicate/hos/gorlex/holdout
	name = "Holdout - Sergeant"
	suit = /obj/item/clothing/suit/space/hardsuit/stealth/hardliners
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners
	belt = /obj/item/storage/belt/security/webbing/hardliners/alt

/datum/outfit/job/syndicate/security/gorlex/holdout1
	name = "Holdout - Suicidal Trooper"
	suit = /obj/item/clothing/suit/armor/hardliners
	head = /obj/item/clothing/head/helmet/hardliners
	belt = /obj/item/storage/belt/security/webbing/hardliners/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners
	gloves = /obj/item/clothing/gloves/combat
	mask = /obj/item/clothing/mask/gas/syndicate

/datum/outfit/job/syndicate/security/gorlex/holdout2
	name = "Holdout - Doomer Trooper"
	suit = /obj/item/clothing/suit/armor/hardliners
	head = /obj/item/clothing/head/helmet/hardliners

/obj/effect/mob_spawn/human/corpse/hardliner/sergeant/holdout
	name = "Holdout Sergeant"
	id_job = "Site Sergeant"
	outfit = /datum/outfit/job/syndicate/hos/gorlex/holdout
	mob_species = /datum/species/human

/obj/effect/mob_spawn/human/corpse/hardliner/trooper/holdout1
	name = "Holdout Suicidal Trooper"
	id_job = "Site Trooper"
	outfit = /datum/outfit/job/syndicate/security/gorlex/holdout1
	brute_damage = 252
	mob_species = /datum/species/lizard

/obj/effect/mob_spawn/human/corpse/hardliner/trooper/holdout2
	name = "Holdout Doomer Trooper"
	id_job = "Site Trooper"
	outfit = /datum/outfit/job/syndicate/security/gorlex/holdout2
	mob_gender = FEMALE
	mob_name = "Marianne Tchaikovski"
	mob_species = /datum/species/human

/obj/machinery/vending/cola/holdout
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/cola = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/comet_trail = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/tadrixx = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/lunapunch = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_up = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/pacfuel = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/orange_soda = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/sol_dry = 0,
		/obj/item/reagent_containers/food/drinks/waterbottle = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/xeno_energy = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/vimukti = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/shoal_punch = 0)
	premium = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/xeno_energy = 0,
		/obj/item/reagent_containers/food/drinks/soda_cans/crosstalk = 0)

/obj/machinery/vending/snack/holdout
	products = list(
		/obj/item/food/spacetwinkie = 0,
		/obj/item/food/gummycarps = 0,
		/obj/item/food/candy = 0,
		/obj/item/food/chips = 0,
		/obj/item/food/channeler_meats = 0,
		/obj/item/food/no_raisin = 0,
		/obj/item/reagent_containers/food/drinks/dry_ramen = 0,
		/obj/item/food/energybar = 0,
		/obj/item/food/syndicake = 0,
		/obj/item/food/reti = 0,
		/obj/item/food/lifosa = 0,
		/obj/item/food/dote = 0,
	)

/obj/item/paper/fluff/ruins/holdout/goodbye
	name = "water-damaged goodbye"
	default_raw_text = "Mom,<br><br>It's your daughter, Marianne. I don't expect this to make it back to you. I'm at peace with how this is going to end, I think. The sound of the turrets firing is drilled into my mind as I look at the last of our food and potable water.<br><br>You were right. I'm stupid, and an idiot, and nothing. I wanted to do what you did, to fight against the people who hurt us. I thought you were giving up in the Republic, that I had to make up for the dream I thought you wanted. Now, with Clique trying to batter down our doors I don't know if I believe any more.<br><br>I love you."

/obj/item/paper/fluff/ruins/holdout/hurrah
	name = "angrily scratched note"
	default_raw_text = "They can have the satisfaction of starving us out, but I'll be damned if I let those fucking traitors have our supplies. One last explosive hurrah for me, then I take my own way out."

/obj/item/paper/fluff/ruins/holdout/besieged
	name = "ineptly written note"
	default_raw_text = "Captain left me in charge of overseeing us starving out the Hardliners in the site. I think she's a coward and if I can take the base with only the dolts she left behind the Lieutenant will surely back me up in a coup."
