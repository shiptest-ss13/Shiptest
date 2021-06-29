//this code is not final

/obj/item/disk
	icon = 'whitesands/icons/obj/diskette.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "disk_map"
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound =  'sound/items/handling/disk_pickup.ogg'
	var/random_color = TRUE
	var/illustration = "generic"
	var/static/list/random_disk_colors = list(
		"blue" = "#8080ff",
		"red" = "#ff666e",
		"pink" = "#fd99ff",
		"brown" = "#b38459",
		"green" = "#9fe3a9",
		"cyan" = "#96ffef",
		"yellow" = "#ffe366"
	)

obj/item/disk/Initialize()
	. = ..()
	icon_state = "disk"
	if(random_color) //random colors!
		var/our_color = pick(random_disk_colors)
		add_atom_colour(random_disk_colors[our_color], FIXED_COLOUR_PRIORITY)
	else
		add_atom_colour(color, FIXED_COLOUR_PRIORITY)
	update_icon()
	update_overlays()

/obj/item/disk/update_overlays()
	. = ..()
	var/mutable_appearance/label = mutable_appearance(icon, "label")
	var/mutable_appearance/protect = mutable_appearance(icon, "protect")
	protect.appearance_flags = RESET_COLOR
	label.appearance_flags = RESET_COLOR
	. += label
	. += protect
	if(illustration)
		var/mutable_appearance/writing = mutable_appearance(icon, illustration)
		writing.appearance_flags = RESET_COLOR
		. += writing

/obj/item/disk/design_disk
	random_color = FALSE
	icon_state = "disk_map"
	color = "#3C2798"

/obj/item/disk/tech_disk
	random_color = FALSE
	icon_state = "disk_map"
	color = "#973328"

/obj/item/disk/nuclear
	random_color = FALSE
	icon_state = "disk_map"
	color = "#4ED57C"
	illustration = "nuke_useless"
	desc = "The authentication disk of a nuclear bomb. This is probably useless."

/obj/item/disk/tech_disk/major
	icon_state = "disk_map"
	color = "#FFBAFF"
	illustration = "bepis"

/obj/item/disk/holodisk
	random_color = FALSE
	icon_state = "disk_map"
	color = "#A7A3A6"
	illustration = "holo"

/obj/item/disk/data
	icon_state = "disk_map"
	illustration = "dna"

/obj/item/disk/design_disk/modkit_disc
	illustration = "accel"

/obj/item/disk/design_disk/ammo_1911
	illustration = "ammo"

/obj/item/disk/design_disk/adv/knight_gear
	illustration = "sword"

/obj/item/disk/design_disk/adv/cleric_mace
	illustration = "sword"

/obj/item/disk/design_disk/golem_shell
	illustration = "poyo"

//security
/obj/item/disk/design_disk/sec
	name = "security design disk"
	desc = "A design disk for use in a autolathe. Includes designs for security departments."
	color = "#BE4130"
	illustration = "security"

/obj/item/disk/design_disk/sec/shotgundb
	name = "Double Barrel Shotgun disk"
	illustration = "gun"

/obj/item/disk/design_disk/sec/shotgun
	name = "Standard Issue Shotgun disk"
	illustration = "gun"

/obj/item/disk/design_disk/sec/riotshotgun
	name = "Riot Shotgun disk"
	illustration = "gun"

/obj/item/disk/design_disk/sec/combatshotgun
	name = "SPAS-12 disk"
	illustration = "gun"

/obj/item/disk/design_disk/sec/combatshotgun
	name = "Disabler disk"
	illustration = "gun"

/obj/item/disk/design_disk/sec/standard
	name = "Standard security equipment disk"

/obj/item/disk/design_disk/sec/baton
	name = "Stun baton disk"

/obj/item/disk/design_disk/sec/flash
	name = "Flash disk"

/obj/item/disk/design_disk/sec/det
	name = "Colt Detective's kit disk"

/obj/item/disk/design_disk/sec/m1911
	name = "Colt M1911"

//research
/obj/item/disk/design_disk/rd
	name = "research design disk"
	desc = "A design disk for use in a autolathe. Includes designs for research departments."
	color = "#7D59AE"
	illustration = "sci"

//engineering
/obj/item/disk/design_disk/engi
	name = "engineering design disk"
	desc = "A design disk for use in a autolathe. Includes designs for engineering departments."
	color = "#D6A001"
	illustration = "engineering"

//medical
/obj/item/disk/design_disk/med
	name = "medical design disk"
	desc = "A design disk for use in a autolathe. Includes designs for engineering departments."
	color = "#6DA0BE"
	illustration = "med"

//soviet
/obj/item/disk/design_disk/russia
	name = "russian design disk"
	desc = "A design disk for use in a autolathe. It reads: Dlya tekh, kto prodvigayet tsivilizatsiyu. The label is a little faded."
	color = "#DA251D"
	illustration = "russia"

/obj/item/disk/design_disk/russia/soviet
	desc = "A design disk for use in a autolathe. It reads: Sobstvennost' slovatskogo pravitel'stva."
	illustration = "soviet"

//nanotresen
/obj/item/disk/design_disk/nt
	name = "nanotrasen design disk"
	desc = "A design disk for use in a autolathe. Includes high tech designs from nanotrasen."
	color = "#19196E"
	illustration = "nt"

/obj/item/disk/design_disk/nt/old
	name = "old design disk"
	desc = "A design disk for use in a autolathe. This is a old nanotrasen design."
	color = "#004E82"
	illustration = "nt_old"

//solgov
/obj/item/disk/design_disk/solgov
	name = "solgov design disk"
	desc = "A design disk for use in a autolathe. Includes designs from Solgov."
	color = "#4C5B76"
	illustration = "solgov"
/obj/item/disk/design_disk/solgov_old
	name = "solgov design disk"
	desc = "A design disk for use in a autolathe. Includes old designs from Solgov."
	color = "#00AC56"
	illustration = "solgov_old"

/obj/item/disk/design_disk/solgov_older
	name = "ancient design disk"
	desc = "A design disk for use in a autolathe. This thing probably hasn't been touched in many years, and the label is faded away."
	color = "#5B92E5"
	illustration = "solgov_older"

//lavaland
/obj/item/disk/design_disk/lavaland
	name = "lavaland design disk"
	desc = "A strange disk, with no label. Something complells you to stick it in a autolathe."
	color = "#6F6F6F"
	illustration = "rd_major"

/obj/item/disk/design_disk/amogus_plushie
	name = "suspicous design disk"
	desc = "A design disc with no markings besides a drawing of a space man."
	illustration = "sus"
	var/modkit_design = /datum/design/amogus_plushie

/datum/design/amogus_plushie
	name = "Suspicous Plush"
	desc = "Sometimes, you want to yell, but the thing that you want to yell at is also the most adorable thing in the world."
	id = "amogus_plushie"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = 6000)
	build_path = /obj/item/toy/plush/among
	category = list("Imported")
