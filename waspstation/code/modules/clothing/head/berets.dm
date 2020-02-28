//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, a mime's favorite headwear."
	icon = 'waspstation/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/head.dmi'
	icon_state = "beret"
	dog_fashion = /datum/dog_fashion/head/beret
	dynamic_hair_suffix = "+generic"
	dynamic_fhair_suffix = "+generic"

/obj/item/clothing/head/beret/vintage
	name = "vintage beret"
	desc = "A well-worn beret."
	icon_state = "vintageberet"
	dog_fashion = null

/obj/item/clothing/head/beret/archaic
	name = "archaic beret"
	desc = "An absolutely ancient beret, allegedly worn by the first mime to ever step foot on a NanoTrasen station."
	icon_state = "archaicberet"
	dog_fashion = null

/obj/item/clothing/head/beret/black
	name = "black beret"
	desc = "A black beret, perfect for war veterans and dark, brooding, anti-hero mimes."
	icon_state = "beretblack"

/obj/item/clothing/head/beret/highlander
	desc = "That was white fabric. <i>Was.</i>"
	dog_fashion = null //THIS IS FOR SLAUGHTER, NOT PUPPIES

/obj/item/clothing/head/beret/highlander/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER)

/obj/item/clothing/head/beret/durathread
	name = "durathread beret"
	desc =  "A beret made from durathread, its resilient fibres provide some protection to the wearer."
	icon_state = "beretdurathread"
	armor = list("melee" = 15, "bullet" = 5, "laser" = 15, "energy" = 25, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 5)

//Sec
/obj/item/clothing/head/beret/corpwarden
	name = "corporate warden beret"
	desc = "A special black beret with a Warden's insignia in the middle. This one is commonly warn by wardens of the corporation."
	icon_state = "beret_corporate_warden"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "rad" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "rad" = 60)
	strip_delay = 60

/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A robust beret with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "beret_officer"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 50)
	strip_delay = 60
	dog_fashion = null

/obj/item/clothing/head/beret/corpsec
	name = "corporate security beret"
	desc = "A special black beret for the mundane life of a corporate security officer."
	icon_state = "beret_corporate_officer"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 10, "rad" = 25, "bio" = 0, "rad" = 0, "fire" = 20, "rad" = 50)
	strip_delay = 60

/obj/item/clothing/head/beret/sec/navyhos
	name = "head of security's beret"
	desc = "A special beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon_state = "hosberet"

/obj/item/clothing/head/beret/sec/navywarden
	name = "warden's beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "wardenberet"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/beret/sec/navyofficer
	desc = "A special beret with the security insignia emblazoned on it. For officers with class."
	icon_state = "officerberet"

//Engineering
/obj/item/clothing/head/beret/eng
	name = "engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety."
	icon_state = "beret_engineering"
	armor = list("rad" = 10, "fire" = 10)
	strip_delay = 60

/obj/item/clothing/head/beret/atmos
	name = "atmospherics beret"
	desc = "A beret for those who have shown immaculate proficienty in piping. Or plumbing."
	icon_state = "beret_atmospherics"
	armor = list("rad" = 10, "fire" = 10)
	strip_delay = 60

/obj/item/clothing/head/beret/ce
	name = "chief engineer beret"
	desc = "A white beret with the engineering insignia emblazoned on it. Its owner knows what they're doing. Probably."
	icon_state = "beret_ce"
	armor = list("rad" = 20, "fire" = 30)
	strip_delay = 60

//Science
/obj/item/clothing/head/beret/sci
	name = "science beret"
	desc = "A purple beret with the science insignia emblazoned on it. It has that authentic burning plasma smell."
	icon_state = "beret_sci"
	armor = list("rad" = 5, "bio" = 5, "fire" = 5, "rad" = 10)
	strip_delay = 60

//Medical
/obj/item/clothing/head/beret/med
	name = "medical beret"
	desc = "A white beret with a blue cross finely threaded into it. It has that sterile smell about it."
	icon_state = "beret_med"
	armor = list("bio" = 20)
	strip_delay = 60

/obj/item/clothing/head/beret/cmo
	name = "chief medical officer beret"
	desc = "A baby blue beret with the insignia of Medistan. It smells very sterile."
	icon_state = "beret_cmo"
	armor = list("bio" = 30, "acid" = 20)
	strip_delay = 60

//Command
/obj/item/clothing/head/beret/captain
	name = "captain beret"
	desc = "A lovely blue Captain beret with a gold and white insignia."
	icon_state = "beret_captain"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 90

/obj/item/clothing/head/beret/hop
	name = "head of personnel beret"
	desc = "A lovely blue Head of Personnel's beret with a silver and white insignia. It smells faintly of paper."
	icon_state = "beret_hop"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 90

/obj/item/clothing/head/beret/cccaptain
	name = "central command captain beret"
	desc = "A pure white beret with a Captain insignia of Central Command."
	icon_state = "beret_centcom_captain"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 80, "energy" = 80, "rad" = 80, "bio" = 80, "rad" = 80, "fire" = 80, "rad" = 80)
	strip_delay = 120

/obj/item/clothing/head/beret/ccofficer
	name = "central command officer beret"
	desc = "A black Central Command Officer beret with matching insignia."
	icon_state = "beret_centcom_officer"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 80, "energy" = 80, "rad" = 80, "bio" = 80, "rad" = 80, "fire" = 80, "rad" = 80)
	strip_delay = 120

/obj/item/clothing/head/beret/ccofficernavy
	name = "central command navy officer beret"
	desc = "A navy beret commonly worn by Central Command Officers."
	icon_state = "beret_centcom_officer_navy"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 80, "energy" = 80, "rad" = 80, "bio" = 80, "rad" = 80, "fire" = 80, "rad" = 80)
	strip_delay = 120

/obj/item/clothing/head/beret/lt
	name = "officer beret"
	desc = "A lieutenants's beret. Smells of spilled coffee."
	icon_state = "beret_centcom_officer"
	armor = list("melee" = 40, "bullet" = 20, "laser" = 10, "energy" = 10, "rad" = 10, "bio" = 5, "rad" = 5, "fire" = 5, "rad" = 30)
	strip_delay = 60

/obj/item/clothing/head/beret/lt/navy
	name = "navy officer beret"
	desc = "A navy lieutenant's beret. Smells of spilled coffee."
	icon_state = "beret_centcom_officer_navy"
