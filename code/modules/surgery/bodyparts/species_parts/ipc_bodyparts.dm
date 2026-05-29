/obj/item/bodypart/head/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_head"
	limb_id = "synth"
	draw_eyes = FALSE
	draw_sclera = FALSE
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
	limb_id = "plug"
	name = "robot tail"
	desc = "Do robots even need these?"
	sturdy = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	biological_state = BIO_ROBOTIC

/obj/item/bodypart/tail/ipc/plug
	name = "power cord tail"
	desc = "A long power cord connected to nothing."
	icon_state = "plug_tail"
	limb_id = "plug"
	examine_id = "power cord"
	uses_mutcolor = TRUE
	overlay_icon_state = TRUE
	can_wag = FALSE

/obj/item/bodypart/tail/ipc/plug/secondary_color
	overlay_use_primary_color = TRUE
	draw_color_use_secondary = TRUE

/obj/item/bodypart/tail/ipc/fox
	name = "synthetic fox tail"
	desc = "At least, you hope it's synthetic."
	icon_state = "fox_tail"
	limb_id = "fox"
	examine_id = "synthetic fox"
	uses_mutcolor = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_HAIR
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
	uses_mutcolor = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_HAIR
	can_wag = FALSE

// PAWSITRONS UNITED

/obj/item/bodypart/head/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 head"
	examine_id = "\improper Pawsitrons United N1"
	icon_state = "pawsitrons_head"
	limb_id = "pawsitrons"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 chest"
	examine_id = "\improper Pawsitrons United N1"
	icon_state = "pawsitrons_chest"
	limb_id = "pawsitrons"

/obj/item/bodypart/l_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 left arm"
	examine_id = "\improper Pawsitrons United N1"
	icon_state = "pawsitrons_l_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/r_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 right arm"
	examine_id = "\improper Pawsitrons United N1"
	icon_state = "pawsitrons_r_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/left/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 left leg"
	examine_id = "\improper Pawsitrons United N1"
	icon_state = "pawsitrons_l_leg"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/right/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 right leg"
	icon_state = "pawsitrons_r_leg"
	limb_id = "pawsitrons"

//Makosso-Warra MW-HIAU (high-inteligence-automated-unit)

//Makosso-Warra MW-PMU

/obj/item/bodypart/head/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU head"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_head"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU chest"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_chest"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left arm"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_l_arm"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right arm"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_r_arm"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left leg"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_l_leg_digitigrade"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right leg"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_r_leg_digitigrade"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Makosso-Warra MW-PMU (Custom Visor Color)

/obj/item/bodypart/head/ipc/mwpmu_visor_color
	name = "\improper Makosso-Warra MW-PMU head"
	examine_id = "\improper Makosso-Warra MW-PMU"
	icon_state = "mwpmu_head"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

//Makosso-Warra MW-HIACU (MW)

/obj/item/bodypart/head/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU head"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_head"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU chest"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_chest"
	limb_id = "mwhiacu"

/obj/item/bodypart/l_arm/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU left arm"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_l_arm"
	limb_id = "mwhiacu"

/obj/item/bodypart/r_arm/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU right arm"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_r_arm"
	limb_id = "mwhiacu"

/obj/item/bodypart/leg/left/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU left leg"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_l_leg_digitigrade"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU right leg"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_r_leg_digitigrade"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Makosso-Warra MW-HIACU (VI)
//since the only difference is the literal color, they share names

/obj/item/bodypart/head/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU head"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_head"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU chest"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_chest"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/l_arm/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU left arm"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_l_arm"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/r_arm/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU right arm"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_r_arm"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/leg/left/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU left leg"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_l_leg_digitigrade"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU right leg"
	examine_id = "\improper Makosso-Warra MW-HIACU"
	icon_state = "mwhiacu_vi_r_leg_digitigrade"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Atua Synkinetics Parça

/obj/item/bodypart/head/ipc/atua
	name = "\improper Atua Synkinetics Parça head"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_head"
	limb_id = "atua"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/atua
	name = "\improper Atua Synkinetics Parça chest"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_chest"
	limb_id = "atua"

