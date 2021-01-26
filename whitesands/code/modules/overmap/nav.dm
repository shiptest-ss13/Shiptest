//Custom shuttle docker locations
/obj/machinery/computer/camera_advanced/shuttle_docker/nav
	name = "shuttle docking and landing computer"
	icon_screen = "holocontrol"
	icon_keyboard = "tech_key"
	lock_override = NONE
	jumpto_ports = list("whiteship_home" = 1)
	designate_time = 50
	circuit = /obj/item/circuitboard/computer/shuttle/docker
	var/obj/structure/overmap/ship/simulated/current_ship
	var/obj/structure/overmap/level/current_target

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/Initialize(mapload)
	. = ..()
	LAZYADD(SSovermap.navs, src)
	if(!mapload)
		link_shuttle()

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/Destroy()
	. = ..()
	LAZYREMOVE(SSovermap.navs, src)

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/proc/link_shuttle(new_id)
	if(new_id)
		shuttleId = new_id
	if(!shuttleId)
		var/obj/docking_port/port = SSshuttle.get_containing_shuttle(src)
		if(!port)
			return
		shuttleId = port.id
	current_ship = SSovermap.get_overmap_object_by_id(shuttleId)

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/give_eye_control(mob/user)
	. = ..()
	user.update_parallax_contents()

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/remove_eye_control(mob/living/user)
	. = ..()
	user.update_parallax_contents()

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/placeLandingSpot()
	if(!shuttleId)
		return	//Only way this would happen is if someone else delinks the console while in use somehow
	if(!current_ship.is_still())
		to_chat(current_user, "<span class='warning'>You can't try to land while moving!</span>")
		return
	if(!(current_target in current_ship.close_overmap_objects))
		return
	..()

/obj/machinery/computer/camera_advanced/shuttle_docker/nav/attack_hand(mob/user)
	if(!shuttleId || !current_ship)
		to_chat(user, "<span class='warning'>No shuttle linked!</span>")
		return
	if(!isturf(current_ship.loc))
		to_chat(user, "<span class='warning'>Cannot select docking position while already docked.</span>")
		return
	current_target = locate() in current_ship.close_overmap_objects
	if(!current_target)
		to_chat(user, "<span class='warning'>Not near any celestial object or station!</span>")
		return
	if(!current_target.custom_docking || !current_target.linked_levels)
		to_chat(user, "<span class='warning'>There's too much interference to dock anywhere but the designated docking port!</span>")
		return
	if(!current_ship.is_still())
		to_chat(user, "<span class='warning'>You can't try to land while moving!</span>")
		return
	view_range = max(current_ship.shuttle.height, current_ship.shuttle.width, 0)
	jumpto_ports = list("[shuttleId]_[current_target.id]", "[PRIMARY_OVERMAP_DOCK_PREFIX]_[current_target.id]")
	shuttlePortId = "[shuttleId]_[current_target.id]"
	shuttlePortName = "[current_ship] [current_target.id] dock"
	z_lock = LAZYCOPY(current_target.linked_levels)
	my_port = SSshuttle.getDock(shuttlePortId)
	..()
	if(eyeobj)
		eyeobj.setLoc(my_port ? get_turf(my_port) : locate(eyeobj.x, eyeobj.y, pick(z_lock)))
