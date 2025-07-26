#define GRILL_FUELUSAGE_IDLE 0.5
#define GRILL_FUELUSAGE_ACTIVE 5

/obj/machinery/grill
	name = "grill"
	desc = "Just like the old days."
	icon = 'icons/obj/machines/kitchen.dmi'
	icon_state = "grill_open"
	density = TRUE
	pass_flags_self = LETPASSTHROW // sorta like griddles
	layer = BELOW_OBJ_LAYER
	use_power = NO_POWER_USE
	var/grill_fuel = 0
	var/obj/item/food/grilled_item
	var/grill_time = 0
	var/datum/looping_sound/grill/grill_loop

/obj/machinery/grill/Initialize()
	. = ..()
	grill_loop = new(list(src), FALSE)

/obj/machinery/grill/Destroy()
	grilled_item = null
	QDEL_NULL(grill_loop)
	return ..()

/obj/machinery/grill/update_icon_state()
	if(grilled_item)
		icon_state = "grill"
		return ..()
	if(grill_fuel > 0)
		icon_state = "grill_on"
		return ..()
	icon_state = "grill_open"
	return ..()

/obj/machinery/grill/examine(mob/user)
	. = ..()
	if(grill_fuel)
		. += span_notice("\The [src] has [grill_fuel] units of fuel left.")
	else
		. += span_warning("\The [src] is out of fuel! Add some wood or coal!")

/obj/machinery/grill/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/S = I
		var/stackamount = S.get_amount()
		to_chat(user, span_notice("You put [stackamount] [I]s in [src]."))
		if(istype(I, /obj/item/stack/sheet/mineral/wood))
			grill_fuel += (20 * stackamount)
		S.use(stackamount)
		update_appearance()
		return

	if(I.resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("You don't feel it would be wise to grill [I]..."))
		return ..()

	if(IS_EDIBLE(I))
		var/obj/item/food/food_item = I
		if(HAS_TRAIT(food_item, TRAIT_NODROP) || (food_item.item_flags & (ABSTRACT | DROPDEL)))
			return ..()
		else if(!grill_fuel)
			to_chat(user, span_warning("There is not enough fuel!"))
			return
		else if(!grilled_item && user.transferItemToLoc(food_item, src))
			grilled_item = food_item
			RegisterSignal(grilled_item, COMSIG_GRILL_COMPLETED, PROC_REF(GrillCompleted))
			to_chat(user, span_notice("You put the [grilled_item] on [src]"))
			update_appearance()
			grill_loop.start()
			return
	..()

/obj/machinery/grill/process(seconds_per_tick)
	..()
	update_appearance()
	if(grill_fuel <= 0)
		return PROCESS_KILL
	else
		grill_fuel -= GRILL_FUELUSAGE_ACTIVE * seconds_per_tick

	if(grilled_item)
		SEND_SIGNAL(grilled_item, COMSIG_ITEM_GRILLED, src, seconds_per_tick)
		grill_time += seconds_per_tick
		grill_fuel -= GRILL_FUELUSAGE_ACTIVE * seconds_per_tick
		grilled_item.AddComponent(/datum/component/sizzle)

/obj/machinery/grill/Exited(atom/movable/AM)
	if(AM == grilled_item)
		finish_grill()
	. = ..()

/obj/machinery/grill/handle_atom_del(atom/A)
	if(A == grilled_item)
		grilled_item = null
	. = ..()

/obj/machinery/grill/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(default_unfasten_wrench(user, I) != CANT_UNFASTEN)
		return TRUE

/obj/machinery/grill/deconstruct(disassembled = TRUE)
	finish_grill()
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal(loc, 5)
		new /obj/item/stack/rods(loc, 5)
	..()

/obj/machinery/grill/attack_ai(mob/user)
	return

/obj/machinery/grill/attack_hand(mob/user)
	if(grilled_item)
		to_chat(user, span_notice("You take out [grilled_item] from [src]."))
		grilled_item.forceMove(drop_location())
		update_appearance()
		return
	return ..()

/obj/machinery/grill/proc/finish_grill()
	SEND_SIGNAL(grilled_item, COMSIG_GRILL_FOOD, grilled_item, grill_time)
	grill_time = 0
	UnregisterSignal(grilled_item, COMSIG_GRILL_COMPLETED, PROC_REF(GrillCompleted))
	grill_loop.stop()

///Called when a food is transformed by the grillable component
/obj/machinery/grill/proc/GrillCompleted(obj/item/source, atom/grilled_result)
	SIGNAL_HANDLER
	grilled_item = grilled_result //use the new item!!

/obj/machinery/grill/unwrenched
	anchored = FALSE

#undef GRILL_FUELUSAGE_IDLE
#undef GRILL_FUELUSAGE_ACTIVE
