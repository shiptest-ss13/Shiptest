#define RESOLVE_ICON_STATE(I) (I.mob_overlay_state || I.icon_state)

	///////////////////////
	//UPDATE_ICONS SYSTEM//
	///////////////////////
/* Keep these comments up-to-date if you -insist- on hurting my code-baby ;_;
This system allows you to update individual mob-overlays, without regenerating them all each time.
When we generate overlays we generate the standing version and then rotate the mob as necessary..

As of the time of writing there are 20 layers within this list. Please try to keep this from increasing. //22 and counting, good job guys
	var/overlays_standing[20]		//For the standing stance

Most of the time we only wish to update one overlay:
	e.g. - we dropped the fireaxe out of our left hand and need to remove its icon from our mob
	e.g.2 - our hair colour has changed, so we need to update our hair icons on our mob
In these cases, instead of updating every overlay using the old behaviour (regenerate_icons), we instead call
the appropriate update_X proc.
	e.g. - update_l_hand()
	e.g.2 - update_hair()

Note: Recent changes by aranclanos+carn:
	update_icons() no longer needs to be called.
	the system is easier to use. update_icons() should not be called unless you absolutely -know- you need it.
	IN ALL OTHER CASES it's better to just call the specific update_X procs.

Note: The defines for layer numbers is now kept exclusvely in __DEFINES/misc.dm instead of being defined there,
	then redefined and undefiend everywhere else. If you need to change the layering of sprites (or add a new layer)
	that's where you should start.

All of this means that this code is more maintainable, faster and still fairly easy to use.

There are several things that need to be remembered:
>	Whenever we do something that should cause an overlay to update (which doesn't use standard procs
	( i.e. you do something like l_hand = /obj/item/something new(src), rather than using the helper procs)
	You will need to call the relevant update_inv_* proc

	All of these are named after the variable they update from. They are defined at the mob/ level like
	update_clothing was, so you won't cause undefined proc runtimes with usr.update_inv_wear_id() if the usr is a
	slime etc. Instead, it'll just return without doing any work. So no harm in calling it for slimes and such.


>	There are also these special cases:
		update_damage_overlays()	//handles damage overlays for brute/burn damage
		update_body()				//Handles updating your mob's body layer and mutant bodyparts
									as well as sprite-accessories that didn't really fit elsewhere (underwear, undershirts, socks, lips, eyes)
									//NOTE: update_mutantrace() is now merged into this!
		update_hair()				//Handles updating your hair overlay (used to be update_face, but mouth and
									eyes were merged into update_body())


*/

//HAIR OVERLAY
/mob/living/carbon/human/update_hair()
	dna.species.handle_hair(src)

//used when putting/removing clothes that hide certain mutant body parts to just update those and not update the whole body.
/mob/living/carbon/human/proc/update_mutant_bodyparts()
	dna.species.handle_mutant_bodyparts(src)


/mob/living/carbon/human/update_body()
	remove_overlay(BODY_LAYER)
	dna.species.handle_body(src)

/mob/living/carbon/human/update_fire()
	..((fire_stacks > HUMAN_FIRE_STACK_ICON_NUM) ? "Standing" : "Generic_mob_burning")


/* --------------------------------------- */
//For legacy support.
/mob/living/carbon/human/regenerate_icons()
	if(!..())
		update_body()
		update_hair()
		update_inv_w_uniform()
		update_inv_wear_id()
		update_inv_gloves()
		update_inv_glasses()
		update_inv_ears()
		update_inv_shoes()
		update_inv_s_store()
		update_inv_wear_mask()
		update_inv_head()
		update_inv_belt()
		update_inv_back()
		update_inv_wear_suit()
		update_inv_pockets()
		update_inv_neck()
		update_transform()
		//mutations
		update_mutations_overlay()
		//damage overlays
		update_damage_overlays()

/* --------------------------------------- */
//vvvvvv UPDATE_INV PROCS vvvvvv

