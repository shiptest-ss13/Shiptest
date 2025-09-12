#define MEAT (1<<0)
#define VEGETABLES (1<<1)
#define RAW (1<<2)
#define JUNKFOOD (1<<3)
#define GRAIN (1<<4)
#define FRUIT (1<<5)
#define DAIRY (1<<6)
#define FRIED (1<<7)
#define ALCOHOL (1<<8)
#define SUGAR (1<<9)
#define GROSS (1<<10)
#define TOXIC (1<<11)
#define PINEAPPLE (1<<12)
#define BREAKFAST (1<<13)
#define CLOTH (1<<14)
#define GRILLED (1<<15)
#define NUTS (1<<16)
#define SEAFOOD (1<<17)
#define ORANGES (1<<18)
#define BUGS (1<<19)
#define GORE (1<<20)

DEFINE_BITFIELD(foodtypes, list(
	"MEAT" = MEAT,
	"VEGETABLES" = VEGETABLES,
	"RAW" = RAW,
	"JUNKFOOD" = JUNKFOOD,
	"GRAIN" = GRAIN,
	"FRUIT" = FRUIT,
	"DAIRY" = DAIRY,
	"FRIED" = FRIED,
	"ALCOHOL" = ALCOHOL,
	"SUGAR" = SUGAR,
	"GROSS" = GROSS,
	"TOXIC" = TOXIC,
	"PINEAPPLE" = PINEAPPLE,
	"BREAKFAST" = BREAKFAST,
	"CLOTH" = CLOTH,
	"NUTS" = NUTS,
	"SEAFOOD" = SEAFOOD,
	"ORANGES" = ORANGES,
	"BUGS" = BUGS,
	"GORE" = GORE,
))

/// IC meaning (more or less) for food flags
#define FOOD_FLAGS_IC list( \
	"Meat", \
	"Vegetables", \
	"Raw food", \
	"Junk food", \
	"Grain", \
	"Fruits", \
	"Dairy products", \
	"Fried food", \
	"Alcohol", \
	"Sugary food", \
	"Gross food", \
	"Toxic food", \
	"Pineapples", \
	"Breakfast food", \
	"Clothing", \
	"Nuts", \
	"Seafood", \
	"Oranges", \
	"Bugs", \
)

#define DRINK_NICE 1
#define DRINK_GOOD 2
#define DRINK_VERYGOOD 3
#define DRINK_FANTASTIC 4
#define FOOD_AMAZING 5

/// Food is "in a container", not in a code sense, but in a literal sense (canned foods)
#define FOOD_IN_CONTAINER (1<<0)
/// Finger food can be eaten while walking / running around
#define FOOD_FINGER_FOOD (1<<1)

DEFINE_BITFIELD(food_types, list(
	"FOOD_FINGER_FOOD" = FOOD_FINGER_FOOD,
	"FOOD_IN_CONTAINER" = FOOD_IN_CONTAINER,
))

#define STOP_SERVING_BREAKFAST (15 MINUTES)

///Amount of reagents you start with on crafted food excluding the used parts
#define CRAFTED_FOOD_BASE_REAGENT_MODIFIER 0.7
///Modifier of reagents you get when crafting food from the parts used
#define CRAFTED_FOOD_INGREDIENT_REAGENT_MODIFIER 0.5

#define IS_EDIBLE(O) (O.GetComponent(/datum/component/edible))

///Food trash flags
#define FOOD_TRASH_POPABLE (1<<0)
#define FOOD_TRASH_OPENABLE (1<<1)

#define FOOD_LIKED 1
#define FOOD_DISLIKED 2
#define FOOD_TOXIC 3
