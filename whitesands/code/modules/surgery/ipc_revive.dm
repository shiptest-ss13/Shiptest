/*\ IPC revival surgery \*/

/datum/surgery/revival/ipc
	name = "IPC maintenance reboot"
	desc = "Manual reboot protocol to revive broken IPC units."
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/revive/ipc,
		/datum/surgery_step/mechanic_close
	)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYPART_ROBOTIC
	lying_required = FALSE

/datum/surgery/revival/ipc/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	return isipc(target)

/datum/surgery_step/revive/ipc
	name = "reboot electronics"
	implements = list(/obj/item/inducer = 100, /obj/item/shockpaddles = 80, /obj/item/melee/baton = 50, /obj/item/gun/energy = 30)
	time = 60

/datum/surgery_step/revive/ipc/tool_check(mob/user, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/inducer))
		var/obj/item/inducer/I = tool
		if(I.cantbeused(user))
			return FALSE


