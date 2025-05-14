/obj/item/organ/zombie_infection
	name = "festering ooze"
	desc = "A black web of pus and viscera."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ZOMBIE
	icon_state = "blacktumor"
	var/causes_damage = TRUE
	var/datum/species/old_species = /datum/species/human
	var/living_transformation_time = 30

	var/revive_time_min = 450
	var/revive_time_max = 700
	var/timer_id

/obj/item/organ/zombie_infection/Initialize()
	. = ..()
	if(iscarbon(loc))
		Insert(loc)
	GLOB.zombie_infection_list += src

/obj/item/organ/zombie_infection/Destroy()
	GLOB.zombie_infection_list -= src
	. = ..()

/obj/item/organ/zombie_infection/Insert(mob/living/carbon/M, special = 0)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/organ/zombie_infection/Remove(mob/living/carbon/M, special = 0)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	if(ishuman(M) && iszombie(M) && old_species && !QDELETED(M) && !special)
		var/mob/living/carbon/human/H = M
		H.set_species(old_species)
	if(timer_id)
		deltimer(timer_id)

/obj/item/organ/zombie_infection/on_find(mob/living/finder)
	to_chat(finder, "<span class='warning'>Inside the head is a disgusting black \
		web of pus and viscera, bound tightly around the brain like some \
		biological harness.</span>")

/obj/item/organ/zombie_infection/process(seconds_per_tick)
	if(!owner)
		return
	if(!(src in owner.internal_organs))
		Remove(owner)
	if((owner.mob_biotypes & MOB_MINERAL) || !ishuman(owner))//does not process in inorganic things or monkeys
		return
	if (causes_damage && !iszombie(owner) && owner.stat != DEAD)
		owner.adjustToxLoss(0.5 * seconds_per_tick)
		if(SPT_PROB(5, seconds_per_tick))
			to_chat(owner, span_danger("You feel sick..."))
	if(timer_id)
		return
	if(owner.stat != DEAD)
		return
	if(!owner.getorgan(/obj/item/organ/brain))
		return
	if(!iszombie(owner))
		to_chat(owner, "<span class='cultlarge'>You can feel your heart stopping, but something isn't right... \
		life has not abandoned your broken form. You can only feel a deep and immutable hunger that \
		not even death can stop, you will rise again!</span>")
	var/revive_time = rand(revive_time_min, revive_time_max)
	var/flags = TIMER_STOPPABLE
	timer_id = addtimer(CALLBACK(src, PROC_REF(zombify), owner), revive_time, flags)

/obj/item/organ/zombie_infection/proc/zombify(mob/living/carbon/human/H)
	timer_id = null

	if(owner.stat != DEAD || H != owner || !ishuman(H))
		return

	if(!iszombie(owner))
		old_species = owner.dna.species.type
		H.set_species(/datum/species/zombie/infectious)

	var/stand_up = (H.stat == DEAD) || (H.stat == UNCONSCIOUS)

	//Fully heal the zombie's damage the first time they rise
	H.setToxLoss(0, 0)
	H.setOxyLoss(0, 0)
	H.heal_overall_damage(INFINITY, INFINITY, INFINITY, null, TRUE)

	if(!H.revive())
		return

	H.grab_ghost()
	H.visible_message(span_danger("[owner] suddenly convulses, as [owner.p_they()][stand_up ? " stagger to [owner.p_their()] feet and" : ""] gain a ravenous hunger in [owner.p_their()] eyes!"), span_alien("You HUNGER!"))
	playsound(H.loc, 'sound/hallucinations/far_noise.ogg', 50, 1)
	H.do_jitter_animation(living_transformation_time)
	H.Stun(living_transformation_time)
	to_chat(H, span_alertalien("You are now a zombie! Do not seek to be cured, do not help any non-zombies in any way, do not harm your zombie brethren and spread the disease by killing others. You are a creature of hunger and violence."))

/obj/item/organ/zombie_infection/nodamage
	causes_damage = FALSE
