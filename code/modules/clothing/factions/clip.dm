//under

/obj/item/clothing/under/clip
	name = "\improper CLIP deck worker jumpsuit"
	desc = "A jumpsuit worn by non-Minutemen workers in CLIP vessels."

	icon = 'icons/obj/clothing/faction/clip/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/uniforms.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip_deck"
	item_state = "b_suit"

	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	dying_key = DYE_REGISTRY_UNDER //??? // it's for washing machines don't worry about it

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION // a new record! UPDATE 2 MONTHS LATER: :'(

/obj/item/clothing/under/clip/minutemen
	name = "\improper Minutemen combat fatigues"
	desc = "The distinctive blue uniform of the Confederated League Minutemen, worn during field work and battle. Smells faintly of blueberries."

	icon_state = "clip_minuteman"

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50

	roll_sleeves = TRUE
	roll_down = TRUE
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION

/obj/item/clothing/under/clip/formal
	name = "\improper CLIP service uniform"
	desc = "A formal outfit consisting of CLIP-issued navy slacks and white dress shirt. Commonly seen on white-collar CLIP bureaucrats, but also worn by minutemen outside of combat."

	icon_state = "clip_formal"

	armor = null
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION

/obj/item/clothing/under/clip/formal/alt
	desc = "A formal outfit consisting of a CLIP-issued navy skirt and white dress shirt. Commonly seen on white-collar CLIP bureaucrats, but also worn by minutemen outside of combat."

	icon_state = "clip_formal_skirt"

/obj/item/clothing/under/clip/formal/with_shirt/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/clip_formal_overshirt/accessory = new (src)
	attach_accessory(accessory)

/obj/item/clothing/under/clip/formal/with_shirt/alt //because of how fucking skirt code works...
	desc = "A formal outfit consisting of a CLIP-issued navy skirt and white dress shirt. Commonly seen on white-collar CLIP bureaucrats, but also worn by minutemen outside of combat."

	icon_state = "clip_formal_skirt"

/obj/item/clothing/under/clip/medic
	name = "\improper CLIP medic uniform"
	desc = "A Confederated League uniform with navy slacks and a blue button-down shirt, embroidered with white shoulder patches. The patches feature a medical cross, denoting the wearer as medical personnel. "
	icon_state = "clip_medic"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION

/obj/item/clothing/under/clip/officer
	name = "\improper Minutemen officer service uniform"
	desc = "The brown service uniform used by officers of the CLIP Minutemen."
	icon_state = "clip_officer"
	item_state = "g_suit"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION

/obj/item/clothing/under/clip/officer/alt
	desc = "The brown service uniform used by officers of the CLIP Minutemen. This variant has a pencil skirt!"
	icon_state = "clip_officer_skirt"

//suit
/obj/item/clothing/suit/toggle/lawyer/clip
	name = "\improper CLIP officer suit jacket"
	desc = "A fancy buttoned dress jacket issued to officers of CLIP."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'

	icon_state = "suitjacket_clip"
	item_state = "suitjacket_navy"

/obj/item/clothing/suit/toggle/lawyer/clip/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed //it's hop-equivalent gear after all

/obj/item/clothing/suit/toggle/lawyer/clip/command
	name = "\improper CLIP senior officer suit jacket"
	desc = "A fancy buttoned dress jacket issued to senior officers of CLIP."

	icon_state = "suitjacket_clip_command"
	item_state = "suitjacket_clip_command"

//armor

/obj/item/clothing/suit/armor/vest/capcarapace/clip
	name = "Minutemen general coat"
	desc = "This flamboyant overwear is employed by the field generals of the CLIP Minutemen."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'

	icon_state = "clip_general"
	item_state = "clip_general"

	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/capcarapace/clip/admiral
	name = "Minutemen admiral trenchcoat"
	desc = "A very fancy trenchcoat used by naval admirals of the CLIP Minutemen."

	icon_state = "clip_admiral"
	item_state = "clip_admiral"

/obj/item/clothing/suit/armor/riot/clip
	name = "black riot suit"
	desc = "A charcoal-painted suit of bulky, heavy armor designed for close-quarters fighting and riot control. The armor of choice for CLIP-BARD members, but used universally by CLIP. Helps the wearer resist shoving in close quarters."
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	icon_state = "riot_clip"

