//////////////
//Jumpsuits//
/////////////

/obj/item/clothing/under/syndicate/ngr
	name = "\improper NGR uniform"
	desc = "A button-up in a tasteful beige with black pants, used as the basic uniform of the New Gorlex Republic."
	icon_state = "ngr"
	item_state = "ngr"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	can_adjust = FALSE
	icon = 'icons/obj/clothing/faction/ngr/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/uniforms.dmi'

/obj/item/clothing/under/syndicate/ngr/fatigues
	name = "\improper NGR fatigues"
	desc = "Beige fatigues used primarily by the shuttle and exosuit pilots of the New Gorlex Republic."
	icon_state = "ngr_fatigues"
	item_state = "ngr_fatigues"

/obj/item/clothing/under/syndicate/ngr/jumpsuit
	name = "\improper NGR jumpsuit"
	desc = "A beige jumpsuit with black overalls used by wreckers of the New Gorlex Republic. A reminder of Gorlex VII's history as a mining colony, prior to its destruction."
	icon_state = "ngr_jumpsuit"
	item_state = "ngr_jumpsuit"

/obj/item/clothing/under/syndicate/ngr/officer
	name = "\improper NGR officer uniform"
	desc = "A button-up in a tasteful black with beige pants, used by officers of the New Gorlex Republic."
	icon_state = "ngr_officer"
	item_state = "ngr_officer"

/obj/item/clothing/under/plasmaman/ngr
	name = "\improper NGR phorid envirosuit"
	desc = "A button-up envirosuit with use intended for phorids of the New Gorlex Republic. Ensures they don't die of combustion."
	icon_state = "ngr_envirosuit"
	item_state = "ngr_envirosuit"
	icon = 'icons/obj/clothing/faction/ngr/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/uniforms.dmi'


////////////////////
//Unarmored suits//
///////////////////

/obj/item/clothing/suit/ngr
	name = "foreman's jacket"
	desc = "A beige high-visibility jacket worn by the Foreman of the New Gorlex Republic."
	icon = 'icons/obj/clothing/faction/ngr/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/suits.dmi'
	icon_state = "ngr_foreman"
	item_state = "blackcloth"

/obj/item/clothing/suit/ngr/smock
	name = "blood red smock"
	desc = "A blood-red surgical smock typically worn by field medics of the New Gorlex Republic. It hides red blood really well!"
	icon_state = "ngr_apron"
	item_state = "redcloth"

/obj/item/clothing/suit/hazardvest/ngr
	name = "blood-red hazard vest"
	desc = "A blood-red high-visibility vest typically used in work zones by the New Gorlex Republic."
	icon = 'icons/obj/clothing/faction/ngr/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/suits.dmi'
	icon_state = "ngr_hazard"
	item_state = "redcloth"
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/hooded/wintercoat/security/ngr
	name = "NGR winter coat"
	desc = "A sleek beige winter coat used by the Second Battlegroup of the New Gorlex Republic, the zipper tab proudly displays the official emblem of the NGR."
	icon_state = "coatngr"
	item_state = "coatngr"
	icon = 'icons/obj/clothing/faction/ngr/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/suits.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/ngr

/obj/item/clothing/head/hooded/winterhood/security/ngr
	icon_state = "hood_ngr"
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'

//////////////////
//Armored suits//
/////////////////

/obj/item/clothing/suit/armor/ngr
	name = "NGR armor vest"
	desc = "A slim Type I armored vest, utilized by the 2nd Battlegroup of the New Gorlex Republic that provides decent protection against most types of damage."
	icon_state = "ngr_vest"
	item_state = "armor"
	icon = 'icons/obj/clothing/faction/ngr/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/suits.dmi'
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/ngr/lieutenant
	name = "\improper 2nd Battlegroup overcoat"
	desc = "An armored overcoat worn by the lieutenants of the New Gorlex Republic's 2nd Battlegroup."
	body_parts_covered = CHEST|GROIN
	icon_state = "ngr_lieutenant"
	item_state = "ngr_lieutenant"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/armor/ngr/captain
	name = "\improper 2nd Battlegroup coat"
	desc = "An armored coat worn by captains the New Gorlex Republic's 2nd Battlegroup."
	body_parts_covered = CHEST|GROIN
	icon_state = "ngr_captain"
	item_state = "ngr_captain"
	blood_overlay_type = "coat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

///////////////
//Spacesuits//
//////////////

/obj/item/clothing/head/helmet/space/hardsuit/syndi/ngr
	name = "beige-red hardsuit helmet"
	desc = "A standardized dual-mode helmet derived from ICW-era advanced special operations helmets, its red partly replaced by beige. It is in EVA mode. Manufactured by Second Battlegroup."
	alt_desc = "A standardized dual-mode helmet derived from ICW-era advanced special operations helmets, its red partly replaced by beige. It is in combat mode. Manufactured by Second Battlegroup."
	icon_state = "hardsuit1-ngr"
	item_state = "hardsuit1-ngr"
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'
	hardsuit_type = "ngr"

/obj/item/clothing/suit/space/hardsuit/syndi/ngr
	name = "beige-red hardsuit"
	desc = "A standardized dual-mode hardsuit derived from ICW-era advanced special operations hardsuits, its red partly replaced by beige. It is in EVA mode. Manufactured by Second Battlegroup."
	alt_desc = "A standardized dual-mode hardsuit derived from ICW-era advanced special operations hardsuits, its red partly replaced by beige. It is in combat mode. Manufactured by the Second Battlegroup."
	icon_state = "hardsuit1-ngr"
	item_state = "hardsuit1-ngr"
	hardsuit_type = "ngr"
	icon = 'icons/obj/clothing/faction/ngr/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/suits.dmi'
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ngr
	lightweight = 1
	jetpack = null
	greyscale_colors = list("#33353a", "#d9ad82", "#8c1a34")

