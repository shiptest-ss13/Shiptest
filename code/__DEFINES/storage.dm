// storage_flags variable on /datum/component/storage

// Storage limits. These can be combined (and usually are combined).
/// Check max_items and contents.len when trying to insert
#define STORAGE_LIMIT_MAX_ITEMS (1<<0)
/// Check max_combined_w_class.
#define STORAGE_LIMIT_COMBINED_W_CLASS (1<<1)
/// Use the new volume system. Will automatically force rendering to use the new volume/baystation scaling UI so this is kind of incompatible with stuff like stack storage etc etc.
#define STORAGE_LIMIT_VOLUME (1<<2)
/// Use max_w_class
#define STORAGE_LIMIT_MAX_W_CLASS (1<<3)

#define STORAGE_FLAGS_LEGACY_DEFAULT (STORAGE_LIMIT_MAX_ITEMS | STORAGE_LIMIT_COMBINED_W_CLASS | STORAGE_LIMIT_MAX_W_CLASS)
#define STORAGE_FLAGS_VOLUME_DEFAULT (STORAGE_LIMIT_VOLUME | STORAGE_LIMIT_MAX_W_CLASS)

// UI defines
/// Size of volumetric box icon
#define VOLUMETRIC_STORAGE_BOX_ICON_SIZE 32
/// Size of EACH left/right border icon for volumetric boxes
#define VOLUMETRIC_STORAGE_BOX_BORDER_SIZE 1
/// Minimum pixels an item must have in volumetric scaled storage UI
#define MINIMUM_PIXELS_PER_ITEM 8
/// Maximum number of objects that will be allowed to be displayed using the volumetric display system. Arbitrary number to prevent server lockups.
#define MAXIMUM_VOLUMETRIC_ITEMS 256
/// How much padding to give between items
#define VOLUMETRIC_STORAGE_ITEM_PADDING 3
/// How much padding to give to edges
#define VOLUMETRIC_STORAGE_EDGE_PADDING 1

//ITEM INVENTORY WEIGHT, FOR w_class
/// Usually items smaller then a human hand, ex: Playing Cards, Lighter, Scalpel, Coins/Money
#define WEIGHT_CLASS_TINY 1
/// Fits within a small pocket, ex: Flashlight, Multitool, Grenades, GPS Device
#define WEIGHT_CLASS_SMALL 2
/// Can be carried in one hand comfortably, ex: Fire extinguisher, Stunbaton, Gas Mask, Metal Sheets
#define WEIGHT_CLASS_NORMAL 3
/// Items that can be wielded or equipped, (e.g. defibrillator, space suits). Often fits inside backpacks.
#define WEIGHT_CLASS_BULKY 4
/// Usually represents objects that require two hands to operate, (e.g. shotgun, two-handed melee weapons) May fit on some inventory slots
#define WEIGHT_CLASS_HUGE 5
/// Essentially means it cannot be picked up or placed in an inventory, ex: Mech Parts, Safe - Can not fit in Boh
#define WEIGHT_CLASS_GIGANTIC 6

// PLEASE KEEP ALL VOLUME DEFINES IN THIS FILE, it's going to be hell to keep track of them later.
#define DEFAULT_VOLUME_TINY 1
#define DEFAULT_VOLUME_SMALL 2
#define DEFAULT_VOLUME_NORMAL 8
#define DEFAULT_VOLUME_BULKY 14
#define DEFAULT_VOLUME_HUGE 28
#define DEFAULT_VOLUME_GIGANTIC 48

GLOBAL_LIST_INIT(default_weight_class_to_volume, list(
	"[WEIGHT_CLASS_TINY]" = DEFAULT_VOLUME_TINY,
	"[WEIGHT_CLASS_SMALL]" = DEFAULT_VOLUME_SMALL,
	"[WEIGHT_CLASS_NORMAL]" = DEFAULT_VOLUME_NORMAL,
	"[WEIGHT_CLASS_BULKY]" = DEFAULT_VOLUME_BULKY,
	"[WEIGHT_CLASS_HUGE]" = DEFAULT_VOLUME_HUGE,
	"[WEIGHT_CLASS_GIGANTIC]" = DEFAULT_VOLUME_GIGANTIC
	))

/// Macro for automatically getting the volume of an item from its w_class.
#define AUTO_SCALE_VOLUME(w_class)							(GLOB.default_weight_class_to_volume["[w_class]"])
/// Macro for automatically getting the volume of a storage item from its max_w_class and max_combined_w_class.
#define AUTO_SCALE_STORAGE_VOLUME(w_class, max_combined_w_class)		(AUTO_SCALE_VOLUME(w_class) * (max_combined_w_class / w_class))

// Let's keep all of this in one place. given what we put above anyways..

// volume amount for items
#define ITEM_VOLUME_DISK DEFAULT_VOLUME_TINY
#define ITEM_VOLUME_CONTAINER_M 12 //makes nested toolboxes & toolbelts less efficient
#define ITEM_VOLUME_MOB 40//prevents mob stacking

// #define SAMPLE_VOLUME_AMOUNT 2

// max_weight_class for storages
//
#define MAX_WEIGHT_CLASS_S_CONTAINER WEIGHT_CLASS_SMALL
#define MAX_WEIGHT_CLASS_M_CONTAINER WEIGHT_CLASS_NORMAL
#define MAX_WEIGHT_CLASS_BACKPACK WEIGHT_CLASS_NORMAL
#define MAX_WEIGHT_CLASS_DUFFEL WEIGHT_CLASS_BULKY

// max_volume for storages
#define STORAGE_VOLUME_CONTAINER_S DEFAULT_VOLUME_NORMAL //4 small items
#define STORAGE_VOLUME_CONTAINER_M (DEFAULT_VOLUME_NORMAL * 2) //8 small items
#define STORAGE_VOLUME_SATCHEL (DEFAULT_VOLUME_NORMAL * 4) //4 normal items
#define STORAGE_VOLUME_BACKPACK (DEFAULT_VOLUME_NORMAL * 6) //1.5x satchel, 3 bulky items
#define STORAGE_VOLUME_DUFFLEBAG (DEFAULT_VOLUME_NORMAL * 8) // 2 huge items, or 4 bulky items
#define STORAGE_VOLUME_BAG_OF_HOLDING (DEFAULT_VOLUME_NORMAL * 9) //1.5X backpack

//Whitelist for the suit storage slot on medical suits
#define MEDICAL_SUIT_ALLOWED_ITEMS list(	\
	/obj/item/scalpel,	\
	/obj/item/cautery,	\
	/obj/item/hemostat,	\
	/obj/item/retractor,	\
	/obj/item/surgicaldrill,	\
	/obj/item/circular_saw,	\
	/obj/item/analyzer,	\
	/obj/item/sensor_device,	\
	/obj/item/stack/medical,	\
	/obj/item/dnainjector,	\
	/obj/item/reagent_containers/dropper,	\
	/obj/item/reagent_containers/syringe,	\
	/obj/item/reagent_containers/hypospray,	\
	/obj/item/healthanalyzer,	\
	/obj/item/flashlight/pen,	\
	/obj/item/reagent_containers/glass/bottle,	\
	/obj/item/reagent_containers/glass/beaker,	\
	/obj/item/reagent_containers/pill,	\
	/obj/item/storage/pill_bottle,	\
	/obj/item/paper,	\
	/obj/item/melee/classic_baton/telescopic,	\
	/obj/item/toy,	\
	/obj/item/storage/fancy/cigarettes,	\
	/obj/item/lighter,	\
	/obj/item/tank/internals/emergency_oxygen,	\
	/obj/item/tank/internals/plasmaman	\
)
