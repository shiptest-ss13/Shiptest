/datum/outfit/job/nanotrasen
	name = "Nanotrasen Base Outfit"

	box = /obj/item/storage/box/survival
	id = /obj/item/card/id


/datum/outfit/job/nanotrasen/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_NANOTRASEN)

// Captain

/datum/outfit/job/nanotrasen/captain
	name = "Nanotrasen - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/captain/nt
	ears = /obj/item/radio/headset/nanotrasen/captain
	uniform = /obj/item/clothing/under/rank/command/captain/nt
	alt_uniform = /obj/item/clothing/under/rank/command/captain/parade //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/caphat/nt
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/nanotrasen/captain/lp
	name = "Nanotrasen - Loss Prevention Lieutenant"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/alt/skirt/lp
	dcoat = /obj/item/clothing/suit/jacket
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/command

	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

/datum/outfit/job/nanotrasen/captain/centcom
	name = "Nanotrasen - Captain (Central Command)"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/centhat
	suit = /obj/item/clothing/suit/armor/vest/bulletproof

// Head of Personnel

/datum/outfit/job/nanotrasen/hop
	name = "Nanotrasen - First Officer"

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/nanotrasen
	uniform = /obj/item/clothing/under/rank/command/head_of_personnel/nt
	alt_uniform = null
	alt_suit = null
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/hopcap/nt

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

// Head of Security

/datum/outfit/job/nanotrasen/hos
	name = "Nanotrasen - Head of Security"
	job_icon = "headofsecurity"
	jobtype = /datum/job/hos

	id = /obj/item/card/id/silver
	belt = /obj/item/pda/heads/hos
	ears = /obj/item/radio/headset/nanotrasen/alt
	uniform = /obj/item/clothing/under/rank/security/head_of_security/nt
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/hos/trenchcoat
	alt_suit = /obj/item/clothing/suit/armor/vest/security/hos
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security //WS Edit - Alt Uniforms
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec/hos
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit_store = null
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(/obj/item/melee/classic_baton=1)

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/e_gun/hos, /obj/item/stamp/hos)

// Roboticist

/datum/outfit/job/nanotrasen/roboticist
	name = "Nanotrasen - Mech Technician"

	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/longcoat/robowhite
	ears = /obj/item/radio/headset/nanotrasen
	glasses = /obj/item/clothing/glasses/welding

	backpack_contents = list(/obj/item/weldingtool/hugetank)

// Pilot. idk

/datum/outfit/job/nanotrasen/pilot
	name = "Nanotrasen - Pilot"

	uniform = /obj/item/clothing/under/rank/security/officer/military
	suit = /obj/item/clothing/suit/jacket/leather/duster
	glasses = /obj/item/clothing/glasses/hud/spacecop
	accessory = /obj/item/clothing/accessory/holster
	head = /obj/item/clothing/head/beret/command

// Security Officer

/datum/outfit/job/nanotrasen/security
	name = "Nanotrasen - Security Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/nt
	alt_uniform = null
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

/datum/outfit/job/nanotrasen/security/ert
	name = "Nanotrasen - ERT Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/military
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/kitchen/knife/combat/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

/datum/outfit/job/nanotrasen/security/ert/engi
	name = "Nanotrasen - ERT Engineering Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = null
	backpack = /obj/item/storage/backpack/ert/engineer
	belt = /obj/item/storage/belt/utility/full/ert
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/kitchen/knife/combat/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/engine
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/job/nanotrasen/security/ert/med
	name = "Nanotrasen - ERT Medical Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/camo
	head = /obj/item/clothing/head/beret/med
	backpack = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	id = /obj/item/card/id/ert/security
	r_pocket = /obj/item/kitchen/knife/combat/survival
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)
	accessory = /obj/item/clothing/accessory/armband/med
	glasses = /obj/item/clothing/glasses/hud/health/night

/datum/outfit/job/nanotrasen/security/mech_pilot
	name = "Nanotrasen - Mech Pilot"

	uniform = /obj/item/clothing/under/rank/security/officer/military/eng
	head = /obj/item/clothing/head/beret/sec/officer
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	backpack_contents = list(/obj/item/radio, /obj/item/flashlight/seclite)

/datum/outfit/job/nanotrasen/security/lp
	name = "Nanotrasen - Loss Prevention Security Specialist"

	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lpsec
	belt = /obj/item/pda/security
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/skirt/lp
	alt_uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/lp
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec

	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

// Engineer

/datum/outfit/job/nanotrasen/engineer
	name = "Nanotrasen - Engineer"
	uniform = /obj/item/clothing/under/rank/engineering/engineer/nt
	head = /obj/item/clothing/head/hardhat

// Warden

/datum/outfit/job/nanotrasen/warden
	name = "Nanotrasen - Warden"

	ears = /obj/item/radio/headset/nanotrasen/alt
	head = /obj/item/clothing/head/warden/red
	uniform = /obj/item/clothing/under/rank/security/warden/nt
	suit = /obj/item/clothing/suit/armor/vest/security/warden/alt/nt
	alt_uniform = null
	alt_suit = null
