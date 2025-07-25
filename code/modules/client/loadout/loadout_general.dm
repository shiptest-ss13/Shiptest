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

/datum/gear/vape
	display_name = "vape"
	path = /obj/item/clothing/mask/vape

/datum/gear/ecigar
	display_name = "e-cigar"
	path = /obj/item/clothing/mask/vape/cigar

/datum/gear/flask
	display_name = "flask"
	path = /obj/item/reagent_containers/food/drinks/flask

/datum/gear/mug
	display_name = "coffee mug"
	path = /obj/item/reagent_containers/food/drinks/mug

/datum/gear/rilena_mug
	display_name = "coffee mug, rilena"
	path = /obj/item/reagent_containers/food/drinks/rilenacup

/datum/gear/lighter
	display_name = "cheap lighter"
	path = /obj/item/lighter/greyscale

/datum/gear/zippo
	display_name = "zippo"
	path = /obj/item/lighter

/datum/gear/clockworkzippo
	display_name = "Clockwork Zippo"
	path = /obj/item/lighter/clockwork

/datum/gear/matches
	display_name = "matchbox"
	path = /obj/item/storage/box/matches

/datum/gear/candles
	display_name = "candle pack"
	path = /obj/item/storage/fancy/candle_box

/datum/gear/cards
	display_name = "toy, deck of cards"
	path = /obj/item/toy/cards/deck

/datum/gear/kotahi
	display_name = "toy, deck of KOTAHI cards"
	path = /obj/item/toy/cards/deck/kotahi

/datum/gear/tarot_cards
	display_name = "toy, deck of tarot cards"
	path = /obj/item/toy/cards/deck/tarot

/datum/gear/eightball
	display_name = "toy, magic eight ball"
	path = /obj/item/toy/eightball

/datum/gear/pai
	display_name = "personal AI device"
	description = "A synthetic friend that fits in your pocket."
	path = /obj/item/paicard

/datum/gear/tablet
	display_name = "tablet computer"
	path = /obj/item/modular_computer/tablet/preset/cheap

/datum/gear/laptop
	display_name = "laptop computer"
	path = /obj/item/modular_computer/laptop/preset/civilian

/datum/gear/rilena_laptop
	display_name = "rilena laptop computer"
	path = /obj/item/modular_computer/laptop/preset/civilian/rilena

/datum/gear/pen
	display_name = "pen, black"
	path = /obj/item/pen

/datum/gear/colorpen
	display_name = "pen, four-color"
	path = /obj/item/pen/fourcolor

/datum/gear/fountainpen
	display_name = "pen, fountain"
	path = /obj/item/pen/fountain

/datum/gear/paperbin
	display_name = "paper bin"
	path = /obj/item/paper_bin

/datum/gear/spraycan
	display_name = "spray can"
	path = /obj/item/toy/crayon/spraycan

/datum/gear/crayons
	display_name = "box of crayons"
	path = /obj/item/storage/crayons

/datum/gear/cane
	display_name = "cane"
	path = /obj/item/cane

/datum/gear/lizard
	display_name = "toy, lizard plushie"
	path = /obj/item/toy/plush/lizardplushie

/datum/gear/snake
	display_name = "toy, snake plushie"
	path = /obj/item/toy/plush/snakeplushie

/datum/gear/moth
	display_name = "toy, moth plushie box"
	path = /obj/item/choice_beacon/mothplushies

/datum/gear/bee
	display_name = "toy, bee plushie"
	path = /obj/item/toy/plush/beeplushie

/datum/gear/spider
	display_name = "toy, spider plushie"
	path = /obj/item/toy/plush/spider

/datum/gear/flushed
	display_name = "toy, flushed plushie"
	path = /obj/item/toy/plush/flushed

/datum/gear/blahaj
	display_name = "toy, Solarian Marine Society mascot plushie"
	path = /obj/item/toy/plush/blahaj

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

/datum/gear/ri
	display_name = "toy, rilena ri plushie"
	path = /obj/item/toy/plush/rilena

/datum/gear/tali
	display_name = "toy, rilena tali plushie"
	path = /obj/item/toy/plush/tali

/datum/gear/amongus
	display_name = "toy, suspicious pill plushie"
	path = /obj/item/toy/plush/among

/datum/gear/dice_bag
	display_name = "toy, bag of die"
	path = /obj/item/storage/pill_bottle/dice

/datum/gear/amongus/New()
	. = ..()
	var/obj/item/toy/plush/among/temp = new path()
	description = "[capitalize(pick(temp.among_colors))] sus."
	qdel(temp)

/datum/gear/hairspray
	display_name = "hair dye"
	path = /obj/item/dyespray

/datum/gear/colorsalve
	display_name = "Elzuose color salve"
	path = /obj/item/colorsalve

/datum/gear/tablebell
	display_name = "table bell"
	path = /obj/item/table_bell

/datum/gear/brasstablebell
	display_name = "table bell, brass"
	path = /obj/item/table_bell/brass

/datum/gear/flashlight
	display_name = "tool, flashlight"
	path = /obj/item/flashlight

/datum/gear/crowbar
	display_name = "tool, emergency crowbar"
	path = /obj/item/crowbar/red

/datum/gear/rilena_poster
	display_name = "poster, rilena"
	path = /obj/item/poster/random_rilena
	description = "A random poster of the RILENA series."

/datum/gear/camera
	display_name = "polaroid camera"
	path = /obj/item/camera

/datum/gear/hourglass
	display_name = "hourglass"
	path = /obj/item/hourglass

/datum/gear/spraycan
	display_name = "spraycan"
	path = /obj/item/toy/crayon/spraycan

/datum/gear/prescription_pills
	display_name = "prescription pills"
	path = /obj/item/storage/pill_bottle/placebatol

/datum/gear/prescription_injector
	display_name = "prescription injector"
	path = /obj/item/reagent_containers/hypospray/medipen/placebatol
