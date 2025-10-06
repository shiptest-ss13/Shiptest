//////////////
//Jumpsuits//
/////////////

/obj/item/clothing/under/syndicate/hardliners
	name = "hardliners uniform"
	desc = "A crimson combat uniform, reminiscent of the Gorlex Marauders at the height of the Inter-Corporate Wars. It's oddly comfortable, and warm."
	icon_state = "hardliners"
	item_state = "hardliners"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	icon = 'icons/obj/clothing/faction/hardliners/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/uniforms.dmi'

/obj/item/clothing/under/syndicate/hardliners/jumpsuit
	name = "hardliners jumpsuit"
	desc = "A black jumpsuit with white overalls, a scant reminder of the old miners of Gorlex VII."
	icon_state = "hl_jumpsuit"
	item_state = "hl_jumpsuit"

/obj/item/clothing/under/syndicate/hardliners/officer
	name = "hardliners officer uniform"
	desc = "A button-up uniform with cargo pants, certainly more tactical than most officer uniforms."
	icon_state = "hl_officer"
	item_state = "hl_officer"

/obj/item/clothing/under/plasmaman/hardliners
	name = "\improper Hardliner phorid envirosuit"
	desc = "A button-up envirosuit with use intended for phorid Hardliners. Ensures they don't die of combustion."
	icon_state = "hl_envirosuit"
	item_state = "hl_envirosuit"
	icon = 'icons/obj/clothing/faction/hardliners/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/uniforms.dmi'

////////////////////
//Unarmored suits//
///////////////////

/obj/item/clothing/suit/hardliners //Ideally, the basic suit model here should be turned into a placeholder model, and this item have "smock" or "apron" added on the end.
	name = "white smock"
	desc = "A plain-white surgical smock typically worn by both Hardliners and Cybersun staff. Even mercenaries need medical attention!"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	icon_state = "hl_apron"
	item_state = "whitecloth"
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

	equip_sound = 'sound/items/equip/cloth_equip.ogg'
	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5

/obj/item/clothing/suit/hazardvest/hardliners
	name = "blood-red hazard vest"
	desc = "A white high-visibility vest, worn by mechanics associated with Hardliners. Safety first!"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	icon_state = "hl_hazard"
	item_state = "whitecloth"

/obj/item/clothing/suit/hooded/wintercoat/security/hardliners
	name = "hardliner winter coat"
	desc = "A stark-white winter coat used by Marauders of the Hardliner movement, the zipper tab displaying the cracked emblem of the Gorlex Marauders."
	icon_state = "coathl"
	item_state = "coathl"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/hardliners

/obj/item/clothing/head/hooded/winterhood/security/hardliners
	icon_state = "hood_hl"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'

//////////////////
//Armored suits//
/////////////////

/obj/item/clothing/suit/armor/hardliners
	name = "hardliners armor vest"
	desc = "A slim Type I armored vest, painted in a classic white associated with the Hardliners. It would probably make bloodstains very obvious..."
	icon_state = "hl_vest"
	item_state = "armor"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	blood_overlay_type = "armor"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10) //ngr armor reskin - same statline

/obj/item/clothing/suit/armor/hardliners/jacket
	name = "hardliners armored kutte"
	desc = "A leather Kutte with a slim Type I armored vest, painted in a classic white associated with the Hardliners. The patch of the Hardliner movement can be seen behind the leather kutte, a nostalgic callback to the leather outfits used by the civilians of Gorlex VII."
	icon_state = "hl_jacket"
	item_state = "armor"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	blood_overlay_type = "armor"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10) //its not like they cover your arms.

/obj/item/clothing/suit/armor/hardliners/sergeant
	name = "hardliners sergeant jacket"
	desc = "An armored jacket typically worn by sergeant of the Hardliners. They're reminiscent of the garb worn by old Gorlex navymen, prior to its destruction."
	body_parts_covered = CHEST|GROIN
	icon_state = "hl_sergeant"
	item_state = "hl_sergeant"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/toggle/armor/vest/hardliners
	name = "hardliners captain coat"
	desc = "An imposing armored coat worn by captains of Hardliner fleets, hand-designed by Cybersun tailors to provide maximum protection to its wearer."
	body_parts_covered = CHEST|GROIN
	icon_state = "hl_captain"
	item_state = "hl_captain"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	togglename = "buttons"

	equipping_sound = EQUIP_SOUND_MED_GENERIC
	unequipping_sound = UNEQUIP_SOUND_MED_GENERIC
	equip_delay_self = EQUIP_DELAY_SUIT
	equip_delay_other = EQUIP_DELAY_SUIT * 1.5
	strip_delay = EQUIP_DELAY_SUIT * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT | EQUIP_SLOWDOWN

/obj/item/clothing/suit/toggle/armor/vest/hardliners/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

///////////////
//Spacesuits//
//////////////

/obj/item/clothing/head/helmet/space/hardsuit/syndi/hl
	name = "white-red hardsuit helmet"
	desc = "An advanced dual-mode helmet derived from ICW-era advanced special operations helmets, its red partly replaced by white. It is in EVA mode. Manufactured by Cybersun Biodynamics."
	alt_desc = "An advanced dual-mode helmet derived from ICW-era advanced special operations helmets, its red partly replaced by white. It is in combat mode. Manufactured by Cybersun Biodynamics."
	icon_state = "hardsuit1-hl"
	item_state = "hardsuit1-hl"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'
	hardsuit_type = "hl"

