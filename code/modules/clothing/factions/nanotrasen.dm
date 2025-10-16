// Uniforms //

/obj/item/clothing/under/nanotrasen
	name = "deckhand's uniform"
	desc = "A plain grey work uniform with a Nanotrasen, Inc. logo embroidered on the front. Typical of entry-level employees."
	icon = 'icons/obj/clothing/faction/nanotrasen/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/uniforms.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "deckhand"
	item_state = "graycloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

// Engineering uniforms
/obj/item/clothing/under/nanotrasen/engineering
	name = "engineering jumpsuit"
	desc = "A dirty grey jumpsuit with reflective blue flashes on the limbs and a wrench icon on the back. A Nanotrasen, Inc. logo is stitched into the collar."
	icon_state = "engi"
	item_state = "greycloth"

/obj/item/clothing/under/nanotrasen/engineering/atmos
	name = "atmospherics jumpsuit"
	desc = "A thick grey jumpsuit with black stripes and an 'O2' icon on the back. A Nanotrasen, Inc. logo is stitched into the collar."
	icon_state = "atmos_tech"
	item_state = "greycloth"

/obj/item/clothing/under/nanotrasen/engineering/director
	name = "engineering director's overalls"
	desc = "Thick black overalls over a blue office shirt. Unlike most managerial staff, Nanotrasen engineering directors still need to get hands-on with their work."
	icon_state = "engi_director"
	item_state = "blackcloth"


//Supply uniforms
/obj/item/clothing/under/nanotrasen/supply
	name = "cargo handler shorts"
	desc = "A cheap work shirt and black shorts, typical of cargo handlers and clerks at N+S Logistics."
	icon_state = "supply"
	item_state = "browncloth"

/obj/item/clothing/under/nanotrasen/supply/qm
	name = "supply director slacks"
	desc = "Crisp slacks and a pressed brown shirt that any supply director could be proud of. N+S Logistics' compass rose logo is embossed on every button."
	icon_state = "supply_director"
	item_state = "browncloth"

/obj/item/clothing/under/nanotrasen/supply/miner
	name = "mining overalls"
	desc = "Cheap brown overalls over a grey jumpsuit, already slightly frayed and saturated with rock dust. N+S Logistics logos are prominently sewn on in several places."
	icon_state = "miner"
	item_state = "browncloth"

//Science uniforms
/obj/item/clothing/under/nanotrasen/science
	name = "science slacks"
	desc = "A thick buttoned shirt and slacks for some protection against low-level lab hazards. The basic uniform of Nanotrasen, Inc.'s research division."
	icon_state = "sci"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/science/robotics
	name = "robotics jumpsuit"
	desc = "A cheap black jumpsuit with blue arm flashes. Expendable armor against oil and sparks, issued en masse to Nanotrasen robotics technicians."
	icon_state = "robotics"
	item_state = "blackcloth"

/obj/item/clothing/under/nanotrasen/science/director
	name = "science director's slacks"
	desc = "A well-made black shirt with blue slacks, practically begging to be paired with a garish tie of some description. Nanotrasen logos are neatly stitched into the collar and cuffs."
	icon_state = "sci_director"
	item_state = "blackcloth"

//Medical uniforms
/obj/item/clothing/under/nanotrasen/medical
	name = "medical slacks"
	desc = "A crisp white shirt with blue stripes on the arms, identifying the owner as trained Nanotrasen medical staff. The faint smell of antiseptic won't wash out."
	icon_state = "doctor"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/medical/paramedic
	name = "paramedic uniform"
	desc = "Tough synthetic pants and a white uniform shirt, designed to handle all manner of scrapes and splashes in the line of duty. The tag identifies this as property of Nanotrasen, Inc."
	icon_state = "paramedic"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/medical/director
	name = "medical director's slacks"
	desc = "A neat blue shirt with white arm bands and comfortable black slacks. Nanotrasen logos are finely stitched into the collar and cuffs. It smells like burnt coffee and antiseptic."
	icon_state = "medical_director"
	item_state = "bluecloth"

//Security/civilian uniforms

/obj/item/clothing/under/nanotrasen/janitor
	name = "custodial jumpsuit"
	desc = "A grey jumpsuit with purple sleeves and faint stains on the elbows and knees. It looks stiff and cheap, but is surprisingly comfortable."
	icon_state = "janitor"
	item_state = "graycloth"

/obj/item/clothing/under/nanotrasen/affairs
	name = "neatly pleated slacks"
	desc = "Flawlessly pleated slacks and a linen shirt with the Nanotrasen logo stitched repeatedly into the cuffs and collar. It exudes an aura of quiet authority."
	icon_state = "affairs"
	item_state = "whitecloth"

