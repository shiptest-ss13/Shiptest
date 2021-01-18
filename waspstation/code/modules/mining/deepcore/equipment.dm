/obj/item/deepcorecapsule
	name = "deepcore drill deployment capsule"
	desc = "A deepcore mining drill compressed into an easy-to-deploy capsule."
	icon = 'waspstation/icons/obj/mining.dmi'
	icon_state = "capsule_dcm"
	w_class = WEIGHT_CLASS_TINY
	var/to_deploy = /obj/machinery/deepcore/drill

/obj/item/deepcorecapsule/attack_self()
	loc.visible_message("<span class='warning'>\The [src] begins to shake. Stand back!</span>")
	addtimer(CALLBACK(src, .proc/Deploy), 50)

/obj/item/deepcorecapsule/proc/Deploy()
	if(QDELETED(src) || !to_deploy)
		return
	playsound(src, 'sound/effects/phasein.ogg', 100, TRUE)
	var/turf/deploy_location = get_turf(src)
	new to_deploy(deploy_location)
	new /obj/effect/particle_effect/smoke(deploy_location)
	qdel(src)