/obj/item/clothing/suit/space/hardsuit/syndi/hl
	name = "white-red hardsuit"
	desc = "An advanced dual-mode hardsuit derived from ICW-era advanced special operations hardsuits, its red partly replaced by white. It is in EVA mode. Manufactured by Cybersun Biodynamics."
	alt_desc = "An advanced dual-mode hardsuit derived from ICW-era advanced special operations hardsuits, its red partly replaced by white. It is in combat mode. Manufactured by Cybersun Biodynamics."
	icon_state = "hardsuit1-hl"
	item_state = "hardsuit1-hl"
	hardsuit_type = "hl"
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/hl
	jetpack = null
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/hl
	name = "elite white-red hardsuit helmet"
	desc = "An elite version of the infamous white-red Hardliner hardsuit, with improved armor and fireproofing. It is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "An elite version of the infamous white-red Hardliner hardsuit, with improved armor and fireproofing. It is in combat mode. Property of Gorlex Marauders."
	icon_state = "hardsuit0-hlelite"
	hardsuit_type = "hlelite"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'

/obj/item/clothing/suit/space/hardsuit/syndi/elite/hl
	name = "elite white-red hardsuit"
	desc = "An elite version of the infamous white-red Hardliner hardsuit, with improved armor and fireproofing. It is in travel mode."
	alt_desc = "An elite version of the infamous white-red Hardliner hardsuit, with improved armor and fireproofing. It is in combat mode."
	icon_state = "hardsuit0-hlelite"
	item_state = "hardsuit0-hlelite"
	hardsuit_type = "hlelite"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/hl
	icon = 'icons/obj/clothing/faction/hardliners/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/suits.dmi'
	jetpack = null
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/head/helmet/space/plasmaman/hardliners
	name = "Hardliner phorid envirosuit helmet"
	desc = "An envirohelmet designed for phorid Hardliners, with intimidating white stripes."
	icon_state = "hl_envirohelm"
	item_state = "hl_envirohelm"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'

/////////
//Hats//
////////

/obj/item/clothing/head/hardliners
	name = "white surgical cap"
	desc = "A surgical cap used by doctors of Hardliner fleets, matching their white smocks."
	icon_state = "hl_surgery"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'


/obj/item/clothing/head/hardhat/hardliners
	name = "white-red hard hat"
	desc = "A white-red hardhat typically used by both miners and mechanics under the Hardliner fleets."
	icon_state = "hl_hardhat"
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'

/obj/item/clothing/head/hardliners/peaked
	name = "Hardliner peaked cap"
	desc = "A stylish peaked cap utilized by high-ranking officers of the Hardliner movement. Most who wear it are likely to have been a veteran of the ICW, still vying for revenge against Nanotrasen..."
	icon_state = "hl_officer"
	item_state = "hl_officer"

/obj/item/clothing/head/helmet/hardliners
	name = "hardliners X-11 helmet"
	desc = "A well-armored helmet utilized by the Hardliners, though painted in their iconic white. Either it makes them stick out like a sore thumb, or it provides excellent camouflage in snow-covered planets."
	icon = 'icons/obj/clothing/faction/hardliners/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/head.dmi'
	armor = list("melee" = 40, "bullet" = 60, "laser" = 35, "energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) // The guys who specialize in ballistics would probably have better bullet armor. Maybe.
	icon_state = "hl_x11"
	item_state = "hl_x11"
	can_flashlight = TRUE
	content_overlays = TRUE

/obj/item/clothing/head/helmet/hardliners/swat
	name = "hardliners pilot helmet"
	desc = "A modified X-11 helmet utilized by regular pilots, as well as the feared exosuit pilots of the Hardliner movement. The attached visor helps protect against sudden flashes from explosions."
	flash_protect = FLASH_PROTECTION_WELDER
	icon_state = "hl_pilot"
	item_state = "hl_pilot"
	can_flashlight = TRUE

////////////
//Glasses//
///////////

/obj/item/clothing/glasses/hud/security/sunglasses/hardliners
	name = "hardliners security goggles"
	desc = "Tinted-red flash-proof goggles used by Hardliners, with an integrated security HUD, courtesy of their partners, Cybersun."
	icon_state = "hl_goggles"
	item_state = "hl_goggles"
	icon = 'icons/obj/clothing/faction/hardliners/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/eyes.dmi'
	glass_colour_type = /datum/client_colour/glass_colour/red
	flags_cover = GLASSESCOVERSEYES | SEALS_EYES

//////////
//Belts//
/////////

/obj/item/storage/belt/security/webbing/hardliners
	name = "hardliners webbing"
	desc = "A set of tactical webbing for operators of the Hardliner movement, can hold security gear."
	icon_state = "hl_webbing"
	item_state = "hl_webbing"
	icon = 'icons/obj/clothing/faction/hardliners/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/hardliners/belt.dmi'
	supports_variations = KEPORI_VARIATION

/obj/item/storage/belt/security/webbing/hardliners/sidewinder/PopulateContents()
	. = ..()
	new /obj/item/ammo_box/magazine/m57_39_sidewinder(src)
	new /obj/item/ammo_box/magazine/m57_39_sidewinder(src)
	new /obj/item/ammo_box/magazine/m57_39_sidewinder(src)
