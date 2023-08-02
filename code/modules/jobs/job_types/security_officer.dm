/datum/job/officer
	name = "Security Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	total_positions = 5 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 5 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	minimal_player_age = 7
	wiki_page = "Space_Law" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/security

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM, ACCESS_EVA)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM) // See /datum/job/officer/get_access()
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER

/datum/job/officer/get_access()
	var/list/L = list()
	L |= ..() | check_config_for_sec_maint()
	return L

GLOBAL_LIST_INIT(available_depts, list(SEC_DEPT_ENGINEERING, SEC_DEPT_MEDICAL, SEC_DEPT_SCIENCE, SEC_DEPT_SUPPLY))

/datum/job/officer/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	// Assign department security
	var/department
	if(M && M.client && M.client.prefs)
		department = M.client.prefs.prefered_security_department
		if(!LAZYLEN(GLOB.available_depts) || department == "None")
			return
		else if(department in GLOB.available_depts)
			LAZYREMOVE(GLOB.available_depts, department)
		else
			department = pick_n_take(GLOB.available_depts)
	var/accessory = null
	var/list/dep_access = null
	var/spawn_point = null
	switch(department)
		if(SEC_DEPT_SUPPLY)
			dep_access = list(ACCESS_MAILSORTING, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_CARGO)
			spawn_point = locate(/obj/effect/landmark/start/depsec/supply) in GLOB.department_security_spawns
			accessory = /obj/item/clothing/accessory/armband/cargo
		if(SEC_DEPT_ENGINEERING)
			dep_access = list(ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_ATMOSPHERICS)
			spawn_point = locate(/obj/effect/landmark/start/depsec/engineering) in GLOB.department_security_spawns
			accessory = /obj/item/clothing/accessory/armband/engine
		if(SEC_DEPT_MEDICAL)
			dep_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY)
			spawn_point = locate(/obj/effect/landmark/start/depsec/medical) in GLOB.department_security_spawns
			accessory =  /obj/item/clothing/accessory/armband/medblue
		if(SEC_DEPT_SCIENCE)
			dep_access = list(ACCESS_RESEARCH, ACCESS_TOX)
			spawn_point = locate(/obj/effect/landmark/start/depsec/science) in GLOB.department_security_spawns
			accessory = /obj/item/clothing/accessory/armband/science

	if(accessory)
		var/obj/item/clothing/under/U = H.w_uniform
		U.attach_accessory(new accessory)

	var/obj/item/card/id/W = H.wear_id
	W.access |= dep_access

	if(!CONFIG_GET(flag/sec_start_brig))
		if(spawn_point)
			var/turf/T
			T = get_turf(spawn_point)
			H.Move(T)
	if(department)
		to_chat(M, "<b>You have been assigned to [department]!</b>")
	else
		to_chat(M, "<b>You have not been assigned to any department. Patrol the halls and help where needed.</b>")



/datum/outfit/job/security
	name = "Security Officer"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/rank/security/officer
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/sec
	suit = /obj/item/clothing/suit/armor/vest
	alt_suit = /obj/item/clothing/suit/armor/vest/security/officer
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/melee/baton/loaded=1, /obj/item/ammo_box/magazine/co9mm=1, /obj/item/gun_voucher=1) //WS edit - security rearming

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses, /obj/item/clothing/head/helmet)
	//The helmet is necessary because /obj/item/clothing/head/helmet/sec is overwritten in the chameleon list by the standard helmet, which has the same name and icon state

//Shiptest outfits begin

/datum/outfit/job/security/pirate
	name = "Buccaneer (Pirate)"

	uniform = /obj/item/clothing/under/syndicate/camo
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/bandana
	suit = /obj/item/clothing/suit/armor/vest

/datum/outfit/job/security/corporate
	name = "Corporate Security"

	uniform = /obj/item/clothing/under/syndicate/combat
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	head = /obj/item/clothing/head/beret/sec/officer
	suit = /obj/item/clothing/suit/armor/vest/security/officer

/datum/outfit/job/security/western
	name = "Security Detail (Western)"

	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	head = /obj/item/clothing/head/cowboy/sec

