#define OVERMAP_GENERATOR_SOLAR "solar_system"
#define OVERMAP_GENERATOR_RANDOM "random"

//Add new star types here
#define SMALLSTAR 1
#define TWOSTAR 2
#define MEDSTAR 3
#define BIGSTAR 4

//Star classes
#define STARO 1 //Extremely bright blue main sequence star or (super)giant
#define STARB 2 //Bright blue main sequence star or (super)giant
#define STARA 3 //Light blue main sequence star
#define STARF 4 //White main sequence star
#define STARG 5 //Yellow main sequence star or supergiant
#define STARK 6 //Orange dwarf, main sequence star, or hypergiant
#define STARM 7 //Red dwarf or red (super)giant
#define STARL 8 //Cool red dwarf
#define START 9 //Methane dwarf
#define STARY 10 //Sad lame brown dwarf
#define STARD 11 //White dwarf

//Amount of times the overmap generator will attempt to place something before giving up
#define MAX_OVERMAP_PLACEMENT_ATTEMPTS 5

//Possible dynamic encounter types
#define DYNAMIC_WORLD_LAVA "lava"
#define DYNAMIC_WORLD_ICE "ice"
#define DYNAMIC_WORLD_SAND "sand"
#define DYNAMIC_WORLD_JUNGLE "jungle"
#define DYNAMIC_WORLD_ROCKPLANET "rockplanet"
#define DYNAMIC_WORLD_REEBE "reebe"
#define DYNAMIC_WORLD_ASTEROID "asteroid"
#define DYNAMIC_WORLD_SPACERUIN "space"

//Possible ship states
#define OVERMAP_SHIP_IDLE "idle"
#define OVERMAP_SHIP_FLYING "flying"
#define OVERMAP_SHIP_ACTING "acting"
#define OVERMAP_SHIP_DOCKING "docking"
#define OVERMAP_SHIP_UNDOCKING "undocking"

///Used to get the turf on the "physical" overmap representation.
#define OVERMAP_TOKEN_TURF(x_pos, y_pos) locate(SSovermap.overmap_vlevel.low_x + SSovermap.overmap_vlevel.reserved_margin + x_pos - 1, SSovermap.overmap_vlevel.low_y + SSovermap.overmap_vlevel.reserved_margin + y_pos - 1, SSovermap.overmap_vlevel.z_value)
