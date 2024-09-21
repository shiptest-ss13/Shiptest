/obj/item/attachment/gun/energy
	name = "underbarrel minature energy gun"
	desc = "A compact energy gun designed to be mounted on the underside of another firearm for quick access."
	weapon_type = /obj/item/gun/energy/e_gun/mini

/obj/item/attachment/gun/energy/Initialize()
	. = ..()
	attached_energy_gun = attached_gun

/obj/item/attachment/gun/energy/on_attacked(obj/item/gun/gun, mob/user, obj/item/attack_item)
	. = ..()
	if(toggled)
		if(attack_item.tool_behaviour == TOOL_SCREWDRIVER)
			attached_gun.screwdriver_act(user,attack_item)

/obj/item/attachment/gun/energy/get_cell()
	return attached_gun.cell
