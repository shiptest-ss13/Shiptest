/obj/projectile/energy/electrode
	name = "electrode"
	icon_state = "spark"
	color = "#FFFF00"
	nodamage = FALSE
	hitsound = 'sound/weapons/taserhit.ogg'
	range = 7
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = /obj/effect/projectile/muzzle/stun
	impact_type = /obj/effect/projectile/impact/stun

	var/confusion_amt = 10		//WS Edit Begin - Nerfs tasers
	var/stamina_loss_amt = 60
	var/apply_stun_delay = 2 SECONDS
	var/stun_time = 5 SECONDS

	var/attack_cooldown_check = 0 SECONDS
	var/attack_cooldown = 2.5 SECONDS		//WS Edit End

/obj/projectile/energy/electrode/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - burst into sparks!
		do_sparks(1, TRUE, src)
	else if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(C.dna && C.dna.check_mutation(HULK))
			C.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		else if((C.status_flags & CANKNOCKDOWN) && !HAS_TRAIT(C, TRAIT_STUNIMMUNE))
			C.Jitter(20)				//WS Edit Begin - Nerfs tasers
			C.confused = max(confusion_amt, C.confused)
			C.stuttering = max(8, C.stuttering)
			C.apply_damage(stamina_loss_amt, STAMINA, BODY_ZONE_CHEST)
			SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
			addtimer(CALLBACK(src, .proc/apply_stun_effect_end, C), apply_stun_delay)

			attack_cooldown_check = world.time + attack_cooldown



/obj/projectile/energy/electrode/proc/apply_stun_effect_end(mob/living/target)
	var/trait_check = HAS_TRAIT(target, TRAIT_STUNRESISTANCE) //var since we check it in out to_chat as well as determine stun duration
	if(trait_check)
		target.Knockdown(stun_time * 0.1)
	else
		target.Knockdown(stun_time)
	if(!target.IsKnockdown())
		to_chat(target, "<span class='warning'>Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]</span>")		//WS Edit End


/obj/projectile/energy/electrode/on_range() //to ensure the bolt sparks when it reaches the end of its range if it didn't hit a target yet
	do_sparks(1, TRUE, src)
	..()
