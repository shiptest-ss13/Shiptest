//the satchel charge that'll explode

/obj/item/grenade/c4/satchel_charge/cave_base
	desc = "With Love - Kerberos-574"

//i am such a bitch
/obj/item/grenade/c4/satchel_charge/cave_base/Initialize()
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_OBSERVER, use_anchor = TRUE)
	wires.attach_assembly_init(/obj/item/assembly/voice/preset/cave_base)

/obj/item/assembly/voice/preset/cave_base
	mode = 1
	recorded = "Goodbye~"

//gut wrenching content

/datum/preset_holoimage/hapless_ipc
	species_type = /datum/species/ipc
	outfit_type = /datum/outfit/job/independent/security/pirate/jupiter

/datum/outfit/cave_base_ipc
	name = "Cave Base IPC"
	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/kitchen/knife/combat
	suit = /obj/item/clothing/suit/hooded/cloak/goliath


/datum/preset_holoimage/hunting_ipc
	species_type = /datum/species/ipc
	outfit_type = /datum/outfit/cave_base_ipc

/obj/item/disk/holodisk/ruin/cave_base/one
	name = "holorecord disk - Journal #1"
	desc = "Stores recorder holocalls, has a layer of dust on it."
	preset_image_type = /datum/preset_holoimage/hapless_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY My Name is Kerberos-574. I've been assigned to this Operations Post for the foreseeable future.
	DELAY 20
	SAY Command's orders included some fine print.
	DELAY 10
	SAY Said *I* need to keep a journal for my morale's sake.
	SOUND keyboard
	DELAY 30
	SAY Don't know how long I'm gonna be down here but I'm not too keen on journaling.
	DELAY 20
	SAY We'll see how it goes, though.
	"}

/obj/item/disk/holodisk/ruin/cave_base/two
	name = "holorecord disk - Journal #2"
	preset_image_type = /datum/preset_holoimage/hapless_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY Been about... 2 months since my last journal entry. Haven't heard *shit* from anyone for the past....
	SOUND keyboard
	DELAY 5
	SAY 2 weeks?
	DELAY 20
	SAY Checked the relay and made sure that everything was linked up. Got a no connection error when I - well - tried to forcibly re-establish one.
	DELAY 40
	SAY Miss being able to chat. But. It is what it is.
	DELAY 10
	"}

/obj/item/disk/holodisk/ruin/cave_base/three
	name = "holorecord disk - Journal #3"
	preset_image_type = /datum/preset_holoimage/hapless_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY 'Nother month down the drain, aye Kerberos?
	DELAY 10
	SAY Yup. Still haven't heard anything from anyone.
	DELAY 10
	SAY Just making sure this place runs, and that *I'm* okay.
	DELAY 20
	SAY Weather has been picking up something fierce lately. Scanners are saying that the planetoid is entering it's winter.
	DELAY 40
	SAY Heh. Maybe some new beasts will show themselves.
	DELAY 10
	SAY I was dropped with an AMR and kit for a reason after all...
	DELAY 10
	SAY Self-defense. And you know what the Solarians say about the best defense.
	SOUND rustle
	"}

/obj/item/disk/holodisk/ruin/cave_base/four
	name = "holorecord disk - Journal #4"
	preset_image_type = /datum/preset_holoimage/hunting_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY One Four Point Five
	SOUND sparks
	DELAY 10
	SAY One Four Point Five By One Four Six Point Seven.
	SOUND sparks
	DELAY 10
	SOUND sparks
	DELAY 20
	SAY -and that animal clipped me in something important.
	DELAY 20
	SAY I got knocked around - and landed by something *buzzing*.
	DELAY 10
	SAY Got the gun. Scrambled away.
	DELAY 10
	SAY But I've been blacking out for bits. Losing days.
	DELAY 5
	SOUND rustle
	DELAY 10
	SAY And still no word from command. Starting to wor-
	DELAY 5
	SOUND sparks
	"}

/obj/item/disk/holodisk/ruin/cave_base/five
	name = "holorecord disk - Journal #5"
	preset_image_type = /datum/preset_holoimage/hunting_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY I used to be a renegade!~
	DELAY 10
	SAY Used to fool around!~
	SOUND sparks
	DELAY 10
	SAY But they left me on this godsdamned rock!~
	DELAY 20
	SAY And I had to learn new rounds!~
	DELAY 20
	SAY Don't know where I picked up that beat. Maybe that static put it in my processors.
	DELAY 30
	SAY I'm runnin out of rounds for my crunch gun too.
	DELAY 10
	SAY Not that I'm keen to heft 50kg around.
	SOUND rustle
	DELAY 10
	SAY But I've been going through my old intel reports, and there're some ships in the dust that I could get to. With a few weeks.
	DELAY 35
	SOUND sparks
	SAY I'm gonna go for it soon. Just gotta get everything in order.
	"}

/obj/item/disk/holodisk/ruin/cave_base/six
	name = "holorecord disk - Journal #6"
	preset_image_type = /datum/preset_holoimage/hunting_ipc
	preset_record_text = {"
	NAME Kerberos-574
	DELAY 10
	SAY Hey!
	DELAY 10
	SAY I missed you earlier.
	SOUND sparks
	DELAY 10
	SAY Gonna be out for a bit, gotta find a ship.
	DELAY 20
	SAY Gotta find a radio. Gotta call help.
	DELAY 20
	SAY Maybe they can fix me somewhere~
	DELAY 10
	SOUND sparks
	DELAY 10
	SAY I've got this place ah - set just in case anyone comes snooping around.
	DELAY 20
	SOUND sparks
	SAY There is no strategic information.
	DELAY 10
	SAY There is no essential equipment.
	DELAY 5
	SAY Just you and me~
	SOUND hiss
	DELAY 5
	SAY Maybe one day we'll really meet. For now?
	DELAY 10
	SAY Goodbye~
	"}
