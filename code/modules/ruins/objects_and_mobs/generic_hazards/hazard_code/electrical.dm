// Electrical hazards for ruins. Sparks, Teslas, and Stuns!

/obj/structure/hazard/electrical
	name = "electrical hazard"
	desc = "tell a maptainer if you see this. BZZT!"
	icon_state = "hazardb"

	//randomly emit sparks. mostly for show
	var/random_sparks = FALSE
	//randomly zaps mobs on turf. deadly!
	var/random_zap = FALSE
	//randomly emit tesla arcs. use sparingly!
	var/random_tesla = FALSE
	//how far the tesla arc reaches, still can chain off other objects.
	var/zap_range = 4
	//has to be more than 1000. this Will be exploited by players so be smart about it. used for damage & power generation
	var/zap_power = 2000
	//flags for the arc, these are generally good, but ZAP_OBJ_DAMAGE may be useful in rare cases.
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_MOB_STUN

	//sparks on contact, mostly for show or to light fires.
	var/contact_sparks = FALSE
	//stops people from spamming sparks
	cooldown_time = 3 SECONDS

	//stun on contact. dangerous and potentially deadly
	var/contact_stun = FALSE
	//how long, in decaseconds, the target is stunned. If 0, doesn't stun.
	var/stun_time = 50
	//how much burn damage the stun does.
	var/contact_damage = 30
	//flags for the stun, SHOCK_NOGLOVES ignores gloves, SHOCK_NOSTUN doesn't stun (built in stun_time is seperate), SHOCK_ILLUSION does stamina damage instead.
	var/shock_flags = SHOCK_NOGLOVES | SHOCK_NOSTUN
	//examine text shown in can_be_disabled is TRUE
	disable_text = "cutting the wires."

/obj/structure/hazard/electrical/Initialize()
	//if contact, need to set enter_activated
	if(contact_sparks || contact_stun)
		enter_activated = TRUE
	//if random, need to set random_effect
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

/obj/structure/hazard/electrical/client_nearby()
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_time)
	zap()

//shoots off a tesla arc
/obj/structure/hazard/electrical/proc/zap()
	playsound(src.loc, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
	tesla_zap(src, zap_range, zap_power, zap_flags)

//zaps players on the same turf
/obj/structure/hazard/electrical/proc/zap_on_turf()
	for(var/mob/living/target in src.loc)
		do_sparks(2, TRUE, src)
		target.electrocute_act(contact_damage, src, flags = shock_flags)

/obj/structure/hazard/electrical/contact(target)
	if(contact_sparks)
		contact_sparks()
	if(contact_stun && istype(target, /mob/living))
		contact_stun(target)

//sparks when bumped or walked over
/obj/structure/hazard/electrical/proc/contact_sparks()
	if(!COOLDOWN_FINISHED(src, cooldown))
		return
	COOLDOWN_START(src, cooldown, cooldown_time)
	do_sparks(3, TRUE, src)

//stuns when bumped or walked over
/obj/structure/hazard/electrical/proc/contact_stun(mob/living/target)
	target.electrocute_act(contact_damage, src, flags = shock_flags) // electrocute act does a message.
	if(shock_flags & SHOCK_NOGLOVES)
		target.Paralyze(stun_time)

//generic disabling for electrical hazards, only works if can_be_disabled is TRUE
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
