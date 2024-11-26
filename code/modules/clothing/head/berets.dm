//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A red beret."
	icon_state = "beret"
	dog_fashion = /datum/dog_fashion/head/beret

/obj/item/clothing/head/beret/black
	name = "black beret"
	desc = "A black beret."
	icon_state = "beret_black"

/obj/item/clothing/head/beret/highlander
	desc = "That was white fabric. <i>Was.</i>"
	dog_fashion = null //THIS IS FOR SLAUGHTER, NOT PUPPIES

/obj/item/clothing/head/beret/highlander/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER)

/obj/item/clothing/head/beret/durathread
	name = "durathread beret"
	desc =  "A beret made from durathread, its resilient fibres provide a modicum of fire protection to the wearer."
	icon_state = "beretdurathread"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 5, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 15, "acid" = 5)

//Civilian
/obj/item/clothing/head/beret/grey
	name = "grey beret"
	desc =  "A standard grey beret. Why an assistant would need a beret is unknown."
	icon_state = "beret_grey"

/obj/item/clothing/head/beret/puce
	name = "strange beret"
	desc =  "You're not sure what to make of this."
	icon_state = "beret_PUCE"

/obj/item/clothing/head/beret/service
	name = "service beret"
	desc =  "A standard Nanotrasen service beret. Held by those with the sanity to serve others in the far frontier."
	icon_state = "beret_serv"

/obj/item/clothing/head/beret/qm
	name = "quartermaster beret"
	desc =  "A cargo beret with a faded medal haphazardly stitched into it. Worn by a true cargonian, it commands respect from everyone."
	icon_state = "beret_qm"

/obj/item/clothing/head/beret/cargo
	name = "cargo beret"
	desc =  "A slightly faded mustard yellow beret. Usually held by the members of cargonia."
	icon_state = "beret_cargo"

/obj/item/clothing/head/beret/mining
	name = "mining beret"
	desc =  "A grey beret with a pickaxe insignia sewn into it."
	icon_state = "beret_mining"

//Sec
/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A robust beret with the security insignia emblazoned on it."
	icon_state = "beret_sec"
	dog_fashion = null

/obj/item/clothing/head/beret/sec/hos
	name = "head of security's black beret"
	desc = "A black beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon_state = "beret_hos"

/obj/item/clothing/head/beret/sec/warden
	name = "warden's beret"
	desc = "A beret made with black reinforced fabric with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "beret_warden"

/obj/item/clothing/head/beret/sec/officer
	desc = "A beret made out of black reinforced fabric with the security insignia emblazoned on it. For officers with class."
	icon_state = "beret_officer"

/obj/item/clothing/head/beret/sec/brig_phys
	desc = "A beret made out of black reinforced fabric with a lue cross emblazoned on it. Denotes security's personal medic."
	icon_state = "beret_brigphys"

//Engineering
/obj/item/clothing/head/beret/eng
	name = "engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety."
	icon_state = "beret_engineering"
	armor = list("rad" = 5, "fire" = 10)

/obj/item/clothing/head/beret/eng/hazard
	name = "engineering hazardberet"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety. This one seems to be colored differently."
	icon_state = "beret_hazard_engineering"

/obj/item/clothing/head/beret/atmos
	name = "atmospherics beret"
	desc = "A beret for those who have shown immaculate proficienty in piping. Or plumbing. Mostly piping."
	icon_state = "beret_atmospherics"
	armor = list("rad" = 5, "fire" = 10)

/obj/item/clothing/head/beret/ce
	name = "chief engineer beret"
	desc = "A white beret with the engineering insignia emblazoned on it. Its owner knows what they're doing. Probably."
	icon_state = "beret_ce"
	armor = list("rad" = 10, "fire" = 30)

//Science
/obj/item/clothing/head/beret/sci
	name = "science beret"
	desc = "A purple beret with a silver science department insignia emblazoned on it. It has that authentic burning plasma smell."
	icon_state = "beret_sci"
	armor = list("rad" = 5, "bio" = 5, "fire" = 5)

/obj/item/clothing/head/beret/rd
	name = "research director beret"
	desc = "A purple beret with a golden science insignia emblazoned on it. It has that authentic burning plasma smell, with a hint of tritium."
	icon_state = "beret_rd"
	armor = list("rad" = 10, "bio" = 10, "fire" = 10)

