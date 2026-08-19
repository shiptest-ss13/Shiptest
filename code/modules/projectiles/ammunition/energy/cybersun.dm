/* Contains ionization, lorentz, and plasmaflare fire modes */

/obj/item/ammo_casing/energy/ionization
	name = "ionization lens"
	caliber = "ionization"
	projectile_type = /obj/projectile/beam/ionization
	e_cost = 1000
	select_name = "ionization"
	fire_sound = 'sound/weapons/gun/cybersun/ionization.ogg'
	delay = 4

/obj/item/ammo_casing/energy/ionization/sniper
	name = "far-reach ionization lens"
	caliber = "ionization"
	projectile_type = /obj/projectile/beam/ionization
	e_cost = 1000
	select_name = "far-reach ionization"
	fire_sound = 'sound/weapons/gun/cybersun/heavy_ionization.ogg'
	delay = 4


/* look @ firing logic to do the return thing */
//to-do: kill self
/obj/item/ammo_casing/energy/lorentz
	name = "lorentz force lens"
	caliber = "lorentz"
	projectile_type = /obj/projectile/beam/lorentz
	e_cost = 1000
	select_name = "lorentz"
	fire_sound = 'sound/weapons/gun/cybersun/lorentz.ogg'
	delay = 4

/obj/item/ammo_casing/energy/lorentz/scatter
	name = "scatter lorentz lens"
	projectile_type = /obj/projectile/beam/lorentz
	e_cost = 1000
	select_name = "lorentz pulse"
	fire_sound = 'sound/weapons/gun/cybersun/lorentz.ogg'
	delay = 4
	pellets = 6
	variance = 4

//gun needs to dynamically set e_cost to whatever's left in the cell
/obj/item/ammo_casing/energy/flare
	name = "plasma flare lens"
	caliber = "flare"
	projectile_type = /obj/projectile/beam/flare
	e_cost = 0
	select_name = "plasma flare"
	fire_sound = 'sound/weapons/gun/cybersun/lorentz.ogg'
	delay = 4
