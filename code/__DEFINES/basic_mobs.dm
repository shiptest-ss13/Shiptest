#define BASIC_MOB_MAX_STAMINALOSS 200

// Grace period so mobs don't immediately take damage on spawn before atmos settles
#define BASIC_MOB_ENVIRONMENT_GRACE (10 SECONDS)
// The longest grace for a mob made while a planet's being generated, if it doesn't finish earlier
#define BASIC_MOB_LEVEL_GENERATION_GRACE_CAP (3 MINUTES)

// Diminishing returns on what disables basic humans, so they can't be locked down forever
// Count each CC type individually
#define STUN_DR_HARD "hard"
#define STUN_DR_KNOCKDOWN "knockdown"
#define STUN_DR_IMMOBILIZE "immobilize"
#define BASIC_MOB_STUN_DR_WINDOW (10 SECONDS)
///How many in a row before we're immune, until the window runs out
#define BASIC_MOB_STUN_DR_STEPS 3
///How long after getting back up from exhaustion before it can floor us again, otherwise they can be chained stamcrit
#define BASIC_MOB_STAMINA_COLLAPSE_GRACE (5 SECONDS)
///The longest exhaustion keeps AI down, however much they keep at it, before it gets back up
#define BASIC_MOB_STAMINA_COLLAPSE_MAX (8 SECONDS)

// What a basic human's outfit protects it from, see /mob/living/basic/human/proc/get_outfit_protection()
///TRUE if something it wears keeps it on its feet when shoved into something, like riot armour
#define OUTFIT_SHOVE_PROOF "shove_proof"
///TRUE if its gloves let it pat out a fire without burning its hands
#define OUTFIT_HOT_HANDS "hot_hands"
///Thermal protection value of the overall outfit
#define OUTFIT_THERMAL_PROTECTION "thermal_protection"
///TRUE if its suit and helmet are both fully acid-proof
#define OUTFIT_ACID_PROOF "acid_proof"

///Basic mob flags
#define DEL_ON_DEATH (1<<0)