/obj/item/clothing/head/helmet/space/plasmaman/ngr
	name = "NGR phorid envirosuit helmet"
	desc = "An envirohelmet designed for phorids of the New Gorlex Republic, with intimidating blood-red stripes."
	icon_state = "ngr_envirohelm"
	item_state = "ngr_envirohelm"
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'

/////////
//Hats//
////////

/obj/item/clothing/head/ngr
	name = "beige garrison cap"
	desc = "A garrison cap used by low-ranking members of the New Gorlex Republic's 2nd Battlegroup when off-duty."
	icon_state = "ngr_garrison"
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'

/obj/item/clothing/head/ngr/flap
	name = "beige flap cap"
	desc = "A flap cap used by soldiers of the New Gorlex Republic's 2nd Battlegroup in desert environments."
	icon_state = "ngr_flap"

/obj/item/clothing/head/ngr/surgical
	name = "blood-red surgical cap"
	desc = "A surgical cap used by field medics of the New Gorlex Republic's 2nd Battlegroup."
	icon_state = "ngr_surgery"

/obj/item/clothing/head/hardhat/ngr
	name = "blood-red hard hat"
	desc = "A blood-red hardhat typically used by Wreckers and Ship Engineers of the New Gorlex Republic."
	icon_state = "ngr_hardhat"
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'

/obj/item/clothing/head/hardhat/ngr/foreman
	name = "beige hard hat"
	desc = "A beige hardhat used exclusively by the Foreman of the New Gorlex Republic."
	icon_state = "ngr_foreman"

/obj/item/clothing/head/ngr/peaked
	name = "2nd Battlegroup peaked cap"
	desc = "A cap worn by officers of the New Gorlex Republic's 2nd Battlegroup."
	icon_state = "ngr_officer"
	item_state = "ngr_officer"

/obj/item/clothing/head/helmet/ngr
	name = "\improper NGR X-11 helmet"
	desc = "A well-armored helmet utilized by the New Gorlex Republic's 2nd Battlegroup, far better at protecting one's head than the softer caps."
	icon = 'icons/obj/clothing/faction/ngr/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/head.dmi'
	armor = list("melee" = 40, "bullet" = 60, "laser" = 35, "energy" = 35, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) // The guys who specialize in ballistics would probably have better bullet armor. Maybe.
	icon_state = "ngr_x11"
	item_state = "ngr_x11"

/obj/item/clothing/head/helmet/ngr/swat
	name = "\improper NGR pilot helmet"
	desc = "A modified X-11 helmet utilized by the pilots of the New Gorlex Republic's 2nd Battlegroup. The attached visor helps protect against sudden flashes from explosions."
	flash_protect = FLASH_PROTECTION_WELDER
	icon_state = "ngr_pilot"
	item_state = "ngr_pilot"

////////////
//Glasses//
///////////

/obj/item/clothing/glasses/hud/security/sunglasses/ngr
	name = "NGR modified mesons"
	desc = "A modified version of widely-used optical meson scanners, with a flash-proof tint and integrated security HUD. Unfortunately, the opaque visor disables the meson functionality."
	icon_state = "ngr_goggles"
	item_state = "ngr_goggles"
	icon = 'icons/obj/clothing/faction/ngr/eyes.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/eyes.dmi'
	glass_colour_type = /datum/client_colour/glass_colour/green

//////////
//Masks//
/////////

/obj/item/clothing/mask/balaclava/ngr
	name = "NGR combat balaclava"
	desc = "A surprisingly advanced balaclava. While it doesn't muffle your voice, it has a mouthpiece for internals. Comfy to boot! This version is commonly used by the soldiers of the New Gorlex Republic to protect against sandstorms."
	icon_state = "ngr_balaclava"
	item_state = "ngr_balaclava"
	icon = 'icons/obj/clothing/faction/ngr/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/mask.dmi'

/obj/item/clothing/mask/breath/ngr
	name = "NGR face mask"
	desc = "A face mask that covers the nose, mouth and neck of those who wear it. Favored by field medics over the balaclava due to lessened heat while wearing."
	icon_state = "ngr_facemask"
	item_state = "ngr_facemask"
	icon = 'icons/obj/clothing/faction/ngr/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/mask.dmi'
	supports_variations = SNOUTED_VARIATION | SNOUTED_SMALL_VARIATION

//////////
//Neck//
/////////

/obj/item/clothing/neck/shemagh/ngr
	name = "shemagh"
	desc = "An oversized shemagh, in a tacticool blood-red for use in the 2nd Battlegroup."
	icon_state = "ngr_shemagh"
	icon = 'icons/obj/clothing/faction/ngr/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/neck.dmi'
	supports_variations = VOX_VARIATION

//////////
//Belts//
/////////

/obj/item/storage/belt/security/webbing/ngr
	name = "NGR webbing"
	desc = "A set of tactical webbing for operators of the New Gorlex Republic, can hold security gear."
	icon_state = "ngr_webbing"
	item_state = "ngr_webbing"
	icon = 'icons/obj/clothing/faction/ngr/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/ngr/belt.dmi'

/obj/item/storage/belt/security/webbing/ngr/cobra/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m45_cobra(src)

/obj/item/storage/belt/security/webbing/ngr/hydra_grenadier/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/ammo_box/magazine/m556_42_hydra(src)
	new /obj/item/ammo_casing/a40mm(src)
	new /obj/item/ammo_casing/a40mm(src)
