/obj/item/ammo_casing/caseless/gauss
	name = "ferromagnetic pellet"
	desc = "A small metal pellet."
	caliber = "pellet"
	icon_state = "gauss-pellet"
	projectile_type = /obj/projectile/bullet/gauss
	auto_rotate = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/gauss
	var/energy_cost = 100

/obj/item/ammo_casing/caseless/gauss/lance
	name = "ferromagnetic lance"
	desc = "A sharp metal rod."
	caliber = "lance"
	icon_state = "gauss-lance"
	projectile_type = /obj/projectile/bullet/gauss/lance
	auto_rotate = TRUE
	energy_cost = 166

/obj/item/ammo_casing/caseless/gauss/slug
	name = "ferromagnetic slug"
	desc = "A large metal slug."
	caliber = "slug"
	icon_state = "gauss-slug"
	projectile_type = /obj/projectile/bullet/gauss/slug
	auto_rotate = TRUE
	energy_cost = 700
