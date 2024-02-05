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
