/obj/item/shrapnel // frag grenades
	name = "shrapnel shard"
	custom_materials = list(/datum/material/iron = 50)
	armour_penetration = -20
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	w_class = WEIGHT_CLASS_TINY
	item_flags = DROPDEL
	sharpness = SHARP_EDGED
	embedding = list(
		embed_chance = 70,
		fall_chance = 2,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 3,
		embed_chance_turf_mod = -100,
		rip_time = 4,
	)

/obj/item/shrapnel/hot
	name = "molten slag"
	damtype =  BURN
	sharpness = SHARP_NONE

/obj/item/shrapnel/stingball
	name = "clump of ballistic gel"
	icon_state = "tiny"
	embedding = list(
		embed_chance = 15,
		fall_chance = 2,
		jostle_chance = 7,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.8,
		pain_mult = 3,
		jostle_pain_mult = 5,
		rip_time = 15,
		embed_chance_turf_mod = -100,
	)

/obj/item/shrapnel/bullet // bullets
	name = "bullet"
	icon = 'icons/obj/ammunition/ammo_bullets.dmi'
	icon_state = "pistol-brass"
	item_flags = DROPDEL
	embedding = list(
		embed_chance = 40,
		jostle_chance = 0,
		ignore_throwspeed_threshold = TRUE,
		pain_stam_pct = 0.5,
		pain_mult = 3,
		rip_time = 4,
	)

/obj/item/shrapnel/bullet/c38 // .38 round
	name = "\improper .38 bullet"

/obj/item/shrapnel/bullet/c38/dumdum // .38 DumDum round
	name = "\improper .38 prism bullet"
	embedding = list(embed_chance=70,fall_chance=7, jostle_chance=7, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=-100)

/obj/item/shrapnel/bullet/tracker
	name = "\improper bullet tracker"
	embedding = list(embed_chance=100, fall_chance=0, jostle_chance=1, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=1, jostle_pain_mult=2, rip_time=100, embed_chance_turf_mod=-100)
	var/lifespan = 3000
	var/gps_tag = "*TRAC"
	var/timer_id

/obj/item/shrapnel/bullet/tracker/Initialize()
	. = ..()
	timer_id = QDEL_IN_STOPPABLE(src, lifespan)
	AddComponent(/datum/component/gps/item, gps_tag)

/obj/item/shrapnel/bullet/tracker/Destroy()
	deltimer(timer_id)
	return ..()

/obj/item/shrapnel/bullet/tracker/c38
	name = ".38 Tracker"

/obj/item/shrapnel/bullet/tracker/a8_50r
	name = "8x50mm Tracker"

/obj/item/shrapnel/bullet/tracker/a858
	name = "8x58mm Tracker"

/obj/item/shrapnel/bullet/tracker/a65clip
	name = "6.5mm Tracker"

/obj/item/shrapnel/bullet/tracker/a308
	name = ".308 Tracker"

/obj/projectile/bullet/shrapnel
	name = "flying shrapnel shard"
	damage = 15
	range = 15
	armour_penetration = -5
	ricochets_max = 2
	ricochet_chance = 60
	shrapnel_type = /obj/item/shrapnel
	ricochet_incidence_leeway = 60
	hit_stunned_targets = TRUE
	sharpness = SHARP_EDGED
	wound_bonus = 30

/obj/projectile/bullet/shrapnel/Initialize()
	. = ..()
	def_zone = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/obj/projectile/bullet/shrapnel/rusty
	damage = 8
	armour_penetration = -10
	ricochets_max = 3//duller = less likely to stick in a wall
	ricochet_chance = 60

/obj/projectile/bullet/shrapnel/mega
	damage = 20
	name = "flying shrapnel hunk"
	range = 25
	ricochets_max = 4
	ricochet_chance = 90
	ricochet_decay_chance = 0.9

/obj/projectile/bullet/shrapnel/hot
	name = "white-hot metal slag"
	damage = 8
	range = 8
	armour_penetration = -35
	shrapnel_type = /obj/item/shrapnel/hot
	damage_type = BURN

/obj/projectile/bullet/shrapnel/hot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(15)
		M.ignite_mob()

/obj/projectile/bullet/shrapnel/spicy
	name = "radioactive slag"
	damage_type = BURN
	damage = 10
	range = 8
	armour_penetration = -35
	shrapnel_type = /obj/item/shrapnel/hot

/obj/projectile/bullet/shrapnel/spicy/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.apply_effect(250,EFFECT_IRRADIATE,0)

/obj/projectile/bullet/pellet/stingball
	name = "ballistic gel clump"
	damage = 5
	stamina = 15
	ricochets_max = 6
	ricochet_chance = 66
	ricochet_decay_chance = 1
	ricochet_decay_damage = 0.9
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 2
	ricochet_incidence_leeway = 0
	embed_falloff_tile = -2
	shrapnel_type = /obj/item/shrapnel/stingball
	embedding = list(embed_chance=55, fall_chance=2, jostle_chance=7, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.7, pain_mult=3, jostle_pain_mult=3, rip_time=15)

/obj/projectile/bullet/pellet/stingball/mega
	name = "megastingball pellet"
	ricochets_max = 6
	ricochet_chance = 110

/obj/projectile/bullet/pellet/stingball/on_ricochet(atom/A)
	hit_stunned_targets = TRUE // ducking will save you from the first wave, but not the rebounds

//claymore shrapnel stuff//
//2 small bursts- one that harasses people passing by a bit aways, one that brutalizes point-blank targets.
/obj/item/ammo_casing/caseless/shrapnel
	name = "directional shrapnel burst :D"
	desc = "I May Have Overreacted"
	pellets = 5
	variance = 70
	projectile_type = /obj/projectile/bullet/shrapnel/claymore
	randomspread = TRUE

/obj/item/ammo_casing/caseless/shrapnel/shred
	name = "point blank directional shrapnel burst"
	desc = "Claymores are lethal to armored infantry at point blank range."
	pellets = 4
	variance = 50
	projectile_type = /obj/projectile/bullet/shrapnel/claymore/pointbl
	randomspread = TRUE

/obj/projectile/bullet/shrapnel/claymore
	name = "ceramic splinter"
	range = 4
	armour_penetration = 0

/obj/projectile/bullet/shrapnel/claymore/pointbl
	name = "large ceramic shard"
	range = 2
	damage = 18
	dismemberment = 30
	armour_penetration = 10

/obj/item/ammo_casing/caseless/shrapnel/plasma
	name = "directional plasma burst"
	projectile_type = /obj/projectile/energy/plasmabolt

/obj/item/ammo_casing/caseless/shrapnel/shred/plasma
	name = "point blank directional plasma burst"
	projectile_type = /obj/projectile/energy/plasmabolt/shred
