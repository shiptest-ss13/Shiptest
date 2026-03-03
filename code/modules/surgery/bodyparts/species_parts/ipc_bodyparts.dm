/obj/item/bodypart/head/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_head"
	limb_id = "synth"
	draw_eyes = FALSE
	var/has_screen = TRUE
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD
	biological_state = BIO_ROBOTIC

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/chest/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_chest"
	limb_id = "synth"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = BIO_ROBOTIC

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/l_arm/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_l_arm"
	limb_id = "synth"
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/r_arm/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_r_arm"
	limb_id = "synth"
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/leg/left/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_l_leg"
	limb_id = "synth"
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/leg/right/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_r_leg"
	limb_id = "synth"
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

/obj/item/bodypart/tail/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	name = "robot tail"
	desc = "Do robots even need these?"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/tail/ipc/plug
	name = "power cord tail"
	desc = "A long power cord connected to nothing."
	icon_state = "plug_tail"
	limb_id = "plug"
	examine_id = "power cord"
	uses_mutcolor = TRUE
	overlay_icon_state = TRUE
	can_wag = FALSE

/obj/item/bodypart/tail/ipc/fox
	name = "synthetic fox tail"
	desc = "At least, you hope it's synthetic."
	icon_state = "fox_tail"
	limb_id = "fox"
	examine_id = "synthetic fox"
	can_wag = FALSE

/obj/item/bodypart/tail/ipc/fox/alt
	name = "synthetic fox tail (alt)"
	icon_state = "fox2_tail"
	limb_id = "fox2"
	can_wag = FALSE

/obj/item/bodypart/tail/ipc/cat
	name = "synthetic cat tail"
	desc = "At least, you hope it's synthetic."
	icon_state = "cat_tail"
	limb_id = "cat"
	examine_id = "synthetic cat"
	can_wag = FALSE

// MORPHEUS CYBERKINETICS

/obj/item/bodypart/head/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics head"
	icon_state = "mcgipc_head"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

/obj/item/bodypart/chest/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics chest"
	icon_state = "mcgipc_chest"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

/obj/item/bodypart/l_arm/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics left arm"
	icon_state = "mcgipc_l_arm"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

/obj/item/bodypart/r_arm/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics right arm"
	icon_state = "mcgipc_r_arm"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

/obj/item/bodypart/leg/left/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics left leg"
	icon_state = "mcgipc_l_leg"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

/obj/item/bodypart/leg/right/ipc/morpheus
	name = "\improper Morpheus Cyberkinetics right leg"
	icon_state = "mcgipc_r_leg"
	limb_id = "mcgipc"
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE

// BISHOP CYBERKINETICS

/obj/item/bodypart/head/ipc/bishop
	name = "\improper Bishop Cyberkinetics head"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_head"
	limb_id = "bshipc"

/obj/item/bodypart/chest/ipc/bishop
	name = "\improper Bishop Cyberkinetics chest"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_chest"
	limb_id = "bshipc"

/obj/item/bodypart/l_arm/ipc/bishop
	name = "\improper Bishop Cyberkinetics left arm"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_l_arm"
	limb_id = "bshipc"

/obj/item/bodypart/r_arm/ipc/bishop
	name = "\improper Bishop Cyberkinetics right arm"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_r_arm"
	limb_id = "bshipc"

/obj/item/bodypart/leg/left/ipc/bishop
	name = "\improper Bishop Cyberkinetics left leg"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_l_leg"
	limb_id = "bshipc"

/obj/item/bodypart/leg/right/ipc/bishop
	name = "\improper Bishop Cyberkinetics right leg"
	examine_id = "\improper Bishop Cyberkinetics"
	icon_state = "bshipc_r_leg"
	limb_id = "bshipc"

// BISHOP CYBERKINETICS 2.0

/obj/item/bodypart/head/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 head"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_head"
	limb_id = "bs2ipc"

/obj/item/bodypart/chest/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 chest"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_chest"
	limb_id = "bs2ipc"

/obj/item/bodypart/l_arm/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 left arm"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_l_arm"
	limb_id = "bs2ipc"

/obj/item/bodypart/r_arm/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 right arm"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_r_arm"
	limb_id = "bs2ipc"

/obj/item/bodypart/leg/left/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 left leg"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_l_leg"
	limb_id = "bs2ipc"

/obj/item/bodypart/leg/right/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 right leg"
	examine_id = "\improper Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc_r_leg"
	limb_id = "bs2ipc"

// HEPHAESTUS INDUSTRIES

