/*
Lieutenant
*/

/datum/job/lieutenant
  title = "Lieutenant"
  flag = LT
  department_flag = ENGSEC
  faction = "Station"
  total_positions = 1
  spawn_positions = 1
  supervisors = "captain, head of personnel, and command personnel"
  selection_color = "#ddddff"
  req_admin_notify = 1
  special_notice = "You are NOT security. Your job is to protect the Captain and Heads of Staff."
  minimal_player_age = 7
  exp_requirements = 180
  exp_type = EXP_TYPE_CREW
  exp_type_department = EXP_TYPE_SECURITY

  outfit = /datum/outfit/job/lieutenant

  access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_HOP,
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_EVA, ACCESS_HEADS,
			            ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_CONSTRUCTION,
			            ACCESS_CARGO, ACCESS_RESEARCH, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_LIEUTENANT)
  minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS,
                  ACCESS_RESEARCH, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_HEADS, ACCESS_LIEUTENANT, ACCESS_WEAPONS)

  display_order = JOB_DISPLAY_ORDER_LIEUTENANT

/datum/outfit/job/lieutenant
  name = "Lieutenant"
  jobtype = /datum/job/lieutenant

  id = /obj/item/card/id/silver
  head = /obj/item/clothing/head/beret/lt
  uniform = /obj/item/clothing/under/rank/command/lieutenant
  alt_uniform = /obj/item/clothing/under/rank/command
  dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain
  gloves = /obj/item/clothing/gloves/combat
  shoes = /obj/item/clothing/shoes/jackboots
  ears = /obj/item/radio/headset/heads/lieutenant/alt
  glasses = /obj/item/clothing/glasses/hud/health/sunglasses
  belt = /obj/item/pda/lieutenant

  implants = list(/obj/item/implant/mindshield)

  backpack = /obj/item/storage/backpack/security
  satchel = /obj/item/storage/backpack/satchel/sec
  duffelbag = /obj/item/storage/backpack/duffelbag/sec
  courierbag = /obj/item/storage/backpack/messenger/sec

  backpack_contents = list(
    /obj/item/gun/energy/e_gun/lieutenant = 1
  )
