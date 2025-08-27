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
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE
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
	name = "PGFN silkenweave jacket"
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
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/gezena/marine
	name = "PGFMC silkenweave jacket"
	desc = "Comfortable, light, and surprisingly warm with it's removable liner, the silkenweave jacket has found few complaints. This one is in Marine Corps green."
	icon_state = "marinejacket"
	item_state = "greencloth"

//Armored suit

/obj/item/clothing/suit/armor/gezena
	name = "navywear coat"
	desc = "A heavy belted coat with a pair of sleek epaulettes in a recognizable PGF green."
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
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE
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
	name = "\improper PGFMC AR-98 Armor Vest"
	desc = "The vest component of the relatively new Arbitrator body armor system, complete with a set of shoulder pads for additional protection. Designed specifically for service with the PGF Marines. While the added bulk over previous systems is a common complaint, the Defense Administration is certain the marines can handle a few extra pounds."
	icon_state = "marinevest"
	item_state = "marinevest"
	armor = list("melee" = 35, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 20) //the laser gun country should probably have laser armor
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

//Spacesuits

/obj/item/clothing/suit/space/gezena
	name = "\improper PGFN Rakalla Utility Suit"
	desc = "The Rakalla Utility suit has seen extensive use within the Federation Navy, serving countless sailors throughout it's growing service history. Sturdy, flexible, reliable."
	icon = 'icons/obj/clothing/faction/gezena/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyspacesuit"
	item_state = "navyspace"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/suit/space/gezena/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

/obj/item/clothing/suit/space/gezena/marine
	name = "\improper PGFMC Lataka Combat Suit"
	desc = "Not quite as old as the Rakalla suit but venerable in its own right, the Lataka combat suit is the Marine Corps' go-to EVA combat suit when power armored units aren't availible. For what it lacks in comparative protection, it makes up for in price and ease of use."
	icon_state = "marinespacesuit"
	item_state = "marinespace"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/head/helmet/space/gezena
	name = "\improper PGFN Rakalla Utility Helmet"
	desc = "Features rubberized grommets for safely accomodating any length of horn, all the while boasting second to none panoramic visibilty though it's domed visor."
	icon = 'icons/obj/clothing/faction/gezena/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/gezena/gezena_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/gezena/gezena_righthand.dmi'
	icon_state = "navyspacehelmet"
	item_state = "navyspacehelm"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION

/obj/item/clothing/head/helmet/space/gezena/marine
	name = "\improper PGFMC Lataka Combat Helmet"
	desc = "Features rubberized grommets for safely accomodating any length of horn and thicker plating on the forehead, sacrificing visibility for much needed protection."
	icon_state = "marinespacehelmet"
	item_state = "marinespacehelm"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION

//Hats

/obj/item/clothing/head/gezena
	name = "\improper PGFN Cap"
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
	name = "\improper PGFN Betzu-il cap"
	desc = "The standard cap of the PGF military, in Navy colors. “Betzu-il”, translating to “sun-blocker”, refers to the flap at the back for protection against natural hazards such as sunburns, sandstorms, and biting insects."
	icon_state = "navyflap"
	item_state = "bluecloth"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/gezena/marine
	name = "\improper PGFMC Cap"
	desc = "The standard cap of the PGF military, in Marine Corps colors."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "marinehat"
	item_state = "greencloth"

/obj/item/clothing/head/gezena/flap/marine
	name = "\improper PGFMC Betzu-il cap"
	desc = "The standard cap of the PGF military, in Marine Corps colors. “Betzu-il”, translating to “sun-blocker”, refers to the flap at the back for protection against natural hazards such as sunburns, sandstorms, and biting insects."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "marineflap"
	item_state = "greencloth"

/obj/item/clothing/head/gezena/engi
	name = "\improper PGF engineer cap"
	desc = "The standard cap of the PGF military. The coloring indicates the wearer as an engineering specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "engihat"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/flap/engi
	name = "\improper PGF engineering Betzu-il cap"
	desc = "The standard cap of the PGF military. “Betzu-il”, translating to “sun-blocker”, refers to the flap at the back for protection against natural hazards such as sunburns, sandstorms, and biting insects. The coloring indicates the wearer as an engineering specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "engiflap"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/medic
	name = "\improper PGF medical cap"
	desc = "The standard cap of the PGF military. The coloring indicates the wearer as a medical specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "medichat"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/flap/medic
	name = "\improper PGF medical Betzu-il cap"
	desc = "The standard cap of the PGF military. “Betzu-il”, translating to “sun-blocker”, refers to the flap at the back for protection against natural hazards such as sunburns, sandstorms, and biting insects. The coloring indicates the wearer as a medical specialist."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "medicflap"
	item_state = "whitecloth"

/obj/item/clothing/head/gezena/captain
	name = "\improper PGFN Captain's cap"
	desc = "The standard cap of the PGF military, in Navy colors. The decoration indicates the wearer as a ship's Captain."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "captainhat"
	item_state = "bluecloth"

/obj/item/clothing/head/gezena/flap/captain
	name = "\improper PGF Captain's Betzu-il cap"
	desc = "The standard cap of the PGF military. “Betzu-il”, translating to “sun-blocker”, refers to the flap at the back for protection against natural hazards such as sunburns, sandstorms, and biting insects. The decoration indicates the wearer as a ship's Captain."
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'
	icon_state = "captainflap"
	item_state = "bluecloth"

