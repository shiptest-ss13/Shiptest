/datum/outfit/centcom/ert
	name = "ERT Common"

	mask = /obj/item/clothing/mask/gas/sechailer
	uniform = /obj/item/clothing/under/rank/centcom/officer
	shoes = /obj/item/clothing/shoes/combat/swat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/headset_cent/alt

/datum/outfit/centcom/ert/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_CENTCOM)
	R.freqlock = TRUE

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.registered_name = H.real_name
		W.update_label()
	..()

/datum/outfit/centcom/ert/commander
	name = "ERT Commander"

	id = /obj/item/card/id/ert
	suit = /obj/item/clothing/suit/space/hardsuit/ert
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	back = /obj/item/storage/backpack/ert
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/e_gun=1)
	l_pocket = /obj/item/switchblade

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
		/obj/item/gun/energy/pulse/pistol/loyalpin=1)
	l_pocket = /obj/item/melee/transforming/energy/sword/saber

/datum/outfit/centcom/ert/security
	name = "ERT Security"

	id = /obj/item/card/id/ert/security
	suit = /obj/item/clothing/suit/space/hardsuit/ert/sec
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	back = /obj/item/storage/backpack/ert/security
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,\
		/obj/item/gun/energy/e_gun/stun=1,\
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

	mask = /obj/item/clothing/mask/gas/sechailer/swat
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/storage/box/handcuffs=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/pulse/carbine/loyalpin=1)


/datum/outfit/centcom/ert/medic
	name = "ERT Medic"

	id = /obj/item/card/id/ert/medical
	suit = /obj/item/clothing/suit/space/hardsuit/ert/med
	glasses = /obj/item/clothing/glasses/hud/health
	back = /obj/item/storage/backpack/ert/medical
	belt = /obj/item/storage/belt/medical
	r_hand = /obj/item/storage/firstaid/regular
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/e_gun=1,\
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
		/obj/item/gun/energy/pulse/pistol/loyalpin=1,\
		/obj/item/reagent_containers/hypospray/combat/nanites=1,\
		/obj/item/gun/medbeam=1)

/datum/outfit/centcom/ert/engineer
	name = "ERT Engineer"

	id = /obj/item/card/id/ert/engineer
	suit = /obj/item/clothing/suit/space/hardsuit/ert/engi
	glasses =  /obj/item/clothing/glasses/meson/engine
	back = /obj/item/storage/backpack/ert/engineer
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/rcd_ammo/large
	r_hand = /obj/item/storage/firstaid/regular
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,\
		/obj/item/melee/baton/loaded=1,\
		/obj/item/gun/energy/e_gun=1,\
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
		/obj/item/gun/energy/pulse/pistol/loyalpin=1,\
		/obj/item/construction/rcd/combat=1)


/datum/outfit/centcom/centcom_official
	name = "CentCom Official"

	uniform = /obj/item/clothing/under/rank/centcom/officer
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

/datum/outfit/centcom/ert/commander/inquisitor
	name = "Inquisition Commander"
	r_hand = /obj/item/nullrod/scythe/talking/chainsword
	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,
		/obj/item/gun/energy/e_gun=1)

/datum/outfit/centcom/ert/security/inquisitor
	name = "Inquisition Security"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor

	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,
		/obj/item/storage/box/handcuffs=1,
		/obj/item/gun/energy/e_gun/stun=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/construction/rcd/loaded=1)

/datum/outfit/centcom/ert/medic/inquisitor
	name = "Inquisition Medic"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor

	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/gun/energy/e_gun=1,
		/obj/item/reagent_containers/hypospray/combat=1,
		/obj/item/reagent_containers/hypospray/combat/heresypurge=1,
		/obj/item/gun/medbeam=1)

/datum/outfit/centcom/ert/chaplain
	name = "ERT Chaplain"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor // Chap role always gets this suit
	id = /obj/item/card/id/ert/chaplain
	glasses = /obj/item/clothing/glasses/hud/health
	back = /obj/item/storage/backpack/cultpack
	belt = /obj/item/storage/belt/soulstone
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,
		/obj/item/nullrod=1,
		/obj/item/gun/energy/e_gun=1,
		)

/datum/outfit/centcom/ert/chaplain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()

/datum/outfit/centcom/ert/chaplain/inquisitor
	name = "Inquisition Chaplain"

	belt = /obj/item/storage/belt/soulstone/full/chappy
	backpack_contents = list(/obj/item/storage/box/survival/engineer=1,
		/obj/item/grenade/chem_grenade/holy=1,
		/obj/item/nullrod=1,
		/obj/item/gun/energy/e_gun=1,
		)

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

/datum/outfit/centcom/ert/clown
	name = "ERT Clown"

	suit = /obj/item/clothing/suit/space/hardsuit/ert/clown
	mask = /obj/item/clothing/mask/gas/clown_hat
	id = /obj/item/card/id/ert/clown
	glasses = /obj/item/clothing/glasses/godeye
	back = /obj/item/storage/backpack/ert/clown
	belt = /obj/item/storage/belt/champion
	shoes = /obj/item/clothing/shoes/clown_shoes/combat
	r_pocket = /obj/item/bikehorn/golden
	l_pocket = /obj/item/reagent_containers/food/snacks/grown/banana
	backpack_contents = list(/obj/item/storage/box/hug/survival=1,\
		/obj/item/melee/transforming/energy/sword/bananium=1,\
		/obj/item/shield/energy/bananium=1,\
		/obj/item/gun/ballistic/revolver/reverse=1)

/datum/outfit/centcom/ert/clown/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	var/obj/item/radio/R = H.ears
	R.keyslot = new /obj/item/encryptionkey/headset_com
	R.recalculateChannels()
	ADD_TRAIT(H, TRAIT_NAIVE, INNATE_TRAIT)
	H.dna.add_mutation(CLOWNMUT)
	for(var/datum/mutation/human/clumsy/M in H.dna.mutations)
		M.mutadone_proof = TRUE

/datum/outfit/centcom/centcom_intern
	name = "CentCom Intern"

	uniform = /obj/item/clothing/under/rank/centcom/intern
	shoes = /obj/item/clothing/shoes/sneakers/black
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/headset_cent
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/melee/classic_baton
	r_hand = /obj/item/gun/ballistic/rifle/boltaction
	back = /obj/item/storage/backpack/satchel
	l_pocket = /obj/item/ammo_box/a762
	r_pocket = /obj/item/ammo_box/a762
	id = /obj/item/card/id/centcom
	backpack_contents = list(/obj/item/storage/box/survival = 1)

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
	suit_store = /obj/item/gun/ballistic/rifle/boltaction
	r_hand = /obj/item/megaphone
	head = /obj/item/clothing/head/intern

/datum/outfit/centcom/ert/marine
	name = "Marine Commander"

	id = /obj/item/card/id/ert
	suit = /obj/item/clothing/suit/armor/vest/marine
	back = /obj/item/storage/backpack/ert
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/radio = 1,
		/obj/item/gun_voucher/nanotrasen = 1
)
	belt = /obj/item/storage/belt/military/assault
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	l_pocket = /obj/item/kitchen/knife/combat
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
		/obj/item/storage/box/survival/engineer/radio = 1,
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
		/obj/item/storage/box/survival/engineer/radio = 1,
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