/datum/outfit/job/security/minutemen
	name = "Minuteman (Colonial Minutemen)"

	head = /obj/item/clothing/head/helmet/bulletproof/minutemen
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat

	belt = /obj/item/storage/belt/military

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security/cmm
	box = /obj/item/storage/box/survival/engineer/radio
	backpack_contents = null

/datum/outfit/job/security/minutemen/naked
	name = "Minuteman (Colonial Minutemen) (Naked)"

	head = null
	suit = null
	mask = null
	shoes = null
	gloves = null
	ears = null

	belt = null

	l_pocket = null
	r_pocket = null

/datum/outfit/job/security/minutemen/armed
	name = "Minuteman (Colonial Minutemen) (Armed)"

	suit_store = /obj/item/gun/ballistic/automatic/assualt/p16/minutemen
	belt = /obj/item/storage/belt/military/minutemen

/datum/outfit/job/security/minutemen/mechpilot
	name = "Mech Pilot  (Colonial Minutemen)"

	suit = /obj/item/clothing/suit/armor/vest/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	glasses = /obj/item/clothing/glasses/hud/diagnostic

	backpack_contents = list(/obj/item/melee/classic_baton=1, /obj/item/gun/ballistic/automatic/pistol/commander=1, /obj/item/restraints/handcuffs=1)

/datum/outfit/job/security/inteq
	name = "IRMG Enforcer (Inteq)"

	head = /obj/item/clothing/head/helmet/inteq
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/security/webbing/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	gloves = /obj/item/clothing/gloves/combat

	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/melee/baton/loaded=1, /obj/item/ammo_box/magazine/co9mm=1, /obj/item/gun_voucher=1,/obj/item/pda/security)

/datum/outfit/job/security/inteq/beluga
	name = "IRMG Enforcer (Beluga)"

	head = /obj/item/clothing/head/beret/sec/inteq
	suit = null
	belt = null
	mask = null
	uniform = /obj/item/clothing/under/syndicate/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = null
	gloves = /obj/item/clothing/gloves/color/evening

	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/pda/security)

/datum/outfit/job/security/inteq/naked
	name = "IRMG Enforcer (Inteq) (Naked)"
	head = null
	suit = null
	belt = null
	mask = null
	gloves = null

/datum/outfit/job/security/nanotrasen
	name = "Security Officer (Nanotrasen)"

	uniform = /obj/item/clothing/under/rank/security/officer/nt
	alt_uniform = null

/datum/outfit/job/security/roumain
	name = "Hunter (Saint-Roumain Militia)"

	uniform = /obj/item/clothing/under/suit/roumain
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/workboots/mining
	suit = /obj/item/clothing/suit/armor/roumain

	head = /obj/item/clothing/head/cowboy/sec/roumain
	gloves = null
	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger
	backpack_contents = null

/datum/outfit/job/security/syndicate/gorlex
	name = "Syndicate Battlecruiser Assault Operative"
	uniform = /obj/item/clothing/under/syndicate
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military
	back = /obj/item/storage/backpack
	suit = /obj/item/clothing/suit/armor/vest
	id = /obj/item/card/id/syndicate_command/crew_id
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1)

/datum/outfit/job/security/syndicate/sbc
	name = "Operative (Twinkleshine)"
	uniform = /obj/item/clothing/under/syndicate/combat
	ears = /obj/item/radio/headset/syndicate/alt
	mask = /obj/item/clothing/mask/gas/syndicate/voicechanger
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	id = /obj/item/card/id/syndicate_command/crew_id
	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/gun_voucher/syndicate=1)

	head = null
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	box = /obj/item/storage/box/survival/syndie

/datum/outfit/job/security/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(4, 8)) // squidquest real
	I.assignment = "Operative"
	I.access |= list(ACCESS_SYNDICATE)
	I.update_label()

/datum/outfit/job/security/aipirate
	name = "Nodesman (Security)"

	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/kitchen/knife/combat

	backpack_contents = list(/obj/item/melee/baton/loaded=1)

	implants = list(/obj/item/implant/radio)


/datum/outfit/job/security/Frontiersmen
	name = "Buccaneer (Frontiersmen)"

	head = /obj/item/clothing/head/beret/sec/frontier
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = null
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/pirate/alt

	belt = /obj/item/storage/belt/security/webbing

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

//Shiptest outfits end
