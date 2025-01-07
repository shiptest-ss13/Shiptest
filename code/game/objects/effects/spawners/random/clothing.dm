/obj/effect/spawner/random/clothing
	name = "clothing loot spawner"
	desc = "Time to look pretty."
	icon_state = "suit"

/obj/effect/spawner/random/clothing/gloves
	name = "random gloves"
	desc = "These gloves are supposed to be a random color..."
	icon_state = "gloves"
	loot = list(
		/obj/item/clothing/gloves/color/orange,
		/obj/item/clothing/gloves/color/red,
		/obj/item/clothing/gloves/color/blue,
		/obj/item/clothing/gloves/color/purple,
		/obj/item/clothing/gloves/color/green,
		/obj/item/clothing/gloves/color/grey,
		/obj/item/clothing/gloves/color/light_brown,
		/obj/item/clothing/gloves/color/brown,
		/obj/item/clothing/gloves/color/white,
		/obj/item/clothing/gloves/color/rainbow
	)

/obj/effect/spawner/random/clothing/costume
	name = "random costume spawner"
	icon_state = "costume"
	loot_subtype_path = /obj/effect/spawner/costume
	loot = list()

/obj/effect/spawner/random/clothing/beret_or_rabbitears
	name = "beret or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/beret
	)

/obj/effect/spawner/random/clothing/bowler_or_that
	name = "bowler or top hat spawner"
	loot = list(
		/obj/item/clothing/head/that
	)

/obj/effect/spawner/random/clothing/kittyears_or_rabbitears
	name = "kitty ears or rabbit ears spawner"
	loot = list(
		/obj/item/clothing/head/kitty
	)

/obj/effect/spawner/random/clothing/pirate_or_bandana
	name = "pirate hat or bandana spawner"
	loot = list(
		/obj/item/clothing/head/pirate,
		/obj/item/clothing/head/bandana
	)

/obj/effect/spawner/random/clothing/twentyfive_percent_cyborg_mask
	name = "25% cyborg mask spawner"
	spawn_loot_chance = 25
	loot = list(/obj/item/clothing/mask/gas/cyborg)

/obj/effect/spawner/random/clothing/mafia_outfit
	name = "mafia outfit spawner"
	icon_state = "costume"
	loot = list(
		/obj/effect/spawner/costume/mafia = 20,
		/obj/effect/spawner/costume/mafia/white = 5,
		/obj/effect/spawner/costume/mafia/checkered = 2,
		/obj/effect/spawner/costume/mafia/beige = 5
	)
