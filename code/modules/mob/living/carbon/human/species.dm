GLOBAL_LIST_EMPTY(roundstart_races)

#define MINIMUM_MOLS_TO_HARM 1

/**
 * # species datum
 *
 * Datum that handles different species in the game.
 *
 * This datum handles species in the game, such as lizardpeople, mothmen, zombies, skeletons, etc.
 * It is used in [carbon humans][mob/living/carbon/human] to determine various things about them, like their food preferences, if they have biological genders, their damage resistances, and more.
 *
 */
/datum/species
	///If the game needs to manually check your race to do something not included in a proc here, it will use this.
	var/id
	///This is the fluff name. They are displayed on health analyzers and in the character setup menu. Leave them generic for other servers to customize.
	var/name
	//Species flags currently used for species restriction on items
	var/bodyflag = FLAG_HUMAN
	// Default color. If mutant colors are disabled, this is the color that will be used by that race.
	var/default_color = "#FFFFFF"

	var/bodytype = BODYTYPE_HUMANOID
	///Minimum species_age
	var/species_age_min = 18
	///Maximum species age
	var/species_age_max = 85

	var/list/offset_clothing = list()

	//The maximum number of bodyparts this species can have.
	var/max_bodypart_count = 6

	///This allows races to have specific hair colors. If null, it uses the H's hair/facial hair colors. If "mutcolor", it uses the H's mutant_color. If "fixedmutcolor", it uses fixedmutcolor
	var/hair_color
	///The alpha used by the hair. 255 is completely solid, 0 is invisible.
	var/hair_alpha = 255

	///This is used for children, it will determine their default limb ID for use of examine. See examine.dm.
	var/examine_limb_id
	///Never, Optional, or Forced digi legs?
	var/digitigrade_customization = DIGITIGRADE_NEVER

	///The gradient style used for the mob's hair.
	var/grad_style
	///The gradient color used to color the gradient.
	var/grad_color
	///The color used for the "white" of the eye, if the eye has one.
	var/sclera_color = "#e8e8e8"
	/// The color used for blush overlay
	var/blush_color = COLOR_BLUSH_PINK
	///Does the species use skintones or not? As of now only used by humans.
	var/use_skintones = FALSE
	///If your race bleeds something other than bog standard blood, change this to reagent id. For example, ethereals bleed liquid electricity.
	var/exotic_blood = ""
	///If your race uses a non standard bloodtype (A+, O-, AB-, etc). For example, lizards have L type blood.
	var/exotic_bloodtype = ""
	///What the species drops when gibbed by a gibber machine.
	var/meat = /obj/item/food/meat/slab/human
	///What skin the species drops when gibbed by a gibber machine.
	var/skinned_type
	///Bitfield for food types that the species likes, giving them a mood boost. Lizards like meat, for example.
	var/liked_food = NONE
	///Bitfield for food types that the species dislikes, giving them disgust. Humans hate raw food, for example.
	var/disliked_food = GROSS
	///Bitfield for food types that the species absolutely hates, giving them even more disgust than disliked food. Meat is "toxic" to moths, for example.
	var/toxic_food = TOXIC
	///Inventory slots the race can't equip stuff to.
	var/list/no_equip = list()
	/// Allows the species to equip items that normally require a jumpsuit without having one equipped.
	var/nojumpsuit = FALSE
	///What languages this species can understand and say. Use a [language holder datum][/datum/language_holder] in this var.
	var/species_language_holder = /datum/language_holder
	/// Default mutant bodyparts for this species. Don't forget to set one for every mutant bodypart you allow this species to have.
	var/list/default_features = list("body_size" = "Normal")
	/// Visible CURRENT bodyparts that are unique to a species. DO NOT USE THIS AS A LIST OF ALL POSSIBLE BODYPARTS AS IT WILL FUCK SHIT UP! Changes to this list for non-species specific bodyparts (ie cat ears and tails) should be assigned at organ level if possible. Layer hiding is handled by [datum/species/handle_mutant_bodyparts()] below.
	var/list/mutant_bodyparts = list()
	///Internal organs that are unique to this race, like a tail.
	var/list/mutant_organs = list()
	///Multiplier for the race's speed. Positive numbers make it move slower, negative numbers make it move faster.
	var/speedmod = 0
	///Percentage modifier for overall defense of the race, or less defense, if it's negative.
	var/armor = 0
	///multiplier for brute damage
	var/brutemod = 1
	///multiplier for burn damage
	var/burnmod = 1
	///multiplier for damage from cold temperature
	var/coldmod = 1
	///multiplier for damage from hot temperature
	var/heatmod = 1
	///multiplier for stamina damage
	var/staminamod = 1
	///multiplier for stun durations
	var/stunmod = 1
	///Type of damage attack does. Ethereals attack with burn damage for example.
	var/attack_type = BRUTE
	///Lowest possible punch damage this species can give. If this is set to 0, punches will always miss.
	var/punchdamagelow = 1
	///Highest possible punch damage this species can give.
	var/punchdamagehigh = 10
	///Damage at which punches from this race will stun
	var/punchstunthreshold = 10 //yes it should be to the attacked race but it's not useful that way even if it's logical
	///Base electrocution coefficient.  Basically a multiplier for damage from electrocutions.
	var/siemens_coeff = 1
	///What kind of damage overlays (if any) appear on our species when wounded? If this is "", does not add an overlay.
	var/damage_overlay_type = "human"
	///for species with a unique body size(above 32x32), who need a custom icon file for overlays
	var/custom_overlay_icon
	///To use MUTCOLOR with a fixed color that's independent of the mcolor feature in DNA.
	var/fixed_mut_color = ""
	///Special mutation that can be found in the genepool exclusively in this species. Dont leave empty or changing species will be a headache
	var/inert_mutation 	= DWARFISM
	///Used to set the mob's deathsound upon species change
	var/deathsound
	///Sounds to override barefeet walking
	var/list/special_step_sounds
	///Special sound for grabbing
	var/grab_sound
	/// A path to an outfit that is important for species life e.g. plasmaman outfit
	var/datum/outfit/outfit_important_for_life

	///Used for metabolizing reagents. We're going to assume you're a meatbag unless you say otherwise.
	var/reagent_tag = PROCESS_ORGANIC
	///Does this mob have special gibs?
	var/species_gibs = "human"

	///Does this species have a special set of overlay clothing, and if so, what is the name of the folder under .../clothing/species that contains them?
	var/species_clothing_path
	///Icon file used for eyes, defaults to 'icons/mob/human_face.dmi'
	var/species_eye_path

	///Is this species a flying species? Used as an easy check for some things
	var/flying_species = FALSE
	///The actual flying ability given to flying species
	var/datum/action/innate/flight/fly
	///Current wings icon
	var/wings_icon = "Angel"
	//Dictates which wing icons are allowed for a given species. If count is >1 a radial menu is used to choose between all icons in list
	var/list/wings_icons = list("Angel")
	///Used to determine what description to give when using a potion of flight, if false it will describe them as growing new wings
	var/has_innate_wings = FALSE

	/// The natural temperature for a body
	var/bodytemp_normal = HUMAN_BODYTEMP_NORMAL
	/// Minimum amount of kelvin moved toward normal body temperature per tick.
	var/bodytemp_autorecovery_min = HUMAN_BODYTEMP_AUTORECOVERY_MINIMUM
	/// The maximum temperature the species is comfortable at. Going above this does not apply any effects, but warns players that the temperture is hot
	var/max_temp_comfortable = (HUMAN_BODYTEMP_NORMAL + 7) //20 c will always be below human bodytemp, this just makes it so when it can sustain that its higher
	/// The minimum temperature the species is comfortable at. Going below this does not apply any effects, but warns players that the temperture is chilly
	var/min_temp_comfortable = (HUMAN_BODYTEMP_NORMAL - 5)
	/// This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery.
	var/bodytemp_autorecovery_divisor = HUMAN_BODYTEMP_AUTORECOVERY_DIVISOR
	///Similar to the autorecovery_divsor, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to lose bodytemp faster.
	var/bodytemp_heat_divisor = HUMAN_BODYTEMP_HEAT_DIVISOR
	///Similar to the autorecovery_divisor, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to gain bodytemp faster.
	var/bodytemp_cold_divisor = HUMAN_BODYTEMP_COLD_DIVISOR
	/// The body temperature limit the body can take before it starts taking damage from heat.
	var/bodytemp_heat_damage_limit = HUMAN_BODYTEMP_HEAT_DAMAGE_LIMIT
	/// The body temperature limit the body can take before it starts taking damage from cold.
	var/bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT
	/// The maximum rate at which a species can heat up per tick
	var/bodytemp_cooling_rate_max = HUMAN_BODYTEMP_COOLING_MAX
	/// The maximum rate at which a species can cool down per tick
	var/bodytemp_heating_rate_max = HUMAN_BODYTEMP_HEATING_MAX
	/// How much temp is our body stabilizing naturally?
	var/bodytemp_natural_stabilization = 0
	/// How much temp is the environment is causing us to charge?
	var/bodytemp_environment_change = 0

	///Does our species have colors for its' damage overlays?
	var/use_damage_color = TRUE

	///Species-only traits. Can be found in [code/_DEFINES/DNA.dm]
	var/list/species_traits = list()
	///Generic traits tied to having the species.
	var/list/inherent_traits = list()
	/// List of biotypes the mob belongs to. Used by diseases.
	var/inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	///List of factions the mob gain upon gaining this species.
	var/list/inherent_factions

	///Punch-specific attack verb.
	var/attack_verb = "punch"
	///
	var/sound/attack_sound = 'sound/weapons/punch1.ogg'
	var/sound/miss_sound = 'sound/weapons/punchmiss.ogg'

	///What gas does this species breathe? Used by suffocation screen alerts, most of actual gas breathing is handled by mutantlungs. See [life.dm][code/modules/mob/living/carbon/human/life.dm]
	var/breathid = "o2"

	//Do NOT remove by setting to null. use OR make a RESPECTIVE TRAIT (removing stomach? add the NOSTOMACH trait to your species)
	//why does it work this way? because traits also disable the downsides of not having an organ, removing organs but not having the trait will make your species die
	//shut up you're not my mother

	///Replaces default brain with a different organ
	var/obj/item/organ/brain/mutantbrain = /obj/item/organ/brain
	///Replaces default heart with a different organ
	var/obj/item/organ/heart/mutantheart = /obj/item/organ/heart
	///Replaces default lungs with a different organ
	var/obj/item/organ/lungs/mutantlungs = /obj/item/organ/lungs
	///Replaces default eyes with a different organ
	var/obj/item/organ/eyes/mutanteyes = /obj/item/organ/eyes
	///Replaces default ears with a different organ
	var/obj/item/organ/ears/mutantears = /obj/item/organ/ears
	///Replaces default tongue with a different organ
	var/obj/item/organ/tongue/mutanttongue = /obj/item/organ/tongue
	///Replaces default liver with a different organ
	var/obj/item/organ/liver/mutantliver = /obj/item/organ/liver
	///Replaces default stomach with a different organ
	var/obj/item/organ/stomach/mutantstomach = /obj/item/organ/stomach
	///Replaces default appendix with a different organ.
	var/obj/item/organ/appendix/mutantappendix = /obj/item/organ/appendix
	///Forces an item into this species' hands. Only an honorary mutantthing because this is not an organ and not loaded in the same way, you've been warned to do your research.
	var/obj/item/mutanthands

	///Bitflag that controls what in game ways something can select this species as a spawnable source, such as magic mirrors. See [mob defines][code/_DEFINES/mobs.dm] for possible sources.
	var/changesource_flags = NONE
	var/loreblurb = "Description not provided. Yell at a coder. Also, please look into cooking fajitas. That stuff is amazing."

	//K-Limbs. If a species doesn't have their own limb types. Do not override this, use the K-Limbs overrides at the top of the species datum.
	var/obj/item/bodypart/species_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/species_head = /obj/item/bodypart/head
	var/obj/item/bodypart/species_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/species_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/species_r_leg = /obj/item/bodypart/leg/right
	var/obj/item/bodypart/species_l_leg = /obj/item/bodypart/leg/left

	var/obj/item/bodypart/species_digi_l_leg = /obj/item/bodypart/leg/left/lizard/digitigrade
	var/obj/item/bodypart/species_digi_r_leg = /obj/item/bodypart/leg/right/lizard/digitigrade

	var/obj/item/bodypart/species_robotic_chest = /obj/item/bodypart/chest/robot
	var/obj/item/bodypart/species_robotic_head = /obj/item/bodypart/head/robot
	var/obj/item/bodypart/species_robotic_l_arm = /obj/item/bodypart/l_arm/robot/surplus
	var/obj/item/bodypart/species_robotic_r_arm = /obj/item/bodypart/r_arm/robot/surplus
	var/obj/item/bodypart/species_robotic_l_leg = /obj/item/bodypart/leg/left/robot/surplus
	var/obj/item/bodypart/species_robotic_r_leg = /obj/item/bodypart/leg/right/robot/surplus

	var/obj/item/bodypart/species_robotic_digi_l_leg = /obj/item/bodypart/leg/left/robot/surplus/lizard/digitigrade
	var/obj/item/bodypart/species_robotic_digi_r_leg = /obj/item/bodypart/leg/right/robot/surplus/lizard/digitigrade

	var/obj/item/organ/heart/robotic_heart = /obj/item/organ/heart/cybernetic
	var/obj/item/organ/lungs/robotic_lungs = /obj/item/organ/lungs/cybernetic
	var/obj/item/organ/eyes/robotic_eyes = /obj/item/organ/eyes/robotic
	var/obj/item/organ/ears/robotic_ears = /obj/item/organ/ears/cybernetic
	var/obj/item/organ/tongue/robotic_tongue = /obj/item/organ/tongue/robot
	var/obj/item/organ/liver/robotic_liver = /obj/item/organ/liver/cybernetic
	var/obj/item/organ/stomach/robotic_stomach = /obj/item/organ/stomach/cybernetic
	var/obj/item/organ/appendix/robotic_appendix = null

	///For custom overrides for species ass images
	var/icon/ass_image

