/obj/item/bodypart/head/ipc
	static_icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon = 'icons/mob/species/ipc/bodyparts.dmi'
	icon_state = "synth_head"
	limb_id = "synth"
	var/custom_eye_sprite
	/// if true, we set the eyes to #FFFFFF - useful for ipcs where the light color probably shouldnt be changable
	var/force_white_eye_color = FALSE
	dynamic_rename = FALSE
	draw_eyes = FALSE
	var/has_screen = FALSE
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

//awful workaround for the lack of differing eye sprite handling
/obj/item/bodypart/head/ipc/attach_limb(mob/living/carbon/our_carbon, special, is_creating = FALSE)
	var/mob/living/carbon/human/limb_owner
	if(our_carbon)
		limb_owner = our_carbon
	else
		limb_owner = owner

	var/obj/item/organ/eyes/eyes_to_edit = limb_owner.getorganslot(ORGAN_SLOT_EYES)

	if(!limb_owner || !eyes_to_edit)
		return ..()
	if(custom_eye_sprite)
		eyes_to_edit.eye_icon_state = custom_eye_sprite

	if(force_white_eye_color)
		limb_owner.eye_color = COLOR_WHITE
	var/datum/species/ipc/species_datum = limb_owner.dna.species
	if(!species_datum)
		species_datum.update_screen_action()
	return ..()

//ditto
/obj/item/bodypart/head/ipc/drop_limb(special)
	var/mob/living/carbon/human/limb_owner = owner

	var/obj/item/organ/eyes/eyes_to_edit = limb_owner.getorganslot(ORGAN_SLOT_EYES)

	if(!limb_owner || !eyes_to_edit)
		return ..()
	if(custom_eye_sprite)
		eyes_to_edit.eye_icon_state = eyes_to_edit::eye_icon_state

	if(force_white_eye_color)
		limb_owner.eye_color = eyes_to_edit.eye_color
	return ..()

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

//Makosso-Warra MW-HIAU (high-inteligence-automated-unit)

//Makosso-Warra MW-PMU

/obj/item/bodypart/head/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU head"
	icon_state = "mwpmu_head"
	limb_id = "mwpmu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU chest"
	icon_state = "mwpmu_chest"
	limb_id = "mwpmu"

/obj/item/bodypart/l_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left arm"
	icon_state = "mwpmu_l_arm"
	limb_id = "mwpmu"

/obj/item/bodypart/r_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right arm"
	icon_state = "mwpmu_r_arm"
	limb_id = "mwpmu"

/obj/item/bodypart/leg/left/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left leg"
	icon_state = "mwpmu_l_leg_digitigrade"
	limb_id = "mwpmu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right leg"
	icon_state = "mwpmu_r_leg_digitigrade"
	limb_id = "mwpmu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE


//Makosso-Warra MW-HIACU (MW)

/obj/item/bodypart/head/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU head"
	icon_state = "mwhiacu_head"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU chest"
	icon_state = "mwhiacu_chest"
	limb_id = "mwhiacu"

/obj/item/bodypart/l_arm/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU left arm"
	icon_state = "mwhiacu_l_arm"
	limb_id = "mwhiacu"

/obj/item/bodypart/r_arm/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU right arm"
	icon_state = "mwhiacu_r_arm"
	limb_id = "mwhiacu"

/obj/item/bodypart/leg/left/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU left leg"
	icon_state = "mwhiacu_l_leg_digitigrade"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwhiacu
	name = "\improper Makosso-Warra MW-HIACU right leg"
	icon_state = "mwhiacu_r_leg_digitigrade"
	limb_id = "mwhiacu"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Makosso-Warra MW-HIACU (VI)
//since the only difference is the literal color, they share names

/obj/item/bodypart/head/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU head"
	icon_state = "mwhiacu_vi_head"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU chest"
	icon_state = "mwhiacu_vi_chest"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/l_arm/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU left arm"
	icon_state = "mwhiacu_vi_l_arm"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/r_arm/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU right arm"
	icon_state = "mwhiacu_vi_r_arm"
	limb_id = "mwhiacu_vi"

/obj/item/bodypart/leg/left/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU left leg"
	icon_state = "mwhiacu_vi_l_leg_digitigrade"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwhiacu_vi
	name = "\improper Makosso-Warra MW-HIACU right leg"
	icon_state = "mwhiacu_vi_r_leg_digitigrade"
	limb_id = "mwhiacu_vi"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Atua Synkinetics Parça

/obj/item/bodypart/head/ipc/atua
	name = "\improper Atua Synkinetics Parça head"
	icon_state = "atua_head"
	limb_id = "atua"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/atua
	name = "\improper Atua Synkinetics Parça chest"
	icon_state = "atua_chest"
	limb_id = "atua"

/obj/item/bodypart/l_arm/ipc/atua
	name = "\improper Atua Synkinetics Parça left arm"
	icon_state = "atua_l_arm"
	limb_id = "atua"

