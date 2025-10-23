#define SIGNAL_ADDTRAIT(trait_ref) "addtrait [trait_ref]"
#define SIGNAL_REMOVETRAIT(trait_ref) "removetrait [trait_ref]"

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
			SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
				SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources \
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			}; \
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAIT_NOT_FROM(target, trait, sources) \
	do { \
		var/list/_traits_list = target.status_traits; \
		var/list/_sources_list; \
		if (sources && !islist(sources)) { \
			_sources_list = list(sources); \
		} else { \
			_sources_list = sources\
		}; \
		if (_traits_list && _traits_list[trait]) { \
			for (var/_trait_source in _traits_list[trait]) { \
				if (!(_trait_source in _sources_list)) { \
					_traits_list[trait] -= _trait_source \
				} \
			};\
			if (!length(_traits_list[trait])) { \
				_traits_list -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_traits_list)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S; \
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] -= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				};\
			if (!length(_L)) { \
				target.status_traits = null\
			};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)
#define HAS_TRAIT_FROM_ONLY(target, trait, source) ( \
	target.status_traits ? \
		(target.status_traits[trait] ? \
			((source in target.status_traits[trait]) && (length(target.status_traits) == 1)) \
			: FALSE) \
		: FALSE)
#define HAS_TRAIT_NOT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (length(target.status_traits[trait] - source) > 0) : FALSE) : FALSE)

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
/// Forces the user to stay unconscious.
#define TRAIT_KNOCKEDOUT "knockedout"
/// Prevents voluntary movement.
#define TRAIT_IMMOBILIZED "immobilized"
/// Prevents voluntary standing or staying up on its own.
#define TRAIT_FLOORED "floored"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage).
#define TRAIT_HANDS_BLOCKED "handsblocked"
/// Inability to access UI hud elements. Turned into a trait from [MOBILITY_UI] to be able to track sources.
#define TRAIT_UI_BLOCKED "uiblocked"
/// Inability to pull things. Turned into a trait from [MOBILITY_PULL] to be able to track sources.
#define TRAIT_PULL_BLOCKED "pullblocked"
/// Abstract condition that prevents movement if being pulled and might be resisted against. Handcuffs and straight jackets, basically.
#define TRAIT_RESTRAINED "restrained"
#define TRAIT_INCAPACITATED "incapacitated"
///In some kind of critical condition. Is able to succumb.
#define TRAIT_CRITICAL_CONDITION "critical-condition"
/// Doesn't miss attacks
#define TRAIT_PERFECT_ATTACKER "perfect_attacker"
#define TRAIT_BLIND "blind"
#define TRAIT_DEAF "deaf"
#define TRAIT_MUTE "mute"
#define TRAIT_EMOTEMUTE "emotemute"
#define TRAIT_NEARSIGHT "nearsighted"
#define TRAIT_HUSK "husk"
#define TRAIT_BADDNA "baddna"
#define TRAIT_CLUMSY "clumsy"
#define TRAIT_CHUNKYFINGERS "chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB "dumb"
#define TRAIT_MONKEYLIKE "monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM "pacifism"
#define TRAIT_IGNORESLOWDOWN "ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
/// Makes it so the mob can use guns regardless of tool user status
#define TRAIT_GUN_NATURAL "gunnatural"
#define TRAIT_DEATHCOMA "deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH "fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_DISFIGURED "disfigured"
#define TRAIT_XENO_HOST "xeno_host"	//Tracks whether we're gonna be a baby alien's mummy.
#define TRAIT_STUNIMMUNE "stun_immunity"
#define TRAIT_STUNRESISTANCE "stun_resistance"
#define TRAIT_IWASBATONED "iwasbatoned" //Anti Dual-baton cooldown bypass exploit.
#define TRAIT_SLEEPIMMUNE "sleep_immunity"
#define TRAIT_PUSHIMMUNE "push_immunity"
#define TRAIT_SHOCKIMMUNE "shock_immunity"
#define TRAIT_TESLA_SHOCKIMMUNE "tesla_shock_immunity"
#define TRAIT_STABLEHEART "stable_heart"
#define TRAIT_STABLELIVER "stable_liver"
#define TRAIT_RESISTHEAT "resist_heat"
#define TRAIT_RESISTHEATHANDS "resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD "resist_cold"
#define TRAIT_RESISTHIGHPRESSURE "resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE "resist_low_pressure"
#define TRAIT_BOMBIMMUNE "bomb_immunity"
#define TRAIT_RADIMMUNE "rad_immunity"
#define TRAIT_GENELESS "geneless"
#define TRAIT_VIRUSIMMUNE "virus_immunity"
#define TRAIT_PIERCEIMMUNE "pierce_immunity"
#define TRAIT_NODISMEMBER "dismember_immunity"
#define TRAIT_LAVA_IMMUNE "lava_immunity"
#define TRAIT_SNOWSTORM_IMMUNE "snow_immunity"
#define TRAIT_ASHSTORM_IMMUNE "ash_immunity"
#define TRAIT_SANDSTORM_IMMUNE "sand_immunity"
#define TRAIT_NOFIRE "nonflammable"
/// Prevents plasmamen from self-igniting if only their helmet is missing
#define TRAIT_NOSELFIGNITION_HEAD_ONLY "no_selfignition_head_only"
#define TRAIT_NOGUNS "no_guns"
#define TRAIT_NOHUNGER "no_hunger"
#define TRAIT_NOMETABOLISM "no_metabolism"
#define TRAIT_NOCLONELOSS "no_cloneloss"
#define TRAIT_TOXIMMUNE "toxin_immune"
#define TRAIT_EASYDISMEMBER "easy_dismember"
#define TRAIT_LIMBATTACHMENT "limb_attach"
#define TRAIT_NOLIMBDISABLE "no_limb_disable"
#define TRAIT_EASYLIMBDISABLE "easy_limb_disable"
#define TRAIT_TOXINLOVER "toxinlover"
#define TRAIT_NOBREATH "no_breath"
#define TRAIT_ANTIMAGIC "anti_magic"
#define TRAIT_HOLY "holy"
#define TRAIT_JOLLY "jolly"
#define TRAIT_NOCRITDAMAGE "no_crit"
#define TRAIT_NOSLIPWATER "noslip_water"
#define TRAIT_NOSLIPALL "noslip_all"
#define TRAIT_NODEATH "nodeath"
#define TRAIT_NOHARDCRIT "nohardcrit"
#define TRAIT_NOSOFTCRIT "nosoftcrit"
#define TRAIT_MINDSHIELD "mindshield"
#define TRAIT_DISSECTED "dissected"
#define TRAIT_SIXTHSENSE "sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS "fearless"
#define TRAIT_PARALYSIS_L_ARM "para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM "para-r-arm"
#define TRAIT_PARALYSIS_L_LEG "para-l-leg"
#define TRAIT_PARALYSIS_R_LEG "para-r-leg"
#define TRAIT_EASILY_WOUNDED "easy_limb_wound"
#define TRAIT_HARDLY_WOUNDED "hard_limb_wound"
#define TRAIT_VERY_HARDLY_WOUNDED "extreme_limb_wound"
#define TRAIT_NEVER_WOUNDED "never_wounded"
#define TRAIT_CANNOT_OPEN_PRESENTS "cannot-open-presents"
#define TRAIT_PRESENT_VISION "present-vision"
#define TRAIT_DISK_VERIFIER "disk-verifier"
#define TRAIT_NOMOBSWAP "no-mob-swap"
#define TRAIT_XRAY_VISION "xray_vision"
#define TRAIT_THERMAL_VISION "thermal_vision"
/// Like antimagic, but doesn't block the user from casting
#define TRAIT_ANTIMAGIC_NO_SELFBLOCK "anti_magic_no_selfblock"
/// We have some form of forced gravity acting on us
#define TRAIT_FORCED_GRAVITY "forced_gravity"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON "surgeon"
#define TRAIT_STRONG_GRABBER "strong_grabber"
#define TRAIT_MAGIC_CHOKE "magic_choke"
#define TRAIT_SOOTHED_THROAT "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_ALWAYS_CLEAN "always-clean"
#define TRAIT_BOOZE_SLIDER "booze-slider"
#define TRAIT_QUICK_CARRY "quick-carry"
#define TRAIT_QUICKER_CARRY "quicker-carry"
#define TRAIT_QUICK_BUILD "quick-build"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_OIL_FRIED "oil_fried"
#define TRAIT_MEDICAL_HUD "med_hud"
#define TRAIT_SECURITY_HUD "sec_hud"
#define TRAIT_DIAGNOSTIC_HUD "diag_hud" //for something granting you a diagnostic hud
#define TRAIT_MEDIBOTCOMINGTHROUGH "medbot" //Is a medbot healing you
#define TRAIT_PASSTABLE "passtable"
#define TRAIT_NOFLASH "noflash" //Makes you immune to flashes
#define TRAIT_XENO_IMMUNE "xeno_immune"//prevents xeno huggies implanting skeletons
#define TRAIT_NAIVE "naive"
#define TRAIT_PRIMITIVE "primitive"
#define TRAIT_GUNSLINGER "gunslinger"
#define TRAIT_SPECIAL_TRAUMA_BOOST "special_trauma_boost" ///Increases chance of getting special traumas, makes them harder to cure
#define TRAIT_BLOODCRAWL_EAT "bloodcrawl_eat"
#define TRAIT_SPACEWALK "spacewalk"
#define TRAIT_GAMERGOD "gamer-god" //double arcade prizes
#define TRAIT_GIANT "giant"
#define TRAIT_DWARF "dwarf"
#define TRAIT_FASTMED "fast_med_use"
#define TRAIT_SILENT_FOOTSTEPS "silent_footsteps" //makes your footsteps completely silent
#define TRAIT_PAIN_RESIST "pain_resistance" //you resist pain
#define TRAIT_NICE_SHOT "nice_shot" //hnnnnnnnggggg..... you're pretty good....
/// The holder of this trait has antennae or whatever that hurt a ton when noogied
#define TRAIT_ANTENNAE "antennae"
/// The holder of this trait can be picked up and held by another mob that does NOT have this trait.
#define TRAIT_HOLDABLE "holdable"
/// This person is blushing
#define TRAIT_BLUSHING "blushing"
/// The person has their eyes closed. Visual only
#define TRAIT_EYESCLOSED "eyesclosed"
/// The person is snoring. Visual only
#define TRAIT_SNORE "snoring"
/// the holder of this trait will be scooped instead of fireman carried
#define TRAIT_SCOOPABLE "scoopable"
//your smooches actually deal damage to their target
#define TRAIT_KISS_OF_DEATH "kiss_of_death"
/// We can handle 'dangerous' plants in botany safely
#define TRAIT_PLANT_SAFE "plant_safe"
///This person is aiming and should not face atoms in different directions
#define TRAIT_AIMING "aiming"
/// This mob overrides certian SSlag_switch measures with this special trait
#define TRAIT_BYPASS_MEASURES "bypass_lagswitch_measures"
/// This mob is able to use sign language over the radio.
#define TRAIT_CAN_SIGN_ON_COMMS "can_sign_on_comms"
//non-mob traits
/// Used for limb-based paralysis, where replacing the limb will fix it.
#define TRAIT_PARALYSIS "paralysis"
/// Used for limbs.
#define TRAIT_DISABLED_BY_WOUND "disabled-by-wound"
/// Is this atom being actively shocked? Used to prevent repeated shocks.
#define TRAIT_BEING_SHOCKED "shocked"
/// Granted by prismwine, reflects lasers
#define TRAIT_REFLECTIVE "reflective"
#define TRAIT_HEARING_SENSITIVE "hearing_sensitive"
/// You can't see color!
#define TRAIT_COLORBLIND "colorblind"

