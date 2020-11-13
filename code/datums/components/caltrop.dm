/datum/component/caltrop
	var/min_damage
	var/max_damage
	var/probability
	var/flags

	var/cooldown = 0

/datum/component/caltrop/Initialize(_min_damage = 0, _max_damage = 0, _probability = 100,  _flags = NONE)
	min_damage = _min_damage
	max_damage = max(_min_damage, _max_damage)
	probability = _probability
	flags = _flags

	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), .proc/Crossed)

/datum/component/caltrop/proc/Crossed(datum/source, atom/movable/AM)
	SIGNAL_HANDLER

	if(!prob(probability))
		return

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/atom/A = parent		// Wasp Edit

		if(HAS_TRAIT(H, TRAIT_PIERCEIMMUNE))
			return

		if((flags & CALTROP_IGNORE_WALKERS) && H.m_intent == MOVE_INTENT_WALK)
			return

		//move these next two down a level if you add more mobs to this.
		if(H.is_flying() || H.is_floating()) //check if they are able to pass over us
			return							//gravity checking only our parent would prevent us from triggering they're using magboots / other gravity assisting items that would cause them to still touch us.
		if(H.buckled) //if they're buckled to something, that something should be checked instead.
			return
		if(!(H.mobility_flags & MOBILITY_STAND)) //if were not standing we cant step on the caltrop
			return

		var/picked_def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/O = H.get_bodypart(picked_def_zone)
		if(!istype(O))
			return
		if(O.status == BODYPART_ROBOTIC)
			return

		var/feetCover = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) || (H.w_uniform && (H.w_uniform.body_parts_covered & FEET))

		if(!(flags & CALTROP_BYPASS_SHOES) && (H.shoes || feetCover))
			return

		var/damage = rand(min_damage, max_damage)
		var/haslightstep = HAS_TRAIT(H, TRAIT_LIGHT_STEP) //Begin Waspstation edit - caltrops don't paralyze people with light step
		if(haslightstep && !H.incapacitated(ignore_restraints = TRUE))
			damage *= 0.75

		if(cooldown < world.time - 10) //cooldown to avoid message spam.
			//var/atom/A = parent		Wasp edit
			if(!H.incapacitated(ignore_restraints = TRUE))
				if(haslightstep)
					H.visible_message("<span class='danger'>[H] carefully steps on [A].</span>",
									  "<span class='danger'>You carefully step on [A], but it still hurts!</span>")
				else 
					H.visible_message("<span class='danger'>[H] steps on [A].</span>", \
									  "<span class='userdanger'>You step on [A]!</span>")
			else
				H.visible_message("<span class='danger'>[H] slides on [A]!</span>", \
						"<span class='userdanger'>You slide on [A]!</span>")

			cooldown = world.time
		H.apply_damage(damage, BRUTE, picked_def_zone)
		if(!haslightstep)
			H.Paralyze(60) //End Waspstation edit - caltrops don't paralyze people with light step
		if(H.pulledby)								// Waspstation Edit Begin - Being pulled over caltrops is logged
			log_combat(H.pulledby, H, "pulled", A)
		else
			H.log_message("has stepped on [A]", LOG_ATTACK, color="orange")		// Waspstation Edit End
