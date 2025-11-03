//top outfit of everything Minuteman. Touch at own risk.

/datum/outfit/job/clip
	name = "CLIP - Base Outfit"

	uniform = /obj/item/clothing/under/clip
	alt_uniform = null

	faction_icon = "bg_clip"

	box = /obj/item/storage/box/survival/clip
	ears = /obj/item/radio/headset

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip

// 	var/list/selectable_alt_titles = list()

/datum/outfit/job/clip/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_MINUTEMAN)
/* 	if(selectable_alt_titles)
		var/selection = input(H, "Select an alternative name for your role.", "Job Title", alt_title) as null|anything in selectable_alt_titles)
	if(!selection)
		return

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.assignment = alt_title
*/

// Base CLIP

/datum/outfit/job/clip/assistant
	name = "CLIP - Volunteer"
	job_icon = "assistant"
	jobtype = /datum/job/assistant
	// selectable_alt_titles = list("Volunteer","Civillian")

	r_pocket = /obj/item/radio

/datum/outfit/job/clip/assistant/surveyor
	name = "CLIP - Surveyor"
	job_icon = "scribe"

	suit = /obj/item/clothing/suit/hazardvest
	head = /obj/item/clothing/head/soft/darkblue
	gloves = /obj/item/clothing/gloves/color/black
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	shoes = /obj/item/clothing/shoes/workboots
	belt = /obj/item/clipboard

/datum/outfit/job/clip/captain
	name = "CLIP - Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = /obj/item/clothing/under/clip/formal/with_shirt
	suit = /obj/item/clothing/suit/toggle/lawyer/clip/command
	alt_suit = null
	dcoat = /obj/item/clothing/suit/armor/clip_trenchcoat
	head = /obj/item/clothing/head/clip/slouch/officer
	id = /obj/item/card/id/gold
	ears = /obj/item/radio/headset/clip/alt/captain
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/laceup
//	accessory = /obj/item/clothing/accessory/medal/gold/captain

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	backpack_contents = list(
		/obj/item/storage/box/ids = 1,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/clip/ce
	name = "CLIP - Foreman"
	job_icon = "clip_navy3"
	jobtype = /datum/job/chief_engineer

	id = /obj/item/card/id/silver
	gloves = /obj/item/clothing/gloves/color/yellow
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat/white
	ears = /obj/item/radio/headset/clip
	uniform = /obj/item/clothing/under/clip
	gloves = /obj/item/clothing/gloves/color/yellow
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1
	)

/datum/outfit/job/clip/first_officer
	name = "CLIP - First Officer"
	job_icon = "clip_navy4"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	alt_suit = null

	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/clip/slouch

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	backpack_contents = list(
		/obj/item/storage/box/ids=1,
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1)

	chameleon_extras = list(/obj/item/gun/energy/sharplite/x12, /obj/item/stamp/officer)

/datum/outfit/job/clip/doctor
	name = "CLIP - Doctor"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	box = /obj/item/storage/box/survival/medical
	chameleon_extras = /obj/item/gun/syringe
	accessory = /obj/item/clothing/accessory/armband/medblue
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/clip
	suit_store = /obj/item/flashlight/pen/paramedic

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med

/datum/outfit/job/clip/medtech
	name = "CLIP - Medical Technician"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic

	uniform = /obj/item/clothing/under/clip/medic
	head = /obj/item/clothing/head/soft/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/blue
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/clip
	belt = /obj/item/storage/belt/medical
	l_pocket = /obj/item/flashlight/pen

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para

	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/clip/scientist
	name = "CLIP - Researcher"
	job_icon = "scientist"
	jobtype = /datum/job/scientist

	shoes = /obj/item/clothing/shoes/sneakers/white
	suit = /obj/item/clothing/suit/toggle/labcoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

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

/datum/outfit/job/clip/mechanic
	name = "CLIP - Mechanic"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	gloves = /obj/item/clothing/gloves/color/yellow
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