//Medical
/obj/item/clothing/head/beret/med
	name = "medical beret"
	desc = "A white beret with a blue cross finely threaded into it. It has that sterile smell about it."
	icon_state = "beret_med"
	armor = list("bio" = 20)

/obj/item/clothing/head/beret/chem
	name = "chemistry beret"
	desc = "A white beret with an orange insignia finely threaded into it. It smells of acid and ash."
	icon_state = "beret_chem"
	armor = list("acid" = 20)

/obj/item/clothing/head/beret/viro
	name = "virology beret"
	desc = "A white beret with a green insignia in the shape of a bacteria finely threaded into it. Smells unnaturally sterile..."
	icon_state = "beret_viro"
	armor = list("bio" = 30)

/obj/item/clothing/head/beret/cmo
	name = "chief medical officer beret"
	desc = "A baby blue beret with the insignia of Medistan. It smells very sterile."
	icon_state = "beret_cmo"
	armor = list("bio" = 30, "acid" = 20)

/obj/item/clothing/head/beret/cmo/cybersun
	name = "medical director beret"
	desc = "A burgundy-red beret with a silver cross. It smells very sterile."
	icon_state = "meddirectorberet"

//Command
/obj/item/clothing/head/beret/captain
	name = "captain beret"
	desc = "A lovely blue Captain beret with a gold and white insignia. Truly fit for only the finest officers."
	icon_state = "beret_captain"

/obj/item/clothing/head/beret/hop
	name = "head of personnel beret"
	desc = "A lovely blue Head of Personnel's beret with a silver and white insignia. It smells faintly of paper and dogs."
	icon_state = "beret_hop"

/obj/item/clothing/head/beret/command
	name = "command beret"
	desc = "A modest blue command beret with a silver rank insignia. Smells of power and the sweat of assistants."
	icon_state = "beret_com"

// SolGov

/obj/item/clothing/head/beret/solgov
	name = "\improper SolGov beret"
	desc = "A beret with SolGov's emblem emblazoned on it. Colored in SolGov blue."
	icon_state = "beret_solgov"

/obj/item/clothing/head/beret/solgov/plain
	name = "\improper SolGov beret"
	desc = "A plain blue beret. It looks like it's missing something."
	icon_state = "beret_solgovplain"

/obj/item/clothing/head/beret/solgov/terragov
	name = "\improper TerraGov beret"
	desc = "A beret with SolGov's emblem emblazoned on it. It's still colored in original TerraGov green."
	icon_state = "beret_terragov"

/obj/item/clothing/head/beret/solgov/terragov/plain
	name = "\improper TerraGov beret"
	desc = "A plain beret colored in original TerraGov green. It looks like it's missing something."
	icon_state = "beret_terragovplain"

// Inteq

/obj/item/clothing/head/beret/sec/inteq
	name = "inteq beret"
	desc = "A comfortable looking brown beret with a badge of the golden shield of the IRMG. Denotes the wearer as part of the IRMG."
	icon_state = "inteq_beret"

/obj/item/clothing/head/beret/sec/hos/inteq
	name = "inteq vanguard beret"
	desc = "A comfortable looking brown beret with a badge of the golden shield of the IRMG. Denotes the wearer as a vanguard of the IRMG. The padding inside feels thicker."
	icon_state = "inteq_beret"

/obj/item/clothing/head/beret/sec/hos/inteq/honorable
	name = "honorable vanguard beret"
	desc = "A snow white beret with an air of distinction around it, emblazoned with the golden shield of the IRMG as the badge."
	icon_state = "inteq_honorable_beret"

// CentCom

/obj/item/clothing/head/beret/centcom_formal
	name = "\improper CentCom Formal Beret"
	desc = "Sometimes, a compromise between fashion and defense needs to be made. Thanks to Nanotrasen's most recent nano-fabric durability enhancements, this time, it's not the case."
	icon = 'icons/obj/clothing/head/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/spacesuits.dmi'
	icon_state = "beret_badge"
	greyscale_colors = "#46b946#f2c42e"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 90)
	strip_delay = 10 SECONDS