/obj/item/clothing/under/nanotrasen/security
	name = "security slacks"
	desc = "A starched grey uniform with red arm flashes, of a type seen throughout the core worlds. The Vigilitas Interstellar logo is proudly emblazoned on the front."
	icon_state = "security"
	item_state = "graycloth"

/obj/item/clothing/under/nanotrasen/security/director
	name = "security director's slacks"
	desc = "A robust crimson uniform, heavily starched, with a Vigilitas logo neatly stitched onto either end of the collar. The last line of defense for Vigilitas's managerial staff."
	icon_state = "security_director"
	item_state = "redcloth"

//Command uniforms
/obj/item/clothing/under/nanotrasen/captain
	name = "blue captain's slacks"
	desc = "A quality uniform in Nanotrasen Blue, with gold trim. Gold Nanotrasen logo pins adorn the collar and cuffs. The fine fabrics and comfortable fit set this apart from the more utilitarian uniforms worn by lower-level employees."
	icon_state = "nt_captain"
	item_state = "bluecloth"

/obj/item/clothing/under/nanotrasen/captain/skirt
	name = "blue captain's skirt"
	desc = "A quality uniform in Nanotrasen Blue, with gold trim. Gold Nanotrasen logo pins adorn the collar and cuffs. The fine fabrics and comfortable fit set this apart from the more utilitarian uniforms worn by lower-level employees."
	icon_state = "nt_captain_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
/obj/item/clothing/under/nanotrasen/captain/parade
	name = ""
	desc = ""
	icon_state = "captain_parade"
*/

/obj/item/clothing/under/nanotrasen/officer
	name = "officer's slacks"
	desc = "An unadorned uniform in Nanotrasen Blue. While it isn't as nice as a captain's uniform, the color and quality still mark its owner as part of Nanotrasen's managerial class."
	icon_state = "officer"
	item_state = "bluecloth"

/obj/item/clothing/under/nanotrasen/officer/skirt
	name = "officer's skirt"
	desc = "An unadorned uniform in Nanotrasen Blue. While it isn't as nice as a captain's uniform, the color and quality still mark its owner as part of Nanotrasen's managerial class."
	icon_state = "officer_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

// Suits //

/obj/item/clothing/suit/nanotrasen //Base type, do not use
	name = "Suit"
	desc = "You shouldn't be here."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5

/obj/item/clothing/suit/nanotrasen/medical_smock
	name = "surgical smock"
	desc = "A thick fluid-repelling smock rendered in what is unmistakeably Nanotrasen Blue. The tag on the inside declares it property of Nanotrasen, Inc."
	icon_state = "med_smock"
	item_state = "bluecloth"
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

/obj/item/clothing/suit/nanotrasen/suitjacket
	name = "fancy black suit jacket"
	desc = "A fine black linen suit jacket with blue markings and a Nanotrasen lapel pin. It has a strangely menacing aura."
	icon_state = "suit_jacket"
	item_state = "blackcloth"
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/nanotrasen/vest
	name = "black hazard vest"
	desc = "A thin black vest with reflective markings, worn to guarantee visibility when operating around industrial equipment or in dark or dusty conditions. Property of Nanotrasen, Inc."
	icon_state = "engi_vest"
	item_state = "blackcloth"
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/nanotrasen/vest/blue
	name = "blue hazard vest"
	desc = "A thin vest with reflective stripes, worn to guarantee visibility in dangerous conditions. The vest itself is an offensively bright shade of Nanotrasen Blue. Property of Nanotrasen, Inc."
	icon_state = "atmos_vest"
	item_state = "bluecloth"
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/toggle/nanotrasen
	name = "officer's coat"
	desc = "A smart blue uniform jacket with red silk accents and a large buckle with an engraved Nanotrasen logo. Standard wear for command officers aboard Nanotrasen, Inc. ships."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "officer_formal"
	item_state = "bluecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen
	name = "corporate labcoat"
	desc = "A standardized white labcoat used by Nanotrasen, Inc.'s medical and research divisions. A simplified Nanotrasen logo is stitched on the front."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "labcoat"
	item_state = "whitecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/blue
	name = "medical director's labcoat"
	desc = "A well-made, fitted labcoat, crafted from high-quality materials and sporting blue markings around the arms and hem. A Nanotrasen logo is neatly embroidered on the front. Stylish, practical, and exceptionally professional."
	icon_state = "med_labcoat"
	item_state = "whitecloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/black
	name = "science director's labcoat"
	desc = "An overdesigned and rather intimidating black labcoat with a very high collar, as impervious to lab hazards as one can get without a full-body suit. Nanotrasen, Inc.'s logo is proudly emblazoned on the chest."
	icon_state = "black_labcoat"
	item_state = "blackcloth"

