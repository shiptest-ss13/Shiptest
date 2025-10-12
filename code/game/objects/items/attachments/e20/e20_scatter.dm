/obj/item/attachment/e20mod
	name = "Generic E-20 Mod"
	desc = "Basetype you probably shouldnt see."
	icon = 'icons/obj/guns/manufacturer/eoehoma/e20_attachment_obj.dmi'
	icon_state = "silencer"

	var/gun_icon_state = "e20"
	var/add_desc = "It seems to have been modified with an scattershot mod, scattering the lasers in a radius in exchange for large damage dropoff"

/obj/item/attachment/e20mod/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.desc = (gun::desc + "\n" + span_notice(add_desc))
	gun.base_icon_state = gun_icon_state
	gun.item_state = gun_icon_state
	gun.icon_state = gun_icon_state
	gun.update_appearance()

//hard coding the values like this is bad practice, however, the one gun that should have this anyways is the E-20, so I can't be assed
/obj/item/attachment/e20mod/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.desc = gun::desc
	gun.base_icon_state = "e20"
	gun.item_state = "e20"
	gun.icon_state = "e20"
	gun.update_appearance()

/obj/item/attachment/e20mod/scatter
	name = "E-20 Scattershot mod"
	desc = "A mod for the E-20 that scatters the lasers in a radius in exchange for large damage dropoff."

	icon_state = "e20_scatter"
	gun_icon_state = "e20_scatter"
	add_desc = "It seems to have been modified with an scattershot mod, scattering the lasers in a radius in exchange for large damage dropoff"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 4
	spread_unwielded_mod = 10
	wield_delay = -0.2 SECONDS

/obj/item/attachment/e20mod/scatter/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/scatter/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/mining)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()


/obj/item/attachment/e20mod/heavy
	name = "E-20 Heavy Emitter mod"
	desc = "A mod for the E-20 that overclocks the plasma emitters, causing the resulting blast to be extremely damaging. Related to the E-50, and may even contain parts from it."

	icon_state = "e20_heavy"
	gun_icon_state = "e20_scatter"
	add_desc = "It seems to have been modified with an overclock mod, making the weapon extremely damaging in exchange for extreme inefficency"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 0
	spread_unwielded_mod = 10
	wield_delay = 0.1 SECONDS

/obj/item/attachment/e20mod/heavy/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma/heavy)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/heavy/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/mining)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()


/obj/item/attachment/e20mod/efficency
	name = "E-20 Rapid Efficency mod"
	desc = "A mod for the E-20 that makes the plasma heater less powerful, causing the resulting blast to be less damaging. Related to the E-50, and may even contain parts from it."

	icon_state = "e20_heavy"
	gun_icon_state = "e20_scatter"
	add_desc = "It seems to have been modified with an overclock mod, making the weapon extremely damaging in exchange for extreme inefficency"

	allow_icon_state_prefixes = TRUE
	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 0
	spread_unwielded_mod = 10
	wield_delay = 0.1 SECONDS

/obj/item/attachment/e20mod/heavy/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma/heavy)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/heavy/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/mining)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()
