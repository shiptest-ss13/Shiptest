/datum/supply_pack/tcomms
	category = "Telecommunications"
	crate_type = /obj/structure/closet/crate/secure/engineering
	crate_name = "telecommunication equipment"
	faction = /datum/faction/nt
	faction_discount = 30

/datum/supply_pack/tcomms/bowman
	name = "Bowman Headset Crate"
	desc = "One bowman radio headset. Protects the ears from loud noises."
	cost = 100
	contains = list(/obj/item/radio/headset/alt)

/datum/supply_pack/tcomms/pda
	name = "Personal Data Assistant Crate"
	desc = "A Nanotrasen manufactured Personal Data Assistant - PDA for short. Requires an operating network to function"
	cost = 100
	contains = list(/obj/item/pda)
	faction_discount = 80

/datum/supply_pack/tcomms/quickstart
	name = "Telecommunications Quick-Start Pack"
	desc = "The bare minimum in creating a telecommunications set-up. Contains a broadcaster, bus, processor, and receiver, as well as the constituent parts. Assembly instructions not included."
	cost = 6000
	contains = list(
		/obj/item/circuitboard/machine/telecomms/bus,
		/obj/item/circuitboard/machine/telecomms/broadcaster,
		/obj/item/circuitboard/machine/telecomms/processor,
		/obj/item/circuitboard/machine/telecomms/receiver,
		/obj/item/stock_parts/subspace/filter = 4,
		/obj/item/stock_parts/subspace/treatment = 2,
		/obj/item/stock_parts/subspace/analyzer = 1,
		/obj/item/stock_parts/subspace/amplifier = 1,
		/obj/item/stock_parts/subspace/ansible = 1,
		/obj/item/stock_parts/subspace/crystal = 1
	)
	crate_name = "Telecommunications Quick-Start Pack"

/datum/supply_pack/tcomms/broadcaster
	name = "Broadcaster Crate"
	desc = "An Nanotrasen manufactured subspace broadcaster. Broadcasts recieved and processed radio signals as dense packets of information through subspace."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/broadcaster,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/crystal = 1
	)


/datum/supply_pack/tcomms/bus
	name = "Bus Mainframe Crate"
	desc = "An Nanotrasen manufactured bus mainframe. Moves signals to the requisite telecommunications machine once linked."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/bus,
		/obj/item/stock_parts/subspace/filter = 1,
	)


/datum/supply_pack/tcomms/processor
	name = "Signal Processor Crate"
	desc = "An Nanotrasen manufactured Signal Processor. Decompresses and decodes subspace radio signals."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/processor,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/treatment = 2,
		/obj/item/stock_parts/subspace/analyzer = 1,
		/obj/item/stock_parts/subspace/amplifier = 1
	)


/datum/supply_pack/tcomms/receiver
	name = "Receiver Crate"
	desc = "An Nanotrasen manufactured subspace receiver. Catches radio signals being broadcast through subspace."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/receiver,
		/obj/item/stock_parts/subspace/filter = 1,
		/obj/item/stock_parts/subspace/treatment = 2,
		/obj/item/stock_parts/subspace/analyzer = 1,
		/obj/item/stock_parts/subspace/amplifier = 1
	)

/datum/supply_pack/tcomms/server
	name = "Telecommunication Server Crate"
	desc = "An Nanotrasen manufactured telecommunications server. Logs radio signals passed through it for future reference."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/server,
		/obj/item/stock_parts/subspace/filter = 1,
	)

/datum/supply_pack/tcomms/pda_server
	name = "Messaging Server Crate"
	desc = "An Nanotrasen manufactured PDA Server. Translates radio bursts from PDA messaging into a subspace-friendly packet."
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/message_server,
		/obj/item/stock_parts/subspace/filter = 3,
	)

/datum/supply_pack/tcomms/relay
	name = "Subspace Relay Crate"
	desc = "An Nanotrasen manufactured Subspace Relay. Creates paths through exotic subspace geometry to broadcast signals to other known relays. "
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/relay,
		/obj/item/stock_parts/subspace/filter = 2,
		/obj/item/stock_parts/subspace/transmitter = 4
	)
	faction_locked = TRUE

/datum/supply_pack/tcomms/hub
	name = "Telecommunications Hub Crate"
	desc = "An Nanotrasen manufactured Telecommunications Hub. The centerpiece of any functional telecommunications set up. Routes all data fed to it. "
	cost = 1500
	contains = list(
		/obj/item/circuitboard/machine/telecomms/hub,
		/obj/item/stock_parts/subspace/filter = 2,
		/obj/item/stock_parts/subspace/transmitter = 4
	)
	faction_locked = TRUE

/datum/supply_pack/tcomms/server_monitor
	name = "Telecommunications Monitor Crate"
	desc = "A server monitoring toolkit, based on old Solarian tools known as the \"Parcel Tracer\", \"Wired Fish\" and \"En Mappe\". Fits in any computer."
	cost = 1000
	contains = list(
		/obj/item/circuitboard/computer/comm_monitor
	)

/datum/supply_pack/tcomms/pda_monitor
	name = "PDA Server Monitor Crate"
	desc = "A PDA packet inspection system. Great for verifying suspicions that your Second In Command is scheming. Or that the deckhands are kissing."
	cost = 1000
	contains = list(
		/obj/item/circuitboard/computer/message_monitor,
		/obj/item/paper/monitor_pass
	)

/datum/supply_pack/tcomms/log_browser
	name = "Telecommunications Log Monitor Crate"
	desc = "A radio packet inspection system. Accesses logs stored on radio servers and prints them in a sapient-readable format."
	cost = 1000
	contains = list(
		/obj/item/circuitboard/computer/message_monitor
	)
