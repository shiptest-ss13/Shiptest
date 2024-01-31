/datum/lathe_recipe
	var/obj/item/result = /obj/item/gun

/datum/lathe_recipe/gun
	var/list/validParts = list()
	var/requiredPartTypes = ALL

/datum/lathe_recipe/gun/winchester
	result = /obj/item/gun/ballistic/shotgun/winchester
	validParts = list(
		/obj/item/part/gun/frame/winchester,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/shotgun,
		/obj/item/part/gun/modular/barrel/shotgun
		)

/datum/lathe_recipe/gun/winchester
	result = /obj/item/gun/ballistic/shotgun/winchester/mk1
	validParts = list(
		/obj/item/part/gun/frame/winchester/mk1,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/shotgun,
		/obj/item/part/gun/modular/barrel/shotgun
		)

/datum/lathe_recipe/gun/m1911
	result = /obj/item/gun/ballistic/automatic/pistol/m1911
	validParts = list(
		/obj/item/part/gun/frame/m1911,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism,
		/obj/item/part/gun/modular/barrel
		)

/datum/lathe_recipe/gun/tec9
	result = /obj/item/gun/ballistic/automatic/pistol/tec9
	validParts = list(
		/obj/item/part/gun/frame,
		/obj/item/part/gun/modular/grip,
		/obj/item/part/gun/modular/mechanism,
		/obj/item/part/gun/modular/barrel
		)
/datum/lathe_recipe/gun/boltaction
	result	= /obj/item/gun/ballistic/rifle/boltaction
