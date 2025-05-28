/// A component for ai-controlled atoms which makes them speak if they target a living atom
/datum/component/aggro_speech
	/// Blackboard key in which target data is stored
	var/target_key
	/// If we want to limit emotes to only play at mobs
	var/living_only
	/// List of phrases to say. These should be self contained (e.g. "FOR A FREE FRONTIER", "TERMINATE INTRUDERS", "I NEED SALT CAPTAIN")
	var/list/phrase_list
	/// Chance to play an emote
	var/phrase_chance
	/// Chance to subtract every time we play an emote (permanently)
	var/subtract_chance
	/// Minimum chance to play an emote
	var/minimum_chance

/datum/component/aggro_speech/Initialize(
		target_key = BB_BASIC_MOB_CURRENT_TARGET,
		living_only = FALSE,
		list/phrase_list,
		phrase_chance = 30,
		minimum_chance = 2,
		subtract_chance = 7,
)
	. = ..()
	if (!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	var/atom/atom_parent = parent
	if (!atom_parent.ai_controller)
		return COMPONENT_INCOMPATIBLE
	src.target_key = target_key
	src.phrase_list = phrase_list
	src.phrase_chance = phrase_chance
	src.minimum_chance = minimum_chance
	src.subtract_chance = subtract_chance

/datum/component/aggro_speech/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key), PROC_REF(on_target_changed))

/datum/component/aggro_speech/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key))
	return ..()
/// When we get a new target, see if we want to bark at it


/datum/component/aggro_speech/proc/on_target_changed(atom/movable/source)
	SIGNAL_HANDLER
	var/atom/new_target = source.ai_controller.blackboard[target_key]
	if (isnull(new_target) || !prob(phrase_chance))
		return
	if (living_only && !isliving(new_target))
		return // If we don't want to bark at food items or chairs or windows
	phrase_chance = max(phrase_chance - subtract_chance, minimum_chance)
	source.say("[pick(phrase_list)]")
