/obj/projectile/bullet
	name = "bullet"
	icon_state = "gauss"
	damage = 60
	speed = 0.4
	damage_type = BRUTE
	nodamage = FALSE
	flag = "bullet"
	hitsound = "bullet_hit"
	hitsound_non_living = "bullet_impact"
	ricochet_sound = "bullet_bounce"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	ricochets_max = 5 //should be enough to scare the shit out of someone
	ricochet_chance = 30
	ricochet_decay_damage = 0.5 //shouldnt being reliable, but deadly enough to be careful if you accidentally hit an ally
