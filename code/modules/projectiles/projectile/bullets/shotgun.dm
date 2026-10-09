/obj/projectile/bullet/slug
	name = "12g shotgun slug"
	damage = 40
	armour_penetration = 10
	speed = BULLET_SPEED_SHOTGUN
	bullet_identifier = "large slug"

/obj/projectile/bullet/slug/beanbag
	name = "beanbag slug"
	damage = 10
	stamina = 60
	armour_penetration = -45

/obj/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = 25
	armour_penetration = -10
	speed = BULLET_SPEED_SHOTGUN

/obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = 8
	armour_penetration = -35

/obj/projectile/bullet/slug/stun
	name = "stunslug"
	damage = 5
	paralyze = 100
	stutter = 5
	jitter = 20 SECONDS
	range = 7
	icon_state = "spark"
	color = "#FFFF00"

/obj/projectile/bullet/slug/meteor
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = 30
	paralyze = 15
	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/projectile/bullet/slug/meteor/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/projectile/bullet/slug/meteor/Initialize()
	. = ..()
	SpinAnimation()

/obj/projectile/bullet/slug/frag12
	name = "frag12 slug"
	damage = 25
	paralyze = 20

/obj/projectile/bullet/slug/frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 2, light_dam = 30)
	return BULLET_ACT_HIT

/obj/projectile/bullet/pellet
	///How much damage is subtracted per tile?
	var/tile_dropoff = 1 //Standard of 10% per tile
	///How much stamina damage is subtracted per tile?
	var/tile_dropoff_stamina = 1.5 //As above

	var/ap_dropoff = 5
	var/ap_dropoff_cutoff = -25

	icon_state = "pellet"
	armour_penetration = -10
	speed = BULLET_SPEED_SHOTGUN
	bullet_identifier = "pellet"

/obj/projectile/bullet/pellet/buckshot
	name = "buckshot pellet"
	damage = 13

/obj/projectile/bullet/pellet/rubbershot
	name = "rubbershot pellet"
	damage = 2.5
	tile_dropoff = 0.15
	stamina = 15
	armour_penetration = -35
	bullet_identifier = "rubber pellet"

/obj/projectile/bullet/pellet/rubbershot/incapacitate
	name = "incapacitating pellet"
	damage = 1
	tile_dropoff = 0.1
	stamina = 6
	tile_dropoff_stamina = 0.6

/obj/projectile/bullet/pellet/Range() //10% loss per tile = max range of 10, generally
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_stamina
	if(armour_penetration > ap_dropoff_cutoff)
		armour_penetration -= ap_dropoff
	if(accuracy_mod < 3)
		accuracy_mod += 0.3
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/improvised
	damage = 6
	armour_penetration = -60
	tile_dropoff = 0.6

// Mech Scattershot

/obj/projectile/bullet/pellet/scattershot
	damage = 24
	armour_penetration = -20

/obj/projectile/bullet/pellet/buckshot/twobore
	name = "two-bore pellet"
	damage = 30
	armour_penetration = 20
	tile_dropoff = 3
	bullet_identifier = "massive pellet"

/obj/projectile/bullet/pellet/blank
	name = "blank"
	damage = 30
	range = 2
	armour_penetration = -70
	bullet_identifier = "\improper shockwave"

/obj/projectile/bullet/pellet/fourbore
	name = "four-bore pellet"
	damage = 20
	armour_penetration = 10
	bullet_identifier = "huge pellet"
	tile_dropoff = 3

/obj/projectile/bullet/pellet/fourbore/shrapnel
	name = "four-bore shrapnel pellet"
	damage = 13
	armour_penetration = -10
	bullet_identifier = "small pellet"


/obj/projectile/bullet/slug/fourbore
	name = "four-bore shotgun slug"
	damage = 50
	armour_penetration = 20
	speed = BULLET_SPEED_SHOTGUN
	bullet_identifier = "huge slug"
	wall_damage_override = 400
	demolition_mod = 5
	wall_damage_flags = PROJECTILE_BONUS_DAMAGE_WALLS | PROJECTILE_BONUS_DAMAGE_RWALLS

/obj/projectile/bullet/slug/fourbore/flashbang
	name = "four-bore flashbang shell"
	damage = 25
	speed = BULLET_SPEED_SHOTGUN
	bullet_identifier = "huge shell"
	wall_damage_override = null
	demolition_mod = 0
	var/flashbang_range = 4;
/obj/projectile/bullet/slug/fourbore/flashbang/on_hit(atom/target, blocked = 0)
	var/turf/flashbang_turf = get_turf(target) || get_turf(src)
	if(flashbang_turf)
		do_sparks(rand(5, 9), FALSE, src)
		playsound(flashbang_turf, 'sound/weapons/flashbang.ogg', 100, TRUE, 8, 0.9)
	new /obj/effect/dummy/lighting_obj(flashbang_turf, flashbang_range + 2, 4, COLOR_WHITE, 2)
	for(var/mob/living/M in get_hearers_in_view(flashbang_range, flashbang_turf))
		M.flash_act(1, 1)
	return ..()


/obj/projectile/bullet/slug/fourbore/teargas
	name = "four-bore teargas shell"
	damage = 25
	speed = BULLET_SPEED_SHOTGUN
	bullet_identifier = "huge shell"
	wall_damage_override = null
	demolition_mod = 0
/obj/projectile/bullet/slug/fourbore/teargas/on_hit(atom/target, blocked = 0)
	var/turf/target_turf = get_turf(target) || get_turf(src)
	if(!target_turf)
		return
	if(target_turf.density)
		var/atom/origin = firer || starting
		if(origin)
			target_turf = get_step_towards(target_turf, origin)
	var/obj/item/grenade/chem_grenade/G = new(target_turf)
	G.stage = GRENADE_READY
	var/obj/item/reagent_containers/glass/beaker/large/B1 = new(G)
	var/obj/item/reagent_containers/glass/beaker/large/B2 = new(G)
	//This is like 1/8 of a normal teargas grenade btw
	B1.reagents.add_reagent(/datum/reagent/consumable/condensedcapsaicin, 4)
	B1.reagents.add_reagent(/datum/reagent/potassium, 2)
	B2.reagents.add_reagent(/datum/reagent/phosphorus, 2)
	B2.reagents.add_reagent(/datum/reagent/consumable/sugar, 2)
	G.beakers += B1
	G.beakers += B2
	G.prime()
	return ..()
