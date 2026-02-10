//Meant for simple animals to drop lootable human bodies.

//If someone can do this in a neater way, be my guest-Kor

//This has to be separate from the Away Mission corpses, because New() doesn't work for those, and initialize() doesn't work for these.

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

//List of different corpse types

/obj/effect/mob_spawn/human/corpse/ramzi
	name = "Ramzi Operative"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi

/datum/outfit/ramzi
	name = "Ramzi Clique Corpse"
	uniform = /obj/item/clothing/under/syndicate/ramzi/overalls
	suit = /obj/item/clothing/suit/armor/ramzi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/alt
	mask = /obj/item/clothing/mask/gas/ramzi
	head = /obj/item/clothing/head/helmet/m10/ramzi
	back = /obj/item/storage/backpack
	neck = /obj/item/clothing/neck/dogtag/ramzi
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/human/corpse/ramzi/engi
	name = "Ramzi Engineer"
	outfit = /datum/outfit/ramzi/engi

/datum/outfit/ramzi/engi
	name = "Ramzi Technician Corpse"
	suit = /obj/item/clothing/suit/ramzi
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	head = /obj/item/clothing/head/hardhat/ramzi
	glasses = /obj/item/clothing/glasses/welding
	belt = /obj/item/storage/belt/utility

/obj/effect/mob_spawn/human/corpse/ramzi/doctor
	name = "Ramzi Field Medic"
	outfit = /datum/outfit/ramzi/doctor

/datum/outfit/ramzi/doctor
	name = "Ramzi Sawbones Corpse"
	uniform = /obj/item/clothing/under/syndicate/ramzi
	suit = /obj/item/clothing/suit/ramzi/smock
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil //EVIL
	head = /obj/item/clothing/head/ramzi/surgical

/datum/outfit/ramzi/bulletproof
	name = "Ramzi Clique Rifleman"
	suit = /obj/item/clothing/suit/armor/ramzi/bulletproof
	head = /obj/item/clothing/head/helmet/bulletproof/x11/ramzi
	belt = /obj/item/storage/belt/security/webbing/ramzi/alt
	mask = /obj/item/clothing/mask/breath/facemask
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	neck = /obj/item/clothing/neck/shemagh/ramzi

/obj/effect/mob_spawn/human/corpse/ramzi/trooper
	name = "Ramzi Trooper"
	outfit = /datum/outfit/ramzi/bulletproof

/obj/effect/mob_spawn/human/corpse/ramzi/space
	name = "Ramzi Hardsuit"
	outfit = /datum/outfit/ramzi/commando

/datum/outfit/ramzi/commando
	name = "Ramzi Clique Space Corpse"
	uniform = /obj/item/clothing/under/syndicate/ramzi
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi
	mask = /obj/item/clothing/mask/breath/facemask
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen

/obj/effect/mob_spawn/human/corpse/ramzi/space/soft
	name = "Ramzi Softsuit"
	outfit = /datum/outfit/ramzi/soft

/datum/outfit/ramzi/soft
	name = "Ramzi Clique Softsuit"
	uniform = /obj/item/clothing/under/syndicate/ramzi
	head = /obj/item/clothing/head/helmet/space/syndicate/ramzi
	suit = /obj/item/clothing/suit/space/syndicate/ramzi
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen

/obj/effect/mob_spawn/human/corpse/ramzi/space/soft/surplus
	name = "Ramzi Softsuit Surplus"
	outfit = /datum/outfit/ramzi/soft/surplus

/obj/effect/mob_spawn/human/corpse/ramzi/towel
	name = "Ramzi Showerer"
	outfit = /datum/outfit/ramzi/towel

/datum/outfit/ramzi/towel
	name = "Ramzi Clique Showerer"
	uniform = null
	head = null
	suit = /obj/item/towel/full
	back = null
	id = null
	shoes = null
	gloves = null

