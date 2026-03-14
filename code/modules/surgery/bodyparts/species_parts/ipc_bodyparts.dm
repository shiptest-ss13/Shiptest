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
	var/datum/species/ipc/ipc_species_datum = limb_owner.dna.species
	var/datum/species/species_datum = limb_owner.dna.species
	if(!ipc_species_datum)
		ipc_species_datum.update_screen_action()
	else if(species_datum)
		LAZYREMOVE(species_datum.species_traits, SCLERA)
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
	name = "\improper Pawsitrons United N1 head"
	icon_state = "pawsitrons_head"
	limb_id = "pawsitrons"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/chest/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 chest"
	icon_state = "pawsitrons_chest"
	limb_id = "pawsitrons"

/obj/item/bodypart/l_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 left arm"
	icon_state = "pawsitrons_l_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/r_arm/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 right arm"
	icon_state = "pawsitrons_r_arm"
	limb_id = "pawsitrons"

/obj/item/bodypart/leg/left/ipc/pawsitrons
	name = "\improper Pawsitrons United N1 left leg"
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
	icon_state = "mwpmu_head"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU chest"
	icon_state = "mwpmu_chest"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left arm"
	icon_state = "mwpmu_l_arm"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right arm"
	icon_state = "mwpmu_r_arm"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU left leg"
	icon_state = "mwpmu_l_leg_digitigrade"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/mwpmu
	name = "\improper Makosso-Warra MW-PMU right leg"
	icon_state = "mwpmu_r_leg_digitigrade"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

//Makosso-Warra MW-PMU (Custom Visor Color)

/obj/item/bodypart/head/ipc/mwpmu_visor_color
	name = "\improper Makosso-Warra MW-PMU head"
	icon_state = "mwpmu_head"
	limb_id = "mwpmu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

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

/obj/item/bodypart/head/ipc/saipc_boxhead
	name = "\improper Scarborgh Arms IPC-73 Type-2 boxhead"
	icon_state = "saipc_alt_head"
	limb_id = "saipc_alt"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

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

/obj/item/bodypart/head/ipc/lanchesterheavy_boxhead
	name = "\improper Lanchester Mechanics 'HEAVY DUTY FRAME' head"
	icon_state = "lanchesterheavy_alt_head"
	limb_id = "lanchesterheavy_alt"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

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
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' head"
	icon_state = "pgfmk3_suhols_head"
	limb_id = "pgfmk3_suhols"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_elzu"

/obj/item/bodypart/chest/ipc/pgfmk3_suhols
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' chest"
	icon_state = "pgfmk3_suhols_chest"
	limb_id = "pgfmk3_suhols"

/obj/item/bodypart/head/ipc/pgfmk3_suhols_boxhead
	name = "\improper PGF Mechanics MK.III Type 'Suhols-Ro' aftermarket boxhead"
	icon_state = "pgfmk3_suhols_alt_head"
	limb_id = "pgfmk3_suhols_alt"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

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

/obj/item/bodypart/head/ipc/pgfmk3_wusha_boxhead
	name = "\improper PGF Mechanics MK.III Type 'Wusha' aftermarket boxhead"
	icon_state = "pgfmk3_wusha_alt_head"
	limb_id = "pgfmk3_wusha_alt"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

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

// PGF Mechanics MK.V TYPE-P

/obj/item/bodypart/head/ipc/pgf
	name = "\improper PGF Mechanics MK.V head"
	icon_state = "pgfipc-p_head"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE
	has_screen = FALSE
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/pgf
	name = "\improper PGF Mechanics MK.V chest"
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/pgf
	name = "\improper PGF Mechanics MK.V left arm"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/pgf
	name = "\improper PGF Mechanics MK.V right arm"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/pgf
	name = "\improper PGF Mechanics MK.V Type-P left leg"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/pgf
	name = "\improper PGF Mechanics MK.V Type-P right leg"
	icon_state = "pgfipc-p_r_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	overlay_icon_state = TRUE

// PGF Mechanics MK.V TYPE-D

/obj/item/bodypart/leg/left/ipc/pgf/type_d
	name = "\improper PGF Mechanics MK.V Type-D left leg"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/pgf/type_d
	name = "\improper PGF Mechanics MK.V Type-D right leg"
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