/datum/outfit/job/clip/investigator
	name = "CLIP-GOLD - Investigator"
	jobtype = /datum/job/detective
	job_icon = "detective"

	head = /obj/item/clothing/head/fedora/det_hat/clip
	belt = /obj/item/clipboard
	uniform = /obj/item/clothing/under/clip/formal
	suit = /obj/item/clothing/suit/armor/clip_trenchcoat
	ears = /obj/item/radio/headset/alt
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black

	l_hand = /obj/item/storage/briefcase

	backpack = /obj/item/storage/backpack/industrial

	l_pocket = /obj/item/toy/crayon/white
	r_pocket = /obj/item/radio

	backpack_contents = list(/obj/item/storage/box/evidence=1,\
		/obj/item/detective_scanner=1,\
		/obj/item/melee/classic_baton=1)

/datum/outfit/job/clip/investigator/cm5
	name = "CLIP-GOLD - Investigator (CM-5c)"

	backpack_contents = list(/obj/item/storage/box/evidence=1,\
		/obj/item/detective_scanner=1,\
		/obj/item/melee/classic_baton=1,\
		/obj/item/ammo_box/magazine/cm5_9mm = 2, \
		/obj/item/gun/ballistic/automatic/smg/cm5/compact
		)

/datum/outfit/job/clip/bureaucrat
	name = "CLIP-GOLD - Bureaucrat"
	job_icon = "scribe"
	jobtype = /datum/job/lawyer

	head = /obj/item/clothing/head/flatcap/clip
	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	shoes = /obj/item/clothing/shoes/laceup

	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather

	r_pocket = /obj/item/radio

/datum/outfit/job/clip/correspondent
	name = "CLIP - Military Correspondent"
	job_icon = "curator"
	jobtype = /datum/job/curator

	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	shoes = /obj/item/clothing/shoes/laceup

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel

	r_pocket = /obj/item/radio
	l_pocket = /obj/item/multitool

/datum/outfit/job/clip/correspondent/dressed
	name = "CLIP - Military Correspondent (Dressed)"

	head = /obj/item/clothing/head/helmet/m10/clip_correspondent
	suit = /obj/item/clothing/suit/armor/vest/clip_correspondent

	belt = /obj/item/bodycamera/broadcast_camera

// Confederated League Minutemen

/datum/outfit/job/clip/minutemen
	name = "CLIP Minutemen - Base Outfit"

	jobtype = /datum/job/assistant

	uniform = /obj/item/clothing/under/clip/minutemen
	shoes = /obj/item/clothing/shoes/combat

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/satchel/sec/clip

	box = /obj/item/storage/box/survival/clip/minutemen

/datum/outfit/job/clip/minutemen/deckhand
	name = "CLIP Minutemen - Deckhand"
	id_assignment = "Deckhand"
	job_icon = "clip_navy1"
	jobtype = /datum/job/assistant

	r_pocket = /obj/item/radio

// captain

/datum/outfit/job/clip/minutemen/captain
	name = "CLIP Minutemen - Captain"
	job_icon = "clip_navy5"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	gloves = /obj/item/clothing/gloves/color/captain
//	accessory = /obj/item/clothing/accessory/medal/gold/captain
	ears = /obj/item/radio/headset/clip/alt/captain
	uniform = /obj/item/clothing/under/clip/officer
	alt_uniform = null
	alt_suit = null
	suit = /obj/item/clothing/suit/armor/clip_capcoat
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/clip/slouch/officer

	backpack_contents = list(/obj/item/storage/box/ids=1,
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1)

/datum/outfit/job/clip/minutemen/captain/general
	name = "CLIP Minutemen - General"
	id_assignment = "General"
	job_icon = "clip_cmm6"

	head = /obj/item/clothing/head/clip/slouch/officer
	ears = /obj/item/radio/headset/clip/alt/captain
	uniform = /obj/item/clothing/under/clip/officer
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/clip
	shoes = /obj/item/clothing/shoes/jackboots

	box = /obj/item/storage/box/survival/engineer
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/gun/ballistic/revolver/rhino=1)

