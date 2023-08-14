/datum/job/lp

/datum/outfit/job/lp
	implants = list(/obj/item/implant/mindshield)

/datum/job/lp/lieutenant
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/lp/lieutenant

/datum/job/lp/lieutenant/get_access()
	return get_lplieu_access()

/datum/outfit/job/lp/lieutenant
	name = "LP Lieutenant"
	jobtype = /datum/job/lp/lieutenant

	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	dcoat = /obj/item/clothing/suit/jacket
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/ert
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com


/datum/job/lp/security
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/lp/security

/datum/job/lp/security/get_access()
	return get_lpsec_access()

/datum/outfit/job/lp/security
	name = "LP Security Specialist"
	jobtype = /datum/job/lp/security

	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpsec
	belt = /obj/item/pda/security
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/skirt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/ert/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec


/datum/job/lp/engineer
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/lp/engineer

/datum/job/lp/engineer/get_access()
	return get_lpengi_access()

/datum/outfit/job/lp/engineer
	name = "LP Engineering Specialist"
	jobtype = /datum/job/lp/engineer

	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpengie
	belt = /obj/item/pda/engineering
	gloves = /obj/item/clothing/gloves/color/yellow
	uniform = /obj/item/clothing/under/rank/engineering/engineer/lp
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/eng
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/ert/engineer
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi


/datum/job/lp/medic
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/lp/medic

/datum/job/lp/medic/get_access()
	return get_lpmedic_access()

/datum/outfit/job/lp/medic
	name = "LP Medical specialist"
	jobtype = /datum/job/lp/medic

	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpmed
	belt = /obj/item/pda/medical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	uniform = /obj/item/clothing/under/rank/medical/paramedic/lp
	alt_uniform = /obj/item/clothing/under/rank/medical/paramedic/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/med
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/ert/medical
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical


/datum/job/lp/commissioner
	access = list()
	minimal_access = list()
	outfit = /datum/outfit/job/lp/commissioner

/datum/job/lp/commissioner/get_access()
	return get_lpcomm_access()


/datum/outfit/job/lp/commissioner
	name = "LP Commissioner"
	jobtype = /datum/job/lp/commissioner

	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpcomm
	belt = /obj/item/pda/heads/lp/commissioner
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	alt_uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt
	dcoat = /obj/item/clothing/suit/jacket
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com


/datum/job/scientist/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_AI, ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_AI, ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE)
	outfit = /datum/outfit/job/scientist/lp

/datum/outfit/job/scientist/lp
	ears = /obj/item/radio/headset/nanotrasen
	jobtype = /datum/job/scientist/lp

/datum/job/mining/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	outfit = /datum/outfit/job/miner/lp

/datum/outfit/job/miner/lp
	ears = /obj/item/radio/headset/nanotrasen
	jobtype = /datum/job/mining/lp

/datum/job/doctor/lp
	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_EVA, ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY, ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM)
	outfit = /datum/outfit/job/doctor/lp

/datum/outfit/job/doctor/lp
	ears = /obj/item/radio/headset/nanotrasen
	jobtype = /datum/job/doctor/lp

/datum/job/bartender/lp
	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE, ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	minimal_access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE, ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	outfit = /datum/outfit/job/bartender/lp

/datum/outfit/job/bartender/lp
	ears = /obj/item/radio/headset/nanotrasen
	jobtype = /datum/job/bartender/lp