/datum/outfit/ramzi/soft/surplus
	name = "Ramzi Clique Softsuit Surplus"
	uniform = /obj/item/clothing/under/syndicate/ramzi
	head = /obj/item/clothing/head/helmet/space/syndicate/ramzi/surplus
	suit = /obj/item/clothing/suit/space/syndicate/ramzi/surplus
	back = /obj/item/storage/backpack
	r_pocket = /obj/item/tank/internals/emergency_oxygen

/datum/outfit/ramzi/sniper
	name = "Ramzi Clique Sniper"
	uniform = /obj/item/clothing/under/syndicate/ramzi
	head = /obj/item/clothing/head/helmet/space/hardsuit/stealth/ramzi
	suit = /obj/item/clothing/suit/space/hardsuit/stealth/ramzi
	back = /obj/item/tank/jetpack/oxygen/harness
	r_pocket = /obj/item/tank/internals/emergency_oxygen

/obj/effect/mob_spawn/human/corpse/ramzi/sniper
	name = "Ramzi Clique Sniper"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi/sniper

/obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	name = "Ramzi Clique Trooper"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi/stormtrooper

/datum/outfit/ramzi/officer
	name = "Ramzi Clique Officer"
	uniform = /obj/item/clothing/under/syndicate/ramzi/officer
	suit = /obj/item/clothing/suit/armor/ramzi/officer
	head = /obj/item/clothing/head/ramzi/beret
	back = null
	mask = /obj/item/clothing/mask/breath/facemask
	neck = /obj/item/clothing/neck/dogtag/gold

/obj/effect/mob_spawn/human/corpse/ramzi/officer
	name = "Ramzi Clique Officer"
	outfit = /datum/outfit/ramzi/officer

/obj/effect/mob_spawn/human/corpse/ramzi/officer/beach
	name = "Ramzi Clique Quartermaster"
	mob_species = /datum/species/human
	mob_gender = FEMALE

/obj/effect/mob_spawn/human/corpse/ramzi/officer/ngr
	name = "Corrupt NGR Official"
	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	head = /obj/item/clothing/head/ngr
	suit = /obj/item/clothing/suit/armor/ngr/lieutenant
	glasses = null
	neck = null
	mob_gender = FEMALE
	mob_species = /datum/species/human

/datum/outfit/ramzi/stormtrooper
	name = "Ramzi Clique Trooper Corpse"
	uniform = /obj/item/clothing/under/syndicate/ramzi/officer
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi/elite
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi/elite
	mask = /obj/item/clothing/mask/breath/facemask
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	back = /obj/item/tank/jetpack/oxygen/harness

/datum/outfit/syndicatecaptaincorpse
	name = "Syndicate Captain Corpse"
	uniform = /obj/item/clothing/under/syndicate/gorlex
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	shoes = /obj/item/clothing/shoes/combat/coldres
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate
	head = /obj/item/clothing/head/HoS/syndicate
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/corpse/syndicatecaptain
	name = "Syndicate Captain"
	id_job = "Syndicate Base Commander"
	outfit = /datum/outfit/syndicatecaptaincorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/cybersunmedicaldirectorcorpse
	name = "Cybersun Medical Director Corpse"
	uniform = /obj/item/clothing/under/rank/medical/chief_medical_officer/cybersun
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/cybersun
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	ears = /obj/item/radio/headset/syndicate
	belt = /obj/item/gun/ballistic/automatic/pistol/challenger
	head = /obj/item/clothing/head/soft/cybersun/medical
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/corpse/cybersunmedicaldirector
	name = "Cybersun Medical Director Corpse"
	id_job = "Cybersun Medical Director"
	outfit = /datum/outfit/cybersunmedicaldirectorcorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/cybersunfieldmediccorpse
	name = "Cybersun Field Medic Corpse"
	uniform = /obj/item/clothing/under/syndicate/medic
	suit = /obj/item/clothing/suit/toggle/labcoat/raincoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	ears = /obj/item/radio/headset/syndicate
	belt = /obj/item/storage/belt/medical/paramedic
	head = /obj/item/clothing/head/soft/cybersun/medical
	back = /obj/item/storage/backpack/messenger
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/corpse/cybersunfieldmedic
	name = "Cybersun Field Medic"
	id_job = "Cybersun Field Medic"
	outfit = /datum/outfit/cybersunfieldmediccorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"


