/mob/living/carbon/human/MouseDrop(mob/over)
	. = ..()
	if(ishuman(over))
		var/mob/living/carbon/human/T = over  // curbstomp, ported from PP with modifications
		if(!src.is_busy && (src.zone_selected == BODY_ZONE_HEAD || src.zone_selected == BODY_ZONE_PRECISE_GROIN) && get_turf(src) == get_turf(T) && !(T.mobility_flags & MOBILITY_STAND) && src.a_intent != INTENT_HELP) //all the stars align, time to curbstomp
			src.is_busy = TRUE

			if (!do_mob(src,T,25) || get_turf(src) != get_turf(T) || (T.mobility_flags & MOBILITY_STAND) || src.a_intent == INTENT_HELP || src == T) //wait 30ds and make sure the stars still align (Body zone check removed after PR #958)
				src.is_busy = FALSE
				return

			T.Stun(6)

			if(src.zone_selected == BODY_ZONE_HEAD) //curbstomp specific code

				var/increment = (T.lying_angle/90)-2
				setDir(increment > 0 ? WEST : EAST)
				for(var/i in 1 to 5)
					src.pixel_y += 8-i
					src.pixel_x -= increment
					sleep(0.2)
				for(var/i in 1 to 5)
					src.pixel_y -= 8-i
					src.pixel_x -= increment
					sleep(0.2)

				playsound(src, 'sound/effects/hit_kick.ogg', 80, 1, -1)
				playsound(src, 'sound/weapons/punch2.ogg', 80, 1, -1)

				var/obj/item/bodypart/BP = T.get_bodypart(BODY_ZONE_HEAD)
				if(BP)
					BP.receive_damage(36) //so 3 toolbox hits

				T.visible_message("<span class='warning'>[src] curbstomps [T]!</span>", "<span class='warning'>[src] curbstomps you!</span>")

				log_combat(src, T, "curbstomped")

			else if(src.zone_selected == BODY_ZONE_PRECISE_GROIN) //groinkick specific code

				var/increment = (T.lying_angle/90)-2
				setDir(increment > 0 ? WEST : EAST)
				for(var/i in 1 to 5)
					src.pixel_y += 2-i
					src.pixel_x -= increment
					sleep(0.2)
				for(var/i in 1 to 5)
					src.pixel_y -= 2-i
					src.pixel_x -= increment
					sleep(0.2)

				playsound(src, 'sound/effects/hit_kick.ogg', 80, 1, -1)
				playsound(src, 'sound/effects/hit_punch.ogg', 80, 1, -1)

				var/obj/item/bodypart/BP = T.get_bodypart(BODY_ZONE_CHEST)
				if(BP)
					if(T.gender == MALE)
						BP.receive_damage(25)
					else
						BP.receive_damage(15)

				T.visible_message("<span class='warning'>[src] kicks [T] in the groin!</span>", "<span class='warning'>[src] kicks you in the groin!</span")

				log_combat(src, T, "groinkicked")

			var/increment = (T.lying_angle/90)-2
			for(var/i in 1 to 10)
				src.pixel_x = src.pixel_x + increment
				sleep(0.1)

			src.pixel_x = 0
			src.pixel_y = 0 //position reset

			src.is_busy = FALSE

/mob/living/carbon/human/species/ipc
	race = /datum/species/ipc

/mob/living/carbon/human/species/squid
	race = /datum/species/squid
