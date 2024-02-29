//top outfit of everything Minuteman. Touch at own risk.

/datum/outfit/job/clip
	name = "CLIP - Base Outfit"

	jobtype = /datum/job/assistant
	uniform = /obj/item/clothing/under/clip
	alt_uniform = null

	faction_icon = "bg_minutemen"

	box = /obj/item/storage/box/survival/clip

/datum/outfit/job/clip/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_MINUTEMAN)

/datum/outfit/job/clip/minutemen
	name = "CLIP Minutemen - Base Outfit"

	jobtype = /datum/job/assistant
	alt_uniform = null

	faction_icon = "bg_minutemen"

	box = /obj/item/storage/box/survival/clip/balaclava

///assistant

/datum/outfit/job/clip/assistant
	name = "CLIP - Volunteer"
	job_icon = "assistant"
	jobtype = /datum/job/assistant

	r_pocket = /obj/item/radio
/*
/datum/outfit/job/clip/assistant/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	var/list/selectable_alt_titles = list("Volunteer","Civillian")

	var/selection = tgui_input_list(H,"Select an alternative name for the [name] role.","Select your job title!",selectable_alt_titles)
	if(selection)
		return
*/

/datum/outfit/job/clip/minutemen/deckhand
	name = "CLIP Minutemen - Deckhand"
	job_icon = "clip_navy1"
	jobtype = /datum/job/assistant
	uniform =  /obj/item/clothing/under/clip

	r_pocket = /obj/item/radio

///captains

/datum/outfit/job/clip/captain
	name = "CLIP - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/color/white


	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

//	accessory = /obj/item/clothing/accessory/medal/gold/captain

//	ears = /obj/item/radio/headset/clip/alt/captain
	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = /obj/item/clothing/under/clip/formal/with_shirt
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain

	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/clip/slouch
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/clip/minutemen/captain
	name = "CLIP Minutemen - Captain"
	job_icon = "clip_navy5"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/color/captain


	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	ears = /obj/item/radio/headset/clip/alt/captain
	uniform = /obj/item/clothing/under/clip/officer
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/clip/slouch/officer
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/clip/captain/minutemen/general
	name = "CLIP Minutemen - General"
	job_icon = "clip_cmm6"

	head = /obj/item/clothing/head/clip/slouch/officer
	ears = /obj/item/radio/headset/clip/alt/captain
	uniform = /obj/item/clothing/under/clip/officer
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/clip
	shoes = /obj/item/clothing/shoes/combat

	box = /obj/item/storage/box/survival/engineer/radio
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/gun/ballistic/revolver/mateba=1)

/datum/outfit/job/clip/captain/minutemen/general/admiral // for flavor, might remove outright
	name = "CLIP Minutemen - Admiral"
	job_icon = "clip_navy6"

	head = /obj/item/clothing/head/clip/bicorne
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/clip/admiral

///chemist

/datum/outfit/job/clip/chemist
	name = "CLIP - Pharmacist"
	job_icon = "chemist"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	shoes = /obj/item/clothing/shoes/sneakers/white

	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/chem

	box = /obj/item/storage/box/survival/medical
	chameleon_extras = /obj/item/gun/syringe

/datum/outfit/job/clip/minutemen/chemist
	name = "CLIP Minutemen - Chemist"
	job_icon = "clip_navy2"
	jobtype = /datum/job/chemist

	glasses = /obj/item/clothing/glasses/science
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/chemist
	uniform = /obj/item/clothing/under/clip/medic

	backpack = /obj/item/storage/backpack/chemistry
	satchel = /obj/item/storage/backpack/satchel/chem
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/chem

	chameleon_extras = /obj/item/gun/syringe

///Chief Engineer

/datum/outfit/job/clip/ce
	name = "CLIP Minutemen - Foreman"
	job_icon = "clip_navy3"
	jobtype = /datum/job/chief_engineer

	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer

	chameleon_extras = /obj/item/stamp/ce


	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/clip/slouch
	backpack = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1
	)

/// Head Of Personnel

/datum/outfit/job/clip/first_officer
	name = "CLIP Minutemen - First Officer"
	job_icon = "clip_navy4"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/head_of_personnel)

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/clip/slouch/officer
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/storage/box/ids=1,\
		/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/clip/head_of_personnel
	name = "Minutemen - Bridge Officer"
	job_icon = "headofpersonnel"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null

	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/clip/slouch
	backpack = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced = 1)

/// Medical Doctor
/datum/outfit/job/clip/doctor
	name = "CLIP - Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	l_hand = /obj/item/storage/firstaid/medical

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

	accessory = /obj/item/clothing/accessory/armband/medblue
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/med
	suit = /obj/item/clothing/suit/toggle/labcoat
	suit_store = /obj/item/flashlight/pen

/datum/outfit/job/clip/minutemen/doctor
	name = "CLIP Minutemen - Corpsman"
	job_icon = "clip_navy2"
	jobtype = /datum/job/doctor

	l_hand = /obj/item/storage/firstaid/medical

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

	uniform = /obj/item/clothing/under/clip/medic
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/clip/corpsman
	suit = null
	suit_store = null

