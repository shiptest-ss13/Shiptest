/obj/item/part/gun/frame
	name = "gun frame"
	desc = "a generic gun frame."
	icon_state = "frame_olivaw"
	generic = FALSE
	var/obj/item/gun/result = /obj/item/gun

	// Currently installed grip
	var/obj/item/part/gun/modular/grip/InstalledGrip
	// Which grips does the frame accept?
	var/list/validGrips = list(/obj/item/part/gun/modular/grip/wood, /obj/item/part/gun/modular/grip/black)

	// Currently installed mechanism
	var/obj/item/part/gun/modular/grip/InstalledMechanism
	// Which mechanism the frame accepts?
	var/list/validMechanisms = list(/obj/item/part/gun/modular/mechanism)

	// Currently installed barrel
	var/obj/item/part/gun/modular/barrel/InstalledBarrel
	// Which barrels does the frame accept?
	var/list/validBarrels = list(/obj/item/part/gun/modular/barrel)

	gun_part_type = FRAME

/obj/item/part/gun/frame/Initialize(mapload)
	..()
	var/spawn_with_preinstalled_parts = TRUE

/obj/item/part/gun/frame/Initialize(mapload, dont_spawn_with_parts)
	..()
	if(dont_spawn_with_parts)
		spawn_with_preinstalled_parts = FALSE

	if(spawn_with_preinstalled_parts)
		var/list/parts_list = list("mechanism", "barrel", "grip")
		for(var/part in parts_list)
			switch(part)
				if("mechanism")
					var/select = pick(validMechanisms)
					InstalledMechanism = new select(src)
				if("barrel")
					var/select = pick(validBarrels)
					InstalledBarrel = new select(src)
				if("grip")
					var/select = pick(validGrips)
					InstalledGrip = new select(src)

/obj/item/part/gun/frame/proc/eject_item(obj/item/I, mob/living/user)
	if(!I || !user.IsAdvancedToolUser() || user.stat || !user.Adjacent(I))
		return FALSE
	user.put_in_hands(I)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] removes [I] from [src].",
		span_notice("You remove [I] from [src].")
	)
	return TRUE

/obj/item/part/gun/frame/proc/insert_item(obj/item/I, mob/living/user)
	if(!I || !istype(user) || user.stat)
		return FALSE
	I.forceMove(src)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	to_chat(user, span_notice("You insert [I] into [src]."))
	return TRUE

/obj/item/part/gun/frame/proc/replace_item(obj/item/I_old, obj/item/I_new, mob/living/user)
	if(!I_old || !I_new || !istype(user) || user.stat || !user.Adjacent(I_new) || !user.Adjacent(I_old))
		return FALSE
	I_new.forceMove(src)
	user.put_in_hands(I_old)
	playsound(src.loc, 'sound/weapons/gun/pistol/mag_release_alt.ogg', 75, 1)
	spawn(2)
		playsound(src.loc, 'sound/weapons/gun/pistol/mag_insert_alt.ogg', 75, 1)
	user.visible_message(
		"[user] replaces [I_old] with [I_new] in [src].",
		span_notice("You replace [I_old] with [I_new] in [src]."))
	return TRUE

/obj/item/part/gun/frame/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/part/gun/modular/grip))
		if(InstalledGrip)
			to_chat(user, span_warning("[src] already has a grip attached!"))
			return
		else
			handle_grip(I, user)

	if(istype(I, /obj/item/part/gun/modular/mechanism))
		if(InstalledMechanism)
			to_chat(user, span_warning("[src] already has a mechanism attached!"))
			return
		else
			handle_mechanism(I, user)

	if(istype(I, /obj/item/part/gun/modular/barrel))
		if(InstalledBarrel)
			to_chat(user, span_warning("[src] already has a barrel attached!"))
			return
		else
			handle_barrel(I, user)

	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		var/list/possibles = contents.Copy()
		var/obj/item/part/gun/toremove = input("Which part would you like to remove?","Removing parts") in possibles
		if(!toremove)
			return
		if(I.use_tool(src, user, 40, volume=50))
			eject_item(toremove, user)
			if(istype(toremove, /obj/item/part/gun/modular/grip))
				InstalledGrip = null
			else if(istype(toremove, /obj/item/part/gun/modular/barrel))
				InstalledBarrel = FALSE
			else if(istype(toremove, /obj/item/part/gun/modular/mechanism))
				InstalledMechanism = FALSE

	return ..()

/obj/item/part/gun/frame/proc/handle_grip(obj/item/I, mob/living/user)
	if(I.type in validGrips)
		if(insert_item(I, user))
			InstalledGrip = I
			to_chat(user, span_notice("You have attached the grip to \the [src]."))
			return
	else
		to_chat(user, span_warning("This grip does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_mechanism(obj/item/I, mob/living/user)
	if(I.type in validMechanisms)
		if(insert_item(I, user))
			InstalledMechanism = I
			to_chat(user, span_notice("You have attached the mechanism to \the [src]."))
			return
	else
		to_chat(user, span_warning("This mechanism does not fit!"))
		return

/obj/item/part/gun/frame/proc/handle_barrel(obj/item/I, mob/living/user)
	if(I.type in validBarrels)
		if(insert_item(I, user))
			InstalledBarrel = I
			to_chat(user, span_notice("You have attached the barrel to \the [src]."))
			return
	else
		to_chat(user, span_warning("This barrel does not fit!"))
		return

/obj/item/part/gun/frame/attack_self(mob/user)
	. = ..()
	if(!InstalledGrip)
		to_chat(user, span_warning("\the [src] does not have a grip!"))
		return
	if(!InstalledMechanism)
		to_chat(user, span_warning("\the [src] does not have a mechanism!"))
		return
	if(!InstalledBarrel)
		to_chat(user, span_warning("\the [src] does not have a barrel!"))
		return
	var/turf/T = get_turf(src)
	var/obj/item/gun/newGun = new result(T, 0)
	newGun.frame = src
	src.forceMove(newGun)
	return

/obj/item/part/gun/frame/examine(user, distance)
	. = ..()
	if(.)
		if(InstalledGrip)
			. += "<span class='notice'>\the [src] has \a [InstalledGrip] installed.</span>"
		else
			. += "<span class='notice'>\the [src] does not have a grip installed.</span>"
		if(InstalledMechanism)
			. += "<span class='notice'>\the [src] has \a [InstalledMechanism] installed.</span>"
		else
			. += "<span class='notice'>\the [src] does not have a mechanism installed.</span>"
		if(InstalledBarrel)
			. += "<span class='notice'>\the [src] has \a [InstalledBarrel] installed.</span>"
		else
			. += "<span class='notice'>\the [src] does not have a barrel installed.</span>"

/obj/item/part/gun/frame/mk1
	name = "wellmade gun frame"
	icon_state = "frame_shotgun"
	result = /obj/item/gun/ballistic/shotgun/winchester/mk1
	validGrips = list(/obj/item/part/gun/modular/grip/wood)
	validMechanisms = list(/obj/item/part/gun/modular/mechanism/shotgun)
	validBarrels = list(/obj/item/part/gun/modular/barrel/shotgun)
