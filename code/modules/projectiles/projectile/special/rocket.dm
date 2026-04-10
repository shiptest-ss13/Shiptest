/obj/projectile/bullet/a84mm
	name ="\improper HEDP rocket"
	desc = "USE A WEEL GUN"
	icon_state= "84mm-hedp"
	damage = 80
	var/anti_armour_damage = 120
	armour_penetration = 100
	dismemberment = 30

	var/devastation = 0
	var/range_heavy= 1
	var/heavy_damage = EX_HEAVY_BASE_DAM
	var/heavy_item_damage = EX_HEAVY_BASE_ITEM_DAM
	var/range_light = 2
	var/light_damage = EX_LIGHT_BASE_DAM
	var/light_item_damage = EX_LIGHT_BASE_ITEM_DAM
	var/flame_range = 4


/obj/projectile/bullet/a84mm/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, devastation, range_heavy, range_light, 1, 0, flame_range = flame_range,\
	light_dam = light_damage, light_item_dam = light_item_damage, heavy_dam = heavy_damage, heavy_item_dam = heavy_item_damage)

	if(anti_armour_damage)
		if(ismecha(target))
			var/obj/mecha/M = target
			M.take_damage(anti_armour_damage)
		if(issilicon(target))
			var/mob/living/silicon/S = target
			S.take_overall_damage(anti_armour_damage*0.75, anti_armour_damage*0.25)
	return BULLET_ACT_HIT

/obj/projectile/bullet/a84mm/he
	name ="\improper HE missile"
	desc = "Boom."
	icon_state = "missile"
	damage = 30
	anti_armour_damage = 0
	light_range = 4
	ricochets_max = 0 //it's a MISSILE

/obj/projectile/bullet/a84mm/he/weak
	name ="\improper Light HE missile"
	desc = "Boom."
	icon_state = "missile-light"
	dismemberment = 0
	damage = 20
	heavy_damage = 40
	heavy_item_damage = 40
	light_damage = 25
	light_item_damage = 20

/obj/projectile/bullet/a84mm_br
	name ="\improper HE missile"
	desc = "Boom."
	icon_state = "missile"
	damage = 30
	ricochets_max = 0 //it's a MISSILE
	var/sturdy = list(
	/turf/closed,
	/obj/mecha,
	/obj/machinery/door/,
	/obj/machinery/door/poddoor/shutters
	)

/obj/item/broken_missile
	name = "\improper broken missile"
	desc = "A missile that did not detonate. The tail has snapped and it is in no way fit to be used again."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "missile_broken"
	w_class = WEIGHT_CLASS_TINY


/obj/projectile/bullet/a84mm_br/on_hit(atom/target, blocked=0)
	..()
	for(var/i in sturdy)
		if(istype(target, i))
			explosion(target, 1, 1, 1, 2)
			return BULLET_ACT_HIT
	//if(istype(target, /turf/closed) || ismecha(target))
	new /obj/item/broken_missile(get_turf(src), 1)
