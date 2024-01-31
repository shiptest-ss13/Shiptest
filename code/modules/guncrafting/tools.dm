/obj/item/tool/hammer
	name = "hammer"

/obj/item/tool/file
	name = "file"

/obj/item/tool/saw
	name = "saw"

/obj/item/storage/box/parts
	name = "gunmakers box"
	desc = "A set of tools and parts to assemble your first weapon"

/obj/item/storage/box/parts/PopulateContents()
	new /obj/item/tool/hammer(src)
	new /obj/item/tool/file(src)
	new /obj/item/tool/saw(src)
	/*
	new /obj/item/part/gun/frame/winchester(src)
	new /obj/item/part/gun/modular/grip/wood(src)
	new /obj/item/part/gun/modular/mechanism/shotgun(src)
	new /obj/item/part/gun/modular/barrel/shotgun(src)
	new /obj/item/part/gun/frame/winchester(src)
	new /obj/item/part/gun/modular/grip/wood(src)
	new /obj/item/part/gun/modular/mechanism/shotgun(src)
	new /obj/item/part/gun/modular/barrel/shotgun(src)
	*/
