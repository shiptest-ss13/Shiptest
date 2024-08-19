//I JUST WANNA GRILL FOR GOD'S SAKE

/obj/machinery/grill
	name = "grill"
	desc = "Just like the old days."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "grill_open"
	density = TRUE
	layer = BELOW_OBJ_LAYER
	use_power = NO_POWER_USE
	var/grill_fuel = 0
	var/obj/item/reagent_containers/food/snacks/grilled_item
	var/grill_time = 0
	var/datum/looping_sound/grill/grill_loop

/obj/machinery/grill/Initialize()
	. = ..()
	grill_loop = new(list(src), FALSE)

/obj/machinery/grill/update_icon_state()
	if(grilled_item)
		icon_state = "grill"
		return ..()
	else if(grill_fuel)
		icon_state = "grill_on"
		return ..()
	else
		icon_state = "grill_open"
	return ..()

/obj/machinery/grill/examine(mob/user)
	. = ..()
	if(grill_fuel)
		. += span_notice("\The [src] has [grill_fuel] units of fuel left.")
	else
		. += span_warning("\The [src] is out of fuel! Add some wood or coal!")

/obj/machinery/grill/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet/mineral/coal) || istype(I, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/S = I
		var/stackamount = S.get_amount()
		to_chat(user, span_notice("You put [stackamount] [I]s in [src]."))
		if(istype(I, /obj/item/stack/sheet/mineral/coal))
			grill_fuel += (50 * stackamount)
		else
			grill_fuel += (5 * stackamount)
		S.use(stackamount)
		update_appearance()
		return
	if(I.resistance_flags & INDESTRUCTIBLE)
		to_chat(user, span_warning("You don't feel it would be wise to grill [I]..."))
		return ..()

	if(istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/food_item = I
		if(HAS_TRAIT(food_item, TRAIT_NODROP) || (food_item.item_flags & (ABSTRACT | DROPDEL)))
			return ..()
		else if(food_item.foodtype & GRILLED)
			to_chat(user, span_notice("[food_item] has already been grilled!"))
			return
		else if(grill_fuel <= 0)
			to_chat(user, span_warning("There is not enough fuel!"))
			return
		else if(grilled_item)
			to_chat(user,span_warning("\The [src] is already grilling something, take it out first!"))
			return
		else if(user.transferItemToLoc(food_item, src))
			START_PROCESSING(SSmachines, src)
			grilled_item = food_item
			to_chat(user, span_notice("You put the [grilled_item] on [src]."))
			update_appearance()
			grill_loop.start()
			return
	..()

/obj/machinery/grill/process()
	..()
	if(!grilled_item)
		return PROCESS_KILL
	update_appearance()
	if(grill_fuel <= 0)
		grill_fuel = 0
		visible_message(span_warning("\The [src] is out of fuel!"))
		if(grilled_item)
			grilled_item.forceMove(loc)
			finish_grill()
		return
	grill_time += 1
	grill_fuel -= 1
	if(prob(1))
		var/datum/effect_system/smoke_spread/bad/smoke = new
		smoke.set_up(1, loc)
		smoke.start()

/obj/machinery/grill/Exited(atom/movable/AM)
	if(AM == grilled_item)
		finish_grill()
	. = ..()

/obj/machinery/grill/Destroy()
	QDEL_NULL(grilled_item)
	QDEL_NULL(grill_loop)
	return ..()

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
	if(grill_time >= 10 && grilled_item.cooked_type)
		grilled_item = grilled_item.microwave_act()
	switch(grill_time) //no 0-9 to prevent spam
		if(10 to 15)
			grilled_item.name = "lightly-grilled [grilled_item.name]"
			grilled_item.desc = "[grilled_item.desc] It's been lightly grilled."
		if(16 to 39)
			grilled_item.name = "grilled [grilled_item.name]"
			grilled_item.desc = "[grilled_item.desc] It's been grilled."
			grilled_item.foodtype |= FRIED
		if(40 to 50)
			grilled_item.name = "heavily grilled [grilled_item.name]"
			grilled_item.desc = "[grilled_item.desc] It's been heavily grilled."
			grilled_item.foodtype |= FRIED
		if(51 to INFINITY) //grill marks reach max alpha
			grilled_item.name = "Powerfully Grilled [grilled_item.name]"
			grilled_item.desc = "A [grilled_item.name]. Reminds you of your wife, wait, no, it's prettier!"
			grilled_item.foodtype |= FRIED
	grilled_item.AddComponent(/datum/component/sizzle, (grill_time * 5))
	grilled_item.foodtype |= GRILLED
	grill_time = 0
	grill_loop.stop()
	grilled_item = null
	update_appearance()

/obj/machinery/grill/unwrenched
	anchored = FALSE

//I JUST WANNYA GWIWW FOW GAWD'S SAKE

/obj/machinery/grill/cat
	name = "catgrill"
	desc = "Is this what the youngins are into now?"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "catgrill_open"
	anchored = FALSE

/obj/machinery/grill/cat/update_icon_state()
	if(grilled_item)
		icon_state = "catgrill"
	else if(grill_fuel)
		icon_state = "catgrill_on"
	else
		icon_state = "catgrill_open"
	return ..()

/obj/machinery/grill/cat/proc/owoify()
	var/static/regex/owo = new("r|l", "g")
	var/static/regex/oWo = new("R|L", "g")
	var/static/regex/Nya = new("N(a|e|i|o|u)", "g")
	// Forgive me marg for I have sinned
	grilled_item.name = owo.Replace(grilled_item.name, "w")
	grilled_item.name = oWo.Replace(grilled_item.name, "w")
	grilled_item.name = Nya.Replace(grilled_item.name, "Ny$1")

/obj/machinery/grill/cat/finish_grill()
	..()
	owoify()
