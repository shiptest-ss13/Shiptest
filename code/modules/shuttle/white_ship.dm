/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship
	name = "White Ship Navigation Computer"
	desc = "Used to designate a precise transit location for the White Ship."
	shuttleId = "whiteship"
	lock_override = NONE
	shuttlePortId = "whiteship_custom"
	jumpto_ports = list("whiteship_space" = 1, "whiteship_home" = 1, "whiteship_z4" = 1)
	view_range = 10
	x_offset = -6
	y_offset = -10
	designate_time = 100

/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship/pod
	name = "Salvage Pod Navigation Computer"
	desc = "Used to designate a precise transit location for the Salvage Pod."
	shuttleId = "whiteship_pod"
	shuttlePortId = "whiteship_pod_custom"
	jumpto_ports = list("whiteship_pod_home" = 1)
	view_range = 0
	x_offset = -2
	y_offset = 0
	designate_time = 0

/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship/Initialize()
	. = ..()
	GLOB.jam_on_wardec += src

/obj/machinery/computer/camera_advanced/shuttle_docker/whiteship/Destroy()
	GLOB.jam_on_wardec -= src
	return ..()

/obj/effect/spawner/lootdrop/whiteship_cere_ripley
	name = "25% mech 75% wreckage ripley spawner"
	loot = list(/obj/mecha/working/ripley/mining = 1,
				/obj/structure/mecha_wreckage/ripley = 5)
	lootdoubles = FALSE
