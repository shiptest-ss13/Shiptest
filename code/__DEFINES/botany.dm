/// TOOLS AND TRAY

#define TRAY_NAME_UPDATE name = myseed ? "[initial(name)] ([myseed.plantname])" : initial(name)
#define STATIC_NUTRIENT_CAPACITY 10
/// Maximum amount of toxins a tray can reach.
#define MAX_TRAY_TOXINS 100
/// Maxumum pests a tray can reach.
#define MAX_TRAY_PESTS 10
/// Maximum weeds a tray can reach.
#define MAX_TRAY_WEEDS 10
/// How long to wait between plant age ticks, by default. See [/obj/machinery/hydroponics/var/cycledelay]
#define HYDROTRAY_CYCLE_DELAY 60 SECONDS

#define HYDROTRAY_NO_PLANT "missing"
#define HYDROTRAY_PLANT_DEAD "dead"
#define HYDROTRAY_PLANT_GROWING "growing"
#define HYDROTRAY_PLANT_HARVESTABLE "harvestable"

//Both available scanning modes for the plant analyzer.
#define PLANT_SCANMODE_STATS 0
#define PLANT_SCANMODE_CHEMICALS 1

//Floral Somoray
#define REVOLUTION_CHARGE 10000 // Default flora cell

/// PLANTS

//Seed flags.
#define MUTATE_EARLY (1<<0)
#define UNHARVESTABLE -1

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

#define MAX_PLANT_YIELD 10
#define MAX_PLANT_LIFESPAN 100
#define MAX_PLANT_ENDURANCE 100
#define MAX_PLANT_PRODUCTION 10
#define MAX_PLANT_POTENCY 100
#define MAX_PLANT_INSTABILITY 100
#define MAX_PLANT_WEEDRATE 10
#define MAX_PLANT_WEEDCHANCE 67
/// MINS:
#define MIN_PLANT_ENDURANCE 10