/obj/item/bodypart/l_arm/ipc/atua
	name = "\improper Atua Synkinetics Parça left arm"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_l_arm"
	limb_id = "atua"

/obj/item/bodypart/r_arm/ipc/atua
	name = "\improper Atua Synkinetics Parça right arm"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_r_arm"
	limb_id = "atua"

/obj/item/bodypart/leg/left/ipc/atua
	name = "\improper Atua Synkinetics Parça left leg"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_l_leg"
	limb_id = "atua"

/obj/item/bodypart/leg/right/ipc/atua
	name = "\improper Atua Synkinetics Parça right leg"
	examine_id = "\improper Atua Synkinetics Parça"
	icon_state = "atua_r_leg"
	limb_id = "atua"

// Scarborgh Arms IPC-73

/obj/item/bodypart/head/ipc/saipc
	name = "\improper Scarborough Arms IPC-73 head"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_head"
	limb_id = "saipc"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	eye_state_override = "eyes_mono"

/obj/item/bodypart/chest/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 chest"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_chest"
	limb_id = "saipc"

/obj/item/bodypart/l_arm/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 left arm"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_l_arm"
	limb_id = "saipc"

/obj/item/bodypart/r_arm/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 right arm"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_r_arm"
	limb_id = "saipc"

/obj/item/bodypart/leg/left/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 left leg"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_l_leg"
	limb_id = "saipc"

/obj/item/bodypart/leg/right/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 right leg"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_r_leg"
	limb_id = "saipc"

/obj/item/bodypart/head/ipc/saipc_boxhead
	name = "\improper Scarborgh Arms IPC-73 Type-2 boxhead"
	examine_id = "\improper Scarborough Arms IPC-73"
	icon_state = "saipc_alt_head"
	limb_id = "saipc_alt"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

// Scarborgh Arms IPC-80 MK.2

/obj/item/bodypart/head/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 head"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_head"
	limb_id = "saipc2"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	eye_state_override = "eyes_mono"

/obj/item/bodypart/chest/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 chest"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_chest"
	limb_id = "saipc2"

/obj/item/bodypart/l_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left arm"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_l_arm"
	limb_id = "saipc2"

/obj/item/bodypart/r_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right arm"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_r_arm"
	limb_id = "saipc2"

/obj/item/bodypart/leg/left/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left leg"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_l_leg"
	limb_id = "saipc2"

/obj/item/bodypart/leg/right/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right leg"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_r_leg"
	limb_id = "saipc2"

/obj/item/bodypart/leg/left/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left leg"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_l_leg"
	limb_id = "saipc2"

/obj/item/bodypart/leg/right/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right leg"
	examine_id = "\improper Scarborgh Arms IPC-80 MK.2"
	icon_state = "saipc2_r_leg"
	limb_id = "saipc2"

// Lanchester Mechanics 'HEAVY DUTY FRAME'

/obj/item/bodypart/head/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' head"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_head"
	limb_id = "lanchesterheavy"
	draw_eyes = TRUE
	eye_state_override = "eyes_circle"

/obj/item/bodypart/chest/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' chest"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_chest"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/l_arm/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' left arm"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_l_arm"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/r_arm/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' right arm"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_r_arm"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/leg/left/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' left leg"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_l_leg"
	limb_id = "lanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' right leg"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_r_leg"
	limb_id = "lanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/head/ipc/lanchesterheavy_boxhead
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' head"
	examine_id = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME'"
	icon_state = "lanchesterheavy_alt_head"
	limb_id = "lanchesterheavy_alt"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

// HARDLINE 'Longshore'

/obj/item/bodypart/head/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' head"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_head"
	limb_id = "lanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' chest"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_chest"
	limb_id = "lanchesterworker"

/obj/item/bodypart/l_arm/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' left arm"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_l_arm"
	limb_id = "lanchesterworker"

/obj/item/bodypart/r_arm/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' right arm"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_r_arm"
	limb_id = "lanchesterworker"

