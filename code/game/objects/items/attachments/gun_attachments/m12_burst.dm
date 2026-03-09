/obj/item/attachment/m12_burst
	name = "Model 12 'Sporter' assualt rifle mod kit"
	desc = "A random assortment of parts intended to make the Sporter into a 'assualt rifle.' Random parts are taken from various Serene Sporting weapons, and includes an assualt rifle stock. This gives it full auto along with bust fire."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"
	attach_features_flags = null
	attach_sound = 'sound/items/drill_use.ogg'
	attachment_time = 10 SECONDS

	slot = ATTACHMENT_SLOT_STOCK

	var/gun_icon_state = "m12_burst"
	var/add_desc = "It seems to have been modified with an after-market mod; random parts taken from various Serene Sporting weapons and an assault rifle stock."

/obj/item/attachment/m12_burst/apply_attachment(obj/item/gun/ballistic/gun, mob/user)
	. = ..()
	if(!.)
		return FALSE
	gun.desc = (gun::desc + "\n" + span_notice(add_desc))
	gun.base_icon_state = gun_icon_state
	gun.item_state = gun_icon_state
	gun.icon_state = gun_icon_state
	gun.wear_minor_threshold = 240
	gun.wear_major_threshold = 720
	gun.gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO)

	gun.burst_size = 3
	gun.burst_delay = 0.1 SECONDS
	gun.fire_delay = 0.3 SECONDS
	gun.spread = 4
	gun.weapon_weight = WEAPON_MEDIUM
	gun.build_firemodes()


	gun.update_appearance()

//since this isnt intended to be removed... whatever on most the vars being
/obj/item/attachment/m12_burst/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	gun.desc = gun::desc
	gun.base_icon_state = gun::icon_state
	gun.item_state = gun::item_state
	gun.icon_state = gun::icon_state
	gun.update_appearance()