/obj/item/bodypart/head/ipc/hephaestus
	name = "\improper Hephaestus Industries head"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_head"
	limb_id = "hsiipc"

/obj/item/bodypart/chest/ipc/hephaestus
	name = "\improper Hephaestus Industries chest"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_chest"
	limb_id = "hsiipc"

/obj/item/bodypart/l_arm/ipc/hephaestus
	name = "\improper Hephaestus Industries left arm"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_l_arm"
	limb_id = "hsiipc"

/obj/item/bodypart/r_arm/ipc/hephaestus
	name = "\improper Hephaestus Industries right arm"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_r_arm"
	limb_id = "hsiipc"

/obj/item/bodypart/leg/left/ipc/hephaestus
	name = "\improper Hephaestus Industries left leg"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_l_leg"
	limb_id = "hsiipc"

/obj/item/bodypart/leg/right/ipc/hephaestus
	name = "\improper Hephaestus Industries right leg"
	examine_id = "\improper Hephaestus Industries"
	icon_state = "hsiipc_r_leg"
	limb_id = "hsiipc"

// HEPHAESTUS INDUSTRIES 2.0

/obj/item/bodypart/head/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 head"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_head"
	limb_id = "hi2ipc"

/obj/item/bodypart/chest/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 chest"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_chest"
	limb_id = "hi2ipc"

/obj/item/bodypart/l_arm/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 left arm"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_l_arm"
	limb_id = "hi2ipc"

/obj/item/bodypart/r_arm/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 right arm"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_r_arm"
	limb_id = "hi2ipc"

/obj/item/bodypart/leg/left/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 left leg"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_l_leg"
	limb_id = "hi2ipc"

/obj/item/bodypart/leg/right/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 right leg"
	examine_id = "\improper Hephaestus Industries 2.0"
	icon_state = "hi2ipc_r_leg"
	limb_id = "hi2ipc"

// PAWSITRONS UNITED

/obj/item/bodypart/head/ipc/pawsitrons
	name = "\improper Pawsitrons United head"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_head"
	limb_id = "pawsitrons"

/obj/item/bodypart/chest/ipc/pawsitrons
	name = "\improper Pawsitrons United chest"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_chest"
	limb_id = "pawsitrons"

/obj/item/bodypart/l_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United left arm"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_l_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/r_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United right arm"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_r_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/left/ipc/pawsitrons
	name = "\improper Pawsitrons United left leg"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_l_leg"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/right/ipc/pawsitrons
	name = "\improper Pawsitrons United right leg"
	examine_id = "\improper Pawsitrons United"
	icon_state = "pawsitrons_r_leg"
	limb_id = "pawsitrons"

// SHELLGUARD MUNITIONS

/obj/item/bodypart/head/ipc/shellguard
	name = "\improper Shellguard Munitions head"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_head"
	limb_id = "sgmipc"

/obj/item/bodypart/chest/ipc/shellguard
	name = "\improper Shellguard Munitions chest"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_chest"
	limb_id = "sgmipc"

/obj/item/bodypart/l_arm/ipc/shellguard
	name = "\improper Shellguard Munitions left arm"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_l_arm"
	limb_id = "sgmipc"

/obj/item/bodypart/r_arm/ipc/shellguard
	name = "\improper Shellguard Munitions right arm"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_r_arm"
	limb_id = "sgmipc"

/obj/item/bodypart/leg/left/ipc/shellguard
	name = "\improper Shellguard Munitions left leg"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_l_leg"
	limb_id = "sgmipc"

/obj/item/bodypart/leg/right/ipc/shellguard
	name = "\improper Shellguard Munitions right leg"
	examine_id = "\improper Shellguard Munitions"
	icon_state = "sgmipc_r_leg"
	limb_id = "sgmipc"


// WARD-TAKAHASHI MANUFACTURING

/obj/item/bodypart/head/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing head"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_head"
	limb_id = "wtmipc"

/obj/item/bodypart/chest/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing chest"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_chest"
	limb_id = "wtmipc"

/obj/item/bodypart/l_arm/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing left arm"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_l_arm"
	limb_id = "wtmipc"

/obj/item/bodypart/r_arm/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing right arm"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_r_arm"
	limb_id = "wtmipc"

/obj/item/bodypart/leg/left/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing left leg"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_l_leg"
	limb_id = "wtmipc"

/obj/item/bodypart/leg/right/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing right leg"
	examine_id = "\improper Ward-Takahashi Manufacturing"
	icon_state = "wtmipc_r_leg"
	limb_id = "wtmipc"