/obj/item/bodypart/leg/left/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' left leg"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_l_leg"
	limb_id = "lanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' right leg"
	examine_id = "\improper HARDLINE 'Longshore'"
	icon_state = "lanchesterworker_r_leg"
	limb_id = "lanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

// Custom Unplated

/obj/item/bodypart/head/ipc/lanchesterunplated
	name = "\improper Custom Unplated head"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_head"
	limb_id = "lanchesterunplated"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/lanchesterunplated
	name = "\improper Custom Unplated chest"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_chest"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/l_arm/ipc/lanchesterunplated
	name = "\improper Custom Unplated left arm"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_l_arm"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/r_arm/ipc/lanchesterunplated
	name = "\improper Custom Unplated right arm"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_r_arm"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/leg/left/ipc/lanchesterunplated
	name = "\improper Custom Unplated left leg"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_l_leg"
	limb_id = "lanchesterunplated"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterunplated
	name = "\improper Custom Unplated right leg"
	examine_id = "\improper Custom Unplated"
	icon_state = "lanchesterunplated_r_leg"
	limb_id = "lanchesterunplated"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

// PGF Mechanics MK.III Type 'Suhols-Ro'

/obj/item/bodypart/head/ipc/pgfmk3_suhols
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' head"
	examine_id = "\improper PGF Mechanics MK.III Type 'Suhols-Ro'"
	icon_state = "pgfmk3_suhols_head"
	limb_id = "pgfmk3_suhols"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	eye_state_override = "eyes_elzu"

/obj/item/bodypart/chest/ipc/pgfmk3_suhols
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' chest"
	examine_id = "\improper PGF Mechanics MK.III Type 'Suhols-Ro'"
	icon_state = "pgfmk3_suhols_chest"
	limb_id = "pgfmk3_suhols"

/obj/item/bodypart/head/ipc/pgfmk3_suhols_boxhead
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' aftermarket boxhead"
	examine_id = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' aftermarket box"
	icon_state = "pgfmk3_suhols_alt_head"
	limb_id = "pgfmk3_suhols_alt"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

// PGF Mechanics MK.III Type 'Wusha'

/obj/item/bodypart/head/ipc/pgfmk3_wusha
	name = "\improper PGF Mechanics MK.III Type 'Wusha' head"
	examine_id = "\improper PGF Mechanics MK.III Type 'Wusha'"
	icon_state = "pgfmk3_wusha_head"
	limb_id = "pgfmk3_wusha"
	draw_eyes = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/pgfmk3_wusha
	name = "\improper PGF Mechanics MK.III Type 'Wusha' chest"
	examine_id = "\improper PGF Mechanics MK.III Type 'Wusha'"
	icon_state = "pgfmk3_wusha_chest"
	limb_id = "pgfmk3_wusha"

/obj/item/bodypart/head/ipc/pgfmk3_wusha_boxhead
	name = "\improper PGF Mechanics MK.III Type 'Wusha' aftermarket boxhead"
	examine_id = "\improper PGF Mechanics MK.III Type 'Wusha' aftermarket box"
	icon_state = "pgfmk3_wusha_alt_head"
	limb_id = "pgfmk3_wusha_alt"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

// PGF Mechanics MK.III generic

/obj/item/bodypart/l_arm/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III left arm"
	examine_id = "\improper PGF Mechanics MK.III"
	icon_state = "pgfmk3_l_arm"
	limb_id = "pgfmk3"

/obj/item/bodypart/r_arm/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III right arm"
	examine_id = "\improper PGF Mechanics MK.III"
	icon_state = "pgfmk3_r_arm"
	limb_id = "pgfmk3"

/obj/item/bodypart/leg/left/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III left leg"
	examine_id = "\improper PGF Mechanics MK.III"
	icon_state = "pgfmk3_l_leg"
	limb_id = "pgfmk3"

/obj/item/bodypart/leg/right/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III right leg"
	examine_id = "\improper PGF Mechanics MK.III"
	icon_state = "pgfmk3_r_leg"
	limb_id = "pgfmk3"

