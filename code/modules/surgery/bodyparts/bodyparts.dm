/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 3
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/mob/human_parts_greyscale.dmi'
	var/husk_icon = 'icons/mob/human_parts.dmi'
	var/husk_type = "humanoid"
	var/static_icon = 'icons/mob/human_parts.dmi' //Uncolorable sprites
	icon_state = ""
	layer = BELOW_MOB_LAYER //so it isn't hidden behind objects when on the floor
	var/mob/living/carbon/owner = null
	var/datum/weakref/original_owner = null
	///List of bodytypes flags, important for fitting clothing. If you'd like to know if a bodypart is organic, please use is_organic_limb()
	var/bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC

	///Whether the clothing being worn forces the limb into being "squished" to plantigrade/standard humanoid compliance
	var/plantigrade_forced = FALSE
	///Whether the limb is husked
	var/is_husked = FALSE
	///This is effectively the icon_state prefix for limbs.
	var/limb_id = SPECIES_HUMAN
	///Defines what sprite the limb should use if it is also sexually dimorphic.
	var/limb_gender = "m"
	///Does this limb have a greyscale version?
	var/uses_mutcolor = TRUE
	///Is there a sprite difference between male and female?
	var/is_dimorphic = FALSE
	///Greyscale draw color
	var/draw_color

	/// The icon state of the limb's overlay, colored with a different color
	var/overlay_icon_state
	/// The color of the limb's overlay
	var/species_secondary_color

	var/body_zone //BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc , used for def_zone
	/// The body zone of this part in english ("chest", "left arm", etc) without the species attached to it
	var/plaintext_zone
	var/aux_zone // used for hands
	var/aux_layer
	///bitflag used to check which clothes cover this bodypart
	var/body_part = null
	var/list/embedded_objects = list()
	///Are we a hand? if so, which one!
	var/held_index = 0
	///For limbs that don't really exist, eg chainsaws
	var/is_pseudopart = FALSE
	/// Is it fine, broken, splinted, or just straight up fucking gone
	var/bone_status = BONE_FLAG_NO_BONES
	var/bone_break_threshold = 30

	/// So we know if we need to scream if this limb hits max damage
	var/last_maxed
	///If disabled, limb is as good as missing.
	var/bodypart_disabled = FALSE
	///Multiplied by max_damage it returns the threshold which defines a limb being disabled or not. From 0 to 1.
	var/disable_threshold = 1
	///Controls whether bodypart_disabled makes sense or not for this limb.
	var/can_be_disabled = FALSE
	///Multiplier of the limb's damage that gets applied to the mob
	var/body_damage_coeff = 1
	var/stam_damage_coeff = 0.75  //Why is this the default??? - Kapu
	var/brutestate = 0
	var/burnstate = 0
	var/brute_dam = 0
	var/burn_dam = 0
	var/stamina_dam = 0
	var/max_stamina_damage = 0
	var/max_damage = 0

	///Gradually increases while burning when at full damage, destroys the limb when at 100
	var/cremation_progress = 0

	///Subtracted from brute damage taken
	var/brute_reduction = 0
	///Subtracted from burn damage taken
	var/burn_reduction = 0

	//Coloring and proper item icon update
	var/skin_tone = ""
	///Limbs need this information as a back-up incase they are generated outside of a carbon (limbgrower)
	var/should_draw_greyscale = TRUE
	var/species_color = ""
	var/mutation_color = ""
	/// The colour of damage done to this bodypart
	var/damage_color = ""
	/// Should we even use a color?
	var/use_damage_color = FALSE
	var/no_update = 0

	/// If it's a nonhuman bodypart (e.g. monkey)
	var/animal_origin = null
	/// Whether it can be dismembered with a weapon
	var/dismemberable = TRUE

	var/px_x = 0
	var/px_y = 0

	var/species_flags_list = list()
	///the type of damage overlay (if any) to use when this bodypart is bruised/burned.
	var/dmg_overlay_type

	//Damage messages used by help_shake_act()
	var/light_brute_msg = "bruised"
	var/medium_brute_msg = "battered"
	var/heavy_brute_msg = "mangled"

	var/light_burn_msg = "numb"
	var/medium_burn_msg = "blistered"
	var/heavy_burn_msg = "peeling away"

/obj/item/bodypart/Initialize()
	. = ..()
	name = "[limb_id] [parse_zone(body_zone)]"
	update_icon_dropped()

