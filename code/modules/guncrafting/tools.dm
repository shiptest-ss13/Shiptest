/obj/item/tool/hammer
	name = "hammer"
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldcrowbar"

/obj/item/tool/file
	name = "file"
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldwrench"

/obj/item/tool/saw
	name = "saw"
	icon = 'icons/obj/tools.dmi'
	icon_state = "oldcutters_map"

/obj/item/storage/box/parts
	name = "gunmakers box"
	desc = "A set of tools and parts to assemble your first weapon"

/obj/item/storage/box/parts/PopulateContents()
	new /obj/item/tool/hammer(src)
	new /obj/item/tool/file(src)
	new /obj/item/tool/saw(src)
	new /obj/item/part/gun/frame/winchester(src)
	new /obj/item/part/gun/modular/grip/wood(src)
	new /obj/item/part/gun/modular/mechanism/shotgun(src)
	new /obj/item/part/gun/modular/barrel/shotgun(src)
	new /obj/item/part/gun/frame/winchester(src)
	new /obj/item/part/gun/modular/grip/wood(src)
	new /obj/item/part/gun/modular/mechanism/shotgun(src)
	new /obj/item/part/gun/modular/barrel/shotgun(src)
