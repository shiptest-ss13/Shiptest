/datum/outfit/job/solgov
	name = "SolGov Base Outfit"
	faction = FACTION_PLAYER_SOLCON
	faction_icon = "bg_solgov"

/datum/outfit/job/solgov/assistant
	name = "SolGov - Scribe"
	id_assignment = "Scribe"
	jobtype = /datum/job/assistant
	job_icon = "scribe"

	head = /obj/item/clothing/head/beret/solgov/plain
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/solgov

/datum/outfit/job/solgov/bureaucrat
	name = "SolGov - Bureaucrat"
	id_assignment = "Bureaucrat"
	jobtype = /datum/job/curator
	job_icon = "curator"

	head = /obj/item/clothing/head/beret/solgov
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/solgov/bureaucrat
	l_hand = /obj/item/storage/bag/books
	r_pocket = /obj/item/key/displaycase
	l_pocket = /obj/item/laser_pointer
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/barcodescanner = 1
	)

/datum/outfit/job/solgov/captain
	name = "SolGov - Captain"
	jobtype = /datum/job/captain
	job_icon = "solgovrepresentative" // idk

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/solgov/alt/captain
	uniform =  /obj/item/clothing/under/solgov/formal/captain
	suit = /obj/item/clothing/suit/armor/vest/solgov/captain
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/solgov/captain
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/captain)

/datum/outfit/job/solgov/sonnensoldner
	name = "SolGov - Sonnensöldner"
	id_assignment = "Sonnensöldner"
	jobtype = /datum/job/officer
	job_icon = "sonnensoldner"

	id = /obj/item/card/id/solgov
	uniform = /obj/item/clothing/under/solgov
	suit = /obj/item/clothing/suit/armor/vest/solgov
	ears = /obj/item/radio/headset/solgov/alt
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/solgov/sonnensoldner
	r_pocket = null
	l_pocket = null
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival
	backpack_contents = list(/obj/item/crowbar/power)

/datum/outfit/job/solgov/representative
	name = "SolGov - Solarian Representative"
	jobtype = /datum/job/solgov
	job_icon = "solgovrepresentative"

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

	implants = list(/obj/item/implant/mindshield)

	backpack_contents = list(
		/obj/item/melee/knife/letter_opener = 1
	)

/datum/outfit/job/solgov/overseer
	name = "SolGov - Overseer"
	id_assignment = "Overseer"
	jobtype = /datum/job/head_of_personnel
	job_icon = "headofpersonnel"

	id = /obj/item/card/id/solgov
	ears = /obj/item/radio/headset/solgov/captain
	uniform = /obj/item/clothing/under/solgov/formal
	head = /obj/item/clothing/head/solgov
	neck = /obj/item/clothing/neck/cloak/overseer
	suit = /obj/item/clothing/suit/armor/vest/solgov/overseer
	shoes = /obj/item/clothing/shoes/laceup

	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/officer)

/datum/outfit/job/solgov/doctor
	name = "SolGov - Medical Doctor"
	jobtype = /datum/job/doctor
	job_icon = "medicaldoctor"

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/solgov/formal
	accessory = /obj/item/clothing/accessory/armband/medblue
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/solgov_surgery
	suit =  /obj/item/clothing/suit/solgov/jacket
	l_hand = /obj/item/storage/firstaid/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/solgov/miner
	name = "SolGov - Field Engineer"
	id_assignment = "Field Engineer"
	jobtype = /datum/job/mining
	job_icon = "shaftminer"

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
		/obj/item/melee/knife/survival=1,\
		/obj/item/stack/marker_beacon/ten=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

/datum/outfit/job/solgov/psychologist
	name = "SolGov - Psychologist"
	jobtype = /datum/job/psychologist
	job_icon = "psychologist"

	head = /obj/item/clothing/head/fedora/solgov
	suit = /obj/item/clothing/suit/solgov/suit
	ears = /obj/item/radio/headset/headset_srvmed
	uniform = /obj/item/clothing/under/solgov/formal
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id
	l_hand = /obj/item/clipboard

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

/datum/outfit/job/solgov/patient
	name = "SolGov - Attentive Care Patient"
	id_assignment = "Attentive Care Patient"
	jobtype = /datum/job/prisoner
	job_icon = "assistant" // todo: bug rye for patient icon // rye. rye. give me 50 gazillion billion dollars paypal

	id = /obj/item/card/id/patient
	uniform = /obj/item/clothing/under/rank/medical/gown
	alt_suit = null
	shoes = /obj/item/clothing/shoes/sandal/slippers

/datum/outfit/job/solgov/engineer
	name = "SolGov - Ship Engineer"
	id_assignment = "Ship Engineer"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	belt = /obj/item/storage/belt/utility/full/engi
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
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/solgov/quartermaster
	name = "SolGov - Logistics Deck Officer"
	id_assignment = "Logistics Deck Officer"
	jobtype = /datum/job/qm
	job_icon = "quartermaster"

	ears = /obj/item/radio/headset/solgov/captain
	uniform = /obj/item/clothing/under/solgov/formal
	suit = /obj/item/clothing/suit/solgov/overcoat
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/flatcap/solgov
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)