///////////
// PROCS //
///////////


/datum/species/New()
	wings_icons = string_list(wings_icons)
	..()

/**
 * Generates species available to choose in character setup at roundstart
 *
 * This proc generates which species are available to pick from in character setup.
 * If there are no available roundstart species, defaults to human.
 */
/proc/generate_selectable_species()
	for(var/I in subtypesof(/datum/species))
		var/datum/species/S = new I
		if(S.check_roundstart_eligible())
			GLOB.roundstart_races += S.id
			qdel(S)
	if(!GLOB.roundstart_races.len)
		GLOB.roundstart_races += "human"
	sortList(GLOB.roundstart_races)

/**
 * Checks if a species is eligible to be picked at roundstart.
 *
 * Checks the config to see if this species is allowed to be picked in the character setup menu.
 * Used by [proc/generate_selectable_species].
 */
/datum/species/proc/check_roundstart_eligible()
	if(id in (CONFIG_GET(keyed_list/roundstart_races)))
		return TRUE
	return FALSE

/**
 * Generates a random name for a carbon.
 *
 * This generates a random unique name based on a human's species and gender.
 * Arguments:
 * * gender - The gender that the name should adhere to. Use MALE for male names, use anything else for female names.
 * * unique - If true, ensures that this new name is not a duplicate of anyone else's name currently on the station.
 * * lastname - Does this species' naming system adhere to the last name system? Set to false if it doesn't.
 */
/datum/species/proc/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_name(gender)

	var/randname
	if(gender == MALE)
		randname = pick(GLOB.first_names_male)
	else
		randname = pick(GLOB.first_names_female)

	if(lastname)
		randname += " [lastname]"
	else
		randname += " [pick(GLOB.last_names)]"

	return randname

/**
 * Copies some vars and properties over that should be kept when creating a copy of this species.
 *
 * Used by slimepeople to copy themselves, and by the DNA datum to hardset DNA to a species
 * Arguments:
 * * old_species - The species that the carbon used to be before copying
 */
/datum/species/proc/copy_properties_from(datum/species/old_species)
	return

/** regenerate_organs
 * Corrects organs in a carbon, removing ones it doesn't need and adding ones it does
 *
 * takes all organ slots, removes organs a species should not have, adds organs a species should have.
 * can use replace_current to refresh all organs, creating an entirely new set.
 * Arguments:
 * * C - carbon, the owner of the species datum AKA whoever we're regenerating organs in
 * * old_species - datum, used when regenerate organs is called in a switching species to remove old mutant organs.
 * * replace_current - boolean, forces all old organs to get deleted whether or not they pass the species' ability to keep that organ
 * * excluded_zones - list, add zone defines to block organs inside of the zones from getting handled. see headless mutation for an example
 */
/datum/species/proc/regenerate_organs(mob/living/carbon/C, datum/species/old_species,replace_current=TRUE, list/excluded_zones, robotic = FALSE)
	//what should be put in if there is no mutantorgan (brains handled seperately)
	var/list/slot_mutantorgans = list( \
		ORGAN_SLOT_BRAIN = mutantbrain, \
		ORGAN_SLOT_HEART = robotic ? robotic_heart : mutantheart, \
		ORGAN_SLOT_LUNGS = robotic ? robotic_lungs : mutantlungs, \
		ORGAN_SLOT_APPENDIX = robotic ? robotic_appendix : mutantappendix, \
		ORGAN_SLOT_EYES = robotic ? robotic_eyes : mutanteyes, \
		ORGAN_SLOT_EARS = robotic ? robotic_ears : mutantears, \
		ORGAN_SLOT_TONGUE = robotic ? robotic_tongue : mutanttongue, \
		ORGAN_SLOT_LIVER = robotic ? robotic_liver : mutantliver, \
		ORGAN_SLOT_STOMACH = robotic ? robotic_stomach : mutantstomach)

	for(var/slot in list(ORGAN_SLOT_BRAIN, ORGAN_SLOT_HEART, ORGAN_SLOT_LUNGS, ORGAN_SLOT_APPENDIX, \
	ORGAN_SLOT_EYES, ORGAN_SLOT_EARS, ORGAN_SLOT_TONGUE, ORGAN_SLOT_LIVER, ORGAN_SLOT_STOMACH))

		var/obj/item/organ/oldorgan = C.getorganslot(slot) //used in removing
		var/obj/item/organ/neworgan = slot_mutantorgans[slot] //used in adding

		if(isnull(neworgan)) //If null is specified, just delete the old organ and call it a day
			QDEL_NULL(oldorgan)
			continue

		var/used_neworgan = FALSE
		neworgan = new neworgan()
		var/should_have = neworgan.get_availability(src) //organ proc that points back to a species trait (so if the species is supposed to have this organ)

		if(oldorgan && (!should_have || replace_current) && !(oldorgan.zone in excluded_zones))
			neworgan.damage = oldorgan.damage //apply the damage of the old organ to the new organ
			if(slot == ORGAN_SLOT_BRAIN)
				var/obj/item/organ/brain/brain = oldorgan
				if(!brain.decoy_override)//"Just keep it if it's fake" - confucius, probably
					brain.Remove(C,TRUE, TRUE) //brain argument used so it doesn't cause any... sudden death.
					QDEL_NULL(brain)
			oldorgan.Remove(C,TRUE)
			QDEL_NULL(oldorgan)

		if(!oldorgan && should_have && !(initial(neworgan.zone) in excluded_zones))
			used_neworgan = TRUE
			neworgan.Insert(C, TRUE, FALSE)

		if(!used_neworgan)
			qdel(neworgan)

	if(old_species)
		for(var/mutantorgan in old_species.mutant_organs)
			var/obj/item/organ/I = C.getorgan(mutantorgan)
			if(I)
				I.Remove(C)
				QDEL_NULL(I)

	for(var/path in mutant_organs)
		var/obj/item/organ/I = new path()
		var/obj/item/organ/old = C.getorgan(I)
		if(old)
			QDEL_NULL(old)
		I.Insert(C)

/datum/species/proc/is_digitigrade(mob/living/carbon/leg_haver)
	return (digitigrade_customization == DIGITIGRADE_OPTIONAL && leg_haver.dna.features["legs"] == "Digitigrade Legs") || digitigrade_customization == DIGITIGRADE_FORCED

/datum/species/proc/replace_body(mob/living/carbon/C, datum/species/new_species, robotic = FALSE)
	new_species ||= C.dna.species //If no new species is provided, assume its src.
	//Note for future: Potentionally add a new C.dna.species() to build a template species for more accurate limb replacement

	for(var/obj/item/bodypart/old_part as anything in C.bodyparts)
		var/obj/item/bodypart/new_part = C.new_body_part(old_part.body_zone, robotic, FALSE, new_species)
		new_part.brute_dam = old_part.brute_dam
		new_part.burn_dam = old_part.burn_dam
		new_part.replace_limb(C, TRUE)
		new_part.update_limb(is_creating = TRUE)
		qdel(old_part)

/**
	* Proc called when a carbon becomes this species.
	*
	* This sets up and adds/changes/removes things, qualities, abilities, and traits so that the transformation is as smooth and bugfree as possible.
	* Produces a [COMSIG_SPECIES_GAIN] signal.
	* Arguments:
	* * C - Carbon, this is whoever became the new species.
	* * old_species - The species that the carbon used to be before becoming this race, used for regenerating organs.
	* * pref_load - Preferences to be loaded from character setup, loads in preferred mutant things like bodyparts, digilegs, skin color, etc.
*/
/datum/species/proc/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load, robotic = FALSE)
	// Drop the items the new species can't wear
	if((AGENDER in species_traits))
		C.gender = PLURAL
	for(var/slot_id in no_equip)
		var/obj/item/thing = C.get_item_by_slot(slot_id)
		if(thing && (!thing.species_exception || !is_type_in_list(src,thing.species_exception)))
			C.dropItemToGround(thing)

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		for(var/obj/item/I in H.get_equipped_items(TRUE))
			if(I.restricted_bodytypes & H.dna.species.bodytype)
				H.dropItemToGround(I)

	if(C.hud_used)
		C.hud_used.update_locked_slots()

	replace_body(C, robotic = robotic)

	C.mob_biotypes = inherent_biotypes

	regenerate_organs(C, old_species, robotic = robotic)

	if(exotic_bloodtype && C.dna.blood_type != exotic_bloodtype)
		C.dna.blood_type = get_blood_type(exotic_bloodtype)

	if(old_species.mutanthands)
		for(var/obj/item/I in C.held_items)
			if(istype(I, old_species.mutanthands))
				qdel(I)

	if(mutanthands)
		// Drop items in hands
		// If you're lucky enough to have a TRAIT_NODROP item, then it stays.
		for(var/V in C.held_items)
			var/obj/item/I = V
			if(istype(I))
				C.dropItemToGround(I)
			else	//Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
				C.put_in_hands(new mutanthands())

	if(NOMOUTH in species_traits)
		for(var/obj/item/bodypart/head/head in C.bodyparts)
			head.mouth = FALSE

	if(SCLERA in species_traits)
		var/obj/item/organ/eyes/eyes = C.getorganslot(ORGAN_SLOT_EYES)
		eyes.sclera_color = sclera_color

	for(var/X in inherent_traits)
		ADD_TRAIT(C, X, SPECIES_TRAIT)

	if(TRAIT_VIRUSIMMUNE in inherent_traits)
		for(var/datum/disease/A in C.diseases)
			A.cure(FALSE)

	if(TRAIT_TOXIMMUNE in inherent_traits)
		C.setToxLoss(0, TRUE, TRUE)

	if(TRAIT_NOMETABOLISM in inherent_traits)
		C.end_metabolization(C, keep_liverless = TRUE)

	if(TRAIT_GENELESS in inherent_traits)
		C.dna.remove_all_mutations() // Radiation immune mobs can't get mutations normally

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction += i //Using +=/-= for this in case you also gain the faction from a different source.

	if(flying_species && isnull(fly))
		fly = new
		fly.Grant(C)

	C.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	C.bodytemperature = bodytemp_normal

	SEND_SIGNAL(C, COMSIG_SPECIES_GAIN, src, old_species)

/**
 * Proc called when a carbon is no longer this species.
 *
 * This sets up and adds/changes/removes things, qualities, abilities, and traits so that the transformation is as smooth and bugfree as possible.
 * Produces a [COMSIG_SPECIES_LOSS] signal.
 * Arguments:
 * * C - Carbon, this is whoever lost this species.
 * * new_species - The new species that the carbon became, used for genetics mutations.
 * * pref_load - Preferences to be loaded from character setup, loads in preferred mutant things like bodyparts, digilegs, skin color, etc.
 */
/datum/species/proc/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	if(C.dna.species.exotic_bloodtype)
		C.dna.blood_type = random_blood_type()

	if(NOMOUTH in species_traits)
		for(var/obj/item/bodypart/head/head in C.bodyparts)
			head.mouth = TRUE

	for(var/X in inherent_traits)
		REMOVE_TRAIT(C, X, SPECIES_TRAIT)

	//If their inert mutation is not the same, swap it out
	if((inert_mutation != new_species.inert_mutation) && LAZYLEN(C.dna.mutation_index) && (inert_mutation in C.dna.mutation_index))
		C.dna.remove_mutation(inert_mutation)
		//keep it at the right spot, so we can't have people taking shortcuts
		var/location = C.dna.mutation_index.Find(inert_mutation)
		C.dna.mutation_index[location] = new_species.inert_mutation
		C.dna.default_mutation_genes[location] = C.dna.mutation_index[location]
		C.dna.mutation_index[new_species.inert_mutation] = create_sequence(new_species.inert_mutation)
		C.dna.default_mutation_genes[new_species.inert_mutation] = C.dna.mutation_index[new_species.inert_mutation]

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction -= i

	if(flying_species)
		fly.Remove(C)
		QDEL_NULL(fly)
		if(C.movement_type & FLYING)
			ToggleFlight(C)
	if(C.dna && C.dna.species && (C.dna.features["wings"] == wings_icon))
		if("wings" in C.dna.species.mutant_bodyparts)
			C.dna.species.mutant_bodyparts -= "wings"
		C.dna.features["wings"] = "None"
		C.update_body()

	C.remove_movespeed_modifier(/datum/movespeed_modifier/species)
	SEND_SIGNAL(C, COMSIG_SPECIES_LOSS, src)

