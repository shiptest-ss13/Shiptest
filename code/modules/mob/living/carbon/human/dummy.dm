
/mob/living/carbon/human/dummy
	real_name = "Test Dummy"
	status_flags = GODMODE|CANPUSH
	mouse_drag_pointer = MOUSE_INACTIVE_POINTER
	var/in_use = FALSE

INITIALIZE_IMMEDIATE(/mob/living/carbon/human/dummy)

/mob/living/carbon/human/dummy/Destroy()
	in_use = FALSE
	return ..()

/mob/living/carbon/human/dummy/Life(seconds_per_tick, times_fired)
	return

/mob/living/carbon/human/dummy/has_equipped(obj/item/item, slot, initial = FALSE)
	return item.visual_equipped(src, slot, initial)

/mob/living/carbon/human/dummy/proc/wipe_state()
	delete_equipment()
	cut_overlays(TRUE)

/mob/living/carbon/human/dummy/setup_human_dna()
	create_dna(src)
	randomize_human(src)
	dna.initialize_dna(skip_index = TRUE) //Skip stuff that requires full round init.

//Inefficient pooling/caching way.
GLOBAL_LIST_EMPTY(human_dummy_list)
GLOBAL_LIST_EMPTY(dummy_mob_list)

/proc/generate_or_wait_for_human_dummy(slotkey)
	if(!slotkey)
		return new /mob/living/carbon/human/dummy
	var/mob/living/carbon/human/dummy/D = GLOB.human_dummy_list[slotkey]
	if(istype(D))
		UNTIL(!D.in_use)
	if(QDELETED(D))
		D = new
		GLOB.human_dummy_list[slotkey] = D
		GLOB.dummy_mob_list += D
	else
		D.regenerate_icons() //they were cut in wipe_state()
	D.in_use = TRUE
	return D

/proc/generate_dummy_lookalike(slotkey, mob/target)
	if(!istype(target))
		return generate_or_wait_for_human_dummy(slotkey)

	var/mob/living/carbon/human/dummy/copycat = generate_or_wait_for_human_dummy(slotkey)

	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.dna.transfer_identity(copycat, transfer_SE = TRUE)

		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			human_target.copy_clothing_prefs(copycat)

		copycat.updateappearance(icon_update=TRUE, mutcolor_update=TRUE, mutations_overlay_update=TRUE)
	else
		//even if target isn't a carbon, if they have a client we can make the
		//dummy look like what their human would look like based on their prefs
		target?.client?.prefs?.copy_to(copycat, icon_updates=TRUE, roundstart_checks=FALSE, character_setup=TRUE)

	return copycat

/proc/unset_busy_human_dummy(slotkey)
	if(!slotkey)
		return
	var/mob/living/carbon/human/dummy/D = GLOB.human_dummy_list[slotkey]
	if(istype(D))
		D.wipe_state()
		D.in_use = FALSE

/proc/clear_human_dummy(slotkey)
	if(!slotkey)
		return

	var/mob/living/carbon/human/dummy/dummy = GLOB.human_dummy_list[slotkey]

	GLOB.human_dummy_list -= slotkey
	if(istype(dummy))
		GLOB.dummy_mob_list -= dummy
		qdel(dummy)


/*
// To speed up the preference menu, we apply 1 filter to the entire mob
/mob/living/carbon/human/dummy/regenerate_icons()
	. = ..()
	apply_height_filters(src, TRUE)

/mob/living/carbon/human/dummy/apply_height_filters(image/appearance, only_apply_in_prefs = FALSE, parent_adjust_y=0)
	if(only_apply_in_prefs)
		return ..()

// Not necessary with above
/mob/living/carbon/human/dummy/apply_height_offsets(image/appearance, upper_torso)
	return
*/


/// Takes in an accessory list and returns the first entry from that list, ensuring that we dont return SPRITE_ACCESSORY_NONE in the process.
/proc/get_consistent_feature_entry(list/accessory_feature_list)
	var/consistent_entry = (accessory_feature_list- SPRITE_ACCESSORY_NONE)[1]
	ASSERT(!isnull(consistent_entry))
	return consistent_entry

/proc/create_consistent_human_dna(mob/living/carbon/human/target)
	target.dna.features[FEATURE_MUTANT_COLOR] = COLOR_VIBRANT_LIME
	target.dna.features[FEATURE_ETHEREAL_COLOR] = COLOR_WHITE
	for(var/feature_key in SSaccessories.feature_list)
		target.dna.features[feature_key] = get_consistent_feature_entry(SSaccessories.feature_list[feature_key])
	target.dna.initialize_dna(newblood_type = get_blood_type(BLOOD_TYPE_O_MINUS), create_mutation_blocks = FALSE, randomize_features = FALSE)
	// UF and UI are nondeterministic, even though the features are the same some blocks will randomize slightly
	// In practice this doesn't matter, but this is for the sake of 100%(ish) consistency
	var/static/consistent_UF
	var/static/consistent_UI
	if(isnull(consistent_UF) || isnull(consistent_UI))
		consistent_UF = target.dna.unique_features
		consistent_UI = target.dna.unique_identity
	else
		target.dna.unique_features = consistent_UF
		target.dna.unique_identity = consistent_UI

/// Provides a dummy that is consistently bald, white, naked, etc.
/mob/living/carbon/human/dummy/consistent

/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	create_consistent_human_dna(src)

/// Provides a dummy for unit_tests that functions like a normal human, but with a standardized appearance
/// Copies the stock dna setup from the dummy/consistent type
/mob/living/carbon/human/consistent

/mob/living/carbon/human/consistent/setup_human_dna()
	create_consistent_human_dna(src)
	fully_replace_character_name(real_name, "John Doe")

/mob/living/carbon/human/consistent/domutcheck()
	return // We skipped adding any mutations so this runtimes

/mob/living/carbon/human/consistent/slow

#ifdef UNIT_TESTS
//unit test dummies should be very fast with actions
/mob/living/carbon/human/dummy/consistent/initialize_actionspeed()
	add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/base, multiplicative_slowdown = -1)

/mob/living/carbon/human/consistent/initialize_actionspeed()
	add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/base, multiplicative_slowdown = -1)

//this one gives us a small window of time for checks on asynced actions.
/mob/living/carbon/human/consistent/slow/initialize_actionspeed()
	add_or_update_variable_actionspeed_modifier(/datum/actionspeed_modifier/base, multiplicative_slowdown = 0.1)
#endif
