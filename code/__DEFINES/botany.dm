#define TRAY_NAME_UPDATE name = myseed ? "[initial(name)] ([myseed.plantname])" : initial(name)
#define YIELD_WEED_MINIMUM 3
#define YIELD_WEED_MAXIMUM 10
#define STATIC_NUTRIENT_CAPACITY 10
#define CYCLE_DELAY_DEFAULT 200 //About 10 seconds / cycle
#define CYCLE_DELAY_SLOW 500 //About 25 seconds / cycle

//Both available scanning modes for the plant analyzer.
#define PLANT_SCANMODE_STATS 0
#define PLANT_SCANMODE_CHEMICALS 1

//Seed flags.
#define MUTATE_EARLY (1<<0)
#define UNHARVESTABLE -1

//Floral Somoray
#define REVOLUTION_CHARGE 10000 // Default flora cell

/// -- Trait IDs. Plants that match IDs cannot be added to the same plant. --
/// Plants that glow.
#define GLOW_ID (1<<0)
/// Plant types.
#define PLANT_TYPE_ID (1<<1)
/// Plants that affect the reagent's temperature.
#define TEMP_CHANGE_ID (1<<2)
/// Plants that affect the reagent contents.
#define CONTENTS_CHANGE_ID (1<<3)
/// Plants that do something special when they impact.
#define THROW_IMPACT_ID (1<<4)
/// Plants that transfer reagents on impact.
#define REAGENT_TRANSFER_ID (1<<5)
/// Plants that have a unique effect on attack_self.
#define ATTACK_SELF_ID (1<<6)

#define HYDROTRAY_NO_PLANT "missing"
#define HYDROTRAY_PLANT_DEAD "dead"
#define HYDROTRAY_PLANT_GROWING "growing"
#define HYDROTRAY_PLANT_HARVESTABLE "harvestable"
