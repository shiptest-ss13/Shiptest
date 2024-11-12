// .50 AE (Desert Eagle)

/obj/projectile/bullet/a50AE
	name = ".50 AE bullet"
	damage = 40

/obj/projectile/bullet/a50AE/hp
	name = ".50 AE hollow point bullet"
	damage = 55
	armour_penetration = -50

// .38 (Colt Detective Special & Winchester)

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 20
	armour_penetration = -20

/obj/projectile/bullet/c38/surplus
	damage = 15

/obj/projectile/bullet/c38/match
	name = ".38 match bullet"
	speed = 0.3
	armour_penetration = -10
	ricochets_max = 4
	ricochet_chance = 100
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

/obj/projectile/bullet/c38/match/bouncy // I don't know why this is a subtype of match
	name = ".38 rubber bullet"
	speed = 0.4
	damage = 7
	stamina = 38
	armour_penetration = -60
	ricochets_max = 6
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = NONE

/obj/projectile/bullet/c38/dumdum
	name = ".38 dum-dum bullet"
	damage = 20
	armour_penetration = -50
	ricochets_max = 0
	shrapnel_type = /obj/item/shrapnel/bullet/c38/dumdum

/obj/projectile/bullet/c38/trac
	name = ".38 TRAC bullet"
	damage = 10
	ricochets_max = 0

/obj/projectile/bullet/c38/trac/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/M = target
	if(!istype(M))
		return
	var/obj/item/implant/tracking/c38/imp
	for(var/obj/item/implant/tracking/c38/TI in M.implants) //checks if the target already contains a tracking implant
		imp = TI
		return
	if(!imp)
		imp = new /obj/item/implant/tracking/c38(M)
		imp.implant(M)

/obj/projectile/bullet/c38/hotshot //similar to incendiary bullets, but do not leave a flaming trail
	name = ".38 hearth bullet"
	ricochets_max = 0

/obj/projectile/bullet/c38/hotshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.IgniteMob()

/obj/projectile/bullet/c38/iceblox //see /obj/projectile/temp for the original code
	name = ".38 chilled bullet"
	var/temperature = 100
	ricochets_max = 0

/obj/projectile/bullet/c38/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

// .357 (Syndicate Revolver)

/obj/projectile/bullet/a357
	name = ".357 bullet"
	damage = 30

// admin only really, for ocelot memes
/obj/projectile/bullet/a357/match
	name = ".357 match bullet"
	speed = 0.3
	armour_penetration = 10
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a357/hp
	name = ".357 hollow point bullet"
	damage = 45
	armour_penetration = -20
	ricochet_chance = 0 //mushroom on impact, no bounces

// .45-70 Gov't (Hunting Revolver)

/obj/projectile/bullet/a4570
	name = ".45-70 bullet"
	damage = 45 //crits in 3-4 taps depending on armor

/obj/projectile/bullet/a4570/match
	name = ".45-70 match bullet"
	speed = 0.3
	armour_penetration = 10
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a4570/hp
	name = ".45-70 hollow point bullet"
	damage = 55 //it's ALMOST the pre-nerf .357 with less armor pen
	armour_penetration = -50

/obj/projectile/bullet/a4570/explosive //for extra oof
	name = ".45-70 explosive bullet"
	dismemberment = 50 //literally blow limbs off

/obj/projectile/bullet/a4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT


/obj/projectile/bullet/c22lr
	name = ".22LR bullet"
	damage = 20
	armour_penetration = -45
	ricochet_incidence_leeway = 20
	ricochet_chance = 65

// 44 Short (Roumain & Shadow)

/obj/projectile/bullet/a44roum
	name = ".44 roumain bullet"
	damage =  25

/obj/projectile/bullet/a44roum/rubber
	name = ".44 roumain bullet"
	damage =  7
	stamina = 38
	armour_penetration = -20

/obj/projectile/bullet/a44roum/hp
	name = ".44 roumain bullet"
	damage =  40
	armour_penetration = -20
