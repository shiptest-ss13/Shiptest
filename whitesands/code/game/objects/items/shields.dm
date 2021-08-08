/obj/item/shield/riot/goliath
	name = "Goliath shield"
	desc = "A shield made from interwoven plates of goliath hide."
	icon_state = "goliath_shield"
	icon = 'whitesands/icons/obj/shields.dmi'
	lefthand_file = 'whitesands/icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/equipment/shields_righthand.dmi'
	mob_overlay_icon = 'whitesands/icons/mob/clothing/back.dmi'
	custom_materials = list()
	transparent = FALSE
	block_chance = 25
	max_integrity = 70
	w_class = WEIGHT_CLASS_BULKY

/obj/item/shield/riot/goliath/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", damage = 0, attack_type = MELEE_ATTACK)
	if(isliving(hitby)) // If attacker is a simple mob.
		damage *= 0.5
	. = ..()

/obj/item/shield/riot/goliath/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/bang.ogg', 50)
	new /obj/item/stack/sheet/animalhide/goliath_hide(get_turf(src))
	qdel(src)
