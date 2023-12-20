/datum/gear/dice
	display_name = "d20"
	path = /obj/item/dice/d20

/datum/gear/briefcase
	display_name = "briefcase"
	path = /obj/item/storage/briefcase

/datum/gear/lipstick
	display_name = "lipstick, black"
	path = /obj/item/lipstick/black

/datum/gear/lipstick/red
	display_name = "lipstick, red"
	path = /obj/item/lipstick

/datum/gear/balaclava
	display_name = "balaclava"
	path = /obj/item/clothing/mask/balaclava

/datum/gear/vape
	display_name = "vape"
	path = /obj/item/clothing/mask/vape

/datum/gear/ecigar
	display_name = "e-cigar"
	path = /obj/item/clothing/mask/vape/cigar

/datum/gear/bandana
	display_name = "bandana, red"
	path = /obj/item/clothing/mask/bandana/red

/datum/gear/bible
	display_name = "bible"
	path = /obj/item/storage/book/bible

/datum/gear/flask
	display_name = "flask"
	path = /obj/item/reagent_containers/food/drinks/flask

/datum/gear/mug
	display_name = "coffee mug"
	path = /obj/item/reagent_containers/food/drinks/britcup

/datum/gear/lighter
	display_name = "cheap lighter"
	path = /obj/item/lighter/greyscale

/datum/gear/zippo
	display_name = "zippo"
	path = /obj/item/lighter

/datum/gear/clockworkzippo
	display_name = "Clockwork Zippo"
	path = /obj/item/lighter/clockwork

/datum/gear/cards
	display_name = "toy, deck of cards"
	path = /obj/item/toy/cards/deck

/datum/gear/eightball
	display_name = "toy, magic eight ball"
	path = /obj/item/toy/eightball

/datum/gear/wallet
	display_name = "wallet"
	path = /obj/item/storage/wallet

/datum/gear/pai
	display_name = "personal AI device"
	path = /obj/item/paicard

/datum/gear/tablet
	display_name = "tablet computer"
	path = /obj/item/modular_computer/tablet/preset/cheap

/datum/gear/laptop
	display_name = "laptop computer"
	path = /obj/item/modular_computer/laptop/preset/civilian

/datum/gear/pen
	display_name = "pen, black"
	path = /obj/item/pen

/datum/gear/colorpen
	display_name = "pen, four-color"
	path = /obj/item/pen/fourcolor

/datum/gear/paperbin
	display_name = "paper bin"
	path = /obj/item/paper_bin

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/cane

/datum/gear/radio
	display_name = "hand radio"
	path = /obj/item/radio

/datum/gear/lizard
	display_name = "toy, lizard plushie"
	path = /obj/item/toy/plush/lizardplushie

/datum/gear/snake
	display_name = "toy, snake plushie"
	path = /obj/item/toy/plush/snakeplushie

/datum/gear/moth
	display_name = "toy, moth plushie"
	path = /obj/item/toy/plush/moth

/datum/gear/hornet
	display_name = "toy, marketable hornet plushie"
	path = /obj/item/toy/plush/hornet

/datum/gear/gayhornet
	display_name = "toy, gay hornet plushie"
	path = /obj/item/toy/plush/hornet/gay
	description = "Hornet says lesbian rights."

/datum/gear/knight
	display_name = "toy, marketable knight plushie"
	path = /obj/item/toy/plush/knight

// Shiptest edit
/datum/gear/amongus
	display_name = "toy, suspicious pill plushie"
	path = /obj/item/toy/plush/among

/datum/gear/amongus/New()
	. = ..()
	var/obj/item/toy/plush/among/temp = new path()
	description = "[capitalize(pick(temp.among_colors))] sus."
	qdel(temp)

/datum/gear/hairspray
	display_name = "hair dye"
	path = /obj/item/dyespray

/datum/gear/tablebell
	display_name = "table bell, brass"
	path = /obj/item/table_bell/brass

// End Shiptest

/datum/gear/flashlight
	display_name = "tool, flashlight"
	path = /obj/item/flashlight

/datum/gear/crowbar
	display_name = "tool, emergency crowbar"
	path = /obj/item/crowbar/red

/datum/gear/balloon
	display_name = "toy, balloon"
	path = /obj/item/toy/balloon

/datum/gear/balloon/ian
	display_name = "toy, ian balloon"
	path = /obj/item/toy/balloon/corgi

/datum/gear/surgical_mask
	display_name = "surgical mask"
	path = /obj/item/clothing/mask/surgical
