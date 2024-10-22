/datum/preset_holoimage/cybersun_researcher
	outfit_type = /datum/outfit/job/syndicate/science/cybersun
	species_type = /datum/species/elzuose

/obj/item/disk/holodisk/kansatsu/gear
	preset_image_type = /datum/preset_holoimage/cybersun_researcher

/obj/item/disk/holodisk/kansatsu/gear/tablets
	name = "\improper IR-241" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the Syndix tablets."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a set of Cybersun Virtual Solutions Syndix Tablets.
	DELAY 40
	SAY They will allow you to maintain communications over a long range, via the Chatting feature.
	DELAY 40
	SAY We advise you to create a private channel where you maintain contact with personnel on missions.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}

/obj/item/disk/holodisk/kansatsu/gear/chameleon
	name = "\improper IR-174" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the Chameleon gear."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a Cybersun Industries Chameleon Gear Kit.
	DELAY 40
	SAY It contains three pieces of advanced gear used for espionage.
	DELAY 40
	SAY The most exciting gadget included is the Chameleon kit - the Chameleon projector. It is a personal cloaking device that is excellent for getting in and out unnoticed.
	DELAY 40
	The rest of
	DELAY 40
	SAY Second piece of gear is the Chameleon holster. It allows you to smuggle a firearm past any security checkpoint, which will prove vital for self-defense and assassination missions.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}

/obj/item/storage/box/syndie_kit/kansatsu/chameleon
	name = "chameleon gear kit"
	illustration = "glasses"

/obj/item/storage/box/syndie_kit/kansatsu/chameleon/PopulateContents() // Same as normal, but instead of stamp and PDA, it gets a holster, a projector and a holodisk.
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/backpack/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)
	new /obj/item/radio/headset/chameleon(src)
	new /obj/item/clothing/accessory/holster/chameleon(src)
	new /obj/item/chameleon(src)
	new /obj/item/disk/holodisk/kansatsu/gear/chameleon(src)


/obj/item/disk/holodisk/kansatsu/gear/pens
	name = "\improper IR-304" // Introductory Recording - Random Number
	desc = "A classified holodisk containing an introduction to the modified pens."
	preset_record_text = {"
	NAME Researcher Meenus-Seeba
	SAY You have been issued a set of Cybersun Biodynamics Modified Pen Kit.
	DELAY 40
	SAY It contains three advanced pens with utility in espionage.
	DELAY 40
	SAY First of the pens doubles as a tiny energy knife. Extremely useful in combat and for utility, while being practically unrecognizable.
	DELAY 40
	SAY Second pen is equipped with a hidden chemical injector at the tip. After stabbing a target with it, they will be subdued shortly. Perfect for target extraction.
	DELAY 40
	SAY Third pen, and the most visually distinctive one, has a diamond tip that can be used to mine. Not the fastest way to move around, but can certainly prove useful in emergencies.
	DELAY 40
	SAY The Cybersun Industries Modified Pen Kit also contains a complimentraty pocket protector to carry the pens in without drawing too much suspicion.
	DELAY 40
	SAY Good luck.
	DELAY 20
	"}

/obj/item/storage/box/syndie_kit/kansatsu/pens
	name = "modified pen kit"
	illustration = "fpen"

/obj/item/storage/box/syndie_kit/kansatsu/pens/PopulateContents()
	new /obj/item/pen/edagger(src)
	new /obj/item/pen/sleepy(src)
	new /obj/item/pen/survival(src)
	new /obj/item/clothing/accessory/pocketprotector(src)
	new /obj/item/disk/holodisk/kansatsu/gear/pens(src)
