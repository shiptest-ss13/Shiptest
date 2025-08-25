/obj/item/ammo_casing/energy
	name = "energy weapon lens"
	desc = "The part of the gun that makes the laser go pew."
	caliber = "energy"
	projectile_type = /obj/projectile/energy
	var/e_cost = 1000 //The amount of energy a cell needs to expend to create this shot.
	var/select_name = "energy"
	resistance_flags = INDESTRUCTIBLE
	fire_sound = 'sound/weapons/gun/laser/nt-fire.ogg'
	heavy_metal = FALSE
	delay = 5
