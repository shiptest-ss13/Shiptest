/obj/structure/salvageable
	name = "broken machinery"
	desc = "It is broken beyond repair. You may be able to salvage something from this."
	icon = 'icons/obj/salvage_structure.dmi'
	density = TRUE
	anchored = TRUE
	var/salvageable_parts = list()

/obj/structure/salvageable/proc/dismantle()
	var/obj/frame = new /obj/structure/frame/machine(get_turf(src))
	frame.anchored = TRUE
	for(var/path in salvageable_parts)
		if(prob(salvageable_parts[path]))
			new path (loc)
	return

/obj/structure/salvageable/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	user.visible_message(user,"<span class='notice'>[user] starts to salvage \the [src].</span>", \
					"<span class='notice'>You start salvage anything useful from \the [src].</span>")
	I.play_tool_sound(src, 100)
	if(do_after(user, 60, target = src))
		user.visible_message(user, "<span class='notice'>[user] dismantles \the [src].</span>", \
						"<span class='notice'>You dismantle \the [src].</span>")
		dismantle()
		I.play_tool_sound(src, 100)
		qdel(src)
		return


//Types themself, use them, but not the parent object

/obj/structure/salvageable/machine
	name = "broken machine"
	icon_state = "wreck_pda"
	salvageable_parts = list(
		/obj/item/stack/sheet/glass/two = 80,
		/obj/item/stack/cable_coil/cut = 80,
		/obj/item/stack/ore/salvage/scrapgold = 60,
		/obj/item/stack/ore/salvage/scrapmetal = 60,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/capacitor = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/scanning_module = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/manipulator = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/micro_laser = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/matter_bin = 40,
		/obj/item/stock_parts/capacitor/adv = 20,
		/obj/item/stock_parts/scanning_module/adv = 20,
		/obj/item/stock_parts/manipulator/nano = 20,
		/obj/item/stock_parts/micro_laser/high = 20,
		/obj/item/stock_parts/matter_bin/adv = 20,
		/obj/item/stock_parts/manipulator/pico = 5,
		/obj/item/stock_parts/matter_bin/super = 5,
		/obj/item/stock_parts/micro_laser/ultra = 5,
		/obj/item/stock_parts/scanning_module/phasic = 5
	)


/obj/item/stack/ore/salvage
	name = "salvage"
	icon = 'icons/obj/salvage_structure.dmi'

/obj/item/stack/ore/salvage/examine(mob/user)
	. = ..()
	. += "You can most likely reclaim this in a autolathe or Ore Redemption Machine."

/obj/item/stack/ore/salvage/scrapmetal
	name = "scrap metal"
	desc = "A collection of metal peices and parts."
	icon_state = "smetal"
	item_state = "smetal"
	points = 1
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/metal

/obj/item/stack/ore/salvage/scraptitanium
	name = "scrap titanium"
	desc = "A bunch of strong metal peices and parts from high-preformance equppment."
	icon_state = "stitanium"
	item_state = "stitanium"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/titanium

/obj/item/stack/ore/salvage/scrapsilver
	name = "worn crt"
	desc = "An old CRT display. the letters 'STANDBY' are burned into the screen."
	icon_state = "ssilver"
	item_state = "ssilver"
	points = 16
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/silver

/obj/item/stack/ore/salvage/scrapgold
	name = "scrap electronics"
	desc = "Various bits of electrical components."
	icon_state = "sgold"
	item_state = "sgold"
	points = 18
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold

/obj/item/stack/ore/salvage/scrapplasma
	name = "junk plasma cell"
	desc = "This plasma cell looks nonfunctional."
	icon_state = "splasma"
	item_state = "splasma"
	points = 15
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/plasma

/obj/item/stack/ore/salvage/scrapuranium
	name = "broken detector"
	desc = "There is a label on the side of the old detector warning of radioactive elements."
	icon_state = "suranium"
	item_state = "suranium"
	points = 30
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/uranium

/obj/item/stack/ore/salvage/scrapbluespace
	name = "damaged bluespace circuit"
	desc = "The circuit looks too damaged to be operational, but the crystal inside its housing looks fine."
	icon_state = "sbluespace"
	item_state = "sbluespace"
	points = 50
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/bluespace=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/bluespace_crystal
