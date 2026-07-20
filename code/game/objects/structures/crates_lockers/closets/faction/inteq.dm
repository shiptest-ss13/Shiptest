/obj/structure/closet/faction/inteq
	name = "inteq closet"
	desc = "A storage unit with little to distinguish it other than the brown colouration of the IRMG."
	icon_state = "inteq"

/obj/structure/closet/faction/inteq/black
	name = "inteq closet"
	desc = "A storage unit with little to distinguish it other than the black colouration of the IRMG."
	icon_state = "inteqb"

/obj/structure/closet/faction/inteq/secure
	name = "inteq locker"
	desc = "A sturdy, keycard-locked storage unit with little to distinguish it other than the brown colouration of the IRMG."
	secure = TRUE
	locked = TRUE
	icon_state = "inteqsecure"
	armor = list("melee" = 30, "bullet" = 50, "laser" = 50, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	max_integrity = 250
	damage_deflection = 20

/obj/structure/closet/faction/inteq/secure/black
	name = "inteq locker"
	desc = "A sturdy, keycard-locked storage unit with little to distinguish it other than the black colouration of the IRMG."
	icon_state = "inteqbsecure"

// jobs

/obj/structure/closet/faction/inteq/secure/merc

/obj/structure/closet/faction/inteq/secure/merc/enforcer
	name = "enforcer's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical black stripe, and golden helmet emblem denote it's belonging to an IRMG Enforcer."
	icon_state = "inteqenf"
	req_access = list(ACCESS_SECURITY)

/obj/structure/closet/faction/inteq/secure/merc/artificer
	name = "artificer's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical black stripe, and golden wrench emblem denote it's belonging to an IRMG Artificer."
	icon_state = "inteqarti"
	req_access = list(ACCESS_ENGINE)

/obj/structure/closet/faction/inteq/secure/merc/corpsman
	name = "corpsman's locker"
	desc = "A sturdy, keycard-locked storage unit. It's white colouration, vertical green stripe, and green cross emblem denote it's belonging to an IRMG Corpsman."
	icon_state = "inteqcorps"
	req_access = list(ACCESS_MEDICAL)

// class 1

/obj/structure/closet/faction/inteq/secure/classone

/obj/structure/closet/faction/inteq/secure/classone/enforcer
	name = "enforcer class one's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical gold stripe, and golden helmet emblem denote it's belonging to an IRMG Enforcer Class One."
	icon_state = "inteqenfc1"
	req_access = list(ACCESS_ARMORY)

/obj/structure/closet/faction/inteq/secure/classone/artificer
	name = "artificer class one's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical gold stripe, and golden wrench emblem denote it's belonging to an IRMG Artificer Class One."
	icon_state = "inteqartic1"
	req_access = list(ACCESS_ATMOSPHERICS)

/obj/structure/closet/faction/inteq/secure/classone/corpsman
	name = "corpsman class one's locker"
	desc = "A sturdy, keycard-locked storage unit. It's white colouration, vertical gold stripe, and golden cross emblem denote it's belonging to an IRMG Corpsman Class One."
	icon_state = "inteqcorpsc1"
	req_access = list(ACCESS_VIROLOGY)

// command

/obj/structure/closet/faction/inteq/secure/command

/obj/structure/closet/faction/inteq/secure/command/masteratarms
	name = "master at arms' locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical gold stripe, and golden pistol emblem denote it's belonging to an IRMG Master At Arms'."
	icon_state = "inteqmaster"
	req_access = list(ACCESS_HOS)

/obj/structure/closet/faction/inteq/secure/command/artificer
	name = "honorable artificer's locker"
	desc = "A sturdy, keycard-locked storage unit. It's black colouration, vertical gold stripe, and golden wrench emblem denote it's belonging to an IRMG Honorable Artificer."
	icon_state = "inteqbarti"
	req_access = list(ACCESS_CE)

/obj/structure/closet/faction/inteq/secure/command/corpsman
	name = "honorable corpsman's locker"
	desc = "A sturdy, keycard-locked storage unit. It's black colouration, vertical gold stripe, and golden cross emblem denote it's belonging to an IRMG Honorable Corpsman."
	icon_state = "inteqbcorps"
	req_access = list(ACCESS_CMO)

/obj/structure/closet/faction/inteq/secure/command/vanguard
	name = "vanguard's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical gold stripe, and golden shield emblem denote it's belonging to an IRMG Vanguard."
	icon_state = "inteqvanguard"
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/faction/inteq/secure/command/pilot
	name = "pilot's locker"
	desc = "A sturdy, keycard-locked storage unit. It's brown colouration, vertical gold stripe, and golden shuttle emblem denote it's belonging to an IRMG Pilot."
	icon_state = "inteqpilot"
	req_access = list(ACCESS_MINING)

// ERT

/obj/structure/closet/faction/inteq/secure/ert

/obj/structure/closet/faction/inteq/secure/ert/vanguard
	name = "honorable vanguard's locker"
	desc = "A sturdy, keycard-locked storage unit. It's black colouration, vertical white stripe, and white shield emblem denote it's belonging to an IRMG Honorable Vanguard."
	icon_state = "inteqbvanguard"
	req_access = list(ACCESS_CENT_CAPTAIN)

/obj/structure/closet/faction/inteq/secure/ert/enforcer
	name = "enforcer honor guard's locker"
	desc = "A sturdy, keycard-locked storage unit. It's black colouration, vertical gold stripe, and golden helmet emblem denote it's belonging to an IRMG Enforcer Honor Guard."
	icon_state = "inteqbenf"
	req_access = list(ACCESS_CENT_SPECOPS)

/*
populate contents! mostly for clothes, equipment like armour and weapons should be kept mapped in with few exceptions
belts and PPE in job lockers? yes!
the corpsman's and master at arms' unique armoured coats mapped into their lockers? yes!
knives in enforcer lockers? no!
first-aid in corpsman lockers? no!
*/

/obj/structure/closet/faction/inteq/uniforms
	name = "inteq uniform closet"

/obj/structure/closet/faction/inteq/uniforms/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/storage/backpack/messenger/inteq = 2,
		/obj/item/clothing/head/soft/inteq = 2,
		/obj/item/clothing/head/beret/sec/inteq = 2,
		/obj/item/clothing/suit/hooded/wintercoat/security/inteq = 2,
		/obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt = 2,
		/obj/item/clothing/under/syndicate/inteq = 2,
		/obj/item/clothing/under/syndicate/inteq/skirt = 2,
		/obj/item/clothing/under/syndicate/inteq/sneaksuit = 2,
		/obj/item/clothing/shoes/combat = 2,
		/obj/item/clothing/gloves/combat = 2,
		/obj/item/clothing/mask/balaclava/inteq = 2,
		/obj/item/radio/headset = 2)
	generate_items_inside(items_inside,src)

