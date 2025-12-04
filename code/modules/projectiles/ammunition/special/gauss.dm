/obj/item/ammo_casing/caseless/gauss
	name = "ferromagnetic pellet"
	desc = "A small metal pellet."
	caliber = "pellet"
	icon_state = "gauss-pellet"
	projectile_type = /obj/projectile/bullet/gauss
	auto_rotate = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/gauss
	var/energy_cost = 100

/obj/item/ammo_casing/caseless/gauss/hc
	name = "high conductivity pellet"
	desc = "A small crystal-metal pellet."
	caliber = "pellet"
	icon_state = "hc-pellet"
	projectile_type = /obj/projectile/bullet/gauss/hc
	auto_rotate = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/gauss
	energy_cost = 200

/obj/item/ammo_casing/caseless/gauss/lance
	name = "ferromagnetic lance"
	desc = "A sharp metal rod."
	caliber = "lance"
	icon_state = "gauss-lance"
	projectile_type = /obj/projectile/bullet/gauss/lance
	auto_rotate = TRUE
	energy_cost = 155

/obj/item/ammo_casing/caseless/gauss/lance/hc
	name = "high conductivity lance"
	desc = "A sharp crystal-metal lance."
	caliber = "lance"
	icon_state = "hc-lance"
	projectile_type = /obj/projectile/bullet/gauss/lance/hc
	auto_rotate = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/gauss
	energy_cost = 233

/obj/item/ammo_casing/caseless/gauss/slug
	name = "ferromagnetic slug"
	desc = "A large metal slug."
	caliber = "slug"
	icon_state = "gauss-slug"
	projectile_type = /obj/projectile/bullet/gauss/slug
	auto_rotate = TRUE
	energy_cost = 700

/obj/item/ammo_casing/caseless/gauss/slug/hc
	name = "high conductivity slug"
	desc = "A large crystal-metal slug."
	caliber = "slug"
	icon_state = "hc-slug"
	projectile_type = /obj/projectile/bullet/gauss/slug/hc
	auto_rotate = FALSE
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/gauss
	energy_cost = 1400
