/obj/item/ammo_casing/caseless/arrow
	name = "arrow"
	desc = "A finely crafted wooden arrow."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon_state = "arrow"
	throwforce = 3 //good luck hitting someone with the pointy end of the arrow
	throw_speed = 3
	firing_effect_type = null
	flags_1 = NONE
	heavy_metal = FALSE
	auto_rotate = FALSE
	can_cookoff = FALSE
	stack_type = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_casing/caseless/arrow/examine(mob/examiner)
	. = ..()
	. += span_notice("You can use the arrow in hand to load it into a bow in your other hand.")

/obj/item/ammo_casing/caseless/arrow/attack_self(mob/user)
	. = ..()
	var/obj/item/potential_bow = user.get_inactive_held_item()
	if(istype(potential_bow, /obj/item/gun/ballistic/bow))
		potential_bow.attackby(src, user)
