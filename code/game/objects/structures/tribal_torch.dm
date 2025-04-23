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
		user.visible_message(span_notice("[user] snuffs [src] out."), span_notice("You snuff [src] out."))
		burning = FALSE
		icon_state = "torch_unlit"
		set_light(0)
		update_appearance()
		return
	if(!burning)
		user.visible_message(span_notice("[user] starts to pull [src] free from the ground...."), span_notice("You start to pull [src] free from the ground..."))
		if(do_after(user, 20, show_progress = TRUE, target = src))
			to_chat(user, span_notice("You pull [src] free from the ground."))
			var/torch = new /obj/item/candle/tribal_torch
			user.put_in_hands(torch)
			qdel(src)
			return

/obj/structure/destructible/tribal_torch/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature())
		StartBurning()
		update_appearance()
		user.visible_message(span_notice("[user] lights [src] with [W]."), span_notice("You light [src] with [W]."))
		return

/obj/structure/destructible/tribal_torch/proc/StartBurning()
	if(!burning)
		burning = TRUE
		icon_state = "torch_lit"
		set_light(7)
		update_appearance()
		return

/obj/structure/destructible/tribal_torch/fire_act(exposed_temperature, exposed_volume)
	StartBurning()

/obj/structure/destructible/tribal_torch/lit/Initialize()
	. = ..()
	StartBurning()