// PGF Mechanics MK.V

/obj/item/bodypart/head/ipc/pgf
	name = "\improper PGF Mechanics MK.V head"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_head"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/pgf
	name = "\improper PGF Mechanics MK.V chest"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/pgf
	name = "\improper PGF Mechanics MK.V left arm"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/pgf
	name = "\improper PGF Mechanics MK.V right arm"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/pgf
	name = "\improper PGF Mechanics MK.V Type-P left leg"
	examine_id = "\improper PGF Mechanics MK.V Type-P"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf
	name = "\improper PGF Mechanics MK.V Type-P right leg"
	examine_id = "\improper PGF Mechanics MK.V Type-P"
	icon_state = "pgfipc-p_r_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/tail/ipc/pgf
	name = "\improper PGF Mechanics MK.V robotic tail"
	examine_id = "\improper PGF Mechanics MK.V robotic"
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
	sturdy = TRUE

/obj/item/bodypart/tail/ipc/pgf/secondary_color
	overlay_use_primary_color = TRUE
	draw_color_use_secondary = TRUE

/obj/item/bodypart/tail/ipc/pgf/large
	name = "\improper PGF Mechanics MK.V large robotic tail"
	examine_id = "\improper PGF Mechanics MK.V robotic"
	icon_state = "large_synth_tail"
	limb_id = "large_synth"
	max_damage = 50
	max_stamina_damage = 50
	body_damage_coeff = 0.75
	body_weight = 16
	can_wag = TRUE // only one with a sprite for it

/obj/item/bodypart/tail/ipc/pgf/large/secondary_color
	overlay_use_primary_color = TRUE
	draw_color_use_secondary = TRUE

// PGF Mechanics MK.V TYPE-D

/obj/item/bodypart/leg/left/ipc/pgf/type_d
	name = "\improper PGF Mechanics MK.V Type-D left leg"
	examine_id = "\improper PGF Mechanics MK.V Type-D"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf/type_d
	name = "\improper PGF Mechanics MK.V Type-D right leg"
	examine_id = "\improper PGF Mechanics MK.V Type-D"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

// Besoro Bishop

/obj/item/bodypart/head/ipc/bishop
	name = "\improper Besoro Bishop head"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_head"
	limb_id = "bishop"
	draw_eyes = TRUE
	eye_state_override = "eyes_circle"

/obj/item/bodypart/chest/ipc/bishop
	name = "\improper Besoro Bishop chest"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_chest"
	limb_id = "bishop"

/obj/item/bodypart/l_arm/ipc/bishop
	name = "\improper Besoro Bishop left arm"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_l_arm"
	limb_id = "bishop"

/obj/item/bodypart/r_arm/ipc/bishop
	name = "\improper Besoro Bishop right arm"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_r_arm"
	limb_id = "bishop"

/obj/item/bodypart/leg/left/ipc/bishop
	name = "\improper Besoro Bishop left leg"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_l_leg"
	limb_id = "bishop"

/obj/item/bodypart/leg/right/ipc/bishop
	name = "\improper Besoro Bishop right leg"
	examine_id = "\improper Besoro Bishop"
	icon_state = "bishop_r_leg"
	limb_id = "bishop"

/obj/item/bodypart/head/ipc/bishop_boxhead
	name = "\improper Besoro Bishop Type-B head"
	examine_id = "\improper Besoro Bishop Type-B"
	icon_state = "bishop_alt_head"
	limb_id = "bishop_alt"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

// INTEQ SPRINTER

/obj/item/bodypart/head/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' Type-1 head"
	examine_id = "\improper Inteq Mothership 'Sprinter' Type-1"
	icon_state = "inteqsprinter_head"
	limb_id = "inteqsprinter"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	eye_state_override = "eyes_inteqsprinter"
	draw_eyes = TRUE
	greyscale_eyes = FALSE

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
	eye_state_override = "eyes_inteqsprinter2"
	draw_eyes = TRUE
	greyscale_eyes = FALSE

// MAXIM SEEKER

