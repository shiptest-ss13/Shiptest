/obj/structure/closet/secure_closet/brig_phys
	name = "\proper brig physician's locker"
	req_access = list(ACCESS_BRIG)
	icon_state = "brig_phys"

/obj/structure/closet/secure_closet/brig_phys/PopulateContents()
	..()
	new /obj/item/defibrillator/loaded(src)
	new /obj/item/radio/headset/headset_medsec(src)
	new	/obj/item/storage/firstaid/regular(src)
	new	/obj/item/storage/firstaid/fire(src)
	new	/obj/item/storage/firstaid/toxin(src)
	new	/obj/item/storage/firstaid/o2(src)
	new	/obj/item/storage/firstaid/brute(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)

/obj/structure/closet/secure_closet/lieutenant
	name = "\proper lieutenant's locker"
	req_access = list(ACCESS_LIEUTENANT)
	icon_state = "blueshield"

/obj/structure/closet/secure_closet/lieutenant/PopulateContents()
	..()
	new /obj/item/clothing/head/beret/lt(src)
	new /obj/item/storage/briefcase(src)
	new	/obj/item/storage/firstaid/regular(src)
	new /obj/item/storage/belt/security(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/loaded(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/suit/armor/vest/lieutenant(src)
	new /obj/item/clothing/suit/lieutenant(src)
	new /obj/item/clothing/accessory/holster/lieutenant(src)
	new /obj/item/clothing/shoes/jackboots(src)
