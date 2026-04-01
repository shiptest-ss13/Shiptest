/obj/machinery/vending/medical
	name = "\improper NanoMed Plus"
	desc = "Medical drug dispenser."
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
	req_access = list(ACCESS_MEDICAL)
	products = list(
		/obj/item/stack/medical/gauze = 5,
		/obj/item/stack/medical/splint = 5,
		/obj/item/reagent_containers/syringe = 5,
		/obj/item/reagent_containers/dropper = 2,
		/obj/item/healthanalyzer = 2,
		/obj/item/reagent_containers/pill/patch/indomide = 5,
		/obj/item/reagent_containers/pill/patch/alvitane = 5,
		/obj/item/reagent_containers/hypospray/medipen = 3,
		/obj/item/reagent_containers/syringe/antiviral = 1,
		/obj/item/reagent_containers/glass/bottle/charcoal = 3,
		/obj/item/reagent_containers/glass/bottle/epinephrine = 3,
		/obj/item/reagent_containers/glass/bottle/morphine = 1,
		/obj/item/reagent_containers/glass/bottle/potass_iodide = 1,
		/obj/item/reagent_containers/glass/bottle/salglu_solution = 3,
		/obj/item/reagent_containers/medigel/hadrakine = 1,
		/obj/item/reagent_containers/medigel/quardexane = 1,
		/obj/item/reagent_containers/medigel/synthflesh = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/sensor_device = 1,
		/obj/item/pinpointer/crew = 1)
	contraband = list(/obj/item/reagent_containers/pill/tox = 2)
	premium = list(
		/obj/item/clothing/glasses/hud/health = 1,
		/obj/item/clothing/glasses/hud/health/prescription = 1,
		/obj/item/shears = 1,
		/obj/item/storage/box/hug/medical = 1,
		/obj/item/inhaler/salbutamol = 2)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/medical
	default_price = 150
	extra_price = 400
	light_mask = "med-light-mask"

/obj/item/vending_refill/medical
	machine_name = "NanoMed Plus"
	icon_state = "refill_medical"

/obj/machinery/vending/medical/syndicate_access
	name = "\improper SyndiMed Plus"
	req_access = list(ACCESS_SYNDICATE)

/obj/machinery/vending/medical
	name = "\improper NanoMed Plus"
	desc = "Medical drug dispenser."
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "Go save some lives!;The best stuff for your medbay.;Only the finest tools.;Natural chemicals!;This stuff saves lives.;Don't you want some?;Ping!"
