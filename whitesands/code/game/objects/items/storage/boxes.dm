/obj/item/storage/box/slugshot
	name = "box of 12-gauge slug shotgun shells"
	desc = "a box full of slug shots, designed for riot shotguns"
	icon = 'whitesands/icons/obj/storage.dmi'
	icon_state = "slugshot_box"
	illustration = null

/obj/item/storage/box/slugshot/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun(src)
