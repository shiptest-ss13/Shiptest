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
	uniform = /obj/item/clothing/under/syndicate/gorlex
	suit = /obj/item/clothing/suit/armor/vest/syndie
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/alt
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/syndie
	back = /obj/item/storage/backpack
	neck = /obj/item/clothing/neck/dogtag/ramzi
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/human/corpse/ramzi/space
	name = "Ramzi Hardsuit"
	outfit = /datum/outfit/ramzi/commando

/datum/outfit/ramzi/commando
	name = "Ramzi Clique Space Corpse"
	uniform = /obj/item/clothing/under/syndicate/combat
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi/ramzi
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen

/obj/effect/mob_spawn/human/corpse/ramzi/stormtrooper
	name = "Ramzi Clique Trooper"
	id_job = "Operative"
	outfit = /datum/outfit/ramzi/stormtrooper

/datum/outfit/ramzi/stormtrooper
	name = "Ramzi Clique Trooper Corpse"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	head = /obj/item/clothing/head/helmet/space/hardsuit/syndi
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen/harness

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


/obj/effect/mob_spawn/human/corpse/nanotrasensoldier
	name = "\improper Nanotrasen Private Security Officer"
	id_job = "Private Security Force"
	outfit = /datum/outfit/nanotrasensoldiercorpse2
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/nanotrasensoldiercorpse2
	name = "NT Private Security Officer Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/corpse/nanotrasenassaultsoldier
	name = "Nanotrasen Private Security Officer"
	id_job = "Nanotrasen Assault Force"
	outfit = /datum/outfit/nanotrasenassaultsoldiercorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/nanotrasenassaultsoldiercorpse
	name = "NT Assault Officer Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id

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
	name = "IRMG Recruit"
	id_job = "Recruit"
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
