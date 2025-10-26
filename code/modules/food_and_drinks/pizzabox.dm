/obj/item/bombcore/miniature/pizza
	name = "pizza bomb"
	desc = "Special delivery!"
	icon_state = "pizzabomb_inactive"
	item_state = "eshield0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'

/obj/item/pizzabox
	name = "pizza box"
	desc = "A box suited for pizzas."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "pizzabox"
	item_state = "pizzabox"
	base_icon_state = "pizzabox"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'

	var/open = FALSE
	var/can_open_on_fall = TRUE //if FALSE, this pizza box will never open if it falls from a stack
	var/boxtag = ""
	var/list/boxes = list()
	var/obj/item/food/pizza/pizza
	var/obj/item/bombcore/miniature/pizza/bomb
	var/bomb_active = FALSE // If the bomb is counting down.
	var/bomb_defused = TRUE // If the bomb is inert.
	var/bomb_timer = 1 // How long before blowing the bomb.
	var/const/BOMB_TIMER_MIN = 1
	var/const/BOMB_TIMER_MAX = 10

/obj/item/pizzabox/Initialize()
	. = ..()
	update_appearance()


/obj/item/pizzabox/Destroy()
	unprocess()
	return ..()

/obj/item/pizzabox/update_desc()
	// Description
	desc = initial(desc)
	. = ..()
	if(open)
		if(pizza)
			desc = "[desc] It appears to have \a [pizza] inside. Use your other hand to take it out."
		if(bomb)
			desc = "[desc] Wait, what?! It has \a [bomb] inside!"
			if(bomb_defused)
				desc = "[desc] The bomb seems inert. Use your other hand to activate it."
			if(bomb_active)
				desc = "[desc] It looks like it's about to go off!"
	else
		var/obj/item/pizzabox/box = boxes.len ? boxes[boxes.len] : src
		if(boxes.len)
			desc = "A pile of boxes suited for pizzas. There appear to be [boxes.len + 1] boxes in the pile."
		if(box.boxtag != "")
			desc = "[desc] The [boxes.len ? "top box" : "box"]'s tag reads: [box.boxtag]"

/obj/item/pizzabox/update_icon_state()
	if(!open)
		icon_state = "[base_icon_state]"
		return ..()

	icon_state = pizza ? "[base_icon_state]_messy" : "[base_icon_state]_open"
	bomb?.icon_state = "pizzabomb_[bomb_active ? "active" : "inactive"]"
	return ..()

/obj/item/pizzabox/update_overlays()
	. = ..()
	if(open)
		if(pizza)
			var/mutable_appearance/pizza_overlay = mutable_appearance(pizza.icon, pizza.icon_state)
			pizza_overlay.pixel_y = -3
			. += pizza_overlay
		if(bomb)
			var/mutable_appearance/bomb_overlay = mutable_appearance(bomb.icon, bomb.icon_state)
			bomb_overlay.pixel_y = 5
			. += bomb_overlay
		return

	var/box_offset = 0
	for(var/stacked_box in boxes)
		box_offset += 3
		var/obj/item/pizzabox/box = stacked_box
		var/mutable_appearance/box_overlay = mutable_appearance(box.icon, box.icon_state)
		box_overlay.pixel_y = box_offset
		. += box_overlay

	var/obj/item/pizzabox/box = LAZYLEN(boxes.len) ? boxes[boxes.len] : src
	if(box.boxtag != "")
		var/mutable_appearance/tag_overlay = mutable_appearance(icon, "pizzabox_tag")
		tag_overlay.pixel_y = box_offset
		. += tag_overlay

/obj/item/pizzabox/worn_overlays(isinhands, icon_file)
	. = ..()
	var/current_offset = 2
	if(isinhands)
		for(var/V in boxes) //add EXTRA BOX per box
			var/mutable_appearance/M = mutable_appearance(icon_file, item_state)
			M.pixel_y = current_offset
			current_offset += 2
			. += M

/obj/item/pizzabox/attack_self(mob/user)
	if(boxes.len > 0)
		return
	open = !open
	if(open && !bomb_defused)
		audible_message(span_warning("[icon2html(src, hearers(src))] *beep*"))
		bomb_active = TRUE
		START_PROCESSING(SSobj, src)
	update_appearance()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/pizzabox/attack_hand(mob/user)
	if(user.get_inactive_held_item() != src)
		return ..()
	if(open)
		if(pizza)
			user.put_in_hands(pizza)
			to_chat(user, span_notice("You take [pizza] out of [src]."))
			pizza = null
			update_appearance()
		else if(bomb)
			if(wires.is_all_cut() && bomb_defused)
				user.put_in_hands(bomb)
				to_chat(user, span_notice("You carefully remove the [bomb] from [src]."))
				bomb = null
				update_appearance()
				return
			else
				bomb_timer = input(user, "Set the [bomb] timer from [BOMB_TIMER_MIN] to [BOMB_TIMER_MAX].", bomb, bomb_timer) as num|null

				if (isnull(bomb_timer))
					return

				bomb_timer = clamp(CEILING(bomb_timer / 2, 1), BOMB_TIMER_MIN, BOMB_TIMER_MAX)
				bomb_defused = FALSE

				log_bomber(user, "has trapped a", src, "with [bomb] set to [bomb_timer * 2] seconds")
				bomb.adminlog = "The [bomb.name] in [src.name] that [key_name(user)] activated has detonated!"

				to_chat(user, span_warning("You trap [src] with [bomb]."))
				update_appearance()
	else if(boxes.len)
		var/obj/item/pizzabox/topbox = boxes[boxes.len]
		boxes -= topbox
		user.put_in_hands(topbox)
		to_chat(user, span_notice("You remove the topmost [name] from the stack."))
		topbox.update_appearance()
		update_appearance()
		user.regenerate_icons()

