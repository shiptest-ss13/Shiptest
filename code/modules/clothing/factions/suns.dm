

//////////////
//Jumpsuits//
/////////////


/obj/item/clothing/under/syndicate/suns
	name = "\improper SUNS formal suit"
	desc = "A fancy-looking tailored suit with purple slacks. Worn typically by students in the first half of their academic journey."
	icon_state = "suns_uniform1"
	item_state = "suns_uniwhite"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	can_adjust = TRUE
	icon = 'icons/obj/clothing/faction/suns/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/uniforms.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/under/syndicate/suns/alt
	name = "\improper SUNS formal suit"
	desc = "A fancy-looking tailored shirt with a purple skirt. Worn typically by students in the first half of their academic journey."
	icon_state = "suns_uniskirt1"
	item_state = "suns_uniwhite"

/obj/item/clothing/under/syndicate/suns/uniform2
	desc = "A uniform typically worn by students in the final years of their academic journey."
	icon_state = "suns_uniform2"
	item_state = "suns_uniwhite"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/suns/uniform2/alt
	desc = "A long skirt and blouse typically worn by students in the final years of their academic journey."
	icon_state = "suns_uniskirt2"
	item_state = "suns_uniwhite"

/obj/item/clothing/under/syndicate/suns/uniform3
	desc = "A suit typically worn by SUNS graduates and SUNS academic staff. You've come a long way, friend."
	icon_state = "suns_uniform3"
	item_state = "suns_unipurple"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/suns/uniform3/alt
	desc = "A skirt and blouse typically worn by SUNS graduates and SUNS academic staff. You've come a long way, friend."
	icon_state = "suns_uniskirt3"
	item_state = "suns_unipurple"

/obj/item/clothing/under/syndicate/suns/pkuniform
	name = "\improper SUNS peacekeeper uniform"
	desc = "A uniform designed for ease of movement for both the classroom and the frontier."
	icon_state = "suns_pkuniform"
	item_state = "suns_uniblack"

/obj/item/clothing/under/syndicate/suns/workerjumpsuit
	name = "\improper SUNS work jumpsuit"
	desc = "A casual uniform worn by students and staff to protect from blue collar work."
	icon_state = "suns_workerjumpsuit"
	item_state = "suns_unipurple"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/suns/captain
	name = "\improper SUNS captain suit"
	desc = "An elaborate uniform to set high ranking staff from academia apart from the rest."
	icon_state = "suns_captain"
	item_state = "suns_uniblack"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/suns/xo
	name = "\improper SUNS academic suit"
	desc = "A style of suit typically worn by academic staff."
	icon_state = "suns_xo"
	item_state = "suns_uniblack"
	can_adjust = TRUE

/obj/item/clothing/under/syndicate/suns/sciencejumpsuit
	name = "\improper SUNS lab jumpsuit"
	desc = "A comfortable suit meant to protect the individual from exposure to harmful objects."
	icon_state = "suns_sciencejumpsuit"
	item_state = "suns_uniwhite"
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/suns/doctorscrubs
	name = "\improper SUNS medical scrubs"
	desc = "Work safe medical scrubs for both the professionals and the trainees."
	icon_state = "suns_doctorscrubs"
	item_state = "suns_unipurple"
	can_adjust = FALSE


////////////////////
//Unarmored suits//
///////////////////


/obj/item/clothing/suit/toggle/suns
	name = "\improper SUNS jacket"
	desc = "A plain purple SUNS jacket, used fairly often on the frontier."
	icon_state = "suns_jacket"
	item_state = "suns_overpurple"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/suit/toggle/suns/alt
	name = "black school jacket"
	desc = "A plain black jacket with gold detailing. Found in universities all over the galaxy."
	icon_state = "suns_schooljacket"
	item_state = "suns_overblack"