/* Traits for ventcrawling.
 * Both give access to ventcrawling, but *_NUDE requires the user to be
 * wearing no clothes and holding no items. If both present, *_ALWAYS
 * takes precedence.
 */
#define TRAIT_VENTCRAWLER_ALWAYS "ventcrawler_always"
#define TRAIT_VENTCRAWLER_NUDE "ventcrawler_nude"

/*
 * Used for movables that need to be updated, via COMSIG_ENTER_AREA and COMSIG_EXIT_AREA, when transitioning areas.
 * Use [/atom/movable/proc/become_area_sensitive(trait_source)] to properly enable it. How you remove it isn't as important.
 */
#define TRAIT_AREA_SENSITIVE "area-sensitive"

///Used for managing KEEP_TOGETHER in [/atom/var/appearance_flags]
///every object that is currently the active storage of some client mob has this trait
#define TRAIT_ACTIVE_STORAGE "active_storage"

#define TRAIT_KEEP_TOGETHER "keep-together"

// item traits
#define TRAIT_NODROP "nodrop"
#define TRAIT_NO_STORAGE_INSERT "no_storage_insert" //cannot be inserted in a storage.
#define TRAIT_T_RAY_VISIBLE "t-ray-visible" // Visible on t-ray scanners if the atom/var/level == 1
#define TRAIT_NO_TELEPORT "no-teleport" //you just can't
/// A transforming item that is actively extended / transformed
#define TRAIT_TRANSFORM_ACTIVE "active_transform"
#define TRAIT_WIELDED "wielded" //The item is currently being wielded
#define TRAIT_FORCE_SUIT_STORAGE "force_suit_storage" // the item can be worn in suit storage even if it's not in the allowed objects, or without an outerclothing.
#define TRAIT_FORCE_SUIT_STORAGE_ALWAYS "force_suit_storage_naked" // the item can be worn in suit storage even while naked.

