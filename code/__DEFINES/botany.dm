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
