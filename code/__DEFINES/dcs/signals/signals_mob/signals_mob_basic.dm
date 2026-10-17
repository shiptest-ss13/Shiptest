/// Called whenever an animal is pet via the /datum/element/pet_bonus element: (mob/living/petter, modifiers)
#define COMSIG_ANIMAL_PET "animal_pet"

/// Sent by /datum/component/ranged_attacks just before a basic mob fires: (atom/target)
#define COMSIG_BASICMOB_PRE_RANGED_ATTACK "basicmob_pre_ranged_attack"
	/// Stops the shot, like when we're out of ammo
	#define COMPONENT_CANCEL_RANGED_ATTACK (1<<0)

/// Sent by /mob/living/basic/death() before the mob's actually dead, for last words and the like: (gibbed)
#define COMSIG_BASICMOB_PRE_DEATH "basicmob_pre_death"