/obj/item/bodypart/head/ipc/bishop_boxhead
	name = "\improper Besoro Bishop Type-B head"
	icon_state = "bishop_alt_head"
	limb_id = "bishop_alt"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

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

//Custom 3D Printed (Various)
/obj/item/bodypart/head/ipc/custom_boxhead
	name = "\improper Custom 3D Printed Boxhead"
	icon_state = "custom_3d_box_head"
	limb_id = "custom_3d_box"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD

/obj/item/bodypart/head/ipc/custom_monoeye
	name = "\improper Custom 3D Printed monoeye head"
	icon_state = "customsa_head"
	limb_id = "customsa"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_mono"

/obj/item/bodypart/head/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua head"
	icon_state = "customatua_monoc_head"
	limb_id = "customatua_monoc"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	custom_eye_sprite = "eyes_mono"

/obj/item/bodypart/leg/left/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua left leg"
	icon_state = "customatua_monoc_l_leg"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua right leg"
	icon_state = "customatua_monoc_r_leg"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua left arm"
	icon_state = "customatua_monoc_l_arm"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customatua_monoc
	name = "\improper Custom 3D Printed Atua right arm"
	icon_state = "customatua_monoc_r_arm"
	limb_id = "customatua_monoc"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/custom_saipc2
	name = "\improper Custom 3D Printed IPC-80 left arm"
	icon_state = "customsa_l_arm"
	limb_id = "customsa"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custom_saipc2
	name = "\improper Custom 3D Printed IPC-80 right arm"
	icon_state = "customsa_r_arm"
	limb_id = "customsa"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE


// Custom 3D Printed MK.III Type 'Suhols-Ro'

/obj/item/bodypart/head/ipc/custompgf3_suhols
	name = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro' head"
	icon_state = "custompgf3_suhols_head"
	limb_id = "custompgf3_suhols"
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	custom_eye_sprite = "eyes_elzu"

/obj/item/bodypart/chest/ipc/custompgf3_suhols
	name = "\improper Custom 3D Printed MK.III Type 'Suhols-Ro' chest"
	icon_state = "custompgf3_suhols_chest"
	limb_id = "custompgf3_suhols"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed MK.III Type 'Wusha'

/obj/item/bodypart/head/ipc/custompgf3_wusha
	name = "\improper Custom 3D Printed MK.III Type 'Wusha' head"
	icon_state = "custompgf3_wusha_head"
	limb_id = "custompgf3_wusha"
	draw_eyes = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/chest/ipc/custompgf3_wusha
	name = "\improper Custom 3D Printed MK.III Type 'Wusha' chest"
	icon_state = "custompgf3_wusha_chest"
	limb_id = "custompgf3_wusha"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed MK.III generic

/obj/item/bodypart/l_arm/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III left arm"
	icon_state = "custompgf3_l_arm"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III right arm"
	icon_state = "custompgf3_r_arm"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III left leg"
	icon_state = "custompgf3_l_leg"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/custompgf3
	name = "\improper Custom 3D Printed MK.III right leg"
	icon_state = "custompgf3_r_leg"
	limb_id = "custompgf3"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

//Custom 3D Printed Atua

/obj/item/bodypart/head/ipc/customatua
	name = "\improper Custom 3D Printed Atua head"
	icon_state = "customatua_head"
	limb_id = "customatua"
	draw_eyes = TRUE
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT_SMALL

/obj/item/bodypart/chest/ipc/customatua
	name = "\improper Custom 3D Printed Atua chest"
	icon_state = "customatua_chest"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customatua
	name = "\improper Custom 3D Printed Atua left arm"
	icon_state = "customatua_l_arm"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customatua
	name = "\improper Custom 3D Printed Atua right arm"
	icon_state = "customatua_r_arm"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customatua
	name = "\improper Custom 3D Printed Atua left leg"
	icon_state = "customatua_l_leg"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customatua
	name = "\improper Custom 3D Printed Atua right leg"
	icon_state = "customatua_r_leg"
	limb_id = "customatua"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

// Custom 3D Printed Bishop

