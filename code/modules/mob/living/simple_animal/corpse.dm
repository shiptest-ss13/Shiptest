//Meant for simple animals to drop lootable human bodies.

//If someone can do this in a neater way, be my guest-Kor

//This has to be separate from the Away Mission corpses, because New() doesn't work for those, and initialize() doesn't work for these.

//To do: Allow corpses to appear mangled, bloody, etc. Allow customizing the bodies appearance (they're all bald and white right now).

//List of different corpse types

/obj/effect/mob_spawn/human/corpse/syndicatesoldier
	name = "Syndicate Operative"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatesoldiercorpse

/datum/outfit/syndicatesoldiercorpse
	name = "Syndicate Operative Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/helmet/swat
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/human/corpse/syndicatecommando
	name = "Syndicate Commando"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatecommandocorpse

/datum/outfit/syndicatecommandocorpse
	name = "Syndicate Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/human/corpse/syndicateramzi
	name = "Ramzi Clique Commando"
	id_job = "Cutthroat"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicateramzicorpse

/datum/outfit/syndicateramzicorpse
	name = "Ramzi Clique Commando Corpse"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	id = /obj/item/card/id/syndicate_command/crew_id


/obj/effect/mob_spawn/human/corpse/syndicatestormtrooper
	name = "Syndicate Stormtrooper"
	id_job = "Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/syndicatestormtroopercorpse

/datum/outfit/syndicatestormtroopercorpse
	name = "Syndicate Stormtrooper Corpse"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	mask = /obj/item/clothing/mask/gas/syndicate
	back = /obj/item/tank/jetpack/oxygen/harness
	id = /obj/item/card/id/syndicate


/obj/effect/mob_spawn/human/clown/corpse
	roundstart = FALSE
	instant = TRUE
	skin_tone = "caucasian1"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/obj/effect/mob_spawn/human/corpse/pirate
	name = "Pirate"
	skin_tone = "caucasian1" //all pirates are white because it's easier that way
	outfit = /datum/outfit/piratecorpse
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

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


/obj/effect/mob_spawn/human/corpse/frontier
	name = "Frontiersman"
	outfit = /datum/outfit/frontier
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"

/datum/outfit/frontier
	name = "Frontiersman Corpse"
	uniform = /obj/item/clothing/under/frontiersmen
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/beret/sec/frontier
	gloves = /obj/item/clothing/gloves/color/black

/obj/effect/mob_spawn/human/corpse/frontier/ranged
	outfit = /datum/outfit/frontier

/obj/effect/mob_spawn/human/corpse/frontier/surgeon
	outfit = /datum/outfit/job/frontiersmen/doctor/corpse

/datum/outfit/job/frontiersmen/doctor/corpse
	name = "Frontiersmen Surgeon Corpse"
	r_pocket = null

/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper
	outfit = /datum/outfit/frontier/trooper

/datum/outfit/frontier/trooper
	name = "Frontiersman Armored Corpse"
	suit = /obj/item/clothing/suit/armor/vest/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	ears = /obj/item/radio/headset
	head = /obj/item/clothing/head/helmet/bulletproof/x11/frontier


/obj/effect/mob_spawn/human/corpse/frontier/ranged/officer
	name = "Frontiersman Officer"
	outfit = /datum/outfit/frontier/officer

/datum/outfit/frontier/officer
	name = "Frontiersman Officer Corpse"
	uniform = /obj/item/clothing/under/frontiersmen/officer
	suit = /obj/item/clothing/suit/armor/frontier
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset
	head = /obj/item/clothing/head/frontier/peaked

/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy
	outfit = /datum/outfit/frontier/trooper/heavy

/datum/outfit/frontier/trooper/heavy
	name = "Frontiersman Heavy Corpse"
	suit = /obj/item/clothing/suit/space/hardsuit/security/independent/frontier
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	back = /obj/item/minigunpack

/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/heavy/gunless
	outfit = /datum/outfit/frontier/trooper/heavy/gunless

/obj/effect/mob_spawn/human/corpse/frontier/ranged/trooper/flame
	outfit = /datum/outfit/job/frontiersmen/ert/flamer/corpse

/datum/outfit/job/frontiersmen/ert/flamer/corpse
	name = "Frontiersman Flametrooper Corpse"
	back = null
	belt = /obj/item/storage/belt/security/military/frontiersmen
	l_hand = null

	backpack_contents = null

/datum/outfit/frontier/trooper/heavy/gunless
	name = "Frontiersman Heavy Corpse (Gunless)"
	back = null

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