// jobs

/obj/structure/closet/faction/inteq/secure/merc/enforcer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/beret/sec/inteq(src)
//suits
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq(src)
	new /obj/item/clothing/under/syndicate/inteq/skirt(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
//belts
	new /obj/item/storage/belt/security/webbing/inteq(src)
	new /obj/item/storage/belt/security/webbing/inteq/alt(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/alt/(src)

/obj/structure/closet/faction/inteq/secure/merc/artificer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/engineering(src)
	new /obj/item/storage/backpack/industrial(src)
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/beret/sec/inteq(src)
//suits
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/artificer(src)
	new /obj/item/clothing/under/syndicate/inteq/artificer/skirt(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/insulated(src)
//belts
	new /obj/item/storage/belt/utility/full/engi(src)
//masks
	new /obj/item/clothing/mask/gas/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/radio/headset/alt/(src)

/obj/structure/closet/faction/inteq/secure/merc/corpsman/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/med(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/storage/backpack/satchel/med(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq/corpsman(src)
//suits
	new /obj/item/clothing/suit/armor/inteq/corpsman
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/corpsman(src)
	new /obj/item/clothing/under/syndicate/inteq/corpsman/skirt(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/nitrile/inteq(src)
//belts
	new /obj/item/storage/belt/medical/webbing(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/radio/headset/headset_medsec/alt(src)

/*class one
these lack assets, here for consistency and futureproofing
*/

/obj/structure/closet/faction/inteq/secure/classone/enforcer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/beret/sec/inteq(src)
//suits
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq(src)
	new /obj/item/clothing/under/syndicate/inteq/skirt(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
//belts
	new /obj/item/storage/belt/security/webbing/inteq(src)
	new /obj/item/storage/belt/security/webbing/inteq/alt(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt(src)

/obj/structure/closet/faction/inteq/secure/classone/artificer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/engineering(src)
	new /obj/item/storage/backpack/industrial(src)
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/beret/sec/inteq(src)
//suits
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/artificer(src)
	new /obj/item/clothing/under/syndicate/inteq/artificer/skirt(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/insulated(src)
//belts
	new /obj/item/storage/belt/utility/full/engi(src)
//masks
	new /obj/item/clothing/mask/gas/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/radio/headset/inteq/alt(src)

/obj/structure/closet/faction/inteq/secure/classone/corpsman/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/med(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/storage/backpack/satchel/med(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq/corpsman(src)
//suits
	new /obj/item/clothing/suit/armor/inteq/corpsman
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/corpsman(src)
	new /obj/item/clothing/under/syndicate/inteq/corpsman/skirt(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/nitrile/inteq(src)
//belts
	new /obj/item/storage/belt/medical/webbing(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/radio/headset/inteq/alt(src)

//command

/obj/structure/closet/faction/inteq/secure/command/masteratarms/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/warden/inteq(src)
//suits
	new /obj/item/clothing/suit/armor/vest/security/warden/inteq(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/honorable(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat/insulated(src)
//belts
	new /obj/item/storage/belt/military/assault(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt(src)

//honorable arti and corpsman lack assets, here for consistency and futureproofing

/obj/structure/closet/faction/inteq/secure/command/artificer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/engineering(src)
	new /obj/item/storage/backpack/industrial(src)
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/hardhat/white(src)
//suits
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq(src)
	new /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/artificer(src)
	new /obj/item/clothing/under/syndicate/inteq/artificer/skirt(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/insulated(src)
//belts
	new /obj/item/storage/belt/utility/chief/full(src)
//masks
	new /obj/item/clothing/mask/gas/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/radio/headset/inteq/alt(src)

/obj/structure/closet/faction/inteq/secure/command/corpsman/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag/med(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/storage/backpack/satchel/med(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq/corpsman(src)
//suits
	new /obj/item/clothing/suit/armor/inteq/corpsman
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/corpsman(src)
	new /obj/item/clothing/under/syndicate/inteq/corpsman/skirt(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/nitrile/inteq(src)
//belts
	new /obj/item/storage/belt/medical/webbing(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/radio/headset/inteq/alt(src)

/obj/structure/closet/faction/inteq/secure/command/vanguard/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/inteq_peaked(src)
	new /obj/item/clothing/head/beret/sec/hos/inteq(src)
//suits
	new /obj/item/clothing/suit/armor/hos/inteq(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/honorable(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat/insulated(src)
//belts
	new /obj/item/storage/belt/military/assault(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt/captain(src)

/obj/structure/closet/faction/inteq/secure/command/pilot/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/soft/inteq(src)
	new /obj/item/clothing/head/beret/sec/inteq(src)
//suits
	new /obj/item/clothing/suit/toggle/flight/inteq(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/honorable(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/combat(src)
//belts
	new /obj/item/storage/belt/security/webbing/inteq/alt(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt/captain(src)

// ERT

/obj/structure/closet/faction/inteq/secure/ert/vanguard/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/beret/sec/hos/inteq/honorable(src)
//suits
	new /obj/item/clothing/suit/armor/hos/inteq/honorable(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/honorable(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat/insulated(src)
//belts
	new /obj/item/storage/belt/military/assault(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt/captain(src)

/obj/structure/closet/faction/inteq/secure/ert/enforcer/prefilled/PopulateContents()
	..()
//bags
	new /obj/item/storage/backpack/duffelbag(src)
	new /obj/item/storage/backpack(src)
	new /obj/item/storage/backpack/satchel(src)
	new /obj/item/storage/backpack/messenger/inteq(src)
//hats
	new /obj/item/clothing/head/beret/sec/hos/inteq/honorable(src)
//uniforms
	new /obj/item/clothing/under/syndicate/inteq/honorable(src)
	new /obj/item/clothing/under/syndicate/inteq/sneaksuit(src)
//hands/feet
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/gloves/tackler/combat/insulated(src)
//belts
	new /obj/item/storage/belt/security/webbing/inteq(src)
	new /obj/item/storage/belt/security/webbing/inteq/alt(src)
//masks
	new /obj/item/clothing/mask/balaclava/inteq(src)
//eyes/ears
	new /obj/item/clothing/glasses/hud/security/sunglasses/inteq(src)
	new /obj/item/radio/headset/inteq/alt/captain(src)
