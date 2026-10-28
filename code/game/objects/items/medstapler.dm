// MEDICAL STAPLER //
// stops bleeding and heals a bit of brute

/obj/item/med_stapler
	name = "medical stapler"
	desc = "A tool for quickly applying medical staples to open wounds. Designed to be relatively easy to use and minimize pain. Uses swappable single-use staple cartridges."
	icon = 'icons/obj/item/medical_stapler.dmi'
	icon_state = "stapler"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/med_staple_cart/cart // currently loaded staple cartridge

/obj/item/med_stapler/examine(mob/examiner)
	. = ..()
	if(cart)
		. += span_notice("An electronic display reports that the cartridge has [cart.qty] staples remaining.")
		. += span_notice("Use the stapler in hand to eject the cartridge.")
	else
		. += span_notice("There is no cartridge loaded.")
		. += span_notice("Use a cartridge on the stapler to load it.")

// handle the "full" overlay
/obj/item/med_stapler/update_overlays()
	. = ..()
	if(cart)
		. += "stapler_loaded"

// loading a new cartridge via slapping it onto the stapler
/obj/item/med_stapler/attackby(obj/item/attacking_item, mob/living/user)
	if(istype(attacking_item, /obj/item/med_staple_cart) && !cart)
		var/obj/item/med_staple_cart/new_cart = attacking_item
		if(new_cart.qty <= 0)
			to_chat(user, span_warning("The display blinks \"EMPTY\" and [src] rejects the cartridge!"))
			return FALSE
		if(!user.transferItemToLoc(new_cart, src))
			return FALSE
		cart = new_cart
		user.visible_message(span_notice("[user] loads a cartridge into [src]."),span_notice("You load [new_cart] into [src]."))
		update_appearance()
		playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
		return TRUE

// remove the cartridge if we have one
/obj/item/med_stapler/attack_self(mob/living/user)
	if(user && cart)
		if(user.incapacitated())
			return
		else
			cart.forceMove(user.loc)
			user.put_in_hands(cart)
			to_chat(user, span_notice("You remove [cart] from [src]."))
			cart = null
			update_appearance()
			playsound(loc, SOUND_EMPTY_MAG, 50, 1)

// attempt to staple what we attack
/obj/item/med_stapler/attack(mob/living/target, mob/user)
	try_staple(target, user)

// main loop for the repeating staple doafter
/obj/item/med_stapler/proc/try_staple(mob/living/target, mob/user, was_bleeding)
	// check if for whatever reason we do NOT want to staple the target
	// is our target a carbon that has limbs and such?
	if(!iscarbon(target))
		to_chat(user, span_warning("This won't help [target]!"))
		return
	// get reference to targeted limb
	var/obj/item/bodypart/limb = target.get_bodypart(check_zone(user.zone_selected))
	// does the limb we are targeting exist?
	if(!limb)
		to_chat(user, span_warning("There isn't a limb here to staple!"))
		return
	// is the limb we are targeting made of meat?
	if(!IS_ORGANIC_LIMB(limb))
		to_chat(user, span_warning("This won't work on a robotic limb!"))
		return
	// is our target pierce-proof?
	if(!target.can_inject(user))
		to_chat(user, span_warning("The staples won't punch through that!"))
		return
	// do we have a cartridge?
	if(!cart)
		to_chat(user, span_notice("There is no staple cartridge loaded!"))
		return
	// do we have staples in the cartridge?
	if(cart.qty == 0)
		to_chat(user, span_notice("The cartridge is empty!"))
		return
	// take a look at the limb's wounds to see if we have bleeding
	var/am_i_bleeding = FALSE
	for(var/i in limb.wounds)
		var/datum/wound/this_wound = i
		if(this_wound.blood_flow)
			am_i_bleeding = TRUE
			break
	// if we have plugged all bleeding on the limb, beep at our doctor and stop
	if(was_bleeding && !am_i_bleeding)
		to_chat(user, span_green("[src] reports that the bleeding on this limb has been stopped!"))
		playsound(loc, 'sound/effects/fastbeep.ogg', 25)
		return
	// do we actually need to heal the limb? (has brute or bleeding)
	if(!limb.brute_dam && !am_i_bleeding)
		to_chat(user, span_notice("Nothing more needs to be done here."))
		return
	// use a longer delay if we're stapling ourselves
	var/delay = user == target ? 0.8 SECONDS : 0.4 SECONDS
	// did we successfully complete our do_after?
	if(!do_after(user, delay, target = target))
		return
	// all checks passed. perform the staple
	staple(target, user, limb)
	// then repeat until we can't
	if(cart.qty > 0)
		try_staple(target, user, am_i_bleeding)

// proc for actually performing the staple
/obj/item/med_stapler/proc/staple(mob/living/target, mob/user, obj/item/bodypart/limb)
	cart.qty--
	playsound(src, 'sound/items/syringeproj.ogg', 25)
	target.heal_bodypart_damage(2) // little bit of brute
	for(var/i in limb.wounds)
		var/datum/wound/this_wound = i
		if(this_wound.blood_flow)
			this_wound.blood_flow -= 0.2 // half a suture
			break // only heals one wound at a time
	user.visible_message(
		span_green("[user] staples some of the wounds on [target]."),
		span_green("You staple some of the wounds on [user == target ? "yourself" : "[target]"]."))

// subtype that starts full
/obj/item/med_stapler/full/Initialize()
	. = ..()
	cart = new /obj/item/med_staple_cart
	update_appearance()

// STAPLE CARTRIDGE //
/obj/item/med_staple_cart
	name = "medical staple cartridge"
	desc = "A sealed cartridge containing sterile staples tipped with a fast-acting local anesthetic. For use in a medical stapler."
	icon = 'icons/obj/item/medical_stapler.dmi'
	icon_state = "staple_cartridge"
	w_class = WEIGHT_CLASS_TINY
	var/qty = 40 // how many staples we have remaining

/obj/item/med_staple_cart/examine(mob/examiner)
	. = ..()
	if(qty == 0)
		. += span_notice("It is spent.")
	else
		. += span_notice("It has [qty] staples remaining.")