/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ICLOTHING) + 1]
		inv.update_appearance()

	if(istype(w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = w_uniform
		update_hud_uniform(U)

		if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
			return



		var/t_color = U.item_color
		if(!t_color)
			t_color = U.icon_state
		if(U.adjusted == ALT_STYLE)
			t_color = "[t_color]_d"

		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/uniform_overlay

		///icon file of the clothing
		var/icon_file = U.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = U.icon_state
		if(U.adjusted == ALT_STYLE)
			target_overlay = "[target_overlay]_d"
		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if(!uniform_overlay)
			//Kapu's autistic attempt at digitigrade handling
			//Hi Kapu
			if((dna.species.bodytype & BODYTYPE_DIGITIGRADE) && ((U.supports_variations & DIGITIGRADE_VARIATION) || (U.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)))
				icon_file = DIGITIGRADE_PATH
				if((U.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE))
					icon_file = U.mob_overlay_icon
					target_overlay = "[target_overlay]_digi"

			else if(dna.species.bodytype & BODYTYPE_VOX)
				if(U.supports_variations & VOX_VARIATION)
					icon_file = VOX_UNIFORM_PATH
					if(U.vox_override_icon)
						icon_file = U.vox_override_icon
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
				if(U.supports_variations & KEPORI_VARIATION)
					icon_file = KEPORI_UNIFORM_PATH
					if(U.kepori_override_icon)
						icon_file = U.kepori_override_icon
				else
					handled_by_bodytype = TRUE


			if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(U))))
				handled_by_bodytype = TRUE
				icon_file = U.mob_overlay_icon || DEFAULT_UNIFORM_PATH

			var/use_autogen = handled_by_bodytype ? dna.species : null
			uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, override_file = icon_file, override_state = target_overlay, mob_species = use_autogen)

		if(!uniform_overlay)
			return
		overlays_standing[UNIFORM_LAYER] = uniform_overlay

		if(uniform_overlay) //This is faster fuck you
			apply_overlay(UNIFORM_LAYER)

	update_mutant_bodyparts()


/mob/living/carbon/human/update_inv_wear_id()
	remove_overlay(ID_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ID) + 1]
		inv.update_appearance()

	var/mutable_appearance/id_overlay = overlays_standing[ID_LAYER]

	if(wear_id)
		var/obj/item/I = wear_id
		update_hud_id(I)
		var/handled_by_bodytype

		//TODO: add an icon file for ID slot stuff, so it's less snowflakey
		var/use_autogen = handled_by_bodytype ? dna.species : null
		id_overlay = I.build_worn_icon(default_layer = ID_LAYER, default_icon_file = 'icons/mob/mob.dmi', mob_species = use_autogen)

		if(!id_overlay)
			return
		overlays_standing[ID_LAYER] = id_overlay


/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_appearance()

	//Bloody hands begin
	if(!gloves && blood_in_hands && (num_hands > 0))
		var/overlay_file = 'icons/effects/blood.dmi'
		var/custom_overlay_icon = dna.species.custom_overlay_icon
		if(custom_overlay_icon)
			overlay_file = custom_overlay_icon
		var/mutable_appearance/bloody_overlay = mutable_appearance(overlay_file, "handsblood", -GLOVES_LAYER)
		if(num_hands < 2)
			if(has_left_hand(FALSE))
				bloody_overlay.icon_state = "handsblood_left"
			else if(has_right_hand(FALSE))
				bloody_overlay.icon_state = "handsblood_right"
		var/list/blood_dna = return_blood_DNA()
		if(length(blood_dna))
			bloody_overlay.color = get_blood_dna_color(return_blood_DNA())

		overlays_standing[GLOVES_LAYER] = bloody_overlay
	//Bloody hands end



	if(gloves)
		var/obj/item/I = gloves
		update_hud_gloves(I)

		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/gloves_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_GLOVES_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_GLOVES_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = DEFAULT_GLOVES_PATH

		var/use_autogen = handled_by_bodytype ? dna.species : null
		gloves_overlay = I.build_worn_icon(default_layer = GLOVES_LAYER, default_icon_file = icon_file, override_file = icon_file, mob_species = use_autogen)

		if(!gloves_overlay)
			return
		overlays_standing[GLOVES_LAYER] = gloves_overlay
	apply_overlay(GLOVES_LAYER)


