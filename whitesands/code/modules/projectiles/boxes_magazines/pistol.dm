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

/datum/design/disposable_gun
	name = "Disposable Gun"
	id = "disposable"
	build_type = AUTOLATHE
	materials = list(/datum/material/plastic = 4000)
	build_path = /obj/item/gun/ballistic/automatic/pistol/disposable
	category = list("Imported")

/datum/design/pizza_disposable_gun
	name = "Pizza Disposable Gun"
	id = "disposable_pizza"
	build_type = AUTOLATHE
	materials = list(/datum/material/pizza = 4000)
	build_path = /obj/item/gun/ballistic/automatic/pistol/disposable/pizza
	category = list("Imported")

/obj/item/disk/design_disk/disposable_gun
	name = "Design Disk - Disposable Gun"
	desc = "A design disk containing designs for a cheap and disposable gun."

/obj/item/disk/design_disk/disposable_gun/Initialize()
	. = ..()
	var/datum/design/disposable_gun/G = new
	var/datum/design/pizza_disposable_gun/P = new
	blueprints[1] = G
	blueprints[2] = P

/obj/item/disk/design_disk/ammo_38_hunting
	name = "Design Disk - .38 Hunting Ammo"
	desc = "A design disk containing the pattern for a refill ammo box for Winchester rifles and Detective Specials."

/obj/item/disk/design_disk/ammo_38_hunting/Initialize()
	. = ..()
	var/datum/design/ammo/c38_hunting/M = new
	blueprints[1] = M

/datum/design/ammo/c38_hunting
	name = "Ammo Box (.38 hunting)"
	id = "c38_hunting"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/c38_box/hunting
	category = list("Imported")
