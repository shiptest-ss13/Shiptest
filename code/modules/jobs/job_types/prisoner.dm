/datum/job/prisoner
	name = "Prisoner"
	total_positions = 0
	spawn_positions = 2

	outfit = /datum/outfit/job/prisoner

	display_order = JOB_DISPLAY_ORDER_PRISONER

/datum/outfit/job/prisoner
	name = "Prisoner"
	job_icon = "prisoner"

	uniform = /obj/item/clothing/under/rank/prisoner
	alt_uniform = /obj/item/clothing/under/rank/prisoner //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/jacket/leather
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/prisoner
	ears = null
	belt = null

/datum/outfit/job/prisoner/protectedcustody
	name = "Prisoner (Protected Custody)"

	uniform = /obj/item/clothing/under/rank/prisoner/protected_custody
	alt_uniform = /obj/item/clothing/under/rank/prisoner/protected_custody
	alt_suit = null
	shoes = /obj/item/clothing/shoes/sneakers/orange

/datum/outfit/job/prisoner/shotcaller
	name = "Shotcaller"
	l_pocket = /obj/item/kitchen/knife/shiv

/datum/outfit/job/prisoner/syndicatepatient
	name = "Long Term Patient"
	id = /obj/item/card/id/patient
	uniform = /obj/item/clothing/under/misc/gown
	alt_suit = null
	shoes = /obj/item/clothing/shoes/sandal/slippers
