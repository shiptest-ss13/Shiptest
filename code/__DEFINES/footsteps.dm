//footstep sound lists in code\_globalvars\lists\footsteps.dm

//footstep turf defines
#define FOOTSTEP_WOOD "wood"
#define FOOTSTEP_FLOOR "floor"
#define FOOTSTEP_PLATING "plating"
#define FOOTSTEP_CARPET "carpet"
#define FOOTSTEP_ASTEROID "asteroid"
#define FOOTSTEP_GRASS "grass"
#define FOOTSTEP_WATER "water"
#define FOOTSTEP_LAVA "lava"
#define FOOTSTEP_MEAT "meat"
#define FOOTSTEP_CATWALK "catwalk"
#define FOOTSTEP_ICE "ice"
#define FOOTSTEP_SNOW "snow"
#define FOOTSTEP_CONCRETE "conc"
#define FOOTSTEP_SAND "sand"
#define FOOTSTEP_MUD "mud"

//footstep mob defines
#define FOOTSTEP_MOB_SHOE "shoe"
#define FOOTSTEP_MOB_BAREFOOT "barefoot"
#define FOOTSTEP_MOB_CLAW "claw"
#define FOOTSTEP_MOB_HEAVY "heavy"

//add new mob footstep types to this or it won't be added to GLOB.footstep
GLOBAL_LIST_INIT(footstep_mob_types, list(FOOTSTEP_MOB_SHOE, FOOTSTEP_MOB_BAREFOOT, FOOTSTEP_MOB_CLAW, FOOTSTEP_MOB_HEAVY))

//Nonstandard behavior
#define FOOTSTEP_MOB_HUMAN "human" //Warning: Only works on /mob/living/carbon/human
#define FOOTSTEP_MOB_SLIME "slime"