/obj/item/bodypart/forceMove(atom/destination) //Please. Never forcemove a limb if its's actually in use. This is only for borgs.
	. = ..()
	if(isturf(destination))
		update_icon_dropped()


/obj/item/bodypart/Initialize(mapload)
	. = ..()
	if(can_be_disabled)
		RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_gain)
		RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_loss)


/obj/item/bodypart/Destroy()
	if(owner)
		owner.remove_bodypart(src)
		set_owner(null)
	return ..()


/obj/item/bodypart/examine(mob/user)
	. = ..()
	if(brute_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [brute_dam > 30 ? "severe" : "minor"] bruising.</span>"
	if(burn_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [burn_dam > 30 ? "severe" : "minor"] burns.</span>"


/obj/item/bodypart/blob_act()
	take_damage(max_damage)


/obj/item/bodypart/attack(mob/living/carbon/C, mob/user)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(HAS_TRAIT(C, TRAIT_LIMBATTACHMENT))
			if(!H.get_bodypart(body_zone) && !animal_origin)
				user.temporarilyRemoveItemFromInventory(src, TRUE)
				if(!attach_limb(C))
					to_chat(user, "<span class='warning'>[H]'s body rejects [src]!</span>")
					forceMove(H.loc)
				if(H == user)
					H.visible_message("<span class='warning'>[H] jams [src] into [H.p_their()] empty socket!</span>",\
					"<span class='notice'>You force [src] into your empty socket, and it locks into place!</span>")
				else
					H.visible_message("<span class='warning'>[user] jams [src] into [H]'s empty socket!</span>",\
					"<span class='notice'>[user] forces [src] into your empty socket, and it locks into place!</span>")
				return
	..()

/obj/item/bodypart/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		add_fingerprint(user)
		if(!contents.len)
			to_chat(user, "<span class='warning'>There is nothing left inside [src]!</span>")
			return
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message("<span class='warning'>[user] begins to cut open [src].</span>",\
			"<span class='notice'>You begin to cut open [src]...</span>")
		if(do_after(user, 54, target = src))
			drop_organs(user, TRUE)
	else
		return ..()

/obj/item/bodypart/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(IS_ORGANIC_LIMB(src))
		playsound(get_turf(src), 'sound/misc/splort.ogg', 50, TRUE, -1)
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3)

//empties the bodypart from its organs and other things inside it
/obj/item/bodypart/proc/drop_organs(mob/user, violent_removal)
	var/turf/T = get_turf(src)
	if(IS_ORGANIC_LIMB(src))
		playsound(T, 'sound/misc/splort.ogg', 50, TRUE, -1)
	for(var/obj/item/I in src)
		I.forceMove(T)

//Return TRUE to get whatever mob this is in to update health.
/obj/item/bodypart/proc/on_life()
	SHOULD_CALL_PARENT(TRUE)

	if(stamina_dam > DAMAGE_PRECISION && owner.stam_regen_start_time <= world.time)					//DO NOT update health here, it'll be done in the carbon's life.
		heal_damage(0, 0, INFINITY, null, FALSE)
		. |= BODYPART_LIFE_UPDATE_HEALTH

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, break_modifier = 1)
	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode

	if(required_status && !(bodytype & required_status))
		return FALSE

	var/dmg_mlt = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_mlt, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_mlt, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_mlt, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	switch(animal_origin)
		if(ALIEN_BODYPART,LARVA_BODYPART) //aliens take double burn //nothing can burn with so much snowflake code around
			burn *= 2

	// Is the damage greater than the threshold, and if so, probability of damage + item force
	if((brute_dam > bone_break_threshold) && prob(brute_dam + break_modifier))
		break_bone()

	var/can_inflict = max_damage - get_damage()
	if(can_inflict <= 0)
		return FALSE

	var/total_damage = brute + burn

	if(total_damage > can_inflict)
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	brute_dam += brute
	burn_dam += burn

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	if(stamina)
		set_stamina_dam(stamina_dam + round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION))


	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
			if(stamina > DAMAGE_PRECISION)
				owner.update_stamina()
				owner.stam_regen_start_time = world.time + STAMINA_REGEN_BLOCK_TIME
				. = TRUE
	return update_bodypart_damage_state() || .

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, stamina, required_status, updating_health = TRUE)

	if(required_status && !(bodytype & required_status)) //So we can only heal certain kinds of limbs, ie robotic vs organic.
		return

	if(brute)
		set_brute_dam(round(max(brute_dam - brute, 0), DAMAGE_PRECISION))
	if(burn)
		set_burn_dam(round(max(burn_dam - burn, 0), DAMAGE_PRECISION))
	if(stamina)
		set_stamina_dam(round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION))

	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
		if(owner.dna?.species && (REVIVESBYHEALING in owner.dna.species.species_traits))
			if(owner.health > 0 && !owner.hellbound)
				owner.revive(FALSE)
				owner.cure_husk() // If it has REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	cremation_progress = min(0, cremation_progress - ((brute_dam + burn_dam)*(100/max_damage)))
	return update_bodypart_damage_state()


///Proc to hook behavior associated to the change of the brute_dam variable's value.
/obj/item/bodypart/proc/set_brute_dam(new_value)
	if(brute_dam == new_value)
		return
	. = brute_dam
	brute_dam = new_value


///Proc to hook behavior associated to the change of the burn_dam variable's value.
/obj/item/bodypart/proc/set_burn_dam(new_value)
	if(burn_dam == new_value)
		return
	. = burn_dam
	burn_dam = new_value


///Proc to hook behavior associated to the change of the stamina_dam variable's value.
/obj/item/bodypart/proc/set_stamina_dam(new_value)
	if(stamina_dam == new_value)
		return
	. = stamina_dam
	stamina_dam = new_value


//Returns total damage.
/obj/item/bodypart/proc/get_damage(include_stamina = FALSE)
	var/total = brute_dam + burn_dam
	if(include_stamina)
		total = max(total, stamina_dam)
	return total


//Checks disabled status thresholds
/obj/item/bodypart/proc/update_disabled()
	if(!can_be_disabled)
		set_disabled(FALSE)
		CRASH("update_disabled called with can_be_disabled false")
	if(HAS_TRAIT(src, TRAIT_PARALYSIS))
		set_disabled(TRUE)
		return

	var/total_damage = max(brute_dam + burn_dam, stamina_dam)

	if(total_damage >= max_damage * disable_threshold) //Easy limb disable disables the limb at 40% health instead of 0%
		if(!last_maxed)
			if(owner.stat < UNCONSCIOUS)
				INVOKE_ASYNC(owner, /mob.proc/emote, "scream")
			last_maxed = TRUE
		set_disabled(TRUE)
		return

	if(bodypart_disabled && total_damage <= max_damage * 0.8) // reenabled at 80% now instead of 50% as of wounds update
		last_maxed = FALSE
		set_disabled(FALSE)

///Proc to change the value of the `disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_disabled(new_disabled)
	if(bodypart_disabled == new_disabled)
		return
	. = bodypart_disabled
	bodypart_disabled = new_disabled

	if(!owner)
		return
	owner.update_health_hud() //update the healthdoll
	owner.update_body()

///Proc to change the value of the `owner` variable and react to the event of its change.
/obj/item/bodypart/proc/set_owner(new_owner)
	if(owner == new_owner)
		return FALSE //`null` is a valid option, so we need to use a num var to make it clear no change was made.
	. = owner
	owner = new_owner
	var/needs_update_disabled = FALSE //Only really relevant if there's an owner
	if(.)
		var/mob/living/carbon/old_owner = .
		if(can_be_disabled)
			if(HAS_TRAIT(old_owner, TRAIT_EASYLIMBDISABLE))
				disable_threshold = initial(disable_threshold)
				needs_update_disabled = TRUE
			UnregisterSignal(old_owner, list(
				SIGNAL_REMOVETRAIT(TRAIT_EASYLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_EASYLIMBDISABLE),
				))
		if(initial(can_be_disabled))
			if(HAS_TRAIT(old_owner, TRAIT_NOLIMBDISABLE))
				if(!owner || !HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
					set_can_be_disabled(initial(can_be_disabled))
					needs_update_disabled = TRUE
			UnregisterSignal(old_owner, list(
				SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE),
				))
	if(owner)
		if(can_be_disabled)
			if(HAS_TRAIT(owner, TRAIT_EASYLIMBDISABLE))
				disable_threshold = 0.6
				needs_update_disabled = TRUE
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_EASYLIMBDISABLE), .proc/on_owner_easylimbwound_trait_loss)
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_EASYLIMBDISABLE), .proc/on_owner_easylimbwound_trait_gain)
		if(initial(can_be_disabled))
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				set_can_be_disabled(FALSE)
				needs_update_disabled = FALSE
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE), .proc/on_owner_nolimbdisable_trait_loss)
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE), .proc/on_owner_nolimbdisable_trait_gain)
		if(needs_update_disabled)
			update_disabled()


///Proc to change the value of the `can_be_disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_can_be_disabled(new_can_be_disabled)
	if(can_be_disabled == new_can_be_disabled)
		return
	. = can_be_disabled
	can_be_disabled = new_can_be_disabled
	if(can_be_disabled)
		if(owner)
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				CRASH("set_can_be_disabled to TRUE with for limb whose owner has TRAIT_NOLIMBDISABLE")
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_gain)
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), .proc/on_paralysis_trait_loss)
			if(HAS_TRAIT(owner, TRAIT_EASYLIMBDISABLE))
				disable_threshold = 0.6
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_EASYLIMBDISABLE), .proc/on_owner_easylimbwound_trait_loss)
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_EASYLIMBDISABLE), .proc/on_owner_easylimbwound_trait_gain)
		update_disabled()
	else if(.)
		if(owner)
			UnregisterSignal(owner, list(
				SIGNAL_ADDTRAIT(TRAIT_PARALYSIS),
				SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS),
				SIGNAL_REMOVETRAIT(TRAIT_EASYLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_EASYLIMBDISABLE),
				))
		set_disabled(FALSE)


///Called when TRAIT_PARALYSIS is added to the limb.
/obj/item/bodypart/proc/on_paralysis_trait_gain(obj/item/bodypart/source)
	SIGNAL_HANDLER
	if(can_be_disabled)
		set_disabled(TRUE)


///Called when TRAIT_PARALYSIS is removed from the limb.
/obj/item/bodypart/proc/on_paralysis_trait_loss(obj/item/bodypart/source)
	SIGNAL_HANDLER
	if(can_be_disabled)
		update_disabled()


///Called when TRAIT_NOLIMBDISABLE is added to the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_gain(mob/living/carbon/source)
	SIGNAL_HANDLER
	set_can_be_disabled(FALSE)


///Called when TRAIT_NOLIMBDISABLE is removed from the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_loss(mob/living/carbon/source)
	SIGNAL_HANDLER
	set_can_be_disabled(initial(can_be_disabled))


///Called when TRAIT_EASYLIMBDISABLE is added to the owner.
/obj/item/bodypart/proc/on_owner_easylimbwound_trait_gain(mob/living/carbon/source)
	SIGNAL_HANDLER
	disable_threshold = 0.6
	if(can_be_disabled)
		update_disabled()


///Called when TRAIT_EASYLIMBDISABLE is removed from the owner.
/obj/item/bodypart/proc/on_owner_easylimbwound_trait_loss(mob/living/carbon/source)
	SIGNAL_HANDLER
	disable_threshold = initial(disable_threshold)
	if(can_be_disabled)
		update_disabled()


//Updates an organ's brute/burn states for use by update_damage_overlays()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/bodypart/proc/update_bodypart_damage_state()
	var/tbrute	= round((brute_dam/max_damage)*3, 1)
	var/tburn	= round((burn_dam/max_damage)*3, 1)
	if((tbrute != brutestate) || (tburn != burnstate))
		brutestate = tbrute
		burnstate = tburn
		return TRUE
	return FALSE

//Change limb between
//Note:This proc only exists because I can't be arsed to remove it yet. Theres no real reason this should ever be used.
//Don't look at me, I'm just half-assedly porting everything I see.
/obj/item/bodypart/proc/change_bodypart_status(new_limb_status, heal_limb, change_icon_to_default)
	if(!(bodytype & new_limb_status))
		bodytype &= ~(BODYTYPE_ROBOTIC & BODYTYPE_ORGANIC)
		bodytype |= new_limb_status
	else
		bodytype = bodytype & ~BODYTYPE_ORGANIC
		bodytype = bodytype | BODYTYPE_ROBOTIC

	if(heal_limb)
		burn_dam = 0
		brute_dam = 0
		brutestate = 0
		burnstate = 0

	if(change_icon_to_default)
		if(IS_ORGANIC_LIMB(src))
			icon = DEFAULT_BODYPART_ICON_ORGANIC
		else
			icon = DEFAULT_BODYPART_ICON_ROBOTIC

	if(owner)
		owner.updatehealth()
		owner.update_body() //if our head becomes robotic, we remove the lizard horns and human hair.
		owner.update_hair()
		owner.update_damage_overlays()

//we inform the bodypart of the changes that happened to the owner, or give it the informations from a source mob.
//set is_creating to true if you want to change the appearance of the limb outside of mutation changes or forced changes.
/obj/item/bodypart/proc/update_limb(dropping_limb, mob/living/carbon/source, is_creating = FALSE)
	var/mob/living/carbon/C
	if(source)
		C = source
		if(!original_owner)
			original_owner = source
	else
		C = owner
		if(original_owner && original_owner != owner) //Foreign limb
			no_update = TRUE
		else
			no_update = FALSE

	if(HAS_TRAIT(C, TRAIT_HUSK) && IS_ORGANIC_LIMB(src))
		dmg_overlay_type = "" //no damage overlay shown when husked
		is_husked = TRUE
	else
		dmg_overlay_type = initial(dmg_overlay_type)
		is_husked = FALSE

	if(!dropping_limb && C.dna?.check_mutation(HULK)) //Please remove hulk from the game. I beg you.
		mutation_color = "00aa00"
	else
		mutation_color = null

	if(mutation_color) //I hate mutations
		draw_color = mutation_color
	else if(should_draw_greyscale)
		draw_color = (species_color) || (skin_tone && skintone2hex(skin_tone))
	else
		draw_color = null

	if(no_update)
		return

	if(!is_creating || !owner)
		return

	if(!animal_origin && ishuman(C))
		var/mob/living/carbon/human/H = C

		var/datum/species/S = H.dna.species
		species_flags_list = H.dna.species.species_traits //Literally only exists for a single use of NOBLOOD, but, no reason to remove it i guess...?
		limb_gender = (H.gender == MALE) ? "m" : "f"

		if(S.use_skintones)
			skin_tone = H.skin_tone
		else
			skin_tone = ""

		use_damage_color = S.use_damage_color
		if(((MUTCOLORS in S.species_traits) || (DYNCOLORS in S.species_traits)) && uses_mutcolor) //Ethereal code. Motherfuckers.
			if(S.fixed_mut_color)
				species_color = S.fixed_mut_color
			else
				species_color = H.dna.features["mcolor"]
		else
			species_color = null

		if(overlay_icon_state)
			species_secondary_color = H.dna.features["mcolor2"]

		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
		if(NO_BONES in S.species_traits)
			bone_status = BONE_FLAG_NO_BONES
		else
			bone_status = BONE_FLAG_NORMAL
			RegisterSignal(owner, COMSIG_MOVABLE_MOVED, .proc/on_mob_move)


		draw_color = mutation_color
		if(should_draw_greyscale) //Should the limb be colored?
			draw_color ||= (species_color) || (skin_tone && skintone2hex(skin_tone))

		dmg_overlay_type = S.damage_overlay_type

	else if(animal_origin == MONKEY_BODYPART) //currently monkeys are the only non human mob to have damage overlays.
		dmg_overlay_type = animal_origin

	if(!IS_ORGANIC_LIMB(src))
		dmg_overlay_type = "robotic"

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.

//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	cut_overlays()
	var/list/standing = get_limb_icon(1)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	add_overlay(standing)

/obj/item/bodypart/proc/get_limb_icon(dropped)
	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	//Handles dropped icons
	var/image_dir = NONE
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				var/image/bruteoverlay = image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
				if(use_damage_color)
					bruteoverlay.color = damage_color
				. += bruteoverlay
			if(burnstate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	var/image/aux
	//. += limb

	if(animal_origin) //Cringe ass animal-specific code.
		if(IS_ORGANIC_LIMB(src))
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(is_husked)
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		. += limb
		return

	if(is_husked)
		limb.icon = husk_icon
		limb.icon_state = "[husk_type]_husk_[body_zone]"
		. += limb
		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[husk_type]_husk_[aux_zone]", -aux_layer, image_dir)
			. += aux
		return

	////This is the MEAT of limb icon code
	limb.icon = icon
	if(!should_draw_greyscale || !icon)
		limb.icon = static_icon

	limb.icon_state = "[limb_id]_[body_zone]"

	if(is_dimorphic) //Does this type of limb have sexual dimorphism?
		limb.icon_state += "_[limb_gender]"
	if(bodytype & BODYTYPE_DIGITIGRADE && !plantigrade_forced)
		limb.icon_state += "_digitigrade"

	if(!icon_exists(limb.icon, limb.icon_state))
		limb_stacktrace("Limb generated with nonexistant icon. File: [limb.icon] | State: [limb.icon_state]", GLOB.Debug) //If you *really* want more of these, you can set the *other* global debug flag manually.

	if(!is_husked)
		. += limb

		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[limb_id]_[aux_zone]", -aux_layer, image_dir)
			. += aux
			if(overlay_icon_state)
				var/image/overlay = image(limb.icon, "[limb_id]_[aux_zone]_overlay", -aux_layer, image_dir)
				overlay.color = "#[species_secondary_color]"
				. += overlay

		draw_color = mutation_color
		if(should_draw_greyscale) //Should the limb be colored outside of a forced color?
			draw_color ||= (species_color) || (skin_tone && skintone2hex(skin_tone))

		if(draw_color)
			limb.color = "#[draw_color]"
			if(aux_zone)
				aux.color = "#[draw_color]"

		if(overlay_icon_state)
			var/image/overlay = image(limb.icon, "[limb.icon_state]_overlay", -BODY_ADJ_LAYER, image_dir)
			overlay.color = "#[species_secondary_color]"
			. += overlay

	//Ok so legs are a bit goofy in regards to layering, and we will need two images instead of one to fix that
	if((body_zone == BODY_ZONE_R_LEG) || (body_zone == BODY_ZONE_L_LEG))
		var/obj/item/bodypart/leg/leg_source = src
		for(var/image/limb_image in .)
			//remove the old, unmasked image
			. -= limb_image
			//add two masked images based on the old one
			. += leg_source.generate_masked_leg(limb_image, image_dir)

	/*if(!is_husked)
		//Draw external organs like horns and frills
		for(var/obj/item/organ/external/external_organ as anything in external_organs)
			if(!dropped && !external_organ.can_draw_on_bodypart(owner))
				continue
			//Some externals have multiple layers for background, foreground and between
			for(var/external_layer in external_organ.all_layers)
				if(external_organ.layers & external_layer)
					external_organ.generate_and_retrieve_overlays(
						.,
						image_dir,
						external_organ.bitflag_to_layer(external_layer),
						limb_gender,
					)*/

	return

/obj/item/bodypart/deconstruct(disassembled = TRUE)
	drop_organs()
	qdel(src)

// BROKEN BONE PROCS //
/obj/item/bodypart/proc/can_break_bone()
	// Do they have bones, are the bones not broken, is the limb not robotic? If yes to all, return 1
	return (bone_status && bone_status != BONE_FLAG_BROKEN && IS_ORGANIC_LIMB(src)) //was BODYTYPE_ROBOTIC

/obj/item/bodypart/proc/break_bone()
	if(!can_break_bone())
		return
	if (bone_status == BONE_FLAG_NORMAL && body_part & LEGS) // Because arms are not legs
		owner.set_broken_legs(owner.broken_legs + 1)
	bone_status = BONE_FLAG_BROKEN
	addtimer(CALLBACK(owner, /atom/.proc/visible_message, "<span class='danger'>You hear a cracking sound coming from [owner]'s [name].</span>", "<span class='userdanger'>You feel something crack in your [name]!</span>", "<span class='danger'>You hear an awful cracking sound.</span>"), 1 SECONDS)

/obj/item/bodypart/proc/fix_bone()
	// owner.update_inv_splints() breaks
	if (bone_status != BONE_FLAG_NORMAL && body_part & LEGS)
		owner.set_broken_legs(owner.broken_legs - 1)
	bone_status = BONE_FLAG_NORMAL

/obj/item/bodypart/proc/on_mob_move()
	// Dont trigger if it isn't broken or if it has no owner
	if(bone_status != BONE_FLAG_BROKEN || !owner)
		return

	if(prob(5))
		to_chat(owner, "<span class='danger'>[pick("You feel broken bones moving around in your [name]!", "There are broken bones moving around in your [name]!", "The bones in your [name] are moving around!")]</span>")
		receive_damage(rand(1, 3))
		//1-3 damage every 20 tiles for every broken bodypart.
		//A single broken bodypart will give you an average of 650 tiles to run before you get a total of 100 damage and fall into crit
