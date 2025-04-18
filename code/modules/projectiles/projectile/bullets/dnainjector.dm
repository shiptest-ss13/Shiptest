/obj/projectile/bullet/dnainjector
	name = "\improper DNA injector"
	icon_state = "syringeproj"
	var/obj/item/dnainjector/injector
	damage = 5
	hitsound_non_living = "shatter"

/obj/projectile/bullet/dnainjector/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100)
			if(M.can_inject(null, FALSE, def_zone, FALSE))
				if(injector.inject(M, firer))
					QDEL_NULL(injector)
					return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message(
					span_danger("\The [src] is deflected!"),
					span_userdanger("You are protected against \the [src]!"))
	return ..()

/obj/projectile/bullet/dnainjector/Destroy()
	QDEL_NULL(injector)
	return ..()
