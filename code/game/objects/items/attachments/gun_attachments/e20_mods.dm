/obj/item/attachment/e20mod
	name = "e-20 modification kit"
	desc = "This is a basetype item and you should not see this."
	icon = 'icons/obj/guns/manufacturer/eoehoma/e20_attachment_obj.dmi'
	icon_state = "e20mod"
	attach_features_flags = null
	attach_sound = 'sound/items/drill_use.ogg'
	bad_type = /obj/item/attachment/e20mod

	var/gun_icon_state = "e20"
	var/add_desc = "It appears to be completely fucking evil. What the hell?"

/obj/item/attachment/e20mod/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	if(!.)
		return FALSE
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
	name = "E-20 scattershot mod"
	desc = "An aftermarket modification kit for the E-20 mining emitter. Contains a custom lens assembly that makes the device fire a large scatter of small lasers."

	icon_state = "e20_scatter"
	gun_icon_state = "e20_scatter"
	add_desc = "It has been modified with a scattershot mod, and will fire a large spread of small lasers."

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
	name = "E-20 overclock mod"
	desc = "An aftermarket modification kit for the E-20 mining emitter. Contains a high-powered replacement for the charging electronics, which makes the device fire devastating beams at poor efficiency."

	icon_state = "e20_heavy"
	gun_icon_state = "e20_heavy"
	add_desc = "It has a set of overclocked electronics installed, and will fire devastating beams that use an extremely large amount of power."

	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 0
	spread_unwielded_mod = 10
	wield_delay = 0.1 SECONDS

/obj/item/attachment/e20mod/heavy/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e20_heavy)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/heavy/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e20_heavy)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()


/obj/item/attachment/e20mod/efficiency
	name = "E-20 yellowjacket mod"
	desc = "An aftermarket modification kit for the E-20 mining emitter. Contains an assortment of parts from a Wasp hooked up to an adapter, allowing the device to fire off many more shots at the cost of its mining abilities."

	icon_state = "e20_efficency"
	gun_icon_state = "e20_efficency"
	add_desc = "It has been modified with a \"Yellowjacket\" kit, allowing it to shoot many more shots at the cost of its mining power."

	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 0
	spread_unwielded_mod = 10
	wield_delay = 0.1 SECONDS

/obj/item/attachment/e20mod/efficiency/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma/wasp)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/efficiency/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/mining)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/pierce
	name = "E-20 piercer mod"
	desc = "An aftermarket conversion kit for the E-20 mining emitter. Replaces the firing assembly with an Etherbor-style laser emitter, making the device shoot a piercing beam."

	icon_state = "e20_pierce"
	gun_icon_state = "e20_pierce"
	add_desc = "It has been modified with a piercing mod, and will now shoot beams capable of punching through multiple targets."

	slot = ATTACHMENT_SLOT_MUZZLE

	spread_mod = 0
	spread_unwielded_mod = 10
	wield_delay = 0.1 SECONDS

/obj/item/attachment/e20mod/pierce/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e20_pierce)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()

/obj/item/attachment/e20mod/pierce/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	var/obj/item/gun/energy/laser/e20/our_gun = gun
	our_gun.ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e20_pierce)
	our_gun.update_ammo_types()
	gun.chambered = null
	our_gun.recharge_newshot()
	gun.update_appearance()
