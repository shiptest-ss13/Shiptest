/obj/effect/spawner/random/exotic
	name = "exotic spawner"
	desc = "Super duper rare stuff."
	icon_state = "showcase"

/obj/effect/spawner/random/exotic/ripley
	name = "25% exosuit 75% wreckage ripley spawner"
	icon_state = "ripley"
	loot = list(
		/obj/mecha/working/ripley/mining = 1,
		/obj/structure/mecha_wreckage/ripley = 5
	)

/obj/effect/spawner/random/exotic/prison_contraband
	name = "prison contraband loot spawner"
	icon_state = "prisoner"
	loot = list(
		/obj/item/clothing/mask/cigarette/space_cigarette = 4,
		/obj/item/clothing/mask/cigarette/robust = 2,
		/obj/item/clothing/mask/cigarette/carp = 3,
		/obj/item/clothing/mask/cigarette/uplift = 2,
		/obj/item/clothing/mask/cigarette/dromedary = 3,
		/obj/item/clothing/mask/cigarette/robustgold = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes = 3,
		/obj/item/clothing/mask/cigarette/rollie/cannabis = 4,
		/obj/item/toy/crayon/spraycan = 2,
		/obj/item/crowbar = 1,
		/obj/item/assembly/flash/handheld = 1,
		/obj/item/restraints/handcuffs/cable/zipties = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/radio = 1,
		/obj/item/lighter = 3,
		/obj/item/storage/box/matches = 3,
		/obj/item/reagent_containers/syringe/contraband/space_drugs = 1,
		/obj/item/reagent_containers/syringe/contraband/krokodil = 1,
		/obj/item/reagent_containers/syringe/contraband/crank = 1,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine = 1,
		/obj/item/reagent_containers/syringe/contraband/bath_salts = 1,
		/obj/item/reagent_containers/syringe/contraband/fentanyl = 1,
		/obj/item/reagent_containers/syringe/contraband/morphine = 1,
		/obj/item/storage/pill_bottle/happy = 1,
		/obj/item/storage/pill_bottle/lsd = 1,
		/obj/item/storage/pill_bottle/psicodine = 1,
		/obj/item/reagent_containers/food/drinks/beer = 4,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/paper/fluff/jobs/prisoner/letter = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/melee/knife/shiv = 4,
		/obj/item/melee/knife/shiv/carrot = 1,
		/obj/item/melee/knife/kitchen = 1,
		/obj/item/storage/wallet/random = 1,
		/obj/item/pda = 1
	)

/obj/effect/spawner/random/exotic/armory
	name = "generic armory spawner"
	spawn_loot_split = TRUE
	spawn_loot_count = 3
	spawn_loot_split_pixel_offsets = 4

	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/ringneck = 8,
		/obj/item/gun/ballistic/shotgun/automatic/m11 = 5,
		/obj/item/gun/ballistic/automatic/pistol/deagle,
		/obj/item/gun/ballistic/revolver/mateba
	)

