/obj/effect/mob_spawn/human/syndicate/battlecruiser/captain/mini
	name = "Gorelex Captain"
	short_desc = "You are the captain aboard the Syndicate destroyer: the SBD Starfury's Revenge."
	flavour_text = "Pirates have been detected in this region of space. As the Syndicate wish to push their claim over this region, you have been sent in to deal with the pirates in this area. This also serves as a training ground for new recruits to become operatives, since pirates should be easy pickings... Right?."
	important_info = ""
	id_access_list = list(150,151,3)
	id_job = "Gorelex Captain"
	assignedrole = "Gorelex Captain"

/obj/effect/mob_spawn/human/syndicate/battlecruiser/assault/mini
	name = "Gorelex Operative"
	short_desc = "You are an operative aboard the syndicate destroyer: the SBD Starfury's Revenge."
	flavour_text = "You have been taken from the front lines for a more specialised role. Your job is to train the various new recruits on field against simple targets: pirates. Or so, they should be easy..."
	important_info = "you are basicly a warden"
	id_access_list = list(150,3)
	outfit = /datum/outfit/syndicate_empty/sbc/assault
	assignedrole = "Gorelex Operative"
	id_job = "Gorelex Operative"

/obj/effect/mob_spawn/human/syndicate/battlecruiser/mini
	name = "Gorelex Trooper"
	short_desc = "You are a crewmember aboard the syndicate destroyer: the SBD Starfury's Revenge."
	flavour_text = "You are a new or inexperienced recruit for the syndicate, specificly for the Gorelex Mauderaders. You have been taken here for a more 'hands on' training. Your job is to follow your higher-ranking operatives' orders. ."
	important_info = "Despite what the role implies, you are supposed to be a security officer, however here you are the lowest ranking crew member."
	outfit = /datum/outfit/syndicate_empty/sbc/mini
	assignedrole = "Gorelex Trooper"
	id_job = "Gorelex Trooper"

/obj/effect/mob_spawn/human/syndicate/battlecruiser/medical/mini
	name = "Cybersun Medic"
	short_desc = "You are a medic aboard the Syndicate destroyer: the SBD Starfury's Revenge."
	flavour_text = "Your job is to maintain the crew's physical health and keep your comrades alive at all cost. You aren't apart of the crew's corpration, however if you want to keep a job and not die you should listen to the captain."
	important_info = ""
	outfit = /datum/outfit/syndicate_empty/sbc/med/mini
	assignedrole = "Cybersun Medic"
	id_job = "Cybersun Medic"

/obj/effect/mob_spawn/human/syndicate/battlecruiser/engineering/mini
	name = "TamosCorp Engineer"
	short_desc = "You are an engineer aboard the Syndicate destroyer: the SBD Starfury's Revenge."
	flavour_text = "Your job is to maintain the ship, and keep the engine running while the troopers are doing fuck-all. If you are unfamiliar with how the supermatter engine functions, do not attempt to start it alone; ask a fellow crewman for help."
	important_info = ""
	outfit = /datum/outfit/syndicate_empty/sbc/engi/mini
	assignedrole = "TamosCorp Engineer"
	id_job = "TamosCorp Engineer"

/datum/outfit/syndicate_empty/sbc/med/mini
	name = "Ministarfury Medic"
	uniform = /obj/item/clothing/under/syndicate/intern
	glasses = /obj/item/clothing/glasses/hud/health/prescription
	l_pocket = /obj/item/gun/energy/e_gun/mini
	r_hand = null
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1, /obj/item/storage/firstaid/medical, /obj/item/storage/firstaid/tactical, /obj/item/storage/box/medipens=3)

/datum/outfit/syndicate_empty/sbc/mini
	name = "Ministarfury Trooper"
	uniform = /obj/item/clothing/under/syndicate/camo

/datum/outfit/syndicate_empty/sbc/engi/mini
	name = "Ministarfury Engineer"
	uniform = /obj/item/clothing/under/syndicate/intern
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1, /obj/item/construction/rcd/combat, /obj/item/rcd_ammo/large, /obj/item/stack/sheet/mineral/plastitanium=50)
