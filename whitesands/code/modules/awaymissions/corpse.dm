/datum/outfit/whitesands
	name = "Whitesands Inhabitant Default Outfit"

/datum/outfit/whitesands/survivor
	name = "Whitesands Survivor"
	uniform = /obj/item/clothing/under/color/random
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/hooded/survivor
	r_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	gloves = /obj/item/clothing/gloves/color/black

/datum/outfit/whitesands/survivor/hunter
	name = "Whitesands Hunter"
	l_pocket = /obj/item/reagent_containers/food/snacks/meat/steak/goliath

/datum/outfit/whitesands/survivor/gunslinger
	name = "Whitesands Gunslinger"
	l_pocket = /obj/item/ammo_box/magazine/aks74u

/obj/effect/mob_spawn/human/corpse/whitesands
	death = TRUE
	roundstart = FALSE

/obj/effect/mob_spawn/human/corpse/whitesands/survivor
	name = "Whitesands Survivor Corpse"
	outfit = /datum/outfit/whitesands/survivor
	hairstyle = "Bald"
	skin_tone = "caucasian1"
	facial_hairstyle= "Shaved"

/obj/effect/mob_spawn/human/corpse/whitesands/survivor/hunter
	name = "Whitesands Hunter Corpse"
	outfit = /datum/outfit/whitesands/survivor/hunter

/obj/effect/mob_spawn/human/corpse/whitesands/survivor/gunslinger
	name = "Whitesands Gunslinger Corpse"
	outfit = /datum/outfit/whitesands/survivor/gunslinger