/// Equipping or unequipping an item
#define TRAIT_EQUIPPING_OR_UNEQUIPPING "equipping_or_unequipping"

//quirk traits
#define TRAIT_ALCOHOL_TOLERANCE "alcohol_tolerance"
#define TRAIT_AGEUSIA "ageusia"
#define TRAIT_HEAVY_SLEEPER "heavy_sleeper"
#define TRAIT_LIGHT_STEP "light_step"
#define TRAIT_FAN_RILENA "fan_rilena"
#define TRAIT_VORACIOUS "voracious"
#define TRAIT_SELF_AWARE "self_aware"
#define TRAIT_FREERUNNING "freerunning"
#define TRAIT_POOR_AIM "poor_aim"
#define TRAIT_PROSOPAGNOSIA "prosopagnosia"
#define TRAIT_PHOTOGRAPHER "photographer"
#define TRAIT_MUSICIAN "musician"
#define TRAIT_LIGHT_DRINKER "light_drinker"
#define TRAIT_EMPATH "empath"
#define TRAIT_FRIENDLY "friendly"
#define TRAIT_GRABWEAKNESS "grab_weakness"
#define TRAIT_BALD "bald"
#define TRAIT_BADTOUCH "bad_touch"
#define TRAIT_ANXIOUS "anxious"
#define TRAIT_ANALGESIA "congenital_analgesia"
#define TRAIT_CLOUDED "clouded_eyes"
#define TRAIT_PINPOINT_EYES "pinpoint_eyes"
#define TRAIT_CHEMICAL_NIGHTVISION "chemical_nightvision"
#define TRAIT_GOOD_CHEMICAL_NIGHTVISION "good_chemical_nightvision"

