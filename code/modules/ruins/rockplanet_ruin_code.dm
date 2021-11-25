/obj/machinery/door/poddoor/crusher
	gender = PLURAL
	name = "industrial presser"
	desc = "A machine that presses materials into plates."
	icon = 'icons/obj/doors/crusher.dmi'
	damage_deflection = 70
	glass = TRUE

/obj/machinery/door/poddoor/crusher/crush()
	. = ..()
	for(var/mob/living/L in get_turf(src))
		var/mob/living/carbon/C = L
		if(istype(C))
			C.bleed(150)
			C.apply_damage(75, forced=TRUE, spread_damage=TRUE)
			C.AddElement(/datum/element/squish, 80 SECONDS)
		else
			L.apply_damage(75, forced=TRUE)

		L.Paralyze(60)
		playsound(L, 'sound/effects/blobattack.ogg', 40, TRUE)
		playsound(L, 'sound/effects/splat.ogg', 50, TRUE)

	for(var/obj/item/stack/ore/O in get_turf(src))
		var/obj/item/stack/ore/R = new O.refined_type(src)
		R.amount = O.amount
		O.use(O.amount)

/obj/machinery/door/poddoor/crusher/close()
	. = ..()
	playsound(src, 'sound/effects/bang.ogg', 30, TRUE)

/obj/machinery/door/poddoor/crusher/automatic
	desc = "A machine that presses materials into plates. This one seems to be still functioning."
	var/is_open = FALSE //because it doesnt even track it on machinery/door

/obj/machinery/door/poddoor/crusher/automatic/preopen
	icon_state = "open"
	is_open = FALSE
	density = FALSE
	opacity = FALSE

/obj/machinery/door/poddoor/crusher/automatic/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	//COOLDOWN_START(src, 3 SECONDS)

/obj/machinery/door/poddoor/crusher/automatic/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/door/poddoor/crusher/automatic/open()
	. = ..()
	is_open = TRUE

/obj/machinery/door/poddoor/crusher/automatic/close()
	. = ..()
	is_open = FALSE

/obj/machinery/door/poddoor/crusher/automatic/process(delta_time)
	if(is_open)
		close()
	else
		open()

/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit
	name = "experimental gun upgrade kit"
	desc = "A suitcase containing the necessary gun parts to tranform a antique laser gun into something even better. A faded Nanotrasen Security symbol is on the side."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit/afterattack(atom/target, mob/user, proximity, params)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/item/gun)) //checks if they really clicked on a gun
		var/created_gun
		if(istype(target, /obj/item/gun/energy/laser/captain/brazil)) //the gun that comes with the ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil // hos gun with a fancy skin
		else if(istype(target, /obj/item/gun/energy/laser/captain)) //a actual antique gun, only on the skipper as of writing and a lavaland ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil/true // hos gun with a fancy skin, but also recharging!!
		else
			to_chat(user, "<span class='warning'>You can't upgrade this gun!.</span>") //wrong gun
			return
		playsound(src, 'sound/items/drill_use.ogg', 50, FALSE)
		if(do_after(user, 60, target = target))
			new created_gun(get_turf(src))
			to_chat(user, "<span class='notice'>With the [src], you upgrade the [target]!</span>")
			qdel(target)
			qdel(src)
			return

/obj/item/strange_crystal
	name = "strange crystal"
	desc = "A crystal that came from a dead creature. Its rapid growth and corruption is kept inert."
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'
	icon_state = "unnamed_crystal"
	grind_results = list(/datum/reagent/crystal_reagent = 4)
