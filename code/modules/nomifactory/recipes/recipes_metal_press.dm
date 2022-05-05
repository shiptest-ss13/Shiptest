/datum/nomi_recipe/metal_press
	abstract = /datum/nomi_recipe/metal_press
	machine_needed = /obj/structure/nomifactory/machinery/metal_press

/datum/nomi_recipe/metal_press/gear_press
	name = "Gear Pressing"
	desc = "A better way of making gears"
	inputs = list(
		/obj/item/nomi/ingot_iron = 2
	)
	outputs = list(
		/obj/item/nomi/gear = 1
	)

/datum/nomi_recipe/metal_press/rod_press
	name = "Rod Pressing"
	desc = "A better way of making rods"
	inputs = list(
		/obj/item/nomi/ingot_iron = 1
	)
	outputs = list(
		/obj/item/stack/rods = 3
	)
