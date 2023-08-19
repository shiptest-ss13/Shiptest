/datum/job/janitor
	name = "Janitor"
	total_positions = 2
	spawn_positions = 1
	wiki_page = "Janitor" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/janitor

	access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_JANITOR

/datum/outfit/job/janitor
	name = "Janitor"
	job_icon = "janitor"
	jobtype = /datum/job/janitor

	belt = /obj/item/pda/janitor
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/civilian/janitor
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/janitor/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(GARBAGEDAY in SSevents.holidays)
		l_pocket = /obj/item/gun/ballistic/revolver
		r_pocket = /obj/item/ammo_box/a357

/datum/outfit/job/janitor/maid
	name = "Maid"
	uniform = /obj/item/clothing/under/rank/civilian/janitor/maid