/obj/item/bodypart/head/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' head"
	examine_id = "\improper Maxim Dynamics 'Seeker'"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	eye_state_override = "eyes_seekeripc"
	draw_eyes = TRUE
	greyscale_eyes = FALSE
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
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_head"
	limb_id = "cyber"
	draw_eyes = TRUE
	eye_state_override = "eyes_cybersun_ghost"
	greyscale_eyes = FALSE

/obj/item/bodypart/chest/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' chest"
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_chest"
	limb_id = "cyber"

/obj/item/bodypart/l_arm/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' left arm"
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_l_arm"
	limb_id = "cyber"

/obj/item/bodypart/r_arm/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' right arm"
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_r_arm"
	limb_id = "cyber"

/obj/item/bodypart/leg/left/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' left leg"
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_l_leg"
	limb_id = "cyber"

/obj/item/bodypart/leg/right/ipc/ghost
	name = "\improper Cybersun Biodynamics S Series 'Ghost' right leg"
	examine_id = "\improper Cybersun Biodynamics S Series 'Ghost'"
	icon_state = "cyber_r_leg"
	limb_id = "cyber"

//Custom 3D Printed (Various)
/obj/item/bodypart/head/ipc/custom_boxhead
	name = "\improper Custom 3D Printed Boxhead"
	examine_id = "\improper Custom 3D Printed Box"
	icon_state = "custom_3d_box_head"
	limb_id = "custom_3d_box"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/head/ipc/custom_monoeye
	name = "\improper Custom 3D Printed monoeye head"
	examine_id = "\improper Custom 3D Printed monoeye"
	icon_state = "customsa_head"
	limb_id = "customsa"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	eye_state_override = "eyes_mono"

/obj/item/bodypart/head/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua head"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_monoc_head"
	limb_id = "customatua_monoc"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	eye_state_override = "eyes_mono"

/obj/item/bodypart/leg/left/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua left leg"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_monoc_l_leg"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua right leg"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_monoc_r_leg"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua left arm"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_monoc_l_arm"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua right arm"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_monoc_r_arm"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/custom_saipc2
	name = "\improper Custom 3D Printed IPC-80 left arm"
	examine_id = "\improper Custom 3D Printed IPC-80"
	icon_state = "customsa_l_arm"
	limb_id = "customsa"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custom_saipc2
	name = "\improper Custom 3D Printed IPC-80 right arm"
	examine_id = "\improper Custom 3D Printed IPC-80"
	icon_state = "customsa_r_arm"
	limb_id = "customsa"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE


// Custom 3D Printed MK.III Type 'Suhols-Ro'

/obj/item/bodypart/head/ipc/custompgf3_suhols
	name = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro' head"
	examine_id = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro'"
	icon_state = "custompgf3_suhols_head"
	limb_id = "custompgf3_suhols"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	eye_state_override = "eyes_elzu"

/obj/item/bodypart/chest/ipc/custompgf3_suhols
	name = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro' chest"
	examine_id = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro'"
	icon_state = "custompgf3_suhols_chest"
	limb_id = "custompgf3_suhols"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed MK.III Type 'Wusha'

/obj/item/bodypart/head/ipc/custompgf3_wusha
	name = "\improper Custom 3D Printed MK.III Type 'Wusha' head"
	examine_id = "\improper Custom 3D Printed MK.III Type 'Wusha'"
	icon_state = "custompgf3_wusha_head"
	limb_id = "custompgf3_wusha"
	draw_eyes = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/chest/ipc/custompgf3_wusha
	name = "\improper Custom 3D Printed MK.III Type 'Wusha' chest"
	examine_id = "\improper Custom 3D Printed MK.III Type 'Wusha'"
	icon_state = "custompgf3_wusha_chest"
	limb_id = "custompgf3_wusha"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed MK.III generic

