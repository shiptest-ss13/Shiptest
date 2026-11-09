/obj/machinery/vending/outpost_pharmacy
	name = "\improper Matahari Pharmaceuticals Quick Care Center"
	desc = "A vending machine loaded with a variety of over-the-counter medications for dealing with everyday injuries."
	icon_state = "mining"
	icon_deny = "mining_deny"
	refill_canister = /obj/item/vending_refill/pharm
	default_price = 50
	restock_hourly = TRUE
	light_mask = "mining-light-mask"

	products = list(
		// generalist healing
		/obj/item/reagent_containers/hypospray/medipen/cureall = 24,
		/obj/item/reagent_containers/hypospray/medipen/stimpack = 24,
		/obj/item/reagent_containers/hypospray/medipen = 16,
		/obj/item/reagent_containers/hypospray/medipen/blood_loss = 16,
		/obj/item/reagent_containers/hypospray/medipen/tramal = 16,
		// specialized healing
		/obj/item/reagent_containers/hypospray/medipen/atropine = 8,
		/obj/item/reagent_containers/hypospray/medipen/oculine = 8,
		/obj/item/reagent_containers/hypospray/medipen/inacusiate = 8,
		/obj/item/reagent_containers/hypospray/medipen/diphen = 8,
		/obj/item/reagent_containers/hypospray/medipen/psicodine = 8,
		/obj/item/reagent_containers/hypospray/medipen/synap = 8,
		/obj/item/reagent_containers/hypospray/medipen/mannitol = 8,
		/obj/item/reagent_containers/hypospray/medipen/neurine = 8,
		/obj/item/reagent_containers/hypospray/medipen/antihol = 8,
		/obj/item/reagent_containers/hypospray/medipen/anti_rad = 8,
		/obj/item/reagent_containers/hypospray/medipen/placebatol = 8,
	)

/obj/item/vending_refill/pharm
	machine_name = "Matahari Quick Care Center"
	icon_state = "refill_medical"
