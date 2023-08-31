/datum/job/captain
	name = "Captain"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 30
	officer = TRUE
	wiki_page = "Captain"

	outfit = /datum/outfit/job/captain

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

	mind_traits = list(TRAIT_DISK_VERIFIER)

	display_order = JOB_DISPLAY_ORDER_CAPTAIN

/datum/job/captain/get_access()
	return get_all_accesses()

/datum/outfit/job/captain
	name = "Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/captain
	ears = /obj/item/radio/headset/heads/captain
	uniform =  /obj/item/clothing/under/rank/command/captain
	alt_uniform = /obj/item/clothing/under/rank/command/captain/parade //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/captain/hardsuit
	name = "Captain (Hardsuit)"

	mask = /obj/item/clothing/mask/gas/atmos/captain
	suit = /obj/item/clothing/suit/space/hardsuit/swat/captain
	suit_store = /obj/item/tank/internals/oxygen

/datum/outfit/job/captain/nt
	name = "Captain (Nanotrasen)"

	ears = /obj/item/radio/headset/nanotrasen/captain
	uniform = /obj/item/clothing/under/rank/command/captain/nt
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/caphat/nt

/datum/outfit/job/captain/pirate
	name = "Captain (Pirate)"

	ears = /obj/item/radio/headset/pirate/captain
	uniform = /obj/item/clothing/under/costume/russian_officer
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/pirate/captain
	suit = /obj/item/clothing/suit/pirate/captain

/datum/outfit/job/captain/corporate
	name = "Captain (Corporate)"
	uniform = /obj/item/clothing/under/suit/navy
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = null

/datum/outfit/job/captain/western
	name = "Captain (Western)"
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/cowboy/white
	head = /obj/item/clothing/head/caphat/cowboy
	glasses = /obj/item/clothing/glasses/sunglasses
	alt_suit = null

/datum/outfit/job/captain/syndicate
	name = "Captain (ACLF)"
	id = /obj/item/card/id/syndicate_command/captain_id
	ears = /obj/item/radio/headset/syndicate/alt/captain
	uniform = /obj/item/clothing/under/syndicate/aclf
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/HoS/syndicate
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

/datum/outfit/job/captain/syndicate/sbc
	name = "Captain (Twinkleshine)"

	uniform = /obj/item/clothing/under/syndicate/aclf
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicate/alt/captain
	mask = /obj/item/clothing/mask/gas/syndicate/voicechanger
	l_pocket = /obj/item/melee/transforming/energy/sword/saber/red
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	id = /obj/item/card/id/syndicate_command/captain_id
	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/pda/captain)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	box = /obj/item/storage/box/survival/syndie

/datum/outfit/job/captain/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(9, 12)) // squidquest real
	I.access = get_all_accesses()+get_all_syndicate_access()
	I.update_label()

/datum/outfit/job/captain/syndicate/gorlex
	name = "Captain (Gorlex Marauders)"

	uniform = /obj/item/clothing/under/syndicate/aclf
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/aclfcap
	suit = /obj/item/clothing/suit/aclf

/datum/outfit/job/captain/syndicate/cybersun
	name = "Cybersun Commander"

	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/HoS/syndicate
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate

/datum/outfit/job/captain/minutemen
	name = "Captain (Colonial Minutemen)"

	ears = /obj/item/radio/headset/heads/captain/alt
	uniform = /obj/item/clothing/under/rank/command/minutemen
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	alt_suit = null

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/captain/minutemen/general
	name = "General (Colonial Minutemen)"

	head = /obj/item/clothing/head/caphat/minutemen
	ears = /obj/item/radio/headset/heads/captain
	uniform = /obj/item/clothing/under/rank/command/minutemen
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/minutemen
	shoes = /obj/item/clothing/shoes/combat

	box = /obj/item/storage/box/survival/engineer/radio
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/gun/ballistic/revolver/mateba=1)

/datum/outfit/job/captain/independent/owner
	name = "Private Ship Owner (Independent)"

	id = /obj/item/card/id/gold
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	head = null
	belt = null
	gloves = null
	accessory = null
	ears = /obj/item/radio/headset/heads/captain
	box = /obj/item/storage/box/survival
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel/
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/commander=1, /obj/item/clothing/accessory/medal/gold/captain=1, /obj/item/spacecash/bundle/c10000=1)

/datum/outfit/job/captain/inteq
	name = "IRMG Vanguard (Inteq)"

	ears = /obj/item/radio/headset/inteq/alt/captain
	uniform = /obj/item/clothing/under/syndicate/inteq
	head = /obj/item/clothing/head/beret/sec/hos/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	belt = /obj/item/storage/belt/security/webbing/inteq
	suit = /obj/item/clothing/suit/armor/hos/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	accessory = null

	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/ammo_box/magazine/co9mm=1, /obj/item/pda/captain)

/datum/outfit/job/captain/inteq/naked
	name = "IRMG Vanguard (Inteq) (Naked)"
	head = null
	mask = null
	glasses = null
	belt = null
	suit = null
	gloves = null
	suit_store = null

/datum/outfit/job/captain/aipirate
	name = "Nodesman (Command)"

	uniform = /obj/item/clothing/under/utility
	alt_uniform = null
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	alt_suit = null
	dcoat = null
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/kitchen/knife/combat
	implants = list(/obj/item/implant/radio)
	accessory = null

/datum/outfit/job/captain/frontiersmen
	name = "Captain (Frontiersmen)"

	ears = /obj/item/radio/headset/pirate/alt/captain
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/admiral
	head = /obj/item/clothing/head/caphat/frontier/admiral
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/armor/frontier
	shoes = /obj/item/clothing/shoes/cowboy
	gloves = /obj/item/clothing/gloves/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/pda/captain)

/datum/outfit/job/captain/nt/lp_lieutenant
	name = "LP Lieutenant"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	dcoat = /obj/item/clothing/suit/jacket
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command

	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com
