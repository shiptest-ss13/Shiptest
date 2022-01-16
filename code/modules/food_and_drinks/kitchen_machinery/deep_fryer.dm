// April 3rd, 2014 marks the day this machine changed the face of the kitchen on NTStation13
// God bless America.
//           ___----------___
//         _--                ----__
//        -                         ---_
//       -___    ____---_              --_
//   __---_ .-_--   _ O _-                -
//  -      -_-       ---                   -
// -   __---------___                       -
// - _----                                  -
//  -     -_                                 _
//  `      _-                                 _
//        _                           _-_  _-_ _
//       _-                   ____    -_  -   --
//       -   _-__   _    __---    -------       -
//      _- _-   -_-- -_--                        _
//      -_-                                       _
//     _-                                          _
//     -

/obj/machinery/deepfryer
	name = "deep fryer"
	desc = "Deep fried <i>everything</i>."
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "fryer_off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	layer = BELOW_OBJ_LAYER
	///What's being fried RIGHT NOW?
	var/obj/item/reagent_containers/food/snacks/deepfryholder/frying
	///Who's bring fried RIGHT NOW?
	var/obj/item/clothing/head/mob_holder/frying_mob
	var/cook_time = 0
	var/oil_use = 0.05 //How much cooking oil is used per tick
	var/fry_speed = 1 //How quickly we fry food
	var/frying_fried //If the object has been fried; used for messages
	var/frying_burnt //If the object has been burnt
	var/static/list/deepfry_blacklisted_items = typecacheof(list(
		/obj/item/screwdriver,
		/obj/item/crowbar,
		/obj/item/wrench,
		/obj/item/wirecutters,
		/obj/item/multitool,
		/obj/item/weldingtool,
		/obj/item/reagent_containers/glass,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/food/condiment,
		/obj/item/storage,
		/obj/item/smallDelivery,
		/obj/item/his_grace))
	var/datum/looping_sound/deep_fryer/fry_loop

/obj/machinery/deepfryer/Initialize()
	. = ..()
	create_reagents(50, OPENCONTAINER)
	reagents.add_reagent(/datum/reagent/consumable/cooking_oil, 25)
	component_parts = list()
	component_parts += new /obj/item/circuitboard/machine/deep_fryer(null)
	component_parts += new /obj/item/stock_parts/micro_laser(null)
	RefreshParts()
	fry_loop = new(list(src), FALSE)

/obj/machinery/deepfryer/RefreshParts()
	var/oil_efficiency
	for(var/obj/item/stock_parts/micro_laser/M in component_parts)
		oil_efficiency += M.rating
	oil_use = initial(oil_use) - (oil_efficiency * 0.0095)
	fry_speed = oil_efficiency

/obj/machinery/deepfryer/examine(mob/user)
	. = ..()
	if(frying)
		. += "You can make out \a [frying] in the oil."
	if(in_range(user, src) || isobserver(user))
		if(frying_mob)
			. += "<span class='warning'>You can see [frying_mob.held_mob] being fried inside!</span>"
		. += "<span class='notice'>The status display reads: Frying at <b>[fry_speed*100]%</b> speed.<br>Using <b>[oil_use*10]</b> units of oil per second.</span>"

/obj/machinery/deepfryer/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/reagent_containers/pill))
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>There's nothing to dissolve [I] in!</span>")
			return
		user.visible_message("<span class='notice'>[user] drops [I] into [src].</span>", "<span class='notice'>You dissolve [I] in [src].</span>")
		I.reagents.trans_to(src, I.reagents.total_volume, transfered_by = user)
		qdel(I)
		return
	if(!reagents.has_reagent(/datum/reagent/consumable/cooking_oil))
		to_chat(user, "<span class='warning'>[src] has no cooking oil to fry with!</span>")
		return
	if(I.resistance_flags & INDESTRUCTIBLE)
		to_chat(user, "<span class='warning'>You don't feel it would be wise to fry [I]...</span>")
		return
	if(istype(I, /obj/item/reagent_containers/food/snacks/deepfryholder))
		to_chat(user, "<span class='userdanger'>Your cooking skills are not up to the legendary Doublefry technique.</span>")
		return
	if(default_unfasten_wrench(user, I))
		return
	else if(default_deconstruction_screwdriver(user, "fryer_off", "fryer_off" ,I))	//where's the open maint panel icon?!
		return
	else
		if(is_type_in_typecache(I, deepfry_blacklisted_items) || HAS_TRAIT(I, TRAIT_NODROP) || (I.item_flags & (ABSTRACT | DROPDEL)))
			return ..()
		else if(!(frying || frying_mob) && user.transferItemToLoc(I, src))
			if(istype(I, /obj/item/clothing/head/mob_holder)) //Extreme violence against the short
				user.visible_message("<span class='warning'>[user.name] dunks [I.name] into [src]!", "<span class='notice'>You put [I] into [src].</span>")
				var/obj/item/clothing/head/mob_holder/M = I
				M.forceMove(src)
				frying_mob = M
				reagents.expose(M.held_mob, TOUCH)
			else
				to_chat(user, "<span class='notice'>You put [I] into [src].</span>")
				frying = new/obj/item/reagent_containers/food/snacks/deepfryholder(src, I)
			icon_state = "fryer_on"
			fry_loop.start()