/obj/item/bodypart/head/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop head"
	icon_state = "custombishop_head"
	limb_id = "custombishop"
	draw_eyes = TRUE
	custom_eye_sprite = "eyes_circle"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop chest"
	icon_state = "custombishop_chest"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop left arm"
	icon_state = "custombishop_l_arm"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop right arm"
	icon_state = "custombishop_r_arm"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop left leg"
	icon_state = "custombishop_l_leg"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/custombishop
	name = "\improper Custom 3D Printed Bishop right leg"
	icon_state = "custombishop_r_leg"
	limb_id = "custombishop"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

//Custom 3D Printed HIACU

/obj/item/bodypart/head/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU head"
	icon_state = "customhiacu_head"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU chest"
	icon_state = "customhiacu_chest"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	overlay2_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU left arm"
	icon_state = "customhiacu_l_arm"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU right arm"
	icon_state = "customhiacu_r_arm"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU left leg"
	icon_state = "customhiacu_l_leg_digitigrade"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

/obj/item/bodypart/leg/right/ipc/customhiacu
	name = "\improper Custom 3D Printed HIACU right leg"
	icon_state = "customhiacu_r_leg_digitigrade"
	limb_id = "customhiacu"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE

// Custom 3D Printed Lanchester

/obj/item/bodypart/head/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester head"
	icon_state = "customlanchesterheavy_head"
	limb_id = "customlanchesterheavy"
	draw_eyes = TRUE
	custom_eye_sprite = "eyes_circle"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester chest"
	icon_state = "customlanchesterheavy_chest"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester left arm"
	icon_state = "customlanchesterheavy_l_arm"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester right arm"
	icon_state = "customlanchesterheavy_r_arm"
	limb_id = "customlanchesterheavy"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester left leg"
	icon_state = "customlanchesterheavy_l_leg"
	limb_id = "customlanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customlanchesterheavy
	name = "\improper Custom 3D Printed Lanchester right leg"
	icon_state = "customlanchesterheavy_r_leg"
	limb_id = "customlanchesterheavy"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed Longshore

/obj/item/bodypart/head/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore head"
	icon_state = "customlanchesterworker_head"
	limb_id = "customlanchesterworker"
	has_screen = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_BOXHEAD
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/chest/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore chest"
	icon_state = "customlanchesterworker_chest"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/l_arm/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore left arm"
	icon_state = "customlanchesterworker_l_arm"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/r_arm/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore right arm"
	icon_state = "customlanchesterworker_r_arm"
	limb_id = "customlanchesterworker"
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/left/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore left leg"
	icon_state = "customlanchesterworker_l_leg"
	limb_id = "customlanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

/obj/item/bodypart/leg/right/ipc/customlanchesterworker
	name = "\improper Custom 3D Printed Longshore right leg"
	icon_state = "customlanchesterworker_r_leg"
	limb_id = "customlanchesterworker"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	overlay_use_primary_color = TRUE
	overlay_icon_state = TRUE

// Custom 3D Printed Seeeker

/obj/item/bodypart/head/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker head"
	icon_state = "seekeripc_head"
	limb_id = "seekeripc"
	custom_eye_sprite = "eyes_seekeripc_greyscale"
	draw_eyes = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/chest/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker chest"
	icon_state = "seekeripc_chest"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/l_arm/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker left arm"
	icon_state = "seekeripc_l_arm"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/r_arm/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker right arm"
	icon_state = "seekeripc_r_arm"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/left/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker left leg"
	icon_state = "seekeripc_l_leg"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/right/ipc/customseeker
	name = "\improper Custom 3D Printed Seeeker right leg"
	icon_state = "seekeripc_r_leg"
	limb_id = "seekeripc"
	should_draw_greyscale = TRUE

// PGF Mechanics MK.V TYPE-P (Monocolor)

/obj/item/bodypart/head/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V head"
	icon_state = "pgfipc-p_head"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	has_screen = FALSE
	draw_eyes = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_SNOUT

/obj/item/bodypart/chest/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V chest"
	icon_state = "pgfipc-p_chest"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/l_arm/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V left arm"
	icon_state = "pgfipc-p_l_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/r_arm/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V right arm"
	icon_state = "pgfipc-p_r_arm"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/left/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V Type-P left leg"
	icon_state = "pgfipc-p_l_leg"
	limb_id = "pgfipc-p"
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE

/obj/item/bodypart/leg/right/ipc/pgf_monocolor
	name = "\improper PGF Mechanics MK.V Type-P right leg"
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
