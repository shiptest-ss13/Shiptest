/obj/machinery/door/firedoor
	name = "emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. This one has a glass panel. It has a mechanism to open it with just your hands."
	icon = 'starbloom_modules/aesthetics/firedoor/icons/firedoor_glass.dmi'

/obj/machinery/door/firedoor/heavy
	name = "heavy emergency shutter"
	desc = "Emergency air-tight shutter, capable of sealing off breached areas. It has a mechanism to open it with just your hands."
	icon = 'starbloom_modules/aesthetics/firedoor/icons/firedoor.dmi'

/obj/effect/spawner/structure/window/reinforced/no_firelock
	spawn_list = list(/obj/structure/grille, /obj/structure/window/reinforced/fulltile)

/obj/machinery/door/firedoor/closed
	alarm_type = FIRELOCK_ALARM_TYPE_GENERIC
