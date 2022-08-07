#define MOB_LAYERSHIFT_MINIMUM BELOW_MOB_LAYER
#define MOB_LAYERSHIFT_MAXIMUM ABOVE_MOB_LAYER
#define MOB_LAYERSHIFT_STEPSIZE 0.1

/mob/living/Initialize(mapload)
	. = ..()
	if(!CONFIG_GET(flag/enable_mob_layershifting))
		remove_verb(src, /mob/living/verb/shift_layer_up)
		remove_verb(src, /mob/living/verb/shift_layer_down)
		remove_verb(src, /mob/living/verb/shift_layer_reset)

/**
 * Shift the visual layer of the mob by delta
 * MOB_LAYERSHIFT_MINIMUM < delta < MOB_LAYERSHIFT_MAXIMUM
 *
 * * delta - amount to shift by
 */
/mob/living/proc/shift_layer(delta)
	if(!CONFIG_GET(flag/enable_mob_layershifting))
		return
	if(!delta)
		return

	if(incapacitated(ignore_grab=TRUE))
		to_chat(src, "<span class='warning'>You can't do that right now!</span>")
		return

	var/new_layer = layer + delta

	if(new_layer < MOB_LAYERSHIFT_MINIMUM)
		to_chat(usr, "<span class='warning'>You can't shift your layer any lower.</span>")
		return
	else if(new_layer > MOB_LAYERSHIFT_MAXIMUM)
		to_chat(usr, "<span class='warning'>You can't shift your layer any higher.</span>")
		return
	layer = new_layer

/mob/living/verb/shift_layer_up()
	set name = "Layershift Up"
	set category = "IC"
	shift_layer(MOB_LAYERSHIFT_STEPSIZE)

/mob/living/verb/shift_layer_down()
	set name = "Layershift Down"
	set category = "IC"
	shift_layer(-MOB_LAYERSHIFT_STEPSIZE)

/mob/living/verb/shift_layer_reset()
	set name = "Layershift Reset"
	set category = "IC"
	if(incapacitated(ignore_grab=TRUE))
		to_chat(src, "<span class='warning'>You can't do that right now!</span>")
		return
	layer = initial(layer)

#undef MOB_LAYERSHIFT_MINIMUM
#undef MOB_LAYERSHIFT_MAXIMUM
#undef MOB_LAYERSHIFT_STEPSIZE
