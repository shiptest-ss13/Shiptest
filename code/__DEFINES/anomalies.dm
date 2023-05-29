// Max amounts of cores you can make
#define MAX_CORES_BLUESPACE 8
#define MAX_CORES_GRAVITATIONAL 8
#define MAX_CORES_FLUX 8
#define MAX_CORES_VORTEX 8
#define MAX_CORES_PYRO 8
#define MAX_CORES_HALLUCINATION 8
#define MAX_CORES_BIOSCRAMBLER 8
#define MAX_CORES_DIMENSIONAL 8

///Defines for the different types of explosion a flux anomaly can have
#define FLUX_NO_EXPLOSION 0
#define FLUX_EXPLOSIVE 1
#define FLUX_LOW_EXPLOSIVE 2

/// Chance of anomalies moving every process tick
#define ANOMALY_MOVECHANCE 45

/// Blacklist of parts which should not appear when bioscrambled, largely because they will make you look totally fucked up
GLOBAL_LIST_INIT(bioscrambler_parts_blacklist, typecacheof(list (
	/obj/item/bodypart/chest/larva,
	/obj/item/bodypart/head/larva,
	/obj/item/bodypart/leg/left/monkey,
	/obj/item/bodypart/leg/right/monkey,
	/obj/item/bodypart/head,
	/obj/item/bodypart/head/alien,

)))

/// Blacklist of organs which should not appear when bioscrambled.
/// Either will look terrible outside of intended host, give you magical powers, are irreversible, or kill you
GLOBAL_LIST_INIT(bioscrambler_organs_blacklist, typecacheof(list (
	/obj/item/organ/ears/invincible,
	/obj/item/organ/ears/dullahan,
	/obj/item/organ/eyes/dullahan,
	/obj/item/organ/heart/cursed,
	/obj/item/organ/heart/cursed/wizard,
	/obj/item/organ/heart/demon,
	/obj/item/organ/heart/cursed,
	/obj/item/organ/tongue/golem_honk, //hatred
	/obj/item/organ/tongue/uwuspeak,//see last comment
	/obj/item/organ/vocal_cords,
	/obj/item/organ/vocal_cords/adamantine,
	/obj/item/organ/vocal_cords/colossus,
	/obj/item/organ/zombie_infection,
	/obj/item/organ/brain,
	/obj/item/organ/brain/alien,
	/obj/item/organ/brain/nightmare,
	/obj/item/organ/brain/dullahan,
	/obj/item/organ/brain/mmi_holder,
	/obj/item/organ/brain/mmi_holder/posibrain,
	/obj/item/organ/alien/eggsac,
	/obj/item/organ/alien/hivenode,
	/obj/item/organ/alien/plasmavessel/large/queen,
	/obj/item/organ/alien/plasmavessel/large,
	/obj/item/organ/body_egg,
	/obj/item/organ/body_egg/alien_embryo,
	/obj/item/organ/body_egg/changeling_egg,
)))

/// List of body parts we can apply to people
GLOBAL_LIST_EMPTY(bioscrambler_valid_parts)
/// List of organs we can apply to people
GLOBAL_LIST_EMPTY(bioscrambler_valid_organs)
