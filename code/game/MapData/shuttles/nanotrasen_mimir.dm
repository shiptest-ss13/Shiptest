//smuggler's satchels
/obj/item/storage/backpack/satchel/flat/mimir_tech/PopulateContents()
	new /obj/item/encryptionkey/wideband(src)
	new /obj/item/paicard(src)

/obj/item/storage/backpack/satchel/flat/mimir_jackets/PopulateContents()
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat(src)

/obj/item/storage/backpack/satchel/flat/mimir_refill/PopulateContents()
	new /obj/item/vending_refill/hydronutrients(src)
	new /obj/item/vending_refill/hydroseeds(src)

/obj/item/storage/backpack/satchel/flat/mimir_transfer/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
	new /obj/item/weldingtool/mini(src)
	new /obj/item/choice_beacon/music(src)
	new /obj/item/coin/antagtoken(src)

//toilet =)

/obj/structure/toilet/secret/mimir
	secret_type = /obj/item/storage/backpack/satchel/flat/mimir_transfer


//doors
/obj/machinery/door/airlock/security/glass/seclock
	req_one_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS)

/obj/machinery/door/airlock/security/glass/wardenlock
	req_access = list(ACCESS_ARMORY)

/obj/machinery/door/airlock/maintenance_hatch/seclock
	req_one_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS)



//notes