///Trait for dryable items
#define TRAIT_DRYABLE "trait_dryable"
///Trait for dried items
#define TRAIT_DRIED "trait_dried"
/// Trait for customizable reagent holder
//#define TRAIT_CUSTOMIZABLE_REAGENT_HOLDER "customizable_reagent_holder"
/// Trait for allowing an item that isn't food into the customizable reagent holder
//#define TRAIT_ODD_CUSTOMIZABLE_FOOD_INGREDIENT "odd_customizable_food_ingredient"

/// Trait granted by lipstick
#define LIPSTICK_TRAIT "lipstick_trait"

// Bone breaking traits. Don't actually do anything(?)
#define TRAIT_NOBREAK "no_break"
#define TRAIT_ALLBREAK "all_break"

// common trait sources
#define TRAIT_GENERIC "generic"
#define GENERIC_ITEM_TRAIT "generic_item"
#define UNCONSCIOUS_TRAIT "unconscious"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define HELMET_TRAIT "helmet"
#define MASK_TRAIT "mask" //inherited from the mask
#define SHOES_TRAIT "shoes" //inherited from your sweet kicks
#define GLASSES_TRAIT "glasses"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"
#define CRIT_HEALTH_TRAIT "crit_health"
#define OXYLOSS_TRAIT "oxyloss"
#define TURF_TRAIT "turf"
#define BUCKLED_TRAIT "buckled" //trait associated to being buckled
#define CHOKEHOLD_TRAIT "chokehold" //trait associated to being held in a chokehold
#define RESTING_TRAIT "resting" //trait associated to resting
#define STAT_TRAIT "stat" //trait associated to a stat value or range of
#define MAPPING_HELPER_TRAIT "mapping-helper" //obtained from mapping helper
/// Trait associated to wearing a suit
#define SUIT_TRAIT "suit"
/// Trait associated to lying down (having a [lying_angle] of a different value than zero).
#define LYING_DOWN_TRAIT "lying-down"
/// Trait associated to lacking electrical power.
#define POWER_LACK_TRAIT "power-lack"
/// Trait applied by MODsuits.
#define MOD_TRAIT "mod"

