/obj/item/bodypart/head/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_head"
	limb_id = "synth"
	dynamic_rename = FALSE
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
	dynamic_rename = FALSE
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
	dynamic_rename = FALSE
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
	dynamic_rename = FALSE
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
	dynamic_rename = FALSE
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
	dynamic_rename = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	light_brute_msg = "scratched"
	medium_brute_msg = "dented"
	heavy_brute_msg = "sheared"

	light_burn_msg = "burned"
	medium_burn_msg = "scorched"
	heavy_burn_msg = "seared"

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
	icon_state = "bshipc_head"
	limb_id = "bshipc"

/obj/item/bodypart/chest/ipc/bishop
	name = "\improper Bishop Cyberkinetics chest"
	icon_state = "bshipc_chest"
	limb_id = "bshipc"

/obj/item/bodypart/l_arm/ipc/bishop
	name = "\improper Bishop Cyberkinetics left arm"
	icon_state = "bshipc_l_arm"
	limb_id = "bshipc"

/obj/item/bodypart/r_arm/ipc/bishop
	name = "\improper Bishop Cyberkinetics right arm"
	icon_state = "bshipc_r_arm"
	limb_id = "bshipc"

/obj/item/bodypart/leg/left/ipc/bishop
	name = "\improper Bishop Cyberkinetics left leg"
	icon_state = "bshipc_l_leg"
	limb_id = "bshipc"

/obj/item/bodypart/leg/right/ipc/bishop
	name = "\improper Bishop Cyberkinetics right leg"
	icon_state = "bshipc_r_leg"
	limb_id = "bshipc"

// BISHOP CYBERKINETICS 2.0

/obj/item/bodypart/head/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 head"
	icon_state = "bs2ipc_head"
	limb_id = "bs2ipc"

/obj/item/bodypart/chest/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 chest"
	icon_state = "bs2ipc_chest"
	limb_id = "bs2ipc"

/obj/item/bodypart/l_arm/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 left arm"
	icon_state = "bs2ipc_l_arm"
	limb_id = "bs2ipc"

/obj/item/bodypart/r_arm/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 right arm"
	icon_state = "bs2ipc_r_arm"
	limb_id = "bs2ipc"

/obj/item/bodypart/leg/left/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 left leg"
	icon_state = "bs2ipc_l_leg"
	limb_id = "bs2ipc"

/obj/item/bodypart/leg/right/ipc/bishop_v2
	name = "\improper Bishop Cyberkinetics 2.0 right leg"
	icon_state = "bs2ipc_r_leg"
	limb_id = "bs2ipc"

// HEPHAESTUS INDUSTRIES

/obj/item/bodypart/head/ipc/hephaestus
	name = "\improper Hephaestus Industries head"
	icon_state = "hsiipc_head"
	limb_id = "hsiipc"

/obj/item/bodypart/chest/ipc/hephaestus
	name = "\improper Hephaestus Industries chest"
	icon_state = "hsiipc_chest"
	limb_id = "hsiipc"

/obj/item/bodypart/l_arm/ipc/hephaestus
	name = "\improper Hephaestus Industries left arm"
	icon_state = "hsiipc_l_arm"
	limb_id = "hsiipc"

/obj/item/bodypart/r_arm/ipc/hephaestus
	name = "\improper Hephaestus Industries right arm"
	icon_state = "hsiipc_r_arm"
	limb_id = "hsiipc"

/obj/item/bodypart/leg/left/ipc/hephaestus
	name = "\improper Hephaestus Industries left leg"
	icon_state = "hsiipc_l_leg"
	limb_id = "hsiipc"

/obj/item/bodypart/leg/right/ipc/hephaestus
	name = "\improper Hephaestus Industries right leg"
	icon_state = "hsiipc_r_leg"
	limb_id = "hsiipc"

// HEPHAESTUS INDUSTRIES 2.0

/obj/item/bodypart/head/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 head"
	icon_state = "hi2ipc_head"
	limb_id = "hi2ipc"

/obj/item/bodypart/chest/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 chest"
	icon_state = "hi2ipc_chest"
	limb_id = "hi2ipc"

/obj/item/bodypart/l_arm/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 left arm"
	icon_state = "hi2ipc_l_arm"
	limb_id = "hi2ipc"

/obj/item/bodypart/r_arm/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 right arm"
	icon_state = "hi2ipc_r_arm"
	limb_id = "hi2ipc"

/obj/item/bodypart/leg/left/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 left leg"
	icon_state = "hi2ipc_l_leg"
	limb_id = "hi2ipc"

/obj/item/bodypart/leg/right/ipc/hephaestus_v2
	name = "\improper Hephaestus Industries 2.0 right leg"
	icon_state = "hi2ipc_r_leg"
	limb_id = "hi2ipc"

// PAWSITRONS UNITED

/obj/item/bodypart/head/ipc/pawsitrons
	name = "\improper Pawsitrons United head"
	icon_state = "pawsitrons_head"
	limb_id = "pawsitrons"