/mob/living/carbon/human/update_inv_glasses()
	remove_overlay(GLASSES_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EYES) + 1]
		inv.update_appearance()

	if(glasses)
		var/obj/item/I = glasses
		update_hud_glasses(I)
		if(!(head?.flags_inv & HIDEEYES) && !(wear_mask?.flags_inv & HIDEEYES))
			///The final thing we overlay. Set on build_worn_icon.
			var/mutable_appearance/glasses_overlay

			///icon file of the clothing
			var/icon_file = I.mob_overlay_icon

			/// Does this clothing need to be generated via greyscale?
			var/handled_by_bodytype = FALSE

			if(dna.species.bodytype & BODYTYPE_VOX)
				if(I.supports_variations & VOX_VARIATION)
					icon_file = VOX_GLASSES_PATH
					if(I.vox_override_icon)
						icon_file = I.vox_override_icon
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
				if(I.supports_variations & KEPORI_VARIATION)
					icon_file = KEPORI_GLASSES_PATH
					if(I.kepori_override_icon)
						icon_file = I.kepori_override_icon
				else
					handled_by_bodytype = TRUE

			if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
				handled_by_bodytype = TRUE
				icon_file = DEFAULT_GLASSES_PATH

			var/use_autogen = handled_by_bodytype ? dna.species : null
			glasses_overlay = I.build_worn_icon(default_layer = GLASSES_LAYER, default_icon_file = icon_file, override_file = icon_file, mob_species = use_autogen)

			if(!glasses_overlay)
				return
			overlays_standing[GLASSES_LAYER] = glasses_overlay
	apply_overlay(GLASSES_LAYER)


/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EARS) + 1]
		inv.update_appearance()

	if(ears)
		var/obj/item/I = ears
		update_hud_ears(I)

		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/ears_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_EARS_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_EARS_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = DEFAULT_EARS_PATH

		var/use_autogen = handled_by_bodytype ? dna.species : null
		ears_overlay = I.build_worn_icon(default_layer = EARS_LAYER, override_file = icon_file, mob_species = use_autogen)

		if(!ears_overlay)
			return
		overlays_standing[EARS_LAYER] = ears_overlay
	apply_overlay(EARS_LAYER)


/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)

	if(num_legs < 2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
		inv.update_appearance()

	if(shoes)
		var/obj/item/I = shoes
		update_hud_shoes(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/shoes_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = I.icon_state

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if((dna.species.bodytype & BODYTYPE_DIGITIGRADE) && ((I.supports_variations & DIGITIGRADE_VARIATION) || (I.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)))
			var/obj/item/bodypart/leg = src.get_bodypart(BODY_ZONE_L_LEG)
			if(leg.bodytype & BODYTYPE_DIGITIGRADE && !leg.plantigrade_forced)
				icon_file = DIGITIGRADE_SHOES_PATH
			if((I.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE))
				icon_file = I.mob_overlay_icon
				target_overlay = "[target_overlay]_digi"

		else if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_SHOES_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_SHOES_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = DEFAULT_SHOES_PATH

		var/use_autogen = handled_by_bodytype ? dna.species : null
		shoes_overlay = I.build_worn_icon(default_layer = SHOES_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, mob_species = use_autogen, override_state = target_overlay)

		if(!shoes_overlay)
			return
		overlays_standing[SHOES_LAYER] = shoes_overlay

	apply_overlay(SHOES_LAYER)


/mob/living/carbon/human/update_inv_s_store()
	remove_overlay(SUIT_STORE_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_SUITSTORE) + 1]
		inv.update_appearance()

	if(s_store)
		var/obj/item/I = s_store
		update_hud_s_store(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/suit_store_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon

		/// Does this clothing need to be generated via greyscale
		var/handled_by_bodytype = FALSE

		if(!suit_store_overlay)
			if(dna.species.bodytype & BODYTYPE_VOX)
				if(I.supports_variations & VOX_VARIATION)
					icon_file = VOX_BACK_PATH
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
//				if(I.supports_variations & KEPORI_VARIATION)
//					icon_file = KEPORI_BACK_PATH
//				else
				handled_by_bodytype = TRUE

			if(!icon_exists(icon_file, RESOLVE_ICON_STATE(I)))
				icon_file = DEFAULT_BACK_PATH
				handled_by_bodytype = TRUE

			var/use_autogen = handled_by_bodytype ? dna.species : null
			suit_store_overlay = I.build_worn_icon(default_layer = -SUIT_STORE_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, override_file = icon_file, mob_species = use_autogen)

			if(!suit_store_overlay)
				return
			overlays_standing[SUIT_STORE_LAYER] = suit_store_overlay

			if(suit_store_overlay)
				apply_overlay(SUIT_STORE_LAYER)


/mob/living/carbon/human/update_inv_head()
	remove_overlay(HEAD_LAYER)
	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_appearance()
	if(head)
		var/obj/item/I = head
		update_hud_head(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/head_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = I.icon_state

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		var/obj/item/bodypart/head_bodypart = src.get_bodypart(BODY_ZONE_HEAD)
		if((head_bodypart.bodytype & BODYTYPE_SNOUT) && (I.supports_variations & SNOUTED_VARIATION))
			target_overlay = "[target_overlay]_snouted"

		else if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_HEAD_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_HEAD_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = DEFAULT_HEAD_PATH

		var/use_autogen = handled_by_bodytype ? dna.species : null
		head_overlay = I.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, mob_species = use_autogen, override_state = target_overlay)

		if(!head_overlay)
			return
		overlays_standing[HEAD_LAYER] = head_overlay

	update_mutant_bodyparts()
	apply_overlay(HEAD_LAYER)

/mob/living/carbon/human/update_inv_belt()
	remove_overlay(BELT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BELT) + 1]
		inv.update_appearance()

	if(belt)
		var/obj/item/I = belt
		update_hud_belt(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/belt_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE


		if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_BELT_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_BELT_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = DEFAULT_BELT_PATH

		var/use_autogen = handled_by_bodytype ? dna.species : null
		belt_overlay = I.build_worn_icon(default_layer = BELT_LAYER, default_icon_file = icon_file, override_file = icon_file, mob_species = use_autogen)

		if(!belt_overlay)
			return
		overlays_standing[BELT_LAYER] = belt_overlay

	apply_overlay(BELT_LAYER)



/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_OCLOTHING) + 1]
		inv.update_appearance()

	if(wear_suit)
		var/obj/item/I = wear_suit
		update_hud_wear_suit(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/suit_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = I.icon_state

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if((dna.species.bodytype & BODYTYPE_DIGITIGRADE) && ((I.supports_variations & DIGITIGRADE_VARIATION) || (I.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)))
			icon_file = DIGITIGRADE_SUIT_PATH
			if((I.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE))
				icon_file = I.mob_overlay_icon
				target_overlay = "[target_overlay]_digi"

		else if(dna.species.bodytype & BODYTYPE_VOX)
			if(I.supports_variations & VOX_VARIATION)
				icon_file = VOX_SUIT_PATH
				if(I.vox_override_icon)
					icon_file = I.vox_override_icon
			else
				handled_by_bodytype = TRUE

		else if(dna.species.bodytype & BODYTYPE_KEPORI)
			if(I.supports_variations & KEPORI_VARIATION)
				icon_file = KEPORI_SUIT_PATH
				if(I.kepori_override_icon)
					icon_file = I.kepori_override_icon
			else
				handled_by_bodytype = TRUE

		if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
			handled_by_bodytype = TRUE
			icon_file = I.mob_overlay_icon

		var/use_autogen = handled_by_bodytype ? dna.species : null
		suit_overlay = wear_suit.build_worn_icon(default_layer = SUIT_LAYER, override_file = icon_file, mob_species = use_autogen, override_state = target_overlay)

		if(!suit_overlay)
			return
		overlays_standing[SUIT_LAYER] = suit_overlay
	update_hair()
	update_mutant_bodyparts()

	apply_overlay(SUIT_LAYER)


/mob/living/carbon/human/update_inv_pockets()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_LPOCKET) + 1]
		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_RPOCKET) + 1]

		inv.update_appearance()

		if(l_store)
			l_store.screen_loc = ui_storage1
			if(hud_used.hud_shown)
				client.screen += l_store
			update_observer_view(l_store)

		if(r_store)
			r_store.screen_loc = ui_storage2
			if(hud_used.hud_shown)
				client.screen += r_store
			update_observer_view(r_store)


/mob/living/carbon/human/update_inv_wear_mask()
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_appearance()

	if(wear_mask)
		var/obj/item/I = wear_mask
		update_hud_wear_mask(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/mask_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = I.icon_state

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE

		if(!(ITEM_SLOT_MASK in check_obscured_slots()))
			var/obj/item/bodypart/head_bodypart = src.get_bodypart(BODY_ZONE_HEAD)
			if((head_bodypart.bodytype & BODYTYPE_SNOUT) && (I.supports_variations & SNOUTED_VARIATION))
				target_overlay = "[target_overlay]_snouted"

			if((head_bodypart.bodytype & BODYTYPE_SNOUT_SMALL) && (I.supports_variations & SNOUTED_SMALL_VARIATION))
				target_overlay = "[target_overlay]_snouted_small"

			if(dna.species.bodytype & BODYTYPE_VOX)
				if(I.supports_variations & VOX_VARIATION)
					icon_file = VOX_MASK_PATH
					if(I.vox_override_icon)
						icon_file = I.vox_override_icon
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
				if(I.supports_variations & KEPORI_VARIATION)
					icon_file = KEPORI_MASK_PATH
					if(I.kepori_override_icon)
						icon_file = I.kepori_override_icon
				else
					handled_by_bodytype = TRUE

			if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
				icon_file = DEFAULT_MASK_PATH
				handled_by_bodytype = TRUE

			var/use_autogen = handled_by_bodytype ? dna.species : null
			mask_overlay = I.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = icon_file, override_file = icon_file, mob_species = use_autogen, override_state = target_overlay)

		if(!mask_overlay)
			return

		overlays_standing[FACEMASK_LAYER] = mask_overlay

	apply_overlay(FACEMASK_LAYER)

/mob/living/carbon/human/update_inv_neck()
	remove_overlay(NECK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1]
		inv.update_appearance()

	if(wear_neck)
		var/obj/item/I = wear_neck
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/neck_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon
		///The icon state to overlay
		var/target_overlay = I.icon_state

		/// Does this clothing need to be generated via greyscale?
		var/handled_by_bodytype = FALSE


		update_hud_neck(I)

		if(!(ITEM_SLOT_NECK in check_obscured_slots()))

			if(dna.species.bodytype & BODYTYPE_VOX) // there is no kepori neck path, we just tell it to greyscale no matter what
				if(I.supports_variations & VOX_VARIATION)
					icon_file = VOX_NECK_PATH
					if(I.vox_override_icon)
						icon_file = I.vox_override_icon
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
//				if(I.supports_variations & KEPORI_VARIATION)
//					icon_file = KEPORI_NECK_PATH
//					if(I.kepoi_override_icon)
//						icon_file = I.kepoi_override_icon
//				else
				handled_by_bodytype = TRUE

			if(!(icon_exists(icon_file, RESOLVE_ICON_STATE(I))))
				handled_by_bodytype = TRUE
				icon_file = DEFAULT_NECK_PATH

			var/use_autogen = handled_by_bodytype ? dna.species : null
			neck_overlay = I.build_worn_icon(default_layer = NECK_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, mob_species = use_autogen, override_state = target_overlay)

			if(!neck_overlay)
				return

		overlays_standing[NECK_LAYER] = neck_overlay

	apply_overlay(NECK_LAYER)

/mob/living/carbon/human/update_inv_back()
	remove_overlay(BACK_LAYER)

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1]
		inv.update_appearance()

	if(back)
		var/obj/item/I = back
		update_hud_back(I)
		///The final thing we overlay. Set on build_worn_icon.
		var/mutable_appearance/back_overlay

		///icon file of the clothing
		var/icon_file = I.mob_overlay_icon

		/// Does this clothing need to be generated via greyscale
		var/handled_by_bodytype = FALSE

		if(!back_overlay)
			if(dna.species.bodytype & BODYTYPE_VOX)
				if(I.supports_variations & VOX_VARIATION)
					icon_file = VOX_BACK_PATH
				else
					handled_by_bodytype = TRUE

			else if(dna.species.bodytype & BODYTYPE_KEPORI)
				if(I.supports_variations & KEPORI_VARIATION)
					icon_file = KEPORI_BACK_PATH
					if(I.kepori_override_icon)
						icon_file = I.kepori_override_icon
				else
					handled_by_bodytype = TRUE

			if(!icon_exists(icon_file, RESOLVE_ICON_STATE(I)))
				icon_file = I.mob_overlay_icon ? I.mob_overlay_icon : DEFAULT_BACK_PATH
				handled_by_bodytype = TRUE

			var/use_autogen = handled_by_bodytype ? dna.species : null
			back_overlay = I.build_worn_icon(default_layer = BACK_LAYER, default_icon_file = icon_file, override_file = icon_file, isinhands = FALSE, override_file = icon_file, mob_species = use_autogen)

			if(!back_overlay)
				return
			overlays_standing[BACK_LAYER] = back_overlay

			if(back_overlay) //This is faster fuck you
				apply_overlay(BACK_LAYER)

/mob/living/carbon/human/update_inv_legcuffed()
	remove_overlay(LEGCUFF_LAYER)
	clear_alert("legcuffed")
	if(legcuffed)
		overlays_standing[LEGCUFF_LAYER] = mutable_appearance('icons/mob/mob.dmi', legcuffed.icon_state, -LEGCUFF_LAYER)
		apply_overlay(LEGCUFF_LAYER)
		throw_alert("legcuffed", /atom/movable/screen/alert/restrained/legcuffed, new_master = src.legcuffed)

/* Here lies female masking overlay,
 * You broke almost constantly,
 * You broke any time you were touched,
 * You will not be missed, goodbye.
 */

/obj/item/proc/wear_species_version(file2use, state2use, layer, datum/species/mob_species)
	if(!slot_flags) // If it's not wearable, don't try
		return FALSE
	var/icon/species_clothing_icon = GLOB.species_clothing_icons[mob_species.id]["[file2use]-[state2use]"]
	if(!species_clothing_icon) 	//Create standing/laying icons if they don't exist
		if(!generate_species_clothing(file2use, state2use, layer, mob_species))
			return FALSE
	return mutable_appearance(GLOB.species_clothing_icons[mob_species.id]["[file2use]-[state2use]"], layer = -layer)

/mob/living/carbon/human/proc/get_overlays_copy(list/unwantedLayers)
	var/list/out = new
	for(var/i in 1 to TOTAL_LAYERS)
		if(overlays_standing[i])
			if(i in unwantedLayers)
				continue
			out += overlays_standing[i]
	return out


//human HUD updates for items in our inventory

/mob/living/carbon/human/proc/update_hud_uniform(obj/item/I)
	I.screen_loc = ui_iclothing
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_id(obj/item/I)
	I.screen_loc = ui_id
	if((client && hud_used?.hud_shown))
		client.screen += I
	update_observer_view(I)

/mob/living/carbon/human/proc/update_hud_gloves(obj/item/I)
	I.screen_loc = ui_gloves
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_glasses(obj/item/I)
	I.screen_loc = ui_glasses
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_ears(obj/item/I)
	I.screen_loc = ui_ears
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_shoes(obj/item/I)
	I.screen_loc = ui_shoes
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_s_store(obj/item/I)
	I.screen_loc = ui_sstore1
	if(client && hud_used?.hud_shown)
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_wear_suit(obj/item/I)
	I.screen_loc = ui_oclothing
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/proc/update_hud_belt(obj/item/I)
	belt.screen_loc = ui_belt
	if(client && hud_used?.hud_shown)
		client.screen += I
	update_observer_view(I,TRUE)

/mob/living/carbon/human/update_hud_head(obj/item/I)
	I.screen_loc = ui_head
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

//update whether our mask item appears on our hud.
/mob/living/carbon/human/update_hud_wear_mask(obj/item/I)
	I.screen_loc = ui_mask
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

//update whether our neck item appears on our hud.
/mob/living/carbon/human/update_hud_neck(obj/item/I)
	I.screen_loc = ui_neck
	if((client && hud_used) && (hud_used.inventory_shown && hud_used.hud_shown))
		client.screen += I
	update_observer_view(I,TRUE)

//update whether our back item appears on our hud.
/mob/living/carbon/human/update_hud_back(obj/item/I)
	I.screen_loc = ui_back
	if(client && hud_used?.hud_shown)
		client.screen += I
	update_observer_view(I, TRUE)

/*
Does everything in relation to building the /mutable_appearance used in the mob's overlays list
covers:
inhands and any other form of worn item
centering large appearances
layering appearances on custom layers
building appearances from custom icon files

By Remie Richards (yes I'm taking credit because this just removed 90% of the copypaste in update_icons())

state: A string to use as the state, this is FAR too complex to solve in this proc thanks to shitty old code
so it's specified as an argument instead.

default_layer: The layer to draw this on if no other layer is specified

default_icon_file: The icon file to draw states from if no other icon file is specified

isinhands: If true then alternate_worn_icon is skipped so that default_icon_file is used,
in this situation default_icon_file is expected to match either the lefthand_ or righthand_ file var

^this female part sucks and will be fully ripped out ideally

*/
// Note: if handled_by_bodytype is TRUE before calling this, it makes species use greyscale
/obj/item/proc/build_worn_icon(default_layer = 0, default_icon_file = null, isinhands = FALSE, override_state = null, override_file = null, datum/species/mob_species = null, direction = null)

	// WS Edit Start - Worn Icon State
	var/t_state
	if(override_state)
		t_state = override_state
	else
		t_state = !isinhands ? (mob_overlay_state ? mob_overlay_state : icon_state) : (item_state ? item_state : icon_state)

	//Find a valid icon file from variables+arguments
	var/file2use = override_file || (!isinhands ? (mob_overlay_icon ? mob_overlay_icon : default_icon_file) : default_icon_file)

	//Find a valid layer from variables+arguments
	var/layer2use = alternate_worn_layer ? alternate_worn_layer : default_layer

	var/mutable_appearance/standing
	if(mob_species && (mob_species.species_clothing_path || ("[layer2use]" in mob_species.offset_clothing)))
		standing = wear_species_version(file2use, t_state, layer2use, mob_species)
	if(!standing)
		standing = mutable_appearance(file2use, t_state, -layer2use)

	// WS Edit End - Worn Icon State
	//Get the overlays for this item when it's being worn
	//eg: ammo counters, primed grenade flashes, etc.
	var/list/worn_overlays = worn_overlays(isinhands, file2use)
	if(length(worn_overlays))
		if(mob_species && ("[layer2use]" in mob_species.offset_clothing))
			var/list/new_overlays = list()
			for(var/mutable_appearance/overlay in worn_overlays)
				new_overlays += wear_species_version(overlay.icon, overlay.icon_state, layer2use, mob_species)
			worn_overlays = new_overlays
		standing.overlays.Add(worn_overlays)

	standing = center_image(standing, isinhands ? inhand_x_dimension : worn_x_dimension, isinhands ? inhand_y_dimension : worn_y_dimension)

	//Handle held offsets
	if(isinhands)
		var/mob/M = loc
		if(istype(M))
			var/list/L = get_held_offsets(direction)
			if(L)
				standing.pixel_x += L["x"] //+= because of center()ing
				standing.pixel_y += L["y"]
	//Handle worn offsets
	else
		standing.pixel_y += worn_y_offset

	standing.alpha = alpha
	standing.color = color

	return standing


/obj/item/proc/get_held_offsets(direction)
	var/list/L
	if(ismob(loc))
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			var/index = C.get_held_index_of_item(src)
			index ||= 1
			if(!C.layered_hands)
				L = C.dna.species.get_item_offsets_for_index(index)
				if(L)
					return L
			else
				L = C.dna.species.get_item_offsets_for_dir(direction ? direction : C.dir)
				L = L[index]
				return L
		var/mob/M = loc
		L = M.get_item_offsets_for_index(M.get_held_index_of_item(src))

	return L

//Can't think of a better way to do this, sadly
/mob/proc/get_item_offsets_for_index(i)
	switch(i)
		if(3) //odd = left hands
			return list("x" = 0, "y" = 16)
		if(4) //even = right hands
			return list("x" = 0, "y" = 16)
		else //No offsets or Unwritten number of hands
			return list("x" = 0, "y" = 0)//Handle held offsets

/mob/living/carbon/human/proc/update_observer_view(obj/item/I, inventory)
	if(observers && observers.len)
		for(var/M in observers)
			var/mob/dead/observe = M
			if(observe.client && observe.client.eye == src)
				if(observe.hud_used)
					if(inventory && !observe.hud_used.inventory_shown)
						continue
					observe.client.screen += I
			else
				observers -= observe
				if(!observers.len)
					observers = null
					break

// Only renders the head of the human
/mob/living/carbon/human/proc/update_body_parts_head_only(update_limb_data)
	if (!dna?.species)
		return

	var/obj/item/bodypart/HD = get_bodypart("head")

	if (!istype(HD))
		return

	HD.update_limb(is_creating = update_limb_data)

	add_overlay(HD.get_limb_icon())
	update_damage_overlays()

	if(HD && !(HAS_TRAIT(src, TRAIT_HUSK)))
		// lipstick
		if(lip_style && (LIPS in dna.species.species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[lip_style]", -BODY_LAYER)
			lip_overlay.color = lip_color
			add_overlay(lip_overlay)

		// eyes
		if(!(NOEYESPRITES in dna.species.species_traits))
			var/obj/item/organ/eyes/E = getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/eye_overlay
			if(!E)
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', "eyes_missing", -BODY_LAYER)
			else
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', E.eye_icon_state, -BODY_LAYER)
			if((EYECOLOR in dna.species.species_traits) && E)
				eye_overlay.color = "#" + eye_color
			add_overlay(eye_overlay)

	dna.species.handle_hair(src)

	update_inv_head()
	update_inv_wear_mask()