/datum/outfit/job/clip/minutemen/captain/general/admiral // for flavor, might remove outright
	name = "CLIP Minutemen - Admiral"
	id_assignment = "Admiral"
	job_icon = "clip_navy6"

	head = /obj/item/clothing/head/clip/bicorne
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/clip/admiral

// bridge officer

/datum/outfit/job/clip/minutemen/bridge_officer
	name = "CLIP Minutemen - Bridge Officer"
	id_assignment = "Bridge Officer"
	job_icon = "clip_navy3"
	jobtype = /datum/job/head_of_personnel

	id = /obj/item/card/id/silver
	head = /obj/item/clothing/head/clip/slouch
	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/formal
	alt_uniform = null
	alt_suit = null
	suit = /obj/item/clothing/suit/toggle/lawyer/clip
	shoes = /obj/item/clothing/shoes/jackboots

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced = 1)

// doctor

/datum/outfit/job/clip/minutemen/doctor
	name = "CLIP Minutemen - Naval Corpsman"
	id_assignment = "Naval Corpsman"
	job_icon = "clip_navy2"
	jobtype = /datum/job/doctor

	uniform = /obj/item/clothing/under/clip/medic
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/clip/corpsman
	suit = null
	suit_store = null

// vehicle crew

/datum/outfit/job/clip/minutemen/vehicle_crew
	name = "CLIP Minutemen - Vehicle Crewman"
	id_assignment = "Vehicle Crewman"
	job_icon = "clip_mech1"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/clip
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/clip
	suit = null

/datum/outfit/job/clip/minutemen/vehicle_pilot
	name = "CLIP Minutemen - Vehicle Pilot"
	id_assignment = "Pilot"
	job_icon = "clip_mech2"
	jobtype = /datum/job/mining

	uniform = /obj/item/clothing/under/clip/minutemen
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/clip

	gloves = /obj/item/clothing/gloves/fingerless

/datum/outfit/job/clip/minutemen/vehicle_pilot/dressed
	name = "CLIP Minutemen - Vehicle Pilot (Dressed)"

	head = /obj/item/clothing/head/helmet/m10/clip_vc
	suit = /obj/item/clothing/suit/armor/vest/alt
	glasses = /obj/item/clothing/glasses/hud/diagnostic

/datum/outfit/job/clip/minutemen/vehicle_pilot/commander
	name = "CLIP Minutemen - Vehicle Commander"
	id_assignment = "Vehicle Commander"
	job_icon = "clip_mech3"

	suit = /obj/item/clothing/suit/jacket/miljacket
	head = /obj/item/clothing/head/helmet/m10/clip_vc
	glasses = /obj/item/clothing/glasses/hud/diagnostic/sunglasses

/datum/outfit/job/clip/minutemen/vehicle_crew/coordinator
	name = "CLIP Minutemen - Vehicle Traffic Coordinator"
	id_assignment = "Traffic Coordinator"
	job_icon = "clip_mech4"
	jobtype = /datum/job/roboticist

	belt = null

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	head = /obj/item/clothing/head/clip/slouch
	uniform = /obj/item/clothing/under/clip/minutemen
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/hazardvest

// engineer (not combat)

/datum/outfit/job/clip/minutemen/engineer
	name = "CLIP Minutemen - Naval Engineer"
	id_assignment = "Naval Engineer"
	job_icon = "clip_navy2"
	jobtype = /datum/job/engineer

	shoes = /obj/item/clothing/shoes/workboots

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	uniform = /obj/item/clothing/under/clip/minutemen
	head = /obj/item/clothing/head/clip
	suit =  /obj/item/clothing/suit/hazardvest

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