/**
 * Handles hair icons and dynamic hair.
 *
 * Handles hiding hair with clothing, hair layers, losing hair due to husking or augmented heads, facial hair, head hair, and hair styles.
 * Arguments:
 * * H - Human, whoever we're handling the hair for
 * * forced_colour - The colour of hair we're forcing on this human. Leave null to not change. Mind the british spelling!
 */
/datum/species/proc/handle_hair(mob/living/carbon/human/H, forced_colour)
	H.remove_overlay(HAIR_LAYER)
	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
	if(!HD) //Decapitated
		return

	if(HAS_TRAIT(H, TRAIT_HUSK))
		return
	var/datum/sprite_accessory/S
	var/list/standing = list()

	var/hair_hidden = FALSE //ignored if the matching dynamic_X_suffix is non-empty
	var/facialhair_hidden = FALSE // ^

	//we check if our hat or helmet hides our facial hair.
	if(H.head)
		var/obj/item/I = H.head
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/I = H.wear_mask
		if(I.flags_inv & HIDEFACIALHAIR)
			facialhair_hidden = TRUE

	if(H.facial_hairstyle && (FACEHAIR in species_traits) && !facialhair_hidden)
		S = GLOB.facial_hairstyles_list[H.facial_hairstyle]
		if(S)

			var/mutable_appearance/facial_overlay = mutable_appearance(S.icon, S.icon_state, -HAIR_LAYER)

			if(!forced_colour)
				if(hair_color)
					if(hair_color == "mutcolor")
						facial_overlay.color = "#" + H.dna.features["mcolor"]
					else if(hair_color == "fixedmutcolor")
						facial_overlay.color = "#[fixed_mut_color]"
					else
						facial_overlay.color = "#" + hair_color
				else
					facial_overlay.color = "#" + H.facial_hair_color
			else
				facial_overlay.color = forced_colour

			facial_overlay.alpha = hair_alpha

			standing += facial_overlay

	if(H.head)
		var/obj/item/I = H.head
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(H.wear_mask)
		var/obj/item/I = H.wear_mask
		if(I.flags_inv & HIDEHAIR)
			hair_hidden = TRUE

	if(!hair_hidden)
		var/mutable_appearance/hair_overlay = mutable_appearance(layer = -HAIR_LAYER)
		var/mutable_appearance/gradient_overlay = mutable_appearance(layer = -HAIR_LAYER)
		if(!hair_hidden && !H.getorgan(/obj/item/organ/brain)) //Applies the debrained overlay if there is no brain
			if(!(NOBLOOD in species_traits))
				hair_overlay.icon = 'icons/mob/human_face.dmi'
				hair_overlay.icon_state = "debrained"

		else if(H.hairstyle && (HAIR in species_traits))
			S = GLOB.hairstyles_list[H.hairstyle]
			if(S)

				var/hair_state = S.icon_state
				var/hair_file = S.icon

				hair_overlay.icon = hair_file
				hair_overlay.icon_state = hair_state

				if(!forced_colour)
					if(hair_color)
						if(hair_color == "mutcolor")
							hair_overlay.color = "#" + H.dna.features["mcolor"]
						else if(hair_color == "fixedmutcolor")
							hair_overlay.color = "#[fixed_mut_color]"
						else
							hair_overlay.color = "#" + hair_color
					else
						hair_overlay.color = "#" + H.hair_color

					//Gradients
					grad_style = H.grad_style
					grad_color = H.grad_color
					if(grad_style)
						var/datum/sprite_accessory/gradient = GLOB.hair_gradients_list[grad_style]
						var/icon/temp = icon(gradient.icon, gradient.icon_state)
						var/icon/temp_hair = icon(hair_file, hair_state)
						temp.Blend(temp_hair, ICON_ADD)
						gradient_overlay.icon = temp
						gradient_overlay.color = "#" + grad_color


				else
					hair_overlay.color = forced_colour
				hair_overlay.alpha = hair_alpha
		if(hair_overlay.icon)
			standing += hair_overlay
			standing += gradient_overlay

	if(standing.len)
		H.overlays_standing[HAIR_LAYER] = standing

	H.apply_overlay(HAIR_LAYER)

/**
 * Handles the body of a human
 *
 * Handles lipstick, having no eyes, eye color, undergarnments like underwear, undershirts, and socks, and body layers.
 * Calls [handle_mutant_bodyparts][/datum/species/proc/handle_mutant_bodyparts]
 * Arguments:
 * * H - Human, whoever we're handling the body for
 */
