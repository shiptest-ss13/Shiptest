/obj/item/attachment/gun/energy
	name = "energy underbarrel gun"
	desc = "An energy underbarrel gun. It shoots energy. Or something."
	weapon_type = /obj/item/gun/energy/e_gun/mini

/obj/item/attachment/gun/energy/Initialize()
	. = ..()
	attached_energy_gun = attached_gun

/obj/item/attachment/gun/energy/on_attacked(obj/item/gun/gun, mob/user, obj/item)
	if(toggled)
		attached_energy_gun.attacked_by(item, user)

/obj/item/attachment/gun/energy/get_cell()
	return attached_gun.cell
