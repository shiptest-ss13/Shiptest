/obj/projectile/beam
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 25
	armour_penetration = -5
	damage_type = BURN
	wound_bonus = -20
	bare_wound_bonus = 10

	hitsound = 'sound/weapons/gun/hit/energy_impact1.ogg'
	hitsound_non_living = 'sound/weapons/effects/searwall.ogg'
	hitsound_glass = 'sound/weapons/effects/searwall.ogg'
	hitsound_stone = 'sound/weapons/sear.ogg'
	hitsound_metal = 'sound/weapons/effects/searwall.ogg'
	hitsound_wood = 'sound/weapons/sear.ogg'
	hitsound_snow = 'sound/weapons/sear.ogg'

	near_miss_sound = 'sound/weapons/gun/hit/energy_miss1.ogg'
	ricochet_sound = 'sound/weapons/gun/hit/energy_ricochet1.ogg'

	bullet_identifier = "laser"

	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_system = MOVABLE_LIGHT
	light_range = 1.5
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 50	//Honk!
	ricochet_chance = 90
	reflectable = REFLECT_NORMAL

/obj/projectile/beam/throw_atom_into_space()
	return


/obj/projectile/beam/laser
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/projectile/beam/laser/light
	damage = 15

/obj/projectile/beam/laser/sharplite
	icon_state = "nt_laser"
	light_color = COLOR_BLUE_LIGHT
	damage = 25
	armour_penetration = -5

	pass_flags = PASSTABLE | PASSGRILLE //does not go through glass

	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser

	speed = 0.3

/obj/projectile/beam/weak/sharplite
	icon_state = "nt_laser_light"
	damage = 15
	speed = 0.3
	light_color = COLOR_BLUE_LIGHT
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	pass_flags = PASSTABLE | PASSGRILLE //does not go through glass


/obj/projectile/beam/laser/sharplite/dmr
	icon_state = "nt_laser_stronger"
	damage = 30
	armour_penetration = 20

/obj/projectile/beam/laser/assault/sharplite
	icon_state = "nt_laser_heavy"
	damage = 25
	armour_penetration = 20
	speed = 0.3
	wound_bonus = 0
	bare_wound_bonus = 20
	pass_flags = PASSTABLE | PASSGRILLE //does not go through glass

	light_color = COLOR_BLUE_LIGHT
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser

/obj/projectile/beam/laser/sharplite/sniper
	icon_state = "nt_laser_sniper"
	damage = 35
	armour_penetration = 30
	speed = 0.2
	wound_bonus = 0
	bare_wound_bonus = 20

/obj/projectile/beam/laser/light/sharplite
	icon_state = "nt_laser_light"
	speed = 0.4
	pass_flags = PASSTABLE | PASSGRILLE //does not go through glass

/obj/projectile/beam/laser/eoehoma
	icon_state = "heavylaser"
	damage = 35
	armour_penetration = 0
	speed = 0.8

/obj/projectile/beam/laser/eoehoma/wasp
	icon_state = "heavylaser"
	damage = 30

/obj/projectile/beam/laser/eoehoma/heavy
	icon_state = "heavylaser"
	damage = 60
	knockdown = 50
	armour_penetration = 20
	speed = 1

/obj/projectile/beam/laser/eoehoma/heavy/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(get_turf(loc),0,0,0,flame_range = 3)
	return BULLET_ACT_HIT

/obj/projectile/beam/laser/assault
	icon_state = "heavylaser"
	damage = 25
	armour_penetration = 20

/obj/projectile/beam/laser/heavylaser
	name = "heavy laser"
	icon_state = "heavylaser"
	damage = 40
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser

/obj/projectile/beam/laser/heavylaser/assault
	armour_penetration = 20

/obj/projectile/beam/laser/heavylaser/sharplite
	speed = 0.4

/obj/projectile/beam/laser/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.ignite_mob()
	else if(isturf(target))
		impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser/wall

/obj/projectile/beam/weak
	damage = 15

/obj/projectile/beam/weak/shotgun
	damage = 20
	armour_penetration = -10
	var/tile_dropoff = 1
	var/ap_dropoff = 5
	var/ap_dropoff_cutoff = -35

/obj/projectile/beam/weak/shotgun/Range() //10% loss per tile = max range of 10, generally
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(armour_penetration > ap_dropoff_cutoff)
		armour_penetration -= ap_dropoff
	if(accuracy_mod < 3)
		accuracy_mod += 0.3
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/beam/weak/shotgun/sharplite
	icon_state = "nt_laser_light"
	light_color = COLOR_BLUE_LIGHT

	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser

	speed = 0.3
	pass_flags = PASSGRILLE | PASSTABLE

/obj/projectile/beam/weaker
	damage = 10

/obj/projectile/beam/weak/low_range
	damage = 10
	range = 9

/obj/projectile/beam/weak/penetrator
	armour_penetration = 50

/obj/projectile/beam/laser/weak/negative_ap
	damage = 15
	armour_penetration = -30
	range = 9

/obj/projectile/beam/laser/weak/negative_ap/low_range
	range = 6

/obj/projectile/beam/practice
	name = "practice laser"
	damage = 0
	nodamage = TRUE

/obj/projectile/beam/practice/sharplite
	name = "practice laser"
	damage = 0
	nodamage = TRUE
	speed = 0.25

