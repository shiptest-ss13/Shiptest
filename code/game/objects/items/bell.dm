/* Table Bells
The bells harden
click on it or use it inhand to make a noise, click-drag to bring to inventory, varedit into different sounds because you can
*/

/obj/item/table_bell
	name = "table bell"
	desc = "A small bell used to get people's attention."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "table-bell"
	w_class = WEIGHT_CLASS_TINY
	var/bell_sound = 'sound/items/ding.ogg'

/obj/item/table_bell/Initialize(mapload)
	. = ..()
	interaction_flags_item = ~INTERACT_ITEM_ATTACK_HAND_PICKUP

/obj/item/table_bell/attack_self(mob/user)
	return attack_hand(user)

/obj/item/table_bell/attack_paw(mob/user)
	return attack_hand(user)

//ATTACK HAND IGNORING PARENT RETURN VAUE
/obj/item/table_bell/attack_hand(mob/user)
	playsound (src, bell_sound, 50, FALSE)
	flick("[icon_state]_ding", src)
	add_fingerprint(user)
	return ..()

/obj/item/table_bell/MouseDrop(atom/over_object)
	. = ..()
	var/mob/living/M = usr
	if(!istype(M) || M.incapacitated() || !Adjacent(M))
		return

	if(over_object == M)
		M.put_in_hands(src)

	else if(istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)

	add_fingerprint(M)

/obj/item/table_bell/brass
	name = "ornate table bell"
	desc = "A small bell with intricate engravings and four clawed legs."
	icon_state = "table-bell-brass"
