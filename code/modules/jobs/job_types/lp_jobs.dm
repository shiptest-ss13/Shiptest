/datum/job/lp/lieutenant
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 5592, 5832, 2398)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 5592, 5832, 2398)

/datum/outfit/job/lp/lieutenant
	name = "LP Lieutenant"
	jobtype = /datum/job/lp/lieutenant

	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/lieutenant
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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 5592, 5376)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 5592, 5376)

/datum/outfit/job/lp/security
	name = "LP Security Specialist"
	jobtype = "/datum/job/lp/security"

	id = /obj/item/card/id/lpsec
	belt = /obj/item/pda/security
	gloves = /obj/item/clothing/gloves/color/captain
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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 5832, 8357)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 5832, 8357)

/datum/outfit/job/lp/engineer
	name = "LP Engineering Specialist"
	jobtype = /datum/job/lp/engineer

	id = /obj/item/card/id/lpengie
	belt = /obj/item/pda/engineering
	gloves = /obj/item/clothing/gloves/color/captain
	uniform = /obj/item/clothing/under/rank/engineering/engineer/maintenance_tech/lp
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/maintenance_tech/skirt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/eng
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/ert/engineer
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi


/datum/job/lp/medic
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 9377)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 9377)

/datum/outfit/job/lp/medic
	name = "LP Medical specialist"
	jobtype = /datum/job/lp/medic

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 5832, 6732)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617, 5832, 6732)

/datum/outfit/job/lp/commissioner
	name = "LP Commissioner"
	jobtype = /datum/job/lp/commissioner

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 5832)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 5832)

/datum/outfit/job/scientist/lp
	id = /obj/item/card/id/scilp
	jobtype = /datum/job/scientist/lp

/datum/job/miner/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425)

/datum/outfit/job/miner/lp
	id = /obj/item/card/id/minelp
	jobtype = /datum/job/miner/lp


/datum/job/doctor/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425, 7921, 3617)

/datum/outfit/job/doctor/lp
	id = /obj/item/card/id/doclp
	jobtype = /datum/job/doctor/lp

/datum/job/bartender/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, 6425)

/datum/outfit/job/bartender/lp
	id = /obj/item/card/id/barlp
