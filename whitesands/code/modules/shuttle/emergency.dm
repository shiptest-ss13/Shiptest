/obj/item/storage/overmap_ship/emag_act(mob/user)
	. = ..()
	unlocked = !unlocked

/obj/item/storage/overmap_ship
	name = "emergency space suits"
	desc = "A wall mounted safe containing space suits. Will only open in emergencies."
	icon = 'icons/obj/storage.dmi'
	icon_state = "safe"
	anchored = TRUE
	var/unlocked = FALSE
	var/obj/structure/overmap/ship/simulated/linked_ship

/obj/item/storage/overmap_ship/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	linked_ship = port?.current_ship

/obj/item/storage/overmap_ship/PopulateContents()
	new /obj/item/clothing/head/helmet/space/fragile(src)
	new /obj/item/clothing/head/helmet/space/fragile(src)
	new /obj/item/clothing/suit/space/fragile(src)
	new /obj/item/clothing/suit/space/fragile(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/clothing/mask/gas(src)
	new /obj/item/tank/internals/oxygen/red(src)
	new /obj/item/tank/internals/oxygen/red(src)
	new /obj/item/pickaxe/emergency(src)
	new /obj/item/kitchen/knife/hunting(src)
	new /obj/item/survivalcapsule(src)

/obj/item/storage/overmap_ship/fueled/PopulateContents()
	..()
	new /obj/item/storage/toolbox/emergency/shuttle/fueled(src)

/obj/item/storage/overmap_ship/electric/PopulateContents()
	..()
	new /obj/item/storage/toolbox/emergency/shuttle/electric(src)

/obj/item/storage/overmap_ship/attackby(obj/item/W, mob/user, params)
	if (can_interact(user))
		return ..()

/obj/item/storage/overmap_ship/attack_hand(mob/user)
	if (can_interact(user))
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SHOW, user)
	return TRUE

/obj/item/storage/overmap_ship/MouseDrop(over_object, src_location, over_location)
	if(can_interact(usr))
		return ..()

/obj/item/storage/overmap_ship/AltClick(mob/user)
	if(!can_interact(user))
		return
	..()

/obj/item/storage/overmap_ship/can_interact(mob/user)
	if(!..())
		return FALSE
	if((linked_ship?.integrity < initial(linked_ship?.integrity) / 4)|| (!linked_ship.is_still() && linked_ship.avg_fuel_amnt < 10) || unlocked)
		return TRUE
	to_chat(user, "The storage unit will only unlock when the vessel is at 25% integrity or out of fuel.")

//Emergency toolbox with a few more things for repairing shuttles.
/obj/item/storage/toolbox/emergency/shuttle
	name = "shuttle repair kit"
	desc = "For emergencies only! Use when there is nothing else you can do about your ship."

/obj/item/storage/toolbox/emergency/shuttle/PopulateContents()
	new /obj/item/screwdriver(src)
	..()

/obj/item/storage/toolbox/emergency/shuttle/fueled/PopulateContents()
	..()
	new /obj/item/tank/internals/plasma/full/emergency_tank(src)

/obj/item/storage/toolbox/emergency/shuttle/electric/PopulateContents()
	new /obj/item/wirecutters(src)
	..()
	new /obj/item/stock_parts/cell/emproof/disposable(src)

//Reskinned plasma tank
/obj/item/tank/internals/plasma/full/emergency_tank
	name = "emergency fuel reserve tank"
	desc = "For emergencies only. Slot into engine for an emergency measure of fuel to get to the nearest planet or station."

//Disposable EMP-proof cells
/obj/item/stock_parts/cell/emproof/disposable
	desc = "An EMP-proof cell. This one can't be recharged."

/obj/item/stock_parts/cell/emproof/disposable/Initialize(mapload, override_maxcharge)
	. = ..()
	maxcharge = 0

/obj/item/stock_parts/cell/emproof/disposable/percent()
	return 100
