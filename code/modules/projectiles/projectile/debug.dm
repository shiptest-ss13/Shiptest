/obj/projectile/debug/death
	name = "bolt of death"
	icon_state = "pulse1_bl"

/obj/projectile/debug/death/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		M.death(0)

/obj/projectile/debug/resurrection
	name = "bolt of resurrection"
	icon_state = "ion"
	nodamage = TRUE

/obj/projectile/debug/resurrection/on_hit(mob/living/carbon/target)
	. = ..()
	if(isliving(target))
		if(target.revive(full_heal = TRUE, admin_revive = TRUE))
			target.grab_ghost(force = TRUE) // even suicides
			to_chat(target, "<span class='notice'>You rise with a start, you're alive!!!</span>")
		else if(target.stat != DEAD)
			to_chat(target, "<span class='notice'>You feel great!</span>")
