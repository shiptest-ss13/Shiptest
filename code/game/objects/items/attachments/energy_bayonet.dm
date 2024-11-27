/obj/item/attachment/energy_bayonet
	name = "energy bayonet"
	desc = "Stabby-Stabby"
	icon_state = "ebayonet"
	force = 3
	throwforce = 2
	pickup_sound =  'sound/items/handling/knife1_pickup.ogg'
	drop_sound = 'sound/items/handling/knife3_drop.ogg'
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_BLUNT
	slot = ATTACHMENT_SLOT_MUZZLE
	attach_features_flags = ATTACH_TOGGLE

	light_range = 2
	light_power = 0.6
	light_on = FALSE
	light_color = COLOR_MOSTLY_PURE_RED
	light_system = MOVABLE_LIGHT

	toggle_on_sound = 'sound/weapons/saberon.ogg'
	toggle_off_sound = 'sound/weapons/saberoff.ogg'

	pixel_shift_x = 1
	pixel_shift_y = 4
	spread_mod = 1
	wield_delay = 0.2 SECONDS

/obj/item/attachment/energy_bayonet/on_preattack(obj/item/gun/gun, atom/target, mob/living/user, list/params)
	if(user.a_intent == INTENT_HARM && user.CanReach(target, src, TRUE) && toggled != 0)
		melee_attack_chain(user, target, params)
		return COMPONENT_NO_ATTACK


/obj/item/attachment/energy_bayonet/toggle_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	set_light_on(toggled)
	update_icon()
	sharpness = toggled ? IS_SHARP_ACCURATE : IS_BLUNT
	force = toggled ? 19 : 3
	throwforce = toggled ? 14 : 2

/obj/item/attachment/energy_bayonet/attack_self(mob/user)
	toggle_attachment()
