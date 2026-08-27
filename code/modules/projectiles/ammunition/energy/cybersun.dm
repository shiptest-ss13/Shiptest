/* Contains ionization, lorentz, and plasmaflare fire modes */

/obj/item/ammo_casing/energy/ionization
	name = "ionization lens"
	caliber = "ionization"
	projectile_type = /obj/projectile/beam/ionization
	e_cost = 350
	select_name = "ionization"
	fire_sound = 'sound/weapons/gun/cybersun/ionization.ogg'
	delay = 4

/obj/item/ammo_casing/energy/ionization/sniper
	name = "far-reach ionization lens"
	caliber = "ionization"
	projectile_type = /obj/projectile/beam/ionization/sniper
	e_cost = 1000
	select_name = "far-reach ionization"
	fire_sound = 'sound/weapons/gun/cybersun/heavy_ionization.ogg'
	delay = 8

/obj/item/ammo_casing/energy/lorentz
	name = "lorentz lens"
	caliber = "lorentz"
	projectile_type = /obj/projectile/beam/lorentz
	e_cost = 2000

	select_name = "lorentz"
	fire_sound = 'sound/weapons/gun/cybersun/lorentz.ogg'
	delay = 0.3 SECONDS

/obj/item/ammo_casing/energy/lorentz/scatter
	name = "scatter lorentz lens"
	projectile_type = /obj/projectile/beam/lorentz/shotgun
	e_cost = 3000
	delay = 0.5 SECONDS
	pellets = 12
	variance = 12

/obj/item/ammo_casing/energy/lorentz/mg
	name = "rapid lorentz lens"
	fire_sound = 'sound/weapons/gun/cybersun/lorentz_heavy.ogg'
	delay = 0.25 SECONDS
	e_cost = 1000
	projectile_type = /obj/projectile/beam/lorentz/mg

//if you use this on a weapon that's not made for it bad things will happen
//for cybersun/lorentz use ONLY
/obj/item/ammo_casing/energy/flare
	name = "plasma flare lens"
	caliber = "flare"
	projectile_type = /obj/projectile/beam/flare
	e_cost = 1
	select_name = "flare"
	fire_sound = 'sound/weapons/gun/cybersun/plasmaflare.ogg'
	delay = 20
