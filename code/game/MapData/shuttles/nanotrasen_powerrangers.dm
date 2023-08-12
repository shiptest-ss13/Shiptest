//Clothes
/obj/item/clothing/under/rank/security/head_of_security/nt/skirt/lp
	name = "LP Security Specialist's Jumpskirt"
	desc = "A standard Jumpskirt belonging to the Security Specialist of the Loss Previention team."

/obj/item/clothing/under/rank/security/head_of_security/nt/lp
	name = "LP Security Specialist's Jumpsuit"
	desc = "The ERT ran out of outfits to give to the LP, so they gave them station spares. This one belongs to the LP Lieutenant."

/obj/item/clothing/under/rank/security/head_of_security/alt/lp
	name = "LP Lieutentant's 'Dramatic' Jumpsuit"
	desc = "The first LP Lieutenant wasn't satisfied with the standard outfits given to them. So they requested something more 'Dramatic'."

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	name = "LP Lieutenant's 'Dramatic' Jumpskirt"
	desc = "The first LP Lieutenant wasn't satisfied with the standard outfits given to them. So they requested something more 'Dramatic'."

/obj/item/clothing/under/rank/security/warden/skirt/lp
	name = "LP Lieutenant's Jumpskirt"
	desc = "A standard Jumpskirt belonging to the Lieutenant of the Loss Previention team."

/obj/item/clothing/under/rank/security/warden/lp
	name = "LP Lieutenant's Jumpsuit"
	desc = "The ERT ran out of outfits to give to the LP, so they gave them station spares. This one belongs to the LP Lieutenant."

/obj/item/clothing/under/rank/engineering/engineer/lp
	name = "LP Engineering Specialist's Jumpsuit"
	desc = "The ERT ran out of outfits to give to the LP, so they gave them station spares. This one belongs to the LP Engineering Specialist."

/obj/item/clothing/under/rank/engineering/engineer/skirt/lp
	name = "LP Engineering Specialist's Jumpskirt"
	desc = "A standard Jumpskirt belonging to the Engineering Specialist of the Loss Previention team."

/obj/item/clothing/under/rank/medical/paramedic/lp
	name = "LP Medical Specialist's Jumpsuit"
	desc = "The ERT ran out of outfits to give to the LP, so they gave them station spares. This one belongs to the LP Medical Specialist."

/obj/item/clothing/under/rank/medical/paramedic/skirt/lp
	name = "LP Medical Specialist's Jumpskirt"
	desc = "A standard Jumpskirt belonging to the Medical Specialist of the Loss Previention team."


//closets
/obj/structure/closet/secure_closet/lp/lieutenant
	name = "lietenant's closet"
	desc = "It's the lieutenant's closet."
	icon_state = "blueshield"
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/lp/security
	name = "security specialist's closet"
	desc = "It's the security specialist's closet."
	icon_state = "hos"
	req_one_access = list(ACCESS_SECURITY)

/obj/structure/closet/secure_closet/lp/engineer
	name = "engineering specialist's closet"
	desc = "It's the engineering specialist's closet."
	icon_state = "eng_secure"
	req_one_access = list(ACCESS_ENGINE)

/obj/structure/closet/secure_closet/lp/medical
	name = "medical specialist's closet"
	desc = "It's the medical specialist's closet."
	icon_state = "med"
	req_one_access = list(ACCESS_MEDICAL)

//IDs

/obj/item/card/id/lpengie
	desc = "The LP Engineering Specialist's ID card."
	icon_state = "ert_engineer"
	name = "LP Engineering Specialist"

/obj/item/card/id/lpmed
	desc = "The LP Medical Specialist's ID card."
	icon_state = "ert_medic"
	name = "LP Medical Specialist"

/obj/item/card/id/lpsec
	desc = "The LP Security Specialist's ID card."
	icon_state = "ert_security"
	name = "LP Security Specialist"

/obj/item/card/id/lplieu
	name = "LP Lieutenant's ID"
	desc = "The LP Lieutenant's ID card."
	icon_state = "ert_commander"



//Holocalls
/datum/preset_holoimage/commissioner
	outfit_type = /datum/outfit/job/captain/nt/lp_lieutenant

//hardsuits
/obj/item/clothing/suit/space/hardsuit/ert/lp
	name = "Loss Prevention Lieutenant Hardsuit"
	desc = "The middlemanagement of the ERT world, the Lieutenant of the LP team is given this slightly downgraded version of the ERT Commander hardsuit."
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/lp
	resistance_flags = null
	max_heat_protection_temperature = null
	slowdown = 1.2

/obj/item/clothing/head/helmet/space/hardsuit/ert/lp
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 80)
	name = "Loss Prevention Lieutenant Hardsuit Helmet"
	desc = "The helmet that comes attached to the LP Team Lieutenant Hardsuit."
	resistance_flags = null
	max_heat_protection_temperature = null

