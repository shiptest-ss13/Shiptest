// 7.62x38mmR (Nagant Revolver)

/obj/projectile/bullet/n762
	name = "7.62x38mmR bullet"
	damage = 30
	armour_penetration = -20

// .50AE (Desert Eagle)

/obj/projectile/bullet/a50AE
	name = ".50 AE bullet"
	damage = 40

/obj/projectile/bullet/a50AE/hp
	name = ".50 AE hollow point bullet"
	damage = 60
	armour_penetration = -50

// .38 (Detective's Gun & Winchester)

/obj/projectile/bullet/c38
	name = ".38 bullet"
	damage = 20
	armour_penetration = -20
	ricochets_max = 2
	ricochet_chance = 50
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 3

/obj/projectile/bullet/c38/match
	name = ".38 match bullet"
	ricochets_max = 4
	ricochet_chance = 100
	ricochet_auto_aim_angle = 40
	ricochet_auto_aim_range = 5
	ricochet_incidence_leeway = 50
	ricochet_decay_chance = 1
	ricochet_decay_damage = 1

/obj/projectile/bullet/c38/match/bouncy
	name = ".38 rubber bullet"
	damage = 10
	stamina = 30
	ricochets_max = 6
	ricochet_incidence_leeway = 70
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	shrapnel_type = NONE

/obj/projectile/bullet/c38/dumdum
	name = ".38 dum-dum bullet"
	damage = 15
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
	name = ".38 hot shot bullet"
	damage = 20
	ricochets_max = 0

/obj/projectile/bullet/c38/hotshot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()

/obj/projectile/bullet/c38/iceblox //see /obj/projectile/temp for the original code
	name = ".38 iceblox bullet"
	damage = 20
	var/temperature = 100
	ricochets_max = 0

/obj/projectile/bullet/c38/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

// .357 (Syndie Revolver)

/obj/projectile/bullet/a357
	name = ".357 bullet"
	damage = 30 //shiptest nerf

// admin only really, for ocelot memes
/obj/projectile/bullet/a357/match
	name = ".357 match bullet"
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a357/hp
	name = ".357 hollow point bullet"
	damage = 50
	armour_penetration = -50
	ricochet_chance = 0 //mushroom on impact, no bounces

// .45-70 Gov't (Hunting Revolver)

/obj/projectile/bullet/a4570
	name = ".45-70 bullet"
	damage = 40 //crits in 3-4 taps depending on armor

/obj/projectile/bullet/a4570/match
	name = ".45-70 match bullet"
	ricochets_max = 5
	ricochet_chance = 140
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/obj/projectile/bullet/a4570/hp
	name = ".45-70 hollow point bullet"
	damage = 60 //it's the pre-nerf .357 with less armor pen
	armour_penetration = -50

/obj/projectile/bullet/a4570/explosive //for extra oof
	name = ".45-70 explosive bullet"
	dismemberment = 50 //literally blow limbs off

/obj/projectile/bullet/a4570/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT
