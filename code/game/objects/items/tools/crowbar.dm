/obj/item/crowbar
	name = "pocket crowbar"
	desc = "A small crowbar. This handy tool is useful for lots of things, such as prying floor tiles or opening unpowered doors."
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	usesound = 'sound/items/crowbar.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	drop_sound = 'sound/items/handling/crowbar_drop.ogg'
	pickup_sound =  'sound/items/handling/crowbar_pickup.ogg'

	attack_verb = list("attacked", "bashed", "battered", "bludgeoned", "whacked")
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	var/force_opens = FALSE

/obj/item/crowbar/red
	icon_state = "crowbar_red"
	force = 8

/obj/item/crowbar/abductor
	name = "alien crowbar"
	desc = "A hard-light crowbar. It appears to pry by itself, without any effort required."
	icon = 'icons/obj/abductor.dmi'
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	icon_state = "crowbar"
	toolspeed = 0.1


/obj/item/crowbar/large
	name = "crowbar"
	desc = "It's a big crowbar. It doesn't fit in your pockets, because it's big."
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 3
	throw_range = 3
	custom_materials = list(/datum/material/iron=70)
	icon_state = "crowbar_large"
	item_state = "crowbar"
	toolspeed = 0.7

/obj/item/crowbar/power
	name = "jaws of life"
	desc = "A set of jaws of life, compressed through the magic of science."
	icon_state = "jaws_pry"
	item_state = "jawsoflife"
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25)
	usesound = 'sound/items/jaws_pry.ogg'
	force = 15
	toolspeed = 0.7
	force_opens = TRUE

/obj/item/crowbar/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_CROWBAR ? "prying" : "cutting"] head."

/obj/item/crowbar/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, "<span class='notice'>You attach the cutting jaws to [src].</span>")
		usesound = 'sound/items/jaws_cut.ogg'
		icon_state = "jaws_cutter"
		update_appearance()
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, "<span class='notice'>You attach the prying jaws to [src].</span>")
		usesound = 'sound/items/jaws_pry.ogg'
		icon_state = "jaws_pry"
		update_appearance()

/obj/item/crowbar/power/attack_hand(mob/user)
	. = ..()
	update_appearance()

/obj/item/crowbar/power/pickup(mob/user)
	. = ..()
	update_appearance()

/obj/item/crowbar/power/dropped(mob/user)
	. = ..()
	update_appearance()

/obj/item/crowbar/power/update_overlays()
	. = ..()
	if(ismob(loc))
		var/mode_ovelay
		switch(tool_behaviour)
			if (TOOL_CROWBAR)
				mode_ovelay = "jaw_pry"
			if (TOOL_WIRECUTTER)
				mode_ovelay = "jaw_cut"
		. += mode_ovelay

/obj/item/crowbar/power/attack(mob/living/carbon/C, mob/user)
	if(istype(C) && C.handcuffed && tool_behaviour == TOOL_WIRECUTTER)
		user.visible_message("<span class='notice'>[user] cuts [C]'s restraints with [src]!</span>")
		qdel(C.handcuffed)
		return
	else
		..()

/obj/item/crowbar/cyborg
	name = "hydraulic crowbar"
	desc = "A hydraulic prying tool, simple but powerful."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "crowbar_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/syndie
	name = "suspicious-looking crowbar"
	desc = "It has special counterweights that adjust to the amount of pressure put on it by using a complex array of springs and screws."
	icon_state = "crowbar_syndie"
	toolspeed = 0.5
	force = 8

/obj/item/crowbar/old
	desc = "A small crowbar. This handy tool is useful for lots of things, such as prying floor tiles or opening unpowered doors. This one seems to be covered in dust."
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldcrowbar"
