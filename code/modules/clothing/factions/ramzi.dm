//////////////
//Jumpsuits//
/////////////

/obj/item/clothing/under/syndicate/ramzi
	name = "\improper Ramzi uniform"
	desc = "An older uniform, formerly worn by the Gorlex Marauders."
	icon_state = "ramzi"
	item_state = "ramzi"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	icon = 'icons/obj/clothing/faction/ramzi/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/uniforms.dmi'
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/ramzi/overalls
	name = "\improper Ramzi overalls"
	desc = "An aging pair of overalls, formerly worn by the Gorlex Marauders."
	icon_state = "ramzi_overalls"
	item_state = "ramzi_overalls"
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/ramzi/officer
	name = "\improper Ramzi officer uniform"
	desc = "An aging button-up uniform, with its colors dulled out. Worn by Ramzi Clique Officers."
	icon_state = "ramzi_officer"
	item_state = "ramzi_officer"
	supports_variations = DIGITIGRADE_VARIATION

////////////////////
//Unarmored suits//
///////////////////

/obj/item/clothing/suit/ramzi
	name = "torn worker's jacket"
	desc = "An old worker's jacket in a poor state, in the colors of the Ramzi Clique."
	icon = 'icons/obj/clothing/faction/ramzi/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/suits.dmi'
	icon_state = "ramzi_worker"
	item_state = "blackcloth"

	equipping_sound = EQUIP_SOUND_SHORT_GENERIC
	unequipping_sound = UNEQUIP_SOUND_SHORT_GENERIC
	equip_delay_self = EQUIP_DELAY_COAT
	equip_delay_other = EQUIP_DELAY_COAT * 1.5
	strip_delay = EQUIP_DELAY_COAT * 1.5


/obj/item/clothing/suit/ramzi/smock
	name = "maroon smock"
	desc = "A shabby smock, it's straps barely held on. It's hard to tell if the color due to aging or bloodstains."
	icon_state = "ramzi_smock"
	item_state = "redcloth"
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS

//////////////////
//Armored suits//
/////////////////

/obj/item/clothing/suit/armor/ramzi
	name = "Ramzi armor vest"
	desc = "A slim Type I armored vest, worn by pirates of the Ramzi Clique."
	icon_state = "ramzi_vest"
	item_state = "armor"
	icon = 'icons/obj/clothing/faction/ramzi/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/suits.dmi'
	blood_overlay_type = "armor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)

/obj/item/clothing/suit/armor/ramzi/bulletproof
	name = "Ramzi bulletproof vest"
	desc = "A heavier Type III armored vest, worn by pirates of the Ramzi Clique. "
	icon_state = "ramzi_bullet"
	item_state = "armor"
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)

/obj/item/clothing/suit/armor/ramzi/officer
	name = "\improper Ramzi overcoat"
	desc = "An armored overcoat worn by officers of the Ramzi Clique."
	body_parts_covered = CHEST|GROIN
	icon_state = "ramzi_lead"
	item_state = "ramzi_lead"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)

/obj/item/clothing/suit/armor/ramzi/captain
	name = "\improper Armored Ramzi coat"
	desc = "An armored coat worn by cell leaders of the Ramzi Clique."
	body_parts_covered = CHEST|GROIN
	icon_state = "ramzi_captain"
	item_state = "ramzi_captain"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)

///////////////
//Spacesuits//
//////////////

/obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi
	name = "rust-red hardsuit helmet"
	desc = "A beat-up standardized dual-mode helmet derived from more advanced special operations helmets, its red rusted into a dirty brown. It is in EVA mode. Manufactured by Ramzi Clique."
	alt_desc = "A beat-up standardized dual-mode helmet derived from more advanced special operations helmets, its red rusted into a dirty brown. It is in travel mode. Manufactured by Ramzi Clique."
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'
	icon_state = "hardsuit1-ramzi"
	item_state = "hardsuit1-ramzi"
	hardsuit_type = "ramzi"

	armor = list("melee" = 35, "bullet" = 40, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)

/obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	name = "rust-red hardsuit"
	desc = "A beat-up standardized dual-mode hardsuit derived from more advanced special operations hardsuits, its red rusted into a dirty brown. It is in EVA mode. Manufactured by Ramzi Clique."
	alt_desc = "A beat-up standardized dual-mode hardsuit derived from more advanced special operations hardsuits, its red rusted into a dirty brown. It is in travel mode. Manufactured by Ramzi Clique."
	icon = 'icons/obj/clothing/faction/ramzi/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/suits.dmi'
	icon_state = "hardsuit1-ramzi"
	item_state = "hardsuit1-ramzi"
	hardsuit_type = "ramzi"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi
	jetpack = null
	armor = list("melee" = 35, "bullet" = 40, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	slowdown = 0.7
	jetpack = null
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION | VOX_VARIATION

//Ramzi Elite Suit
/obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi/elite
	name = "elite rust-red hardsuit helmet"
	desc = "An elite version of the rusted-red hardsuit helmet, with improved armour and fireproofing. The armour is worn and heavy. It is in EVA mode."
	alt_desc = "An elite version of the rusted-red hardsuit, with improved armour and fireproofing. The armour is worn and heavy. It is in travel mode."
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'
	hardsuit_type = "ramzielite"
	icon_state = "hardsuit1-ramzielite"
	item_state = "hardsuit1-ramzielite"
	armor = list("melee" = 50, "bullet" = 60, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 80, "wound" = 30)

/obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	name = "elite rust-red hardsuit"
	desc = "An elite version of the rusted-red hardsuit, with improved armour and fireproofing. The armour is worn and heavy. It is in EVA mode."
	alt_desc = "An elite version of the rusted-red hardsuit, with improved armour and fireproofing. The armour is worn and heavy. It is in EVA mode."
	icon = 'icons/obj/clothing/faction/ramzi/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/suits.dmi'
	icon_state = "hardsuit1-ramzielite"
	item_state = "hardsuit1-ramzielite"
	hardsuit_type = "ramzielite"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi/elite
	armor = list("melee" = 50, "bullet" = 60, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 80, "wound" = 30)
	slowdown = 1.25

/////////
//Hats//
////////

/obj/item/clothing/head/ramzi
	name = "Ramzi garrison cap"
	desc = "An old Gorlex Marauder garrison cap, commonly used by the Ramzi Clique."
	icon_state = "ramzi_minor"
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'

/obj/item/clothing/head/ramzi/flap
	name = "Ramzi flap cap"
	desc = "A flap cap used by Ramzi cells in harsh environments."
	icon_state = "ramzi_flap"

/obj/item/clothing/head/ramzi/surgical
	name = "maroon surgical cap"
	desc = "A worn surgical cap, either dulled red or covered in dried blood."
	icon_state = "ramzi_surgery"

/obj/item/clothing/head/hardhat/ramzi
	name = "maroon hard hat"
	desc = "An aging hardhat typically worn by Ramzi Clique engineers."
	icon_state = "ramzi_hardhat"
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'

/obj/item/clothing/head/ramzi/peaked
	name = "Ramzi Clique peaked cap"
	desc = "A cap worn by officers of the Ramzi Clique."
	icon_state = "ramzi_peak"
	item_state = "ramzi_peak"

/obj/item/clothing/head/ramzi/beret
	name = "Ramzi Clique officer's beret"
	desc = "A beret worn by officers of the Ramzi Clique."
	icon_state = "ramzi_major"
	item_state = "ramzi_major"

/obj/item/clothing/head/helmet/m10/ramzi
	name = "\improper Ramzi Clique M-10 helmet"
	desc = "A cheaper helmet utilized by the Ramzi Clique, often handed out to less valuable combatants."
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	icon_state = "ramzi_m10"
	item_state = "ramzi_m10"
	can_flashlight = TRUE
	content_overlays = TRUE

/obj/item/clothing/head/helmet/bulletproof/x11/ramzi
	name = "\improper Ramzi Clique X-11 helmet"
	desc = "A durable bulletproof helmet, often handed out to more reliable Ramzi assets."
	icon = 'icons/obj/clothing/faction/ramzi/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/head.dmi'
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	icon_state = "ramzi_x11"
	item_state = "ramzi_x11"
	can_flashlight = TRUE
	content_overlays = TRUE

//////////
//Masks//
/////////

/obj/item/clothing/mask/gas/ramzi
	name = "Ramzi Clique gas mask"
	desc = "A protective gas mask salvaged back together by the Ramzi Clique."
	icon = 'icons/obj/clothing/faction/ramzi/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/mask.dmi'
	icon_state = "ramzi_gas"
	item_state = "ramzi_gas"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	supports_variations = SNOUTED_VARIATION

//////////
//Neck//
/////////

/obj/item/clothing/neck/shemagh/ramzi
	name = "shemagh"
	desc = "An oversized shemagh, in a dark maroon."
	icon_state = "ramzi_shemagh"
	icon = 'icons/obj/clothing/faction/ramzi/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/neck.dmi'

//////////
//Belts//
/////////

/obj/item/storage/belt/security/webbing/ramzi
	name = "Ramzi Clique webbing"
	desc = "A set of tactical webbing for cells of the Ramzi Clique."
	icon_state = "ramzi_webbing"
	item_state = "ramzi_webbing"
	icon = 'icons/obj/clothing/faction/ramzi/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ramzi/belt.dmi'

/obj/item/storage/belt/security/webbing/ramzi/alt
	name = "Ramzi Clique drop pouch harness"
	desc = "A quick-access drop pouch harness used by cells of the Ramzi Clique."
	icon_state = "ramzi_harness"
	item_state = "ramzi_harness"