// XION MANUFACTURING GROUP

/obj/item/bodypart/head/ipc/xion
	name = "\improper Xion Manufacturing Group head"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_head"
	limb_id = "xmgipc"

/obj/item/bodypart/chest/ipc/xion
	name = "\improper Xion Manufacturing Group chest"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_chest"
	limb_id = "xmgipc"

/obj/item/bodypart/l_arm/ipc/xion
	name = "\improper Xion Manufacturing Group left arm"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_l_arm"
	limb_id = "xmgipc"

/obj/item/bodypart/r_arm/ipc/xion
	name = "\improper Xion Manufacturing Group right arm"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_r_arm"
	limb_id = "xmgipc"

/obj/item/bodypart/leg/left/ipc/xion
	name = "\improper Xion Manufacturing Group left leg"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_l_leg"
	limb_id = "xmgipc"

/obj/item/bodypart/leg/right/ipc/xion
	name = "\improper Xion Manufacturing Group right leg"
	examine_id = "\improper Xion Manufacturing Group"
	icon_state = "xmgipc_r_leg"
	limb_id = "xmgipc"

// XION MANUFACTURING GROUP 2.0

/obj/item/bodypart/head/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 head"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_head"
	limb_id = "xm2ipc"

/obj/item/bodypart/chest/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 chest"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_chest"
	limb_id = "xm2ipc"

/obj/item/bodypart/l_arm/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 left arm"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_l_arm"
	limb_id = "xm2ipc"

/obj/item/bodypart/r_arm/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 right arm"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_r_arm"
	limb_id = "xm2ipc"

/obj/item/bodypart/leg/left/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 left leg"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_l_leg"
	limb_id = "xm2ipc"

/obj/item/bodypart/leg/right/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 right leg"
	examine_id = "\improper Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc_r_leg"
	limb_id = "xm2ipc"

// ZENG-HU PHARMACEUTICALS

/obj/item/bodypart/head/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals head"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_head"
	limb_id = "zhpipc"

/obj/item/bodypart/chest/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals chest"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_chest"
	limb_id = "zhpipc"

/obj/item/bodypart/l_arm/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals left arm"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_l_arm"
	limb_id = "zhpipc"

/obj/item/bodypart/r_arm/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals right arm"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_r_arm"
	limb_id = "zhpipc"

/obj/item/bodypart/leg/left/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals left leg"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_l_leg"
	limb_id = "zhpipc"

/obj/item/bodypart/leg/right/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals right leg"
	examine_id = "\improper Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc_r_leg"
	limb_id = "zhpipc"

// PGF MECHANICS TYPE-P

/obj/item/bodypart/head/ipc/pgf
	name = "\improper PGF Mechanics head"
	examine_id = "\improper PGF Mechanics"
	icon_state = "pgfipc-p_head"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE
	has_screen = FALSE
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/pgf
	name = "\improper PGF Mechanics chest"
	examine_id = "\improper PGF Mechanics"
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/pgf
	name = "\improper PGF Mechanics left arm"
	examine_id = "\improper PGF Mechanics"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/pgf
	name = "\improper PGF Mechanics right arm"
	examine_id = "\improper PGF Mechanics"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/pgf
	name = "\improper PGF Mechanics Type-P left leg"
	examine_id = "\improper PGF Mechanics Type-P"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/pgf
	name = "\improper PGF Mechanics Type-P right leg"
	examine_id = "\improper PGF Mechanics Type-P"
	icon_state = "pgfipc-p_r_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/tail/ipc/pgf
	name = "\improper PGF Mechanics robotic tail"
	examine_id = "\improper PGF Mechanics robotic"
	icon_state = "synth_tail"
	limb_id = "synth"
	max_damage = 30
	max_stamina_damage = 30
	body_damage_coeff = 0.6
	body_weight = 8
	uses_mutcolor = TRUE
	overlay_icon_state = TRUE
	can_wag = FALSE
	can_thump = TRUE

/obj/item/bodypart/tail/ipc/pgf/large
	name = "\improper PGF Mechanics large robotic tail"
	examine_id = "\improper PGF Mechanics large robotic"
	icon_state = "large_synth_tail"
	limb_id = "large_synth"
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	body_weight = 16
	can_wag = TRUE // only one with a sprite for it

// PGF MECHANICS TYPE-D

/obj/item/bodypart/leg/left/ipc/pgf/type_d
	name = "\improper PGF Mechanics Type-D left leg"
	examine_id = "\improper PGF Mechanics Type-D"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf/type_d
	name = "\improper PGF Mechanics Type-D right leg"
	examine_id = "\improper PGF Mechanics Type-D"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