/datum/species/proc/handle_body(mob/living/carbon/human/H)
	H.remove_overlay(BODY_LAYER)

	var/list/standing = list()

	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)

	if(HD && !(HAS_TRAIT(H, TRAIT_HUSK)))
		// lipstick
		if(H.lip_style && (LIPS in species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[H.lip_style]", -BODY_LAYER)
			lip_overlay.color = H.lip_color
			standing += lip_overlay

		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/eye_overlay
			var/mutable_appearance/sclera_overlay

			if(eyes)
				if(!HAS_TRAIT(H, TRAIT_EYESCLOSED) && !(H.stat == DEAD))

					if(iskepori(H)) // Kepori need sclera but don't fit the normal silhouette, so this needs changing. Make better later.
						eye_overlay = mutable_appearance('icons/mob/species/kepori/kepori_eyes.dmi', eyes.eye_icon_state, -BODYPARTS_LAYER)
						sclera_overlay = mutable_appearance('icons/mob/species/kepori/kepori_eyes.dmi', eyes.sclera_icon_state, -BODYPARTS_LAYER)

					else
						eye_overlay = mutable_appearance(species_eye_path || 'icons/mob/human_face.dmi', eyes.eye_icon_state, -BODYPARTS_LAYER)
						sclera_overlay = mutable_appearance('icons/mob/human_face.dmi', eyes.sclera_icon_state, -BODYPARTS_LAYER)

					if((EYECOLOR in species_traits) && eyes)
						eye_overlay.color = "#" + H.eye_color

					if((SCLERA in species_traits) && eyes)
						sclera_overlay.color = "#" + H.sclera_color
						standing += sclera_overlay

					standing += eye_overlay

		if(EMOTE_OVERLAY in species_traits)
			// blush
			if (HAS_TRAIT(H, TRAIT_BLUSHING)) // Caused by either the *blush emote or the "drunk" mood event
				var/mutable_appearance/blush_overlay = mutable_appearance('icons/mob/human_face.dmi', "blush", -BODY_ADJ_LAYER) //should appear behind the eyes
				if(H.dna && H.dna.species && H.dna.species.blush_color)
					blush_overlay.color = H.dna.species.blush_color
				standing += blush_overlay

			// snore
			if (HAS_TRAIT(H, TRAIT_SNORE)) // Caused by the snore emote
				var/mutable_appearance/snore_overlay = mutable_appearance('icons/mob/human_face.dmi', "snore", BODY_ADJ_LAYER) //should appear behind the eyes
				standing += snore_overlay

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(H.underwear)
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[H.underwear]
			if(underwear)
				var/mutable_appearance/underwear_overlay
				var/icon_state = underwear.icon_state
				var/icon_file = underwear.icon
				if((H.dna.species.bodytype & BODYTYPE_KEPORI))
					icon_file = KEPORI_UNDERWEAR_LEGS_PATH
				if((H.dna.species.bodytype & BODYTYPE_VOX))
					icon_file = VOX_UNDERWEAR_LEGS_PATH
				if(underwear.has_digitigrade && (H.dna.species.bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				underwear_overlay = mutable_appearance(icon_file, icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = "#" + H.underwear_color
				standing += underwear_overlay

		if(H.undershirt)
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[H.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_overlay
				var/icon_file = undershirt.icon
				if((H.dna.species.bodytype & BODYTYPE_KEPORI))
					icon_file = KEPORI_UNDERWEAR_TORSO_PATH
				if((H.dna.species.bodytype & BODYTYPE_VOX))
					icon_file = VOX_UNDERWEAR_TORSO_PATH
				undershirt_overlay = mutable_appearance(icon_file, undershirt.icon_state, -BODY_LAYER)
				if(!undershirt.use_static)
					undershirt_overlay.color = "#" + H.undershirt_color
				standing += undershirt_overlay

		if(H.socks && H.num_legs >= 2 && !(NOSOCKS in species_traits))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[H.socks]
			if(socks)
				var/mutable_appearance/socks_overlay
				var/icon_state = socks.icon_state
				var/icon_file = socks.icon
				if((H.dna.species.bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				if((H.dna.species.bodytype & BODYTYPE_KEPORI))
					icon_file = KEPORI_UNDERWEAR_SOCKS_PATH
				if((H.dna.species.bodytype & BODYTYPE_VOX))
					icon_file = VOX_UNDERWEAR_SOCKS_PATH
				socks_overlay = mutable_appearance(icon_file, icon_state, -BODY_LAYER)
				if(!socks.use_static)
					socks_overlay.color = "#" + H.socks_color
				standing += socks_overlay

	if(standing.len)
		H.overlays_standing[BODY_LAYER] = standing

	H.apply_overlay(BODY_LAYER)
	handle_mutant_bodyparts(H)

/**
 * Handles the mutant bodyparts of a human
 *
 * Handles the adding and displaying of, layers, colors, and overlays of mutant bodyparts and accessories.
 * Handles digitigrade leg displaying and squishing.
 * Arguments:
 * * H - Human, whoever we're handling the body for
 * * forced_colour - The forced color of an accessory. Leave null to use mutant color.
 */
/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	var/list/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/list/standing	= list()

	H.remove_overlay(BODY_BEHIND_LAYER)
	H.remove_overlay(BODY_ADJ_LAYER)
	H.remove_overlay(BODY_FRONT_LAYER)

	if(!mutant_bodyparts)
		return

	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)

	if("tail_human" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "tail_human"

	if("waggingtail_human" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "waggingtail_human"
		else if ("tail_human" in mutant_bodyparts)
			bodyparts_to_add -= "waggingtail_human"

	if("spines" in mutant_bodyparts)
		if(!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "spines"

	if("waggingspines" in mutant_bodyparts)
		if(!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "waggingspines"
		else if ("tail" in mutant_bodyparts)
			bodyparts_to_add -= "waggingspines"

	if("face_markings" in mutant_bodyparts) //Take a closer look at that snout! //technically
		if((H.wear_mask?.flags_inv & HIDEFACE) || (H.head?.flags_inv & HIDEFACE) || !HD)
			bodyparts_to_add -= "face_markings"

	if("horns" in mutant_bodyparts)
		if(!H.dna.features["horns"] || H.dna.features["horns"] == "None" || H.head && (H.head.flags_inv & HIDEHORNS) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHORNS)) || !HD)
			bodyparts_to_add -= "horns"

	if("frills" in mutant_bodyparts)
		if(!H.dna.features["frills"] || H.dna.features["frills"] == "None" || (H.head?.flags_inv & HIDEEARS) || !HD)
			bodyparts_to_add -= "frills"

	if("ears" in mutant_bodyparts)
		if(!H.dna.features["ears"] || H.dna.features["ears"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
			bodyparts_to_add -= "ears"
			bodyparts_to_add -= "ears"

	if("ipc_screen" in mutant_bodyparts)
		if(!H.dna.features["ipc_screen"] || H.dna.features["ipc_screen"] == "None" || (H.wear_mask && (H.wear_mask.flags_inv & HIDEEYES)) || !HD)
			bodyparts_to_add -= "ipc_screen"

	if("ipc_antenna" in mutant_bodyparts)
		if(!H.dna.features["ipc_antenna"] || H.dna.features["ipc_antenna"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || !HD)
			bodyparts_to_add -= "ipc_antenna"

	if("spider_mandibles" in mutant_bodyparts)
		if(!H.dna.features["spider_mandibles"] || H.dna.features["spider_mandibles"] == "None" || H.head && (H.head.flags_inv & HIDEFACE) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || !HD) //|| HD.status == BODYTYPE_ROBOTIC removed from here
			bodyparts_to_add -= "spider_mandibles"

	if("squid_face" in mutant_bodyparts)
		if(!H.dna.features["squid_face"] || H.dna.features["squid_face"] == "None" || H.head && (H.head.flags_inv & HIDEFACE) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || !HD) // || HD.status == BODYTYPE_ROBOTIC
			bodyparts_to_add -= "squid_face"

	if("kepori_tail_feathers" in mutant_bodyparts)
		if(!H.dna.features["kepori_tail_feathers"] || H.dna.features["kepori_tail_feathers"] == "None")
			bodyparts_to_add -= "kepori_tail_feathers"

	if("kepori_feathers" in mutant_bodyparts)
		if(!H.dna.features["kepori_feathers"] || H.dna.features["kepori_feathers"] == "None" || (H.head && (H.head.flags_inv & HIDEHAIR)) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD) //HD.status == BODYTYPE_ROBOTIC) and here too
			bodyparts_to_add -= "kepori_feathers"

	if("vox_head_quills" in mutant_bodyparts)
		if(!H.dna.features["vox_head_quills"] || H.dna.features["vox_head_quills"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
			bodyparts_to_add -= "vox_head_quills"

	if("vox_neck_quills" in mutant_bodyparts)
		if(!H.dna.features["vox_neck_quills"] || H.dna.features["vox_neck_quills"] == "None")
			bodyparts_to_add -= "vox_neck_quills"

	////PUT ALL YOUR WEIRD ASS REAL-LIMB HANDLING HERE

	///Digi handling
	if(H.dna.species.bodytype & BODYTYPE_DIGITIGRADE)
		var/uniform_compatible = FALSE
		var/suit_compatible = FALSE
		if(!(H.w_uniform) || (H.w_uniform.supports_variations & DIGITIGRADE_VARIATION) || (H.w_uniform.supports_variations & DIGITIGRADE_VARIATION_NO_NEW_ICON) || (H.w_uniform.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)) //Checks uniform compatibility
			uniform_compatible = TRUE
		if((!H.wear_suit) || (H.wear_suit.supports_variations & DIGITIGRADE_VARIATION) || !(H.wear_suit.body_parts_covered & LEGS) || (H.wear_suit.supports_variations & DIGITIGRADE_VARIATION_NO_NEW_ICON) || (H.wear_suit.supports_variations & DIGITIGRADE_VARIATION_SAME_ICON_FILE)) //Checks suit compatability
			suit_compatible = TRUE

		var/show_digitigrade = suit_compatible && (uniform_compatible || H.wear_suit?.flags_inv & HIDEJUMPSUIT) //If the uniform is hidden, it doesnt matter if its compatible
		for(var/obj/item/bodypart/BP as anything in H.bodyparts)
			if(BP.bodytype & BODYTYPE_DIGITIGRADE)
				BP.plantigrade_forced = !show_digitigrade

	///End digi handling

	////END REAL-LIMB HANDLING
	H.update_body_parts()



	if(!bodyparts_to_add)
		return

	var/g = (H.gender == FEMALE) ? "f" : "m"

	for(var/layer in relevent_layers)
		var/layertext = mutant_bodyparts_layertext(layer)

		for(var/bodypart in bodyparts_to_add)
			var/datum/sprite_accessory/S
			switch(bodypart)
				if("tail_lizard")
					S = GLOB.tails_list_lizard[H.dna.features["tail_lizard"]]
				if("waggingtail_lizard")
					S = GLOB.animated_tails_list_lizard[H.dna.features["tail_lizard"]]
				if("tail_human")
					S = GLOB.tails_list_human[H.dna.features["tail_human"]]
				if("waggingtail_human")
					S = GLOB.animated_tails_list_human[H.dna.features["tail_human"]]
				if("spines")
					S = GLOB.spines_list[H.dna.features["spines"]]
				if("waggingspines")
					S = GLOB.animated_spines_list[H.dna.features["spines"]]
				if("face_markings")
					S = GLOB.face_markings_list[H.dna.features["face_markings"]]
				if("frills")
					S = GLOB.frills_list[H.dna.features["frills"]]
				if("horns")
					S = GLOB.horns_list[H.dna.features["horns"]]
				if("ears")
					S = GLOB.ears_list[H.dna.features["ears"]]
				if("body_markings")
					S = GLOB.body_markings_list[H.dna.features["body_markings"]]
				if("wings")
					S = GLOB.wings_list[H.dna.features["wings"]]
				if("wingsopen")
					S = GLOB.wings_open_list[H.dna.features["wings"]]
				if("legs")
					S = GLOB.legs_list[H.dna.features["legs"]]
				if("moth_wings")
					S = GLOB.moth_wings_list[H.dna.features["moth_wings"]]
				if("moth_fluff")
					S = GLOB.moth_fluff_list[H.dna.features["moth_fluff"]]
				if("moth_markings")
					S = GLOB.moth_markings_list[H.dna.features["moth_markings"]]
				if("squid_face")
					S = GLOB.squid_face_list[H.dna.features["squid_face"]]
				if("ipc_screen")
					S = GLOB.ipc_screens_list[H.dna.features["ipc_screen"]]
				if("ipc_antenna")
					S = GLOB.ipc_antennas_list[H.dna.features["ipc_antenna"]]
				if("ipc_tail")
					S = GLOB.ipc_tail_list[H.dna.features["ipc_tail"]]
				if("ipc_chassis")
					S = GLOB.ipc_chassis_list[H.dna.features["ipc_chassis"]]
				if("ipc_brain")
					S = GLOB.ipc_brain_list[H.dna.features["ipc_brain"]]
				if("spider_legs")
					S = GLOB.spider_legs_list[H.dna.features["spider_legs"]]
				if("spider_spinneret")
					S = GLOB.spider_spinneret_list[H.dna.features["spider_spinneret"]]
				if("kepori_body_feathers")
					S = GLOB.kepori_body_feathers_list[H.dna.features["kepori_body_feathers"]]
				if("kepori_head_feathers")
					S = GLOB.kepori_head_feathers_list[H.dna.features["kepori_head_feathers"]]
				if("kepori_tail_feathers")
					S = GLOB.kepori_tail_feathers_list[H.dna.features["kepori_tail_feathers"]]
				if("kepori_feathers")
					S = GLOB.kepori_feathers_list[H.dna.features["kepori_feathers"]]
				if("vox_head_quills")
					S = GLOB.vox_head_quills_list[H.dna.features["vox_head_quills"]]
				if("vox_neck_quills")
					S = GLOB.vox_neck_quills_list[H.dna.features["vox_neck_quills"]]
				if("elzu_horns")
					S = GLOB.elzu_horns_list[H.dna.features["elzu_horns"]]
				if("tail_elzu")
					S = GLOB.tails_list_elzu[H.dna.features["tail_elzu"]]
				if("waggingtail_elzu")
					S = GLOB.animated_tails_list_elzu[H.dna.features["tail_elzu"]]
			if(!S || S.icon_state == "none")
				continue

			var/mutable_appearance/accessory_overlay = mutable_appearance(S.icon, layer = -layer)

			//A little rename so we don't have to use tail_lizard, tail_human, or tail_elzu when naming the sprites.
			accessory_overlay.alpha = S.image_alpha
			if(bodypart == "tail_lizard" || bodypart == "tail_human" || bodypart == "tail_elzu")
				bodypart = "tail"
			else if(bodypart == "waggingtail_lizard" || bodypart == "waggingtail_human" || bodypart == "waggingtail_elzu")
				bodypart = "waggingtail"

			var/used_color_src = S.color_src

			var/icon_state_name = S.icon_state
			if(S.synthetic_icon_state)
				var/obj/item/bodypart/attachment_point = H.get_bodypart(S.body_zone)
				if(attachment_point && IS_ROBOTIC_LIMB(attachment_point))
					icon_state_name = S.synthetic_icon_state
					if(S.synthetic_color_src)
						used_color_src = S.synthetic_color_src

			if(S.gender_specific)
				accessory_overlay.icon_state = "[g]_[bodypart]_[icon_state_name]_[layertext]"
			else
				accessory_overlay.icon_state = "m_[bodypart]_[icon_state_name]_[layertext]"

			if(S.center)
				accessory_overlay = center_image(accessory_overlay, S.dimension_x, S.dimension_y)

			if(!(HAS_TRAIT(H, TRAIT_HUSK)))
				if(!forced_colour)
					switch(used_color_src)
						if(MUTCOLORS)
							if(fixed_mut_color)
								accessory_overlay.color = "#[fixed_mut_color]"
							else
								accessory_overlay.color = "#[H.dna.features["mcolor"]]"
						if(MUTCOLORS_SECONDARY)
							accessory_overlay.color = "#[H.dna.features["mcolor2"]]"
						if(SKINCOLORS)
							accessory_overlay.color = "#[(skintone2hex(H.skin_tone))]"

						if(HAIR)
							if(hair_color == "mutcolor")
								accessory_overlay.color = "#[H.dna.features["mcolor"]]"
							else if(hair_color == "fixedmutcolor")
								accessory_overlay.color = "#[fixed_mut_color]"
							else
								accessory_overlay.color = "#[H.hair_color]"
						if(FACEHAIR)
							accessory_overlay.color = "#[H.facial_hair_color]"
						if(EYECOLOR)
							accessory_overlay.color = "#[H.eye_color]"
				else
					accessory_overlay.color = forced_colour
			standing += accessory_overlay

			if(S.secondary_color)
				var/mutable_appearance/secondary_color_overlay = mutable_appearance(S.icon, layer = -layer)
				if(S.gender_specific)
					secondary_color_overlay.icon_state = "[g]_[bodypart]_secondary_[S.icon_state]_[layertext]"
				else
					secondary_color_overlay.icon_state = "m_[bodypart]_secondary_[S.icon_state]_[layertext]"

				if(S.center)
					secondary_color_overlay = center_image(secondary_color_overlay, S.dimension_x, S.dimension_y)
				secondary_color_overlay.color = "#[H.dna.features["mcolor2"]]"
				standing += secondary_color_overlay

		H.overlays_standing[layer] = standing.Copy()
		standing = list()

	H.apply_overlay(BODY_BEHIND_LAYER)
	H.apply_overlay(BODY_ADJ_LAYER)
	H.apply_overlay(BODY_FRONT_LAYER)

//This exists so sprite accessories can still be per-layer without having to include that layer's
//number in their sprite name, which causes issues when those numbers change.
/datum/species/proc/mutant_bodyparts_layertext(layer)
	switch(layer)
		if(BODY_BEHIND_LAYER)
			return "BEHIND"
		if(BODY_ADJ_LAYER)
			return "ADJ"
		if(BODY_FRONT_LAYER)
			return "FRONT"

/datum/species/proc/spec_life(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		H.setOxyLoss(0)
		H.losebreath = 0

		var/takes_crit_damage = (!HAS_TRAIT(H, TRAIT_NOCRITDAMAGE) && H.stat != DEAD)
		if((H.health < H.crit_threshold) && takes_crit_damage)
			H.adjustBruteLoss(1)
	if(flying_species)
		HandleFlight(H)

/datum/species/proc/spec_death(gibbed, mob/living/carbon/human/H)
	return

/datum/species/proc/auto_equip(mob/living/carbon/human/H)
	// handles the equipping of species-specific gear
	return

/datum/species/proc/can_equip(obj/item/I, slot, disable_warning, mob/living/carbon/human/H, bypass_equip_delay_self = FALSE, swap = FALSE)
	if(slot in no_equip)
		if(!I.species_exception || !is_type_in_list(src, I.species_exception))
			return FALSE

	if(I.restricted_bodytypes & H.dna.species.bodytype)
		to_chat(H, span_warning("Your species cannot wear this item!"))
		return FALSE

	switch(slot)
		if(ITEM_SLOT_HANDS)
			if(H.get_empty_held_indexes())
				return TRUE
			return FALSE
		if(ITEM_SLOT_MASK)
			if(H.wear_mask && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_MASK))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_NECK)
			if(H.wear_neck && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_NECK))
				return FALSE
			return TRUE
		if(ITEM_SLOT_BACK)
			if(H.back && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_BACK))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_OCLOTHING)
			if(H.wear_suit && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_OCLOTHING))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_GLOVES)
			if(H.gloves && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_GLOVES))
				return FALSE
			if(H.num_hands < 2)
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_FEET)
			if(H.shoes && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_FEET))
				return FALSE
			if(H.num_legs < 2)
				return FALSE
			if((bodytype & BODYTYPE_DIGITIGRADE) && !(I.supports_variations & DIGITIGRADE_VARIATION))
				if(!disable_warning)
					to_chat(H, span_warning("This footwear isn't compatible with your feet!"))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_BELT)
			if(H.belt && !swap)
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_CHEST)

			if(!H.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_BELT))
				return
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_EYES)
			if(H.glasses && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_EYES))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			var/obj/item/organ/eyes/E = H.getorganslot(ORGAN_SLOT_EYES)
			if(E?.no_glasses)
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_HEAD)
			if(H.head && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_HEAD))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_EARS)
			if(H.ears && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_EARS))
				return FALSE
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_ICLOTHING)
			if(H.w_uniform && !swap)
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_ICLOTHING))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_ID)
			if(H.wear_id)
				if(SEND_SIGNAL(H.wear_id, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE))
					return TRUE
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_CHEST)
			if(!H.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(!(I.slot_flags & ITEM_SLOT_ID))
				return FALSE
			return H.equip_delay_self_check(I, bypass_equip_delay_self)
		if(ITEM_SLOT_LPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP)) //Pockets aren't visible, so you can't move TRAIT_NODROP items into them.
				return FALSE
			if(H.l_store)
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_L_LEG)

			if(!H.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_LPOCKET))
				return TRUE
		if(ITEM_SLOT_RPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(H.r_store)
				return FALSE

			var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_LEG)

			if(!H.w_uniform && !nojumpsuit && (!O || IS_ORGANIC_LIMB(O)))
				if(!disable_warning)
					to_chat(H, span_warning("You need a jumpsuit before you can attach this [I.name]!"))
				return FALSE
			if(I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_RPOCKET))
				return TRUE
			return FALSE
		if(ITEM_SLOT_SUITSTORE)
			if(HAS_TRAIT(I, TRAIT_NODROP))
				return FALSE
			if(H.s_store && !swap)
				return FALSE
			if(HAS_TRAIT(I, TRAIT_FORCE_SUIT_STORAGE_ALWAYS))
				return TRUE
			if(HAS_TRAIT(I, TRAIT_FORCE_SUIT_STORAGE))
				if(!H.w_uniform)
					if(!disable_warning)
						to_chat(H, span_warning("You need at least a uniform before you can attach this [I.name]!"))
					return FALSE
				return TRUE
			if(!H.wear_suit)
				if(!disable_warning)
					to_chat(H, span_warning("You need a suit before you can attach this [I.name]!"))
				return FALSE
			if(!H.wear_suit.allowed)
				if(!disable_warning)
					to_chat(H, span_warning("You somehow have a suit with no defined allowed items for suit storage, stop that."))
				return FALSE
			if(I.w_class > WEIGHT_CLASS_BULKY)
				if(!disable_warning)
					to_chat(H, span_warning("The [I.name] is too big to attach!")) //should be src?
				return FALSE
			if(istype(I, /obj/item/pda) || istype(I, /obj/item/pen) || is_type_in_list(I, H.wear_suit.allowed))
				return TRUE
			return FALSE
		if(ITEM_SLOT_HANDCUFFED)
			if(H.handcuffed)
				return FALSE
			if(!istype(I, /obj/item/restraints/handcuffs))
				return FALSE
			if(H.num_hands < 2)
				return FALSE
			return TRUE
		if(ITEM_SLOT_LEGCUFFED)
			if(H.legcuffed)
				return FALSE
			if(!istype(I, /obj/item/restraints/legcuffs))
				return FALSE
			if(H.num_legs < 2)
				return FALSE
			return TRUE
		if(ITEM_SLOT_BACKPACK)
			if(H.back)
				if(SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_CAN_INSERT, I, H, TRUE, TRUE))
					return TRUE
			return FALSE
	return FALSE //Unsupported slot