/obj/item/clothing/suit/toggle/suns/workervest
	name = "SUNS work vest"
	desc = "A protective vest worn by some of the more practically minded students and staff during field work."
	icon_state = "suns_workervest"
	item_state = "suns_overblack"

/obj/item/clothing/suit/toggle/labcoat/suns/cmo
	name = "medical instructor coat"
	desc = "A labcoat often worn by the more eccentric medical instructors."
	icon_state = "suns_cmocoat"
	item_state = "suns_overblack"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/suit/toggle/labcoat/suns/doctorlabcoat
	name = "SUNS work vest"
	desc = "A stylized white labcoat frequently worn by SUNS medical staff."
	icon_state = "suns_doctorlabcoat"
	item_state = "suns_overwhite"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/suit/hooded/suns
	name = "\improper SUNS labcoat"
	desc = "An academic labcoat designed to protect the wearer from chemical and non chemical spills."
	icon_state = "suns_labcoat"
	item_state = "suns_overwhite"
	hoodtype = /obj/item/clothing/head/hooded/hood/suns
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/hooded/hood/suns
	name = "\improper SUNS labcoat hood"
	desc = "A hood to protect you from chemical spills."
	icon_state = "suns_labcoathood"
	item_state = "suns_labcoathood"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'


//////////////////
//Armored suits//
/////////////////


