//under CLIP
/obj/item/clothing/under/clip
	name = "\improper CLIP utility jumpsuit"
	desc = "A sturdy jumpsuit worn by CLIP government workers in field positions."

	icon = 'icons/obj/clothing/faction/clip/civilian_uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/civilian_uniforms.dmi'
	icon_state = "clip_deck"
	sensor_mode = SENSOR_COORDS
	roll_sleeves = TRUE
	roll_down = FALSE
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'


/obj/item/clothing/under/clip/medic
	name = "\improper CLIP doctor's uniform"
	desc = "A Confederated League uniform in stark white with large blue ring patches on either shoulder, denoting the wearer as medical personnel."
	icon_state = "clip_doc"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/clip/engi
	name = "\improper CLIP engineer's uniform"
	desc = "A sturdy jumpsuit worn by CLIP government workers in field positions. This one has large orange ring patches on either shoulder, denoting the wearer as an engineer."
	icon_state = "clip_engi"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/clip/formal
	name = "\improper CLIP dress uniform"
	desc = "A more formal outfit consisting of CLIP-issued navy slacks and a white dress shirt. Commonly seen on white-collar CLIP bureaucrats and off-duty government workers."

	icon_state = "clip_formal"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/clip/formal/alt
	desc = "A more formal outfit consisting of a CLIP-issued navy skirt and white dress shirt. Commonly seen on white-collar CLIP bureaucrats and off-duty government workers."

	icon_state = "clip_formalskirt"

/obj/item/clothing/under/clip/officer
	name = "\improper CLIP officer's uniform"
	desc = "The green pants and khaki shirt of a CLIP sanctioned captain."
	icon_state = "clip_captain"
	item_state = "g_suit"

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/clip/officer/alt
	desc = "The green skirt and khaki shirt of a CLIP sanctioned captain"
	icon_state = "clip_captainskirt"

//under CMM

/obj/item/clothing/under/cmm
	name = "\improper Minutemen combat fatigues"
	desc = "The drab olive uniform of the Colonial Minutemen, simple yet identifiable, just how the Minutemen like it."

	icon = 'icons/obj/clothing/faction/clip/minutemen_uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/minutemen_uniforms.dmi'
	icon_state = "cmm_fatigue"
	sensor_mode = SENSOR_COORDS
	roll_sleeves = TRUE
	roll_down = TRUE
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/under/cmm/medic
	name = "\improper CMM combat medic uniform"
	desc = "A Colonial Minutemen uniform in drab olive with large blue ring patches on either shoulder, denoting the wearer as medical personnel."
	icon_state = "cmm_doc"
	roll_down = FALSE

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/cmm/engi
	name = "\improper CMM engineer's uniform"
	desc = "A jumpsuit worn by the Colonial Minutemen's engineering personell denoted by the large orange ring patches on either shoulder."
	icon_state = "cmm_engi"
	roll_down = FALSE

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/cmm/formal
	name = "\improper CMM dress uniform"
	desc = "A more formal outfit consisting of olive slacks and a white dress shirt. Commonly worn by Minutemen on leave or parade."
	icon_state = "cmm_formal"
	roll_down = FALSE

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/cmm/formal/alt
	desc = "A more formal outfit consisting of and olive skirt and a white dress shirt. Commonly worn by Minutemen on leave or parade."
	icon_state = "cmm_formalskirt"
	roll_down = FALSE

/obj/item/clothing/under/cmm/officer
	name = "\improper CMM officer's uniform"
	desc = "The khaki pants and olive shirt of an officer of the Colonial Minutemen."
	icon_state = "cmm_captain"
	item_state = "g_suit"
	roll_down = FALSE

	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/cmm/officer/alt
	desc = "The khaki skirt and olive shirt of an officer of the Colonial Minutemen."
	icon_state = "cmm_captainskirt"
	roll_down = FALSE


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

/obj/item/clothing/suit/toggle/cmm
	name = "CMM range fleece"
	desc = "Made from a deceptively warm faux-wool blend and covered in zipper-pockets, the Colonial Minutemen's range fleece is hard to beat in terms of convenience."
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	icon_state = "cmm_fleece"
	blood_overlay_type = "coat"
	togglename = "zipper"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	vox_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'
	kepori_override_icon = 'icons/mob/clothing/faction/clip/kepori.dmi'

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
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
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
	supports_variations = SNOUTED_VARIATION

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
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/mining/clip
	name = "CLIP industrial hardsuit helmet"
	desc = "A bulky, slit-helmet design made with impact protection in mind."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	icon_state = "hardsuit0-clipindus"
	item_state = "hardsuit0-clipindus"
	hardsuit_type = "clipindus"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 80, "fire" = 80, "acid" = 100, "wound" = 20)
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/mining/clip
	name = "CLIP industrial hardsuit"
	desc = "A prolific hardsuit seen in every corner of the league, the CLIP industrial hardsuit is rated for factory, prospecting, and construction work. A frequent life saver in mining ventures and repair yards, the plating on this suit is durable, yet not over-encumbering."
	icon = 'icons/obj/clothing/faction/clip/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/suits.dmi'
	icon_state = "hardsuit0-clipindus"
	item_state = "hardsuit0-clipindus"
	hardsuit_type = "clipindus"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining/clip
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 80, "fire" = 80, "acid" = 100, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION_SAME_ICON_FILE
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = 0.5

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

	armor = list("melee" = 50, "bullet" = 60, "laser" = 50, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80, "wound" = 50)
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

	armor = list("melee" = 50, "bullet" = 60, "laser" = 50, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80, "wound" = 50)
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
	supports_variations = SNOUTED_VARIATION