/obj/item/clothing/suit/toggle/labcoat/nanotrasen/paramedic
	name = "bright blue paramedic jacket"
	desc = "A thick, protective blue jacket with reflective visibility stripes and a Nanotrasen logo stitched into the chest. Safe against all manner of scrapes and splashes."
	icon_state = "med_jacket"
	item_state = "bluecloth"

/obj/item/clothing/suit/armor/nanotrasen
	name = "armor vest"
	desc = "A sturdy vest designed to protect Vigilitas Interstellar officers from a variety of basic threats. Sports a stylish red stripe down the front."
	icon = 'icons/obj/clothing/faction/nanotrasen/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "armor"
	item_state = "blackcloth"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/nanotrasen/slim
	name = "slim armor vest"
	icon_state = "armor_slim"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/armor/nanotrasen/sec_director
	name = "security director's overcoat"
	desc = "A tailored black overcoat, made from cutting-edge ballistic fabrics and composites. Vigilitas's 'VI' logo is embossed on every button. Intimidating and profoundly stylish."
	icon_state = "command_coat"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90, "wound" = 10)
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/armor/nanotrasen/captain
	name = "captain's jacket"
	desc = "A sturdy jacket in Nanotrasen Blue, accentuated with gold thread and lined with a layer of ballistic fabric. Its large, shiny belt buckle is embossed with Nanotrasen's corporate logo."
	icon_state = "armor_captain"
	item_state = "bluecloth"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90, "wound" = 10)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/nanotrasen/captain/parade
	name = "ostentatious captain's coat"
	desc = "An exquisitely-decorated fine blue jacket, suitable for especially formal situations, or for a commanding officer who wants to flaunt their status even more than usual. Richly decorated with gold thread and embroidered Nanotrasen logos."
	icon_state = "captain_formal"
	item_state = "bluecloth"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 30, "bullet" = 0, "laser" = 30, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90, "wound" = 10)

// Hats //

/obj/item/clothing/head/nanotrasen
	name = "blue flatcap"
	desc = "A simple blue flat cap with a Nanotrasen logo on the side. Not standard uniform, but occasionally worn by Nanotrasen office workers."
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "com_flatcap"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/beret
	name = "fancy blue beret"
	desc = "A well-made beret in Nanotrasen Blue with a corporate logo on the side, often seen topping the heads of Nanotrasen, Inc. managerial staff."
	icon_state = "beret_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/beret/security
	name = "fancy red beret"
	desc = "A cherry-red beret issued to Vigilitas security officers for formal occasions. Vigilitas Interstellar's 'VI' logo is stitched into the side."
	icon_state = "beret_red"
	item_state = "redcloth"

/obj/item/clothing/head/nanotrasen/beret/security/command
	name = "fancy black beret"
	desc = "A deep black beret with a Vigilitas Interstellar 'VI' badge on the front. An unmistakeable hallmark of Vigilitas managerial staff."
	icon_state = "beret_black"
	item_state = "blackcloth"

/obj/item/clothing/head/nanotrasen/surgical
	name = "white surgical cap"
	desc = "A white surgical cap with a Nanotrasen Blue stripe down the middle."
	icon_state = "surgical_white"
	item_state = "whitecloth"

/obj/item/clothing/head/nanotrasen/surgical/blue
	name = "blue surgical cap"
	desc = "A Nanotrasen Blue surgical cap with a white stripe down the middle, issued to NT medical directors as the last line of recognizability, should their uniforms, coats, and unflappable nature ever fail."
	icon_state = "surgical_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/cap // Base type, do not use
	name = "generic cap"
	desc = "You don't belong here."

/obj/item/clothing/head/nanotrasen/cap/security
	name = "red softcap"
	desc = "A cherry red cap with a white 'VI' logo embroidered on the front. Issued to Vigilitas security guards as casual wear and low-threat workwear. Surprisingly durable, and very popular among current and retired employees."
	icon_state = "cap_red"
	item_state = "redcloth"

/obj/item/clothing/head/helmet/m10/nanotrasen
	name = "\improper Vigilitas Helmet"
	desc = "A classic protective helmet utilized by Vigilitas, utilizing a M-10 pattern helmet with their color scheme!"
	icon_state = "nt_m10helm"
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'

/obj/item/clothing/head/helmet/bulletproof/x11/nanotrasen
	name = "\improper Bulletproof Vigilitas Helmet"
	desc = "A bulky bulletproof helmet in the X-11 pattern, utilized by Vigilitas and NT loss prevention!"
	icon_state = "nt_x11helm"
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'

