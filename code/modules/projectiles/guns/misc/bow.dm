/obj/item/gun/ballistic/bow
	name = "longbow"
	desc = "While pretty finely crafted, surely you can find something better to use in the current year."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "bow"
	item_state = "pipebow"
	load_sound = null
	fire_sound = 'whitesands/sound/weapons/bowfire.ogg'
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/bow
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	force = 15
	attack_verb = list("whipped", "cracked")
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	var/drawn = FALSE

/obj/item/gun/ballistic/bow/update_icon()
	. = ..()
	if(!chambered)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_[drawn]"

/obj/item/gun/ballistic/bow/chamber_round(keep_bullet = FALSE, spin_cylinder, replace_new_round)
	if(chambered || !magazine)
		return
	if(magazine.ammo_count())
		chambered = magazine.get_round(TRUE)
		chambered.forceMove(src)

/obj/item/gun/ballistic/bow/attack_self(mob/user)
	if(chambered)
		to_chat(user, "<span class='notice'>You [drawn ? "release the tension on" : "draw the string on"] [src].</span>")
		if(!drawn)
			playsound(src, 'whitesands/sound/weapons/bowdraw.ogg', 75, 0)
		drawn = !drawn
	update_icon()

/obj/item/gun/ballistic/bow/afterattack(atom/target, mob/living/user, flag, params, passthrough = FALSE)
	if(!chambered)
		return
	if(!drawn)
		to_chat(user, "<span clasas='warning'>You can't shoot without drawing the bow.</span>")
		return
	drawn = FALSE
	. = ..() //fires, removing the arrow
	update_icon()

/obj/item/gun/ballistic/bow/shoot_with_empty_chamber(mob/living/user)
	return //so clicking sounds please

/obj/item/gun/ballistic/bow/ashen
	name = "Bone Bow"
	desc = "Some sort of primitive projectile weapon made of bone and wrapped sinew."
	icon_state = "ashenbow"
	item_state = "ashenbow"
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	lefthand_file = 'whitesands/icons/mob/inhands/weapons/guns_left.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/weapons/guns_right.dmi'
	force = 8

/obj/item/gun/ballistic/bow/pipe
	name = "Pipe Bow"
	desc = "A crude projectile weapon made from silk string, pipe and lots of bending."
	icon_state = "pipebow"
	force = 7

/obj/item/ammo_casing/caseless/arrow/despawning/dropped()
	. = ..()
	addtimer(CALLBACK(src, .proc/floor_vanish), 5 SECONDS)

/obj/item/ammo_casing/caseless/arrow/despawning/proc/floor_vanish()
	if(isturf(loc))
		qdel(src)

/obj/item/storage/bag/quiver
	name = "quiver"
	desc = "Holds arrows for your bow. Good, because while pocketing arrows is possible, it surely can't be pleasant."
	icon_state = "quiver"
	item_state = "harpoon_quiver"
	var/arrow_path = /obj/item/ammo_casing/caseless/arrow

/obj/item/storage/bag/quiver/Initialize(mapload)
	. = ..()
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	storage.max_w_class = WEIGHT_CLASS_TINY
	storage.max_items = 40
	storage.max_combined_w_class = 100
	storage.set_holdable(list(
		/obj/item/ammo_casing/caseless/arrow
		))

/obj/item/storage/bag/quiver/PopulateContents()
	. = ..()
	if(arrow_path)
		for(var/i in 1 to 10)
			new arrow_path(src)

/obj/item/storage/bag/quiver/despawning
	arrow_path = /obj/item/ammo_casing/caseless/arrow/despawning

/obj/item/storage/bag/quiver/empty
	name = "leather quiver"
	desc = "A quiver made from the hide of some animal. Used to hold arrows."
	arrow_path = null
	icon = 'whitesands/icons/obj/items_and_weapons.dmi'
