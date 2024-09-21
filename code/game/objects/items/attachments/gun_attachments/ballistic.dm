/obj/item/attachment/gun/ballistic
	name = "ballistic underbarrel gun"
	desc = "A ballistic underbarrel gun. It shoots bullets. Or something."

/obj/item/attachment/gun/ballistic/Initialize()
	. = ..()
	attached_ballistic_gun = attached_gun

/obj/item/attachment/gun/ballistic/on_attacked(obj/item/gun/gun, mob/user, obj/item)
	if(toggled)
		attached_ballistic_gun.attacked_by(item, user)
