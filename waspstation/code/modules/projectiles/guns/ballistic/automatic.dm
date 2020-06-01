/obj/item/gun/ballistic/automatic/terraar
	name = "TerraGov assault rifle"
	desc = "An assault rifle used by the elite forces of TerraGov. Uses 7.62 FMJ rounds that have a unique design to TerraGov."
	icon_state = "terraar"
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/terraar
	fire_delay = 1
	can_suppress = FALSE
	burst_size = 3
	actions_types = list()
	can_bayonet = FALSE
	mag_display = TRUE
	
/obj/item/gun/ballistic/automatic/pistol/commander
	name = "\improper Commander"
	desc = "A modification on the classic 1911 handgun, this one is chambered in 9mm. Much like its predecessor, it suffers from low capacity."
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	icon_state = "commander"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/co9mm
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/commander/no_mag
	spawnwithmagazine = FALSE
