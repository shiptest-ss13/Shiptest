// .50 BMG (Sniper)

/obj/projectile/bullet/p50
	name = ".50 BMG bullet"
	speed = BULLET_SPEED_SNIPER
	damage = 70
	knockdown = 100
	dismemberment = 50
	armour_penetration = 60
	var/breakthings = TRUE

/obj/projectile/bullet/p50/on_hit(atom/target, blocked = 0)
	if(isobj(target) && (blocked != 100) && breakthings)
		var/obj/O = target
		O.take_damage(80, BRUTE, "bullet", FALSE)
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

//6.5x57mm CLIP (F90)

/obj/projectile/bullet/a65clip
	name = "6.5x57mm CLIP bullet"
	stamina = 10
	damage = 40
	armour_penetration = 50

	speed = BULLET_SPEED_SNIPER

	icon_state = "redtrac"
	light_system = MOVABLE_LIGHT
	light_color = COLOR_SOFT_RED
	light_range = 2

/obj/projectile/bullet/a65clip/trac
	damage = 10
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/a65clip

//this should only exist on the big ass turrets. don't fucking give players this.
/obj/projectile/bullet/a65clip/rubber //"rubber"
	name = "6.5x57mm CLIP rubber bullet"
	damage = 10
	stamina = 40
	speed_mod = BULLET_SPEED_RUBBER_MOD

// 8x58mm caseless (SG-669)

/obj/projectile/bullet/a858
	name = "8x58mm caseless bullet"
	damage = 35
	armour_penetration = 40
	speed = BULLET_SPEED_SNIPER

/obj/projectile/bullet/a858/trac
	name = "8x58mm tracker"
	damage = 12
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/a858

// .300 Magnum

/obj/projectile/bullet/a300
	name = ".300 Magnum bullet"
	damage = 45
	stamina = 10
	armour_penetration = 40
	speed = BULLET_SPEED_RIFLE

/obj/projectile/bullet/a300/trac
	name = ".300 Tracker"
	damage = 10
	armour_penetration = 0
	shrapnel_type = /obj/item/shrapnel/bullet/tracker/a308
