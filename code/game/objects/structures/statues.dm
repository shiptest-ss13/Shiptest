/obj/structure/statue
	name = "statue"
	desc = "Placeholder. Yell at Firecage if you SOMEHOW see this."
	icon = 'icons/obj/statue.dmi'
	icon_state = ""
	density = TRUE
	anchored = FALSE
	max_integrity = 100
	var/oreAmount = 5
	var/material_drop_type = /obj/item/stack/sheet/metal
	var/impressiveness = 15
	CanAtmosPass = ATMOS_PASS_DENSITY
	var/art_type = /datum/component/art

/obj/structure/statue/Initialize()
	. = ..()
	AddComponent(art_type, impressiveness)
	AddElement(/datum/element/beauty, impressiveness * 75)

/obj/structure/statue/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(default_unfasten_wrench(user, W))
			return
		if(W.tool_behaviour == TOOL_WELDER)
			if(!W.tool_start_check(user, amount=0))
				return FALSE

			user.visible_message("<span class='notice'>[user] is slicing apart the [name].</span>", \
								"<span class='notice'>You are slicing apart the [name]...</span>")
			if(W.use_tool(src, user, 40, volume=50))
				user.visible_message("<span class='notice'>[user] slices apart the [name].</span>", \
									"<span class='notice'>You slice apart the [name]!</span>")
				deconstruct(TRUE)
			return
	return ..()

/obj/structure/statue/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(material_drop_type)
			var/drop_amt = oreAmount
			if(!disassembled)
				drop_amt -= 2
			if(drop_amt > 0)
				new material_drop_type(get_turf(src), drop_amt)
	qdel(src)

//////////////////////////////////////STATUES/////////////////////////////////////////////////////////////
////////////////////////uranium///////////////////////////////////

/obj/structure/statue/uranium
	max_integrity = 300
	light_range = 2
	material_drop_type = /obj/item/stack/sheet/mineral/uranium
	var/last_event = 0
	var/active = null
	impressiveness = 25 // radiation makes an impression


/obj/structure/statue/uranium/nuke
	name = "statue of a nuclear fission explosive"
	desc = "This is a grand statue of a Nuclear Explosive. It has a sickening green colour."
	icon_state = "nuke"

/obj/structure/statue/uranium/attackby(obj/item/W, mob/user, params)
	radiate()
	return ..()

/obj/structure/statue/uranium/Bumped(atom/movable/AM)
	radiate()
	..()

/obj/structure/statue/uranium/attack_hand(mob/user)
	radiate()
	. = ..()

/obj/structure/statue/uranium/attack_paw(mob/user)
	radiate()
	. = ..()

/obj/structure/statue/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 30)
			last_event = world.time
			active = null
			return
	return

/////////////////////sandstone/////////////////////////////////////////

/obj/structure/statue/sandstone
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/sandstone
	impressiveness = 15

/obj/structure/statue/sandstone/venus //call me when we add marble i guess
	name = "statue of a pure maiden"
	desc = "An ancient marble statue. The subject is depicted with a floor-length braid and is wielding a toolbox. By Jove, it's easily the most gorgeous depiction of a woman you've ever seen. The artist must truly be a master of his craft. Shame about the broken arm, though."
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "venus"

/////////////////////snow/////////////////////////////////////////

/obj/structure/statue/snow
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/snow

/obj/structure/statue/snow/snowman
	name = "snowman"
	desc = "Several lumps of snow put together to form a snowman."
	icon_state = "snowman"

/obj/structure/statue/snow/snowlegion
	name = "snowlegion"
	desc = "Looks like that weird kid with the tiger plushie has been round here again."
	icon_state = "snowlegion"

/// bone
/obj/structure/statue/bone
	anchored = TRUE
	max_integrity = 120
	material_drop_type = /obj/item/stack/sheet/bone
	impressiveness = 18 // Carved from the bones of a massive creature, it's going to be a specticle to say the least
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/bone/rib
	name = "collosal rib"
	desc = "It's staggering to think that something this big could have lived, let alone died."
	oreAmount = 4
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "rib"

/obj/structure/statue/bone/skull
	name = "collosal skull"
	desc = "The gaping maw of a dead, titanic monster."
	oreAmount = 12
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "skull"

/obj/structure/statue/bone/skull/half
	desc = "The gaping maw of a dead, titanic monster. This one is cracked in half."
	oreAmount = 6
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "skull-half"
