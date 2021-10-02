/obj/structure/destructible/tribal_torch
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/candle.dmi'
	icon_state = "torch_unlit"
	light_color = LIGHT_COLOR_FIRE
	light_power = 1
	light_range = 0
	break_sound = 'sound/hallucinations/veryfar_noise.ogg'
	debris = list(/obj/item/candle/tribal_torch = 1)
	var/burning = FALSE

/obj/structure/destructible/tribal_torch/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(burning)
		user.visible_message("<span class='notice'>[user] snuffs [src] out.</span>", "<span class='notice'>You snuff [src] out.</span>")
		burning = FALSE
		icon_state = "torch_unlit"
		set_light(0)
		update_icon()
		return
	if(!burning)
		user.visible_message("<span class='notice'>[user] starts to pull [src] free from the ground....</span>", "<span class='notice'>You start to pull [src] free from the ground...</span>")
		if(do_after(user, 20, progress = 1, target = src))
			to_chat("<span class='notice'>You pull [src] free from the ground.</span>")
			var/torch = new /obj/item/candle/tribal_torch
			user.put_in_hands(torch)
			qdel(src)
			return

/obj/structure/destructible/tribal_torch/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature())
		StartBurning()
		update_icon()
		user.visible_message("<span class='notice'>[user] lights [src] with [W].</span>", "<span class='notice'>You light [src] with [W].</span>")
		return

/obj/structure/destructible/tribal_torch/proc/StartBurning()
	if(!burning)
		burning = TRUE
		icon_state = "torch_lit"
		set_light(7)
		update_icon()
		return

/obj/structure/destructible/tribal_torch/fire_act(exposed_temperature, exposed_volume)
	StartBurning()
