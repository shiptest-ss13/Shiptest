/datum/outfit/job/gezena
	name = "PGF - Base Outfit"
	// faction_icon = "bg_pgf"

/datum/outfit/job/gezena/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_GEZENA)

/datum/outfit/job/gezena/assistant
	name = "PGF - Deckhand"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	head = /obj/item/clothing/head/gezena
	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/toggle/gezena
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena

/datum/outfit/job/gezena/captain
	name = "Captain (PGF)"
	jobtype = /datum/job/captain

	head = /obj/item/clothing/head/gezena/captain
	neck = /obj/item/clothing/neck/cloak/gezena/captain
	uniform = /obj/item/clothing/under/gezena/captain
	suit = /obj/item/clothing/suit/armor/gezena/captain
	gloves = /obj/item/clothing/gloves/gezena/captain
	shoes = /obj/item/clothing/shoes/combat/gezena

/datum/outfit/job/gezena/officer
	name = "Officer (PGF)"
	jobtype = /datum/job/head_of_personnel

	head = /obj/item/clothing/head/gezena/captain

/datum/outfit/job/gezena/engineer
	name = "Ship Engineer (PGF)"
	jobtype = /datum/job/engineer

	neck = /obj/item/clothing/neck/cloak/gezena/engi
	suit = /obj/item/clothing/suit/armor/gezena/engi
	gloves = /obj/item/clothing/gloves/gezena/engi

/datum/outfit/job/gezena/marine
	name = "Marine (PGF)"
	jobtype = /datum/job/officer

	head = /obj/item/clothing/head/gezena/marine/flap
	uniform = /obj/item/clothing/under/gezena/marine
	gloves = /obj/item/clothing/gloves/gezena/marine

/datum/outfit/job/gezena/marine/medic
	name = "Medic (PGF)"
	jobtype = /datum/job/doctor

	head = /obj/item/clothing/head/gezena/medic/flap
	neck = /obj/item/clothing/neck/cloak/gezena/med
