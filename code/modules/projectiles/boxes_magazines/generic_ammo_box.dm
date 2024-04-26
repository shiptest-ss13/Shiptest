/datum/design/generic_ammo_box
	name = "Generic Ammo Box"
	id = "generic-ammo"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_box/generic
	category = list("initial", "Security", "Ammo")

/datum/design/ammo_can
	name = "Ammo Can"
	id = "ammo-can"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/storage/toolbox/ammo
	category = list("initial", "Security", "Ammo")
