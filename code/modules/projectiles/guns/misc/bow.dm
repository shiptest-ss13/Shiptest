/obj/item/gun/ballistic/bow
	autowiki_hidden = TRUE //the bows and therefore arrows are apparently due for a rework and are unobtainable atm?
	name = "HP Longbow"
	desc = "A modern rendition of a prehistoric weapon, built by Hunter's Pride. While not as easy to operate as modern compound bows, it packs quite a bit more punch. Chambered in 6.5x750 caseless - that is to say, it fires arrows."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "bow"
	item_state = "pipebow"

	load_sound = null
	fire_sound = 'sound/weapons/bowfire.ogg' // pthwung
	slot_flags = ITEM_SLOT_BACK

	default_ammo_type = /obj/item/ammo_box/magazine/internal/bow
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/bow)
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	has_safety = FALSE
	gun_firemodes = list(FIREMODE_SEMIAUTO) // I fucking guess bro
	default_firemode = FIREMOD_SEMIAUTO

	force = 10
	attack_verb = list("whipped", "cracked")

	weapon_weight = WEAPON_HEAVY
	wield_slowdown = 0.1
	w_class = WEIGHT_CLASS_BULKY

	var/drawn = FALSE

/obj/item/gun/ballistic/bow/update_icon_state()
	. = ..()
	icon_state = chambered ? "bow_[drawn]" : "bow"

/obj/item/gun/ballistic/bow/chamber_round(keep_bullet = FALSE, spin_cylinder, replace_new_round)
	if(chambered || !magazine)
		return
	if(magazine.ammo_count())
		chambered = magazine.get_round(TRUE)
		chambered.forceMove(src)

/obj/item/gun/ballistic/bow/unique_action(mob/living/user)
	if(chambered)
		to_chat(user, span_notice("You [drawn ? "release" : "draw"] [src]'s string."))
		if(!drawn)
			playsound(src, 'sound/weapons/bowdraw.ogg', 75, 0)
		drawn = !drawn
	update_appearance()

/obj/item/gun/ballistic/bow/afterattack(atom/target, mob/living/user, flag, params, passthrough = FALSE)
	if(!chambered)
		return
	if(!wielded)
		to_chat(user, span_warning("You need both hands to fire this!"))
		return
	if(!drawn)
		to_chat(user, span_warning("The bow needs to be drawn first!"))
		return
	drawn = FALSE
	. = ..() //fires, removing the arrow
	update_appearance()

/obj/item/gun/ballistic/bow/shoot_with_empty_chamber(mob/living/user)
	return // no clicking sounds please

/obj/item/gun/ballistic/bow/serene
	name = "Model 5 Hunting Bow"
	desc = "A modern compound bow for hunting large game. Typically used in locations with heavy restrictions on firearms or by hunters with particular preferences. Chambered in 6.5x750 caseless - that is to say, it fires arrows."

/obj/item/storage/bag/quiver
	name = "quiver"
	desc = "A sturdy leather quiver. Used to hold arrows."
	icon_state = "quiver"
	item_state = "harpoon_quiver"
	var/arrow_path = /obj/item/ammo_casing/caseless/arrow

/obj/item/storage/bag/quiver/Initialize(mapload)
	. = ..()
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	storage.max_w_class = WEIGHT_CLASS_TINY
	storage.max_items = 40
	storage.max_combined_w_class = 100
	storage.set_holdable(list(/obj/item/ammo_casing/caseless/arrow))

/obj/item/storage/bag/quiver/PopulateContents()
	. = ..()
	if(arrow_path)
		for(var/i in 1 to 10)
			new arrow_path(src)

/obj/item/storage/bag/quiver/empty
	arrow_path = null