/obj/item/clothing/suit/armor/vest/suns
	name = "peacekeeper plating"
	desc = "A standard issue set of plate assigned to peacekeepers, both durable and stylish."
	icon_state = "suns_pkarmor"
	item_state = "suns_pkarmor"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/armor/vest/suns/hos
	name = "gilded peacekeeper plating"
	desc = "A set of plate assigned to peacekeepers, both durable and stylish. This one has a gold lining to indicate rank."
	icon_state = "suns_lpkarmor"
	item_state = "suns_pkarmor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/armor/vest/suns/ehos //remind me to make this something to buy
	name = "peacekeeper greatcoat"
	desc = "A funky armored coat worn by eccentric peacekeepers. Closing the coat is socially improper."
	icon_state = "suns_greatcoat"
	item_state = "suns_greatcoat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/toggle/suns/pkcoat
	name = "peacekeeper coat"
	desc = "An armored coat used during special occasions. This one is used in academic security."
	icon_state = "suns_pkjacket"
	item_state = "suns_overblack"
	armor = list("melee" = 15, "bullet" = 30, "laser" = 10, "energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 25)
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/armor/vest/suns/captain
	name = "decorated academic coat"
	desc = "An armored coat intended for SUNS captains on the frontier. Go forth, and spread the message of the academy."
	icon_state = "suns_captaincoat"
	item_state = "suns_overblack"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/armor/vest/suns/xo
	name = "academic staff coat"
	desc = "A white coat used by SUNS academic staff. It designates the second in command on the ship."
	icon_state = "suns_xojacket"
	item_state = "suns_overwhite"

///////////////
//Spacesuits//
//////////////


/obj/item/clothing/head/helmet/space/syndicate/suns
	name = "SUNS space helmet"
	icon_state = "suns_vachelm"
	item_state = "suns_vachelm"
	desc = "An academic standard spacesuit helmet. Normally reserved for low budget tasks in space."
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/suit/space/syndicate/suns
	name = "SUNS spacesuit"
	icon_state = "suns_vacsuit"
	item_state = "suns_vacsuit"
	desc = "An academic standard spacesuit. Normally reserved for low budget tasks in space."
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/security/suns
	name = "\improper SUNS peacekeeper hardsuit helmet"
	icon_state = "hardsuit0-suns_pk"
	item_state = "hardsuit0-suns_pk"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	hardsuit_type = "suns_pk"

/obj/item/clothing/suit/space/hardsuit/security/suns
	name = "\improper SUNS peacekeeper hardsuit"
	icon_state = "suns_pkhardsuit"
	item_state = "suns_pkhardsuit"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	hardsuit_type = "suns_pk"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/suns
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/mining/suns
	name = "\improper SUNS industrial hardsuit helmet"
	icon_state = "hardsuit0-suns_mining"
	item_state = "hardsuit0-suns_mining"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	hardsuit_type = "suns_mining"

/obj/item/clothing/suit/space/hardsuit/mining/suns
	name = "\improper SUNS industrial hardsuit"
	icon_state = "suns_miningsuit"
	item_state = "suns_miningsuit"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	hardsuit_type = "suns_mining"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining/suns
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/helmet/space/hardsuit/solgov/suns
	name = "\improper SUNS captain's hardsuit helmet"
	icon_state = "hardsuit0-suns_solgov"
	item_state = "hardsuit0-suns_solgov"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	hardsuit_type = "suns_solgov"
	desc = "An armored spaceproof helmet, the white glass on the side signifies a captain level rank."

/obj/item/clothing/suit/space/hardsuit/solgov/suns
	name = "\improper SUNS captain's hardsuit"
	desc = "A well decorated spaceworthy suit. The design was co-created by SolGov and SUNS academics."
	icon_state = "suns_commandsuit"
	item_state = "suns_commandsuit"
	icon = 'icons/obj/clothing/faction/suns/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/suits.dmi'
	hardsuit_type = "suns_solgov"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/solgov/suns
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'


/////////
//Hats//
////////


/obj/item/clothing/head/suns
	name = "academic staff beret"
	desc = "A soft beret sporting a discontinued inkwell quill feather. If only it could hold ink once more."
	icon_state = "suns_xoberet"
	item_state = "suns_captainberet"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/safety_helmet/suns
	desc = "A piece of headgear used in dangerous working conditions to protect the head."
	icon_state = "suns_workerhelmet"
	item_state = "suns_workerhelmet"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/HoS/syndicate/suns //remind me to make this something to buy
	name = "peacekeeper cap"
	desc = "A black cap worn by the more eccentric peacekeepers."
	icon_state = "suns_pkcap"
	item_state = "suns_pkcap"
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/suns/surgery
	name = "\improper SUNS surgery cap"
	desc = "A surgery cap used by academic students and profesionals alike."
	icon_state = "suns_doctorcap"
	item_state = "suns_doctorcap"

/obj/item/clothing/head/welding/suns
	name = "peacekeeper visor"
	desc = "A head-mounted helmet designed to protect those on the field from bright lights, while also allowing a life support connection. The warnings on this helmet suggest it is not spaceworthy."
	icon_state = "sunsvisor"
	item_state = "suns_pkhelmet"
	tint = 0
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) // identical stats to vest
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS //Why? Because I'm not giving PK's sec masks nor hud sunglasses.
	icon = 'icons/obj/clothing/faction/suns/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/head.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/head/welding/suns/hos
	name = "gilded peacekeeper visor"
	desc = "A head-mounted helmet designed to protect those on the field, this one has a gold lining to indicate rank. The warnings on this helmet suggest it is not spaceworthy."
	icon_state = "sunslpkvisor"
	item_state = "suns_pkhelmet"

/obj/item/clothing/head/suns/captain
	name = "\improper SUNS bicorne hat"
	desc = "A unique bicorne hat given to SUNS Captains to display academic seniority."
	icon_state = "suns_captainbicorne"
	item_state = "suns_captainbicorne"
	worn_y_offset = 2
	dog_fashion = null

/obj/item/clothing/head/suns/cmo //I was told I get one plague doctor outfit and I'm using it
	name = "medical instructor hat"
	desc = "A hat worn by the more eccentric medical staff."
	icon_state = "suns_doctorhat"
	item_state = "suns_doctorhat"
	permeability_coefficient = 0.01


////////////
//Glasses//
///////////


