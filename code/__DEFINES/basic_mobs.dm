#define BASIC_MOB_MAX_STAMINALOSS 200

// Grace period so mobs don't immediately take damage on spawn before atmos settles
#define BASIC_MOB_ENVIRONMENT_GRACE (10 SECONDS)
// The longest grace for a mob made while a planet's being generated, if it doesn't finish earlier
#define BASIC_MOB_LEVEL_GENERATION_GRACE_CAP (3 MINUTES)

///Basic mob flags
#define DEL_ON_DEATH (1<<0)
