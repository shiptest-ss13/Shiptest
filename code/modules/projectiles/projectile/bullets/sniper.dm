// .50 BMG (Sniper)

/obj/projectile/bullet/p50
	name = ".50 BMG bullet"
	speed = 0.3
	damage = 70
	knockdown = 100
	dismemberment = 50
	armour_penetration = 60
	var/obj_damage_mod = 1.1
	var/breakthings = TRUE

/obj/projectile/bullet/p50/on_hit(atom/target, blocked = 0)
	if(isobj(target) && (blocked != 100) && breakthings)
		var/obj/O = target
		O.take_damage((damage * obj_damage_mod), BRUTE, "bullet", FALSE)
	return ..()

/obj/projectile/bullet/p50/soporific
	name = ".50 BMG soporific bullet"
	armour_penetration = 0
	damage = 0
	dismemberment = 0
	knockdown = 0
	breakthings = FALSE

/obj/projectile/bullet/p50/soporific/on_hit(atom/target, blocked = FALSE)
	if((blocked != 100) && isliving(target))
		var/mob/living/L = target
		L.Sleeping(400)
	return ..()

/obj/projectile/bullet/p50/penetrator
	name = ".50 BMG penetrator round"
	icon_state = "gauss"
	damage = 60
	projectile_piercing = PASSMOB
	projectile_phasing = (ALL & (~PASSMOB))
	dismemberment = 0 //It goes through you cleanly.
	knockdown = 0
	breakthings = FALSE

/obj/projectile/bullet/p50/penetrator/shuttle //Nukeop Shuttle Variety
	icon_state = "gaussstrong"
	damage = 25
	range = 16