/obj/item/pizzabox/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/pizzabox))
		var/obj/item/pizzabox/newbox = I
		if(!open && !newbox.open)
			var/list/add = list()
			add += newbox
			add += newbox.boxes
			if(!user.transferItemToLoc(newbox, src))
				return
			boxes += add
			newbox.boxes.Cut()
			to_chat(user, span_notice("You put [newbox] on top of [src]!"))
			newbox.update_appearance()
			update_appearance()
			user.regenerate_icons()
			if(boxes.len >= 5)
				if(prob(10 * boxes.len))
					to_chat(user, span_danger("You can't keep holding the stack!"))
					disperse_pizzas()
				else
					to_chat(user, span_warning("The stack is getting a little high..."))
			return
		else
			to_chat(user, span_notice("Close [open ? src : newbox] first!"))
	else if(istype(I, /obj/item/bombcore/miniature/pizza))
		if(open && !bomb)
			if(!user.transferItemToLoc(I, src))
				return
			wires = new /datum/wires/explosive/pizza(src)
			bomb = I
			to_chat(user, span_notice("You put [I] in [src]. Sneaky..."))
			update_appearance()
			return
		else if(bomb)
			to_chat(user, span_warning("[src] already has a bomb in it!"))
	else if(istype(I, /obj/item/pen))
		if(!open)
			if(!user.is_literate())
				to_chat(user, span_notice("You scribble illegibly on [src]!"))
				return
			var/obj/item/pizzabox/box = boxes.len ? boxes[boxes.len] : src
			box.boxtag += stripped_input(user, "Write on [box]'s tag:", box, "", 30)
			if(!user.canUseTopic(src, BE_CLOSE))
				return
			to_chat(user, span_notice("You write with [I] on [src]."))
			update_appearance()
			return
	else if(is_wire_tool(I))
		if(wires && bomb)
			wires.interact(user)
	else if(istype(I, /obj/item/reagent_containers/food))
		to_chat(user, span_warning("That's not a pizza!"))
	..()

/obj/item/pizzabox/process()
	if(bomb_active && !bomb_defused && (bomb_timer > 0))
		playsound(loc, 'sound/items/timer.ogg', 50, FALSE)
		bomb_timer--
	if(bomb_active && !bomb_defused && (bomb_timer <= 0))
		if(bomb in src)
			bomb.detonate()
			unprocess()
			qdel(src)
	if(!bomb_active || bomb_defused)
		if(bomb_defused && (bomb in src))
			bomb.defuse()
			bomb_active = FALSE
			unprocess()
	return

/obj/item/pizzabox/attack(mob/living/target, mob/living/user, def_zone)
	. = ..()
	if(boxes.len >= 3 && prob(25 * boxes.len))
		disperse_pizzas()

/obj/item/pizzabox/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(boxes.len >= 2 && prob(20 * boxes.len))
		disperse_pizzas()

/obj/item/pizzabox/proc/disperse_pizzas()
	visible_message(span_warning("The pizzas fall everywhere!"))
	for(var/V in boxes)
		var/obj/item/pizzabox/P = V
		var/fall_dir = pick(GLOB.alldirs)
		step(P, fall_dir)
		if(P.pizza && P.can_open_on_fall && prob(50)) //rip pizza
			P.open = TRUE
			P.pizza.forceMove(get_turf(P))
			fall_dir = pick(GLOB.alldirs)
			step(P.pizza, fall_dir)
			P.pizza = null
			P.update_appearance()
		boxes -= P
	update_appearance()
	if(isliving(loc))
		var/mob/living/L = loc
		L.regenerate_icons()

/obj/item/pizzabox/proc/unprocess()
	STOP_PROCESSING(SSobj, src)
	qdel(wires)
	wires = null
	update_appearance()

/obj/item/pizzabox/bomb/Initialize()
	. = ..()
	var/randompizza = pick(subtypesof(/obj/item/food/pizza))
	pizza = new randompizza(src)
	bomb = new(src)
	wires = new /datum/wires/explosive/pizza(src)

/obj/item/pizzabox/margherita/Initialize()
	. = ..()
	AddPizza()
	boxtag = "Margherita Deluxe"

/obj/item/pizzabox/margherita/proc/AddPizza()
	pizza = new /obj/item/food/pizza/margherita(src)

/obj/item/pizzabox/vegetable/Initialize()
	. = ..()
	pizza = new /obj/item/food/pizza/vegetable(src)
	boxtag = "Gourmet Vegatable"

/obj/item/pizzabox/mushroom/Initialize()
	. = ..()
	pizza = new /obj/item/food/pizza/mushroom(src)
	boxtag = "Mushroom Special"

/obj/item/pizzabox/meat/Initialize()
	. = ..()
	pizza = new /obj/item/food/pizza/meat(src)
	boxtag = "Meatlover's Supreme"

/obj/item/pizzabox/pineapple/Initialize()
	. = ..()
	pizza = new /obj/item/food/pizza/pineapple(src)
	boxtag = "Honolulu Chew"
