/obj/item/clothing/under/rank/medical
	icon = 'icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/rank/medical/chief_medical_officer
	desc = "It's a jumpsuit worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	name = "chief medical officer's jumpsuit"
	icon_state = "cmo"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt
	name = "chief medical officer's jumpskirt"
	desc = "It's a jumpskirt worn by those with the experience to be \"Chief Medical Officer\". It provides minor biological protection."
	icon_state = "cmo_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/geneticist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a genetics rank stripe on it."
	name = "geneticist's jumpsuit"
	icon = 'icons/obj/clothing/under/rnd.dmi' //WS Edit - Gen/Sci Split
	mob_overlay_icon = 'icons/mob/clothing/under/rnd.dmi' //WS Edit - Gen/Sci Split
	icon_state = "genetics"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/medical/geneticist/skirt
	name = "geneticist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a genetics rank stripe on it."
	icon_state = "geneticswhite_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/virologist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	name = "virologist's jumpsuit"
	icon_state = "virology"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/medical/virologist/skirt
	name = "virologist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	icon_state = "virologywhite_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/doctor/nurse
	desc = "It's a jumpsuit commonly worn by nursing staff in the medical department."
	name = "nurse's suit"
	icon_state = "nursesuit"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/doctor
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpsuit"
	icon_state = "medical"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/rank/medical/doctor/blue
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in baby blue."
	icon_state = "scrubsblue"
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/doctor/green
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in dark green."
	icon_state = "scrubsgreen"
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/doctor/purple
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in deep purple."
	icon_state = "scrubspurple"
	can_adjust = FALSE

/obj/item/clothing/under/rank/medical/doctor/skirt
	name = "medical doctor's jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	icon_state = "medical_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	name = "chemist's jumpsuit"
	icon_state = "chemistry"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 65)

/obj/item/clothing/under/rank/medical/chemist/skirt
	name = "chemist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a chemist rank stripe on it."
	icon_state = "chemistrywhite_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/paramedic
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a dark blue cross on the chest denoting that the wearer is a trained paramedic."
	name = "paramedic jumpsuit"
	icon_state = "paramedic"
	item_state = "w_suit"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/medical/paramedic/skirt
	name = "paramedic jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a dark blue cross on the chest denoting that the wearer is a trained paramedic."
	icon_state = "paramedic_skirt"
	item_state = "w_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

//Alt job uniforms

/obj/item/clothing/under/rank/medical/chemist/pharmacist
	name = "pharmacist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. For those pharmacists that want to improve or worsen their crew's health."
	icon_state = "pharmacist"

/obj/item/clothing/under/rank/medical/chemist/pharmacist/skirt
	name = "pharmacist's jumpskirt"
	icon_state = "pharmacist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/chemist/pharmacologist
	name = "pharmacologist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. For those pharmacologist one step behind to being evil."
	icon_state = "pharmacologist"

/obj/item/clothing/under/rank/medical/chemist/pharmacologist/skirt
	name = "pharmacologist's jumpskirt"
	icon_state = "pharmacologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/chemist/junior_chemist
	name = "junior chemist's jumpsuit"
	desc = "It's made of a special fiber that gives special protection against biohazards. A jumpsuit for junior chemist staff."
	icon_state = "junior_chemistry"

/obj/item/clothing/under/rank/medical/chemist/junior_chemist/skirt
	name = "junior chemist's jumpskirt"
	desc = "It's made of a special fiber that gives special protection against biohazards. A jumpskirt for junior chemist staff."
	icon_state = "junior_chemistry_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/psychiatrist
	name = "white psychiatrist's suit"
	desc = "A turtleneck for personnel trained to deal with psychological issues, such as terrible work place incidents or the clown's bad jokes. This one has a white turtleneck."
	icon_state = "psychiatrist-white"

	can_adjust = FALSE

	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

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
	icon_state = "junior_medical"

/obj/item/clothing/under/rank/medical/doctor/junior_doctor/skirt
	name = "junior doctor's jumpskirt"
	icon_state = "junior_medical_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/cmo
	name = "medical director suit"
	desc = "A suit with medical colors, meant to be worn by those who lead the medical department."
	icon_state = "medical_director"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	icon = 'icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/suit/cmo/skirt
	name = "medical director skirtsuit"
	desc = "A skirtsuit with medical colors, meant to be worn by those who lead the medical department."
	icon_state = "medical_director_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/chief_medical_officer/surgeon_general
	name = "surgeon-general scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is meant to be worn by surgeon-generals."
	icon_state = "surgeon_general"
	can_adjust = FALSE

/obj/item/clothing/under/suit/senior_doctor
	name = "senior doctor suit"
	desc = "A suit with medical colors, meant to be worn by senior staff."
	icon_state = "senior_medical"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	icon = 'icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/suit/senior_doctor/skirt
	name = "senior doctor skirtsuit"
	desc = "A skirtsuit with medical colors, meant to be worn by senior staff."
	icon_state = "senior_medical_skirt"

	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/senior_chemist
	name = "senior chemist suit"
	desc = "A suit with chemistry colors, meant to be worn by senior staff."
	icon_state = "senior_chemistry"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 65)
	icon = 'icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/suit/senior_chemist/skirt
	name = "senior chemist suit"
	desc = "A skirtsuit with chemistry colors, meant to be worn by senior staff."
	icon_state = "senior_chemistry_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/pathologist
	name = "pathologist suit"
	desc = "A suit with special fibers that provide minor protection against biohazards. A suit with green pants, provided to pathologists."
	icon_state = "pathologist"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	icon = 'icons/obj/clothing/under/medical.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/medical.dmi'

/obj/item/clothing/under/suit/pathologist/skirt
	name = "pathologist suit"
	desc = "A suit with special fibers that provide minor protection against biohazards. A skirtsuit with green pants, provided to pathologists."
	icon_state = "pathologist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/paramedic/emt
	name = "emergency medical technician jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has shorts, allowing ease of movement for EMTs."
	icon_state = "emt"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/under/rank/medical/paramedic/emt/skirt
	name = "emergency medical technician jumpskirt"
	desc = "It's made of a special fiber that provides minor protection against biohazards."
	icon_state = "emt_skirt"
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/medical/doctor/red
	name = "medical scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one is in red."
	icon_state = "scrubsred"
	can_adjust = FALSE
