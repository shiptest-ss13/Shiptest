/obj/machinery/vending/wallmed
	name = "\improper NanoMed"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	density = FALSE
	products = list(
		/obj/item/reagent_containers/syringe = 1,
		/obj/item/reagent_containers/pill/patch/styptic = 3,
		/obj/item/reagent_containers/pill/patch/silver_sulf = 3,
		/obj/item/reagent_containers/pill/charcoal = 1,
		/obj/item/reagent_containers/medigel/styptic = 1,
		/obj/item/reagent_containers/medigel/silver_sulf = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/reagent_containers/pill/morphine = 1
	)
	contraband = list(
		/obj/item/reagent_containers/pill/tox = 1,
		/obj/item/storage/box/gum/happiness = 1
	)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/wallmed
	default_price = 200
	extra_price = 400
	tiltable = FALSE
	light_mask = "wallmed-light-mask"

/obj/item/vending_refill/wallmed
	machine_name = "NanoMed"
	icon_state = "refill_medical"
