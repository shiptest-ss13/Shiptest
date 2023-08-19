/datum/job/brig_phys
	name = "Brig Physician"
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 7
	wiki_page = "Guide_to_Medicine" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/brig_phys

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MEDICAL, ACCESS_EVA)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MEDICAL)
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BRIG_PHYS

/datum/outfit/job/brig_phys
	name = "Brig Physician"
	job_icon = "brigphysician"
	jobtype = /datum/job/brig_phys

	belt = /obj/item/pda/brig_phys
	ears = /obj/item/radio/headset/headset_medsec/alt
	uniform = /obj/item/clothing/under/rank/security/brig_phys
	shoes = /obj/item/clothing/shoes/sneakers/white
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	alt_suit = /obj/item/clothing/suit/armor/vest/security/brig_phys
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	suit_store = /obj/item/flashlight/pen
	l_hand = /obj/item/storage/firstaid/regular
	head = /obj/item/clothing/head/soft/sec/brig_phys
	implants = list(/obj/item/implant/mindshield)


/datum/outfit/job/brig_phys/securitymedic
	name = "Brig Physician (Security Medic)"

	uniform = /obj/item/clothing/under/rank/security/brig_phys/nt
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	suit_store = /obj/item/flashlight/pen
	alt_suit = null

/datum/outfit/job/brig_phys/executionsupervisor
	name = "Brig Physician (Execution Supervisor)"

	uniform = /obj/item/clothing/under/rank/security/brig_phys/nt
	suit = /obj/item/clothing/suit/toggle/labcoat/brig_phys
	l_pocket = /obj/item/reagent_containers/syringe
	alt_suit = null

/datum/outfit/job/brig_phys/syndicate/sbc
	name = "Medic (Twinkleshine)"

	uniform = /obj/item/clothing/under/rank/medical/doctor/red
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	alt_uniform = /obj/item/clothing/under/syndicate/cybersun
	glasses = /obj/item/clothing/glasses/hud/health
	belt = /obj/item/storage/belt/medical
	back = /obj/item/storage/backpack/duffelbag/syndie/med
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/longcoat/roboblack
	alt_suit = /obj/item/clothing/suit/toggle/labcoat
	suit_store =  null
	head = null
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/gas/syndicate/voicechanger
	id = /obj/item/card/id/syndicate_command/crew_id/med
	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/pda/brig_phys)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie/med
	courierbag = /obj/item/storage/backpack/messenger/sec

	box = /obj/item/storage/box/survival/syndie

/datum/outfit/job/brig_phys/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(6, 8)) // squidquest real
	I.assignment = "Medic"
	I.access |= list(ACCESS_SYNDICATE)
	I.update_label()
