//NGR ERT outfits


//Serviceman
/datum/outfit/job/syndicate/ert/ngr
	name = "ERT - NGR Serviceman"
	id_assignment = "Serviceman"

	head = /obj/item/clothing/head/helmet/ngr
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ngr
	ears = /obj/item/radio/headset/syndicate/alt/ngr
	mask = /obj/item/clothing/mask/balaclava/ngr
	neck = /obj/item/clothing/neck/shemagh/ngr
	uniform = /obj/item/clothing/under/syndicate/ngr
	accessory = /obj/item/clothing/accessory/holster/ringneck
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/ngr
	belt = /obj/item/storage/belt/security/webbing/ngr/hydra
	shoes = /obj/item/clothing/shoes/combat
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra
	box = /obj/item/storage/box/survival

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/trench_tool, /obj/item/attachment/rail_light)

/datum/outfit/job/syndicate/ert/ngr/softsuit
	name = "ERT - NGR Serviceman (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/hardsuit
	name = "ERT - NGR Serviceman (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Automatic Rifleman
/datum/outfit/job/syndicate/ert/ngr/automatic_rifleman
	name = "ERT - NGR Automatic Rifleman"

	belt = /obj/item/storage/belt/security/webbing/ngr/hydra_lmg
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra/lmg/casket_mag

/datum/outfit/job/syndicate/ert/ngr/automatic_rifleman/softsuit
	name = "ERT - NGR Automatic Rifleman (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/automatic_rifleman/hardsuit
	name = "ERT - NGR Automatic Rifleman (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Breacher
/datum/outfit/job/syndicate/ert/ngr/breacher
	name = "ERT - NGR Breacher"

	belt = /obj/item/storage/belt/security/webbing/ngr/bulldog
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog/drum

	l_pocket = /obj/item/storage/pouch/engi

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/trench_tool, /obj/item/storage/toolbox/explosives, /obj/item/clothing/glasses/welding, /obj/item/attachment/rail_light)

/datum/outfit/job/syndicate/ert/ngr/breacher/softsuit
	name = "ERT - NGR Breacher (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/breacher/hardsuit
	name = "ERT - NGR Breacher (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Grenadier
/datum/outfit/job/syndicate/ert/ngr/grenadier
	name = "ERT - NGR Grenadier"

	belt = /obj/item/storage/belt/security/webbing/ngr/hydra_grenadier
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra/underbarrel_gl

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/ammo_casing/a40mm = 2, /obj/item/trench_tool, /obj/item/flashlight/seclite)

/datum/outfit/job/syndicate/ert/ngr/grenadier/softsuit
	name = "ERT - NGR Grenadier (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/grenadier/hardsuit
	name = "ERT - NGR Grenadier (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Marksman
/datum/outfit/job/syndicate/ert/ngr/marksman
	name = "ERT - NGR Marksman"

	belt = /obj/item/storage/belt/security/webbing/ngr/hydra_dmr
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra/dmr

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/trench_tool, /obj/item/attachment/rail_light, /obj/item/binoculars)

/datum/outfit/job/syndicate/ert/ngr/marksman/softsuit
	name = "ERT - NGR Marksman (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/marksman/hardsuit
	name = "ERT - NGR Marksman (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Sniper
/datum/outfit/job/syndicate/ert/ngr/sniper
	name = "ERT - NGR Sniper"

	head = /obj/item/clothing/head/beret/color/black
	mask = /obj/item/clothing/mask/breath/ngr
	gloves = /obj/item/clothing/gloves/fingerless

	belt = /obj/item/storage/belt/security/webbing/ngr/boomslang
	suit_store = /obj/item/gun/ballistic/automatic/marksman/boomslang

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/trench_tool, /obj/item/attachment/rail_light, /obj/item/binoculars)

/datum/outfit/job/syndicate/ert/ngr/sniper/softsuit
	name = "ERT - NGR Sniper (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/sniper/hardsuit
	name = "ERT - NGR Sniper (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Anti Material
