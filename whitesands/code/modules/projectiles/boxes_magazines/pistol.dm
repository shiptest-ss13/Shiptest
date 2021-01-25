/datum/design/ammo/colt_1911_magazine
	name = "Colt 1911 Magazine"
	id = "ammo_1911"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/m45
	category = list("Imported")

/obj/item/disk/design_disk/ammo_1911
	name = "Design Disk - 1911 Magazine"
	desc = "A design disk containing the pattern for the classic 1911's seven round .45ACP magazine."

/obj/item/disk/design_disk/ammo_1911/Initialize()
	. = ..()
	var/datum/design/ammo/colt_1911_magazine/M = new
	blueprints[1] = M
