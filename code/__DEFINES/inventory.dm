/*ALL DEFINES RELATED TO INVENTORY OBJECTS, MANAGEMENT, ETC, GO HERE*/

//Inventory depth: limits how many nested storage items you can access directly.
//1: stuff in mob, 2: stuff in backpack, 3: stuff in box in backpack, etc
#define INVENTORY_DEPTH 3
#define STORAGE_VIEW_DEPTH 2

//ITEM INVENTORY SLOT BITMASKS
#define ITEM_SLOT_OCLOTHING (1<<0)
#define ITEM_SLOT_ICLOTHING (1<<1)
#define ITEM_SLOT_GLOVES (1<<2)
#define ITEM_SLOT_EYES (1<<3)
#define ITEM_SLOT_EARS (1<<4)
#define ITEM_SLOT_MASK (1<<5)
#define ITEM_SLOT_HEAD (1<<6)
#define ITEM_SLOT_FEET (1<<7)
#define ITEM_SLOT_ID (1<<8)
#define ITEM_SLOT_BELT (1<<9)
#define ITEM_SLOT_BACK (1<<10)
#define ITEM_SLOT_DEX_STORAGE (1<<11)
#define ITEM_SLOT_NECK (1<<12)
#define ITEM_SLOT_HANDS (1<<13)
#define ITEM_SLOT_BACKPACK (1<<14)
#define ITEM_SLOT_SUITSTORE (1<<15)
#define ITEM_SLOT_LPOCKET (1<<16)
#define ITEM_SLOT_RPOCKET (1<<17)
#define ITEM_SLOT_HANDCUFFED (1<<18)
#define ITEM_SLOT_LEGCUFFED (1<<19)

#define SLOTS_AMT 20 // Keep this up to date!

//SLOT GROUP HELPERS
#define ITEM_SLOT_POCKETS (ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET)
//All the item slots that are allowed to be held in Kepori beaks (their mask slot)
#define ITEM_SLOT_KEPORI_BEAK (ITEM_SLOT_MASK|ITEM_SLOT_ID|ITEM_SLOT_POCKETS|ITEM_SLOT_DEX_STORAGE|ITEM_SLOT_SUITSTORE)

//Bit flags for the flags_inv variable, which determine when a piece of clothing hides another. IE a helmet hiding glasses.
//Make sure to update check_obscured_slots() if you add more.
#define HIDEGLOVES (1<<0)
#define HIDESUITSTORAGE (1<<1)
#define HIDEJUMPSUIT (1<<2)	//these first four are only used in exterior suits
#define HIDESHOES (1<<3)
#define HIDEMASK (1<<4)		//these last six are only used in masks and headgear.
#define HIDEEARS (1<<5)		// (ears means headsets and such)
#define HIDEEYES (1<<6)		// Whether eyes and glasses are hidden
#define HIDEFACE (1<<7)		// Whether we appear as unknown.
#define HIDEHAIR (1<<8)
#define HIDEFACIALHAIR (1<<9)
#define HIDENECK (1<<10)
#define HIDEHORNS (1<<11) 	// Used for hiding Sarathi horns.
#define HIDESNOUT (1<<11)

//bitflags for clothing coverage - also used for limbs
#define HEAD (1<<0)
#define CHEST (1<<1)
#define GROIN (1<<2)
#define LEG_LEFT (1<<3)
#define LEG_RIGHT (1<<4)
#define LEGS (LEG_LEFT | LEG_RIGHT)
#define FOOT_LEFT (1<<5)
#define FOOT_RIGHT (1<<6)
#define FEET (FOOT_LEFT | FOOT_RIGHT)
#define ARM_LEFT (1<<7)
#define ARM_RIGHT (1<<8)
#define ARMS (ARM_LEFT | ARM_RIGHT)
#define HAND_LEFT (1<<9)
#define HAND_RIGHT (1<<10)
#define HANDS (HAND_LEFT | HAND_RIGHT)
#define NECK (1<<11)
#define FULL_BODY (~0)

//defines for the index of hands
#define LEFT_HANDS 1
#define RIGHT_HANDS 2

//flags for alternate styles: These are hard sprited so don't set this if you didn't put the effort in
#define NORMAL_STYLE 0
#define ALT_STYLE 1 // rolled down/alt uniform
#define ROLLED_STYLE 2 // rolled sleeves

//This system takes priority over Sprite Sheets.
#define NO_VARIATION (1<<0)
#define DIGITIGRADE_VARIATION (1<<1)
#define DIGITIGRADE_VARIATION_NO_NEW_ICON (1<<2)
#define DIGITIGRADE_VARIATION_SAME_ICON_FILE (1<<3) //intended for use with factional icon files for organization purposes, otherwise use either above. Ex of naming: a state called "nameof_thing" can be named "nameof_thing_digi"
#define SNOUTED_VARIATION (1<<4) //Ex of naming: a state called "nameof_thing" can be named "nameof_thing_snouted"
#define SNOUTED_SMALL_VARIATION (1<<5) //For Elzuose snouts
#define VOX_VARIATION (1<<6)
#define KEPORI_VARIATION (1<<7)

#define NOT_DIGITIGRADE 0
#define FULL_DIGITIGRADE 1
#define SQUISHED_DIGITIGRADE 2

//flags for covering body parts
#define GLASSESCOVERSEYES (1<<0)
#define MASKCOVERSEYES (1<<1) // get rid of some of the other stupidness in these flags
#define HEADCOVERSEYES (1<<2) // feel free to realloc these numbers for other purposes
#define MASKCOVERSMOUTH (1<<3) // on other items, these are just for mask/head
#define HEADCOVERSMOUTH (1<<4)
#define PEPPERPROOF (1<<5)	//protects against pepperspray

#define TINT_DARKENED 2 //Threshold of tint level to apply weld mask overlay
#define TINT_BLIND 3 //Threshold of tint level to obscure vision fully

//Allowed equipment lists for security vests and hardsuits.

GLOBAL_LIST_INIT(advanced_hardsuit_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals)))

GLOBAL_LIST_INIT(security_hardsuit_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/gun/grenadelauncher,
	/obj/item/melee/baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals)))

GLOBAL_LIST_INIT(detective_vest_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/detective_scanner,
	/obj/item/flashlight,
	/obj/item/taperecorder,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/gun/grenadelauncher,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman)))

GLOBAL_LIST_INIT(security_vest_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/gun/grenadelauncher,
	/obj/item/flamethrower,
	/obj/item/melee/knife/combat,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/melee/sledgehammer)))

GLOBAL_LIST_INIT(security_wintercoat_allowed, typecacheof(list(
	/obj/item/ammo_box,
	/obj/item/ammo_casing,
	/obj/item/flashlight,
	/obj/item/storage/fancy/cigarettes,
	/obj/item/gun/ballistic,
	/obj/item/gun/energy,
	/obj/item/gun/grenadelauncher,
	/obj/item/lighter,
	/obj/item/melee/baton,
	/obj/item/melee/classic_baton/telescopic,
	/obj/item/reagent_containers/spray/pepper,
	/obj/item/restraints/handcuffs,
	/obj/item/tank/internals/emergency_oxygen,
	/obj/item/tank/internals/plasmaman,
	/obj/item/toy)))

#define GET_INTERNAL_SLOTS(C) list(C.head, C.wear_mask)