/datum/outfit/job/syndicate/ert/ngr/anti_material
	name = "ERT - NGR Anti Material"

	mask = /obj/item/clothing/mask/gas/syndicate
	accessory = /obj/item/clothing/accessory/holster/asp
	belt = /obj/item/storage/belt/security/webbing/ngr/taipan
	suit_store = /obj/item/gun/ballistic/automatic/marksman/taipan

	backpack_contents = list(/obj/item/grenade/syndieminibomb/concussion = 2, /obj/item/trench_tool, /obj/item/binoculars, /obj/item/flashlight/seclite)

/datum/outfit/job/syndicate/ert/ngr/anti_material/softsuit
	name = "ERT - NGR Anti Tank (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/anti_material/hardsuit
	name = "ERT - NGR Anti Tank (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Field Medic
/datum/outfit/job/syndicate/ert/ngr/medic
	name = "ERT - NGR Field Medic"
	jobtype = /datum/job/ert/med
	job_icon = "paramedic"
	id_assignment = "Field Medic"

	mask = /obj/item/clothing/mask/breath/ngr
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	glasses = /obj/item/clothing/glasses/hud/health
	gloves = /obj/item/clothing/gloves/nitrile/evil
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra

	l_pocket = /obj/item/storage/pouch/ammo/cobra
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/grenade/smokebomb = 4, /obj/item/storage/firstaid/medical=1, /obj/item/melee/knife/combat, /obj/item/attachment/rail_light)

/datum/outfit/job/syndicate/ert/ngr/medic/softsuit
	name = "ERT - NGR Field Medic (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/medic/hardsuit
	name = "ERT - NGR Field Medic (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Leader
/datum/outfit/job/syndicate/ert/ngr/leader
	name = "ERT - NGR Lieutenant"
	job_icon = "lieutenant"
	id_assignment = "Lieutenant"
	jobtype = /datum/job/ert/commander

	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	accessory = /obj/item/clothing/accessory/holster/asp
	neck = /obj/item/clothing/mask/whistle/trench
	head = /obj/item/clothing/head/ngr/peaked
	back = /obj/item/storage/backpack/satchel/sec
	gloves = /obj/item/clothing/gloves/tackler/combat
	belt = /obj/item/storage/belt/security/webbing/ngr/sidewinder
	suit_store = /obj/item/gun/ballistic/automatic/smg/sidewinder
	ears = /obj/item/radio/headset/syndicate/alt/captain/ngr
	shoes = /obj/item/clothing/shoes/jackboots

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/melee/knife/combat, /obj/item/attachment/rail_light, /obj/item/binoculars, /obj/item/megaphone/sec)

/datum/outfit/job/syndicate/ert/ngr/leader/softsuit
	name = "ERT - NGR Lieutenant (Softsuit)"

	suit = /obj/item/clothing/suit/space/syndicate/ngr
	head = /obj/item/clothing/head/helmet/space/syndicate/ngr

/datum/outfit/job/syndicate/ert/ngr/leader/hardsuit
	name = "ERT - NGR Lieutenant (Hardsuit)"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ngr
	head = null

//Inspector
/datum/outfit/job/syndicate/ert/ngr/inspector
	name = "ERT - NGR Official"
	id_assignment = "Official"
	job_icon = "syndicate"
	jobtype = /datum/job/ert/commander

	head = /obj/item/clothing/head/ngr
	ears = /obj/item/radio/headset/syndicate/alt/captain/ngr
	neck = /obj/item/binoculars
	gloves = /obj/item/clothing/gloves/color/white
	mask = null
	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	accessory = /obj/item/clothing/accessory/holster/asp
	glasses = null
	suit = /obj/item/clothing/suit/armor/ngr/lieutenant
	belt = /obj/item/clipboard
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null

	backpack = /obj/item/storage/backpack/satchel/leather
	duffelbag = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	courierbag = /obj/item/storage/backpack/satchel/leather

	backpack_contents = list(/obj/item/pen/fourcolor, /obj/item/folder/red, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler, /obj/item/megaphone/sec)

