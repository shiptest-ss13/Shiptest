
/obj/structure/standing_torch
	name = "standing torch"
	desc = "A free-standing torch lighting the area up."
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tribal"
	light_color = LIGHT_COLOR_FIRE
	light_power = 1
	light_range = 0
	//Has this been ignited?
	var/burning = FALSE

/obj/structure/standing_torch/Initialize()
	. = ..()

/obj/structure/standing_torch/attack_hand(mob/user)
	. = ..()
	if(.)
		return

	if(burning)
		if(snuff_flame())
			user.visible_message(span_notice("[user] snuffs [src] out."), span_notice("You snuff [src] out."))
		return

	if(!burning)
		user.visible_message(span_notice("[user] starts to pull [src] free from the ground...."), span_notice("You start to pull [src] free from the ground..."))
		if(do_after(user, 20, show_progress = TRUE, target = src))
			to_chat(user, span_notice("You pull [src] free from the ground."))
			var/torch = new /obj/item/flashlight/flare/torch/standing
			user.put_in_hands(torch)
			qdel(src)
			return

/obj/structure/standing_torch/attackby(obj/item/olympic_torch, mob/user, params)
	if(olympic_torch.get_temperature() && user.a_intent != INTENT_HARM)
		if(burning)
			to_chat(user, span_notice("[src] has already been lit!"))
			return FALSE
		StartBurning()
		user.visible_message(span_notice("[user] lights [src] with [olympic_torch]."), span_notice("You light [src] with [olympic_torch]."))
		return TRUE
	return ..()

/obj/structure/standing_torch/proc/snuff_flame()
	burning = FALSE
	icon_state = "tribal"
	set_light(0)
	update_appearance()
	return

/obj/structure/standing_torch/proc/StartBurning()
	burning = TRUE
	icon_state = "tribal-on"
	set_light(7)
	update_appearance()
	return

/obj/structure/standing_torch/fire_act(exposed_temperature, exposed_volume)
	StartBurning()

/obj/structure/standing_torch/extinguish()
	. = ..()
	snuff_flame()

/obj/structure/standing_torch/lit/Initialize()
	. = ..()
	StartBurning()

//one day (read, has sprites): torch holder that takes the torch and absorbs its lighting characteristics
/*
/obj/structure/torch_holder
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/structure/torch_holder.dmi'
	icon_state = "holder_empty"
	base_icon_state = "holder"
	//the torch
	var/obj/item/flashlight/flare/torch/held_torch

/obj/structure/torch_holder/init
	register a signal that says the torch is done burning
	so that we can update the icon.

	we also want one for torch ignition / lighting


/obj/structure/torch_holder/attack_hand(mob/user)
	. = ..()
	if(held_torch)
		visible_message(user, span_notice("[user] removes [held_torch] from [src]", span_notice("You remove [held_torch] from [src]")))
		remove_torch()
		user.put_in_hand(held_torch) //or however the proc goes this is half psuedocode anwyays
		held_torch = null
		return TRUE
	return

/obj/structure/torch_holder/proc/add_torch(torch)
	held_torch = torch
	torch.forcemove(src)
	update_torch_light

/obj/structure/torch_holder/proc/update_torch_light
	light_range = held_torch.light_range
	light_power = held_torch.light_power
	light_colour = held_torch.light_colour

/obj/structure/torch_holder/proc/remove_torch(mob/user)
	light_range = 0
	light_power = 0
	STOP_PROCESSING()

/obj/structure/torch_holder/update_appearance()
	if(held_torch && torch burning)
		base_icon_state + torch + lit
	else if held torch
		base icon + torch
	else
		base icon
	return ..()

/obj/structure/torch_holder/attackby(obj/item/olympic_torch, mob/user, params)
	if(istype(held_torch, olypmic_torch))
		if(held_torch)
			to_chat(user, span_warning("There is already a torch in [src]!"))
			return false
		add_torch(torch)
	else if (hot as fuck && held_torch)
		try_ignite_torch()
		return false

	return ..()

/obj/structure/torch_holder/fire_act()
	try_ignite_torch()

/obj/structure/torch_holder/extinguish()
	snuff_torch()

whatever you get the idea. if you get a sprite ping me and I'll implement it.
love erika
*/
