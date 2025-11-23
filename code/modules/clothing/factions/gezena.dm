//Jumpsuits
/obj/item/clothing/under/gezena
	name = "Gezenan navywear"
	desc = "A practical blue jumpsuit with deep pockets and two identifier plates on the chest."
	icon = 'icons/obj/clothing/faction/gezena/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/uniforms.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navywear"
	item_state = "navyjump"
	sensor_mode = SENSOR_COORDS
	roll_sleeves = TRUE
	roll_down = TRUE
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)

/obj/item/clothing/under/gezena/captain
	name = "\improper Gezenan captain's navywear"
	desc = "A refined variation of the basic navywear with a large frontal flap and sleek silver trim."
	icon_state = "captainwear"
	item_state = "navyjump"

/obj/item/clothing/under/gezena/officer
	name = "\improper Gezenan officer's navywear"
	desc = "A refined variation of the basic navywear with a large frontal flap and eyecatching green trim."
	icon_state = "officerwear"
	item_state = "navyjump"

/obj/item/clothing/under/gezena/marine
	name = "\improper Gezenan marine fatigue"
	desc = "A rugged green uniform with canvas re-enforced elbows and knees along with numerous pockets."
	icon_state = "marinewear"
	item_state = "marinejump"

//Unarmored suit

/obj/item/clothing/suit/toggle/gezena
	name = "navy silkenweave jacket"
	desc = "Comfortable, light, and surprisingly warm with it's removable liner, the silkenweave jacket has found few complaints. This one is in Navy blue."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyjacket"
	item_state = "bluecloth"
	blood_overlay_type = "coat"
	togglename = "zipper"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/suit/toggle/gezena/marine
	name = "marine silkenweave jacket"
	desc = "Comfortable, light, and surprisingly warm with it's removable liner, the silkenweave jacket has found few complaints. This one is in Marine Corps green."
	icon_state = "marinejacket"
	item_state = "greencloth"

//Armored suit

