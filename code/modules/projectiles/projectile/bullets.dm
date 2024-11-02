#define BULLET_SPEED 0.3
#define BULLET_SNIPER_SPEED 0.2
#define BULLET_AP_SPEED 0.2
#define BULLET_HP_SPEED 0.5
#define BULLET_RUBBER_SPEED 0.4
#define BULLET_HV_SPEED 0.1
#define BULLET_SURPLUS_SPEED 0.4

/obj/projectile/bullet
	name = "bullet"
	icon_state = "gauss"
	damage = 60
	speed = BULLET_SPEED
	damage_type = BRUTE
	nodamage = FALSE
	flag = "bullet"

	hitsound = "bullet_hit"
	hitsound_non_living = "bullet_impact"
	hitsound_glass = "bullet_hit_glass"
	hitsound_stone = "bullet_hit_stone"
	hitsound_metal = "bullet_hit_metal"
	hitsound_wood = "bullet_hit_wood"
	hitsound_snow = "bullet_hit_snow"

	near_miss_sound = "bullet_miss"
	ricochet_sound = "bullet_bounce"


	impact_effect_type = /obj/effect/temp_visual/impact_effect
	ricochets_max = 5 //should be enough to scare the shit out of someone
	ricochet_chance = 30
	ricochet_decay_damage = 0.5 //shouldnt being reliable, but deadly enough to be careful if you accidentally hit an ally

	//for tracker rounds. most wont interact with this.
	var/gps_tag
	//i wish we had multitype inheritance
