/obj/machinery/foam_dispenser
	name = "smart foam dispenser"
	desc = "An automatic dispenser for hull-sealing foam."
	icon = 'icons/obj/device.dmi'
	icon_state = "ai-slipper0"
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	plane = FLOOR_PLANE
	max_integrity = 200
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)

	var/uses = 10
	var/cooldown = 0
	var/cooldown_time = 100
	req_access = list(ACCESS_AI_UPLOAD)

/obj/machinery/foam_dispenser/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It has <b>[uses]</b> uses of foam remaining.</span>"

/obj/machinery/foam_dispenser/update_icon_state()
	if(machine_stat & BROKEN)
		return
	if((machine_stat & NOPOWER) || cooldown_time > world.time || !uses)
		icon_state = "ai-slipper0"
	else
		icon_state = "ai-slipper1"

/obj/machinery/foam_dispenser/interact(mob/user)
	if(!allowed(user))
		to_chat(user, "<span class='danger'>Access denied.</span>")
		return
	if(!uses)
		to_chat(user, "<span class='warning'>[src] is out of foam and cannot be activated!</span>")
		return
	if(cooldown_time > world.time)
		to_chat(user, "<span class='warning'>[src] cannot be activated for <b>[DisplayTimeText(world.time - cooldown_time)]</b>!</span>")
		return
	new /obj/effect/particle_effect/foam/metal/smart(loc)
	uses--
	to_chat(user, "<span class='notice'>You activate [src]. It now has <b>[uses]</b> uses of foam remaining.</span>")
	cooldown = world.time + cooldown_time
	power_change()
	addtimer(CALLBACK(src, .proc/power_change), cooldown_time)

/obj/machinery/foam_dispenser/Initialize(mapload)
	START_PROCESSING(SSmachines, src)
	. = ..()

/obj/machinery/foam_dispenser/process()
	var/turf/location = get_turf(src)
	var/datum/gas_mixture/environment = location.return_air()
	var/pressure = environment.return_pressure()
	if(!uses)
		return
	if(cooldown_time > world.time)
		return
	if((pressure <= 20) || (pressure >= 550))
		dispense()

/obj/machinery/foam_dispenser/proc/dispense()
	new /obj/effect/particle_effect/foam/metal/smart(loc)
	uses--
	to_chat("<span class='warning'>The [src] activates. It now has <b>[uses]</b> uses of foam remaining.</span>")
	cooldown = world.time + cooldown_time
	power_change()
	addtimer(CALLBACK(src, .proc/power_change), cooldown_time)
	STOP_PROCESSING(SSmachines, src)