/datum/species/proc/equip_delay_self_check(obj/item/to_equip, mob/living/carbon/human/ourhuman, bypass_equip_delay_self)
	if(!to_equip.equip_delay_self || bypass_equip_delay_self)
		return TRUE

	ourhuman.visible_message(
	span_notice("[ourhuman] start putting on [to_equip]..."),
	span_notice("You start putting on [to_equip]...")
	)

	. = to_equip.do_equip_wait(ourhuman, to_equip.equipping_sound)

	if(.)
		ourhuman.visible_message(
			span_notice("[src] puts on [to_equip]."),
			span_notice("You puts on [to_equip].")
		)

/datum/species/proc/before_equip_job(datum/job/J, mob/living/carbon/human/H)
	return

/datum/species/proc/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.update_mutant_bodyparts()


// Do species-specific reagent handling here
// Return 0 if it should do normal processing too
// Return 1 if it's effect is handled entirely by species code
// Other return values will cause weird badness
/datum/species/proc/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	SHOULD_CALL_PARENT(TRUE)

	if(chem.type == exotic_blood)
		H.blood_volume = min(H.blood_volume + round(chem.volume, 0.1), BLOOD_VOLUME_MAXIMUM)
		H.reagents.del_reagent(chem.type)
		return TRUE
	//This handles dumping unprocessable reagents.
	var/dump_reagent = TRUE
	if((chem.process_flags & SYNTHETIC) && (H.dna.species.reagent_tag & PROCESS_SYNTHETIC))		//SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC
		dump_reagent = FALSE
	if((chem.process_flags & ORGANIC) && (H.dna.species.reagent_tag & PROCESS_ORGANIC))		//ORGANIC-oriented reagents require PROCESS_ORGANIC
		dump_reagent = FALSE
	if(dump_reagent)
		chem.holder.remove_reagent(chem.type, chem.metabolization_rate)
		return TRUE
	return FALSE


//return a list of spans or an empty list
/datum/species/proc/get_spans()
	return list()

/**
 * Equip the outfit required for life. Replaces items currently worn.
 */
/datum/species/proc/give_important_for_life(mob/living/carbon/human/human_to_equip)
	if(!outfit_important_for_life)
		return

	outfit_important_for_life= new()
	outfit_important_for_life.equip(human_to_equip)

////////
//LIFE//
////////
/datum/species/proc/handle_digestion(mob/living/carbon/human/H)
	if(HAS_TRAIT(src, TRAIT_NOHUNGER))
		return //hunger is for BABIES

	// nutrition decrease and satiety
	if (H.nutrition > 0 && H.stat != DEAD && !HAS_TRAIT(H, TRAIT_NOHUNGER))
		// THEY HUNGER
		var/hunger_rate = HUNGER_FACTOR
		var/datum/component/mood/mood = H.GetComponent(/datum/component/mood)
		if(mood && mood.sanity > SANITY_DISTURBED)
			hunger_rate *= max(0.5, 1 - 0.002 * mood.sanity) //0.85 to 0.75
		// Whether we cap off our satiety or move it towards 0
		if(H.satiety > MAX_SATIETY)
			H.satiety = MAX_SATIETY
		else if(H.satiety > 0)
			H.satiety--
		else if(H.satiety < -MAX_SATIETY)
			H.satiety = -MAX_SATIETY
		else if(H.satiety < 0)
			H.satiety++
			if(prob(round(-H.satiety/40)))
				H.adjust_timed_status_effect(5 SECONDS, /datum/status_effect/jitter)
			hunger_rate = 3 * HUNGER_FACTOR
		hunger_rate *= H.physiology.hunger_mod
		H.adjust_nutrition(-hunger_rate)


	if (H.nutrition > NUTRITION_LEVEL_FULL)
		if(H.overeatduration < 600) //capped so people don't take forever to unfat
			H.overeatduration++
	else
		if(H.overeatduration > 1)
			H.overeatduration -= 2 //doubled the unfat rate

	//metabolism change
	if(H.nutrition > NUTRITION_LEVEL_FED && H.satiety > 80)
		if(H.metabolism_efficiency != 1.25 && !HAS_TRAIT(H, TRAIT_NOHUNGER))
			to_chat(H, span_notice("You feel vigorous."))
			H.metabolism_efficiency = 1.25
	else if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		if(H.metabolism_efficiency != 0.8)
			to_chat(H, span_notice("You feel sluggish."))
		H.metabolism_efficiency = 0.8
	else
		if(H.metabolism_efficiency == 1.25)
			to_chat(H, span_notice("You no longer feel vigorous."))
		H.metabolism_efficiency = 1

	//Hunger slowdown for if mood isn't enabled
	if(CONFIG_GET(flag/disable_human_mood))
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			var/hungry = (500 - H.nutrition) / 5 //So overeat would be 100 and default level would be 80
			if(hungry >= 70)
				H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/hunger, multiplicative_slowdown = (hungry / 50))
			else if(iselzuose(H))
				var/datum/species/elzuose/E = H.dna.species
				if(E.get_charge(H) <= ELZUOSE_CHARGE_NORMAL)
					H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/hunger, multiplicative_slowdown = (1.5 * (1 - E.get_charge(H) / 100)))
			else
				H.remove_movespeed_modifier(/datum/movespeed_modifier/hunger)

	switch(H.nutrition)
		if(NUTRITION_LEVEL_HUNGRY to INFINITY)
			H.clear_alert("nutrition")
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
			H.throw_alert("nutrition", /atom/movable/screen/alert/hungry)
		if(0 to NUTRITION_LEVEL_STARVING)
			H.throw_alert("nutrition", /atom/movable/screen/alert/starving)

/datum/species/proc/update_health_hud(mob/living/carbon/human/H)
	return 0

/datum/species/proc/handle_mutations_and_radiation(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_RADIMMUNE))
		H.radiation = 0
		return TRUE

	. = FALSE
	var/radiation = H.radiation

	if(radiation > RAD_MOB_KNOCKDOWN && prob(RAD_MOB_KNOCKDOWN_PROB))
		if(!H.IsParalyzed())
			H.emote("collapse")
		H.Paralyze(RAD_MOB_KNOCKDOWN_AMOUNT)
		to_chat(H, span_danger("You feel weak."))

	if(radiation > RAD_MOB_VOMIT && prob(RAD_MOB_VOMIT_PROB))
		H.vomit(10, TRUE)

	if(radiation > RAD_MOB_HAIRLOSS)
		if(prob(15) && !(H.hairstyle == "Bald") && (HAIR in species_traits))
			to_chat(H, span_danger("Your hair starts to fall out in clumps..."))
			addtimer(CALLBACK(src, PROC_REF(go_bald), H), 50)

/datum/species/proc/go_bald(mob/living/carbon/human/H)
	if(QDELETED(H))	//may be called from a timer
		return
	H.facial_hairstyle = "Shaved"
	H.hairstyle = "Bald"
	H.update_hair()

//////////////////
// ATTACK PROCS //
//////////////////

/datum/species/proc/spec_updatehealth(mob/living/carbon/human/H)
	return

/datum/species/proc/spec_fully_heal(mob/living/carbon/human/H)
	return


/datum/species/proc/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(target.body_position == STANDING_UP || (target.health >= 0 && !HAS_TRAIT(target, TRAIT_FAKEDEATH)))
		target.help_shake_act(user)
		if(target != user)
			log_combat(user, target, "shaken")
		return TRUE
	else
		user.do_cpr(target)

