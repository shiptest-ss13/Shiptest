
/datum/outfit/job/cybersun
	name = "Cybersun - Base Outfit"

	faction = FACTION_CYBERSUN

	uniform = /obj/item/clothing/under/cybersun
	alt_uniform = /obj/item/clothing/under/cybersun/suit
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/soft/cybersun

	id = /obj/item/card/id/syndicate_command/crew_id

	//faction_icon = "bg_cybersun"

	ears = /obj/item/radio/headset/syndicate/cybersun

/datum/outfit/job/cybersun/assistant
	name = "Cybersun - Junior Agent"
	jobtype = /datum/job/assistant

/datum/outfit/job/cybersun/engineer
	name = "Cybersun - Technician"

	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	uniform = /obj/item/clothing/under/cybersun/coverall
	alt_uniform = /obj/item/clothing/under/syndicate/gec
	shoes = /obj/item/clothing/shoes/workboots

/datum/outfit/job/cybersun/miner
	name = "Cybersun - Field Agent"
	id_assignment = "Field Agent"

	jobtype = /datum/job/mining
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/cybersun/overalls

/datum/outfit/job/cybersun/troubleshooter
	name = "Cybersun - Troubleshooter"
	id_assignment = "Troubleshooter"

	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/cybersun/suit
	head = /obj/item/clothing/head/soft/cybersun

/datum/outfit/job/cybersun/paramedic
	name = "Cybersun - Trauma Team"
	id_assignment = "Trauma Team Technician"

	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	uniform = /obj/item/clothing/under/cybersun/medic
	head = /obj/item/clothing/head/soft/cybersun/medical
	shoes = /obj/item/clothing/shoes/combat

/datum/outfit/job/cybersun/doctor
	name = "Cybersun - Medical Doctor"

	jobtype = /datum/job/doctor
	job_icon = "medicaldoctor"

	uniform = /obj/item/clothing/under/cybersun/medic
	suit = /obj/item/clothing/suit/cybersun/smock
	head = /obj/item/clothing/head/cybersun/medical
	shoes = /obj/item/clothing/shoes/combat

	neck = /obj/item/clothing/neck/stethoscope

	l_hand = /obj/item/storage/firstaid/medical
	l_pocket = /obj/item/pinpointer/crew

/* OFFICERS */

/datum/outfit/job/cybersun/officer
	name = "Cybersun - Officer Base"


	uniform = /obj/item/clothing/under/cybersun/officer
	suit = /obj/item/clothing/suit/cybersun
	head = /obj/item/clothing/head/cybersun
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots

	ears = /obj/item/radio/headset/syndicate/alt/cybersun

/datum/outfit/job/cybersun/officer/captain
	name = "Cybersun - Captain"
	id_assignment = "Captain"

	jobtype = /datum/job/captain
	job_icon = "headofsecurity"

	ears = /obj/item/radio/headset/syndicate/alt/captain
	uniform = /obj/item/clothing/under/cybersun/officer
	suit = /obj/item/clothing/suit/armor/cybersun

	head = /obj/item/clothing/head/cybersun
	id = /obj/item/card/id/syndicate_command/crew_id
	glasses = /obj/item/clothing/glasses/sunglasses


/datum/outfit/job/cybersun/officer/intelligence_officer
	name = "Cybersun - Intelligence Officer"
	id_assignment = "Intelligence Officer"

	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	uniform = /obj/item/clothing/under/cybersun/officer

	head = /obj/item/clothing/head/cybersun
	id = /obj/item/card/id/syndicate_command/crew_id
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/cybersun/officer/cmo
	name = "Cybersun - Medical Director"
	id_assignment = "Medical Director"

	jobtype = /datum/job/cmo
	job_icon = "chiefmedicalofficer"

	uniform = /obj/item/clothing/under/cybersun/doctor
	alt_uniform = /obj/item/clothing/under/cybersun/medic

	ears = /obj/item/radio/headset/syndicate/alt/captain
	id = /obj/item/card/id/syndicate_command/captain_id
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/cybersun/cmo

	suit = /obj/item/clothing/suit/cybersun
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/raincoat

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)
	box = /obj/item/storage/box/survival/medical
