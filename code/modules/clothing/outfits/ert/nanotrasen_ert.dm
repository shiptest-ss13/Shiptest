// this is where the base ERT outfit goes
/datum/outfit/centcom/ert
	name = "ERT Common"

	mask = /obj/item/clothing/mask/gas/sechailer
	uniform = /obj/item/clothing/under/rank/centcom/official
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/headset_cent/alt

/datum/outfit/centcom/ert/post_equip(mob/living/carbon/human/human, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/id = human.wear_id
	if(id)
		id.registered_name = human.real_name
		id.update_label()
	..()

/datum/outfit/centcom/ert/commander
	name = "ERT Commander"

	id = /obj/item/card/id/ert
	suit = /obj/item/clothing/suit/space/hardsuit/ert
	suit_store = /obj/item/gun/energy/e_gun/hades
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	back = /obj/item/storage/backpack/ert
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1)
	l_pocket = /obj/item/melee/knife/switchblade

/datum/outfit/centcom/ert/commander/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/heads/captain
	R.recalculateChannels()

/datum/outfit/centcom/ert/commander/alert
	name = "ERT Commander - High Alert"

	mask = /obj/item/clothing/mask/gas/sechailer/swat
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/pulse/pistol=1)
	l_pocket = /obj/item/melee/transforming/energy/sword/saber

/datum/outfit/centcom/ert/security
	name = "ERT Security"

	id = /obj/item/card/id/ert/security
	suit = /obj/item/clothing/suit/space/hardsuit/ert/sec
	suit_store = /obj/item/gun/energy/e_gun/hades
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	back = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,
		/obj/item/melee/baton/loaded=1)

/datum/outfit/centcom/ert/security/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()

/datum/outfit/centcom/ert/security/alert
	name = "ERT Security - High Alert"

	suit_store = /obj/item/gun/energy/pulse/carbine
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,\
		/obj/item/melee/baton/loaded=1)

/datum/outfit/centcom/ert/medic
	name = "ERT Medic"

	id = /obj/item/card/id/ert/medical
	suit = /obj/item/clothing/suit/space/hardsuit/ert/med
	suit_store = /obj/item/gun/energy/e_gun/hades
	glasses = /obj/item/clothing/glasses/hud/health
	back = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical
	r_hand = /obj/item/storage/firstaid/regular
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/reagent_containers/hypospray/combat=1,\
		/obj/item/gun/medbeam=1)

/datum/outfit/centcom/ert/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()

/datum/outfit/centcom/ert/medic/alert
	name = "ERT Medic - High Alert"

	mask = /obj/item/clothing/mask/gas/sechailer/swat
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/pulse/pistol=1,\
		/obj/item/reagent_containers/hypospray/combat/nanites=1,\
		/obj/item/gun/medbeam=1)

/datum/outfit/centcom/ert/engineer
	name = "ERT Engineer"

	id = /obj/item/card/id/ert/engineer
	suit = /obj/item/clothing/suit/space/hardsuit/ert/engi
	suit_store = /obj/item/gun/energy/e_gun/hades
	glasses =  /obj/item/clothing/glasses/meson/engine
	back = /obj/item/storage/backpack/ert/engineer
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/rcd_ammo/large
	r_hand = /obj/item/storage/firstaid/regular
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/construction/rcd/loaded=1)


/datum/outfit/centcom/ert/engineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()

/datum/outfit/centcom/ert/engineer/alert
	name = "ERT Engineer - High Alert"

	mask = /obj/item/clothing/mask/gas/sechailer/swat
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/pulse/pistol=1,\
		/obj/item/construction/rcd/combat=1)

// official

/datum/outfit/centcom/centcom_official
	name = "CentCom Official"

	uniform = /obj/item/clothing/under/rank/centcom/official
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/gun/energy/e_gun
	l_pocket = /obj/item/pen
	back = /obj/item/storage/backpack/satchel
	r_pocket = /obj/item/pda/heads
	l_hand = /obj/item/clipboard
	id = /obj/item/card/id/centcom
	backpack_contents = list(/obj/item/stamp/centcom=1)

/datum/outfit/centcom/centcom_official/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/pda/heads/pda = H.r_store
	pda.owner = H.real_name
	pda.ownjob = "CentCom Official"
	pda.update_label()

	var/obj/item/card/id/W = H.wear_id
	W.access = get_centcom_access("CentCom Official")
	W.access += ACCESS_WEAPONS
	W.assignment = "CentCom Official"
	W.registered_name = H.real_name
	W.update_label()
	..()