/obj/item/clothing/suit/armor/clip_trenchcoat
	name = "\improper CLIP trenchcoat"
	desc = "A trenchcoat in Confederated League colors. Despite its reputation as a military officer coat, it's used by all divisions within CLIP. Has a lot of pockets."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'

	icon_state = "clip_trenchcoat"
	item_state = "trenchcoat_solgov"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0, "wound" = 10)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/suit/armor/clip_capcoat
	name = "Minutemen captain's coat"
	desc = "The coat issued to all CLIP Minutemen officers worthy of the rank of Captain. Features thick padding which, while protective, does not replace proper armor."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'

	icon_state = "clip_captaincoat"
	item_state = "clip_captaincoat"
	body_parts_covered = CHEST
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 0, "wound" = 10)
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/suit/armor/vest/clip_correspondent
	name = "\improper correspondent armor vest"
	desc = "A slim Type I armored vest that provides decent protection against most types of damage. The white letters on the front read \"PRESS\" in CLIP Kalixcian."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "armor_correspondant"
	item_state = "armor_correspondant"
	supports_variations = VOX_VARIATION | DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/suit/armor/vest/clip_correspondent/Initialize()
	. = ..()
	if(allowed)
		allowed += list(/obj/item/bodycamera/broadcast_camera) // i mean. come on

// biosuits

/obj/item/clothing/suit/bio_suit/bard
	name = "BARD-440 bio suit"
	desc = "The iconic biosuit of CLIP-BARD agents on the frontier and elsewhere."
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	icon_state = "clip_bard_biosuit"

/obj/item/clothing/suit/bio_suit/bard/Initialize()
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/bio_hood/bard
	name = "BARD-434 bio hood"
	desc = "A simple but effective and lightweight hood for use with CLIP-BARD's biosuits."
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = null
	clothing_flags = THICKMATERIAL | SNUG_FIT
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	icon_state = "clip_bard_bio"

/obj/item/clothing/head/bio_hood/bard/armored
	name = "BARD-434 armored bio hood"
	desc = "An M10 surplus helmet placed over a blue bio hood for use with CLIP-BARD's biosuits."
	icon_state = "clip_bard_bio_armored"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)


/obj/item/clothing/suit/bio_suit/bard/medium
	name = "BARD-434-2 combat bio suit"
	desc = "A special model of bio suit, made to specific CLIP-BARD certification and issued to teams expecting combat against dangerous xenofauna. Cumbersome."
	icon_state = "clip_bard_biosuit_medium"
	armor = list("melee" = 50, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 100, "rad" = 20, "fire" = 30, "acid" = 100)

/obj/item/clothing/suit/bio_suit/bard/heavy
	name = "BARD-434-3 heavy combat bio suit"
	desc = "A special model of bio suit, made to specific CLIP-BARD certification and issued to teams expecting combat against dangerous xenofauna. Cumbersome."
	icon_state = "clip_bard_biosuit_heavy"
	armor = list("melee" = 60, "bullet" = 30, "laser" = 35, "energy" = 35, "bomb" = 50, "bio" = 100, "fire" = 40, "rad" = 20, "acid" = 100)
	slowdown = 0.8

//spacesuits
/obj/item/clothing/suit/space/clip
	name = "CLIP space suit"
	icon_state = "space-clip"
	item_state = "space-clip"
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	desc = "A popular suit manufactured by the colonial league, rated for hazardous, low-pressure environments and high temperature alike. Often worn by various workers and civilians hired by the league."
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 10)
	resistance_flags = FIRE_PROOF
	siemens_coefficient = 0

/obj/item/clothing/head/helmet/space/clip
	name = "CLIP space helmet"
	icon_state = "space-clip"
	item_state = "space-clip"
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	desc = "A space helmet manufactured by the colonial league, rated for hazardous, low pressure environments and minor impacts. Often worn by various workers and civilians hired by the league."
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 10)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/clip/armored
	name = "CLIP armored space suit"
	icon_state = "space-clip-armor"
	item_state = "space-clip-armor"
	desc = "An armored variant of the leagues civilian spacesuit, swapping fabrics and adding more plating. Often issued out to miners in hazardous locations, police forces, or reservists."
	w_class = WEIGHT_CLASS_BULKY
	armor = list("melee" = 30, "bullet" = 20, "laser" = 30, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75, "wound" = 15)
	resistance_flags = null

