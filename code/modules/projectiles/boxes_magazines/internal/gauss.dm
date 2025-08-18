/obj/item/ammo_box/magazine/internal/claris
	name = "claris internal magazine"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	caliber = "pellet"
	max_ammo = 22
	instant_load = TRUE

/obj/item/ammo_box/magazine/internal/rail
	name = "rail cannon internal mag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance/rail
	caliber = "lance"
	max_ammo = 1
	instant_load = TRUE

/obj/item/ammo_casing/caseless/gauss/lance/rail
	name = "ferromagnetic lance"
	desc = "A sharp metal rod."
	caliber = "lance"
	icon_state = "magspear"
	projectile_type = /obj/projectile/bullet/p50/rail
	auto_rotate = TRUE
	energy_cost = 166

/obj/projectile/bullet/p50/rail
	name = "Iron-tungsten rod"
	icon_state = "sabot"

/obj/projectile/bullet/p50/rail/on_hit(atom/target, blocked)
	. = ..()
	if(ismovable(target) && isliving(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, dir)
		M.throw_at(throw_target, 4, 2)
