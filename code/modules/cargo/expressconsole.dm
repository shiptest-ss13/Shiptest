#define BEACON_COST 500
#define SP_LINKED 1
#define SP_READY 2
#define SP_LAUNCH 3
#define SP_UNLINK 4
#define SP_UNREADY 5

/obj/machinery/computer/cargo/express
	name = "outpost communications console"
	desc = "This console allows the user to communicate with a nearby outpost to \
			purchase supplies and manage missions. Purchases are delivered near-instantly."
	icon_screen = "supply_express"
	circuit = /obj/item/circuitboard/computer/cargo/express
	var/blockade_warning = "Bluespace instability detected. Delivery impossible."

	var/message
	/// Number of beacons printed. Used to determine beacon names.
	var/printed_beacons = 0
	var/list/meme_pack_data
	/// The currently linked supplypod beacon
	var/obj/item/supplypod_beacon/beacon
	/// Area instance that cargo pods are sent to
	var/area/landingzone
	/// The pod type used to deliver orders
	var/podType = /obj/structure/closet/supplypod
	/// Cooldown to prevent printing supplypod beacon spam
	var/cooldown = 0
	/// Is the console in beacon mode? exists to let beacon know when a pod may come in
	var/usingBeacon = FALSE
	/// The account to charge purchases to, defaults to the cargo budget
	var/datum/bank_account/charge_account

/obj/machinery/computer/cargo/express/Initialize()
	. = ..()
	packin_up()

/obj/machinery/computer/cargo/express/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	reconnect(port)

/obj/machinery/computer/cargo/express/proc/reconnect(obj/docking_port/mobile/port)
	if(!port)
		var/area/ship/current_area = get_area(src)
		if(!istype(current_area))
			return
		port = current_area.mobile_port
	if(!port)
		return
	charge_account = port.current_ship?.ship_account
	landingzone = locate(/area/ship/cargo) in port.shuttle_areas

/obj/machinery/computer/cargo/express/Destroy()
	if(beacon)
		beacon.unlink_console()
	return ..()

/obj/machinery/computer/cargo/express/attackby(obj/item/W, mob/living/user, params)
	var/value = 0
	if(istype(W, /obj/item/stack/spacecash))
		var/obj/item/stack/spacecash/C = W
		value = C.value * C.amount
	else if(istype(W, /obj/item/holochip))
		var/obj/item/holochip/H = W
		value = H.credits
	if(value)
		charge_account.adjust_money(value)
		to_chat(user, "<span class='notice'>You deposit [W]. The Vessel Budget is now [charge_account.account_balance] cr.</span>")
		qdel(W)
		return TRUE
	if(istype(W, /obj/item/disk/cargo/bluespace_pod))
		podType = /obj/structure/closet/supplypod/bluespacepod//doesnt effect circuit board, making reversal possible
		to_chat(user, "<span class='notice'>You insert the disk into [src], allowing for advanced supply delivery vehicles.</span>")
		qdel(W)
		return TRUE
	else if(istype(W, /obj/item/supplypod_beacon))
		var/obj/item/supplypod_beacon/sb = W
		if (sb.express_console != src)
			sb.link_console(src, user)
			return TRUE
		else
			to_chat(user, "<span class='alert'>[src] is already linked to [sb].</span>")
	..()

/obj/machinery/computer/cargo/express/proc/packin_up() // oh shit, I'm sorry
	meme_pack_data = list() // sorry for what?
	for(var/pack in SSshuttle.supply_packs) // our quartermaster taught us not to be ashamed of our supply packs
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]  // specially since they're such a good price and all
		if(!meme_pack_data[P.group]) // yeah, I see that, your quartermaster gave you good advice
			meme_pack_data[P.group] = list( // it gets cheaper when I return it
				"name" = P.group, // mmhm
				"packs" = list()  // sometimes, I return it so much, I rip the manifest
			) // see, my quartermaster taught me a few things too
		if((P.hidden) || (P.special)) // like, how not to rip the manifest
			continue// by using someone else's crate
		meme_pack_data[P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.cost,
			"id" = pack,
			"desc" = P.desc || P.name // If there is a description, use it. Otherwise use the pack's name.
		))

/obj/machinery/computer/cargo/express/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OutpostComms", name)
		ui.open()
		if(!charge_account)
			reconnect()

/obj/machinery/computer/cargo/express/ui_data(mob/user)
	var/canBeacon = beacon && (isturf(beacon.loc) || ismob(beacon.loc))//is the beacon in a valid location?
	var/list/data = list()

	// not a big fan of get_containing_shuttle
	var/obj/docking_port/mobile/D = SSshuttle.get_containing_shuttle(src)
	var/datum/overmap/ship/controlled/ship = D.current_ship
	var/outpost_docked = istype(ship.docked_to, /datum/overmap/outpost)

	data["onShip"] = !isnull(ship)
	data["numMissions"] = ship ? LAZYLEN(ship.missions) : 0
	data["maxMissions"] = ship ? ship.max_missions : 0
	data["outpostDocked"] = outpost_docked
	data["points"] = charge_account ? charge_account.account_balance : 0
	data["siliconUser"] = user.has_unlimited_silicon_privilege
	data["beaconzone"] = beacon ? get_area(beacon) : ""//where is the beacon located? outputs in the tgui
	data["usingBeacon"] = usingBeacon //is the mode set to deliver to the beacon or the cargobay?
	data["canBeacon"] = !usingBeacon || canBeacon //is the mode set to beacon delivery, and is the beacon in a valid location?
	data["canBuyBeacon"] = charge_account ? (cooldown <= 0 && charge_account.account_balance >= BEACON_COST) : FALSE
	data["beaconError"] = usingBeacon && !canBeacon ? "(BEACON ERROR)" : ""//changes button text to include an error alert if necessary
	data["hasBeacon"] = beacon != null//is there a linked beacon?
	data["beaconName"] = beacon ? beacon.name : "No Beacon Found"
	data["printMsg"] = cooldown > 0 ? "Print Beacon for [BEACON_COST] credits ([cooldown])" : "Print Beacon for [BEACON_COST] credits"//buttontext for printing beacons
	data["supplies"] = list()
	message = "Sales are near-instantaneous - please choose carefully."
	if(SSshuttle.supplyBlocked)
		message = blockade_warning
	if(usingBeacon && !beacon)
		message = "BEACON ERROR: BEACON MISSING"//beacon was destroyed
	else if (usingBeacon && !canBeacon)
		message = "BEACON ERROR: MUST BE EXPOSED"//beacon's loc/user's loc must be a turf
	data["message"] = message
	if(!meme_pack_data)
		packin_up()
		stack_trace("You didn't give the cargo tech good advice, and he ripped the manifest. As a result, there was no pack data for [src]")
	data["supplies"] = meme_pack_data
	if (cooldown > 0)//cooldown used for printing beacons
		cooldown--

	data["shipMissions"] = list()
	data["outpostMissions"] = list()

	if(ship)
		for(var/datum/mission/M as anything in ship.missions)
			data["shipMissions"] += list(M.get_tgui_info())
	if(outpost_docked)
		var/datum/overmap/outpost/out = ship.docked_to
		for(var/datum/mission/M as anything in out.missions)
			data["outpostMissions"] += list(M.get_tgui_info())

	return data

