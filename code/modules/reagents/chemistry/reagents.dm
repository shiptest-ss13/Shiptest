#define REM REAGENTS_EFFECT_MULTIPLIER

GLOBAL_LIST_INIT(name2reagent, build_name2reagent())

/proc/build_name2reagent()
	. = list()
	for (var/t in subtypesof(/datum/reagent))
		var/datum/reagent/R = t
		if (length(initial(R.name)))
			.[ckey(initial(R.name))] = t


//Various reagents
//Toxin & acid reagents
//Hydroponics stuff

/// A single reagent
/datum/reagent
	/// datums don't have names by default
	var/name = "Reagent"
	/// nor do they have descriptions
	var/description = ""
	///J/(K*mol)
	var/specific_heat = SPECIFIC_HEAT_DEFAULT
	/// used by taste messages
	var/taste_description = "metaphorical salt"
	///how this taste compares to others. Higher values means it is more noticable
	var/taste_mult = 1
	/// use for specialty drinks.
	var/glass_name = "glass of ...what?"
	/// desc applied to glasses with this reagent
	var/glass_desc = "You can't really tell what this is."
	/// Otherwise just sets the icon to a normal glass with the mixture of the reagents in the glass.
	var/glass_icon_state = null
	/// used for shot glasses, mostly for alcohol
	var/shot_glass_icon_state = null
	/// used for breakaway flasks similar to glass or shotglass icon state
	var/breakaway_flask_icon_state = null
	/// reagent holder this belongs to
	var/datum/reagents/holder = null
	/// LIQUID, SOLID, GAS
	var/reagent_state = LIQUID
	/// special data associated with this like viruses etc
	var/list/data
	/// increments everytime on_mob_life is called
	var/current_cycle = 0
	///pretend this is moles
	var/volume = 0
	/// color it looks in containers etc
	var/color = "#000000" // rgb: 0, 0, 0
	/// can this reagent be synthesized? (for example: odysseus syringe gun)
	var/can_synth = TRUE
	///how fast the reagent is metabolized by the mob
	var/metabolization_rate = REAGENTS_METABOLISM
	/// appears unused
	var/overrides_metab = 0
	/// above this overdoses happen
	var/overdose_threshold = 0
	/// You fucked up and this is now triggering its overdose effects, purge that shit quick.
	var/overdosed = 0
	///if false stops metab in liverless mobs
	var/self_consuming = FALSE
	///affects how far it travels when sprayed
	var/reagent_weight = 1
	///is it currently metabolizing
	var/metabolizing = FALSE
	/// is it bad for you? Currently only used for borghypo. C2s and Toxins have it TRUE by default.
	var/harmful = FALSE
	/// Are we from a material? We might wanna know that for special stuff. Like metalgen. Is replaced with a ref of the material on New()
	var/datum/material/material
	// What can process this? ORGANIC, SYNTHETIC, or ORGANIC | SYNTHETIC?. We'll assume by default that it affects organics.
	var/process_flags = ORGANIC
	///How good of an accelerant is this reagent
	var/accelerant_quality = 0
	///Assoc list with key type of addiction this reagent feeds, and value amount of addiction points added per unit of reagent metabolzied (which means * REAGENTS_METABOLISM every life())
	var/list/addiction_types = null

	///The section of the autowiki chem table this reagent will be under
	var/category = "Misc"

/datum/reagent/New()
	. = ..()

	if(material)
		material = SSmaterials.GetMaterialRef(material)

/datum/reagent/Destroy() // This should only be called by the holder, so it's already handled clearing its references
	. = ..()
	holder = null

/// Applies this reagent to an [/atom]
/datum/reagent/proc/expose_atom(atom/exposed_atom, reac_volume)
	SEND_SIGNAL(exposed_atom, COMSIG_ATOM_EXPOSE_REAGENT, src, reac_volume)
	return

/// Applies this reagent to a [/mob/living]
/datum/reagent/proc/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(!istype(M))
		return 0
	if(method == VAPOR) //smoke, foam, spray
		if(M.reagents)
			var/modifier = clamp((1 - touch_protection), 0, 1)
			var/amount = round(reac_volume*modifier, 0.1)
			if(amount >= 0.5)
				M.reagents.add_reagent(type, amount)
	SSblackbox.record_feedback("nested tally", "reagent_expose_mob", 1, list("[name]", "[M]", "[method]", "[reac_volume]"))
	return 1

/// Applies this reagent to an [/obj]
/datum/reagent/proc/expose_obj(obj/O, volume)
	return

/// Applies this reagent to a [/turf]
/datum/reagent/proc/expose_turf(turf/T, volume)
	return

/// Called from [/datum/reagents/proc/metabolize]
/datum/reagent/proc/on_mob_life(mob/living/carbon/M)
	current_cycle++
	holder.remove_reagent(type, metabolization_rate * M.metabolism_efficiency) //By default it slowly disappears.
	return

///Called after a reagent is transfered
/datum/reagent/proc/on_transfer(atom/A, method=TOUCH, trans_volume)
	return


/// Called when this reagent is first added to a mob
/datum/reagent/proc/on_mob_add(mob/living/L)
	return

/// Called when this reagent is removed while inside a mob
/datum/reagent/proc/on_mob_delete(mob/living/L)
	SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "[type]_overdose")
	return

/// Called when this reagent first starts being metabolized by a liver
/datum/reagent/proc/on_mob_metabolize(mob/living/L)
	return

/// Called when this reagent stops being metabolized by a liver
/datum/reagent/proc/on_mob_end_metabolize(mob/living/L)
	return

/// Called by [/datum/reagents/proc/conditional_update_move]
/datum/reagent/proc/on_move(mob/M)
	return

/// Called after add_reagents creates a new reagent.
/datum/reagent/proc/on_new(data)
	return

/// Called when two reagents of the same are mixing.
/datum/reagent/proc/on_merge(data)
	return

/// Called by [/datum/reagents/proc/conditional_update]
/datum/reagent/proc/on_update(atom/A)
	return

///called on expose_temperature
/datum/reagent/proc/on_temp_change()
	return
/// Called when the reagent container is hit by an explosion
/datum/reagent/proc/on_ex_act(severity)
	return

///Called when an object is used on the container, return true if a reaction occurs
/datum/reagent/proc/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	return FALSE

/// Called if the reagent has passed the overdose threshold and is set to be triggering overdose effects
/datum/reagent/proc/overdose_process(mob/living/M)
	return

/// Called when an overdose starts
/datum/reagent/proc/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("You feel like you took too much of [name]!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)
	return

/**
 * New, standardized method for chemicals to affect hydroponics trays.
 * Defined on a per-chem level as opposed to by the tray.
 * Can affect plant's health, stats, or cause the plant to react in certain ways.
 */
/datum/reagent/proc/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	if(!mytray)
		return

/// Called when addiction hits stage4, see [/datum/reagents/proc/metabolize]
/datum/reagent/proc/addiction_act_stage4(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/withdrawal_critical, name)
	if(prob(30))
		to_chat(M, span_boldannounce("You're not feeling good at all! You really need some [name]."))
	return

///Called when the addiction is removed, see [/datum/reagents/proc/remove_addiction]
/datum/reagent/proc/on_addiction_removal(mob/living/M)
	return

/proc/pretty_string_from_reagent_list(list/reagent_list)
	//Convert reagent list to a printable string for logging etc
	var/list/rs = list()
	for (var/datum/reagent/R in reagent_list)
		rs += "[R.name], [R.volume]"

	return rs.Join(" | ")
