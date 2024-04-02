/datum/lathe_recipe
	var/result
	var/list/steps = list()
	var/time = 30 //time in deciseconds

/datum/lathe_recipe/part
	var/list/reqs = list(/obj/item/stack/sheet/metal = 3)

/datum/lathe_recipe/part/frame
	result = /obj/item/part/gun/frame

/datum/lathe_recipe/part/grip/wood
	result = /obj/item/part/gun/modular/grip/wood
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3)

/datum/lathe_recipe/part/barrel/revolver
	result = /obj/item/part/gun/modular/barrel/revolver
	reqs = list(/obj/item/stack/sheet/metal = 2)

/datum/lathe_recipe/part/mechanism/revolver
	result = /obj/item/part/gun/modular/mechanism/revolver
	reqs = list(/obj/item/stack/sheet/metal = 2,
			/obj/item/stack/gun_part = 2)

/datum/lathe_recipe/part/frame/revolver
	result = /obj/item/part/gun/frame/revolver
	reqs = list(/obj/item/stack/sheet/metal = 2)

/datum/lathe_recipe/gun
	var/list/valid_parts = list()
	var/required_part_types = ALL

/datum/lathe_recipe/gun/candor
	result = /obj/item/gun/ballistic/automatic/pistol/candor
	valid_parts = list(
		/obj/item/part/gun/frame/pistol/candor,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/pistol,
		/obj/item/part/gun/modular/barrel/pistol
		)

/datum/lathe_recipe/gun/montagne
	result = /obj/item/gun/ballistic/revolver/montagne
	valid_parts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/ashhand
	result = /obj/item/gun/ballistic/revolver/ashhand
	valid_parts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/firebrand
	result = /obj/item/gun/ballistic/revolver/firebrand
	valid_parts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)

/datum/lathe_recipe/gun/shadow
	result = /obj/item/gun/ballistic/revolver/shadow
	valid_parts = list(
		/obj/item/part/gun/frame/revolver,
		/obj/item/part/gun/modular/grip/wood,
		/obj/item/part/gun/modular/mechanism/revolver,
		/obj/item/part/gun/modular/barrel/revolver
		)