/datum/outfit/centcom/ert/janitor
	name = "ERT Janitor"

	id = /obj/item/card/id/ert/janitor
	suit = /obj/item/clothing/suit/space/hardsuit/ert/jani
	glasses = /obj/item/clothing/glasses/night
	back = /obj/item/storage/backpack/ert/janitor
	belt = /obj/item/storage/belt/janitor/full
	r_pocket = /obj/item/grenade/chem_grenade/cleaner
	l_pocket = /obj/item/grenade/chem_grenade/cleaner
	l_hand = /obj/item/storage/bag/trash/bluespace
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/lights/mixed=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/mop/advanced=1,\
		/obj/item/reagent_containers/glass/bucket=1,\
		/obj/item/grenade/clusterbuster/cleaner=1)

/datum/outfit/centcom/ert/janitor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()

/datum/outfit/centcom/ert/janitor/heavy
	name = "ERT Janitor - Heavy Duty"

	mask = /obj/item/clothing/mask/gas/sechailer/swat
	r_hand = /obj/item/reagent_containers/spray/chemsprayer/janitor
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/lights/mixed=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/grenade/clusterbuster/cleaner=3)

/datum/outfit/centcom/centcom_intern
	name = "CentCom Intern"

	uniform = /obj/item/clothing/under/rank/centcom/intern
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/melee/classic_baton
	r_hand = /obj/item/gun/ballistic/rifle/illestren
	back = /obj/item/storage/backpack/satchel
	l_pocket = /obj/item/ammo_box/magazine/illestren_a850r
	r_pocket = /obj/item/ammo_box/magazine/illestren_a850r
	id = /obj/item/card/id/centcom
	backpack_contents = list(/obj/item/storage/box/survival = 1)
/datum/outfit/centcom/centcom_intern/unarmed
	name = "CentCom Intern (Unarmed)"
	belt = null
	l_hand = null
	l_pocket = null
	r_pocket = null

/datum/outfit/centcom/centcom_intern/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	W.access = get_centcom_access(name)
	W.access += ACCESS_WEAPONS
	W.assignment = name
	W.registered_name = H.real_name
	W.update_label()

/datum/outfit/centcom/centcom_intern/leader
	name = "CentCom Head Intern"
	belt = /obj/item/melee/baton/loaded
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/rifle/illestren
	r_hand = /obj/item/megaphone
	head = /obj/item/clothing/head/intern

/datum/outfit/centcom/centcom_intern/leader/unarmed // i'll be nice and let the leader keep their baton and vest
	name = "CentCom Head Intern (Unarmed)"
	suit_store = null
	l_pocket = null
	r_pocket = null

// Marine

/datum/outfit/centcom/ert/marine
	name = "Marine Commander"

	id = /obj/item/card/id/ert
	suit = /obj/item/clothing/suit/armor/vest/marine
	back = /obj/item/storage/backpack/ert
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/gun_voucher/nanotrasen = 1
)
	belt = /obj/item/storage/belt/military/assault
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	l_pocket = /obj/item/melee/knife/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	uniform = /obj/item/clothing/under/rank/security/officer/military
	accessory = /obj/item/clothing/accessory/holster/marine
	mask = /obj/item/clothing/mask/gas/sechailer
	head = /obj/item/clothing/head/helmet/marine

/datum/outfit/centcom/ert/marine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return
	var/obj/item/radio/headset = H.ears
	headset.keyslot = new /obj/item/encryptionkey/heads/captain
	headset.recalculateChannels()

/datum/outfit/centcom/ert/marine/security
	name = "Marine Heavy"

	id = /obj/item/card/id/ert/security
	suit = /obj/item/clothing/suit/armor/vest/marine/heavy
	back = /obj/item/storage/backpack/ert/security
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	head = /obj/item/clothing/head/helmet/marine/security

/datum/outfit/centcom/ert/marine/security/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/headset = H.ears
	headset.keyslot = new /obj/item/encryptionkey/headset_com
	headset.recalculateChannels()

/datum/outfit/centcom/ert/marine/medic
	name = "Marine Medic"

	id = /obj/item/card/id/ert/medical
	suit = /obj/item/clothing/suit/armor/vest/marine
	accessory = /obj/item/clothing/accessory/holster/marine
	back = /obj/item/storage/backpack/ert/medical
	l_pocket = /obj/item/healthanalyzer
	head = /obj/item/clothing/head/helmet/marine/medic
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/gun_voucher/nanotrasen = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/storage/firstaid/advanced = 1
)
	belt = /obj/item/storage/belt/medical/paramedic
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses

