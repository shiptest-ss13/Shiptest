/datum/job/lp
	faction = "Station"

/datum/job/lp/lieutenant
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_VAULT, ACCESS_LP_AI, ACCESS_LP_LIEUTENANT)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_VAULT, ACCESS_LP_AI, ACCESS_LP_LIEUTENANT)
	outfit = /datum/outfit/job/lp/lieutenant

/datum/outfit/job/lp/lieutenant
	name = "LP Lieutenant"
	jobtype = /datum/job/lp/lieutenant

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_VAULT, ACCESS_LP_SECURITY)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_VAULT, ACCESS_LP_SECURITY)
	outfit = /datum/outfit/job/lp/security

/datum/outfit/job/lp/security
	name = "LP Security Specialist"
	jobtype = /datum/job/lp/security

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_AI, ACCESS_LP_ENGINEER)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_AI, ACCESS_LP_ENGINEER)
	outfit = /datum/outfit/job/lp/engineer

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_MEDIC)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_MEDIC)
	outfit = /datum/outfit/job/lp/medic

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_AI, ACCESS_LP_COMMISSIONER)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM, ACCESS_LP_AI, ACCESS_LP_COMMISSIONER)
	outfit = /datum/outfit/job/lp/commissioner

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
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_AI)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_AI)
	outfit = /datum/outfit/job/scientist/lp

/datum/outfit/job/scientist/lp
	id = /obj/item/card/id/scilp
	jobtype = /datum/job/scientist/lp

/datum/job/mining/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	outfit = /datum/outfit/job/miner/lp

/datum/outfit/job/miner/lp
	id = /obj/item/card/id/minelp
	jobtype = /datum/job/mining/lp


/datum/job/doctor/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES, ACCESS_LP_BRIDGE, ACCESS_LP_OPERATING_ROOM)
	outfit = /datum/outfit/job/doctor/lp

/datum/outfit/job/doctor/lp
	id = /obj/item/card/id/doclp
	jobtype = /datum/job/doctor/lp

/datum/job/bartender/lp
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	minimal_access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_LP_FACILITIES)
	outfit = /datum/outfit/job/bartender/lp

/datum/outfit/job/bartender/lp
	id = /obj/item/card/id/barlp