//hats
/obj/item/clothing/head/clip
	name = "\improper CLIP range cap"
	desc = "A general service cap commonly worn by both the military and civilian servants of the Confederated League. The design features a neck-covering flap and chin strap which can be used to tie the hat up or down, depending on the weather."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'
	icon_state = "clip_cap"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Folded Up" = "clip_cap",
		"Folded Down" = "clip_cap_down"
		)

/obj/item/clothing/head/clip/medic
	name = "\improper Medical range cap"
	desc = "A medical service cap commonly worn by both the military and civilian servants of the Confederated League. The design features a neck-covering flap and chin strap which can be used to tie the hat up or down, depending on the weather."
	icon_state = "clip_mediccap"
	supports_variations = VOX_VARIATION | KEPORI_VARIATION
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Folded Up" = "clip_mediccap",
		"Folded Down" = "clip_mediccap_down"
		)

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
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Standard Issue" = "clip_x11",
		"Blank" = "clip_x11_blank",
		"White Stripe" = "clip_x11_stripe",
		"Olive" = "clip_x11_olive"
		)
	can_flashlight = TRUE
	supports_variations = VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/head/helmet/m10/clip
	name = "\improper Minutemen CM-10 Helmet"
	desc = "A cheap, but comfortable and light helmet painted in Minutemen colors, often seen in the hands of the reserves or Minutemen in the backline. Features a little attachment rail on the side where you can mount a flashlight."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'
	icon_state = "clip_m10"
	can_flashlight = TRUE
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Standard Issue" = "clip_m10",
		"Blank" = "clip_m10_blank",
		"Triple Column" = "clip_m10_triple",
		"Olive" = "clip_m10_olive"
		)
	can_flashlight = TRUE
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/m10/clip_vc
	name = "\improper Minutemen CM-12 Helmet"
	desc = "A special, lightweight and padded helmet issued to Vehicle Crewmen of the Minutemen. Features noise-reducing technology and a microphone that automatically connects with worn headsets. Hopefully protects you from bumpy rides."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'

	icon_state = "clip_m10_vc"
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Standard Issue" = "clip_m10_vc",
		"Arctic" = "clip_m10_vc_arctic",
		"Spearhead" = "clip_m10_vc_spearhead",
		"Olive" = "clip_m10_vc_olive"
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

	icon_state = "clip_m10_correspondant"
	item_state = "clip_m10_correspondant"
	can_flashlight = TRUE
	unique_reskin = null
	can_flashlight = TRUE
	supports_variations = VOX_VARIATION

/obj/item/clothing/head/helmet/riot/clip
	name = "\improper Minutemen CM-13 Riot Helmet"
	desc = "A sturdy blue helmet, made with crowd control in mind. The foldable protective visor makes it CLIP-BARD's preferred helmet against hostile xenofauna."
	icon = 'icons/obj/clothing/faction/clip/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'
	icon_state = "riot_clip"
	base_icon_state = "riot_clip"
	supports_variations = SNOUTED_VARIATION | VOX_VARIATION
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
		"Standard Issue" = "riot_clip",
		"Olive" = "riot_clip_olive"
		)
	can_flashlight = TRUE
	supports_variations = VOX_VARIATION

// CLIP-GOLD

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

//boots

//belt
/obj/item/storage/belt/military/clip
	name = "\improper Minutemen drop rig"
	desc = "This rig features many large pouches colored in Confederated League blue. The bulk of the pouches makes it only slightly uncomfortable to wear."

	icon = 'icons/obj/clothing/faction/clip/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/belt.dmi'
	vox_override_icon = 'icons/mob/clothing/faction/clip/vox.dmi'

	icon_state = "clipwebbing"
	item_state = "clipwebbing"
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
	"Suspenders Up" = "clipwebbing",
	"Suspenders Down" = "clipwebbing-belt"
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

	icon_state = "clipwebbing-belt"
	item_state = "clipwebbing-belt"

/obj/item/storage/belt/military/clip/chest
	name = "\improper Minutemen chest rig"
	desc = "An ultralight chest rig in Confederated League blue. The bulk of the pouches makes it only slightly uncomfortable to wear."

	icon_state = "clipwebbing-chest"
	item_state = "clipwebbing-chest"

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

/obj/item/clothing/accessory/clip_sweater
	name = "\improper CLIP commando sweater"
	desc = "A handknitted sweater delivered to the frontier as a part of the 'wool for warriors' program. Quality varies."
	icon_state = "clip_sweater_khaki"
	icon = 'icons/obj/clothing/faction/clip/accessory.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/clip/accessory.dmi'
	minimize_when_attached = FALSE
	obj_flags = INFINITE_RESKIN
	unique_reskin = list(
	"Khaki" = "clip_sweater_khaki",
	"Green" = "clip_sweater_green",
	"Blue" = "clip_sweater_blue",
	)