/obj/item/clothing/suit/armor/gezena
	name = "navywear coat"
	desc = "A heavy belted coat with a pair of sleek epaulettes in a recognizable Gezenan green."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navycoat"
	item_state = "bluecloth"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	armor = list("melee" = 35, "bullet" = 35, "laser" = 20, "energy" = 40, "bomb" = 20, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	allowed = null

/obj/item/clothing/suit/armor/gezena/medic
	name = "medical navywear coat"
	desc = "A heavy belted coat with a pair of sleek epaulettes in a sterile medical white."
	icon_state = "medcoat"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/gezena/engi
	name = "engineering navywear coat"
	desc = "A heavy belted coat with a pair of sleek epaulettes in a rugged engineering orange."
	icon_state = "engicoat"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/gezena/captain
	name = "captain's navywear coat"
	desc = "A heavy belted coat with a pair of sleek epaulettes in a regal command silver."
	icon_state = "captaincoat"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/gezena/marine
	name = "\improper composite marine vest"
	desc = "Heavy composite plating in a striking bright green, with sturdy shoulder pads for extra protection."
	icon_state = "marinevest"
	item_state = "marinevest"
	armor = list("melee" = 35, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 20) //the laser gun country should probably have laser armor
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

//Spacesuits

/obj/item/clothing/suit/space/gezena
	name = "navy utility suit"
	desc = "With bright hardened plating covering the body and tail, the 'Rakalla' utility suit stands firmly between you and the void of space."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyspacesuit"
	item_state = "navyspace"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/suit/space/gezena/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

/obj/item/clothing/suit/space/gezena/marine
	name = "composite combat suit"
	desc = "With striking bright green composite plating, the 'Lataka' combat suit threatens any danger with the promise of protection."
	icon_state = "marinespacesuit"
	item_state = "marinespace"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/head/helmet/space/gezena
	name = "navy utility helmet"
	desc = "Features rubberized grommets for safely accomodating any length of horn, all the while boasting second to none panoramic visibilty though it's domed visor."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyspacehelmet"
	item_state = "navyspacehelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/head/helmet/space/gezena/marine
	name = "composite combat helmet"
	desc = "Features rubberized grommets for safely accomodating any length of horn and thicker plating on the forehead, sacrificing visibility for much needed protection."
	icon_state = "marinespacehelmet"
	item_state = "marinespacehelm"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

//Hats

/obj/item/clothing/head/gezena
	name = "\improper navy cap"
	desc = "The standard cap of the PGF military, in Navy colors."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyhat"
	item_state = "bluecloth"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/clothing/head/gezena/flap
	name = "navy flap cap"
	desc = "The standard cap of the PGF military, in Navy colors. Features a neck-covering flap for harsher environments."
	icon_state = "navyflap"
	item_state = "bluecloth"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/marine
	name = "marine cap"
	desc = "The standard cap of the PGF military, in Marine Corps colors."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "marinehat"
	item_state = "greencloth"

/obj/item/clothing/head/gezena/flap/marine
	name = "marine flap cap"
	desc = "The standard cap of the PGF military, in Marine colors. Features a neck-covering flap for harsher environments."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "marineflap"
	item_state = "greencloth"

/obj/item/clothing/head/gezena/engi
	name = "navy engineer cap"
	desc = "The standard cap of the PGF military. The coloring indicates the wearer as an engineering specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "engihat"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/flap/engi
	name = "\improper navy engineering flap cap"
	desc = "The standard cap of the PGF military. Features a neck-covering flap for harsher environments. The coloring indicates the wearer as an engineering specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "engiflap"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/medic
	name = "navy medical cap"
	desc = "The standard cap of the PGF military. The coloring indicates the wearer as a medical specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "medichat"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/flap/medic
	name = "medic flap cap"
	desc = "The standard cap of the PGF military. Features a neck-covering flap for harsher environments. The coloring indicates the wearer as a medical specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "medicflap"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/captain
	name = "navy command cap"
	desc = "The standard cap of the PGF military, in Navy colors. The decoration indicates the wearer as a ship's Captain."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "captainhat"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/flap/captain
	name = "command flap cap"
	desc = "The standard cap of the PGF military. Features a neck-covering flap for harsher environments. The decoration indicates the wearer as a ship's Captain."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "captainflap"
	item_state = "bluecloth"

/obj/item/clothing/head/helmet/gezena
	name = "composite combat helmet"
	desc = "An armored composite military helmet employed by the PGF. Fitted to connect seamlessly with the L-98 respirator"
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	flags_inv = HIDEHAIR
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	armor = list("melee" = 35, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 20) //the laser gun country should probably have laser armor
	icon_state = "marinehelmet"
	item_state = "marinehelm"
	can_flashlight = TRUE
	content_overlays = TRUE

//Gloves

/obj/item/clothing/gloves/gezena
	name = "navywear gloves"
	desc = "A pair of durable black gloves with extra grip and knuckle-pads."
	icon = 'icons/obj/clothing/faction/gezena/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/hands.dmi'
	icon_state = "navalgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'


/obj/item/clothing/gloves/gezena/marine
	name = "marine combat gloves"
	desc = "A pair of durable black gloves with extra grip and knuckle-pads. The fingers are left particularly nimble for the easier operation of weapons."
	icon_state = "marinegloves"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50)

/obj/item/clothing/gloves/gezena/engi
	name = "navywear engineering gloves"
	desc = "A pair of durable black gloves with extra grip and knuckle-pads. This pair comes with anti-conductive microfibers interwoven to supply the user with electrical insulation."
	icon_state = "engigloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/gezena/captain
	name = "navywear captain gloves"
	desc = "A pair of durable black gloves with extra grip and knuckle-pads. This pair bears the silver standard of a Gezenan captain."
	icon_state = "captaingloves"

//Boots

/obj/item/clothing/shoes/combat/gezena
	name = "navywear high boots"
	desc = "Steel-toe rubber laceless boots that will fit just about any kind of feet."
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/feet.dmi'
	icon_state = "pgfnboots"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'


/obj/item/clothing/shoes/combat/gezena/marine
	name = "marine high boots"
	desc = "Composite-toe rubber laceless boots that will fit just about any kind of feet. Sacrificing steel for a composite toe-cap combined with increased ankle flexibility, these boots are far more comfortable on extended excursions."
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/feet.dmi'
	icon_state = "pgfmcboots"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

//Belt

/obj/item/storage/belt/military/gezena
	name = "marine webbing"
	desc = "A lightweight harness covered in pouches and a slightly larger than average rear pack. Supplied to the combat ground forces of the PGF. This variant is designed for carrying ammunition."
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "pgfwebbing"
	item_state = "greencloth"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	unique_reskin = null

/obj/item/storage/belt/military/gezena/bg16/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/stock_parts/cell/gun/pgf(src)
	new /obj/item/grenade/frag(src)
	new /obj/item/grenade/smokebomb(src)