/datum/species/proc/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(target.check_block())
		target.visible_message(span_warning("[target] blocks [user]'s grab!"), \
						span_userdanger("You block [user]'s grab!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("Your grab at [target] was blocked!"))
		return FALSE
	if(attacker_style && attacker_style.grab_act(user,target))
		return TRUE
	else
		//Steal them shoes
		if(target.body_position == LYING_DOWN && (user.zone_selected == BODY_ZONE_L_LEG || user.zone_selected == BODY_ZONE_R_LEG) && user.a_intent == INTENT_GRAB && target.shoes)
			var/obj/item/I = target.shoes
			user.visible_message(span_warning("[user] starts stealing [target]'s [I.name]!"),
							span_danger("You start stealing [target]'s [I.name]..."), null, null, target)
			to_chat(target, span_userdanger("[user] starts stealing your [I.name]!"))
			if(do_after(user, I.strip_delay, target))
				target.dropItemToGround(I, TRUE)
				user.put_in_hands(I)
				user.visible_message(span_warning("[user] stole [target]'s [I.name]!"),
								span_notice("You stole [target]'s [I.name]!"), null, null, target)
				to_chat(target, span_userdanger("[user] stole your [I.name]!"))
		target.grabbedby(user)
		return TRUE

///This proc handles punching damage. IMPORTANT: Our owner is the TARGET and not the USER in this proc. For whatever reason...
/datum/species/proc/harm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm [target]!"))
		return FALSE
	if(target.check_block())
		target.visible_message(span_warning("[target] blocks [user]'s attack!"), \
						span_userdanger("You block [user]'s attack!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("Your attack at [target] was blocked!"))
		return FALSE
	if(attacker_style && attacker_style.harm_act(user,target))
		return TRUE
	else

		var/atk_verb = user.dna.species.attack_verb
		if(target.body_position == LYING_DOWN)
			atk_verb = ATTACK_EFFECT_KICK

		switch(atk_verb)//this code is really stupid but some genius apparently made "claw" and "slash" two attack types but also the same one so it's needed i guess
			if(ATTACK_EFFECT_KICK)
				user.do_attack_animation(target, ATTACK_EFFECT_KICK)
			if(ATTACK_EFFECT_SLASH, ATTACK_EFFECT_CLAW)//smh
				user.do_attack_animation(target, ATTACK_EFFECT_CLAW)
			if(ATTACK_EFFECT_SMASH)
				user.do_attack_animation(target, ATTACK_EFFECT_SMASH)
			else
				user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)

		var/damage = rand(user.dna.species.punchdamagelow, user.dna.species.punchdamagehigh)

		var/obj/item/bodypart/affecting = target.get_bodypart(ran_zone(user.zone_selected))

		var/miss_chance = 100//calculate the odds that a punch misses entirely. considers stamina and brute damage of the puncher. punches miss by default to prevent weird cases
		if(user.dna.species.punchdamagelow)
			if(atk_verb == ATTACK_EFFECT_KICK || HAS_TRAIT(user, TRAIT_PERFECT_ATTACKER)) //kicks never miss (provided your species deals more than 0 damage)
				miss_chance = 0
			else
				miss_chance = min((user.dna.species.punchdamagehigh/user.dna.species.punchdamagelow) + user.getStaminaLoss() + (user.getBruteLoss()*0.5), 100) //old base chance for a miss + various damage. capped at 100 to prevent weirdness in prob()

		if(!damage || !affecting || prob(miss_chance))//future-proofing for species that have 0 damage/weird cases where no zone is targeted
			playsound(target.loc, user.dna.species.miss_sound, 25, TRUE, -1)
			target.visible_message(span_danger("[user]'s [atk_verb] misses [target]!"), \
							span_danger("You avoid [user]'s [atk_verb]!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, user)
			to_chat(user, span_warning("Your [atk_verb] misses [target]!"))
			log_combat(user, target, "attempted to punch")
			return FALSE

		var/armor_block = target.run_armor_check(affecting, "melee")

		playsound(target.loc, user.dna.species.attack_sound, 25, TRUE, -1)

		target.visible_message(span_danger("[user] [atk_verb]ed [target]!"), \
						span_userdanger("You're [atk_verb]ed by [user]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("You [atk_verb] [target]!"))

		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		user.dna.species.spec_unarmedattacked(user, target)

		if(user.limb_destroyer)
			target.dismembering_strike(user, affecting.body_zone)

		var/attack_direction = get_dir(user, target)
		if(atk_verb == ATTACK_EFFECT_KICK) //kicks deal 1.5x raw damage
			target.apply_damage(damage*1.5, user.dna.species.attack_type, affecting, armor_block, attack_direction = attack_direction)
			log_combat(user, target, "kicked")
		else //other attacks deal full raw damage + 1.5x in stamina damage
			target.apply_damage(damage, user.dna.species.attack_type, affecting, armor_block, attack_direction = attack_direction)
			target.apply_damage(damage*1.5, STAMINA, affecting, armor_block)
			log_combat(user, target, "punched")

		if((target.stat != DEAD) && damage >= user.dna.species.punchstunthreshold)
			target.visible_message(
				span_danger("[user] knocks [target] down!"),
				span_userdanger("You're knocked down by [user]!"),
				span_hear("You hear aggressive shuffling followed by a loud thud!"),
				COMBAT_MESSAGE_RANGE,
				user,
			)
			to_chat(user, span_danger("You knock [target] down!"))
			//50 total damage = 40 base stun + 40 stun modifier = 80 stun duration, which is the old base duration
			var/knockdown_duration = 40 + (target.getStaminaLoss() + (target.getBruteLoss()*0.5))*0.8
			target.apply_effect(knockdown_duration, EFFECT_KNOCKDOWN, armor_block)
			log_combat(user, target, "got a stun punch with their previous punch")

/datum/species/proc/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return

/datum/species/proc/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(target.check_block())
		target.visible_message(
			span_warning("[user]'s shove is blocked by [target]!"),
			span_danger("You block [user]'s shove!"),
			span_hear("You hear a swoosh!"),
			COMBAT_MESSAGE_RANGE,
			user,
		)
		to_chat(user, span_warning("Your shove at [target] was blocked!"))
		return FALSE

	if(attacker_style && attacker_style.disarm_act(user,target))
		return TRUE
	if(user.resting || user.IsKnockdown())
		return FALSE
	if(user == target)
		return FALSE
	if(user.loc == target.loc)
		return FALSE
	else
		user.disarm(target)

/datum/species/proc/spec_hitby(atom/movable/AM, mob/living/carbon/human/H)
	return

/datum/species/proc/spec_attack_hand(mob/living/carbon/human/M, mob/living/carbon/human/H, datum/martial_art/attacker_style)
	if(!istype(M))
		return
	CHECK_DNA_AND_SPECIES(M)
	CHECK_DNA_AND_SPECIES(H)

	if(!istype(M)) //sanity check for drones.
		return
	if(M.mind)
		attacker_style = M.mind.martial_art
	if((M != H) && M.a_intent != INTENT_HELP && H.check_shields(M, 0, M.name, attack_type = UNARMED_ATTACK))
		log_combat(M, H, "attempted to touch")
		H.visible_message(span_warning("[M] attempts to touch [H]!"), \
						span_danger("[M] attempts to touch you!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
		to_chat(M, span_warning("You attempt to touch [H]!"))
		return 0

	SEND_SIGNAL(M, COMSIG_MOB_ATTACK_HAND, M, H, attacker_style)

	switch(M.a_intent)
		if("help")
			help(M, H, attacker_style)
		if("grab")
			grab(M, H, attacker_style)
		if("harm")
			harm(M, H, attacker_style)
		if("disarm")
			disarm(M, H, attacker_style)

/datum/species/proc/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, intent, mob/living/carbon/human/H)
	// Allows you to put in item-specific reactions based on species
	if(user != H)
		if(H.check_shields(I, I.force, "the [I.name]", MELEE_ATTACK, I.armour_penetration))
			return 0
	if(H.check_block())
		H.visible_message(span_warning("[H] blocks [I]!"), \
						span_userdanger("You block [I]!"))
		return 0

	var/hit_area
	if(!affecting) //Something went wrong. Maybe the limb is missing?
		affecting = H.bodyparts[1]

	hit_area = affecting.name
	var/def_zone = affecting.body_zone

	var/armor_block = H.run_armor_check(affecting, "melee", I.armour_penetration, FALSE, span_notice("Your armor has protected your [hit_area]!"), span_warning("Your armor has softened a hit to your [hit_area]!"))
	armor_block = min(90,armor_block) //cap damage reduction at 90%
	var/Iwound_bonus = I.wound_bonus

	// this way, you can't wound with a surgical tool on help intent if they have a surgery active and are laying down, so a misclick with a circular saw on the wrong limb doesn't bleed them dry (they still get hit tho)
	if((I.item_flags & SURGICAL_TOOL) && user.a_intent == INTENT_HELP && (H.mobility_flags & ~MOBILITY_STAND) && (LAZYLEN(H.surgeries) > 0))
		Iwound_bonus = CANT_WOUND

	H.send_item_attack_message(I, user, hit_area, affecting)
	var/attack_direction = get_dir(user, H)
	apply_damage(I.force , I.damtype, def_zone, armor_block, H, wound_bonus = Iwound_bonus, bare_wound_bonus = I.bare_wound_bonus, sharpness = I.get_sharpness(), attack_direction = attack_direction)

	if(!I.force)
		return 0 //item force is zero

	var/bloody = 0
	if(((I.damtype == BRUTE) && I.force && prob(25 + (I.force * 2))))
		if(IS_ORGANIC_LIMB(affecting))
			I.add_mob_blood(H)	//Make the weapon bloody, not the person.
			if(prob(I.force * 2))	//blood spatter!
				bloody = 1
				var/turf/location = H.loc
				if(istype(location))
					H.add_splatter_floor(location)
				if(get_dist(user, H) <= 1)	//people with TK won't get smeared with blood
					user.add_mob_blood(H)

		switch(hit_area)
			if(BODY_ZONE_HEAD)
				if(!I.get_sharpness() && armor_block < 50)
					if(prob(I.force))
						H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
						if(H.stat == CONSCIOUS)
							H.visible_message(span_danger("[H] is knocked senseless!"), \
											span_userdanger("You're knocked senseless!"))
							H.confused = max(H.confused, 20)
							H.adjust_blurriness(10)
						if(prob(10))
							H.gain_trauma(/datum/brain_trauma/mild/concussion)
					else
						H.adjustOrganLoss(ORGAN_SLOT_BRAIN, I.force * 0.2)

				if(bloody)	//Apply blood
					if(H.wear_mask)
						H.wear_mask.add_mob_blood(H)
						H.update_inv_wear_mask()
					if(H.head)
						H.head.add_mob_blood(H)
						H.update_inv_head()
					if(H.glasses && prob(33))
						H.glasses.add_mob_blood(H)
						H.update_inv_glasses()

			if(BODY_ZONE_CHEST)
				if(H.stat == CONSCIOUS && !I.get_sharpness() && armor_block < 50)
					if(prob(I.force))
						H.visible_message(span_danger("[H] is knocked down!"), \
									span_userdanger("You're knocked down!"))
						H.apply_effect(60, EFFECT_KNOCKDOWN, armor_block)

				if(bloody)
					if(H.wear_suit)
						H.wear_suit.add_mob_blood(H)
						H.update_inv_wear_suit()
					if(H.w_uniform)
						H.w_uniform.add_mob_blood(H)
						H.update_inv_w_uniform()

	return TRUE

/datum/species/proc/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE, attack_direction = null)
	SEND_SIGNAL(H, COMSIG_MOB_APPLY_DAMAGE, damage, damagetype, def_zone, wound_bonus, bare_wound_bonus, sharpness, attack_direction)
	var/hit_percent = (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-H.physiology.damage_resistance))/100
	if(!damage || (!forced && hit_percent <= 0))
		return 0

	var/obj/item/bodypart/BP = null
	if(!spread_damage)
		if(isbodypart(def_zone))
			BP = def_zone
		else
			if(!def_zone)
				def_zone = ran_zone(def_zone)
			BP = H.get_bodypart(check_zone(def_zone))
			if(!BP)
				BP = H.bodyparts[1]

	switch(damagetype)
		if(BRUTE)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * brutemod * H.physiology.brute_mod
			if(BP)
				if(BP.receive_damage(damage_amount, 0, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness, attack_direction = attack_direction))
					H.update_damage_overlays()
			else //no bodypart, we deal damage with a more general method.
				H.adjustBruteLoss(damage_amount)
			if(H.stat <= HARD_CRIT)
				H.shake_animation(damage_amount)
		if(BURN)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * burnmod * H.physiology.burn_mod
			if(BP)
				if(BP.receive_damage(0, damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness, attack_direction = attack_direction))
					H.update_damage_overlays()
			else
				H.adjustFireLoss(damage_amount)
			if(H.stat <= HARD_CRIT)
				H.shake_animation(damage_amount)
		if(TOX)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.tox_mod
			H.adjustToxLoss(damage_amount)
		if(OXY)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.oxy_mod
			H.adjustOxyLoss(damage_amount)
		if(CLONE)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.clone_mod
			H.adjustCloneLoss(damage_amount)
		if(STAMINA)
			var/damage_amount = forced ? damage : damage * hit_percent * staminamod * H.physiology.stamina_mod
			if(BP)
				if(BP.receive_damage(0, 0, damage_amount))
					H.update_stamina()
			else
				H.adjustStaminaLoss(damage_amount)
			if(H.stat <= HARD_CRIT)
				H.shake_animation(damage_amount)
		if(BRAIN)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.brain_mod
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage_amount)
	return 1

/datum/species/proc/on_hit(obj/projectile/P, mob/living/carbon/human/H)
	// called when hit by a projectile
	switch(P.type)
		if(/obj/projectile/energy/floramut) // overwritten by plants/pods
			H.show_message(span_notice("The radiation beam dissipates harmlessly through your body."))
		if(/obj/projectile/energy/florayield)
			H.show_message(span_notice("The radiation beam dissipates harmlessly through your body."))
		if(/obj/projectile/energy/florarevolution)
			H.show_message(span_notice("The radiation beam dissipates harmlessly through your body."))

/datum/species/proc/bullet_act(obj/projectile/P, mob/living/carbon/human/H)
	// called before a projectile hit
	return 0

/////////////
//BREATHING//
/////////////

/datum/species/proc/breathe(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOBREATH))
		return TRUE

//////////////////////////
// ENVIRONMENT HANDLERS //
//////////////////////////

/**
 * Enviroment handler for species
 *
 * vars:
 * * environment The environment gas mix
 * * H The mob we will stabilize
 */
/datum/species/proc/handle_environment(datum/gas_mixture/environment, mob/living/carbon/human/H)
	var/areatemp = H.get_temperature(environment)

	if(H.stat != DEAD) // If you are dead your body does not stabilize naturally
		bodytemp_natural_stabilization = natural_bodytemperature_stabilization(environment, H)

	if(!H.on_fire || areatemp > H.bodytemperature) // If we are not on fire or the area is hotter
		bodytemp_environment_change = H.adjust_bodytemperature((areatemp - H.bodytemperature), use_insulation=TRUE, use_steps=TRUE, hardsuit_fix=bodytemp_normal - H.bodytemperature)

	if(H.check_for_seal())
		return

	var/plasma = environment.get_moles(GAS_PLASMA)
	var/tritium = environment.get_moles(GAS_TRITIUM)
	var/chlorine = environment.get_moles(GAS_CHLORINE)
	var/ammonia = environment.get_moles(GAS_AMMONIA)
	var/hydrogen_chloride = environment.get_moles(GAS_HYDROGEN_CHLORIDE)
	var/sulfur_dioxide = environment.get_moles(GAS_SO2)
	if(chlorine <= MINIMUM_MOLS_TO_HARM && hydrogen_chloride <= MINIMUM_MOLS_TO_HARM && tritium <= MINIMUM_MOLS_TO_HARM && plasma <= MINIMUM_MOLS_TO_HARM && ammonia <= MINIMUM_MOLS_TO_HARM && sulfur_dioxide <= MINIMUM_MOLS_TO_HARM)
		return

	var/eyedamage = FALSE
	var/irritant = FALSE
	var/burndamage = 0
	var/mechanical = FALSE

	var/feels_pain = TRUE
	if(inherent_biotypes & MOB_ROBOTIC) //robots are not flesh
		mechanical = TRUE

	if(HAS_TRAIT(H, TRAIT_ANALGESIA)) //if we can't feel pain, dont give the pain messages
		feels_pain = FALSE

	if(plasma > MINIMUM_MOLS_TO_HARM)
		burndamage += max(sqrt(ammonia) - 1, 0)
		eyedamage = TRUE
		irritant = TRUE
	if(tritium)
		burndamage += max(sqrt(tritium) - 2, 0)
		if(tritium > MINIMUM_MOLS_TO_HARM)
			eyedamage = TRUE
			irritant = TRUE
	if(chlorine)
		burndamage += max(sqrt(chlorine) - 4, 0)
		irritant = TRUE
		if(chlorine > (MINIMUM_MOLS_TO_HARM * 10))
			eyedamage = TRUE
	if(ammonia)
		burndamage += max(sqrt(ammonia) - 2, 0)
		irritant = TRUE
		if(ammonia > (MINIMUM_MOLS_TO_HARM * 5))
			eyedamage = TRUE
	if(hydrogen_chloride)
		burndamage += max(sqrt(hydrogen_chloride) - 1, 0)
		eyedamage = TRUE
		irritant = TRUE
	if(sulfur_dioxide)
		burndamage += max(sqrt(sulfur_dioxide) - 4, 0)
		irritant = TRUE
		if(sulfur_dioxide > (MINIMUM_MOLS_TO_HARM * 5))
			eyedamage = TRUE

	if(!eyedamage && !burndamage && !irritant)
		return FALSE
	if(mechanical)
		burndamage /= 5
		if(round(burndamage) == 0)
			return FALSE
	H.apply_damage(burndamage, BURN, spread_damage = TRUE)
	if(prob(5) && burndamage)
		if(feels_pain)
			to_chat(H, span_userdanger("You're [mechanical ? "corroding" : "melting"]!"))
		playsound(H, 'sound/items/welder.ogg', 30, TRUE)
	if(!H.check_for_goggles() && eyedamage && !mechanical)
		if(prob(30))
			H.adjustOrganLoss(ORGAN_SLOT_EYES, 1)
		if(prob(15) && feels_pain)
			to_chat(H, span_danger("Your eyes burn!"))
			H.emote("cry")
		H.set_blurriness(rand(5,15))
	if(irritant && prob(5) && feels_pain)
		to_chat(H, span_danger("Your [mechanical ? "outer shell smolders" : "skin itches"]."))

/// Handle the body temperature status effects for the species
/// Traits for resitance to heat or cold are handled here.
/datum/species/proc/handle_body_temperature(mob/living/carbon/human/H)
	var/body_temp = H.bodytemperature

	//tempature is no longer comfy, throw alert
	if(body_temp > max_temp_comfortable && !HAS_TRAIT(H, TRAIT_RESISTHEAT))
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "cold")
		if(body_temp > bodytemp_heat_damage_limit)
			var/burn_damage = calculate_burn_damage(H)
			if(burn_damage > 2)
				H.throw_alert("tempfeel", /atom/movable/screen/alert/hot, 3)
			else
				H.throw_alert("tempfeel", /atom/movable/screen/alert/hot, 2)
		else
			if(body_temp < (bodytemp_heat_damage_limit - 3))
				H.throw_alert("tempfeel", /atom/movable/screen/alert/hot, 1)
			else
				H.throw_alert("tempfeel", /atom/movable/screen/alert/warm)
	else if (body_temp < min_temp_comfortable && !HAS_TRAIT(H, TRAIT_RESISTCOLD))
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "hot")
		if(body_temp < bodytemp_cold_damage_limit -7)
			H.throw_alert("tempfeel", /atom/movable/screen/alert/cold, 3)
		else if(body_temp < bodytemp_cold_damage_limit)
			H.throw_alert("tempfeel", /atom/movable/screen/alert/cold, 2)
		else if(body_temp < (bodytemp_cold_damage_limit + 5))
			H.throw_alert("tempfeel", /atom/movable/screen/alert/cold, 1)
		else
			H.throw_alert("tempfeel", /atom/movable/screen/alert/chilly)
	else
		H.clear_alert("tempfeel")

	// Body temperature is too hot, and we do not have resist traits
	if(body_temp > bodytemp_heat_damage_limit && !HAS_TRAIT(H, TRAIT_RESISTHEAT))
		// Clear cold mood and apply hot mood
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "hot", /datum/mood_event/hot)

		//Remove any slowdown from the cold.
		H.remove_movespeed_modifier(/datum/movespeed_modifier/cold)

		var/burn_damage = calculate_burn_damage(H)

		// sweats depending on burn damage, not actually a mechanic but a alternative to pinpoint when you are taking damage
		if(burn_damage)
			if(H.mob_biotypes & MOB_ROBOTIC) //robors have a alternative cooling fan graphic
				switch(burn_damage)
					if(0 to 1)
						H.throw_alert("temp", /atom/movable/screen/alert/fans, 1)
					if(2 to 3)
						H.throw_alert("temp", /atom/movable/screen/alert/fans, 2)
					else
						H.throw_alert("temp", /atom/movable/screen/alert/fans, 3)
			else
				switch(burn_damage)
					if(0 to 1)
						H.throw_alert("temp", /atom/movable/screen/alert/sweat, 1)
					if(2 to 3)
						H.throw_alert("temp", /atom/movable/screen/alert/sweat, 2)
					else
						H.throw_alert("temp", /atom/movable/screen/alert/sweat, 3)

		// Apply species and physiology modifiers to heat damage
		burn_damage = burn_damage * heatmod * H.physiology.heat_mod

		// 40% for level 3 damage on humans to scream in pain
		if (H.stat < UNCONSCIOUS && (prob(burn_damage) * 10) / 4)
			H.force_scream()

		// Apply the damage to all body parts
		H.apply_damage(burn_damage, BURN, spread_damage = TRUE)

	// Body temperature is too cold, and we do not have resist traits
	else if(body_temp < bodytemp_cold_damage_limit && !HAS_TRAIT(H, TRAIT_RESISTCOLD))
		// clear any hot moods and apply cold mood
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "hot")
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "cold", /datum/mood_event/cold)
		// Apply cold slow down
		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/cold, multiplicative_slowdown = ((bodytemp_cold_damage_limit - H.bodytemperature) / COLD_SLOWDOWN_FACTOR))
		// Display alerts based on the amount of cold damage being taken
		// Apply more damage based on how cold you are

		if(body_temp < bodytemp_cold_damage_limit - 15)
			H.throw_alert("temp", /atom/movable/screen/alert/shiver, 3)
			if(H.stat != DEAD) // probably can store them in cold storage like this
				H.apply_damage(COLD_DAMAGE_LEVEL_3 * coldmod * H.physiology.cold_mod, BURN)
				H.emote("shiver")

		else if(body_temp < bodytemp_cold_damage_limit - 7)
			H.throw_alert("temp", /atom/movable/screen/alert/shiver, 2)
			if(H.stat != DEAD) // when you think about it, being cold wouldnt do skin damaage if there nothing even alive?
				H.apply_damage(COLD_DAMAGE_LEVEL_2 * coldmod * H.physiology.cold_mod, BURN)
				if(prob(30))
					H.emote("shiver")

		else
			H.throw_alert("temp", /atom/movable/screen/alert/shiver, 1)
			if(H.stat != DEAD) // to prevent a bug where bodies at room tempertue actually take damage from their body being cold
				H.apply_damage(COLD_DAMAGE_LEVEL_1 * coldmod * H.physiology.cold_mod, BURN)
				if(prob(10))
					H.emote("shiver")

	// We are not to hot or cold, remove status and moods
	else
		H.clear_alert("temp")
		H.remove_movespeed_modifier(/datum/movespeed_modifier/cold)
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "cold")
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "hot")