/obj/item/clothing/suit/space/hardsuit/ert/lp/sec
	armor = list("melee" = 35, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/lp/sec
	name = "Loss Prevention Security Hardsuit"
	desc = "The best of the best security staff get assigned to the ERT. Second best are given this Hardsuit as a part of the LP Team."
	icon_state = "ert_security"
	item_state = "ert_security"

/obj/item/clothing/head/helmet/space/hardsuit/ert/lp/sec
	armor = list("melee" = 35, "bullet" = 20, "laser" = 30,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	hardsuit_type = "ert_security"
	name = "Loss Prevention Security Hardsuit Helmet"
	desc = "The helmet that comes attached to the LP Team Security Hardsuit."
	icon_state = "hardsuit0-ert_security"
	item_state = "hardsuit0-ert_security"

/obj/item/clothing/suit/space/hardsuit/ert/lp/engi
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/lp/engi
	name = "Loss Prevention Engineering Hardsuit"
	desc = "The best of the best engineering staff get assigned to the ERT. Second best are given this Hardsuit as a part of the LP Team."
	icon_state = "ert_engineer"
	item_state = "ert_engineer"

/obj/item/clothing/head/helmet/space/hardsuit/ert/lp/engi
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 75)
	name = "Loss Prevention Engineering Hardsuit Helmet"
	desc = "The helmet that comes attached to the LP Team Engineering Hardsuit."
	icon_state = "hardsuit0-ert_engineer"
	item_state = "hardsuit0-ert_engineer"
	hardsuit_type = "ert_engineer"

/obj/item/clothing/suit/space/hardsuit/ert/lp/med
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/lp/med
	name = "Loss Prevention Medical Hardsuit"
	desc = "The best of the best medical staff get assigned to the ERT. Second best are given this Hardsuit as a part of the LP Team."
	icon_state = "ert_medical"
	item_state = "ert_medical"

/obj/item/clothing/head/helmet/space/hardsuit/ert/lp/med
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)
	name = "Loss Prevention Medical Hardsuit Helmet"
	desc = "The helmet that comes attached to the LP Team Medical Hardsuit."
	icon_state = "hardsuit0-ert_medical"
	item_state = "hardsuit0-ert_medical"
	hardsuit_type = "ert_medical"

/obj/item/clothing/head/helmet/space/hardsuit/lp
	name = "RIG heatsuit helmet"
	desc = "The helmet to the RIG heat suit. It's packed with heat diverting materials, coolant pipes, and a two inch thick face screen."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = ACID_PROOF | FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/ancient/lp
	name = "RIG heat suit"
	desc = "A fully heat resistance suit based on an early RIG hardsuit prototype. It sacrifices armor of any kind for intricate heatsinks. It remains rather bulky as a result."
	armor = list("melee" = 5, "bullet" = 5, "laser" = 1, "energy" = 1, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/lp
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = ACID_PROOF | FIRE_PROOF

//lootdrop
/obj/effect/spawner/lootdrop/lpcombat
	name = "LP Combat Missions"
	lootdoubles = FALSE

	loot = list(
		/obj/item/disk/holodisk/lp/combat/syndicate1 = 1,
		/obj/item/disk/holodisk/lp/combat/syndicate2 = 1,
		/obj/item/disk/holodisk/lp/combat/syndicate3 = 1,
		/obj/item/disk/holodisk/lp/combat/syndicate4 = 1,
		/obj/item/disk/holodisk/lp/combat/megafauna = 5,
		/obj/item/disk/holodisk/lp/combat/bdm = 5,
		/obj/item/disk/holodisk/lp/combat/tumor = 5,
		/obj/item/disk/holodisk/lp/combat/bloodred = 5
	)

	lootcount = 2

/obj/effect/spawner/lootdrop/lpretrieval
	name = "LP Retrieval Missions"
	lootdoubles = FALSE

	loot = list(
		/obj/item/disk/holodisk/lp/retrieval/supersuit = 1,
		/obj/item/disk/holodisk/lp/retrieval/phazon = 1,
		/obj/item/disk/holodisk/lp/retrieval/durand = 1,
		/obj/item/disk/holodisk/lp/retrieval/gunstock = 1,
		/obj/item/disk/holodisk/lp/retrieval/artifact = 1,
		/obj/item/disk/holodisk/lp/retrieval/materials = 1
	)

	lootcount = 2

/obj/effect/spawner/lootdrop/lpaid
	name = "LP Aid Missions"
	lootdoubles = FALSE

	loot = list(
		/obj/item/disk/holodisk/lp/aid/recruits = 1,
		/obj/item/disk/holodisk/lp/aid/repairs = 1,
		/obj/item/disk/holodisk/lp/aid/rescue = 1,
		/obj/item/disk/holodisk/lp/aid/guard = 1,
	)

	lootcount = 2