/obj/effect/mob_spawn/human/corpse/pirate
	name = "Pirate"
	outfit = /datum/outfit/piratecorpse

/datum/outfit/piratecorpse
	name = "Pirate Corpse"
	uniform = /obj/item/clothing/under/costume/pirate
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/eyepatch
	head = /obj/item/clothing/head/bandana


/obj/effect/mob_spawn/human/corpse/pirate/ranged
	name = "Pirate Gunner"
	outfit = /datum/outfit/piratecorpse/ranged

/datum/outfit/piratecorpse/ranged
	name = "Pirate Gunner Corpse"
	suit = /obj/item/clothing/suit/pirate
	head = /obj/item/clothing/head/pirate

/obj/effect/mob_spawn/human/corpse/wizard
	name = "Space Wizard Corpse"
	outfit = /datum/outfit/wizardcorpse
	hairstyle = "Bald"
	facial_hairstyle = "Long Beard"
	skin_tone = "caucasian1"

/datum/outfit/wizardcorpse
	name = "Space Wizard Corpse"
	uniform = /obj/item/clothing/under/color/lightpurple
	suit = /obj/item/clothing/suit/wizrobe
	shoes = /obj/item/clothing/shoes/sandal/magic
	head = /obj/item/clothing/head/wizard


/datum/outfit/vigilitas
	name = "VI Corpse"
	uniform = /obj/item/clothing/under/nanotrasen/security
	suit = /obj/item/clothing/suit/armor/nanotrasen
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/headset_sec/alt
	mask = /obj/item/clothing/mask/gas/vigilitas
	head = /obj/item/clothing/head/nanotrasen/cap/security
	back = /obj/item/storage/backpack/messenger
	id = /obj/item/card/id

/datum/outfit/vigilitas/space
	name = "VI Responder"
	suit = /obj/item/clothing/suit/space/hardsuit/security
	head = /obj/item/clothing/head/helmet/space/hardsuit/security
	back = /obj/item/tank/jetpack/carbondioxide

/datum/outfit/vigilitas/space/hos
	name = "VI Breacher"
	suit = /obj/item/clothing/suit/space/hardsuit/security/hos
	head = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	back = /obj/item/tank/jetpack/carbondioxide

/datum/outfit/vigilitas/director
	name = "VI director"
	uniform = /obj/item/clothing/under/nanotrasen/security/director
	suit = /obj/item/clothing/suit/armor/nanotrasen/sec_director
	head = /obj/item/clothing/head/nanotrasen/beret/security/command

/datum/outfit/vigilitas/private
	name = "VI Private"

/obj/effect/mob_spawn/human/corpse/vigilitas_private
	name = "VI Private"
	id_job = "Vigilitas Interstellar"
	outfit = /datum/outfit/vigilitas/private

/obj/effect/mob_spawn/human/corpse/vigilitas_director
	name = "VI Director"
	id_job = "Vigilitas Interstellar"
	outfit = /datum/outfit/vigilitas/director

/datum/outfit/vigilitas/trooper
	name = "VI Trooper"
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/m10
	back = /obj/item/storage/backpack/security

/obj/effect/mob_spawn/human/corpse/vigilitas_trooper
	name = "VI Trooper"
	id_job = "Vigilitas Assault Force"
	outfit = /datum/outfit/vigilitas/trooper

/datum/outfit/vigilitas/elite
	name = "VI Response Team"
	suit = /obj/item/clothing/suit/space/hardsuit/ert/sec
	head = /obj/item/clothing/head/helmet/space/hardsuit/ert/sec
	back = /obj/item/storage/backpack/security
	gloves = /obj/item/clothing/gloves/combat