///paramedic
/datum/outfit/job/clip/paramedic
	name = "Minutemen - BARD Combat Medic"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic


	uniform = /obj/item/clothing/under/rank/medical/paramedic/emt
	head = /obj/item/clothing/head/soft/paramedic
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/sneakers/blue
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/roller=1)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para

	box = /obj/item/storage/box/survival/medical

///vehicle crew
/datum/outfit/job/clip/minutemen/vehicle_crew
	name = "CLIP Minutemen - Vehicle Crewman"
	job_icon = "clip_mech1"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility/full

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/clip
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/clip
	suit = null

/datum/outfit/job/clip/minutemen/vehicle_pilot
	name = "CLIP Minutemen - Vehicle Pilot"
	job_icon = "clip_mech2"
	jobtype = /datum/job/officer

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

	head = /obj/item/clothing/head/helmet/bulletproof/m10/clip_vc
	uniform = /obj/item/clothing/under/clip/minutemen
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/clip

	suit = /obj/item/clothing/suit/armor/vest/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	glasses = /obj/item/clothing/glasses/hud/diagnostic

/datum/outfit/job/clip/minutemen/vehicle_pilot/commander
	name = "CLIP Minutemen - Vehicle Commander"
	job_icon = "clip_mech3"
	suit = /obj/item/clothing/suit/jacket/miljacket
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/job/clip/minutemen/vehicle_crew/coordinator
	name = "CLIP Minutemen - Vehicle Traffic Coordinator"
	job_icon = "clip_mech4"
	jobtype = /datum/job/roboticist

	belt = null

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	head = /obj/item/clothing/head/clip/slouch
	uniform = /obj/item/clothing/under/clip/minutemen
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/hazardvest


///scientist
/datum/outfit/job/clip/scientist
	name = "CLIP - Researcher"
	job_icon = "scientist"
	jobtype = /datum/job/scientist

	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

///miners

/datum/outfit/job/clip/miner
	name = "CLIP - Industrial Miner"
	job_icon = "shaftminer"
	jobtype = /datum/job/mining

	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/toggle/hazard

	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/combat
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,
		/obj/item/stack/marker_beacon/ten=1,
		/obj/item/weldingtool=1,
		/obj/item/clothing/mask/gas/clip=1
		)

///engineers

/datum/outfit/job/clip/mechanic
	name = "CLIP - Mechanic"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/clip
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/hardhat/dblue
	suit =  /obj/item/clothing/suit/hazardvest

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

///engineers

/datum/outfit/job/clip/minutemen/engineer
	name = "CLIP Minutemen - Engineer"
	job_icon = "clip_navy2"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/clip
	head = /obj/item/clothing/head/clip
	suit =  /obj/item/clothing/suit/hazardvest

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/clip/investigator
	name = "CLIP GOLD - Investigator"
	jobtype = /datum/job/detective
	job_icon = "detective"

	head = /obj/item/clothing/head/fedora/det_hat/clip

	belt = /obj/item/clipboard
	uniform = /obj/item/clothing/under/clip/formal
	suit = /obj/item/clothing/suit/armor/clip_trenchcoat

	ears = /obj/item/radio/headset/alt
	shoes = /obj/item/clothing/shoes/jackboots

	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather

	gloves = /obj/item/clothing/gloves/color/black
	l_pocket = /obj/item/toy/crayon/white
	r_pocket = /obj/item/radio

	backpack_contents = list(/obj/item/storage/box/evidence=1,\
		/obj/item/detective_scanner=1,\
		/obj/item/melee/classic_baton=1)

/datum/outfit/job/clip/bureaucrat
	name = "CLIP GOLD - Bureaucrat"
	job_icon = "scribe"
	head = /obj/item/clothing/head/flatcap/clip

	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	suit = /obj/item/clothing/suit/armor/clip_trenchcoat

	shoes = /obj/item/clothing/shoes/laceup

	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather

	r_pocket = /obj/item/radio

//grunts - for erts as well

/obj/item/twenty_pounds_of_ice
	name = "20 pounds of ice"
	desc = "It feels cold and heavy."
	icon_state = "20_lb_ice"
	w_class = WEIGHT_CLASS_NORMAL


/datum/outfit/job/clip/minutemen/grunt/reserve
	name = "CLIP Minutemen - Reservist"
	job_icon = "clip_cmm1"
	jobtype = /datum/job/assistant

	r_pocket = /obj/item/radio

/datum/outfit/job/clip/minutemen/grunt
	name = "CLIP Minutemen - Minuteman"
	job_icon = "clip_cmm2"
	ears = /obj/item/radio/headset/alt
	box = /obj/item/storage/box/survival/clip/balaclava/extra
	shoes = null

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/security/clip //to-do: bug rye for clip duffles // rye. rye. give me 20 pound bag of ice //done