/obj/item/storage/belt/military/gezena/engineer/PopulateContents()
	. = ..()
	for(var/i in 1 to 3)
		new /obj/item/stock_parts/cell/gun/pgf(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/grenade/c4(src)
	new /obj/item/grenade/c4(src)

/obj/item/storage/belt/medical/gezena
	name = "medic webbing"
	desc = "A lightweight harness covered in pouches and a slightly larger than average rear pack. Supplied to the combat ground forces of the PGF. This variant is designed for carrying medical equipment."
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "pgfmedwebbing"
	item_state = "whitecloth"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

/obj/item/storage/belt/medical/gezena/paramedic/PopulateContents()
	new /obj/item/reagent_containers/medigel/hadrakine(src)
	new /obj/item/reagent_containers/medigel/hadrakine(src)
	new /obj/item/reagent_containers/medigel/quardexane(src)
	new /obj/item/reagent_containers/medigel/quardexane(src)
	new /obj/item/reagent_containers/medigel/synthflesh(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/stack/medical/splint(src)
	. = ..()

//Masks
/obj/item/clothing/mask/breath/pgfmask
	name = "gezenan composite respirator"
	desc = "An armored composite L-98 mask designed to protect both face and snout, and allowing easy attachment of external air sources. It's surprisingly comfortable."
	icon_state = "pgfmask"
	item_state = "pgfmask"
	icon = 'icons/obj/clothing/faction/gezena/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/mask.dmi'
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION | KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01

//Eyes
/obj/item/clothing/glasses/sunglasses/pgf
	name = "gezenan protective goggles"
	desc = "Bright cyan goggles with a polarized lens that obscures the wearer's eyes."
	icon = 'icons/obj/clothing/faction/gezena/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/eyes.dmi'
	icon_state = "pgfgoggles"
	item_state = "pgfgoggles"
	clothing_flags = SEALS_EYES | FLASH_PROTECTION_FLASH
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	glass_colour_type = /datum/client_colour/glass_colour/green

//Cloaks

/obj/item/clothing/neck/cloak/gezena
	name = "gezenan rank-cape"
	desc = "A flowing black drape, engrained deep into Gezenan military tradition. Issued to every member of the Pan-Gezenan Federation's armed forces."
	icon = 'icons/obj/clothing/faction/gezena/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/neck.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "cape"
	item_state = "blackcloth"
	obj_flags = INFINITE_RESKIN
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	unique_reskin = list(
		"shoulder cape" = "cape_folded",
		"full cape" = "cape",
	)

/obj/item/clothing/neck/cloak/gezena/engi
	name = "engineering rank-cape"
	desc = "A flowing black drape, engrained deep into Gezenan military tradition. Issued to every member of the Pan-Gezenan Federation's armed forces. This variant displays the wearer's engineering specialization."
	icon_state = "engicape"
	item_state = "blackcloth"
	unique_reskin = list(
		"shoulder cape" = "engicape_folded",
		"full cape" = "engicape",
	)

/obj/item/clothing/neck/cloak/gezena/med
	name = "medic rank-cape"
	desc = "A flowing black drape, engrained deep into Gezenan military tradition. Issued to every member of the Pan-Gezenan Federation's armed forces. This variant displays the wearer's medical specialization."
	icon_state = "medcape"
	item_state = "whitecloth"
	unique_reskin = list(
		"shoulder cape" = "medcape_folded",
		"full cape" = "medcape",
	)

/obj/item/clothing/neck/cloak/gezena/command
	name = "command rank-cape"
	desc = "A flowing black drape, engrained deep into Gezenan military tradition. Issued to every member of the Pan-Gezenan Federation's armed forces. This variant displays the wearer's rank as an officer."
	icon_state = "officercape"
	item_state = "blackcloth"
	unique_reskin = list(
		"shoulder cape" = "officercape_folded",
		"full cape" = "officercape",
	)

/obj/item/clothing/neck/cloak/gezena/captain
	name = "captain's rank-cape"
	desc = "A flowing black drape, engrained deep into Gezenan military tradition. Issued to every member of the Pan-Gezenan Federation's armed forces. This variant displays the wearer's rank as a high ranking officer."
	icon_state = "captaincape"
	item_state = "whitecloth"
	unique_reskin = list(
		"shoulder cape" = "captaincape_folded",
		"full cape" = "captaincape",
	)
