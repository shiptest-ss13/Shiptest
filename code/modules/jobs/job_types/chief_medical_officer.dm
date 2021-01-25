/datum/job/cmo
	title = "Chief Medical Officer"
	department_head = list("Captain")
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	head_announce = list(RADIO_CHANNEL_MEDICAL)
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ffddf0"
	req_admin_notify = 1
	minimal_player_age = 7
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_MEDICAL
	wiki_page = "Chief_Medical_Officer"

	outfit = /datum/outfit/job/cmo

	access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_PHARMACY, ACCESS_HEADS, ACCESS_MINERAL_STOREROOM, //WS edit - Gen/Sci Split
			ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_CMO, ACCESS_SURGERY, ACCESS_RC_ANNOUNCE, ACCESS_MECH_MEDICAL,
			ACCESS_KEYCARD_AUTH, ACCESS_SEC_DOORS, ACCESS_MAINT_TUNNELS)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_MORGUE, ACCESS_GENETICS, ACCESS_PHARMACY, ACCESS_HEADS, ACCESS_MINERAL_STOREROOM, //WS edit - Gen/Sci Split
			ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_CMO, ACCESS_SURGERY, ACCESS_RC_ANNOUNCE, ACCESS_MECH_MEDICAL,
			ACCESS_KEYCARD_AUTH, ACCESS_SEC_DOORS, ACCESS_MAINT_TUNNELS)
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER

/datum/outfit/job/cmo
	name = "Chief Medical Officer"
	jobtype = /datum/job/cmo

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/cmo
	l_pocket = /obj/item/pinpointer/crew
	ears = /obj/item/radio/headset/heads/cmo
	uniform = /obj/item/clothing/under/rank/medical/chief_medical_officer
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/blue //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/mad //WS Edit - Alt-Job Titles
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //WS Edit - Alt Uniforms
	l_hand = /obj/item/storage/firstaid/medical
	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = list(/obj/item/gun/syringe, /obj/item/stamp/cmo)

/datum/outfit/job/cmo/hardsuit
	name = "Chief Medical Officer (Hardsuit)"

	mask = /obj/item/clothing/mask/breath/medical
	suit = /obj/item/clothing/suit/space/hardsuit/medical/cmo
	suit_store = /obj/item/tank/internals/oxygen
	r_pocket = /obj/item/flashlight/pen

/datum/outfit/job/cmo/medicaldirector
	name = "Chief Medical Officer (Medical Director)"

	uniform = /obj/item/clothing/under/suit/cmo
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/cmo
	alt_suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	neck = /obj/item/clothing/neck/tie/blue
	l_hand = null
	suit_store = null
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/storage/firstaid/medical=1, /obj/item/flashlight/pen=1)

/datum/outfit/job/cmo/surgeongeneral
	name = "Chief Medical Officer (Surgeon-General)"

	uniform = /obj/item/clothing/under/rank/medical/chief_medical_officer/surgeon_general
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/labcoat/cmo
	alt_suit = null
	l_hand = null
	suit_store = null
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/storage/firstaid/medical=1, /obj/item/flashlight/pen=1)
