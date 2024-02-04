/datum/lathe_recipe
	var/result
	var/list/steps = list()
	var/time = 30 //time in deciseconds

/datum/lathe_recipe/part
	var/list/reqs = list(/obj/item/stack/sheet/metal = 3)

/datum/lathe_recipe/part/frame
	result = /obj/item/part/gun/frame

/datum/lathe_recipe/part/frame/winchester
	result = /obj/item/part/gun/frame/winchester

/datum/lathe_recipe/part/grip/wood
	result = /obj/item/part/gun/modular/grip/wood
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)

/datum/lathe_recipe/part/mechanism/shotgun
	result = /obj/item/part/gun/modular/mechanism/shotgun
	reqs = list(/obj/item/stack/sheet/metal = 2,
			/obj/item/stack/gun_part = 1)

/datum/lathe_recipe/part/barrel/shotgun
	result = /obj/item/part/gun/modular/barrel/shotgun

/datum/lathe_recipe/gun
	var/list/validParts = list()
	var/requiredPartTypes = ALL

/datum/lathe_recipe/gun/winchester
	result = /obj/item/gun/ballistic/shotgun/winchester
	validParts = list(
		/obj/item/part/gun/frame/winchester,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/rifle,
		/obj/item/part/gun/modular/barrel/rifle
		)

/datum/lathe_recipe/gun/winchester/mk1
	result = /obj/item/gun/ballistic/shotgun/winchester/mk1
	validParts = list(
		/obj/item/part/gun/frame/winchester/mk1,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/rifle,
		/obj/item/part/gun/modular/barrel/rifle
		)

/datum/lathe_recipe/gun/m1911
	result = /obj/item/gun/ballistic/automatic/pistol/m1911
	validParts = list(
		/obj/item/part/gun/frame/m1911,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/pistol,
		/obj/item/part/gun/modular/barrel/pistol
		)

/datum/lathe_recipe/gun/tec9
	result = /obj/item/gun/ballistic/automatic/pistol/tec9
	validParts = list(
		/obj/item/part/gun/frame/tec9,
		/obj/item/part/gun/modular/grip/black,
		/obj/item/part/gun/modular/mechanism/pistol,
		/obj/item/part/gun/modular/barrel/pistol
		)

/datum/lathe_recipe/gun/boltaction
	result	= /obj/item/gun/ballistic/rifle/boltaction
	validParts = list(
		/obj/item/part/gun/frame/boltaction,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/rifle,
		/obj/item/part/gun/modular/barrel/rifle
		)

/datum/lathe_recipe/gun/doublebarrel
	result = /obj/item/gun/ballistic/shotgun/doublebarrel
	validParts = list(
		/obj/item/part/gun/frame/shotgun,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/shotgun,
		/obj/item/part/gun/modular/barrel/shotgun
		)

/datum/lathe_recipe/gun/derringer
	result = /obj/item/gun/ballistic/derringer
	validParts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/srmrevolver
	result = /obj/item/gun/ballistic/revolver/srm
	validParts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/pepperbox
	result = /obj/item/gun/ballistic/revolver/pepperbox
	validParts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/nagantrevolver
	result = /obj/item/gun/ballistic/revolver/nagant
	validParts = list(
		/obj/item/part/gun/frame,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism,
		/obj/item/part/gun/modular/barrel
		)

/datum/lathe_recipe/gun/nagantrifle
	result = /obj/item/gun/ballistic/rifle/boltaction
	validParts = list(
		/obj/item/part/gun/frame,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism,
		/obj/item/part/gun/modular/barrel
		)
