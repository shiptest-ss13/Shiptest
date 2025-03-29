/obj/item/mecha_parts/weapon_bay
	name = "weapon bay"
	desc = "A compartment that allows a civilian exosuit to equip one weapon."
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_weapon_bay"

/obj/item/mecha_parts/weapon_bay/try_attach_part(mob/user, obj/mecha/M)
	if(istype(M, /obj/mecha/combat))
		to_chat(user, "<span class='warning'>[M] can already hold weapons!</span>")
		return
	if(locate(/obj/item/mecha_parts/weapon_bay) in M.contents)
		to_chat(user, "<span class='warning'>[M] already has a weapon bay!</span>")
		return
	..()

/obj/item/mecha_parts/weapon_bay/concealed
	name = "concealed weapon bay"
	desc = "A compartment that allows a civilian exosuit to equip one weapon while hiding the weapon from plain sight."
