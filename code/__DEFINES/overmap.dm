// These must be kept in sync with the constants in tgui/packages/tgui/components/overmap/BodyComponent.js
// If they fall out of sync, the overmap display will break.
#define OVER_COMP_ID_CIRCLE "circle"
#define OVER_COMP_ID_RECT "rectangle"
#define OVER_COMP_ID_SPRITE "sprite"
#define OVER_COMP_ID_ORBIT "orbit"
#define OVER_COMP_ID_PHYSICS "physics"

//Amount of times the overmap generator will attempt to place something before giving up
#define MAX_OVERMAP_PLACEMENT_ATTEMPTS 5

//Possible dynamic encounter types
#define DYNAMIC_WORLD_LAVA "lava"
#define DYNAMIC_WORLD_ICE "ice"
#define DYNAMIC_WORLD_SAND "sand"
#define DYNAMIC_WORLD_JUNGLE "jungle"
#define DYNAMIC_WORLD_ASTEROID "asteroid"
#define DYNAMIC_WORLD_SPACERUIN "space"

//Possible ship states
#define OVERMAP_SHIP_IDLE "idle"
#define OVERMAP_SHIP_FLYING "flying"
#define OVERMAP_SHIP_ACTING "acting"
#define OVERMAP_SHIP_DOCKING "docking"
#define OVERMAP_SHIP_UNDOCKING "undocking"