/obj/machinery/computer/cargo/express/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	switch(action)
		if("withdrawCash")
			var/val = text2num(params["value"])
			// no giving yourself money
			if(!charge_account || !val || val <= 0)
				return
			if(charge_account.adjust_money(-val))
				var/obj/item/holochip/cash_chip = new /obj/item/holochip(drop_location(), val)
				if(ishuman(usr))
					var/mob/living/carbon/human/user = usr
					user.put_in_hands(cash_chip)
				playsound(src, 'sound/machines/twobeep_high.ogg', 50, TRUE)
				src.visible_message("<span class='notice'>[src] dispenses a holochip.</span>")
			return TRUE

		if("LZCargo")
			usingBeacon = FALSE
			if (beacon)
				beacon.update_status(SP_UNREADY) //ready light on beacon will turn off
		if("LZBeacon")
			usingBeacon = TRUE
			if (beacon)
				beacon.update_status(SP_READY) //turns on the beacon's ready light
		if("printBeacon")
			if(charge_account?.adjust_money(-BEACON_COST))
				cooldown = 10//a ~ten second cooldown for printing beacons to prevent spam
				var/obj/item/supplypod_beacon/C = new /obj/item/supplypod_beacon(drop_location())
				C.link_console(src, usr)//rather than in beacon's Initialize(), we can assign the computer to the beacon by reusing this proc)
				printed_beacons++//printed_beacons starts at 0, so the first one out will be called beacon # 1
				beacon.name = "Supply Pod Beacon #[printed_beacons]"

		if("add")//Generate Supply Order first
			var/area/ship/current_area = get_area(src)
			if(!istype(current_area))
				return
			// you have to be at an outpost to trade
			if(!istype(current_area.mobile_port.current_ship.docked_to, /datum/overmap/outpost))
				return
			var/id = text2path(params["id"])
			var/datum/supply_pack/pack = SSshuttle.supply_packs[id]
			if(!istype(pack))
				return
			var/name = "*None Provided*"
			var/rank = "*None Provided*"
			var/ckey = usr.ckey
			if(ishuman(usr))
				var/mob/living/carbon/human/H = usr
				name = H.get_authentification_name()
				rank = H.get_assignment(hand_first = TRUE)
			else if(issilicon(usr))
				name = usr.real_name
				rank = "Silicon"
			var/reason = ""
			var/list/empty_turfs
			var/datum/supply_order/SO = new(pack, name, rank, ckey, reason)
			var/points_to_check
			if(charge_account)
				points_to_check = charge_account.account_balance
			if(SO.pack.cost <= points_to_check)
				var/LZ
				if (istype(beacon) && usingBeacon)//prioritize beacons over landing in cargobay
					LZ = get_turf(beacon)
					beacon.update_status(SP_LAUNCH)
				else if (!usingBeacon)//find a suitable supplypod landing zone in cargobay
					if(!landingzone)
						reconnect()
					if (!landingzone)
						WARNING("[src] couldnt find a Ship/Cargo (aka cargobay) area on a ship, and as such it has set the supplypod landingzone to the area it resides in.")
						landingzone = get_area(src)
					for(var/turf/open/floor/T in landingzone.contents)//uses default landing zone
						if(T.is_blocked_turf())
							continue
						LAZYADD(empty_turfs, T)
						CHECK_TICK
					if(empty_turfs && empty_turfs.len)
						LZ = pick(empty_turfs)
				if (SO.pack.cost <= points_to_check && LZ)//we need to call the cost check again because of the CHECK_TICK call
					charge_account.adjust_money(-SO.pack.cost)
					new /obj/effect/DPtarget(LZ, podType, SO)
					. = TRUE
					update_icon()

		if("mission-act")
			var/datum/mission/mission = locate(params["ref"])
			var/obj/docking_port/mobile/D = SSshuttle.get_containing_shuttle(src)
			var/datum/overmap/ship/controlled/ship = D.current_ship
			var/datum/overmap/outpost/outpost = ship.docked_to
			if(!istype(outpost) || mission.source_outpost != outpost) // important to check these to prevent href fuckery
				return
			if(!mission.accepted)
				mission.accept(ship, loc)
				return TRUE
			else if(mission.servant == ship)
				if(mission.can_complete())
					mission.turn_in()
				else
					mission.give_up()
				return TRUE
