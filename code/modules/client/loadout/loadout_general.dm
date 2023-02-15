//Toys
/datum/gear/toy
	subtype_path = /datum/gear/toy
	sort_categories = "Toys"

/datum/gear/toy/cards
	display_name = "toy, deck of cards"
	path = /obj/item/toy/cards/deck

/datum/gear/toy/eightball
	display_name = "toy, magic eight ball"
	path = /obj/item/toy/eightball

	//Dice

/datum/gear/toy/dice
	subtype_path = /datum/gear/toy/dice
	sort_categories = "Toys, Dice"

/datum/gear/toy/dice/d20
	display_name = "d20"
	path = /obj/item/dice/d20

	//Plushies

/datum/gear/toy/plush
	subtype_path = /datum/gear/toy/plush
	sort_categories = "Toys, Plushies"

/datum/gear/toy/plush/lizard
	display_name = "toy, lizard plushie"
	path = /obj/item/toy/plush/lizardplushie

/datum/gear/toy/plush/snake
	display_name = "toy, snake plushie"
	path = /obj/item/toy/plush/snakeplushie

/datum/gear/toy/plush/moth
	display_name = "toy, moth plushie"
	path = /obj/item/toy/plush/moth

/datum/gear/toy/plush/hornet
	display_name = "toy, marketable hornet plushie"
	path = /obj/item/toy/plush/hornet

/datum/gear/toy/plush/gayhornet
	display_name = "toy, gay hornet plushie"
	path = /obj/item/toy/plush/hornet/gay
	description = "Hornet says lesbian rights."

/datum/gear/toy/plush/knight
	display_name = "toy, marketable knight plushie"
	path = /obj/item/toy/plush/knight

/datum/gear/toy/plush/amongus
	display_name = "toy, suspicious pill plushie"
	path = /obj/item/toy/plush/among

/datum/gear/toy/plush/amongus/New()
	. = ..()
	var/obj/item/toy/plush/among/temp = new path()
	description = "[capitalize(pick(temp.among_colors))] sus."
	qdel(temp)

	//Balloons

/datum/gear/toy/bloon
	subtype_path = /datum/gear/toy/bloon
	sort_categories = "Toys, Balloons"

/datum/gear/toy/bloon/balloon
	display_name = "toy, balloon"
	path = /obj/item/toy/balloon

/datum/gear/toy/bloon/ian
	display_name = "toy, ian balloon"
	path = /obj/item/toy/balloon/corgi

//Tools

/datum/gear/tool
	subtype_path = /datum/gear/tool
	sort_categories = "Tools"

/datum/gear/tool/flashlight
	display_name = "tool, flashlight"
	path = /obj/item/flashlight

/datum/gear/tool/crowbar
	display_name = "tool, emergency crowbar"
	path = /obj/item/crowbar/red

/datum/gear/tool/radio
	display_name = "hand radio"
	path = /obj/item/radio

	//Lighters
/datum/gear/tool/lighter
	subtype_path = /datum/gear/tool/lighter
	sort_categories = "Tools, Lighters"

/datum/gear/tool/lighter/lighter
	display_name = "cheap lighter"
	path = /obj/item/lighter/greyscale

/datum/gear/tool/lighter/zippo
	display_name = "zippo"
	path = /obj/item/lighter

/datum/gear/tool/lighter/clockworkzippo
	display_name = "Clockwork Zippo"
	path = /obj/item/lighter/clockwork

//Storage

/datum/gear/storage
	subtype_path = /datum/gear/storage
	sort_categories = "Storage"

/datum/gear/storage/briefcase
	display_name = "briefcase"
	path = /obj/item/storage/briefcase

/datum/gear/storage/wallet
	display_name = "wallet"
	path = /obj/item/storage/wallet

	//Reagent Containers

/datum/gear/storage/container
	subtype_path = /datum/gear/storage/container
	sort_categories = "Storage, Reagent Containers"

/datum/gear/storage/container/flask
	display_name = "flask"
	path = /obj/item/reagent_containers/food/drinks/flask

/datum/gear/storage/container/mug
	display_name = "coffee mug"
	path = /obj/item/reagent_containers/food/drinks/britcup

	//Loadout Packages

/datum/gear/storage/packages
	subtype_path = /datum/gear/storage/packages
	sort_categories = "Storage, Loadout Packages"

/datum/gear/storage/packages/maidbox
	display_name = "maid outfit bundle"
	path = /obj/item/storage/box/maid
	description = "Contains a four-piece maid outfit inside a single box."
	cost = 20

	//Item Packets

/datum/gear/storage/packet
	subtype_path = /datum/gear/storage/packet
	sort_categories = "Storage, Item Packets"

/datum/gear/storage/packet/paperbin
	display_name = "paper bin"
	path = /obj/item/paper_bin

		//Smokes

/datum/gear/storage/packet/smokes
	subtype_path = /datum/gear/storage/packet/smokes
	sort_categories = "Storage, Item Packets, Smokes"

//Makeup

/datum/gear/makeup
	subtype_path = /datum/gear/makeup
	sort_categories = "Makeup"

/datum/gear/makeup/hairspray
	display_name = "hair dye"
	path = /obj/item/dyespray

	//Lipstick

/datum/gear/makeup/lipstick
	subtype_path = /datum/gear/makeup/lipstick
	sort_categories = "Lipstick, Makeup, Colored"

/datum/gear/makeup/lipstick/black
	display_name = "lipstick, black"
	path = /obj/item/lipstick/black
	sort_categories = "Lipstick, Makeup, Colored, Black"

/datum/gear/makeup/lipstick/red
	display_name = "lipstick, red"
	path = /obj/item/lipstick
	sort_categories = "Lipstick, Makeup, Colored, Red"

//Technology
/datum/gear/technology
	subtype_path = /datum/gear/technology
	sort_categories = "Technology"

/datum/gear/technology/vape
	display_name = "vape"
	path = /obj/item/clothing/mask/vape
	sort_categories = "Technology, Smokes"

/datum/gear/technology/ecigar
	display_name = "e-cigar"
	path = /obj/item/clothing/mask/vape/cigar
	sort_categories = "Technology, Smokes"

/datum/gear/technology/pai
	display_name = "personal AI device"
	path = /obj/item/paicard

/datum/gear/technology/tablet
	display_name = "tablet computer"
	path = /obj/item/modular_computer/tablet/preset/cheap

/datum/gear/technology/laptop
	display_name = "laptop computer"
	path = /obj/item/modular_computer/laptop/preset/civilian

//Misc

/datum/gear/bible
	display_name = "bible"
	path = /obj/item/storage/book/bible

/datum/gear/pen
	display_name = "pen, black"
	path = /obj/item/pen

/datum/gear/colorpen
	display_name = "pen, four-color"
	path = /obj/item/pen/fourcolor

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/cane

/datum/gear/tablebell
	display_name = "table bell, brass"
	path = /obj/item/table_bell/brass