// unique trait sources, still defines
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define MEGAFAUNA_TRAIT "megafauna"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define MADE_UNCLONEABLE "made-uncloneable"
#define VENTCRAWLING_TRAIT "ventcrawling"
#define SPECIES_FLIGHT_TRAIT "species-flight"
#define FROSTMINER_ENRAGE_TRAIT "frostminer-enrage"
#define NO_GRAVITY_TRAIT "no-gravity"
#define LEAPER_BUBBLE_TRAIT "leaper-bubble"
#define TIMESTOP_TRAIT "timestop"
#define STICKY_NODROP "sticky-nodrop" //sticky nodrop sounds like a bad soundcloud rapper's name
#define PULLED_WHILE_SOFTCRIT_TRAIT "pulled-while-softcrit"
#define LOCKED_BORG_TRAIT "locked-borg"
#define LACKING_LOCOMOTION_APPENDAGES_TRAIT "lacking-locomotion-appengades" //trait associated to not having locomotion appendages nor the ability to fly or float
#define LACKING_MANIPULATION_APPENDAGES_TRAIT "lacking-manipulation-appengades" //trait associated to not having fine manipulation appendages such as hands
#define HANDCUFFED_TRAIT "handcuffed"
#define ORBITED_TRAIT "orbited"
/// Trait granted by [/obj/item/warpwhistle]
#define WARPWHISTLE_TRAIT "warpwhistle"
///Turf trait for when a turf is transparent
#define TURF_Z_TRANSPARENT_TRAIT "turf_z_transparent"
/// Trait applied to slimes by low temperature
#define SLIME_COLD "slime-cold"
/// Trait applied to bots by being tipped over
#define BOT_TIPPED_OVER "bot-tipped-over"
/// Trait applied to PAIs by being folded
#define PAI_FOLDED "pai-folded"
/// Trait applied to brain mobs when they lack external aid for locomotion, such as being inside a mech.
#define BRAIN_UNAIDED "brain-unaided"

/// Trait granted by [/obj/item/clothing/head/helmet/space/hardsuit/berserker]
#define BERSERK_TRAIT "berserk_trait"
/// The person with this trait always appears as 'unknown'.
#define TRAIT_UNKNOWN "unknown"
/// Currently fishing
#define TRAIT_GONE_FISHING "fishing"
/// Fish in this won't die
#define TRAIT_FISH_SAFE_STORAGE "fish_case"
/// Stuff that can go inside fish cases
#define TRAIT_FISH_CASE_COMPATIBILE "fish_case_compatibile"
/// Self-explainatory.
#define BEAUTY_ELEMENT_TRAIT "beauty_element"
#define MOOD_COMPONENT_TRAIT "mood_component"

#define TRAIT_CANT_RIDE "cant_ride"
#define TRAIT_BLOODY_MESS "bloody_mess" //from heparin, makes open bleeding wounds rapidly spill more blood
#define TRAIT_COAGULATING "coagulating" //from coagulant reagents, this doesn't affect the bleeding itself but does affect the bleed warning messages
#define TRAIT_NOBLEED "nobleed" //This carbon doesn't bleed

#define TRAIT_FORCED_STANDING "forcedstanding"

///Movement type traits for movables. See elements/movetype_handler.dm
#define TRAIT_MOVE_GROUND "move_ground"
#define TRAIT_MOVE_FLYING "move_flying"
#define TRAIT_MOVE_VENTCRAWLING "move_ventcrawling"
#define TRAIT_MOVE_FLOATING "move_floating"
#define TRAIT_MOVE_PHASING "move_phasing"
/// Disables the floating animation. See above.
#define TRAIT_NO_FLOATING_ANIM "no-floating-animation"

/// Trait granted by [mob/living/silicon/ai]
/// Applied when the ai anchors itself
#define AI_ANCHOR_TRAIT "ai_anchor"

/// Climbable trait, given and taken by the climbable element when added or removed. Exists to be easily checked via HAS_TRAIT().
#define TRAIT_CLIMBABLE "trait_climbable"

/// Trait applied by element
#define ELEMENT_TRAIT(source) "element_trait_[source]"