/datum/outfit/job/clip/minutemen/grunt/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.ckey == "meemofcourse")
		H.equip_to_slot_if_possible(new /obj/item/twenty_pounds_of_ice, ITEM_SLOT_HANDS, FALSE, FALSE)

/datum/outfit/job/clip/minutemen/grunt/dressed
	name = "CLIP Minutemen - Minuteman (Dressed)"
	jobtype = /datum/job/officer


	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip

	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	alt_suit = null
	uniform = /obj/item/clothing/under/clip/minutemen
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat

	belt = /obj/item/storage/belt/military/clip

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double
	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/effect/spawner/lootdrop/ration=1)

/datum/outfit/job/clip/minutemen/grunt/dressed/armed
	name = "CLIP Minutemen - Minuteman (Armed - CM-16)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	belt = /obj/item/storage/belt/military/clip/p16

/datum/outfit/job/clip/minutemen/grunt/dressed/armed/f4 //f4 is rename of GAL, don't wanna repath upon adding the clip guns though, if i forget to remove this during then, fucking yell at me
	name = "CLIP Minutemen - Minuteman (Armed - CM-GAL)"

	suit_store = /obj/item/gun/ballistic/automatic/gal
	belt = /obj/item/storage/belt/military/clip/gal

/datum/outfit/job/clip/minutemen/grunt/dressed/armed/cm5
	name = "CLIP Minutemen - Minuteman (Armed - CM-5)"

	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	belt = /obj/item/storage/belt/military/clip/cm5

//ert outfits, i suppose you could use these for non-ert roles although i highly discourage it


/datum/outfit/job/clip/minutemen/grunt/dressed/engi
	name = "CLIP Minutemen - Field Engineer (Dressed)"

	accessory = /obj/item/clothing/accessory/armband/engine
	belt = /obj/item/storage/belt/military/clip/engi

/datum/outfit/job/clip/minutemen/grunt/dressed/engi/armed
	name = "CLIP Minutemen - Field Engineer (Armed - CM-16)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/effect/spawner/lootdrop/ration=1, /obj/item/grenade/c4=2, /obj/item/ammo_box/magazine/p16=3)


/datum/outfit/job/clip/minutemen/grunt/dressed/med
	name = "CLIP Minutemen - Field Corpsman (Dressed)"

	accessory = /obj/item/clothing/accessory/armband/medblue
	belt = /obj/item/storage/belt/military/clip/engi

/datum/outfit/job/clip/minutemen/grunt/dressed/med/armed
	name = "CLIP Minutemen - Field Corpsman (Armed - CM-5)"

	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/effect/spawner/lootdrop/ration=1, /obj/item/defibrillator/compact/loaded=1, /obj/item/storage/firstaid/medical=1, /obj/item/ammo_box/magazine/smgm9mm=3)

/obj/item/storage/belt/military/clip/gunner/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/ammo_box/magazine/skm_762_40/extended(src)
	new /obj/item/grenade/frag(src)

/datum/outfit/job/clip/minutemen/grunt/dressed/gunner_armed
	name = "CLIP Minutemen - Field Gunner (Armed - SKM-24u)" //See above, replace with CLIP LMG when added

	accessory = /obj/item/clothing/accessory/armband
	belt = /obj/item/storage/belt/military/clip/gunner
	suit_store = /obj/item/gun/ballistic/automatic/hmg/skm_lmg/extended

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/effect/spawner/lootdrop/ration=1)

///lead, i guess you could reuse this for "Brig Officer"

/datum/outfit/job/clip/minutemen/grunt/lead
	name = "CLIP Minutemen - Field Sergeant"
	job_icon = "clip_cmm3"
	jobtype = /datum/job/warden

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/minutemen
	head = /obj/item/clothing/head/clip/slouch
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/military/clip
	shoes = /obj/item/clothing/shoes/combat

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1)

/datum/outfit/job/clip/minutemen/grunt/lead/armed
	name = "CLIP Minutemen - Field Sergeant (Armed)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	belt = /obj/item/storage/belt/military/clip/p16
	//replace commander with the cm23 when its impemented, see the cm-f4 above
	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/effect/spawner/lootdrop/ration=1, /obj/item/gun/ballistic/automatic/pistol/commander=1)

/datum/outfit/job/clip/minutemen/grunt/commander
	name = "CLIP Minutemen - Field Commander"
	job_icon = "clip_cmm4"

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/officer

	head = /obj/item/clothing/head/clip/slouch
	suit = /obj/item/clothing/suit/toggle/lawyer/clip

	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/clip/minutemen/grunt/major
	name = "CLIP Minutemen - Major"
	job_icon = "clip_cmm5"

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/officer

	head = /obj/item/clothing/head/clip/slouch/officer
	suit = /obj/item/clothing/suit/armor/clip_trenchcoat

	shoes = /obj/item/clothing/shoes/combat

	glasses = /obj/item/clothing/glasses/sunglasses
