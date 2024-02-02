// PARTS //

/obj/item/weaponcrafting/receiver
	name = "modular receiver"
	desc = "A prototype modular receiver and trigger assembly for a firearm."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "receiver"

/obj/item/weaponcrafting/stock
	name = "rifle stock"
	desc = "A classic rifle stock that doubles as a grip, roughly carved out of wood."
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 6)
	icon = 'icons/obj/improvised.dmi'
	icon_state = "riflestock"

/obj/item/weaponcrafting/silkstring
	name = "silkstring"
	desc = "A long piece of Silk that looks like a cable coil."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "silkstring"

/obj/item/stack/gun_part
	name = "Gun Parts"
	singular_name = "Gun Part"
	desc = "This could fabcricate metal parts."
	icon = 'icons/obj/guncrafting.dmi'
	icon_state = "work_piece"
	max_amount = 10
