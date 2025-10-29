#define SOLID 1
#define LIQUID 2
#define GAS 3

#define INJECTABLE (1<<0)	// Makes it possible to add reagents through droppers and syringes.
#define DRAWABLE (1<<1)	// Makes it possible to remove reagents through syringes.

#define REFILLABLE (1<<2)	// Makes it possible to add reagents through any reagent container.
#define DRAINABLE (1<<3)	// Makes it possible to remove reagents through any reagent container.
#define DUNKABLE (1<<4)	// Allows items to be dunked into this container for transfering reagents. Used in conjunction with the dunkable component.

#define TRANSPARENT (1<<5)	// Used on containers which you want to be able to see the reagents off.
#define AMOUNT_VISIBLE (1<<6)	// For non-transparent containers that still have the general amount of reagents in them visible.
#define NO_REACT (1<<7)	// Applied to a reagent holder, the contents will not react with each other.

// Is an open container for all intents and purposes.
#define OPENCONTAINER (REFILLABLE | DRAINABLE | TRANSPARENT)


#define TOUCH 1	// splashing
#define INGEST 2	// ingestion
#define VAPOR 3	// foam, spray, blob attack
#define PATCH 4	// patches
#define INJECT 5	// injection
#define SMOKE 6 //smoking

//defines passed through to the on_reagent_change proc
#define DEL_REAGENT 1	// reagent deleted (fully cleared)
#define ADD_REAGENT 2	// reagent added
#define REM_REAGENT 3	// reagent removed (may still exist)
#define CLEAR_REAGENTS 4	// all reagents were cleared

#define MIMEDRINK_SILENCE_DURATION 30 //ends up being 60 seconds given 1 tick every 2 seconds
#define THRESHOLD_UNHUSK 50 //Health treshold for instabitaluri and rezadone to unhusk someone

//used by chem masters and pill presses
#define PILL_STYLE_COUNT 22 //Update this if you add more pill icons or you die
#define RANDOM_PILL_STYLE 22 //Dont change this one though

//used for the autowiki, these reagents you should be able to aquire easily
GLOBAL_LIST_INIT(base_reagents, list(
	/datum/reagent/aluminium,
	/datum/reagent/blood,
	/datum/reagent/bromine,
	/datum/reagent/carbon,
	/datum/reagent/chlorine,
	/datum/reagent/copper,
	/datum/reagent/consumable/ethanol,
	/datum/reagent/fluorine,
	/datum/reagent/hydrogen,
	/datum/reagent/iodine,
	/datum/reagent/iron,
	/datum/reagent/lithium,
	/datum/reagent/mercury,
	/datum/reagent/nitrogen,
	/datum/reagent/oxygen,
	/datum/reagent/phosphorus,
	/datum/reagent/potassium,
	/datum/reagent/uranium/radium,
	/datum/reagent/silicon,
	/datum/reagent/silver,
	/datum/reagent/sodium,
	/datum/reagent/stable_plasma,
	/datum/reagent/consumable/sugar,
	/datum/reagent/sulfur,
	/datum/reagent/toxin/acid,
	/datum/reagent/water,
	/datum/reagent/fuel
))

///Minimum requirement for addiction buzz to be met
#define MIN_ADDICTION_REAGENT_AMOUNT 2
#define MAX_ADDICTION_POINTS 1000

///Addiction start/ends
#define WITHDRAWAL_STAGE1_START_CYCLE 1
#define WITHDRAWAL_STAGE1_END_CYCLE 60
#define WITHDRAWAL_STAGE2_START_CYCLE 61
#define WITHDRAWAL_STAGE2_END_CYCLE 120
#define WITHDRAWAL_STAGE3_START_CYCLE 121
