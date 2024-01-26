/datum/lathe_recipe
	var/obj/item/result = /obj/item/gun

/datum/lathe_recipe/gun
	var/list/validParts = list()
	var/requiredPartTypes = ALL

/datum/lathe_recipe/gun/winchester
	result = /obj/item/gun/ballistic/shotgun/winchester
	validParts = list(
		/obj/item/part/gun/frame/mk1,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/shotgun,
		/obj/item/part/gun/modular/barrel/shotgun
		)

/datum/lathe_recipe/gun/winchester
	result = /obj/item/gun/ballistic/shotgun/winchester
	validParts = list(
		/obj/item/part/gun/frame/mk1,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/shotgun,
		/obj/item/part/gun/modular/barrel/shotgun
		)



