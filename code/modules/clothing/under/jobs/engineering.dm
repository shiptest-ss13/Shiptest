//Contains: Engineering department jumpsuits

/obj/item/clothing/under/rank/engineering
	icon = 'icons/obj/clothing/under/engineering.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/engineering.dmi'

/obj/item/clothing/under/rank/engineering/chief_engineer
	desc = "It's a high visibility jumpsuit given to those engineers insane enough to achieve the rank of \"Chief Engineer\". It has minor radiation shielding."
	name = "chief engineer's jumpsuit"
	icon_state = "chiefengineer"
	item_state = "gy_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 80, "acid" = 40)
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/chief_engineer/skirt
	name = "chief engineer's jumpskirt"
	desc = "It's a high visibility jumpskirt given to those engineers insane enough to achieve the rank of \"Chief Engineer\". It has minor radiation shielding."
	icon_state = "chief_skirt"
	item_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/atmospheric_technician
	desc = "It's a jumpsuit worn by atmospheric technicians."
	name = "atmospheric technician's jumpsuit"
	icon_state = "atmos"
	item_state = "atmos_suit"
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt
	name = "atmospheric technician's jumpskirt"
	desc = "It's a jumpskirt worn by atmospheric technicians."
	icon_state = "atmos_skirt"
	item_state = "atmos_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/engineer
	desc = "A thick blue jumpsuit worn by civilian mechanics. It's made from fire-resistant materials."
	name = "mechanic's jumpsuit"
	icon_state = "engine"
	item_state = "b_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 60, "acid" = 20)
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/engineer/nt
	desc = "It's an yellow high visibility jumpsuit worn by Nanotrasen contracted engineers. It has minor radiation shielding."
	name = "engineer's jumpsuit"
	icon_state = "engine_nt"
	item_state = "engi_suit"

/obj/item/clothing/under/rank/engineering/engineer/nt/skirt
	name = "engineer's jumpskirt"
	desc = "It's an orange high visibility jumpskirt worn by Nanotrasen contracted engineers."
	icon_state = "engine_nt_skirt"
	item_state = "engi_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/engineer/hazard
	name = "engineer's hazard jumpsuit"
	desc = "A high visibility jumpsuit made from heat and radiation resistant materials."
	icon_state = "hazard_eng"
	item_state = "suit-orange"
	alt_covers_chest = TRUE


//Alt job clothing

/obj/item/clothing/under/rank/engineering/engineer/junior
	name = "junior engineer jumpsuit"
	desc = "A jumpsuit worn by junior engineers. It has minor radiation shielding."
	icon_state = "junior_engineer"

/obj/item/clothing/under/rank/engineering/engineer/junior/skirt
	name = "junior engineer jumpskirt"
	desc = "A jumpskirt worn by junior engineers. It has minor radiation shielding."
	icon_state = "junior_engineer_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/engineer/electrician
	name = "electrician jumpsuit"
	desc = "A jumpsuit worn by electricians, made of old insulated gloves. It has minor radiation shielding."
	icon_state = "electrician"

/obj/item/clothing/under/rank/engineering/engineer/electrician/skirt
	name = "electrician jumpskirt"
	desc = "A jumpskirt worn by electricians, made of old insulated gloves. It has minor radiation shielding."
	icon_state = "electrician_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/engineer/maintenance_tech
	name = "maintenance technician jumpsuit"
	desc = "A jumpsuit worn by maintenance technicians, to easily disappear and never be seen again in the maintanance tunnels... It has minor radiation shielding."
	icon_state = "maintenance_tech"

/obj/item/clothing/under/rank/engineering/engineer/maintenance_tech/skirt
	name = "maintenance technician jumpskirt"
	desc = "A jumpskirt worn by maintenance technicians, to easily disappear and never be seen again in the maintanance tunnels... It has minor radiation shielding."
	icon_state = "maintenance_tech_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/engineer/telecomm_specialist
	name = "telecommunications specialist jumpsuit"
	desc = "A jumpsuit worn by telecomm specialist, perfect for those who had earned a space communication degree. It has minor radiation shielding."
	icon_state = "telecomm_specialist"

/obj/item/clothing/under/rank/engineering/engineer/telecomm_specialist/skirt
	name = "telecommunications specialist jumpskirt"
	desc = "A jumpskirt worn by telecomm specialist, perfect for those who had earned a space communication degree. It has minor radiation shielding."
	icon_state = "telecomm_specialist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/ce
	name = "engineering coordinator suit"
	desc = "A suit with engineering colors, worn by those who lead and have survived the engineering department."
	icon_state = "senior_medical"
	icon = 'icons/obj/clothing/under/engineering.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/engineering.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 80, "acid" = 40)
	resistance_flags = NONE

/obj/item/clothing/under/suit/ce/skirt
	name = "engineering coordinator skirtsuit"
	desc = "A skirtsuit with engineering colors, worn by those who lead and have survived the engineering department."
	icon_state = "engineering_coordinator_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/senior_engineer
	name = "senior engineer suit"
	desc = "A suit with engineering colors, meant to be worn by senior staff."
	icon_state = "senior_engineer"
	icon = 'icons/obj/clothing/under/engineering.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/engineering.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 60, "acid" = 20)
	resistance_flags = NONE

/obj/item/clothing/under/suit/senior_engineer/skirt
	name = "senior engineer skirtsuit"
	desc = "A skirtsuit with engineering colors, meant to be worn by senior staff."
	icon_state = "senior_engineer_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/suit/senior_atmos
	name = "senior atmospheric technician suit"
	desc = "A suit with atmospheric colors, meant to be worn by senior staff."
	icon = 'icons/obj/clothing/under/engineering.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/engineering.dmi'
	icon_state = "senior_atmos"

/obj/item/clothing/under/suit/senior_atmos/skirt
	name = "senior atmospheric technician skirtsuit"
	desc = "A skirtsuit with atmospheric colors, meant to be worn by senior staff."
	icon_state = "senior_atmos_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/rank/engineering/atmospheric_technician/life_support_specialist
	name = "life support specialists's jumpsuit"
	desc = "It's a jumpsuit worn by life support specialists, who are the ones behind the fact you are able to breath and complain."
	icon_state = "life_support_specialist"
	resistance_flags = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/life_support_specialist/skirt
	name = "life support specialists's jumpskirt"
	desc = "It's a jumpskirt worn by life support specialists, who are the ones behind the fact you are able to breath and complain."
	icon_state = "life_support_specialist_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION


/obj/item/clothing/under/rank/engineering/atmospheric_technician/firefighter
	name = "firefighter's jumpsuit"
	desc = "It's a jumpsuit worn by firefigthers to help aid in dealing science caused fires. It is made of fire resistant materials."
	icon_state = "firefighter"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 0) //Same fire number as standard engineer uniform

/obj/item/clothing/under/rank/engineering/atmospheric_technician/firefighter/skirt
	name = "firefighter's jumpskirt"
	desc = "It's a jumpskirt worn by firefigthers to help aid in dealing science caused fires. It is made of fire resistant materials."
	icon_state = "firefighter_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION
