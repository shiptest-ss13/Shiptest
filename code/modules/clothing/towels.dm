/// Default shape of the towel, when it's folded.
#define TOWEL_FOLDED ""
/// Chest-down variant of the towel.
#define TOWEL_FULL "chest"
/// Waist-down variant of the towel.
#define TOWEL_WAIST "waist"
/// Head variant of the towel.
#define TOWEL_HEAD "head"
/// Shape of the towel when it has been used, and is no longer neatly folded.
#define TOWEL_USED "used"

/// Icon path to the obj icon of the towel.
#define TOWEL_OBJ_ICON 'icons/obj/clothing/towel.dmi'
/// Icon path to the worn icon of the towel.
#define TOWEL_WORN_ICON 'icons/mob/clothing/towel.dmi'

/// How much cloth goes into a towel.
#define TOWEL_CLOTH_AMOUNT 2

/obj/item/towel
	name = "towel"
	desc = "Everyone knows what a towel is. Use it to dry yourself, or wear it around your chest, your waist or even your head!"
	icon = TOWEL_OBJ_ICON
	mob_overlay_icon = TOWEL_WORN_ICON
	icon_state = "towel"
	base_icon_state = "towel"
	force = 0
	throwforce = 0
	throw_speed = 1
	throw_range = 3 // They're not very aerodynamic.
	w_class = WEIGHT_CLASS_SMALL // Don't ask me why other cloth-related items are considered tiny, and not small like this one.
	item_flags = NOBLUDGEON
	resistance_flags = FLAMMABLE
	flags_inv = HIDEHAIR // Only relevant when in head shape, but useful to keep around regardless.
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION
	/// The shape we're currently in.
	var/shape = TOWEL_FOLDED

/obj/item/towel/full
	shape = TOWEL_FULL
	icon_state = "towel-chest"
	slot_flags = ITEM_SLOT_OCLOTHING

/obj/item/towel/waist
	shape = TOWEL_WAIST
	icon_state = "towel-waist"
	slot_flags = ITEM_SLOT_OCLOTHING

/obj/item/towel/head
	shape = TOWEL_HEAD
	icon_state = "towel-head"
	slot_flags = ITEM_SLOT_HEAD

/obj/item/towel/Initialize()
	. = ..()
	change_towel_shape(null, shape)

/obj/item/towel/examine(mob/user)
	. = ..()

	if(!ishuman(user) && !iscyborg(user))
		return

	. += "" // Just for an empty line

	var/in_hands = TRUE
	if(ishuman(user))
		in_hands = user.get_active_held_item() == src || user.get_inactive_held_item() == src

		if(in_hands)
			. += span_notice("<b>Use in hand</b> to shape [src] into something different.")

	if(iscyborg(user))
		return

	if(in_hands && shape != TOWEL_FOLDED)
		. += span_notice("<b>Ctrl-click</b> to fold [src] neatly.")

	if(shape == TOWEL_FULL || shape == TOWEL_WAIST)
		. += span_notice("<b>Alt-click</b> to adjust the fit of [src].")

/obj/item/towel/attack_self(mob/user, modifiers)
	. = ..()

	/// Initializing this only once to avoid having to do it every time
	var/static/list/datum/radial_menu_choice/worn_options = list()

	if(!length(worn_options))
		for(var/variant in list(TOWEL_FULL, TOWEL_WAIST, TOWEL_HEAD))
			var/datum/radial_menu_choice/option = new
			var/image/variant_image = image(icon = TOWEL_OBJ_ICON, icon_state = "[base_icon_state]-[variant]")

			option.image = variant_image
			worn_options[capitalize(variant)] = option

	var/choice = show_radial_menu(user, src, worn_options, require_near = TRUE, tooltips = TRUE)

	if(!choice)
		return

	change_towel_shape(user, lowertext(choice))

/obj/item/towel/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		var/obj/item/stack/sheet/cotton/cloth/shreds = new (get_turf(src), 3)
		if(!QDELETED(shreds)) //stacks merged
			transfer_fingerprints_to(shreds)
			shreds.add_fingerprint(user)
		qdel(src)
		to_chat(user, span_notice("You tear [src] up."))
	else
		return ..()

/obj/item/towel/attack(mob/living/target_mob, mob/living/user)
	. = ..()
	while(target_mob.has_status_effect(/datum/status_effect/fire_handler/wet_stacks) && do_after(user, 15, target = target_mob, hidden = TRUE))
		target_mob.adjust_wet_stacks(-1)
	to_chat(user, span_notice("You dry [target_mob] off with your towel."))

/obj/item/towel/CtrlClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(. == FALSE)
		return
	if(shape == TOWEL_FOLDED)
		to_chat(user, span_warning("You can't fold a towel that's already folded!"))
	var/in_hands = TRUE
	if(ishuman(user) && shape == TOWEL_USED)
		in_hands = user.get_active_held_item() == src || user.get_inactive_held_item() == src
		if(in_hands)
			change_towel_shape(user, TOWEL_FOLDED, silent = TRUE)
			to_chat(user, span_notice("You fold [src] up neatly."))
		return

/obj/item/towel/AltClick(mob/user)
	. = ..()

	if(. == FALSE)
		return

	if(!(shape == TOWEL_FULL || shape == TOWEL_WAIST))
		return FALSE

	if(!ishuman(user))
		return FALSE

	var/mob/living/carbon/human/towel_user = user
	var/worn = towel_user.wear_suit == src

	change_towel_shape(user, shape == TOWEL_FULL ? TOWEL_WAIST : TOWEL_FULL, silent = worn)

	// No need to display the different message if they're not wearing it.
	if(!worn)
		return

	to_chat(user, span_notice(shape == TOWEL_FULL ? "You raise \the [src] over your [shape]." : "You lower \the [src] down to your [shape]."))

/obj/item/towel/machine_wash(obj/machinery/washing_machine/washer)
	. = ..() // This isn't really needed, including it in case we ever get dyeable towels.
	make_used(null, silent = TRUE)

/obj/item/towel/dropped(mob/user, silent)
	. = ..()

	if(!ishuman(loc) && shape != TOWEL_FOLDED)
		make_used(user, silent = TRUE)

/*
 * Helper to change the shape of the towel, so that it updates its look both
 * in-hand and on the body of the wearer.
 *
 * Arguments:
 * * user - Mob that's trying to change the shape of the towel.
 * * new_shape - The new shape that the towel can be in.
 * * silent (optional) - Whether we produce a to_chat to the user to elaborate on
 * the new shape it is now in. Requires `user` to be non-null if `TRUE` in order to
 * do anything. Defaults to `FALSE`.
 */
/obj/item/towel/proc/change_towel_shape(mob/user, new_shape, silent = FALSE)
	if(new_shape == shape)
		return

	shape = new_shape

	icon_state = "[base_icon_state][shape ? "-[shape]" : ""]"

	if(shape == TOWEL_HEAD)
		flags_inv |= HIDEHAIR
	else
		flags_inv &= ~HIDEHAIR

	update_appearance()
	update_slot_related_flags()

	if(!silent && user)
		to_chat(user, span_notice(shape ? "You adjust [src] so that it can be worn over your [shape]." : "You fold [src] neatly."))

/*
 * Helper proc to change the slot flags of the towel based on its shape.
 */
/obj/item/towel/proc/update_slot_related_flags()
	switch(shape)
		if(TOWEL_FULL)
			slot_flags = ITEM_SLOT_OCLOTHING
			body_parts_covered = CHEST | GROIN | LEGS

		if(TOWEL_WAIST)
			slot_flags = ITEM_SLOT_OCLOTHING
			body_parts_covered = GROIN | LEGS

		if(TOWEL_HEAD)
			slot_flags = ITEM_SLOT_HEAD
			body_parts_covered = HEAD

		else
			slot_flags = NONE
			body_parts_covered = NONE

	update_slot_icon()

/*
 * Simple helper to make the towel into a used towel shape.
 *
 * Arguments:
 * * user - Mob that's making the towel used. Can be null if `silent` is `FALSE`.
 * * silent (optional) - Whether we produce a to_chat to the user to elaborate on
 * the new shape it is now in. Requires `user` to be non-null if `TRUE` in order to
 * do anything. Defaults to `FALSE`.
 */
/obj/item/towel/proc/make_used(mob/user, silent = FALSE)
	change_towel_shape(user, TOWEL_USED, silent)