/obj/item/clothing/glasses/science/suns //This needs a sprite/lense in the eye of the mask to show its science goggles
	name = "eye mask science goggles"
	desc = "A fancy looking mask to help against chemical spills. This one is fitted with an analyzer for scanning items and reagents."
	icon_state = "suns_sciencemask"
	item_state = "suns_sciencemask"
	glass_colour_type = /datum/client_colour/glass_colour/purple
	icon = 'icons/obj/clothing/faction/suns/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/eyes.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/glasses/hud/health/suns //I need to figure out a way to make the masks toggleable for #style points.
	name = "eye mask health scanner HUD"
	desc = "A peculiar looking mask commonly seen at academic functions. This one has a health HUD lense in it."
	icon_state = "suns_doctormask"
	item_state = "suns_doctormask"
	glass_colour_type = /datum/client_colour/glass_colour/lightblue
	icon = 'icons/obj/clothing/faction/suns/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/eyes.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/glasses/hud/security/suns
	name = "eye mask security HUD"
	desc = "A peculiar looking mask commonly seen at academic functions. This one gives a heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records."
	icon_state = "suns_pkmask"
	item_state = "suns_pkmask"
	glass_colour_type = /datum/client_colour/glass_colour/red
	icon = 'icons/obj/clothing/faction/suns/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/eyes.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'


//////////
//Masks//
/////////


/obj/item/clothing/mask/gas/suns //someone mentioned they were interested in using this sprite as the regular gasmask re-sprite, I forgor who so we'll deal with that when I PR this
	name = "black gas mask"
	desc = "A black face covering that allows the user to connect to a personal gas supply. Suprisingly not great at preventing gas inhalation."
	icon_state = "suns_gasmask"
	item_state = "suns_gasmask2"
	icon = 'icons/obj/clothing/faction/suns/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/mask.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/mask/surgical/suns
	name = "purple sterile mask"
	desc = "A sterile mask designed to help prevent the spread of diseases. Now in purple! Pretty!"
	icon_state = "suns_sterile"
	item_state = "suns_doctorcap"
	icon = 'icons/obj/clothing/faction/suns/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/mask.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/mask/breath/suns
	name = "\improper SUNS half face mask"
	desc = "A close-fitting mask that covers JUST enough to connect an air supply."
	icon_state = "suns_captainmask"
	item_state = "suns_captainmask"
	icon = 'icons/obj/clothing/faction/suns/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/mask.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'


///////////
//Gloves//
//////////

// The following employ a slapjob fix to remove the /color subtype, as per maintainer request.
// These should be addressed in any future glove refactor, as that is out of the scope of this PR.
/obj/item/clothing/gloves/suns
	name = "stitched fingerless gloves"
	desc = "These gloves offer style, purely and plainly."
	icon_state = "suns_glovesfingerless"
	item_state = "suns_blackgloves"
	icon = 'icons/obj/clothing/faction/suns/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/hands.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/gloves/suns/captain
	name = "\improper SUNS captain's gloves"
	desc = "Fancy black gloves for trusted SUNS members. Sports a complex lining that prevents the wearer from being shocked."
	icon_state = "suns_captaingloves"
	item_state = "suns_blackgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 50)

/obj/item/clothing/gloves/suns/xo
	name = "academic staff gloves"
	desc = "White gloves that offer a good grip with writing utensils."
	icon_state = "suns_xogloves"
	item_state = "suns_whitegloves"

/obj/item/clothing/gloves/suns/yellow
	name = "insulated gloves"
	desc = "Padded academic gloves that hopefully keep students out of the nurses office."
	icon_state = "suns_insulated"
	item_state = "suns_blackgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05

/obj/item/clothing/gloves/color/latex/nitrile/suns
	name = "white nitrile gloves"
	desc = "Thick sterile white gloves that reach up to the elbows. The nanochips that transfer basic paramedic knowledge are disabled during finals week."
	icon_state = "suns_latexgloves"
	item_state = "suns_whitegloves"
	icon = 'icons/obj/clothing/faction/suns/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/hands.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/gloves/tackler/dolphin/suns
	name = "peacekeeper tackle gloves"
	desc = "Sleek tackle gloves that allows the user to sail through the air. The main cause of accidents during finals week."
	icon_state = "suns_longglovesblack"
	item_state = "suns_blackgloves"
	icon = 'icons/obj/clothing/faction/suns/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/hands.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'


