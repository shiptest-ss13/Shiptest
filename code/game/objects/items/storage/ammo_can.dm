//No idea why this is a toolbox but I'm not fixing that right now
/obj/item/storage/toolbox/ammo
	name = "ammo can"
	desc = "A metal container for storing multiple boxes of ammunition or grenades."
	icon_state = "ammobox"
	item_state = "ammobox"
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'
	material_flags = NONE
	has_latches = FALSE

/obj/item/storage/toolbox/ammo/a850r/PopulateContents()
	name = "ammo can (8x50mmR)"
	icon_state = "ammobox_850"
	for(var/i in 1 to 4)
		new /obj/item/storage/box/ammo/a8_50r(src)

/obj/item/storage/toolbox/ammo/a762_40/PopulateContents()
	name = "ammo can (7.62x40mm CLIP)"
	icon_state = "ammobox_762"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/a762_40(src)

/obj/item/storage/toolbox/ammo/a308/PopulateContents()
	name = "ammo can (.308)"
	icon_state = "ammobox_308"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/a308(src)

/obj/item/storage/toolbox/ammo/c45/PopulateContents()
	name = "ammo can (.45)"
	icon_state = "ammobox_45"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/c45(src)

/obj/item/storage/toolbox/ammo/c9mm/PopulateContents()
	name = "ammo can (9mm)"
	icon_state = "ammobox_9mm"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/c9mm(src)

/obj/item/storage/toolbox/ammo/c10mm/PopulateContents()
	name = "ammo can (10mm)"
	icon_state = "ammobox_10mm"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/c10mm(src)

/obj/item/storage/toolbox/ammo/shotgun/PopulateContents()
	name = "ammo can (12ga)"
	icon_state = "ammobox_12ga"
	for (var/i in 1 to 4)
		new /obj/item/storage/box/ammo/a12g_buckshot(src)