//grunts - soldiers, combat engineers and medics, etc. for erts as well

/obj/item/twenty_pounds_of_ice
	name = "20 pounds of ice"
	desc = "It feels cold and heavy."
	icon_state = "20_lb_ice"
	w_class = WEIGHT_CLASS_NORMAL

/datum/outfit/job/clip/minutemen/grunt
	name = "CLIP Minutemen - Minuteman"
	id_assignment = "Minuteman"
	jobtype = /datum/job/officer
	job_icon = "clip_cmm2"

	ears = /obj/item/radio/headset/alt
	shoes = /obj/item/clothing/shoes/combat // shoos

	backpack = /obj/item/storage/backpack/security/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/duffelbag //to-do: bug rye for clip duffles // rye. rye. give me 20 pound bag of ice //done // rye. rye. give me clip duffels

/datum/outfit/job/clip/minutemen/grunt/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.ckey == "meemofcourse")
		H.equip_to_slot_if_possible(new /obj/item/twenty_pounds_of_ice, ITEM_SLOT_HANDS, FALSE, FALSE)


/datum/outfit/job/clip/minutemen/grunt/dressed
	name = "CLIP Minutemen - Minuteman (Dressed)"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	alt_suit = null
	uniform = /obj/item/clothing/under/clip/minutemen
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black

	belt = /obj/item/storage/belt/military/clip

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/item/storage/ration/chicken_wings_hot_sauce=1)

/datum/outfit/job/clip/minutemen/grunt/dressed/eva_spotter
	name = "CLIP Minutemen - Minuteman (EVA - Spotter Hardsuit)"

	head = null
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter
	suit_store = /obj/item/tank/internals/oxygen

/datum/outfit/job/clip/minutemen/grunt/dressed/bombsuit
	name = "CLIP Minutmemen - Minuteman (Bombsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/bomb/clip
	head = /obj/item/clothing/head/helmet/space/hardsuit/bomb/clip

/datum/outfit/job/clip/minutemen/grunt/dressed/armed
	name = "CLIP Minutemen - Minuteman (Armed - CM-82)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/cm82
	belt = /obj/item/storage/belt/military/clip/cm82

/datum/outfit/job/clip/minutemen/grunt/dressed/armed/f4
	name = "CLIP Minutemen - Minuteman (Armed - F4)"

	suit_store = /obj/item/gun/ballistic/automatic/marksman/f4
	belt = /obj/item/storage/belt/military/clip/f4

/datum/outfit/job/clip/minutemen/grunt/dressed/armed/cm5
	name = "CLIP Minutemen - Minuteman (Armed - CM-5)"

	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	belt = /obj/item/storage/belt/military/clip/cm5

// reservist

/datum/outfit/job/clip/minutemen/grunt/reserve
	name = "CLIP Minutemen - Reservist"
	id_assignment = "Reservist"
	job_icon = "clip_cmm1"
	jobtype = /datum/job/assistant

	head = /obj/item/clothing/head/clip
	shoes = /obj/item/clothing/shoes/combat

// combat engineer

/datum/outfit/job/clip/minutemen/grunt/engineer
	name = "CLIP Minutemen - Combat Engineer"
	id_assignment = "Combat Engineer"
	jobtype = /datum/job/engineer

	accessory = /obj/item/clothing/accessory/armband/engine

/datum/outfit/job/clip/minutemen/grunt/engineer/dressed
	name = "CLIP Minutemen - Combat Engineer (Dressed)"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/military/clip

/datum/outfit/job/clip/minutemen/grunt/engineer/dressed/armed
	name = "CLIP Minutemen - Combat Engineer (Armed - CM-82)"

	suit_store = /obj/item/gun/ballistic/automatic/assault/cm82
	belt = /obj/item/storage/belt/military/clip/engi

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/item/storage/ration/chili_macaroni=1, /obj/item/grenade/c4=2, /obj/item/ammo_box/magazine/p16=3)

