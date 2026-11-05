/datum/outfit/job/independent/ert/outpost_security
	name = "ERT - TrifugeSec"
	id_assignment = "TrifugeSec"

	uniform = /obj/item/clothing/under/pants/cargo/jeans
	alt_uniform = /obj/item/clothing/under/overalls

	head = /obj/item/clothing/head/soft/utility_olive
	mask = null

	belt = /obj/item/storage/belt/security/full

	suit = /obj/item/clothing/suit/armor/vest/alt
	suit_store = /obj/item/gun/energy/disabler/e60
	ears = /obj/item/radio/headset/alt

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/grenade/flashbang = 2,
		/obj/item/melee/knife/combat = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)

/datum/outfit/job/syndicate/ert/cybersun/outpost_security
	name = "ERT - Thousand Eyes Security"
	id_assignment = "Troubleshooter"
	job_icon = "syndicate"

	uniform = /obj/item/clothing/under/cybersun/suit
	alt_uniform = /obj/item/clothing/under/cybersun/sneak

	head = /obj/item/clothing/head/soft/cybersun
	mask = /obj/item/clothing/mask/gas/cybersun

	belt = /obj/item/storage/belt/military/cybersun/security

	suit = /obj/item/clothing/suit/armor/vest/cybersun
	suit_store = /obj/item/gun/energy/cybersun/lorentz/opportunist
	ears = /obj/item/radio/headset/syndicate/alt/cybersun


	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
		/obj/item/grenade/flashbang = 2,
		/obj/item/melee/knife/combat = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/radio = 1,
		/obj/item/bodycamera = 1
	)
