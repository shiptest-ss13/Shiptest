#define GET_AI_BEHAVIOR(behavior_type) SSai_behaviors.ai_behaviors[behavior_type]
#define HAS_AI_CONTROLLER_TYPE(thing, type) istype(thing?.ai_controller, type)

#define AI_STATUS_ON 1
#define AI_STATUS_OFF 2
///Asleep because there's no players on our virtual z-level to notice us, woken when one arrives
#define AI_STATUS_IDLE 3

///Monkey checks
#define SHOULD_RESIST(source) (source.on_fire || source.buckled || HAS_TRAIT(source, TRAIT_RESTRAINED) || (source.pulledby && source.pulledby.grab_state > GRAB_PASSIVE))
#define IS_DEAD_OR_INCAP(source) (source.incapacitated() || source.stat)

///For JPS pathing, the maximum length of a path we'll try to generate. Should be modularized depending on what we're doing later on
#define AI_MAX_PATH_LENGTH 30 // 30 is possibly overkill since by default we lose interest after 14 tiles of distance, but this gives wiggle room for weaving around obstacles

///Whether mobs's close enough to target for something needing to be within distance of it.
#define AI_IN_RANGE(mover, target, distance) (get_dist(mover, target) <= (distance) && ((distance) != 1 || (target).Adjacent(mover)))

///Notes something controller decided, for debugging mob behaviour, logging needs to be enabled per mob for perf reasons
#define AI_LOG_DECISION(controller, text) if((controller)?.logging_decisions) { (controller).log_decision(text) }
///How often AI with nobody alive on its virtual z-level to see it plans and acts, rather than every tick
#define AI_LOW_PRIORITY_INTERVAL (1 SECONDS)

///How many decisions a controller remembers while logging them
#define AI_DECISION_LOG_LENGTH 20

// Conditions a planning subtree's guard can need or be blocked by
///We've a current target that's still around
#define AI_CONDITION_HAS_TARGET (1<<0)
///We can see our current target
#define AI_CONDITION_TARGET_SEEN (1<<1)
///We've lost sight of our current target. Neither this nor AI_CONDITION_TARGET_SEEN if nothing's keeping track
#define AI_CONDITION_TARGET_LOST (1<<2)
///Our current target's within reach
#define AI_CONDITION_TARGET_ADJACENT (1<<3)
///We're taking cover from being shot at
#define AI_CONDITION_TAKING_COVER (1<<4)
///We're fighting from behind cover, or hiding from someone dug in
#define AI_CONDITION_FIGHTING_FROM_COVER (1<<5)
///We're going around something in the way of our shot
#define AI_CONDITION_FLANKING (1<<6)
///We're moving somewhere better to shoot from
#define AI_CONDITION_REPOSITIONING (1<<7)
///We're backing off after getting a hit in
#define AI_CONDITION_BACKING_OFF (1<<8)
///We're heading somewhere the environment won't hurt us
#define AI_CONDITION_SEEKING_SAFETY (1<<9)
///Where we're standing isn't safe for us, like vacuum or a fire
#define AI_CONDITION_UNSAFE_SPOT (1<<10)
///We've a ranged attack
#define AI_CONDITION_HAS_RANGED_ATTACK (1<<11)
///Our nerve's gone and we're falling back
#define AI_CONDITION_BROKEN (1<<12)
///We're reloading
#define AI_CONDITION_RELOADING (1<<13)

///Cooldown on planning if planning failed last time
#define AI_FAILED_PLANNING_COOLDOWN 1.5 SECONDS

//Return flags for ai_behavior/perform()
///Update this behavior's cooldown
#define AI_BEHAVIOR_DELAY (1<<0)
///Finish the behavior successfully
#define AI_BEHAVIOR_SUCCEEDED (1<<1)
///Finish the behavior unsuccessfully
#define AI_BEHAVIOR_FAILED (1<<2)

#define AI_BEHAVIOR_INSTANT (NONE)

///Flags for ai_behavior new()
#define AI_CONTROLLER_INCOMPATIBLE (1<<0)

///Does this task require movement from the AI before it can be performed?
#define AI_BEHAVIOR_REQUIRE_MOVEMENT (1<<0)
///Does this require the current_movement_target to be adjacent and in reach?
#define AI_BEHAVIOR_REQUIRE_REACH (1<<1)
///Does this task let you perform the action while you move closer? (Things like moving and shooting)
#define AI_BEHAVIOR_MOVE_AND_PERFORM (1<<2)
///Does finishing this task not null the current movement target?
#define AI_BEHAVIOR_KEEP_MOVE_TARGET_ON_FINISH (1<<3)
///Does this behavior NOT block planning?
#define AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION (1<<4)

///AI flags
#define STOP_MOVING_WHEN_PULLED (1<<0)

///Subtree defines

///This subtree should cancel any further planning, (Including from other subtrees)
#define SUBTREE_RETURN_FINISH_PLANNING 1


/// After either being given a verbal order or a pointing order, ignore further of each for this duration
#define AI_HOSTILE_COMMAND_COOLDOWN 2 SECONDS

// hostile command modes (what pointing at something/someone does depending on the last order the carp heard)
/// Don't do anything (will still react to stuff around them though)
#define HOSTILE_COMMAND_NONE 0
/// Will attack a target.
#define HOSTILE_COMMAND_ATTACK 1
/// Will follow a target.
#define HOSTILE_COMMAND_FOLLOW 2


/// Basically, what is our vision/hearing range for picking up on things to fetch/
#define AI_DOG_VISION_RANGE 10
/// What are the odds someone petting us will become our friend?
#define AI_DOG_PET_FRIEND_PROB 15
/// After this long without having fetched something, we clear our ignore list
#define AI_FETCH_IGNORE_DURATION 30 SECONDS
/// After being ordered to heel, we spend this long chilling out
#define AI_DOG_HEEL_DURATION 20 SECONDS
/// After either being given a verbal order or a pointing order, ignore further of each for this duration
#define AI_DOG_COMMAND_COOLDOWN 2 SECONDS

// dog command modes (what pointing at something/someone does depending on the last order the dog heard)
/// Don't do anything (will still react to stuff around them though)
#define DOG_COMMAND_NONE 0
/// Will try to pick up and bring back whatever you point to
#define DOG_COMMAND_FETCH 1
/// Will get within a few tiles of whatever you point at and continually growl/bark. If the target is a living mob who gets too close, the dog will attack them with bites
#define DOG_COMMAND_ATTACK 2

//enumerators for parsing dog command speech
#define COMMAND_HEEL "Heel"
#define COMMAND_FETCH "Fetch"
#define COMMAND_ATTACK "Attack"
#define COMMAND_DIE "Play Dead"

//Hunting defines
#define SUCCESFUL_HUNT_COOLDOWN 5 SECONDS