// combat medic

/datum/outfit/job/clip/minutemen/grunt/medic
	name = "CLIP Minutemen - Combat Medic"
	id_assignment = "Combat Medic"
	jobtype = /datum/job/doctor

	accessory = /obj/item/clothing/accessory/armband/medblue

/datum/outfit/job/clip/minutemen/grunt/medic/dressed
	name = "CLIP Minutemen - Combat Medic (Dressed)"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/medical/webbing/clip

/datum/outfit/job/clip/minutemen/grunt/medic/dressed/cm5
	name = "CLIP Minutemen - Combat Medic (Armed - CM-5)"

	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5

	backpack_contents = list(
		/obj/item/clothing/mask/gas/clip = 1,
		/obj/item/storage/ration/cheese_pizza_slice,
		/obj/item/defibrillator/compact/loaded = 1,
		/obj/item/storage/firstaid/medical = 1,
		/obj/item/ammo_box/magazine/cm5_9mm = 3)

// combat gunner

/datum/outfit/job/clip/minutemen/grunt/gunner
	name = "CLIP Minutemen - Support Gunner"

	accessory = /obj/item/clothing/accessory/armband

/datum/outfit/job/clip/minutemen/grunt/gunner/dressed
	name = "CLIP Minutemen - Support Gunner (Dressed)"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/military/clip/gunner

/datum/outfit/job/clip/minutemen/grunt/gunner/dressed/armed
	name = "CLIP Minutemen - Support Gunner (Armed - CM-40)"
	id_assignment = "Support Gunner"

	belt = /obj/item/storage/belt/military/clip/gunner/cm40
	suit_store = /obj/item/gun/ballistic/automatic/hmg/cm40

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1, /obj/item/storage/ration/shredded_beef=1)

/obj/item/storage/belt/military/clip/gunner/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/military/clip/gunner/cm40/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/ammo_box/magazine/cm40_762_40_box(src)
	new /obj/item/grenade/frag(src)

// team sergeant

/datum/outfit/job/clip/minutemen/grunt/lead
	name = "CLIP Minutemen - Team Sergeant"
	id_assignment = "Team Sergeant"
	job_icon = "clip_cmm3"
	jobtype = /datum/job/warden

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/minutemen
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/soft/utility_navy
	shoes = /obj/item/clothing/shoes/jackboots

	backpack_contents = list(/obj/item/clothing/mask/gas/clip=1)

/datum/outfit/job/clip/minutemen/grunt/lead/armed
	name = "CLIP Minutemen - Team Sergeant (Armed - CM-82)"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	suit_store = /obj/item/gun/ballistic/automatic/assault/cm82
	belt = /obj/item/storage/belt/military/clip/cm82
	backpack_contents = list(
		/obj/item/clothing/mask/gas/clip = 1,
		/obj/item/storage/ration/shredded_beef = 1,
		/obj/item/gun/ballistic/automatic/pistol/cm23 = 1
		)

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

/datum/outfit/job/clip/minutemen/grunt/commander
	name = "CLIP Minutemen - Field Commander"
	id_assignment = "Commander"
	job_icon = "clip_cmm4"
	jobtype = /datum/job/hos

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/officer

	head = /obj/item/clothing/head/clip/slouch/officer
	suit = /obj/item/clothing/suit/toggle/lawyer/clip/command

	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/clip/minutemen/grunt/major
	name = "CLIP Minutemen - Major"
	id_assignment = "Major"
	job_icon = "clip_cmm5"
	jobtype = /datum/job/captain

	ears = /obj/item/radio/headset/clip/alt
	uniform = /obj/item/clothing/under/clip/officer

	head = /obj/item/clothing/head/clip/slouch/officer
	suit = /obj/item/clothing/suit/armor/clip_trenchcoat

	shoes = /obj/item/clothing/shoes/jackboots

	glasses = /obj/item/clothing/glasses/sunglasses
