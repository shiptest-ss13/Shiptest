/obj/item/door_seal
	name = "pneumatic seal"
	desc = "A brace used to seal and reinforce an airlock. Useful for making areas inaccessible to those without opposable thumbs."
	icon = 'icons/obj/items.dmi'
	icon_state = "pneumatic_seal"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	flags_1 = CONDUCT_1
	resistance_flags = FIRE_PROOF | ACID_PROOF
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 1
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=5000,/datum/material/plasma=500)
	/// how long the seal takes to place on the door
	var/seal_time = 3 SECONDS
	/// how long it takes to remove the seal from a door
	var/unseal_time = 2 SECONDS
