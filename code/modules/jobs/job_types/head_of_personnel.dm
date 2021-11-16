/datum/job/head_of_personnel
	title = "Head of Personnel"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Captain")
	head_announce = list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_SERVICE)
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ddddff"
	minimal_player_age = 10
	exp_requirements = 180
	officer = TRUE
	wiki_page = "Head_of_Personnel" //WS Edit - Wikilinks/Warning
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SERVICE

	outfit = /datum/outfit/job/head_of_personnel

	access = list(
		ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
		ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
		ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
		ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
		ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
		ACCESS_MECH_MINING, ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
		ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(
		ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
		ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
		ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
		ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
		ACCESS_MECH_MINING, ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
		ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
		ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL

/datum/outfit/job/head_of_personnel
	name = "Head of Personnel"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/head_of_personnel
	ears = /obj/item/radio/headset/heads/head_of_personnel
	uniform = /obj/item/clothing/under/rank/command/head_of_personnel
	alt_uniform = /obj/item/clothing/under/rank/command/head_of_personnel/suit //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/ianshirt
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hopcap
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/head_of_personnel)

/datum/outfit/job/head_of_personnel/pre_equip(mob/living/carbon/human/H)
	..()
	if(locate(/datum/holiday/ianbirthday) in SSevents.holidays)
		undershirt = /datum/sprite_accessory/undershirt/ian

//Shiptest outfits

/datum/outfit/job/head_of_personnel/solgov
	name = "Executive Officer (SolGov)"
	uniform = /obj/item/clothing/under/rank/command/lieutenant
	head = /obj/item/clothing/head/solgov
	shoes = /obj/item/clothing/shoes/laceup

/datum/outfit/job/head_of_personnel/solgov/rebel
	name = "Executive Officer (Deserter)"
	head = /obj/item/clothing/head/solgov/terragov

/datum/outfit/job/head_of_personnel/pirate
	name = "First Mate (Pirate)"
	uniform = /obj/item/clothing/under/costume/russian_officer
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/pirate
	suit = /obj/item/clothing/suit/pirate