/datum/species/proc/calculate_burn_damage(mob/living/carbon/human/current_human)
	var/burn_damage = 0
	var/firemodifier = current_human.fire_stacks / 50
	if (!current_human.on_fire) // We are not on fire, reduce the modifier
		firemodifier = min(firemodifier, 0)

	// this can go below 5 at log 2.5
	burn_damage = max(log(2 - firemodifier, (current_human.bodytemperature - current_human.get_body_temp_normal(apply_change=FALSE))) - 5,0)
	return burn_damage

/// Handle the air pressure of the environment
/datum/species/proc/handle_environment_pressure(datum/gas_mixture/environment, mob/living/carbon/human/H)
	var/pressure = environment.return_pressure()
	var/adjusted_pressure = H.calculate_affecting_pressure(pressure)

	// Set alerts and apply damage based on the amount of pressure
	switch(adjusted_pressure)

		// Very high pressure, show an alert and take damage
		if(HAZARD_HIGH_PRESSURE to INFINITY)
			if(!HAS_TRAIT(H, TRAIT_RESISTHIGHPRESSURE))
				H.adjustBruteLoss(min(((adjusted_pressure / HAZARD_HIGH_PRESSURE) -1) * \
					PRESSURE_DAMAGE_COEFFICIENT, MAX_HIGH_PRESSURE_DAMAGE) * H.physiology.pressure_mod)
				H.throw_alert("pressure", /atom/movable/screen/alert/highpressure, 2)
			else
				H.clear_alert("pressure")

		// High pressure, show an alert
		if(WARNING_HIGH_PRESSURE to HAZARD_HIGH_PRESSURE)
			H.throw_alert("pressure", /atom/movable/screen/alert/highpressure, 1)

		// No pressure issues here clear pressure alerts
		if(WARNING_LOW_PRESSURE to WARNING_HIGH_PRESSURE)
			H.clear_alert("pressure")

		// Low pressure here, show an alert
		if(HAZARD_LOW_PRESSURE to WARNING_LOW_PRESSURE)
			// We have low pressure resit trait, clear alerts
			if(HAS_TRAIT(H, TRAIT_RESISTLOWPRESSURE))
				H.clear_alert("pressure")
			else
				H.throw_alert("pressure", /atom/movable/screen/alert/lowpressure, 1)

		// Very low pressure, show an alert and take damage
		else
			// We have low pressure resit trait, clear alerts
			if(HAS_TRAIT(H, TRAIT_RESISTLOWPRESSURE))
				H.clear_alert("pressure")
			else
				H.adjustBruteLoss(LOW_PRESSURE_DAMAGE * H.physiology.pressure_mod)
				H.throw_alert("pressure", /atom/movable/screen/alert/lowpressure, 2)

/**
 * Used to stabilize the body temperature back to normal on living mobs
 *
 * vars:
 * * environment The environment gas mix
 * * H The mob we will stabilize
 */
/datum/species/proc/natural_bodytemperature_stabilization(datum/gas_mixture/environment, mob/living/carbon/human/H)
	var/areatemp = H.get_temperature(environment)
	var/body_temp = H.bodytemperature // Get current body temperature
	var/body_temperature_difference = H.get_body_temp_normal() - body_temp
	var/natural_change = 0
	var/recovery_temp = bodytemp_autorecovery_min
	//if in crit, we struggle to regulate temperture. this will make extreme tempertures more dangerous to injured
	if (H.stat > SOFT_CRIT)
		recovery_temp =  recovery_temp / 2

	// we are cold, reduce the minimum increment and do not jump over the difference
	if(body_temp > bodytemp_cold_damage_limit && body_temp < H.get_body_temp_normal())
		natural_change = max(body_temperature_difference * H.metabolism_efficiency / bodytemp_autorecovery_divisor, \
			min(body_temperature_difference, recovery_temp / 4))

	// We are hot, reduce the minimum increment and do not jump below the difference
	else if(body_temp > H.get_body_temp_normal() && body_temp <= bodytemp_heat_damage_limit)
		natural_change = min(body_temperature_difference * H.metabolism_efficiency / bodytemp_autorecovery_divisor, \
			max(body_temperature_difference, -(recovery_temp / 4)))


	var/thermal_protection = H.get_insulation_protection(body_temp + natural_change)
	if(areatemp > body_temp) // It is hot here
		if(body_temp < H.get_body_temp_normal())
			// Our bodytemp is below normal we are cold, insulation helps us retain body heat
			// and will reduce the heat we lose to the environment
			natural_change = (thermal_protection + 1) * natural_change
		else
			// Our bodytemp is above normal and sweating, insulation hinders out ability to reduce heat
			// but will reduce the amount of heat we get from the environment
			natural_change = (1 / (thermal_protection + 1)) * natural_change
	else // It is cold here
		if(!H.on_fire) // If on fire ignore ignore local temperature in cold areas
			if(body_temp < H.get_body_temp_normal())
				// Our bodytemp is below normal, insulation helps us retain body heat
				// and will reduce the heat we lose to the environment
				natural_change = (thermal_protection + 1) * natural_change
			else
				// Our bodytemp is above normal and sweating, insulation hinders out ability to reduce heat
				// but will reduce the amount of heat we get from the environment
				natural_change = (1 / (thermal_protection + 1)) * natural_change

	// Apply the natural stabilization changes
	H.adjust_bodytemperature(natural_change)
	return natural_change

