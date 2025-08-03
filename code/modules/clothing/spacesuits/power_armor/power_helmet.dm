//Helmet
/obj/item/clothing/head/helmet/space/hardsuit/power_armor
	name = "power armor helmet"
	desc = "Tell a developer if you see this"
	icon = 'icons/obj/clothing/power_armor/pa_head.dmi'
	mob_overlay_icon = 'icons/obj/clothing/power_armor/pa_head.dmi'
	icon_state = "null"
	basestate = "helmet"

	max_integrity = 500
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | BLOCKS_SHOVE_KNOCKDOWN
	actions_types = list(/datum/action/item_action/toggle_helmet_light)

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/Initialize()
	. = ..()
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP
	ADD_TRAIT(src, TRAIT_NODROP, STICKY_NODROP) //Somehow it's stuck to your body, no questioning.
	radio = new radiotype(src)
	#warn todo add
	// AddElement(/datum/element/radiation_protected_clothing) 

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/Destroy()
	if(suit.helmet)
		suit.helmet = null
	suit = null
	. = ..()

#warn decipher this
/obj/item/clothing/head/helmet/space/hardsuit/ms13/power_armor/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration, def_zone)
	if(QDELETED(src))
		CRASH("[src] taking damage after deletion")

	if(obj_integrity <= 0)
		return damage_amount

	if(sound_effect)
		play_attack_sound(damage_amount, damage_type, damage_flag)

	if(resistance_flags & INDESTRUCTIBLE)
		return
	damage_amount = run_obj_armor(damage_amount, damage_type, damage_flag, attack_dir, armour_penetration)

	if(damage_amount < DAMAGE_PRECISION)
		return
	if(SEND_SIGNAL(src, COMSIG_ATOM_TAKE_DAMAGE, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration))
		return

	. = damage_amount

	update_integrity(obj_integrity - damage_amount)

	//BREAKING
	if(integrity_failure && obj_integrity <= integrity_failure * max_integrity)
		atom_break(damage_flag)

	if(obj_integrity <= 0)
		atom_destruction(damage_flag)

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/get_examine_string(mob/user, thats, damage = TRUE)
	var/damage_txt = ""
	if(damage)
		if(obj_integrity <= 0)
			damage_txt ="This part is a broken."
		if(obj_integrity > 0 && (obj_integrity < (max_integrity / 3)))
			damage_txt ="This part is a heavily damaged."
		if((obj_integrity > (max_integrity / 3)) && (obj_integrity < (max_integrity * (2/3))))
			damage_txt = "This part is a damaged."
		if((obj_integrity > (max_integrity * (2/3))) && (obj_integrity < max_integrity))
			damage_txt = "This part is a lightly damaged."
		if(obj_integrity == max_integrity)
			damage_txt = "This part is a non-damaged."

	return "[icon2html(src, user)] [thats? "That's ":""][get_examine_name(user)]. [damage_txt]"
