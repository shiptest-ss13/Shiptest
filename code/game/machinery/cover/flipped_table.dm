/obj/structure/barricade/directional/flippedtable
	name = "flipped table"
	desc = "A flipped table."
	icon = 'icons/obj/flipped_tables.dmi'
	icon_state = "table"
	var/obj/structure/table/table_type = /obj/structure/table
	pass_chance = 80

/obj/structure/barricade/directional/flippedtable/Initialize(mapload)
	. = ..()
	if(mapload)
		name = "flipped [table_type.name]"
		desc = "[table_type.desc] It is flipped!"
		max_integrity = table_type.max_integrity

/obj/structure/barricade/directional/flippedtable/examine(mob/user)
	. = ..()
	. += span_notice("You could right the [name] by <b>Control Shift-Clicking</b> it.")

/obj/structure/barricade/directional/flippedtable/CtrlShiftClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.can_interact_with(src))
		return FALSE
	user.visible_message(span_danger("[user] starts flipping [src]!"), span_notice("You start flipping over the [src]!"))
	if(do_after(user, max_integrity/12))
		var/obj/structure/table/table_unflip = new table_type(src.loc)
		table_unflip.update_integrity(atom_integrity)
		user.visible_message(span_danger("[user] flips over the [src]!"), span_notice("You flip over the [src]!"))
		playsound(src, 'sound/items/trayhit2.ogg', 100)
		qdel(src)

/obj/structure/barricade/directional/flippedtable/bronze
	name = "flipped brass table"
	icon_state = "brass_table"
	table_type = /obj/structure/table/bronze

/obj/structure/barricade/directional/flippedtable/glass
	name = "flipped glass table"
	icon_state = "glass_table"
	table_type = /obj/structure/table/glass

/obj/structure/barricade/directional/flippedtable/wood
	name = "flipped wooden table"
	icon_state = "wood_table"
	table_type = /obj/structure/table/wood

/obj/structure/barricade/directional/flippedtable/poker
	name = "flipped poker table"
	icon_state = "poker_table"
	table_type = /obj/structure/table/wood/poker

/obj/structure/barricade/directional/flippedtable/fancy
	name = "flipped fancy table"
	icon_state = "fancy_table"
	table_type = /obj/structure/table/wood/fancy

/obj/structure/barricade/directional/flippedtable/fancy/blue
	name = "flipped blue fancy table"
	icon_state = "fancy_table_blue"
	table_type = /obj/structure/table/wood/fancy/blue

/obj/structure/barricade/directional/flippedtable/fancy/black
	name = "flipped black fancy table"
	icon_state = "fancy_table_black"
	table_type = /obj/structure/table/wood/fancy/black

/obj/structure/barricade/directional/flippedtable/fancy/cyan
	name = "flipped fancy table"
	icon_state = "fancy_table_cyan"
	table_type = /obj/structure/table/wood/fancy/cyan

/obj/structure/barricade/directional/flippedtable/fancy/green
	name = "flipped green fancy table"
	icon_state = "fancy_table_green"
	table_type = /obj/structure/table/wood/fancy/green

/obj/structure/barricade/directional/flippedtable/fancy/orange
	name = "flipped orange fancy table"
	icon_state = "fancy_table_orange"
	table_type = /obj/structure/table/wood/fancy/orange

/obj/structure/barricade/directional/flippedtable/fancy/purple
	name = "flipped purple fancy table"
	icon_state = "fancy_table_purple"
	table_type = /obj/structure/table/wood/fancy/purple

/obj/structure/barricade/directional/flippedtable/fancy/red
	name = "flipped red fancy table"
	icon_state = "fancy_table_red"
	table_type = /obj/structure/table/wood/fancy/red

/obj/structure/barricade/directional/flippedtable/fancy/royal_black
	name = "flipped royal black fancy table"
	icon_state = "fancy_table_royalblack"
	table_type = /obj/structure/table/wood/fancy/royalblack

/obj/structure/barricade/directional/flippedtable/fancy/royal_blue
	name = "flipped royal blue fancy table"
	icon_state = "fancy_table_royalblue"
	table_type = /obj/structure/table/wood/fancy/royalblue