/obj/effect/mob_spawn/human/corpse/vigilitas_hos
	name = "VI Breacher"
	id_job = "Vigilitas Assault Force"
	outfit = /datum/outfit/vigilitas/space/hos

/obj/effect/mob_spawn/human/corpse/vigilitas_space
	name = "VI Responder"
	id_job = "Vigilitas Assault Force"
	outfit = /datum/outfit/vigilitas/space

/obj/effect/mob_spawn/human/corpse/vigilitas_elite
	name = "VI Response Team"
	id_job = "Vigilitas Assault Force"
	outfit = /datum/outfit/vigilitas/elite

/obj/effect/mob_spawn/human/corpse/cat_butcher
	name = "The Cat Surgeon"
	id_job = "Cat Surgeon"
	id_access_list = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)
	hairstyle = "Cut Hair"
	facial_hairstyle = "Watson Mustache"
	skin_tone = "caucasian1"
	outfit = /datum/outfit/cat_butcher

/datum/outfit/cat_butcher
	name = "Cat Butcher Uniform"
	uniform = /obj/item/clothing/under/rank/medical/doctor/green
	suit = /obj/item/clothing/suit/apron/surgical
	shoes = /obj/item/clothing/shoes/sneakers/white
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack/satchel/med
	id = /obj/item/card/id
	glasses = /obj/item/clothing/glasses/hud/health

/obj/effect/mob_spawn/human/corpse/solgov/sonnensoldner
	name = "SolGov Sonnensoldner"
	id_job = "SolGov Sonnensoldner"
	outfit = /datum/outfit/job/solgov/sonnensoldner
	id_access_list = list(ACCESS_SOLGOV)

//inteq

/obj/effect/mob_spawn/human/corpse/inteq
	name = "Avery Inteq"

/obj/effect/mob_spawn/human/corpse/inteq/recruit
	name = "IRMG Auxiliary"
	id_job = "Auxiliary"
	outfit = /datum/outfit/job/inteq/assistant

/obj/effect/mob_spawn/human/corpse/inteq/medic
	name = "IRMG Corpsman"
	id_job = "Corpsman"
	outfit = /datum/outfit/job/inteq/paramedic

/obj/effect/mob_spawn/human/corpse/inteq/enforcer
	name = "IRMG Enforcer"
	id_job = "Enforcer"
	outfit = /datum/outfit/job/inteq/security

/obj/effect/mob_spawn/human/corpse/inteq/vanguard
	name = "IRMG Vanguard"
	id_job = "Vanguard"
	outfit = /datum/outfit/job/inteq/captain

/obj/effect/mob_spawn/human/corpse/inteq/artificer
	name = "IRMG Artificer"
	id_job = "Artificer"
	outfit = /datum/outfit/job/inteq/engineer

/* SRM */

/obj/effect/mob_spawn/human/corpse/srm/hunter
	name = "SRM Hunter"
	id_job = "Hunter"
	outfit = /datum/outfit/job/roumain/security
	id_access_list = null

/obj/effect/mob_spawn/human/corpse/srm/montagne
	name = "SRM Montagne"
	id_job = "Hunter Montagne"
	outfit = /datum/outfit/job/roumain/captain
	id_access_list = null

/* PGF */
/obj/effect/mob_spawn/human/corpse/pgf
	name = "PGF Crewmate"
	id_job = "Crewmate"
	mob_species = /datum/species/lizard
	outfit = /datum/outfit/job/gezena/assistant
	id_access_list = null

/obj/effect/mob_spawn/human/corpse/pgf/marine
	name = "PGF Marine"
	id_job = "Marine"
	outfit = /datum/outfit/job/gezena/security

/obj/effect/mob_spawn/human/corpse/pgf/captain
	name = "PGF Captain"
	id_job = "Captain"
	outfit = /datum/outfit/job/gezena/captain