//////////
// FIRE //
//////////

/datum/species/proc/handle_fire(mob/living/carbon/human/H, no_protection = FALSE)
	if(!CanIgniteMob(H))
		return TRUE
	if(H.on_fire)
		//the fire tries to damage the exposed clothes and items
		var/list/burning_items = list()
		var/list/obscured = H.check_obscured_slots(TRUE)
		//HEAD//

		if(H.glasses && !(ITEM_SLOT_EYES in obscured))
			burning_items += H.glasses
		if(H.wear_mask && !(ITEM_SLOT_MASK in obscured))
			burning_items += H.wear_mask
		if(H.wear_neck && !(ITEM_SLOT_NECK in obscured))
			burning_items += H.wear_neck
		if(H.ears && !(ITEM_SLOT_EARS in obscured))
			burning_items += H.ears
		if(H.head)
			burning_items += H.head

		//CHEST//
		if(H.w_uniform && !(ITEM_SLOT_ICLOTHING in obscured))
			burning_items += H.w_uniform
		if(H.wear_suit)
			burning_items += H.wear_suit

		//ARMS & HANDS//
		var/obj/item/clothing/arm_clothes = null
		if(H.gloves && !(ITEM_SLOT_GLOVES in obscured))
			arm_clothes = H.gloves
		else if(H.wear_suit && ((H.wear_suit.body_parts_covered & HANDS) || (H.wear_suit.body_parts_covered & ARMS)))
			arm_clothes = H.wear_suit
		else if(H.w_uniform && ((H.w_uniform.body_parts_covered & HANDS) || (H.w_uniform.body_parts_covered & ARMS)))
			arm_clothes = H.w_uniform
		if(arm_clothes)
			burning_items |= arm_clothes

		//LEGS & FEET//
		var/obj/item/clothing/leg_clothes = null
		if(H.shoes && !(ITEM_SLOT_FEET in obscured))
			leg_clothes = H.shoes
		else if(H.wear_suit && ((H.wear_suit.body_parts_covered & FEET) || (H.wear_suit.body_parts_covered & LEGS)))
			leg_clothes = H.wear_suit
		else if(H.w_uniform && ((H.w_uniform.body_parts_covered & FEET) || (H.w_uniform.body_parts_covered & LEGS)))
			leg_clothes = H.w_uniform
		if(leg_clothes)
			burning_items |= leg_clothes

		for(var/X in burning_items)
			var/obj/item/I = X
			I.fire_act((H.fire_stacks * 50)) //damage taken is reduced to 2% of this value by fire_act()

		var/thermal_protection = H.get_thermal_protection()

		if(thermal_protection >= FIRE_IMMUNITY_MAX_TEMP_PROTECT && !no_protection)
			return
		if(thermal_protection >= FIRE_SUIT_MAX_TEMP_PROTECT && !no_protection)
			H.adjust_bodytemperature(3)
		else
			H.adjust_bodytemperature(bodytemp_heating_rate_max + (H.fire_stacks * 5))
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)

/datum/species/proc/CanIgniteMob(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOFIRE))
		return FALSE
	return TRUE

/datum/species/proc/ExtinguishMob(mob/living/carbon/human/H)
	return

/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return


////////////
//  Stun  //
////////////

/datum/species/proc/spec_stun(mob/living/carbon/human/H,amount)
	if(flying_species && H.movement_type & FLYING)
		ToggleFlight(H)
		flyslip(H)
	. = stunmod * H.physiology.stun_mod * amount

//////////////
//Space Move//
//////////////

/datum/species/proc/space_move(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		return TRUE
	return FALSE

/datum/species/proc/negates_gravity(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		return TRUE
	return FALSE

////////////////
//Tail Wagging//
////////////////

/datum/species/proc/can_wag_tail(mob/living/carbon/human/H)
	return (locate(/obj/item/organ/tail) in H.internal_organs)

/datum/species/proc/is_wagging_tail(mob/living/carbon/human/H)
	return ("waggingtail_human" in mutant_bodyparts) || ("waggingtail_lizard" in mutant_bodyparts) || ("waggingtail_elzu" in mutant_bodyparts)

/datum/species/proc/start_wagging_tail(mob/living/carbon/human/H)
	if("tail_human" in mutant_bodyparts)
		mutant_bodyparts -= "tail_human"
		mutant_bodyparts |= "waggingtail_human"

	else if("tail_lizard" in mutant_bodyparts)
		mutant_bodyparts -= "tail_lizard"
		mutant_bodyparts -= "spines"
		mutant_bodyparts |= "waggingtail_lizard"
		mutant_bodyparts |= "waggingspines"

	else if("tail_elzu" in mutant_bodyparts)
		mutant_bodyparts -= "tail_elzu"
		mutant_bodyparts |= "waggingtail_elzu"

	H.update_body()

/datum/species/proc/stop_wagging_tail(mob/living/carbon/human/H)
	if("waggingtail_human" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_human"
		mutant_bodyparts |= "tail_human"

	else if("waggingtail_lizard" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_lizard"
		mutant_bodyparts -= "waggingspines"
		mutant_bodyparts |= "tail_lizard"
		mutant_bodyparts |= "spines"

	else if("waggingtail_elzu" in mutant_bodyparts)
		mutant_bodyparts -= "waggingtail_elzu"
		mutant_bodyparts |= "tail_elzu"

	H.update_body()

///////////////
//FLIGHT SHIT//
///////////////

/datum/species/proc/GiveSpeciesFlight(mob/living/carbon/human/H)
	if(flying_species) //species that already have flying traits should not work with this proc
		return
	flying_species = TRUE
	if(wings_icons.len > 1)
		if(!H.client)
			wings_icon = pick(wings_icons)
		else
			var/list/wings = list()
			for(var/W in wings_icons)
				var/datum/sprite_accessory/S = GLOB.wings_list[W]	//Gets the datum for every wing this species has, then prompts user with a radial menu
				var/image/img = image(icon = 'icons/mob/clothing/wings.dmi', icon_state = "m_wingsopen_[S.icon_state]_BEHIND")	//Process the HUD elements
				img.transform *= 0.5
				img.pixel_x = -32
				if(wings[S.name])
					stack_trace("Different wing types with repeated names. Please fix as this may cause issues.")
				else
					wings[S.name] = img
			wings_icon = show_radial_menu(H, H, wings, tooltips = TRUE)
			if(!wings_icon)
				wings_icon = pick(wings_icons)
	else
		wings_icon = wings_icons[1]
	if(isnull(fly))
		fly = new
		fly.Grant(H)
	if(H.dna.features["wings"] != wings_icon)
		mutant_bodyparts |= "wings"
		H.dna.features["wings"] = wings_icon
		H.update_body()

/datum/species/proc/HandleFlight(mob/living/carbon/human/H)
	if(H.movement_type & FLYING)
		if(!CanFly(H))
			ToggleFlight(H)
			return FALSE
		return TRUE
	else
		return FALSE

/datum/species/proc/CanFly(mob/living/carbon/human/H)
	if(H.stat || H.body_position == LYING_DOWN)
		return FALSE
	if(H.wear_suit && ((H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception))))	//Jumpsuits have tail holes, so it makes sense they have wing holes too
		to_chat(H, span_warning("Your suit blocks your wings from extending!"))
		return FALSE
	var/turf/T = get_turf(H)
	if(!T)
		return FALSE

	var/datum/gas_mixture/environment = T.return_air()
	if(environment && !(environment.return_pressure() > 30))
		to_chat(H, span_warning("The atmosphere is too thin for you to fly!"))
		return FALSE
	else
		return TRUE

/datum/species/proc/flyslip(mob/living/carbon/human/H)
	var/obj/buckled_obj
	if(H.buckled)
		buckled_obj = H.buckled

	to_chat(H, span_notice("Your wings spazz out and launch you!"))

	playsound(H.loc, 'sound/misc/slip.ogg', 50, TRUE, -3)

	for(var/obj/item/I in H.held_items)
		H.accident(I)

	var/olddir = H.dir

	H.stop_pulling()
	if(buckled_obj)
		buckled_obj.unbuckle_mob(H)
		step(buckled_obj, olddir)
	else
		new /datum/forced_movement(H, get_ranged_target_turf(H, olddir, 4), 1, FALSE, CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon, spin), 1, 1))
	return TRUE

//UNSAFE PROC, should only be called through the Activate or other sources that check for CanFly
/datum/species/proc/ToggleFlight(mob/living/carbon/human/H)
	if(!HAS_TRAIT_FROM(H, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT))
		stunmod *= 2
		speedmod -= 0.35
		ADD_TRAIT(H, TRAIT_NO_FLOATING_ANIM, SPECIES_FLIGHT_TRAIT)
		ADD_TRAIT(H, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT)
		passtable_on(H, SPECIES_TRAIT)
		H.OpenWings()
	else
		stunmod *= 0.5
		speedmod += 0.35
		REMOVE_TRAIT(H, TRAIT_NO_FLOATING_ANIM, SPECIES_FLIGHT_TRAIT)
		REMOVE_TRAIT(H, TRAIT_MOVE_FLYING, SPECIES_FLIGHT_TRAIT)
		passtable_off(H, SPECIES_TRAIT)
		H.CloseWings()

/datum/action/innate/flight
	name = "Toggle Flight"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "flight"

/datum/action/innate/flight/Activate()
	var/mob/living/carbon/human/H = owner
	var/datum/species/S = H.dna.species
	if(S.CanFly(H))
		S.ToggleFlight(H)
		if(!(H.movement_type & FLYING))
			to_chat(H, span_notice("You settle gently back onto the ground..."))
		else
			to_chat(H, span_notice("You beat your wings and begin to hover gently above the ground..."))
			H.set_resting(FALSE, TRUE)

///Calls the DMI data for a custom icon for a given bodypart from the Species Datum.
/datum/species/proc/get_custom_icons(part)
	return
/*Here's what a species that has a unique icon for every slot would look like. If your species doesnt have any custom icons for a given part, return null.
/datum/species/kepori/get_custom_icons(part)
	switch(part)
		if("uniform")
			return 'icons/mob/species/kepori/kepori_uniforms.dmi'
		if("gloves")
			return 'icons/mob/species/kepori/kepori_gloves.dmi'
		if("glasses")
			return 'icons/mob/species/kepori/kepori_glasses.dmi'
		if("ears")
			return 'icons/mob/species/kepori/kepori_ears.dmi'
		if("shoes")
			return 'icons/mob/species/kepori/kepori_shoes.dmi'
		if("head")
			return 'icons/mob/species/kepori/kepori_head.dmi'
		if("belt")
			return 'icons/mob/species/kepori/kepori_belts.dmi'
		if("suit")
			return 'icons/mob/species/kepori/kepori_suits.dmi'
		if("mask")
			return 'icons/mob/species/kepori/kepori_masks.dmi'
		if("back")
			return 'icons/mob/species/kepori/kepori_back.dmi'
		if("generic")
			return 'icons/mob/species/kepori/kepori_generic.dmi'
		else
			return
*/

/datum/species/proc/get_item_offsets_for_index(i)
	return

/datum/species/proc/get_item_offsets_for_dir(dir, hand_index)
	return

/datum/species/proc/get_harm_descriptors()
	return

/**
 * The human species version of [/mob/living/carbon/proc/get_biological_state]. Depends on the HAS_FLESH and HAS_BONE species traits, having bones lets you have bone wounds, having flesh lets you have burn, slash, and piercing wounds
 */
/datum/species/proc/get_biological_state(mob/living/carbon/human/H)
	. = BIO_INORGANIC
	if(HAS_FLESH in species_traits)
		. |= BIO_JUST_FLESH
	if(HAS_BONE in species_traits)
		. |= BIO_JUST_BONE

#undef MINIMUM_MOLS_TO_HARM