//Military Police
/datum/outfit/job/syndicate/ert/ngr/military_police
	name = "ERT - NGR MP"
	id_assignment = "Military Police"

	head = /obj/item/clothing/head/ngr
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/syndicate/alt/ngr
	mask = /obj/item/clothing/mask/breath/ngr
	neck = /obj/item/clothing/mask/whistle
	uniform = /obj/item/clothing/under/syndicate/ngr
	accessory = /obj/item/clothing/accessory/holster/ringneck
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/ngr
	belt = /obj/item/storage/belt/security/full/classic
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	box = /obj/item/storage/box/survival

	l_hand = /obj/item/gun/ballistic/shotgun/gaboon/empty
	r_hand = /obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/rubber

	l_pocket = /obj/item/storage/pouch/ammo/police
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/attachment/rail_light, /obj/item/clothing/head/helmet/riot, /obj/item/shield/tele)

/datum/outfit/job/syndicate/ert/ngr/military_police/leader
	name = "ERT - NGR MP Commander"
	id_assignment = "Military Police Commander"

	head = /obj/item/clothing/head/ngr/peaked
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	ears = /obj/item/radio/headset/syndicate/alt/captain/ngr
	mask = /obj/item/clothing/mask/breath/ngr
	neck = /obj/item/clothing/mask/whistle
	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	accessory = /obj/item/clothing/accessory/holster/asp
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/ngr
	belt = /obj/item/storage/belt/security/full/classic
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null
	box = /obj/item/storage/box/survival

	l_hand = /obj/item/gun/ballistic/shotgun/gaboon/empty
	r_hand = /obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/rubber

	l_pocket = /obj/item/storage/pouch/ammo/police
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/attachment/rail_light, /obj/item/clothing/head/helmet/riot, /obj/item/shield/tele, /obj/item/megaphone/sec)

//EOD
/datum/outfit/job/syndicate/ert/ngr/eod
	name = "ERT - NGR EOD"
	id_assignment = "EOD Specialist"

	head = /obj/item/clothing/head/ngr
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/syndicate/alt/ngr
	mask = /obj/item/clothing/mask/balaclava/ngr
	neck = null
	uniform = /obj/item/clothing/under/syndicate/ngr
	accessory = /obj/item/clothing/accessory/holster/ringneck
	gloves = /obj/item/clothing/gloves/insulated
	suit = /obj/item/clothing/suit/space/hardsuit/bomb/ngr
	belt = /obj/item/storage/belt/utility/full/ert
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	box = /obj/item/storage/box/survival

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/storage/toolbox/explosives, /obj/item/trench_tool)

//Pilot
/datum/outfit/job/syndicate/ert/ngr/pilot
	name = "ERT - NGR Pilot"
	id_assignment = "Pilot"

	head = /obj/item/clothing/head/helmet/ngr/swat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/syndicate/alt/ngr
	mask = /obj/item/clothing/mask/balaclava/ngr
	neck = null
	uniform = /obj/item/clothing/under/syndicate/ngr/fatigues
	accessory = /obj/item/clothing/accessory/holster/ringneck
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/security/webbing/ngr/alt/pilot
	shoes = /obj/item/clothing/shoes/combat
	suit_store = /obj/item/gun/ballistic/shotgun/gaboon
	box = /obj/item/storage/box/survival

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/attachment/rail_light)

//Wrecker
/datum/outfit/job/syndicate/ert/ngr/wrecker
	name = "ERT - NGR Wrecker"
	id_assignment = "Wrecker"

	head = /obj/item/clothing/head/hardhat/ngr
	glasses = /obj/item/clothing/glasses/meson
	ears = /obj/item/radio/headset/syndicate/alt/ngr
	mask = /obj/item/clothing/mask/balaclava/ngr
	neck = /obj/item/clothing/neck/shemagh/ngr
	uniform = /obj/item/clothing/under/syndicate/ngr/jumpsuit
	accessory = /obj/item/clothing/accessory/holster/ringneck
	gloves = /obj/item/clothing/gloves/insulated
	suit = /obj/item/clothing/suit/hazardvest/ngr
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	suit_store = null
	box = /obj/item/storage/box/survival

	r_hand = /obj/item/melee/sledgehammer/gorlex

	l_pocket = /obj/item/geiger_counter
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	backpack_contents = list(/obj/item/stack/marker_beacon/thirty, /obj/item/plasmacutter, /obj/item/clothing/glasses/welding)

/datum/outfit/job/syndicate/ert/ngr/wrecker/hardsuit
	name = "ERT - NGR Wrecker (Hardsuit)"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/mining/heavy/ngr
