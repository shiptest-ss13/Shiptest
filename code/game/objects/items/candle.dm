/obj/item/candle
	name = "red candle"
	desc = "In Greek myth, Prometheus stole fire from the Gods and gave it to \
		humankind. The jewelry he kept for himself."
	icon = 'icons/obj/candle.dmi'
	icon_state = "candle1"
	item_state = "candle1"
	w_class = WEIGHT_CLASS_TINY
	light_color = LIGHT_COLOR_FIRE
	light_power = 0.8
	light_range = 2
	light_system = MOVABLE_LIGHT
	light_on = FALSE
	heat = 1000
	/// How many seconds it burns for
	var/wax = 2000
	var/lit = FALSE
	var/infinite = FALSE
	var/start_lit = FALSE

/obj/item/candle/Initialize()
	. = ..()
	if(start_lit)
		light()

/obj/item/candle/update_icon_state()
	icon_state = "candle[(wax > 800) ? ((wax > 1500) ? 1 : 2) : 3][lit ? "_lit" : ""]"
	return ..()

/obj/item/candle/attackby(obj/item/W, mob/user, params)
	var/msg = W.ignition_effect(src, user)
	if(msg)
		light(msg)
	else
		return ..()

/obj/item/candle/fire_act(exposed_temperature, exposed_volume)
	if(!lit)
		light() //honk
	return ..()

/obj/item/candle/get_temperature()
	return lit * heat

/obj/item/candle/proc/light(show_message)
	if(lit)
		return
	lit = TRUE
	if(show_message)
		usr.visible_message(show_message)
	set_light_on(TRUE)
	if(!infinite)
		START_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/candle/proc/put_out_candle()
	if(!lit)
		return
	lit = FALSE
	update_appearance()
	set_light_on(FALSE)
	return TRUE

/obj/item/candle/extinguish()
	put_out_candle()
	return ..()

/obj/item/candle/process(seconds_per_tick)
	if(!lit)
		return PROCESS_KILL
	if(!infinite)
		wax -= seconds_per_tick
	if(wax <= 0)
		new /obj/item/trash/candle(loc)
		qdel(src)
	update_appearance()
	open_flame()

/obj/item/candle/attack_self(mob/user)
	if(put_out_candle())
		user.visible_message(span_notice("[user] snuffs [src]."))

/obj/item/candle/infinite
	infinite = TRUE
	start_lit = TRUE

/obj/item/candle/tribal_torch
	name = "tribal torch"
	desc = "A standing torch, used to provide light in dark environments."
	icon = 'icons/obj/candle.dmi'
	icon_state = "torch_unlit"
	item_state = "torch"
	w_class = WEIGHT_CLASS_BULKY
	light_range = 7
	infinite = TRUE
	heat = 2000

/obj/item/candle/tribal_torch/attack_self(mob/user)
	if(!src.lit)
		to_chat(user, span_notice("You start pushing [src] into the ground..."))
		if (do_after(user, 20, target=src))
			qdel(src)
			new /obj/structure/destructible/tribal_torch(get_turf(user))
			user.visible_message(span_notice("[user] plants \the [src] firmly in the ground."), span_notice("You plant \the [src] firmly in the ground."))
			return
	return ..()


/obj/item/candle/tribal_torch/update_appearance()
	icon_state = "torch[lit ? "_lit" : "_unlit"]"
	item_state = "torch[lit ? "-on" : ""]"
	return ..()
