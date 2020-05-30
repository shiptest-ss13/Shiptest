/obj/item/melee/transforming/energy/ctf
	name = "energy sword"
	desc = "That cable over there, I'm going to cut it."
	icon = 'waspstation/icons/obj/items_and_weapons.dmi'
	icon_state = "plasmasword0"
	lefthand_file = 'waspstation/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'waspstation/icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = IS_SHARP
	armour_penetration = 200
	block_chance = 0
	force = 0
	throwforce = 0
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	force_on = 200 //instakill if shields are down

/obj/item/melee/transforming/energy/ctf/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(. && active)
		icon_state = "plasmasword1"

/obj/item/melee/transforming/energy/ctf/terragov
	armour_penetration = 40
	force_on = 34 //desword grade, but 0 blocking

/obj/item/melee/transforming/energy/ctf/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'waspstation/sound/weapons/terragov_sword_arm.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")
