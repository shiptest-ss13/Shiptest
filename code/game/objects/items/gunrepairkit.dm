/obj/item/gun_fixer
	name = "firearm maintenance kit"
	desc = "A toolkit containing everything needed to scrub the frontier-gunk out of a gun and return it to a mostly-usable state. Chemicals included in the kit are expended in a cleaning cycle, preventing re-use more than a few times."
	icon_state = "paint_neutral"
	w_class = WEIGHT_CLASS_BULKY //no carrying these around, sorry :(
	custom_materials = list(/datum/material/iron = 500)
	/// Amount of wear removed from a gun on use
	var/wear_reduction = 60
	/// Number of times this gun fixer can be used
	var/uses = 5

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
	if(!fixable.gun_wear)
		to_chat(user, span_notice("[fixable] is already in good condition!"))
		return
	fixable.add_overlay(GLOB.cleaning_bubbles)
	playsound(src, 'sound/misc/slip.ogg', 15, TRUE, -8)
	user.visible_message(span_notice("[user] starts to wipe down [fixable] with [src]!"), span_notice("You start to give [fixable] a deep clean with [src]..."))
	if(!do_after(user, 20 SECONDS, target = target, extra_checks = CALLBACK(fixable, TYPE_PROC_REF(/obj/item/gun/ballistic, accidents_happen), user)))
		return
	fixable.wash(CLEAN_SCRUB)
	fixable.gun_wear = clamp(fixable.gun_wear - wear_reduction, 0, 300)
	user.visible_message(span_notice("[user] finishes cleaning [fixable]!"), span_notice("You finish cleaning [fixable], [fixable.gun_wear < wear_reduction ? "and it's in pretty good condition" : "though it would benefit from another cycle"]."))
	uses--
	if(!uses)
		icon_state = "paint_empty"
