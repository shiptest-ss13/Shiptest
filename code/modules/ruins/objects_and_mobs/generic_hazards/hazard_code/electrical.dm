// Electrical hazards for ruins. Sparks, Teslas, and Stuns!

/obj/structure/hazard/electrical
	name = "electrical hazard"
	desc = "tell a maptainer if you see this. BZZT!"
	icon_state = "hazardb"

	random_effect = FALSE
	var/random_sparks = FALSE //randomly emit sparks. mostly for show

	var/random_zap = FALSE //randomly zaps mobs on turf. deadly!

	var/random_tesla = FALSE // randomly emit tesla arcs. use sparingly!
	var/zap_range = 4 //how far this reaches
	var/zap_power = 2000 //has to be more than 1000. this Will be exploited by players so be smart about it. used for damage & power generation
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_MOB_STUN

	enter_activated = FALSE //make sure to set this to TRUE if using contact stuff.
	var/contact_sparks = FALSE //spark on contact. for show and rarely to light gases
	cooldown_time = 3 SECONDS //stops people from spamming sparks

	var/contact_stun = FALSE //stun on contact. dangerous and potentially deadly
	var/stun_time = 50
	var/contact_damage = 30
	var/shock_flags = SHOCK_NOGLOVES | SHOCK_NOSTUN //SHOCK_ILLUSION does stamina damage instead, may be useful.
	disable_text = "cutting the wires."

/obj/structure/hazard/electrical/Initialize()
	if(contact_sparks || contact_stun)
		enter_activated = TRUE
	if(random_sparks || random_tesla || random_zap)
		random_effect = TRUE
	. = ..()

/obj/structure/hazard/electrical/do_random_effect()
	if(random_sparks)
		do_sparks(2, TRUE, src)
	if(random_tesla)
		zap()
	if(random_zap)
		zap_on_turf()

/obj/structure/hazard/electrical/proc/zap()
	playsound(src.loc, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
	tesla_zap(src, zap_range, zap_power, zap_flags)

/obj/structure/hazard/electrical/proc/zap_on_turf()
	for(var/mob/living/target in src.loc)
		do_sparks(2, TRUE, src)
		target.electrocute_act(contact_damage, src, flags = shock_flags)

/obj/structure/hazard/electrical/contact(target)
	if(contact_sparks)
		contact_sparks()
	if(contact_stun && istype(target, /mob/living))
		contact_stun(target)

/obj/structure/hazard/electrical/proc/contact_sparks()
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_time)
	do_sparks(3, TRUE, src)

/obj/structure/hazard/electrical/proc/contact_stun(mob/living/target)
	target.electrocute_act(contact_damage, src, flags = shock_flags) // electrocute act does a message.
	if(shock_flags & SHOCK_NOGLOVES)
		target.Paralyze(stun_time)

/obj/structure/hazard/electrical/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(!can_be_disabled)
		return
	user.visible_message("<span class='warning'>[user] cuts power to [src].</span>",
		"<span class='notice'>You start to cut power to [src].</span>", "<span class='hear'>You hear cutting.</span>")
	if(!disabled)
		if(I.use_tool(src, user, time_to_disable, volume=100))
			to_chat(user, "<span class='notice'>You disable [src].</span>")
			disable()
	else
		if(I.use_tool(src, user, time_to_disable * 2, volume=100))
			to_chat(user, "<span class='notice'>You destroy [src].</span>")
			qdel(src)
	return TRUE