/obj/item/clothing/head/helmet/space/clip/armored
	name = "CLIP armored space helmet"
	icon_state = "space-clip-armor"
	item_state = "space-clip-armor"
	desc = "An armored variant of the leagues civilian space helmet, swapping plating types. Often issued out to miners in hazardous locations, police forces, or reservists."
	armor = list("melee" = 30, "bullet" = 20, "laser" = 30, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75, "wound" = 15)
	resistance_flags = null

/obj/item/clothing/suit/space/hardsuit/clip_patroller
	name = "\improper CM-410 'Patroller' EVA Hardsuit"
	desc = "An older-issue CLIP hardsuit, adapted from an even older design. Widely utilized in reconnaissance duty and skirmishing due to its lightweight construction."
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee, /obj/item/restraints/handcuffs, /obj/item/tank/internals)

	slowdown = 0.2

	icon_state = "hardsuit-clip-patrol"
	hardsuit_type = "hardsuit-clip-patrol"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/clip_patroller

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

	armor = list("melee" = 35, "bullet" = 25, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)

/obj/item/clothing/head/helmet/space/hardsuit/clip_patroller
	name = "\improper CM-410 'Patroller' EVA Hardsuit helmet"
	desc = "The helmet for the Patroller hardsuit. The wide visor allows for higher visibility than afforded to standard combat hardsuits."

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'

	icon_state = "hardsuit0-clip-patrol"
	hardsuit_type = "clip-patrol"

	supports_variations = SNOUTED_VARIATION

	armor = list("melee" = 35, "bullet" = 25, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)

/obj/item/clothing/suit/space/hardsuit/clip_spotter
	name = "CM-490 'Spotter' Combat Hardsuit"
	desc = "CLIP's newer, standard-issue extra-vehicular combat hardsuit. The heavy plating is uncomfortable, and slows the wearer down."

	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'

	icon_state = "clip_spotter"
	hardsuit_type = "clip_spotter"

	armor = list("melee" = 50, "bullet" = 60, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80, "wound" = 50)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/clip_spotter
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee, /obj/item/restraints/handcuffs, /obj/item/tank/internals)

	resistance_flags = null
	slowdown = 1.25

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE

/obj/item/clothing/head/helmet/space/hardsuit/clip_spotter
	name = "CM-490 'Spotter' Combat Hardsuit Helmet"
	desc = "The helmet for the Spotter hardsuit. Features a very distinctive 'Spider-Eyes' visor."

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'

	icon_state = "hardsuit0-clip_spotter"
	hardsuit_type = "clip_spotter"

	armor = list("melee" = 50, "bullet" = 60, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80, "wound" = 50)
	resistance_flags = null

	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/bomb/clip
	name = "CMM EOD hardsuit"
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	icon_state = "hardsuit-clipeod"
	hardsuit_type = "clipeod"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/bomb/clip

/obj/item/clothing/head/helmet/space/hardsuit/bomb/clip
	name = "CMM EOD hardsuit helmet"
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	icon_state = "hardsuit0-clipeod"
	hardsuit_type = "clipeod"

//hats
/obj/item/clothing/head/clip
	name = "\improper Minutemen service cap"
	desc = "A service cap commonly seen on Minutemen of all ranks while off-duty, but more daring soldiers may choose to wear it during combat. The design dates back to the uniform used by the deserting forces of the Zohil Republic, who were the first citizens of CLIP."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'
