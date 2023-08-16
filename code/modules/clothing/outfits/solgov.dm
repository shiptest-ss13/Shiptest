/datum/outfit/job/solgov

/datum/outfit/job/solgov/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list("playerSolgov")

/datum/outfit/job/solgov/assistant
	name = "Scribe (SolGov)"
	jobtype = /datum/job/assistant

	head = /obj/item/clothing/head/beret/solgov/plain
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/solgov

/datum/outfit/job/solgov/bureaucrat
	name = "Bureaucrat (SolGov)"
	jobtype = /datum/job/curator

	head = /obj/item/clothing/head/beret/solgov
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/solgov/bureaucrat
	belt = /obj/item/pda/curator
	l_hand = /obj/item/storage/bag/books
	r_pocket = /obj/item/key/displaycase
	l_pocket = /obj/item/laser_pointer
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/barcodescanner = 1
	)

/datum/outfit/job/solgov/captain
	name = "Captain (SolGov)"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/solgov/alt/captain
	uniform =  /obj/item/clothing/under/solgov/formal/captain
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/solgov/captain
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/solgov/captain
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/solgov/sonnensoldner
	name = "Sonnensöldner (SolGov)"
	jobtype = /datum/job/officer

	id = /obj/item/card/id/solgov
	uniform = /obj/item/clothing/under/solgov
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/solgov
	ears = /obj/item/radio/headset/solgov/alt
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/solgov/sonnensoldner
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/solgov
	l_pocket = /obj/item/ammo_box/magazine/pistol556mm
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
	backpack_contents = list(/obj/item/crowbar/power,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/ammo_box/magazine/pistol556mm=2)

/datum/outfit/job/solgov/representative
	name = "Solarian Representative (SolGov)"
	job_icon = "solgovrepresentative"
	jobtype = /datum/job/solgov

	id = /obj/item/card/id/solgov
	head = /obj/item/clothing/head/solgov
	uniform = /obj/item/clothing/under/solgov/formal
	accessory = /obj/item/clothing/accessory/waistcoat/solgov
	neck = /obj/item/clothing/neck/cloak/solgov
	suit = /obj/item/clothing/suit/toggle/solgov
	alt_suit = /obj/item/clothing/suit/armor/solgov_trenchcoat
	dcoat = /obj/item/clothing/suit/hooded/wintercoat
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/solgov/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/pda/solgov

	implants = list(/obj/item/implant/mindshield)

	backpack_contents = list(
		/obj/item/kitchen/knife/letter_opener = 1
	)

/datum/outfit/job/solgov/overseer
	name = "Overseer (SolGov)"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/solgov
	belt = /obj/item/pda/heads/head_of_personnel
	ears = /obj/item/radio/headset/solgov/captain
	uniform = /obj/item/clothing/under/solgov/formal
	head = /obj/item/clothing/head/solgov
	neck = /obj/item/clothing/neck/cloak/overseer
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/solgov/overseer
	shoes = /obj/item/clothing/shoes/laceup

	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/head_of_personnel)

/datum/outfit/job/solgov/doctor
	name = "Medical Doctor (SolGov)"
	jobtype = /datum/job/doctor

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/solgov/formal
	accessory = /obj/item/clothing/accessory/armband/medblue
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/soft/solgov
	suit =  /obj/item/clothing/suit/solgov/jacket
	l_hand = /obj/item/storage/firstaid/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/solgov/miner
	name = "Field Engineer (SolGov)"
	jobtype = /datum/job/mining

	belt = /obj/item/pda/shaftminer
	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/explorer
	uniform = /obj/item/clothing/under/solgov
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/hardhat/solgov
	suit =  /obj/item/clothing/suit/hazardvest/solgov
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore	//causes issues if spawned in backpack
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/mining_voucher=1,\
		/obj/item/stack/marker_beacon/ten=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

/datum/outfit/job/solgov/psychologist
	name = "Psychologist (SolGov)"
	jobtype = /datum/job/psychologist

	head = /obj/item/clothing/head/fedora/solgov
	suit = /obj/item/clothing/suit/solgov/suit
	ears = /obj/item/radio/headset/headset_srvmed
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	belt = /obj/item/pda/medical
	pda_slot = ITEM_SLOT_BELT
	l_hand = /obj/item/clipboard

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

/datum/outfit/job/solgov/patient
	name = "Attentive Care Patient (SolGov)"
	jobtype = /datum/job/prisoner

	id = /obj/item/card/id/patient
	uniform = /obj/item/clothing/under/rank/medical/gown
	alt_suit = null
	shoes = /obj/item/clothing/shoes/sandal/slippers

/datum/outfit/job/solgov/engineer
	name = "Ship Engineer (SolGov)"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/solgov/formal
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/hardhat/solgov
	suit =  /obj/item/clothing/suit/hazardvest/solgov
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)