/datum/outfit/centcom/ert/marine/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/headset = H.ears
	headset.keyslot = new /obj/item/encryptionkey/headset_com
	headset.recalculateChannels()

/datum/outfit/centcom/ert/marine/engineer
	name = "Marine Engineer"

	id = /obj/item/card/id/ert/engineer
	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	head = /obj/item/clothing/head/helmet/marine/engineer
	back = /obj/item/storage/backpack/ert/engineer
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/gun_voucher/nanotrasen = 1,
		/obj/item/rcd_ammo/large = 2,
		)
	r_hand = /obj/item/deployable_turret_folded
	uniform = /obj/item/clothing/under/rank/security/officer/military/eng
	belt = /obj/item/storage/belt/utility/full/ert
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/centcom/ert/marine/engineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()

	if(visualsOnly)
		return

	var/obj/item/radio/headset = H.ears
	headset.keyslot = new /obj/item/encryptionkey/headset_com
	headset.recalculateChannels()

// Loss Prevention
/datum/outfit/job/nanotrasen/security/ert/lp
	name = "ERT - Loss Prevention Security Specialist"
	jobtype = /datum/job/officer
	job_icon = "securityresponseofficer"

	head = null
	implants = list(/obj/item/implant/mindshield)
	ears = /obj/item/radio/headset/nanotrasen/alt
	id = /obj/item/card/id/lpsec
	suit_store = /obj/item/gun/energy/laser/scatter/shotty
	belt = /obj/item/storage/belt/security/full
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = /obj/item/clothing/gloves/tackler/combat
	suit = /obj/item/clothing/suit/space/hardsuit/ert/lp/sec
	uniform = /obj/item/clothing/under/rank/security/head_of_security/nt/lp
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack/ert/security

	box = /obj/item/storage/box/survival/security
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/melee/knife/combat

	backpack_contents = list(/obj/item/radio=1, /obj/item/stock_parts/cell/gun/upgraded=2, /obj/item/screwdriver=1)


/datum/outfit/job/nanotrasen/security/ert/lp/medic
	name = "ERT - Loss Prevention Medical Specialist"
	jobtype = /datum/job/doctor
	job_icon = "medicalresponseofficer"

	head = null
	uniform = /obj/item/clothing/under/rank/medical/paramedic/lp
	suit = /obj/item/clothing/suit/space/hardsuit/ert/lp/med
	id = /obj/item/card/id/lpmed
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	back = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical/surgery

	box = /obj/item/storage/box/survival/medical
	l_pocket = /obj/item/healthanalyzer
	r_pocket = /obj/item/reagent_containers/hypospray/medipen/atropine

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/radio=1)


/datum/outfit/job/nanotrasen/security/ert/lp/engineer
	name = "ERT - Loss Prevention Engineering Specialist"
	jobtype = /datum/job/engineer
	job_icon = "engineeringresponseofficer"

	head = null
	uniform = /obj/item/clothing/under/rank/engineering/engineer/nt/lp
	suit = /obj/item/clothing/suit/space/hardsuit/ert/lp/engi
	id = /obj/item/card/id/lpengie
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/color/yellow
	glasses = /obj/item/clothing/glasses/welding
	back = /obj/item/storage/backpack/ert/engineer

	box = /obj/item/storage/box/survival/engineer
	l_pocket = /obj/item/extinguisher/mini
	r_pocket = /obj/item/wrench/combat

	backpack_contents = list(/obj/item/stack/sheet/metal/fifty=1, /obj/item/stack/sheet/glass/fifty=1, /obj/item/radio=1)

/datum/outfit/job/nanotrasen/security/ert/lp/lieutenant
	name = "ERT - Loss Prevention Lieutenant"
	jobtype = /datum/job/captain
	job_icon = "emergencyresponseteamcommander"

	head = null
	ears = /obj/item/radio/headset/nanotrasen/alt/captain
	id = /obj/item/card/id/lplieu
	belt = /obj/item/storage/belt/military/army
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/security/warden/lp
	suit = /obj/item/clothing/suit/space/hardsuit/ert/lp
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	back = /obj/item/storage/backpack/ert

	l_pocket = /obj/item/megaphone/command
	r_pocket = /obj/item/binoculars
