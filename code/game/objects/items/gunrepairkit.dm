/obj/item/gun_fixer
	name = "firearm maintenance kit"
	desc = "A toolkit containing everything needed to scrub the frontier-gunk out of a gun and return it to a mostly-usable state. Several chemicals required for a full cleaning process are expended, and each kit only contains enough for a single use."
	w_class = WEIGHT_CLASS_BULKY //no carrying these around, sorry :(
	/// How much wear will this clean from a gun?
	var/wear_reduction = 60
	/// Number of times this gun fixer can be used
	var/uses = 1

/obj/item/gun_fixer/examine(mob/user)
	. = ..()
	. += "it can be used [uses] more times."

/obj/item/gun_fixer/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(!uses)
		to_chat(user, span_warning("[src] is out of uses!"))
		return
	var/obj/item/gun/ballistic/fixable = target
	if(!istype(fixable))
		return
	fixable.add_overlay(GLOB.cleaning_bubbles)
	playsound(src, 'sound/misc/slip.ogg', 15, TRUE, -8)
	user.visible_message("<span class='notice'>[user] starts to wipe down [fixable] with [src]!</span>", "<span class='notice'>You start to wipe down [fixable] with [src]...</span>")
	if(!do_after(user, 20 SECONDS, target = target, extra_checks = CALLBACK(src, PROC_REF(accidents_happen), fixable, user)))
		user.visible_message("<span class='notice'>[user] finishes cleaning [fixable]!</span>", "<span class='notice'>You clean [fixable].</span>")
		return
	fixable.gun_wear = clamp(fixable.gun_wear - wear_reduction, 0, 200)
	uses--

/// Remember: you can always trust a loaded gun to go off at least once.
/obj/item/gun_fixer/proc/accidents_happen(obj/item/gun/ballistic/whoops, mob/darwin)
	. = TRUE
	if(!whoops.magazine)
		return
	if(whoops.internal_magazine && !whoops.magazine.ammo_count(TRUE))
		return
	if(prob(1)) //this gets called I think once per decisecond so we don't really want a high chance here
		if(whoops.safety) //TTD: FLAVORTEXT
			whoops.safety = FALSE
			if(prob(50)) //you got lucky. THIS time.
				return
		if(!whoops.chambered)//TTD: FLAVORTEXT
			whoops.chamber_round()
			if(prob(50))
				return
		whoops.unsafe_shot(darwin)//TTD: FLAVORTEXT
		return FALSE