/obj/item/bodypart/l_arm/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III left arm"
	examine_id = "\improper Custom 3D Printed MK.III"
	icon_state = "custompgf3_l_arm"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III right arm"
	examine_id = "\improper Custom 3D Printed MK.III"
	icon_state = "custompgf3_r_arm"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III left leg"
	examine_id = "\improper Custom 3D Printed MK.III"
	icon_state = "custompgf3_l_leg"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III right leg"
	examine_id = "\improper Custom 3D Printed MK.III"
	icon_state = "custompgf3_r_leg"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

//Custom 3D Printed Atua

/obj/item/bodypart/head/ipc/customatua
	name = "\improper Custom 3D Printed Atua head"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_head"
	limb_id = "customatua"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/customatua
	name = "\improper Custom 3D Printed Atua chest"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_chest"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customatua
	name = "\improper Custom 3D Printed Atua left arm"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_l_arm"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customatua
	name = "\improper Custom 3D Printed Atua right arm"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_r_arm"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customatua
	name = "\improper Custom 3D Printed Atua left leg"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_l_leg"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customatua
	name = "\improper Custom 3D Printed Atua right leg"
	examine_id = "\improper Custom 3D Printed Atua"
	icon_state = "customatua_r_leg"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

// Custom 3D Printed Bishop

/obj/item/bodypart/head/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop head"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_head"
	limb_id = "custombishop"
	draw_eyes = TRUE
	eye_state_override = "eyes_circle"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop chest"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_chest"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop left arm"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_l_arm"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop right arm"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_r_arm"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop left leg"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_l_leg"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop right leg"
	examine_id = "\improper Custom 3D Printed Bishop"
	icon_state = "custombishop_r_leg"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

//Custom 3D Printed HIACU

/obj/item/bodypart/head/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU head"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_head"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU chest"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_chest"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU left arm"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_l_arm"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU right arm"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_r_arm"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU left leg"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_l_leg_digitigrade"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU right leg"
	examine_id = "\improper Custom 3D Printed HIACU"
	icon_state = "customhiacu_r_leg_digitigrade"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

// Custom 3D Printed Lanchester

/obj/item/bodypart/head/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester head"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_head"
	limb_id = "customlanchesterheavy"
	draw_eyes = TRUE
	eye_state_override = "eyes_circle"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester chest"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_chest"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester left arm"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_l_arm"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester right arm"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_r_arm"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester left leg"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_l_leg"
	limb_id = "customlanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester right leg"
	examine_id = "\improper Custom 3D Printed Lanchester"
	icon_state = "customlanchesterheavy_r_leg"
	limb_id = "customlanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed Longshore

/obj/item/bodypart/head/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore head"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_head"
	limb_id = "customlanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore chest"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_chest"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore left arm"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_l_arm"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore right arm"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_r_arm"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore left leg"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_l_leg"
	limb_id = "customlanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore right leg"
	examine_id = "\improper Custom 3D Printed Longshore"
	icon_state = "customlanchesterworker_r_leg"
	limb_id = "customlanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed Seeeker

/obj/item/bodypart/head/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker head"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	eye_state_override = "eyes_seekeripc_greyscale"
	draw_eyes = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/chest/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker chest"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_chest"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/l_arm/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker left arm"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_l_arm"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/r_arm/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker right arm"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_r_arm"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/left/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker left leg"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_l_leg"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/right/ipc/customseeker
	name = "\improper Custom 3D Printed Seeker right leg"
	examine_id = "\improper Custom 3D Printed Seeker"
	icon_state = "seekeripc_r_leg"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

// PGF Mechanics MK.V TYPE-P (Monocolor)

/obj/item/bodypart/head/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V head"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_head"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V chest"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/l_arm/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V left arm"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/r_arm/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V right arm"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/left/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V Type-P left leg"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/right/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V Type-P right leg"
	examine_id = "\improper PGF Mechanics MK.V"
	icon_state = "pgfipc-p_r_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

// PGF Mechanics MK.V TYPE-D

/obj/item/bodypart/leg/left/ipc/pgf_monocolor/type_d
	name = "\improper PGF Mechanics MK.V Type-D left leg"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf_monocolor/type_d
	name = "\improper PGF Mechanics MK.V Type-D right leg"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
