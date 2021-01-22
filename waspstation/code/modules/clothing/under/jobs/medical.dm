//Alt job uniforms

/obj/item/clothing/under/rank/medical/chemist/pharmacist
	name = "pharmacist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. For those pharmacists that want to improve or worsen the station's health."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "pharmacist"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/chemist/pharmacist/skirt
	name = "pharmacist's jumpskirt"
	icon_state = "pharmacist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/chemist/pharmacologist
	name = "pharmacologist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. For those pharmacologist one step behind to being evil."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "pharmacologist"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/chemist/pharmacologist/skirt
	name = "pharmacologist's jumpskirt"
	icon_state = "pharmacologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/chemist/junior_chemist
	name = "junior chemist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. A jumpsuit for junior chemist staff."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "junior_chemistry"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/chemist/junior_chemist/skirt
	name = "junior chemist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. A jumpskirt for junior chemist staff."
	icon_state = "junior_chemistry_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/psychiatrist
	name = "white psychiatrist's suit"
	desc = "A turtleneck for personnel trained to deal with psychological issues, such as terrible work place incidents or the clown's bad jokes. This one has a white turtleneck."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "psychiatrist-white"

	can_adjust = FALSE

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/psychiatrist/green
	name = "blue psychiatrist's suit"
	desc = "A turtleneck for personnel trained to deal with psychological issues, such as terrible work place incidents or the clown's bad jokes. This one has a green turtleneck."
	icon_state = "psychiatrist-green"

/obj/item/clothing/under/rank/medical/psychiatrist/blue
	name = "green psychiatrist's suit"
	desc = "A turtleneck for personnel trained to deal with psychological issues, such as terrible work place incidents or the clown's bad jokes. This one has a blue turtleneck."
	icon_state = "psychiatrist-blue"

/obj/item/clothing/under/rank/medical/doctor/junior_doctor
	name = "junior doctor's jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohazards. Worn by the junior medical personnel."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "junior_medical"
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/doctor/junior_doctor/skirt
	name = "junior doctor's jumpskirt"
	icon_state = "junior_medical_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/suit/cmo
	name = "medical director suit"
	desc = "A suit with medical colors, meant to be worn by those who lead the medical department."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "medical_director"

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/cmo/skirt
	name = "medical director skirtsuit"
	desc = "A skirtsuit with medical colors, meant to be worn by those who lead the medical department."
	icon_state = "medical_director_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/chief_medical_officer/surgeon_general
	name = "surgeon-general scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is meant to be worn by surgeon-generals."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "surgeon_general"
	can_adjust = FALSE

/obj/item/clothing/under/suit/senior_doctor
	name = "senior doctor suit"
	desc = "A suit with medical colors, meant to be worn by senior staff."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "senior_medical"

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/senior_doctor/skirt
	name = "senior doctor skirtsuit"
	desc = "A skirtsuit with medical colors, meant to be worn by senior staff."
	icon_state = "senior_medical_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/suit/senior_chemist
	name = "senior chemist suit"
	desc = "A suit with chemistry colors, meant to be worn by senior staff."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "senior_chemistry"

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 65)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/senior_chemist/skirt
	name = "senior chemist suit"
	desc = "A skirtsuit with chemistry colors, meant to be worn by senior staff."
	icon_state = "senior_chemistry_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/suit/pathologist
	name = "pathologist suit"
	desc = "A suit with special fibers that provide minor protection against biohazards. A suit with green pants, provided to pathologists."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "pathologist"

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/suit/pathologist/skirt
	name = "pathologist suit"
	desc = "A suit with special fibers that provide minor protection against biohazards. A skirtsuit with green pants, provided to pathologists."
	icon_state = "pathologist_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/paramedic/emt
	name = "emergency medical technician jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has shorts, allowing ease of movement for EMTs."
	icon = 'waspstation/icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/under/medical.dmi'
	icon_state = "emt"

	body_parts_covered = CHEST|GROIN|ARMS
	fitted = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/medical/paramedic/emt/skirt
	name = "emergency medical technician jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards."
	icon_state = "emt_skirt"

	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/doctor/red
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in red."
	icon_state = "scrubsred"
	can_adjust = FALSE
	fitted = NO_FEMALE_UNIFORM
