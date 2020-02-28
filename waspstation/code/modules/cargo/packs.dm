
/datum/supply_pack/security/armory/riot_shotgun_single
	name = "Riot Shotgun Single-Pack"
	desc = "When you simply just want Butch to step aside. Requires Armory level access to open."
	cost =  2500
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/belt/bandolier)

/datum/supply_pack/security/armory/riot_shotgun
	name = "Riot Shotguns Crate"
	desc = "For when the greytide gets out of hand. Contains 3 pump shotguns and shotgun ammo bandoliers to go with. Requires Armory level access to open."
	cost = 6000
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier,
					/obj/item/storage/belt/bandolier)

/datum/supply_pack/emergency/syndicate //Thanks, Ogan.
	name = "NULL_ENTRY"
	desc = "(#@&^$THIS PACKAGE CONTAINS 30TC WORTH OF SOME RANDOM SYNDICATE GEAR WE HAD LYING AROUND THE WAREHOUSE. GIVE EM HELL, OPERATIVE, BUT DON'T GET GREEDY- ORDER TOO MANY AND WE'LL BE SENDING OUR DEADLIEST ENFORCERS TO INVESTIGATE@&!*() "
	hidden = TRUE
	cost = 20000
	contains = list()
	crate_name = "emergency crate"
	crate_type = /obj/structure/closet/crate/internals
	dangerous = TRUE
	var/beepsky_chance = 0

/datum/supply_pack/emergency/syndicate/fill(obj/structure/closet/crate/C)
	var/crate_value = 30
	var/list/uplink_items = get_uplink_items(SSticker.mode)
	while(crate_value)
		if(prob(beepsky_chance))
			new /mob/living/simple_animal/bot/secbot/grievous/nullcrate(C)
			crate_value = 0
		var/category = pick(uplink_items)
		var/item = pick(uplink_items[category])
		var/datum/uplink_item/I = uplink_items[category][item]
		if(!I.surplus_nullcrates || prob(100 - I.surplus_nullcrates))
			continue
			if(crate_value < I.cost)
				continue
			crate_value -= I.cost
			new I.item(C)
	beepsky_chance += 1 //1% chance per crate an item will be replaced with a beepsky and the crate stops spawning items. Doesnt act as a hardcap, making nullcrates far riskier and less predictable
	var/datum/round_event_control/operative/loneop = locate(/datum/round_event_control/operative) in SSevents.control
	if(istype(loneop))
		loneop.weight += 5
		message_admins("a NULL_ENTRY crate has shipped, increasing the weight of the Lone Operative event to [loneop.weight]")
		log_game("a NULL_ENTRY crate has shipped, increasing the weight of the Lone Operative event to [loneop.weight]")

/datum/supply_pack/engine/am_jar
	name = "Antimatter Containment Jar Crate"
	desc = "Two Antimatter containment jars stuffed into a single crate."
	cost = 2000
	contains = list(/obj/item/am_containment,
					/obj/item/am_containment)
	crate_name = "antimatter jar crate"

/datum/supply_pack/engine/am_core
	name = "Antimatter Control Crate"
	desc = "The brains of the Antimatter engine, this device is sure to teach the station's powergrid the true meaning of real power."
	cost = 5000
	contains = list(/obj/machinery/power/am_control_unit)
	crate_name = "antimatter control crate"

/datum/supply_pack/engine/am_shielding
	name = "Antimatter Shielding Crate"
	desc = "Contains ten Antimatter shields, somehow crammed into a crate."
	cost = 2000
	contains = list(/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container,
					/obj/item/am_shielding_container) //10 shields: 3x3 containment and a core
	crate_name = "antimatter shielding crate"
