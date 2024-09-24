/// Defers call of proc AfterChange in ChangeTurf.
#define CHANGETURF_DEFER_CHANGE (1 << 0)
/// This flag prevents changeturf from gathering air from nearby turfs to fill the new turf with an approximation of local air
#define CHANGETURF_IGNORE_AIR (1 << 1)
/// Prevents ChangeTurf from returning without an operation if the given path and baseturfs are identical to the pre-existing ones and the preloader is not engaged.
#define CHANGETURF_FORCEOP (1 << 2)
/// A flag for PlaceOnTop to just instance the new turf instead of calling ChangeTurf. Used for uninitialized turfs NOTHING ELSE
#define CHANGETURF_SKIP (1 << 3)
/// Inherit air from previous turf. Implies CHANGETURF_IGNORE_AIR
#define CHANGETURF_INHERIT_AIR (1 << 4)
/// Defers smoothing and starlight recalculation in ChangeTurf so that they may later be more performantly done in bulk.
#define CHANGETURF_DEFER_BATCH (1 << 5)

#define IS_OPAQUE_TURF(turf) (turf.directional_opacity == ALL_CARDINALS)

// Integrity of mineral walls.
#define MINERAL_WALL_INTEGRITY 100

// how many bullet holes a wall can have at a given time
#define MAX_DENT_DECALS 15
