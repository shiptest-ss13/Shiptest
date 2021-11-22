/datum/gear/dice
	display_name = "d20"
	path = /obj/item/dice/d20
	cost = 300

/datum/gear/briefcase
	display_name = "briefcase"
	path = /obj/item/storage/briefcase
	cost = 300

/datum/gear/lipstick
	display_name = "lipstick, black"
	path = /obj/item/lipstick/black
	cost = 700

/datum/gear/lipstick/red
	display_name = "lipstick, red"
	path = /obj/item/lipstick
	cost = 700

/datum/gear/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava
	cost = 700

/datum/gear/vape
	display_name = "vape"
	path = /obj/item/clothing/mask/vape
	cost = 700

/datum/gear/bandana
	display_name = "bandana, red"
	path = /obj/item/clothing/mask/bandana/red
	cost = 500

/datum/gear/bible
	display_name = "bible"
	path = /obj/item/storage/book/bible
	cost = 750

/datum/gear/flask
	display_name = "flask"
	path = /obj/item/reagent_containers/food/drinks/flask
	cost = 750

/datum/gear/mug
	display_name = "coffee mug"
	path = /obj/item/reagent_containers/food/drinks/britcup
	cost = 500

/datum/gear/lighter
	display_name = "cheap lighter"
	path = /obj/item/lighter/greyscale
	cost = 300
/datum/gear/zippo
	display_name = "zippo"
	path = /obj/item/lighter
	cost = 500

/datum/gear/clockworkzippo
	display_name = "Clockwork Zippo"
	path = /obj/item/lighter/clockwork
	cost = 750

/datum/gear/cards
	display_name = "toy, deck of cards"
	path = /obj/item/toy/cards/deck
	cost = 500

/datum/gear/eightball
	display_name = "toy, magic eight ball"
	path = /obj/item/toy/eightball
	cost = 750

/datum/gear/box
	display_name = "box"
	path = /obj/item/storage/box
	description = "It never hurts to carry an extra box."
	cost = 500

/datum/gear/wallet
	display_name = "wallet"
	path = /obj/item/storage/wallet
	cost = 750

/datum/gear/pai
	display_name = "personal AI device"
	path = /obj/item/paicard
	cost = 1000

/datum/gear/tablet
	display_name = "tablet computer"
	path = /obj/item/modular_computer/tablet
	cost = 1500

/datum/gear/pen
	display_name = "pen, black"
	path = /obj/item/pen
	cost = 250

/datum/gear/colorpen
	display_name = "pen, four-color"
	path = /obj/item/pen/fourcolor
	cost = 500

/datum/gear/paperbin
	display_name = "paper bin"
	path = /obj/item/paper_bin
	cost = 500

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/cane
	cost = 500

/datum/gear/radio
	display_name = "hand radio"
	path = /obj/item/radio
	cost = 500

/datum/gear/moth
	display_name = "toy, moth plushie"
	path = /obj/item/toy/plush/moth
	cost = 1500

/datum/gear/hornet
	display_name = "toy, marketable hornet plushie"
	path = /obj/item/toy/plush/hornet
	cost = 2000

/datum/gear/gayhornet
	display_name = "toy, gay hornet plushie"
	path = /obj/item/toy/plush/hornet/gay
	description = "Hornet says lesbian rights."
	cost = 6969

/datum/gear/knight
	display_name = "toy, marketable knight plushie"
	path = /obj/item/toy/plush/knight
	cost = 2000 //imagine not being able to afford the marketable plushes

// Shiptest edit
/datum/gear/amongus
	display_name = "toy, suspicious pill plushie"
	path = /obj/item/toy/plush/among
	cost = 1000

/datum/gear/amongus/New()
	. = ..()
	var/obj/item/toy/plush/among/temp = new path()
	description = "[capitalize(pick(temp.among_colors))] sus."
	qdel(temp)

/datum/gear/hairspray
	display_name = "hair dye"
	path = /obj/item/dyespray
	cost = 700

/datum/gear/tablebell
	display_name = "table bell, brass"
	path = /obj/item/table_bell/brass
	cost = 100000 //yes

// End Shiptest

/datum/gear/flashlight
	display_name = "tool, flashlight"
	path = /obj/item/flashlight
	cost = 500

/datum/gear/crowbar
	display_name = "tool, emergency crowbar"
	path = /obj/item/crowbar/red
	cost = 500

/datum/gear/balloon
	display_name = "toy, balloon"
	path = /obj/item/toy/balloon
	cost = 500

/datum/gear/balloon/ian
	display_name = "toy, ian balloon"
	path = /obj/item/toy/balloon/corgi
	cost = 2500

/datum/gear/surgical_mask
	display_name = "surgical mask"
	path = /obj/item/clothing/mask/surgical
	cost = 1200
