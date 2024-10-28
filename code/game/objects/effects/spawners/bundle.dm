/obj/effect/spawner/costume
	name = "costume spawner"
	icon = 'icons/hud/screen_gen.dmi'
	icon_state = "x2"
	color = COLOR_VIBRANT_LIME

	var/list/items

/obj/effect/spawner/costume/Initialize(mapload)
	. = ..()
	if(items?.len)
		for(var/path in items)
			new path(loc)

/obj/effect/spawner/costume/gladiator
	name = "gladiator costume spawner"
	items = list(
		/obj/item/clothing/under/costume/gladiator,
		/obj/item/clothing/head/helmet/gladiator
	)

/obj/effect/spawner/costume/madscientist
	name = "mad scientist costume spawner"
	items = list(
		/obj/item/clothing/under/rank/command/captain/suit,
		/obj/item/clothing/head/flatcap,
		/obj/item/clothing/suit/toggle/labcoat/mad
	)

/obj/effect/spawner/costume/elpresidente
	name = "el presidente costume spawner"
	items = list(
		/obj/item/clothing/under/rank/command/captain/suit,
		/obj/item/clothing/head/flatcap,
		/obj/item/clothing/mask/cigarette/cigar/havana,
		/obj/item/clothing/shoes/jackboots
	)

/obj/effect/spawner/costume/nyangirl
	name = "nyangirl costume spawner"
	items = list(
		/obj/item/clothing/under/costume/schoolgirl,
		/obj/item/clothing/head/kitty,
		/obj/item/clothing/glasses/blindfold
	)

/obj/effect/spawner/costume/maid
	name = "maid costume spawner"
	items = list(
		/obj/item/clothing/under/dress/skirt/color,
		/obj/effect/spawner/random/clothing/beret_or_rabbitears,
		/obj/item/clothing/glasses/blindfold
	)

/obj/effect/spawner/costume/butler
	name = "butler costume spawner"
	items = list(
		/obj/item/clothing/accessory/waistcoat,
		/obj/item/clothing/under/suit/black,
		/obj/item/clothing/head/that
	)

/obj/effect/spawner/costume/highlander
	name = "highlander costume spawner"
	items = list(
		/obj/item/clothing/under/costume/kilt,
		/obj/item/clothing/head/beret
	)

/obj/effect/spawner/costume/prig
	name = "prig costume spawner"
	items = list(
		/obj/item/clothing/accessory/waistcoat,
		/obj/effect/spawner/random/clothing/bowler_or_that,
		/obj/item/clothing/shoes/sneakers/black,
		/obj/item/cane,
		/obj/item/clothing/under/suit/sl,
		/obj/item/clothing/mask/fakemoustache
	)

/obj/effect/spawner/costume/plaguedoctor
	name = "plague doctor costume spawner"
	items = list(
		/obj/item/clothing/suit/bio_suit/plaguedoctorsuit,
		/obj/item/clothing/mask/gas/plaguedoctor
	)

/obj/effect/spawner/costume/nightowl
	name = "night owl costume spawner"
	items = list(
		/obj/item/clothing/suit/toggle/owlwings,
		/obj/item/clothing/under/costume/owl,
		/obj/item/clothing/mask/gas/owl_mask
	)

/obj/effect/spawner/costume/waiter
	name = "waiter costume spawner"
	items = list(
		/obj/item/clothing/under/suit/waiter,
		/obj/effect/spawner/random/clothing/kittyears_or_rabbitears,
		/obj/item/clothing/suit/apron
	)

/obj/effect/spawner/costume/pirate
	name = "pirate costume spawner"
	items = list(
		/obj/item/clothing/under/costume/pirate,
		/obj/item/clothing/suit/pirate,
		/obj/effect/spawner/random/clothing/pirate_or_bandana,
		/obj/item/clothing/glasses/eyepatch
	)

/obj/effect/spawner/costume/cutewitch
	name = "cute witch costume spawner"
	items = list(
		/obj/item/clothing/under/dress/sundress,
		/obj/item/staff/broom
	)

/obj/effect/spawner/costume/mafia
	name = "black mafia outfit spawner"
	items = list(
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/under/suit/blacktwopiece,
		/obj/item/clothing/shoes/laceup
	)

/obj/effect/spawner/costume/mafia/white
	name = "white mafia outfit spawner"
	items = list(
		/obj/item/clothing/head/fedora/white,
		/obj/item/clothing/under/suit/white,
		/obj/item/clothing/shoes/laceup
	)

/obj/effect/spawner/costume/mafia/checkered
	name = "checkered mafia outfit spawner"
	items = list(
		/obj/item/clothing/head/fedora,
		/obj/item/clothing/under/suit/checkered,
		/obj/item/clothing/shoes/laceup
	)

/obj/effect/spawner/costume/mafia/beige
	name = "beige mafia outfit spawner"
	items = list(
		/obj/item/clothing/head/fedora/beige,
		/obj/item/clothing/under/suit/beige,
		/obj/item/clothing/shoes/laceup
	)