//	lefthand_file = 'icons/mob/inhands/faction/clip/gezena_lefthand.dmi'
//	righthand_file = 'icons/mob/inhands/faction/clip/gezena_righthand.dmi'
	icon_state = "clip_cap"
	item_state = "bluecloth"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/clip/corpsman
	name = "\improper Minutemen medic cap"
	desc = "A service cap seen on Minutemen who choose medicine as their profession. The design dates back to the uniform used by the deserting forces of the Zohil Republic, who were the first citizens of CLIP."
	icon_state = "clip_mediccap"
	item_state = "whitecloth"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/clip/slouch
	name = "\improper Minutemen officer's slouch hat"
	desc = "A commanding slouch hat, issued to senior enlisted and junior officers of the Minutemen."
	icon_state = "clip_slouch_hat"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/clip/slouch/officer
	name = "\improper Minutemen senior officer's slouch hat"
	desc = "A commanding slouch hat with a white badge, given to higher-ranking officers of the Minutemen."
	icon_state = "clip_officer_hat"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/clip/boonie
	name = "\improper Minutemen boonie hat"
	desc = "A wide brimmed cap in Confederated League colors to keep oneself cool during blistering hot weather."
	icon_state = "clip_boonie"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/clip/bicorne
	name = "\improper Minutemen General bicorne"
	desc = "A large, flashy bicorne used by generals of the CLIP Minutemen."
	icon_state = "clip_general_hat"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/bulletproof/x11/clip
	name = "\improper Minutemen CM-11 Helmet"
	desc = "A large, bulky bulletproof helmet in the distinctive blue coloring of the Minutemen. Features a little attachment rail on the side where you can mount a flashlight."

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'
	lefthand_file = 'icons/mob/inhands/faction/clip/clip_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/clip/clip_righthand.dmi'

	icon_state = "clip_x11"
	item_state = "clip_x11"
	unique_reskin = list(
		"Standard Issue" = "clip_x11",
		"Blank" = "clip_x11_blank",
		"White Stripe" = "clip_x11_stripe"
		)
	can_flashlight = TRUE

	supports_variations = VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/head/helmet/m10/clip
	name = "\improper Minutemen CM-10 Helmet"
	desc = "A cheap, but comfortable and light helmet painted in Minutemen colors, often seen in the hands of the reserves or Minutemen in the backline. Features a little attachment rail on the side where you can mount a flashlight."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	icon_state = "clip_m10"
	can_flashlight = TRUE
	unique_reskin = list(
		"Standard Issue" = "clip_m10",
		"Blank" = "clip_m10_blank",
		"Triple Column" = "clip_m10_triple"
		)

/obj/item/clothing/head/helmet/m10/clip_vc
	name = "\improper Minutemen CM-12 Helmet"
	desc = "A special, lightweight and padded helmet issued to Vehicle Crewmen of the Minutemen. Features noise-reducing technology and a microphone that automatically connects with worn headsets. Hopefully protects you from bumpy rides."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip_m10_vc"
	unique_reskin = list(
		"Standard Issue" = "clip_m10_vc",
		"Arctic" = "clip_m10_vc_arctic",
		"Spearhead" = "clip_m10_vc_spearhead"
		)
	can_flashlight = TRUE

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/m10/clip_vc/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_HEAD))

/obj/item/clothing/head/helmet/m10/clip_correspondent
	name = "CLIP war correspondent M10 Helmet"
	desc = "A lightweight bulletproof helmet given to war correspondents of CLIP. Features a little attachment rail on the side where you can mount a flashlight. Keep your head down!"

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip_m10_correspondant"
	item_state = "clip_m10_correspondant"
	can_flashlight = TRUE

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/riot/clip
	name = "\improper Minutemen CM-13 Riot Helmet"
	desc = "A sturdy blue helmet, made with crowd control in mind. The foldable protective visor makes it CLIP-BARD's preferred helmet against hostile xenofauna."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	icon_state = "riot_clip"
	base_icon_state = "riot_clip"
	supports_variations = SNOUTED_VARIATION

// CLIP-GOLD

/obj/item/clothing/head/fedora/det_hat/clip
	name = "\improper CLIP-GOLD fedora"
	desc = "A rare sight in the frontier, issued to members of the CLIP-GOLD division. Designed to look more casual, but still as fashionable as the average CLIP attire."

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip_fedora"
	item_state = "detective"

	supports_variations = VOX_VARIATION

/obj/item/clothing/head/flatcap/clip
	name = "\improper CLIP-GOLD flatcap"
	desc = "A flatcap issued to members of the CLIP-GOLD division. An office worker's hat."

	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "flatcap_clip"
	item_state = "detective"

	supports_variations = VOX_VARIATION

//mask

/obj/item/clothing/mask/gas/clip
	name = "\improper CM-20 gas mask"
	desc = "A close-fitting gas mask that can be connected to an air supply. Hastily-made in 420 FS during the Xenofauna war, after it was discovered that gas mask designs out of date by two decades did not work against xenofauna. Standard issue for every Minuteman, but rarely used, as chemical warfare is rare."

	icon = 'icons/obj/clothing/faction/clip/mask.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/mask.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip-gasmask"
	strip_delay = 60

	flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR

	supports_variations = SNOUTED_VARIATION | VOX_VARIATION