/obj/item/bodypart/chest/ipc/pawsitrons
	name = "\improper Pawsitrons United chest"
	icon_state = "pawsitrons_chest"
	limb_id = "pawsitrons"

/obj/item/bodypart/l_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United left arm"
	icon_state = "pawsitrons_l_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/r_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United right arm"
	icon_state = "pawsitrons_r_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/left/ipc/pawsitrons
	name = "\improper Pawsitrons United left leg"
	icon_state = "pawsitrons_l_leg"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/right/ipc/pawsitrons
	name = "\improper Pawsitrons United right leg"
	icon_state = "pawsitrons_r_leg"
	limb_id = "pawsitrons"

// SHELLGUARD MUNITIONS

/obj/item/bodypart/head/ipc/shellguard
	name = "\improper Shellguard Munitions head"
	icon_state = "sgmipc_head"
	limb_id = "sgmipc"

/obj/item/bodypart/chest/ipc/shellguard
	name = "\improper Shellguard Munitions chest"
	icon_state = "sgmipc_chest"
	limb_id = "sgmipc"

/obj/item/bodypart/l_arm/ipc/shellguard
	name = "\improper Shellguard Munitions left arm"
	icon_state = "sgmipc_l_arm"
	limb_id = "sgmipc"

/obj/item/bodypart/r_arm/ipc/shellguard
	name = "\improper Shellguard Munitions right arm"
	icon_state = "sgmipc_r_arm"
	limb_id = "sgmipc"

/obj/item/bodypart/leg/left/ipc/shellguard
	name = "\improper Shellguard Munitions left leg"
	icon_state = "sgmipc_l_leg"
	limb_id = "sgmipc"

/obj/item/bodypart/leg/right/ipc/shellguard
	name = "\improper Shellguard Munitions right leg"
	icon_state = "sgmipc_r_leg"
	limb_id = "sgmipc"


// WARD-TAKAHASHI MANUFACTURING

/obj/item/bodypart/head/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing head"
	icon_state = "wtmipc_head"
	limb_id = "wtmipc"

/obj/item/bodypart/chest/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing chest"
	icon_state = "wtmipc_chest"
	limb_id = "wtmipc"

/obj/item/bodypart/l_arm/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing left arm"
	icon_state = "wtmipc_l_arm"
	limb_id = "wtmipc"

/obj/item/bodypart/r_arm/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing right arm"
	icon_state = "wtmipc_r_arm"
	limb_id = "wtmipc"

/obj/item/bodypart/leg/left/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing left leg"
	icon_state = "wtmipc_l_leg"
	limb_id = "wtmipc"

/obj/item/bodypart/leg/right/ipc/ward_takahashi
	name = "\improper Ward-Takahashi Manufacturing right leg"
	icon_state = "wtmipc_r_leg"
	limb_id = "wtmipc"

// XION MANUFACTURING GROUP

/obj/item/bodypart/head/ipc/xion
	name = "\improper Xion Manufacturing Group head"
	icon_state = "xmgipc_head"
	limb_id = "xmgipc"

/obj/item/bodypart/chest/ipc/xion
	name = "\improper Xion Manufacturing Group chest"
	icon_state = "xmgipc_chest"
	limb_id = "xmgipc"

/obj/item/bodypart/l_arm/ipc/xion
	name = "\improper Xion Manufacturing Group left arm"
	icon_state = "xmgipc_l_arm"
	limb_id = "xmgipc"

/obj/item/bodypart/r_arm/ipc/xion
	name = "\improper Xion Manufacturing Group right arm"
	icon_state = "xmgipc_r_arm"
	limb_id = "xmgipc"

/obj/item/bodypart/leg/left/ipc/xion
	name = "\improper Xion Manufacturing Group left leg"
	icon_state = "xmgipc_l_leg"
	limb_id = "xmgipc"

/obj/item/bodypart/leg/right/ipc/xion
	name = "\improper Xion Manufacturing Group right leg"
	icon_state = "xmgipc_r_leg"
	limb_id = "xmgipc"

// XION MANUFACTURING GROUP 2.0

/obj/item/bodypart/head/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 head"
	icon_state = "xm2ipc_head"
	limb_id = "xm2ipc"

/obj/item/bodypart/chest/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 chest"
	icon_state = "xm2ipc_chest"
	limb_id = "xm2ipc"

/obj/item/bodypart/l_arm/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 left arm"
	icon_state = "xm2ipc_l_arm"
	limb_id = "xm2ipc"

/obj/item/bodypart/r_arm/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 right arm"
	icon_state = "xm2ipc_r_arm"
	limb_id = "xm2ipc"

/obj/item/bodypart/leg/left/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 left leg"
	icon_state = "xm2ipc_l_leg"
	limb_id = "xm2ipc"

/obj/item/bodypart/leg/right/ipc/xion_v2
	name = "\improper Xion Manufacturing Group 2.0 right leg"
	icon_state = "xm2ipc_r_leg"
	limb_id = "xm2ipc"

// ZENG-HU PHARMACEUTICALS

/obj/item/bodypart/head/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals head"
	icon_state = "zhpipc_head"
	limb_id = "zhpipc"

