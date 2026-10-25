/obj/item/gun/ballistic/bow
	name = "HP Longbow"
	desc = "A modern rendition of a prehistoric weapon, built by Hunter's Pride. While much harder to operate than a firearm, it is very quiet and packs quite a punch. Chambered in 6.5x750 caseless - that is to say, it fires arrows."
	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'

	icon_state = "bow"
	base_icon_state = "bow"
	item_state = "bow"

	load_sound = null
	fire_sound = 'sound/weapons/bowfire.ogg' // pthwung
	light_range = 0 // no muzzle flash
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	default_ammo_type = /obj/item/ammo_box/magazine/internal/bow
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/internal/bow)
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	has_safety = FALSE
	safety = FALSE
	gun_firemodes = list(FIREMODE_SEMIAUTO) // like I fucking guess bro
	default_firemode = FIREMODE_SEMIAUTO
	casing_ejector = FALSE
	cartridge_wording = "arrow"
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	force = 10
	attack_verb = list("whipped", "cracked")

	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY

	wield_delay = 0.4 SECONDS
	wield_slowdown = 0.1

	unique_reskin = list( "Default" = "bow", "Dark" = "bow_dark")
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_inhand = TRUE

	valid_attachments = list(/obj/item/attachment/ammo_counter)
	slot_available = list(ATTACHMENT_SLOT_RAIL = 1)

	// BOW VARS //
	var/drawn = FALSE // is the bow drawn
	var/drawn_fully = FALSE // is the bow drawn all the way
	var/draw_time = 1 SECONDS // time to draw the bow all the way
	var/draw_slowdown = 0.5 // slowdown during draw

/obj/item/gun/ballistic/bow/examine(mob/examiner)
	. = ..()
	. += span_notice("Use <b>unique action</b> to draw the bow.")

/obj/item/gun/ballistic/bow/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/obj/item/gun/ballistic/bow/proc/update_draw_slowdown(mob/living/user)
	if(drawn)
		user.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bow, multiplicative_slowdown = draw_slowdown)
	else
		user.remove_movespeed_modifier(/datum/movespeed_modifier/bow)

/obj/item/gun/ballistic/bow/proc/on_drop(datum/source, mob/living/user)
	if(drawn)
		discharge()
	update_appearance()
	drawn = FALSE
	drawn_fully = FALSE
	update_draw_slowdown(user)

/obj/item/gun/ballistic/bow/on_unwield(obj/item/source, mob/user)
	. = ..()
	on_drop(source, user)

/obj/item/gun/ballistic/bow/update_overlays()
	. = ..()
	if(chambered)
		. += "arrow[drawn ? "_drawn" : ""]"

/obj/item/gun/ballistic/bow/update_icon_state()
	. = ..()
	if(drawn)
		icon_state = "[base_icon_state]_drawn"
	else
		icon_state = base_icon_state

/obj/item/gun/ballistic/bow/chamber_round(keep_bullet = FALSE, spin_cylinder, replace_new_round)
	if(chambered || !magazine)
		return
	if(magazine.ammo_count())
		chambered = magazine.get_round(TRUE)
		SEND_SIGNAL(src, COMSIG_GUN_CHAMBER_PROCESSED) // makes the ammo counter work

/obj/item/gun/ballistic/bow/proc/on_draw(mob/user)
	if(do_after(user, draw_time, user,
		IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE, TRUE))
		if(drawn)
			drawn_fully = TRUE
	else
		drawn = FALSE

/obj/item/gun/ballistic/bow/unique_action(mob/living/user)
	if(!wielded_fully)
		to_chat(user, span_warning("You need both hands to draw this!"))
		return
	if(chambered)
		to_chat(user, span_notice("You [drawn ? "release" : "draw"] [src]'s string."))
		if(!drawn)
			playsound(src, 'sound/weapons/bowdraw.ogg', 75, 0)
			INVOKE_ASYNC(src, PROC_REF(on_draw), user)
		else
			drawn_fully = FALSE
		drawn = !drawn
		update_draw_slowdown(user)
		update_appearance()
	else
		to_chat(user, span_warning("Load the bow first!"))

/obj/item/gun/ballistic/bow/afterattack(atom/target, mob/living/user, flag, params, passthrough = FALSE)
	if(!chambered)
		return
	if(!wielded)
		to_chat(user, span_warning("You need both hands to fire this!"))
		return
	if(!drawn)
		to_chat(user, span_warning("The bow needs to be drawn first!"))
		return
	if(!drawn_fully)
		to_chat(user, span_warning("The bow needs to be fully drawn first!"))
		return
	drawn = FALSE
	drawn_fully = FALSE
	update_draw_slowdown(user)
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/bow/shoot_with_empty_chamber(mob/living/user)
	return // no clicking sounds please

// this makes the arrow not DELETE ITSELF for caseless reasons. joys
/obj/item/gun/ballistic/bow/eject_casing(mob/user, obj/item/ammo_casing/casing)
	if(!user.put_in_hands(casing))
		casing.forceMove(drop_location())

// QUIVER (in dire need of a resprite!) //

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