/obj/machinery/deepfryer/process()
	..()
	var/datum/reagent/consumable/cooking_oil/C = reagents.has_reagent(/datum/reagent/consumable/cooking_oil)
	if(!C)
		return
	reagents.chem_temp = C.fry_temperature
	cook_time += fry_speed
	if(frying)
		reagents.trans_to(frying, oil_use, multiplier = fry_speed * 3) //Fried foods gain more of the reagent thanks to space magic
		if(cook_time >= 30 && !frying_fried)
			frying_fried = TRUE //frying... frying... fried
			playsound(src.loc, 'sound/machines/ding.ogg', 50, TRUE)
			audible_message("<span class='notice'>[src] dings!</span>")
		else if (cook_time >= 60 && !frying_burnt)
			frying_burnt = TRUE
			visible_message("<span class='warning'>[src] emits an acrid smell!</span>")
	if(frying_mob)
		frying_mob.held_mob.adjustFireLoss(fry_speed)
		frying_mob.held_mob.adjust_bodytemperature(fry_speed * 10, 0, C.fry_temperature)
		if(frying_mob.held_mob.stat == DEAD && !frying_fried)
			frying_fried = TRUE //frying... frying... gone
			playsound(src.loc, 'sound/machines/ding.ogg', 50, TRUE)
			audible_message("<span class='notice'>[src] dings!</span>")
		if(((frying_mob.held_mob.maxHealth - frying_mob.held_mob.fireloss) < HEALTH_THRESHOLD_DEAD*2) && !frying_burnt)
			frying_burnt = TRUE
			visible_message("<span class='warning'>[src] emits an acrid smell!</span>")


/obj/machinery/deepfryer/attack_ai(mob/user)
	return

/obj/machinery/deepfryer/attack_hand(mob/user)
	if(frying)
		if(frying.loc == src)
			to_chat(user, "<span class='notice'>You eject [frying] from [src].</span>")
			frying.fry(cook_time)
			icon_state = "fryer_off"
			frying.forceMove(drop_location())
			if(Adjacent(user) && !issilicon(user))
				user.put_in_hands(frying)
			frying = null
			cook_time = 0
			frying_fried = FALSE
			frying_burnt = FALSE
			fry_loop.stop()
			return
	else if(frying_mob)
		if(frying_mob.loc == src)
			user.visible_message("<span class='notice'>[user] ejects [frying_mob] from [src].", "<span class='notice'>You eject [frying_mob] from [src].</span>")
			icon_state = "fryer_off"
			if(Adjacent(user) && !issilicon(user) && user.a_intent != INTENT_HELP)
				user.put_in_hands(frying_mob)
			else
				frying_mob.forceMove(drop_location())
				frying_mob.release()
				reagents.expose(drop_location(), TOUCH)
			frying_mob = null
			cook_time = 0
			frying_fried = FALSE
			frying_burnt = FALSE
			fry_loop.stop()
			return
	else if(user.pulling && user.a_intent == "grab" && iscarbon(user.pulling) && reagents.total_volume)
		if(user.grab_state < GRAB_AGGRESSIVE)
			to_chat(user, "<span class='warning'>You need a better grip to do that!</span>")
			return
		var/mob/living/carbon/C = user.pulling
		user.visible_message("<span class='danger'>[user] dunks [C]'s face in [src]!</span>")
		reagents.expose(C, TOUCH)
		var/permeability = 1 - C.get_permeability_protection(list(HEAD))
		C.apply_damage(min(30 * permeability, reagents.total_volume), BURN, BODY_ZONE_HEAD)
		reagents.remove_any((reagents.total_volume/2))
		C.Paralyze(60)
		user.changeNext_move(CLICK_CD_MELEE)
	return ..()

/obj/machinery/deepfryer/relay_container_resist_act(mob/living/user, obj/O)
	if(O != frying_mob)
		return
	//Used by unfortunate contained mobs
	loc.visible_message("<span class='warning'>Oil spills out as something crawls out from [src]!</span>", null, null, null, user)
	to_chat(user, "<span class='notice'>You start crawling out of [src]... (This will take about 5 seconds.)</span>")
	if(!do_after(user, 50, FALSE))
		return
	user.visible_message("<span class='warning'>[user] spills out from [src] in a splash of grease!</span>", "You make it out of [src]!")
	icon_state = "fryer_off"
	frying_mob.forceMove(drop_location())
	frying_mob.release()
	reagents.expose(drop_location(), TOUCH)
	frying_mob = null
	cook_time = 0
	frying_fried = FALSE
	frying_burnt = FALSE
	fry_loop.stop()