/obj/item/clothing/mask/balaclava/combat
	name = "\improper combat balaclava"
	desc = "A surprisingly advanced balaclava. While it doesn't muffle your voice, it has a mouthpiece for internals. Comfy to boot!"
	icon_state = "combat_balaclava"
	item_state = "combat_balaclava"
	alternate_worn_layer = BODY_LAYER
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEARS|HIDEHAIR

//gloves

/obj/item/clothing/gloves/color/latex/nitrile/clip
	name = "\improper long white nitrile gloves"
	desc = "Thick sterile gloves that reach up to the elbows. Transfers combat medic knowledge into the user via nanochips."

	icon = 'icons/obj/clothing/faction/clip/hands.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/hands.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "nitrile_clip"
	item_state = "nitrile_clip"

	supports_variations = VOX_VARIATION

//boots

//belt
/obj/item/storage/belt/military/clip
	name = "\improper Minutemen chest rig"
	desc = "This rig features many large pouches colored in Confederated League blue. The bulk of the pouches makes it only slightly uncomfortable to wear."

	icon = 'icons/obj/clothing/faction/clip/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/belt.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clipwebbing"
	item_state = "clipwebbing"

	unique_reskin = list("Suspenders Up" = "clipwebbing",
						"Suspenders Down" = "clipwebbing-alt"
						)

	supports_variations = VOX_VARIATION

/obj/item/storage/belt/military/clip/cm82/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/p16(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/military/clip/f4/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/f4_308(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/military/clip/cm5/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/cm5_9mm(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/military/clip/cm15/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/ammo_box/magazine/cm15_12g(src)
	new /obj/item/grenade/frag(src)

/obj/item/storage/belt/military/clip/e50/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/military/clip/e50/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/stock_parts/cell/gun/large(src)
	for(var/i in 1 to 2)
		new /obj/item/ammo_box/magazine/m9mm_cm70(src)
	new /obj/item/gun/ballistic/automatic/pistol/cm70(src)

/obj/item/storage/belt/military/clip/engi/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/electric(src)
	new /obj/item/multitool(src)
	new /obj/item/construction/rcd/combat(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/military/clip/alt/ecm6/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/stock_parts/cell/gun/kalix(src)

/obj/item/storage/belt/military/clip/alt/cm15_inc/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/ammo_box/magazine/cm15_12g/incendiary(src)
	for(var/i in 1 to 3)
		new /obj/item/ammo_box/magazine/cm357(src)
	new /obj/item/gun/ballistic/automatic/pistol/cm357(src)

/obj/item/storage/belt/military/clip/alt
	name = "\improper Minutemen belt rig"
	desc = "This belt features many large pouches colored in Confederated League blue. The bulk of the pouches makes it only slightly uncomfortable to wear."

	icon_state = "clipwebbing-alt"
	item_state = "clipwebbing-alt"

/obj/item/storage/belt/medical/webbing/clip
	name = "CLIP medical webbing"
	desc = "A variation on the standard Minuteman rig, colored white and instead designed to hold various medical supplies."

	icon = 'icons/obj/clothing/faction/clip/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/belt.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clip-medwebbing"

	supports_variations = VOX_VARIATION

/obj/item/storage/belt/medical/webbing/clip/prefilled/PopulateContents()
	new /obj/item/reagent_containers/medigel/hadrakine(src)
	new /obj/item/reagent_containers/medigel/hadrakine(src)
	new /obj/item/reagent_containers/medigel/quardexane(src)
	new /obj/item/reagent_containers/medigel/quardexane(src)
	new /obj/item/reagent_containers/medigel/synthflesh(src)
	new /obj/item/reagent_containers/medigel/synthflesh(src)
	new /obj/item/stack/medical/splint(src)

//back
/obj/item/storage/backpack/security/clip
	name = "CLIP backpack"
	desc = "It's a very blue backpack, branded with the stars of the Confederated League."

	icon_state = "clippack"

	supports_variations = VOX_VARIATION

/obj/item/storage/backpack/satchel/sec/clip
	name = "CLIP satchel"
	desc = "It's a very blue satchel, branded with the stars of the Confederated League."
	icon_state = "satchel-clip"


//neck

//accessories

/obj/item/clothing/accessory/clip_formal_overshirt
	name = "\improper CLIP overshirt"
	desc = "A fancy blue shirt intended to be worn over the CLIP service uniform's undershirt."
	icon_state = "clip_formal_overshirt"
	icon = 'icons/obj/clothing/faction/clip/accessory.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/accessory.dmi'
	minimize_when_attached = FALSE