/obj/projectile/beam/laser/slug
	name = "laser slug"
	icon_state = "heavylaser"
	damage = 20
	armour_penetration = 40

/obj/projectile/beam/scatter
	name = "laser pellet"
	icon_state = "scatterlaser"
	damage = 5
	range = 7

/obj/projectile/beam/xray
	name = "\improper X-ray beam"
	icon_state = "xray"
	flag = "rad"
	damage = 15
	irradiate = 300
	range = 15
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF

	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/projectile/beam/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	damage = 30
	armour_penetration = -20
	damage_type = STAMINA
	flag = "energy"
	bullet_identifier = "disabler"
	hitsound = 'sound/weapons/tap.ogg'
	hitsound_glass = null
	hitsound_stone = null
	hitsound_metal = null
	hitsound_wood = null
	hitsound_snow = null
	eyeblur = 0
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

/obj/projectile/beam/disabler/sharplite
	icon_state = "nt_disabler"
	light_color = COLOR_PALE_ORANGE
	speed = 0.3

/obj/projectile/beam/disabler/weak
	damage = 15

/obj/projectile/beam/disabler/weak/sharplite
	speed = 0.4

/obj/projectile/beam/disabler/weak/negative_ap
	armour_penetration = -30
	range = 9

/obj/projectile/beam/disabler/weak/negative_ap/sharplite
	icon_state = "nt_disabler_light"
	light_color = COLOR_PALE_ORANGE
	armour_penetration = -30
	range = 9
	speed = 0.3

/obj/projectile/beam/disabler/weak/negative_ap/low_range
	range = 6

/obj/projectile/beam/pulse
	name = "pulse"
	icon_state = "u_laser"
	damage = 40
	bullet_identifier = "pulse"
	wall_damage_flags = PROJECTILE_BONUS_DAMAGE_MINERALS | PROJECTILE_BONUS_DAMAGE_WALLS | PROJECTILE_BONUS_DAMAGE_RWALLS
	wall_damage_override = 200
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse

/obj/projectile/beam/pulse/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/targets_turf = target.loc
	if(!isopenturf(targets_turf))
		return
	targets_turf.ignite_turf(rand(8,22), "blue")

/obj/projectile/beam/pulse/sharplite_turret
	wall_damage_flags = null
	wall_damage_override = 0
	speed = 0.4

/obj/projectile/beam/pulse/shotgun
	damage = 40

/obj/projectile/beam/pulse/condor
	range = 128

/obj/projectile/beam/pulse/heavy
	name = "heavy pulse laser"
	icon_state = "pulse1_bl"
	var/life = 20

/obj/projectile/beam/pulse/heavy/on_hit(atom/target, blocked = FALSE)
	life -= 10
	if(life > 0)
		. = BULLET_ACT_FORCE_PIERCE
	..()

/obj/projectile/beam/emitter
	name = "emitter beam"
	icon_state = "emitter"
	damage = 60 //osha violation waiting to happen
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN

/obj/projectile/beam/emitter/singularity_pull()
	return //don't want the emitters to miss

/obj/projectile/beam/lasertag
	name = "laser tag beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	flag = "laser"
	var/suit_types = list(/obj/item/clothing/suit/redtag, /obj/item/clothing/suit/bluetag)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/projectile/beam/lasertag/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		if(istype(M.wear_suit))
			if(M.wear_suit.type in suit_types)
				M.adjustStaminaLoss(34)

/obj/projectile/beam/lasertag/redtag
	icon_state = "laser"
	suit_types = list(/obj/item/clothing/suit/bluetag)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = COLOR_SOFT_RED
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/projectile/beam/lasertag/redtag/hitscan
	hitscan = TRUE

/obj/projectile/beam/lasertag/bluetag
	icon_state = "bluelaser"
	suit_types = list(/obj/item/clothing/suit/redtag)
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue

/obj/projectile/beam/lasertag/bluetag/hitscan
	hitscan = TRUE

/obj/projectile/beam/instakill
	name = "instagib laser"
	icon_state = "purple_laser"
	damage = 200
	damage_type = BURN
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	light_color = LIGHT_COLOR_PURPLE

/obj/projectile/beam/instakill/blue
	icon_state = "blue_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/projectile/beam/instakill/red
	icon_state = "red_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = COLOR_SOFT_RED

/obj/projectile/beam/instakill/on_hit(atom/target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.visible_message(span_danger("[M] explodes into a shower of gibs!"))
		M.gib()

//a shrink ray that shrinks stuff, which grows back after a short while.
/obj/projectile/beam/shrink
	name = "shrink ray"
	icon_state = "blue_laser"
	hitsound = 'sound/weapons/shrink_hit.ogg'
	damage = 0
	damage_type = STAMINA
	flag = "energy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/shrink
	light_color = LIGHT_COLOR_BLUE
	var/shrink_time = 90

/obj/projectile/beam/shrink/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isopenturf(target) || istype(target, /turf/closed/indestructible))//shrunk floors wouldnt do anything except look weird, i-walls shouldnt be bypassable
		return
	target.AddComponent(/datum/component/shrink, shrink_time)

/obj/projectile/beam/emitter/hitscan
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter
	impact_effect_type = null

/obj/projectile/beam/emitter/hitscan/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/targets_turf = target.loc
	if(!isopenturf(targets_turf))
		return
	targets_turf.ignite_turf(rand(8,22), "green")
