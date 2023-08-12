//smuggler's satchels
/obj/item/storage/backpack/satchel/flat/mimir_tech/PopulateContents()
	new /obj/item/encryptionkey/wideband(src)
	new /obj/item/paicard(src)

/obj/item/storage/backpack/satchel/flat/mimir_jackets/PopulateContents()
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat(src)

/obj/item/storage/backpack/satchel/flat/mimir_refill/PopulateContents()
	new /obj/item/vending_refill/hydronutrients(src)

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

/obj/machinery/door/airlock/command/glass/seclock
	req_one_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS)


//notes

/obj/item/paper/fluff/mimir/treasure
	name = "Bluejack's Note"
	default_raw_text = "To whomever finds this note, \
	I've left behind some things behind that may help your endeavors. The first of them, \
	a bag found where the condemned swirl spirits in a whirlpool. The second, a bag \
	found under my seat of chance and uncanny luck. The third and final bag can be found \
	in the north east quarter of the square of eight lives. I wish you luck, and hope your \
	internment goes better than mine."

/obj/item/paper/fluff/mimir/jacket
	name = "Warden's Secret"
	default_raw_text = "A warden's seat is their place of rest. Look under where your ass rests best."

/obj/item/paper/fluff/mimir/recycler
	name = "TURN ON THE RECYCLER!!!"
	default_raw_text = "IMPORTANT!!!! TURN ON THE AIR RECYCLER IN THIS ROOM!!! JUST TURN ON AND MAX\
	ALL THE ATMOS IN THIS ROOM!!!!!!!!"
