/*
Second Officer
*/

/datum/job/second_officer
  title = "Second Officer"
  flag = SECOND_OFFICER
  department_flag = ENGSEC
  faction = "Station"
  total_positions = 1
  spawn_positions = 1
  supervisors = "captain, first officer, and command personnel"
  selection_color = "#ddddff"
  req_admin_notify = 1

  outfit = /datum/outfit/job/second_officer

  access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_FO,
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_EVA, ACCESS_HEADS,
			            ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_CONSTRUCTION,
			            ACCESS_CARGO, ACCESS_RESEARCH, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_SECOND_OFFICER)
  minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS,
                  ACCESS_RESEARCH, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_HEADS, ACCESS_SECOND_OFFICER, ACCESS_WEAPONS)

  display_order = JOB_DISPLAY_ORDER_SECOND_OFFICER

/datum/outfit/job/second_officer
  name = "Second Officer"
  jobtype = /datum/job/second_officer

  id = /obj/item/card/id/silver
  uniform = /obj/item/clothing/under/rank/civilian/second_officer
  gloves = /obj/item/clothing/gloves/combat
  shoes = /obj/item/clothing/shoes/jackboots
  ears = /obj/item/radio/headset/heads/second_officer/alt
  glasses = /obj/item/clothing/glasses/hud/health/sunglasses
  belt = /obj/item/pda/second_officer

  implants = list(/obj/item/implant/mindshield)

  backpack = /obj/item/storage/backpack/security
  satchel = /obj/item/storage/backpack/satchel/sec
  duffelbag = /obj/item/storage/backpack/duffelbag/sec
  courierbag = /obj/item/storage/backpack/messenger/sec

  backpack_contents = list(
    /obj/item/gun/energy/e_gun/second_officer = 1
  )
