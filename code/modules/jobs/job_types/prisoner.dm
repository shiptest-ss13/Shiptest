/datum/job/prisoner
	title = "Prisoner"
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 0
	spawn_positions = 2
	supervisors = "the security team"
	selection_color = "#ffe1c3"

	outfit = /datum/outfit/job/prisoner

	display_order = JOB_DISPLAY_ORDER_PRISONER

/datum/outfit/job/prisoner
	name = "Prisoner"

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