// INTEQ SPRINTER

/obj/item/bodypart/head/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' Type-1 head"
	examine_id = "\improper Inteq Mothership 'Sprinter' Type-1"
	icon_state = "inteqsprinter_head"
	limb_id = "inteqsprinter"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' chest"
	examine_id = "\improper Inteq Mothership 'Sprinter'"
	icon_state = "inteqsprinter_chest"
	limb_id = "inteqsprinter"

/obj/item/bodypart/l_arm/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' left arm"
	examine_id = "\improper Inteq Mothership 'Sprinter'"
	icon_state = "inteqsprinter_l_arm"
	limb_id = "inteqsprinter"

/obj/item/bodypart/r_arm/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' right arm"
	examine_id = "\improper Inteq Mothership 'Sprinter'"
	icon_state = "inteqsprinter_r_arm"
	limb_id = "inteqsprinter"

/obj/item/bodypart/leg/left/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' left leg"
	examine_id = "\improper Inteq Mothership 'Sprinter'"
	icon_state = "inteqsprinter_l_leg"
	limb_id = "inteqsprinter"

/obj/item/bodypart/leg/right/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' right leg"
	examine_id = "\improper Inteq Mothership 'Sprinter'"
	icon_state = "inteqsprinter_r_leg"
	limb_id = "inteqsprinter"

// INTEQ SPRINTER TYPE 2

/obj/item/bodypart/head/ipc/sprinter/type_2
	name = "\improper Inteq Mothership 'Sprinter' Type-2 head"
	examine_id = "\improper Inteq Mothership 'Sprinter' Type-2"
	icon_state = "inteqsprinter2_head"
	limb_id = "inteqsprinter2"

// MAXIM SEEKER

/obj/item/bodypart/head/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' head"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' chest"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_chest"
	limb_id = "seekeripc"

/obj/item/bodypart/l_arm/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' left arm"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_l_arm"
	limb_id = "seekeripc"

/obj/item/bodypart/r_arm/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' right arm"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_r_arm"
	limb_id = "seekeripc"

/obj/item/bodypart/leg/left/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' left leg"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_l_leg"
	limb_id = "seekeripc"

/obj/item/bodypart/leg/right/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' right leg"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_r_leg"
	limb_id = "seekeripc"

// ABSOLUTION-LUX SOLFERINO

/obj/item/bodypart/head/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' head"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_head"
	limb_id = "ablux"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' chest"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_chest"
	limb_id = "ablux"

/obj/item/bodypart/l_arm/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' left arm"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_l_arm"
	limb_id = "ablux"

/obj/item/bodypart/r_arm/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' right arm"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_r_arm"
	limb_id = "ablux"

/obj/item/bodypart/leg/left/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' left leg"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_l_leg"
	limb_id = "ablux"

/obj/item/bodypart/leg/right/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' right leg"
	examine_id = "\improper Absolution-Lux 'Solferino'"
	icon_state = "ablux_r_leg"
	limb_id = "ablux"

// CLOVER HUMANIFORM

/obj/item/bodypart/head/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' head"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_head"
	limb_id = "humanipc"
	draw_eyes = TRUE
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' chest"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_chest"
	limb_id = "humanipc"

/obj/item/bodypart/l_arm/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' left arm"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_l_arm"
	limb_id = "humanipc"

/obj/item/bodypart/r_arm/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' right arm"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_r_arm"
	limb_id = "humanipc"

/obj/item/bodypart/leg/left/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' left leg"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_l_leg"
	limb_id = "humanipc"

/obj/item/bodypart/leg/right/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' right leg"
	examine_id = "\improper Clover Corporation 'Humaniform'"
	icon_state = "humanipc_r_leg"
	limb_id = "humanipc"

// CYBERSUN GHOST

/obj/item/bodypart/head/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' head"
	icon_state = "cyber_head"
	limb_id = "cyber"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' chest"
	icon_state = "cyber_chest"
	limb_id = "cyber"

/obj/item/bodypart/l_arm/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' left arm"
	icon_state = "cyber_l_arm"
	limb_id = "cyber"

/obj/item/bodypart/r_arm/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' right arm"
	icon_state = "cyber_r_arm"
	limb_id = "cyber"

/obj/item/bodypart/leg/left/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' left leg"
	icon_state = "cyber_l_leg"
	limb_id = "cyber"

/obj/item/bodypart/leg/right/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' right leg"
	icon_state = "cyber_r_leg"
	limb_id = "cyber"
