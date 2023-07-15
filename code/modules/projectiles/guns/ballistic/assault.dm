/obj/item/gun/ballistic/automatic/assualt
	burst_size = 1
	actions_types = list()

/obj/item/gun/ballistic/automatic/assualt/ak47
	name = "\improper AK-47"
	desc = "An old assault rifle, dating back to 20th century. It is commonly used by various bandits, pirates and colonists thanks to its reliability and ease of maintenance."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/ak47.ogg'
	icon_state = "ak47"
	item_state = "ak47"
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/ak47

/obj/item/gun/ballistic/automatic/assualt/ak47/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assualt/ak47/nt
	name = "\improper NT-AK"
	desc = "A cheap rip-off of an already cheap rifle. Comes with a foldable stock for easy storage, although accuracy is questionable when folded. Control click to toggle the stock."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ak47_nt"
	item_state = "ak47_nt"
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/aknt
	var/folded = FALSE
	var/unfolded_spread = 2
	var/unfolded_item_state = "ak47_nt"
	var/folded_spread = 20
	var/folded_item_state = "ak47_nt_stockless"

/obj/item/gun/ballistic/automatic/assualt/ak47/nt/CtrlClick(mob/user)
	. = ..()
	if((!ishuman(user) || user.stat))
		return
	to_chat(user, "<span class='notice'>You start to [folded ? "unfold" : "fold"] the stock on the [src].</span>")
	if(do_after(user, 10, target = src))
		fold(user)
		user.update_inv_back()
		user.update_inv_hands()
		user.update_inv_s_store()

/obj/item/gun/ballistic/automatic/assualt/ak47/nt/proc/fold(mob/user)
	if(folded)
		to_chat(user, "<span class='notice'>You unfold the stock on the [src].</span>")
		spread = unfolded_spread
		item_state = unfolded_item_state
		w_class = WEIGHT_CLASS_BULKY
	else
		to_chat(user, "<span class='notice'>You fold the stock on the [src].</span>")
		spread = folded_spread
		item_state = folded_item_state
		w_class = WEIGHT_CLASS_NORMAL

	folded = !folded
	playsound(src.loc, 'sound/weapons/empty.ogg', 100, 1)
	update_appearance()

/obj/item/gun/ballistic/automatic/assualt/ak47/nt/update_overlays()
	. = ..()
	var/mutable_appearance/stock
	if(!folded)
		stock = mutable_appearance(icon, "ak47_nt_stock")
	else
		stock = mutable_appearance(icon, null)
	. += stock

/obj/item/gun/ballistic/automatic/assualt/ak47/inteq
	name = "\improper SkM-24"
	desc = "An obsolete assault rifle seized from some frontier armory and extensively modified to IRMG standards. Chambered in 7.62x39mm."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/akm.ogg'
	icon_state = "akm"
	item_state = "akm"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/assualt/p16
	name = "\improper P-16"
	desc = "An ancient rifle used by professional mercenaries. It is said that the P-16 and AK-47 were destined to be in combat against each other. Chambered in 5.56mm."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/m16.ogg'
	icon_state = "p16"
	item_state = "p16"
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/p16

/obj/item/gun/ballistic/automatic/assualt/p16/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assualt/p16/minutemen
	name = "\improper CM-16"
	desc = "Standard issue rifle of the Colonial Minutemen. A heavily modified version of the P-16 designed to fit the standards of operative warfare."
	icon_state = "cm16"
	item_state = "cm16"

/obj/item/gun/ballistic/automatic/assualt/ar
	name = "\improper NT-ARG 'Boarder'"
	desc = "A robust assault rifle used by Nanotrasen fighting forces."
	fire_sound = 'sound/weapons/gun/rifle/shot_alt2.ogg'
	icon_state = "arg"
	item_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 1

/obj/item/gun/ballistic/automatic/assualt/ar/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/assualt/swiss_cheese
	name = "\improper Swiss Cheese"
	desc = "An ancient longarm famous for its boxy, modular design. The DMA on this unit is, sadly, broken. Uses 5.56mm ammunition for Matter mode."
	icon = 'icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/swiss.ogg'
	icon_state = "swiss"
	item_state = "swiss"
	mag_display = TRUE
	empty_indicator = TRUE
	burst_size = 3
	fire_delay = 1.5
	spread = 8
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/swiss
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/gun/ballistic/automatic/assualt/swiss_cheese/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.65 SECONDS)

/obj/item/gun/ballistic/automatic/assualt/swiss_cheese/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		to_chat(user, "<span class='danger'>You hear a strange sound from the DMA unit. It doesn't appear to be operational.</span>")
		return
	else
		return ..()

/obj/item/gun/ballistic/automatic/assualt/swiss_cheese/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to Hybrid.</span>")
		if(2)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd Matter.</span>")

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	for(var/datum/action/action as anything in actions)
		action.UpdateButtonIcon()
