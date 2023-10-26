/obj/structure/vein
	name = "ore vein"
	icon = 'icons/obj/lavaland/terrain.dmi'
	icon_state = "geyser"
	anchored = TRUE
	layer = HIGH_TURF_LAYER

	var/ore_list = list(
	/obj/item/stack/ore/uranium = 20,
	/obj/item/stack/ore/iron = 50,
	/obj/item/stack/ore/plasma = 25,
	/obj/item/stack/ore/silver = 20,
	/obj/item/stack/ore/gold = 10,
	/obj/item/stack/ore/diamond = 5,
	/obj/item/stack/ore/titanium = 30,
	)

/obj/structure/vein/Initialize()
	. = ..()
	for(var/type in ore_list)
		var/chance = rand(0, ore_list[type])
		ore_list[type] = chance

/obj/structure/vein/deconstruct(disassembled)
	destroy_effect()
	drop_ore()
	return..()

/obj/structure/vein/proc/drop_ore()
	for(var/type in ore_list)
		var/quantity = ore_list[type]
		new type(loc, quantity)

/obj/structure/vein/proc/destroy_effect()
	playsound(loc,'sound/effects/explosionfar.ogg', 200, TRUE)
	visible_message("<span class='boldannounce'>[src] collapses!</span>\n<span class='warning'>Ores spew out as the vein is destroyed!</span>")
