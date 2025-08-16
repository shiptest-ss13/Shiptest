//Helmet
/obj/item/clothing/head/helmet/space/hardsuit/power_armor
	name = "power armor helmet"
	desc = "Tell a developer if you see this"
	icon = 'icons/obj/clothing/power_armor/pa_head.dmi'
	mob_overlay_icon = 'icons/obj/clothing/power_armor/pa_head.dmi'
	icon_state = "null"
	basestate = "helmet"
	worn_x_dimension = 32
	worn_y_dimension = 48
	worn_y_offset = 2

	max_integrity = 500
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0,  FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | BLOCKS_SHOVE_KNOCKDOWN
	actions_types = list(/datum/action/item_action/toggle_helmet_light)

	///Instantiades path of the internal radio
	var/obj/item/radio/headset/power_armor/radio
	///Typepath of the internal radio
	var/radiotype = /obj/item/radio/headset/power_armor

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

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration, def_zone)
	if(!uses_integrity)
		CRASH("[src] had /atom/proc/take_damage() called on it without it being a type that has uses_integrity = TRUE!")
	if(QDELETED(src))
		CRASH("[src] taking damage after deletion")

	if(atom_integrity <= 0)
		return damage_amount
	if(sound_effect)
		play_attack_sound(damage_amount, damage_type, damage_flag)
	if(resistance_flags & INDESTRUCTIBLE)
		return

	damage_amount = run_atom_armor(damage_amount, damage_type, damage_flag, attack_dir, armour_penetration)
	if(damage_amount < DAMAGE_PRECISION)
		return
	if(SEND_SIGNAL(src, COMSIG_ATOM_TAKE_DAMAGE, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration) & COMPONENT_NO_TAKE_DAMAGE)
		return

	. = damage_amount

	update_integrity(atom_integrity - damage_amount)

	//BREAKING
	if(integrity_failure && atom_integrity <= integrity_failure * max_integrity)
		atom_break(damage_flag)

	if(atom_integrity <= 0)
		atom_destruction(damage_flag)

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/atom_break(damage_flag)
	. = ..()

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/atom_destruction(damage_flag)
	. = ..()
	return

/obj/item/clothing/head/helmet/space/hardsuit/power_armor/get_examine_string(mob/user, thats, damage = TRUE)
	var/damage_txt = ""
	if(damage)
		if(atom_integrity <= 0)
			damage_txt ="This part is broken."
		if(atom_integrity > 0 && (atom_integrity < (max_integrity / 3)))
			damage_txt ="This part is heavily damaged."
		if((atom_integrity > (max_integrity / 3)) && (atom_integrity < (max_integrity * (2/3))))
			damage_txt = "This part is damaged."
		if((atom_integrity > (max_integrity * (2/3))) && (atom_integrity < max_integrity))
			damage_txt = "This part is lightly damaged."
		if(atom_integrity == max_integrity)
			damage_txt = "This part is non-damaged."

	return "[icon2html(src, user)] [thats? "That's ":""][get_examine_name(user)]. [damage_txt]"

//Click the ability to access the settings of the integrated radio
/datum/action/item_action/power_armor_radio
	name = "Toggle Internal Radio Settings"

//Basetype Internal Radio
/obj/item/radio/headset/power_armor
	name = "integrated power armor headset"
	desc = "If you see this tell a developer"
	icon = 'icons/obj/radio.dmi'
	icon_state = "walkietalkie"
	actions_types = list(/datum/action/item_action/power_armor_radio)

/obj/item/radio/headset/power_armor/Initialize()
	. = ..()
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP

/obj/item/radio/headset/power_armor/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/power_armor_radio))
		ui_interact(user)

/obj/item/radio/headset/power_armor/t51
	name = "integrated T-51B power armor radio"
	desc = "A high quality radio internally attached to a T-51B power armor helmet."
