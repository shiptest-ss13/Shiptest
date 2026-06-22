//ngr prison jumpsuit

/obj/item/clothing/under/color/lightbrown/prisoner
	name = "light brown prisoner jumpsuit"
	desc = "A cheap, lightweight jumpsuit. Its suit sensors are locked to the maximum setting."
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

//ruin-exclusive frontie mob that doesnt fit with the rest

/mob/living/simple_animal/hostile/human/frontier/ranged/internals/ngr_colony_ramzifriend
	name = "Frontiersman Smuggler"
	desc = "Once a member of the vicious Frontiersmen fleet, this ex-smuggler seems to have befriended the far more vicious Ramzi Clique. They stroll around with less discipline than their new peers, a jet-black pistol at their hip."
	mob_spawner = /obj/effect/mob_spawn/human/corpse/frontier/ramzifriend_smuggler
	casingtype = /obj/item/ammo_casing/c57x39mm
	r_hand = /obj/item/gun/ballistic/automatic/pistol/asp
	projectilesound = 'sound/weapons/gun/pistol/asp.ogg'
	faction = list(FACTION_RAMZI, FACTION_ANTAG_FRONTIERSMEN) //theyre loyal to their new friends but still loyal to their old comrades
	armor_base = /obj/item/clothing/suit/armor/ramzi

/obj/effect/mob_spawn/human/corpse/frontier/ramzifriend_smuggler
	outfit = /datum/outfit/frontier/internals/smuggler

/datum/outfit/frontier/internals/smuggler
	name = "Frontiersman Smuggler Corpse"
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	suit = /obj/item/clothing/suit/armor/ramzi
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/flashlight
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/security/webbing/ramzi/alt

//papers please


/obj/item/paper/crumpled/bloody/fluff/ruins/ngr_rock_colony/mine_report
	desc = "A thin layer of dried blood is caked over part of the note."
	default_raw_text = "Bit worried about hole two. One's pretty fine, just a class two, but it's pretty deep and the well-established turret cover we have means there's low risk of ours getting hurt. But two's got these weird, <i>real unsettling</i> cyan crystals growing out of it."

/obj/item/paper/crumpled/bloody/fluff/ruins/ngr_rock_colony/cavein
	name = "IMPORTANT"
	default_raw_text = "IF THE HOLE 2 DRILLING GOES TITS UP, I'VE RIGGED A BUNCH OF C4 TO THE CAVE ROOF TO CAUSE A CAVE-IN. TAKE CARE."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/commanders_log_one
	name = "commander's log, day 72"
	default_raw_text = "<b>Day 72</b><br><br>A Frontiersman moonshiner was stopped east of the colony by our security team while trying to sell one of the miners cheap 'shine. I've had the responsible miner disciplined (and borrowed some of the 'shine for myself) and the Frontie's in detainment for the time being. Waiting on a response from Command for transferring them."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/commanders_log_two
	name = "commander's log, day 78"
	default_raw_text = "<b>Day 78</b><br><br>Score. A 9-man fireteam of the Ramzi traitors attacked the colony earlier today. Good news is, we managed to track their dropship down before they finished getting out. Our troops killed one of them and captured the rest alive. Bad news is the colony's brig is now massively overcrowded, so we've had to order for a few mattresses so they've got places to sleep. Command says it'll be a 'month or two' before they get a transport in, apparently due to a recent wave of Frontiersmen cells in Republic space surrendering and needing to be hauled back. Should at least keep 'em comfortable."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/commanders_log_three
	name = "commander's log, day 108"
	default_raw_text = "<b>Day 108</b><br><br>The mining crews started work on Vein 2 today. Apparently, it goes really deep and has a lot of good-quality materials, but one of them raised concerns about some cyan crystals inside the vein. <s>I have high confidence it'll be fine</s>Looked at suit sensors and all of the mining crew are dead. I'm having the mines locked down for the next few days until reinforcements arrive."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/commanders_log_four
	name = "commander's log, day 109"
	default_raw_text = "<b>Day 109</b><br><br>Guards have given me word that there's a large horde of fauna not long out. Apparently the drilling incident yesterday spooked a whole damn nest of gruboids and mi-gos and all the other nasty things these worlds have to offer, and a bunch of them have begun making the trip here. Would've been nice to hear earlier. I'm passing an evacuation order and we're evacuating until Command can reclaim the colony."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/prisoner_notice
	name = "notice to prisoners"
	default_raw_text = "I'm gonna be honest, this colony was never built to accomodate this many of you. We're doing our best to keep you lot comfortable until Command stops dragging their feet. If you need any extra bedding or supplies or whatnot, notify the Sarge, and they'll see what the technicians can spare. Keep playing nice, please."

/obj/item/paper/crumpled/fluff/ruins/ngr_rock_colony/prisoner_procedure
	name = "reminder to guards"
	default_raw_text = "Only give them extras approved by the Sergeant, and don't give 'em anything more. Alcohol is also prohibited, and if any of them distill with what's in the garden you oughta raise issue. Especially because one of them's a Frontie 'shiner. Also, if we ever have to evacuate, herd 'em onto the shuttle if you can."

/obj/item/paper/crumpled/muddy/fluff/ngr_colony_ramzi_camp_moonshine_note
	default_raw_text = "i managed to recover most of your moonshining equipment from the warehouse, apparently they dumped it there after they cut up your ship and never got around to using it. you owe me a few jugs of the good stuff for this."
