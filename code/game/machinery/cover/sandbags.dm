/obj/structure/barricade/sandbags
	name = "sandbags"
	desc = "Bags of sand. Self explanatory."
	icon = 'icons/obj/smooth_structures/sandbags.dmi'
	icon_state = "sandbags-0"
	base_icon_state = "sandbags"
	max_integrity = 240
	pass_chance = 20
	pass_flags_self = LETPASSTHROW
	bar_material = SAND
	climbable = TRUE
	smoothing_flags = SMOOTH_BITMASK
	//what is snow if not white sand
	hitsound_type = PROJECTILE_HITSOUND_SNOW
	smoothing_groups = list(SMOOTH_GROUP_SANDBAGS)
	canSmoothWith = list(SMOOTH_GROUP_SANDBAGS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SECURITY_BARRICADE)
	//how many sandbags do you get back from deconstructing this barrier? Decreases as it takes damage. Can be replenished w/ fresh sandbags.
	var/effective_bags = 5
	//holder for how much damage since the last bag replacement. Resets every 48 damage or bag replacement
	var/bag_damage = 0

/obj/structure/barricade/sandbags/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sandbags) && effective_bags < 5)
		var/obj/item/stack/sandbags/sandbag = attacking_item
		if(do_after(user, 15, src))
			visible_message(span_notice("[user] quickly adds a sandbag to [src]"))
			effective_bags++
			atom_integrity = min(atom_integrity + 48, max_integrity)
			sandbag.use(1)
	else
		return ..()

/obj/structure/barricade/sandbags/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	bag_damage += damage_amount
	if(bag_damage >= 48)
		playsound(src, 'sound/effects/sandbag_break.ogg', 50)
		effective_bags--
		bag_damage = 0
		//make a bit of a mess. It's soulful.
		new /obj/effect/decal/cleanable/generic(get_step(src, (rand(1,8))))
		new /obj/effect/decal/cleanable/dirt/dust(get_step(src, rand(1,8)))
	if(effective_bags == 0)
		deconstruct()

/obj/structure/barricade/sandbags/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(src.flags_1 & NODECONSTRUCT_1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
			return
		usr.visible_message(span_notice("[usr] begins pulling apart \the [src.name]..."), span_notice("You begin pulling apart \the [src.name]..."))
		if(do_after(usr, 30, usr))
			deconstruct()

/obj/structure/barricade/sandbags/make_debris()
	new /obj/item/stack/sandbags(get_turf(src), effective_bags)

/obj/structure/barricade/sandbags/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>pull</b> the [src.name] by dragging it onto yourself.")
	if(effective_bags < 5)
		. += span_warning("[5-effective_bags] sandbag[effective_bags == 4 ? " is" : "s have"] broken!")

#undef SAND