/obj/item/bodypart/r_arm/ipc/atua
	name = "\improper Atua Synkinetics Parça right arm"
	icon_state = "atua_r_arm"
	limb_id = "atua"

/obj/item/bodypart/leg/left/ipc/atua
	name = "\improper Atua Synkinetics Parça left leg"
	icon_state = "atua_l_leg"
	limb_id = "atua"

/obj/item/bodypart/leg/right/ipc/atua
	name = "\improper Atua Synkinetics Parça right leg"
	icon_state = "atua_r_leg"
	limb_id = "atua"

// Scarborgh Arms IPC-73

/obj/item/bodypart/head/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 head"
	icon_state = "saipc_head"
	limb_id = "saipc"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_mono"

/obj/item/bodypart/chest/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 chest"
	icon_state = "saipc_chest"
	limb_id = "saipc"

/obj/item/bodypart/l_arm/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 left arm"
	icon_state = "saipc_l_arm"
	limb_id = "saipc"

/obj/item/bodypart/r_arm/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 right arm"
	icon_state = "saipc_r_arm"
	limb_id = "saipc"

/obj/item/bodypart/leg/left/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 left leg"
	icon_state = "saipc_l_leg"
	limb_id = "saipc"

/obj/item/bodypart/leg/right/ipc/saipc
	name = "\improper Scarborgh Arms IPC-73 right leg"
	icon_state = "saipc_r_leg"
	limb_id = "saipc"

// Scarborgh Arms IPC-80 MK.2

/obj/item/bodypart/head/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 head"
	icon_state = "saipc2_head"
	limb_id = "saipc2"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_mono"

/obj/item/bodypart/chest/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 chest"
	icon_state = "saipc2_chest"
	limb_id = "saipc2"

/obj/item/bodypart/l_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left arm"
	icon_state = "saipc2_l_arm"
	limb_id = "saipc2"

/obj/item/bodypart/r_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right arm"
	icon_state = "saipc2_r_arm"
	limb_id = "saipc2"

/obj/item/bodypart/leg/left/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left leg"
	icon_state = "saipc2_l_leg"
	limb_id = "saipc2"

/obj/item/bodypart/leg/right/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right leg"
	icon_state = "saipc2_r_leg"
	limb_id = "saipc2"

// Scarborgh Arms IPC-80 MK.2

/obj/item/bodypart/head/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 head"
	icon_state = "saipc2_head"
	limb_id = "saipc2"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 chest"
	icon_state = "saipc2_chest"
	limb_id = "saipc2"

/obj/item/bodypart/l_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left arm"
	icon_state = "saipc2_l_arm"
	limb_id = "saipc2"

/obj/item/bodypart/r_arm/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right arm"
	icon_state = "saipc2_r_arm"
	limb_id = "saipc2"

/obj/item/bodypart/leg/left/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 left leg"
	icon_state = "saipc2_l_leg"
	limb_id = "saipc2"

/obj/item/bodypart/leg/right/ipc/saipc2
	name = "\improper Scarborgh Arms IPC-80 MK.2 right leg"
	icon_state = "saipc2_r_leg"
	limb_id = "saipc2"

// Lanchester Mechanics 'HEAVY DUTY FRAME'

/obj/item/bodypart/head/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' head"
	icon_state = "lanchesterheavy_head"
	limb_id = "lanchesterheavy"
	draw_eyes = TRUE
	custom_eye_sprite = "eyes_circle"

/obj/item/bodypart/chest/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' chest"
	icon_state = "lanchesterheavy_chest"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/l_arm/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' left arm"
	icon_state = "lanchesterheavy_l_arm"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/r_arm/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' right arm"
	icon_state = "lanchesterheavy_r_arm"
	limb_id = "lanchesterheavy"

/obj/item/bodypart/leg/left/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' left leg"
	icon_state = "lanchesterheavy_l_leg"
	limb_id = "lanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterheavy
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' right leg"
	icon_state = "lanchesterheavy_r_leg"
	limb_id = "lanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

// HARDLINE 'Longshore'

/obj/item/bodypart/head/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' head"
	icon_state = "lanchesterworker_head"
	limb_id = "lanchesterworker"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' chest"
	icon_state = "lanchesterworker_chest"
	limb_id = "lanchesterworker"

/obj/item/bodypart/l_arm/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' left arm"
	icon_state = "lanchesterworker_l_arm"
	limb_id = "lanchesterworker"

/obj/item/bodypart/r_arm/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' right arm"
	icon_state = "lanchesterworker_r_arm"
	limb_id = "lanchesterworker"

/obj/item/bodypart/leg/left/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' left leg"
	icon_state = "lanchesterworker_l_leg"
	limb_id = "lanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterworker
	name = "\improper HARDLINE 'Longshore' right leg"
	icon_state = "lanchesterworker_r_leg"
	limb_id = "lanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

// Custom Unplated

