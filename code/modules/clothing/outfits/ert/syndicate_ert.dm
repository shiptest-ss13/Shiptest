/datum/outfit/centcom/ert/syndicate
	name = "ERT - Syndicate Basic"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/smg/c20r
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicate
	id = /obj/item/card/id/syndicate_command/crew_id
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/swat
	back = /obj/item/storage/backpack/fireproof
	belt = /obj/item/storage/belt/military/c20r
	r_pocket = /obj/item/kitchen/knife/combat
	l_pocket = /obj/item/grenade/frag

	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol=1, /obj/item/ammo_box/magazine/m10mm=2, /obj/item/radio=1)
	box = /obj/item/storage/box/survival/syndie

	id_role = "Squaddie"

/datum/outfit/centcom/ert/syndicate/leader
	name = "ERT - Syndicate Basic Leader"

	head = /obj/item/clothing/head/HoS/beret/syndicate
	ears = /obj/item/radio/headset/syndicate/captain

	id_role = "Sergeant"

/datum/outfit/centcom/ert/syndicate/gorlex
	name = "ERT - Syndicate Gorlex Trooper"

	head = /obj/item/clothing/head/helmet/operator
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/syndie
	belt = /obj/item/storage/belt/military/assault
	back = /obj/item/storage/backpack/security

	id_role = "Trooper"

/datum/outfit/centcom/ert/syndicate/gorlex/leader
	name = "ERT - Syndicate Gorlex Sergeant"

	head = /obj/item/clothing/head/HoS/beret/syndicate

	id_role = "Sergeant"

/datum/outfit/centcom/ert/syndicate/cybersun
	name = "ERT - Syndicate Cybersun Commando"

	head = null
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/military/c20r
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	suit_store = /obj/item/gun/ballistic/automatic/smg/c20r
	ears = /obj/item/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses

	implants = list(/obj/item/implant/adrenalin)
	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm, /obj/item/ammo_box/magazine/m10mm=2, /obj/item/radio=1)

	id_role = "Operative"

/datum/outfit/centcom/ert/syndicate/cybersun/leader
	name = "ERT - Syndicate Cybersun Commando Leader"

	ears = /obj/item/radio/headset/syndicate/alt/captain
	glasses = /obj/item/clothing/glasses/hud/security/night

	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm=1, /obj/item/ammo_box/magazine/m10mm=2, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1, /obj/item/radio=1)

	id_role = "Lead Operative"

/datum/outfit/centcom/ert/syndicate/cybersun/medic
	name = "ERT - Syndicate Cybersun Paramedic"

	uniform = /obj/item/clothing/under/syndicate/medic
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed
	suit_store = /obj/item/tank/internals/oxygen
	mask = /obj/item/clothing/mask/breath/medical
	glasses = /obj/item/clothing/glasses/hud/health/night
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	head = /obj/item/clothing/head/soft/cybersun
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	back = /obj/item/storage/backpack/ert/medical
	l_pocket = /obj/item/kitchen/knife/combat/survival
	r_pocket = /obj/item/pinpointer/crew
	accessory = /obj/item/clothing/accessory/holster/marine

backpack_contents = list(/obj/item/storage/firstaid/tactical=1,
	/obj/item/holosign_creator/medical=1,
	/obj/item/autosurgeon/cmo=1,
	/obj/item/radio=1)

	id_role = "Medical Technician"

/datum/outfit/centcom/ert/syndicate/cybersun/medic/leader
	name = "ERT - Syndicate Cybersun Lead Paramedic"

	head = /obj/item/clothing/head/beret/cmo
	glasses = /obj/item/clothing/glasses/hud/security/night
	ears = /obj/item/radio/headset/syndicate/captain
	r_pocket = /obj/item/megaphone/command

	id_role = "Lead Medical Technician"