/obj/item/bodypart/chest/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals chest"
	icon_state = "zhpipc_chest"
	limb_id = "zhpipc"

/obj/item/bodypart/l_arm/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals left arm"
	icon_state = "zhpipc_l_arm"
	limb_id = "zhpipc"

/obj/item/bodypart/r_arm/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals right arm"
	icon_state = "zhpipc_r_arm"
	limb_id = "zhpipc"

/obj/item/bodypart/leg/left/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals left leg"
	icon_state = "zhpipc_l_leg"
	limb_id = "zhpipc"

/obj/item/bodypart/leg/right/ipc/zeng_hu
	name = "\improper Zeng-Hu Pharmaceuticals right leg"
	icon_state = "zhpipc_r_leg"
	limb_id = "zhpipc"

// PGF MECHANICS TYPE-P

/obj/item/bodypart/head/ipc/pgf
	name = "\improper PGF Mechanics head"
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
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/pgf
	name = "\improper PGF Mechanics left arm"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/pgf
	name = "\improper PGF Mechanics right arm"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/pgf
	name = "\improper PGF Mechanics Type-P left leg"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/pgf
	name = "\improper PGF Mechanics Type-P right leg"
	icon_state = "pgfipc-p_r_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

// PGF MECHANICS TYPE-D

/obj/item/bodypart/leg/left/ipc/pgf/type_d
	name = "\improper PGF Mechanics Type-D left leg"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf/type_d
	name = "\improper PGF Mechanics Type-D right leg"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

// INTEQ SPRINTER

/obj/item/bodypart/head/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' Type-1 head"
	icon_state = "inteqsprinter_head"
	limb_id = "inteqsprinter"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' chest"
	icon_state = "inteqsprinter_chest"
	limb_id = "inteqsprinter"

/obj/item/bodypart/l_arm/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' left arm"
	icon_state = "inteqsprinter_l_arm"
	limb_id = "inteqsprinter"

/obj/item/bodypart/r_arm/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' right arm"
	icon_state = "inteqsprinter_r_arm"
	limb_id = "inteqsprinter"

/obj/item/bodypart/leg/left/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' left leg"
	icon_state = "inteqsprinter_l_leg"
	limb_id = "inteqsprinter"

/obj/item/bodypart/leg/right/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' right leg"
	icon_state = "inteqsprinter_r_leg"
	limb_id = "inteqsprinter"

// INTEQ SPRINTER TYPE 2

/obj/item/bodypart/head/ipc/sprinter/type_2
	name = "\improper Inteq Mothership 'Sprinter' Type-2 head"
	icon_state = "inteqsprinter2_head"
	limb_id = "inteqsprinter2"

// MAXIM SEEKER

/obj/item/bodypart/head/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' head"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' chest"
	icon_state = "seekeripc_chest"
	limb_id = "seekeripc"

/obj/item/bodypart/l_arm/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' left arm"
	icon_state = "seekeripc_l_arm"
	limb_id = "seekeripc"

/obj/item/bodypart/r_arm/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' right arm"
	icon_state = "seekeripc_r_arm"
	limb_id = "seekeripc"

/obj/item/bodypart/leg/left/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' left leg"
	icon_state = "seekeripc_l_leg"
	limb_id = "seekeripc"

/obj/item/bodypart/leg/right/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' right leg"
	icon_state = "seekeripc_r_leg"
	limb_id = "seekeripc"

// ABSOLUTION-LUX SOLFERINO

/obj/item/bodypart/head/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' head"
	icon_state = "ablux_head"
	limb_id = "ablux"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' chest"
	icon_state = "ablux_chest"
	limb_id = "ablux"

/obj/item/bodypart/l_arm/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' left arm"
	icon_state = "ablux_l_arm"
	limb_id = "ablux"

/obj/item/bodypart/r_arm/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' right arm"
	icon_state = "ablux_r_arm"
	limb_id = "ablux"

/obj/item/bodypart/leg/left/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' left leg"
	icon_state = "ablux_l_leg"
	limb_id = "ablux"

/obj/item/bodypart/leg/right/ipc/solferino
	name = "\improper Absolution-Lux 'Solferino' right leg"
	icon_state = "ablux_r_leg"
	limb_id = "ablux"

// CLOVER HUMANIFORM

/obj/item/bodypart/head/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' head"
	icon_state = "humanipc_head"
	limb_id = "humanipc"
	draw_eyes = TRUE
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/chest/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' chest"
	icon_state = "humanipc_chest"
	limb_id = "humanipc"

/obj/item/bodypart/l_arm/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' left arm"
	icon_state = "humanipc_l_arm"
	limb_id = "humanipc"

/obj/item/bodypart/r_arm/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' right arm"
	icon_state = "humanipc_r_arm"
	limb_id = "humanipc"

/obj/item/bodypart/leg/left/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' left leg"
	icon_state = "humanipc_l_leg"
	limb_id = "humanipc"

/obj/item/bodypart/leg/right/ipc/humaniform
	name = "\improper Clover Corporation 'Humaniform' right leg"
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