/obj/item/bodypart/head/ipc/lanchesterunplated
	name = "\improper Custom Unplated head"
	icon_state = "lanchesterunplated_head"
	limb_id = "lanchesterunplated"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/lanchesterunplated
	name = "\improper Custom Unplated chest"
	icon_state = "lanchesterunplated_chest"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/l_arm/ipc/lanchesterunplated
	name = "\improper Custom Unplated left arm"
	icon_state = "lanchesterunplated_l_arm"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/r_arm/ipc/lanchesterunplated
	name = "\improper Custom Unplated right arm"
	icon_state = "lanchesterunplated_r_arm"
	limb_id = "lanchesterunplated"

/obj/item/bodypart/leg/left/ipc/lanchesterunplated
	name = "\improper Custom Unplated left leg"
	icon_state = "lanchesterunplated_l_leg"
	limb_id = "lanchesterunplated"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

/obj/item/bodypart/leg/right/ipc/lanchesterunplated
	name = "\improper Custom Unplated right leg"
	icon_state = "lanchesterunplated_r_leg"
	limb_id = "lanchesterunplated"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

// PGF Mechanics MK.III Type 'Suhols-Ro'

/obj/item/bodypart/head/ipc/pgfmk3_suhols
	name = "\improper Suhols-Ro head"
	icon_state = "pgfmk3_suhols_head"
	limb_id = "pgfmk3_suhols"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_elzu"

/obj/item/bodypart/chest/ipc/pgfmk3_suhols
	name = "\improper Suhols-Ro chest"
	icon_state = "pgfmk3_suhols_chest"
	limb_id = "pgfmk3_suhols"

// PGF Mechanics MK.III Type 'Wusha'

/obj/item/bodypart/head/ipc/pgfmk3_wusha
	name = "\improper PGF Mechanics MK.III Type 'Wusha' head"
	icon_state = "pgfmk3_wusha_head"
	limb_id = "pgfmk3_wusha"
	draw_eyes = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/pgfmk3_wusha
	name = "\improper PGF Mechanics MK.III Type 'Wusha' chest"
	icon_state = "pgfmk3_wusha_chest"
	limb_id = "pgfmk3_wusha"

// PGF Mechanics MK.III generic

/obj/item/bodypart/l_arm/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III left arm"
	icon_state = "pgfmk3_l_arm"
	limb_id = "pgfmk3"

/obj/item/bodypart/r_arm/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III right arm"
	icon_state = "pgfmk3_r_arm"
	limb_id = "pgfmk3"

/obj/item/bodypart/leg/left/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III left leg"
	icon_state = "pgfmk3_l_leg"
	limb_id = "pgfmk3"

/obj/item/bodypart/leg/right/ipc/pgfmk3
	name = "\improper PGF Mechanics MK.III right leg"
	icon_state = "pgfmk3_r_leg"
	limb_id = "pgfmk3"

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

// Besoro Bishop

/obj/item/bodypart/head/ipc/bishop
	name = "\improper Besoro Bishop head"
	icon_state = "bishop_head"
	limb_id = "bishop"
	draw_eyes = TRUE
	custom_eye_sprite = "eyes_circle"

/obj/item/bodypart/chest/ipc/bishop
	name = "\improper Besoro Bishop chest"
	icon_state = "bishop_chest"
	limb_id = "bishop"

/obj/item/bodypart/l_arm/ipc/bishop
	name = "\improper Besoro Bishop left arm"
	icon_state = "bishop_l_arm"
	limb_id = "bishop"

/obj/item/bodypart/r_arm/ipc/bishop
	name = "\improper Besoro Bishop right arm"
	icon_state = "bishop_r_arm"
	limb_id = "bishop"

/obj/item/bodypart/leg/left/ipc/bishop
	name = "\improper Besoro Bishop left leg"
	icon_state = "bishop_l_leg"
	limb_id = "bishop"

/obj/item/bodypart/leg/right/ipc/bishop
	name = "\improper Besoro Bishop right leg"
	icon_state = "bishop_r_leg"
	limb_id = "bishop"

// INTEQ SPRINTER

/obj/item/bodypart/head/ipc/sprinter
	name = "\improper Inteq Mothership 'Sprinter' Type-1 head"
	icon_state = "inteqsprinter_head"
	limb_id = "inteqsprinter"
	has_screen = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	custom_eye_sprite = "eyes_inteqsprinter"
	draw_eyes = TRUE
	force_white_eye_color = TRUE

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
	custom_eye_sprite = "eyes_inteqsprinter2"
	draw_eyes = TRUE
	force_white_eye_color = TRUE

// MAXIM SEEKER

/obj/item/bodypart/head/ipc/seeker
	name = "\improper Maxim Dynamics 'Seeker' head"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	custom_eye_sprite = "eyes_seekeripc"
	draw_eyes = TRUE
	force_white_eye_color = TRUE

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
	draw_eyes = TRUE
	custom_eye_sprite = "eyes_cybersun_ghost"
	force_white_eye_color = TRUE

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
