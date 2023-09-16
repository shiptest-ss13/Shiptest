/datum/outfit/job/gezena

/datum/outfit/job/gezena/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list("playergezena")

/datum/outfit/job/gezena/assistant
	name = "Deckhand (PGF)"
	jobtype = /datum/job/assistant

	head = /obj/item/clothing/head/gezena
	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/toggle/gezena
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
