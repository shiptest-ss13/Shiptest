/mob/living/simple_animal/drone
	var/underdoor = FALSE


/mob/living/simple_animal/drone/Move(newloc, direct)
	..(newloc,direct)
	if(underdoor)
		underdoor = FALSE
		if(layer == UNDERDOOR)//if this is false, then we must have had our layer changed by something else. We wont do anymore checks for this move proc
			for(var/obj/machinery/door/airlock/A in loc)
				if(A.has_hatch)
					underdoor = TRUE
					break

			if(!underdoor)
				addtimer(CALLBACK(src, .proc/initial_layer), 3)

/mob/living/simple_animal/drone/proc/initial_layer()
	layer = initial(layer)

/mob/living/simple_animal/drone/proc/under_door()
	//This function puts a drone on a layer that makes it draw under doors, then periodically checks if its still standing on a door
	if (layer > UNDERDOOR)//Don't toggle it if we're hiding
		layer = UNDERDOOR
		underdoor = TRUE
