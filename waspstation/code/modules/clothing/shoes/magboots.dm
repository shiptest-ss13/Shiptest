/obj/item/clothing/shoes/magboots
	icon = 'waspstation/icons/obj/clothing/shoes.dmi'
	mob_overlay_icon = 'waspstation/icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/magboots/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WELDER)
		if(I.use(1))
			if (alert(user, "Are you sure you want to irreversibly weld the [src] to be able to fit digitigrade legs?", "Mold magboots:", "Yes", "No") != "Yes")
				return
			I.play_tool_sound(src)
			to_chat(user, "<span class='notice'>You weld the [src] into a shape able to be worn by those with digitigrade legs.</span>")
			var/obj/item/clothing/shoes/magboots/digitigrade/C = new (get_turf(src))
			user.put_in_hands(C)
			qdel(src)


/obj/item/clothing/shoes/magboots/digitigrade //Ported from https://github.com/TheSwain/Fulpstation/pull/466
	name = "digitigrade magboots"
	desc = "A pair of magboots shaped with a welder to fit a digitigrade."
	is_digitigrade = 2
	icon_state = "magboots_digi0"
	magboot_state = "magboots_digi"

/obj/item/clothing/shoes/magboots/digitigrade/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WELDER)
		return


/obj/item/clothing/shoes/magboots/syndie/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WELDER)
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(src != user.get_item_by_slot(ITEM_SLOT_FEET))
			if(!(DIGITIGRADE_SHOE & obj_flags))
				obj_flags |= DIGITIGRADE_SHOE
				icon_state = "syndiemag_digi[magpulse]"
				magboot_state = "syndiemag_digi"
				desc = "Reverse-engineered magnetic boots that have a heavy magnetic pull. Property of Gorlex Marauders. They are set to fit digitigrade legs."
				to_chat(user, "<span class='notice'>You set the blood-red magboots to Digitigrade mode [src].</span>")
			else
				obj_flags = null
				icon_state = "syndiemag[magpulse]"
				magboot_state = "syndiemag"
				desc = "Reverse-engineered magnetic boots that have a heavy magnetic pull. Property of Gorlex Marauders. They are set to fit normal legs."
				to_chat(user, "<span class='notice'>You set the blood-red magboots to Normal mode [src].</span>")
			I.play_tool_sound(src)
		else
			to_chat(user, "<span class='warning'>The [src] cannot be on your feet when you adjust them!</span>")
	return ..()

/obj/item/clothing/shoes/magboots/advance/digicompatable //Ported from https://github.com/TheSwain/Fulpstation/pull/470
	desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer. They are set to fit normal legs."
	name = "Advanced magboots"
	icon_state = "advmag0"
	magboot_state = "advmag"
	slowdown_active = SHOES_SLOWDOWN
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/shoes/magboots/advance/digicompatable/attackby(obj/item/I, mob/living/user, params) //Ported from https://github.com/TheSwain/Fulpstation/pull/470
	if(I.tool_behaviour == TOOL_WELDER)
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(src != user.get_item_by_slot(ITEM_SLOT_FEET))
			if(!(DIGITIGRADE_SHOE & obj_flags))
				obj_flags |= DIGITIGRADE_SHOE
				icon_state = "advmag_digi[magpulse]"
				magboot_state = "advmag_digi"
				desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer. They are set to fit digitigrade legs."
				to_chat(user, "<span class='notice'>You set the advanced magboots to Digitigrade mode [src].</span>")
			else
				obj_flags = null
				icon_state = "advmag[magpulse]"
				magboot_state = "advmag"
				desc = "Advanced magnetic boots that have a lighter magnetic pull, placing less burden on the wearer. They are set to fit normal legs."
				to_chat(user, "<span class='notice'>You set the advanced magboots to Normal mode [src].</span>")
			I.play_tool_sound(src)
		else
			to_chat(user, "<span class='warning'>The [src] cannot be on your feet when you adjust them!</span>")
	return ..()
