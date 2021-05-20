/obj/item/gun/energy/e_gun/adv_stopping
	name = "advanced stopping revolver"
	desc = "An advanced energy revolver with the capacity to shoot both disabler and lethal lasers, as well as futuristic safari nets."
	icon = 'whitesands/icons/obj/guns/energy.dmi'
	icon_state = "bsgun"
	item_state = "gun"
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/trap)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/smg
	name = "\improper E-TAR SMG"
	desc = "A single-mode energy gun capable of discharging weaker shots at a much faster rate than the standard energy gun."
	icon = 'whitesands/icons/obj/guns/energy.dmi'
	icon_state = "esmg"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/weak)
	ammo_x_offset = 2
	fire_rate = 5
	charge_sections = 3
	automatic = 1
	weapon_weight = WEAPON_LIGHT