/obj/item/clothing/head/helmet/riot/nanotrasen
	name = "\improper Vigilitas Riot Helmet"
	desc = "A resistant riot helmet produced for security detail in Vigilitas, often deployed to quell rioters in corporate grounds."
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'
	icon_state = "riot_nanotrasen"
	base_icon_state = "riot_nanotrasen"

/obj/item/clothing/head/nanotrasen/cap/supply
	name = "brown softcap"
	desc = "A brown cap with N+S Logistics' compass rose logo on the front. Issued to almost every N+S employee, although its wear is optional."
	icon_state = "cap_brown"
	item_state = "browncloth"

/obj/item/clothing/head/nanotrasen/cap/janitor
	name = "purple softcap"
	desc = "A rich purple soft cap with a Nanotrasen logo on the front. For some reason, this peculiar shade of purple is only used by custodial personnel instead of the Nanotrasen Blue used by every other division. It's already slightly stained."
	icon_state = "cap_purple"
	//item_state = "purplecloth" //todo: purple

/obj/item/clothing/head/nanotrasen/cap/medical
	name = "blue medical softcap"
	desc = "A soft cap in Nanotrasen Blue, with a large white cross on the front marking the wearer as a trained medical worker. Wearing this without medical training is a violation of Nanotrasen, Inc. employee guidelines."
	icon_state = "cap_blue"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/officer
	name = "officer's hat"
	desc = "A blue peaked hat with red silk decoration and an embroidered Nanotrasen logo, worn exclusively by management."
	icon_state = "officer_peaked"
	item_state = "bluecloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/nanotrasen/officer/fedora
	name = "officer's fedora"
	desc = "A fedora in a violent shade of Nanotrasen Blue, with a red silk band."
	icon_state = "officer_fedora"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/captain
	name = "captain's broad hat"
	desc = "A curious rounded hat, decorated with gold thread and a Nanotrasen logo badge. Particular to Nanotrasen, Inc. captains, though nobody is quite certain where this distinctive design originated."
	icon_state = "com_hat"
	item_state = "bluecloth"

/obj/item/clothing/head/nanotrasen/captain/peaked
	name = "captain's peaked cap"
	desc = "A decorated blue peaked cap, rife with laurels and gold thread, with a large badge on the front displaying the Nanotrasen, Inc. logo. This hat practically oozes authority."
	icon_state = "com_peaked"
	item_state = "bluecloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/hardhat/nanotrasen //TODO: inhands for hardhats
	name = "black heavy-duty hat"
	desc = "A tough plastic helmet with a suspension rig, designed to protect against blunt impacts. This one is a sober shade of black, with a Nanotrasen logo on the front."
	icon = 'icons/obj/clothing/faction/nanotrasen/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "hardhat_black"
	item_state = "blackcloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/hardhat/nanotrasen/blue
	name = "blue heavy-duty hat"
	desc = "A tough plastic helmet with suspension rig, designed to protect against blunt impacts. This one is brightly colored in Nanotrasen Blue, with the company logo on the front."
	icon_state = "hardhat_blue"
	item_state = "bluecloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/hardhat/nanotrasen/white
	name = "white heavy-duty hat"
	desc = "An extremely tough plastic helmet with suspension rig, designed to protect against blunt impacts. This one is colored bright white, typical of managerial staff, and has a Nanotrasen logo on the front."
	icon_state = "hardhat_white"
	item_state = "graycloth"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	supports_variations = VOX_VARIATION


// Neck //

/obj/item/clothing/neck/cloak/nanotrasen
	name = "command sash"
	desc = "A fine red silk sash that would pair nicely with a formal uniform. A small tag inside declares this property of Nanotrasen, Inc."
	icon = 'icons/obj/clothing/faction/nanotrasen/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/neck.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "sash"
	item_state = "redcloth"

// Mask //

/obj/item/clothing/mask/gas/vigilitas
	name = "Vigilitas gas mask"
	desc = "A protective gas mask designed for first response, specialist operations, and counter terrorism by Vigilitas Interstellar officers. It features a wide scratch resistant visor, ports for connecting an oxygen supply, and secure, comfortable straps."
	icon = 'icons/obj/clothing/faction/nanotrasen/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/nanotrasen/mask.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/nanotrasen/mask_kepori.dmi'
	lefthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/nanotrasen/nt_righthand.dmi'
	icon_state = "vigi_gas_mask"
	item_state = "vigi_gas_mask"
	vox_override_icon = 'icons/mob/clothing/faction/nanotrasen/vox.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	supports_variations = KEPORI_VARIATION | VOX_VARIATION