/obj/item/clothing/head/helmet/gezena
	name = "\improper PGFMC AR-98 Helmet"
	desc = "The helmet component of the recently introduced Arbitrator body armor system. Generously fitted with connector clips for the L-98 respirator and vacant hardware for attachments."
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
	name = "\improper PGFN Gloves"
	desc = "A pair of government contract made Smithworx “sure-grip” gloves. Extraordinarily popular in the civilian market for their quality reputation, these military issues never seem to live up to the hype."
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
	name = "\improper PGFMC Combat Gloves"
	desc = "A pair of government contract made Smithworx “sure-grip” gloves. Extraordinarily popular in the civilian market for their quality reputation, these military issues never seem to live up to the hype. This pair comes with extra tactile grip on the fingertips for easy use of firearms."
	icon_state = "marinegloves"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50)

/obj/item/clothing/gloves/gezena/engi
	name = "\improper PGFN Engineering Gloves"
	desc = "A pair of government contract made Smithworx “sure-grip” gloves. Extraordinarily popular in the civilian market for their quality reputation, these military issues never seem to live up to the hype. This pair comes with anti-conductive microfibers interwoven to supply the useer with electrical insulation."
	icon_state = "engigloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/gezena/captain
	name = "\improper PGFN Captain's Gloves"
	desc = "A pair of government contract made Smithworx “sure-grip” gloves. Extraordinarily popular in the civilian market for their quality reputation, these military issues never seem to live up to the hype. This pair bears the silver standard of a Gezenan captain."
	icon_state = "captaingloves"

//Boots

/obj/item/clothing/shoes/combat/gezena
	name = "\improper PGFN High Boots"
	desc = "Rubberized high-cut boots form fitted in a variety of sizes for use by the sailors of the PGF Navy. They fit quite well despite their laceless design and are fitted with steel toe-caps for protection."
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/feet.dmi'
	icon_state = "pgfnboots"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'


/obj/item/clothing/shoes/combat/gezena/marine
	name = "\improper PGFMC Jungle Boots"
	desc = "A modification of the boots in use by the PGF Navy, the Marine Corps' boots are made lighter and less conspicuous through the use of a water proofed canvas in place of high cut rubber. Sacrificing steel for a composite toe-cap combined with increased ankle flexibility, these boots are far easier to move in."
	icon = 'icons/obj/clothing/faction/gezena/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/feet.dmi'
	icon_state = "pgfmcboots"
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/gezena/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/gezena/kepori.dmi'

//Belt

/obj/item/storage/belt/military/gezena
	name = "\improper PGF Webbing"
	desc = "A lightweight harness covered in pouches and a slightly larger than average rear pack. Supplied to the combat ground forces of the PGF this variant is designed for carrying ammunition."
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
	name = "\improper PGF Medical Webbing"
	desc = "A lightweight harness covered in pouches and a slightly larger than average rear pack. Supplied to the combat ground forces of the PGF this variant is designed for carrying medical equipment."
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
	new /obj/item/reagent_containers/medigel/styptic(src)
	new /obj/item/reagent_containers/medigel/styptic(src)
	new /obj/item/reagent_containers/medigel/silver_sulf(src)
	new /obj/item/reagent_containers/medigel/silver_sulf(src)
	new /obj/item/reagent_containers/medigel/synthflesh(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/stack/medical/splint(src)
	. = ..()

//Masks
/obj/item/clothing/mask/breath/pgfmask
	name = "L-98 Respirator"
	desc = "A comfortable half-mask respirator introduced to PGF military service in FSC 498 alongside the new Arbitrator body armor system, replacing and improving upon the much bulkier and shorter lived L-90 masks. Made to connect seamlessly with the PGFMC's AR-98 combat helmet, the L-98 can be connected to external filters and air supplies via a connector port under the chin."
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
	name = "L-98 Enviromental Protection Goggles"
	desc = "The optional eye protection component of the L-98 respirator, complete with a polarized lens and snap latches for connecting the two parts together securely. Commonly worn both with and without it's partner."
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
	name = "\improper PGF rank-cape"
	desc = "Tracing its origins far back into Gezenan military history, the rank cape is the method by which PGF military members display their rank to others. Wearing one while on duty is required by uniform code. This variant displays the wearer's rank as an elisted serviceman."
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
	name = "Engineering rank-cape"
	desc = "Tracing its origins far back into Gezenan military history, the rank cape is the method by which PGF military members display their rank to others. Wearing one while on duty is required by uniform code. This variant displays the wearer's engineering specialization."
	icon_state = "engicape"
	item_state = "blackcloth"
	unique_reskin = list(
		"shoulder cape" = "engicape_folded",
		"full cape" = "engicape",
	)

/obj/item/clothing/neck/cloak/gezena/med
	name = "Medical rank-cape"
	desc = "Tracing its origins far back into Gezenan military history, the rank cape is the method by which PGF military members display their rank to others. Wearing one while on duty is required by uniform code. This variant displays the wearer's medical specialization."
	icon_state = "medcape"
	item_state = "whitecloth"
	unique_reskin = list(
		"shoulder cape" = "medcape_folded",
		"full cape" = "medcape",
	)

/obj/item/clothing/neck/cloak/gezena/command
	name = "Officer's rank-cape"
	desc = "Tracing its origins far back into Gezenan military history, the rank cape is the method by which PGF military members display their rank to others. Wearing one while on duty is required by uniform code. This variant displays the wearer's rank as an officer."
	icon_state = "officercape"
	item_state = "blackcloth"
	unique_reskin = list(
		"shoulder cape" = "officercape_folded",
		"full cape" = "officercape",
	)

/obj/item/clothing/neck/cloak/gezena/captain
	name = "Captain's rank-cape"
	desc = "Tracing its origins far back into Gezenan military history, the rank cape is the method by which PGF military members display their rank to others. Wearing one while on duty is required by uniform code. This variant displays the wearer's rank as a high ranking officer."
	icon_state = "captaincape"
	item_state = "whitecloth"
	unique_reskin = list(
		"shoulder cape" = "captaincape_folded",
		"full cape" = "captaincape",
	)
