//caravan ambush

/obj/item/wrench/caravan
	color = "#ff0000"
	desc = "A prototype of a new wrench design, allegedly the red color scheme makes it go faster."
	name = "experimental wrench"
	toolspeed = 0.3

/obj/item/screwdriver/caravan
	color = "#ff0000"
	desc = "A prototype of a new screwdriver design, allegedly the red color scheme makes it go faster."
	name = "experimental screwdriver"
	toolspeed = 0.3
	random_color = FALSE

/obj/item/wirecutters/caravan
	color = "#ff0000"
	desc = "A prototype of a new wirecutter design, allegedly the red color scheme makes it go faster."
	name = "experimental wirecutters"
	toolspeed = 0.3
	random_color = FALSE

/obj/item/crowbar/red/caravan
	color = "#ff0000"
	desc = "A prototype of a new crowbar design, allegedly the red color scheme makes it go faster."
	name = "experimental crowbar"
	toolspeed = 0.3

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/Initialize()
	. = ..()
	GLOB.jam_on_wardec += src

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/Destroy()
	GLOB.jam_on_wardec -= src
	return ..()

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/trade1
	name = "Small Freighter Navigation Computer"
	desc = "Used to designate a precise transit location for the Small Freighter."
	shuttleId = "caravantrade1"
	lock_override = NONE
	shuttlePortId = "caravantrade1_custom"
	jumpto_ports = list("whiteship_away" = 1, "whiteship_home" = 1, "whiteship_z4" = 1, "caravantrade1_ambush" = 1)
	view_range = 6.5
	x_offset = -5
	y_offset = -5
	designate_time = 100

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/pirate
	name = "Pirate Cutter Navigation Computer"
	desc = "Used to designate a precise transit location for the Pirate Cutter."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "caravanpirate"
	lock_override = NONE
	shuttlePortId = "caravanpirate_custom"
	jumpto_ports = list("caravanpirate_ambush" = 1)
	view_range = 6.5
	x_offset = 3
	y_offset = -6

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/syndicate1
	name = "Syndicate Fighter Navigation Computer"
	desc = "Used to designate a precise transit location for the Syndicate Fighter."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "caravansyndicate1"
	lock_override = NONE
	shuttlePortId = "caravansyndicate1_custom"
	jumpto_ports = list("caravansyndicate1_ambush" = 1, "caravansyndicate1_listeningpost" = 1)
	view_range = 0
	x_offset = 2
	y_offset = 0

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/syndicate2
	name = "Syndicate Fighter Navigation Computer"
	desc = "Used to designate a precise transit location for the Syndicate Fighter."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "caravansyndicate2"
	lock_override = NONE
	shuttlePortId = "caravansyndicate2_custom"
	jumpto_ports = list("caravansyndicate2_ambush" = 1, "caravansyndicate1_listeningpost" = 1)
	view_range = 0
	x_offset = 0
	y_offset = 2

/obj/machinery/computer/camera_advanced/shuttle_docker/caravan/syndicate3
	name = "Syndicate Drop Ship Navigation Computer"
	desc = "Used to designate a precise transit location for the Syndicate Drop Ship."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "caravansyndicate3"
	lock_override = NONE
	shuttlePortId = "caravansyndicate3_custom"
	jumpto_ports = list("caravansyndicate3_ambush" = 1, "caravansyndicate3_listeningpost" = 1)
	view_range = 2.5
	x_offset = -1
	y_offset = -3
