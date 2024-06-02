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

/// Maximum amount of toxins a tray can reach.
#define MAX_TRAY_TOXINS 100
/// Maxumum pests a tray can reach.
#define MAX_TRAY_PESTS 10
/// Maximum weeds a tray can reach.
#define MAX_TRAY_WEEDS 10

/// How long to wait between plant age ticks, by default. See [/obj/machinery/hydroponics/var/cycledelay]
#define HYDROTRAY_CYCLE_DELAY 20 SECONDS

#define HYDROTRAY_NO_PLANT "missing"
#define HYDROTRAY_PLANT_DEAD "dead"
#define HYDROTRAY_PLANT_GROWING "growing"
#define HYDROTRAY_PLANT_HARVESTABLE "harvestable"

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
