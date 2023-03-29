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
	alt_uniform = /obj/item/clothing/under/rank/civilian/janitor/maid //WS Edit - Alt Uniforms
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/janitor/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(GARBAGEDAY in SSevents.holidays)
		l_pocket = /obj/item/gun/ballistic/revolver
		r_pocket = /obj/item/ammo_box/a357

/datum/outfit/job/janitor/custodian
	name = "Janitor (Custodian)"

	uniform = /obj/item/clothing/under/rank/civilian/janitor/custodian

/datum/outfit/job/janitor/sanitationtechnician
	name = "Janitor (Sanitation Technician)"

	uniform = /obj/item/clothing/under/rank/civilian/janitor/sanitation_tech

/datum/outfit/job/janitor/maid
	name = "Maid"
	uniform = /obj/item/clothing/under/rank/civilian/janitor/maid