//////////
//Shoes//
/////////


/obj/item/clothing/shoes/sneakers/suns
	name = "white clogs"
	desc = "Comfortable clogs for general use."
	icon_state = "suns_doctorclogs"
	item_state = "suns_doctorclogs" //I know what the state says, I'm not fixing it.
	icon = 'icons/obj/clothing/faction/suns/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/feet.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/shoes/combat/suns
	name = "fancy combat boots"
	desc = "Decent traction combat boots worn by high ranking academic staff."
	icon_state = "suns_captainboots"
	item_state = "suns_blackboots"
	icon = 'icons/obj/clothing/faction/suns/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/feet.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/shoes/jackboots/suns
	name = "work safe jackboots"
	desc = "Academic issued steel toed boots. For those with physically demanding majors."
	icon_state = "suns_jackboots"
	item_state = "suns_blackboots"
	icon = 'icons/obj/clothing/faction/suns/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/feet.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/shoes/jackboots/suns/long
	name = "peacekeeper longboots"
	desc = "Longboots worn by academic security staff and trainees."
	icon_state = "suns_longboots"
	item_state = "suns_blackboots"

/obj/item/clothing/shoes/laceup/suns
	name = "academy laceup shoes"
	desc = "Standard issue laceups from the syndicates resident academy."
	icon_state = "suns_laceups"
	item_state = "suns_blackboots"
	icon = 'icons/obj/clothing/faction/suns/feet.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/feet.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'


//////////
//Cloaks//
//////////


/obj/item/clothing/neck/cloak/suns
	name = "\improper SUNS short cloak"
	desc = "Worn by both the young and old alike. You can almost feel the academic pride."
	icon_state = "suns_shouldercape"
	item_state = "suns_overpurple"
	icon = 'icons/obj/clothing/faction/suns/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/neck.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

/obj/item/clothing/neck/cloak/suns/xo
	name = "\improper SUNS academic staff cloak"
	desc = "Worn by SUNS staff, you can almost smell all of the failing grades this cloak has given."
	icon_state = "suns_xocape"
	item_state = "suns_xocape"

/obj/item/clothing/neck/cloak/suns/cap
	name = "\improper SUNS captain's cloak"
	desc = "Worn by SUNS captains. This cloak has a very imposing aura to it."
	icon_state = "suns_captaincloak"
	item_state = "suns_captaincloak"


///////////////
//Accessories//
///////////////

//These are stored in clothing/accessories.dmi instead of a factional variant due to accessory code being dogwater
//Please transfer them over to a factional file if accessory code is ever fixed

/obj/item/clothing/accessory/waistcoat/suns
	name = "\improper SUNS waistcoat"
	desc = "An academic issued run of the mill waistcoat."
	icon_state = "suns_waistcoat"
	icon = 'icons/obj/clothing/accessories.dmi'
	mob_overlay_icon = 'icons/mob/clothing/accessories.dmi'
	minimize_when_attached = TRUE

/obj/item/clothing/accessory/waistcoat/suns/ribbon
	name = "\improper SUNS ribbon"
	desc = "An academic issued bow, for when you want to feel pretty."
	icon_state = "suns_ribbon"

/obj/item/clothing/accessory/waistcoat/suns/gembow
	name = "\improper SUNS gem bow"
	desc = "An academic issued bow, for when you want to feel REALLY pretty."
	icon_state = "suns_gembow"

/obj/item/clothing/accessory/waistcoat/suns/poof
	name = "\improper SUNS chest poof"
	desc = "An academic issued bow, for when you want to feel sophisticated."
	icon_state = "suns_poof"
