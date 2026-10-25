#define BASIC_MOB_MAX_STAMINALOSS 200

// Grace period so mobs don't immediately take damage on spawn before atmos settles
#define BASIC_MOB_ENVIRONMENT_GRACE (10 SECONDS)
// The longest grace for a mob made while a planet's being generated, if it doesn't finish earlier
#define BASIC_MOB_LEVEL_GENERATION_GRACE_CAP (3 MINUTES)

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
