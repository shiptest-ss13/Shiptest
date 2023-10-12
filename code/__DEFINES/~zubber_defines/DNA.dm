//We start from 30 to not interfere with TG species defines, should they add more
/// We're using all three mutcolor features for our skin coloration
#define MUTCOLOR_MATRIXED	30
#define MUTCOLORS2			31
#define MUTCOLORS3			32
// Defines for whether an accessory should have one or three colors to choose for
#define USE_ONE_COLOR		31
#define USE_MATRIXED_COLORS	32
// Defines for some extra species traits
#define REVIVES_BY_HEALING	33
#define ROBOTIC_LIMBS		34
#define ROBOTIC_DNA_ORGANS	35
//Also.. yes for some reason specie traits and accessory defines are together

#define REAGENT_ORGANIC 1
#define REAGENT_SYNTHETIC 2

//Some defines for sprite accessories
// Which color source we're using when the accessory is added
#define DEFAULT_PRIMARY		1
#define DEFAULT_SECONDARY	2
#define DEFAULT_TERTIARY	3
#define DEFAULT_MATRIXED	4 //uses all three colors for a matrix
#define DEFAULT_SKIN_OR_PRIMARY	5 //Uses skin tone color if the character uses one, otherwise primary

// Defines for extra bits of accessories
#define COLOR_SRC_PRIMARY	1
#define COLOR_SRC_SECONDARY	2
#define COLOR_SRC_TERTIARY	3
#define COLOR_SRC_MATRIXED	4

// Defines for mutant bodyparts indexes
#define MUTANT_INDEX_NAME		"name"
#define MUTANT_INDEX_COLOR_LIST	"color"

//The color list that is passed to color matrixed things when a person is husked
#define HUSK_COLOR_LIST list(list(0.64, 0.64, 0.64, 0), list(0.64, 0.64, 0.64, 0), list(0.64, 0.64, 0.64, 0), list(0, 0, 0, 1))

//Defines for an accessory to be randomed
#define ACC_RANDOM		"random"

//organ slots
#define ORGAN_SLOT_PENIS "penis"
#define ORGAN_SLOT_VAGINA "vagina"
#define ORGAN_SLOT_TESTICLES "testicles"
#define ORGAN_SLOT_BREASTS "breasts"

#define MAXIMUM_MARKINGS_PER_LIMB 3

#define PREVIEW_PREF_JOB "Job"
#define PREVIEW_PREF_LOADOUT "Loadout"
#define PREVIEW_PREF_NAKED "Naked"

//#define BODY_SIZE_NORMAL 		1.00
#define BODY_SIZE_MAX			1.5
#define BODY_SIZE_MIN			0.8

//In inches
#define PENIS_MAX_GIRTH 		15
#define PENIS_MIN_LENGTH 		1
#define PENIS_MAX_LENGTH 		20

#define SHEATH_NONE			"None"
#define SHEATH_NORMAL		"Sheath"
#define SHEATH_SLIT			"Slit"
#define SHEATH_MODES list(SHEATH_NONE, SHEATH_NORMAL, SHEATH_SLIT)

#define MANDATORY_FEATURE_LIST list(\
	"mcolor" = "FFB", \
	"mcolor2" = "FFB", \
	"mcolor3" = "FFB", \
	"grad_style" = "None", \
	"grad_color" = "FFF", \
	"ethcolor" = "9c3030",\
	"tail_lizard" = "Smooth",\
	"tail_human" = "None",\
	"snout" = "Round",\
	"horns" = "None",\
	"ears" = "None",\
	"wings" = "None",\
	"frills" = "None",\
	"spines" = "None",\
	"legs" = "Normal Legs",\
	"moth_wings" = "Plain",\
	"moth_fluff" = "Plain",\
	"moth_markings" = "None",\
	"spider_legs" = "Plain",\
	"spider_spinneret" = "Plain",\
	"spider_mandibles" = "Plain",\
	"squid_face" = "Squidward",\
	"ipc_screen" = "Blue",\
	"ipc_antenna" = "None",\
	"ipc_chassis" = "Morpheus Cyberkinetics (Custom)",\
	"ipc_brain" = "Posibrain",\
	"kepori_feathers" = "Plain",\
	"kepori_body_feathers" = "Plain",\
	"kepori_tail_feathers" = "Fan",\
	"vox_head_quills" = "Plain",\
	"vox_neck_quills" = "Plain",\
	"elzu_horns" = "None",\
	"elzu_tail" = "None",\
	"flavor_text" = "",\
\
	"breasts_size" = 1, \
	"breasts_lactation" = FALSE,\
	"penis_size" = 13,\
	"penis_girth" = 9,\
	"penis_taur_mode" = TRUE,\
	"penis_sheath" = SHEATH_NONE ,"balls_size" = 1,\
	"body_size" = BODY_SIZE_NORMAL,\
	"custom_species" = null,\
	"uses_skintones" = FALSE,\
	)

#define UNDERWEAR_HIDE_SOCKS		(1<<0)
#define UNDERWEAR_HIDE_SHIRT		(1<<1)
#define UNDERWEAR_HIDE_UNDIES		(1<<2)

#define AROUSAL_CANT		0
#define AROUSAL_NONE		1
#define AROUSAL_PARTIAL		2
#define AROUSAL_FULL		3
/*
// Shipetest Species defines, here for reference //

#define SPECIES_ABDUCTOR "abductor"
#define SPECIES_ANDROID "android"
#define SPECIES_CORPORATE "corporate"
#define SPECIES_DULLAHAN "dullahan"
#define SPECIES_ETHEREAL "ethereal"
#define SPECIES_FLYPERSON "fly"
#define SPECIES_HUMAN "human"
#define SPECIES_IPC "ipc"
#define SPECIES_JELLYPERSON "jelly"
#define SPECIES_SLIMEPERSON "slime_person"
#define SPECIES_LUMINESCENT "luminescent"
#define SPECIES_STARGAZER "stargazer"
#define SPECIES_LIZARD "lizard"
#define SPECIES_ASHWALKER "ashwalker"
#define SPECIES_KOBOLD "kobold"
#define SPECIES_GOLEM "golem"
#define SPECIES_MONKEY "monkey"
#define SPECIES_MOTH "moth"
#define SPECIES_MUSH "mush"
#define SPECIES_PLASMAMAN "plasmaman"
#define SPECIES_POD "pod"
#define SPECIES_SHADOW "shadow"
#define SPECIES_SKELETON "skeleton"
#define SPECIES_SNAIL "snail"
#define SPECIES_RACHNID "rachnid"
#define SPECIES_KEPORI "kepori"
#define SPECIES_VAMPIRE "vampire"
#define SPECIES_VOX "vox"
#define SPECIES_ZOMBIE "zombie"
#define SPECIES_GOOFZOMBIE "krokodil_zombie"
#define SPECIES_XENOMORPH "xenomorph"
*/
#define SPECIES_AKULA "akula"
#define SPECIES_AQUATIC "aquatic"
#define SPECIES_DWARF "dwarf"
#define SPECIES_HUMANOID "humanoid"
#define SPECIES_INSECT "insect"
#define SPECIES_MAMMAL "mammal"
#define SPECIES_PODPERSON_WEAK "podweak"
#define SPECIES_SYNTHLIZ "synthliz"
#define SPECIES_SYNTHMAMMAL "synthmammal"
#define SPECIES_SYNTHHUMAN "synthhuman"
//#define SPECIES_SLIMESTART "slimeperson"	//There's already SPECIES_SLIMEPERSON in tg // slimegirl trafficking is already on shiptest
#define SPECIES_SKRELL "skrell"
#define SPECIES_TAJARAN "tajaran"
#define SPECIES_REPTILE "reptile" //TODO: CHANGE TO SPECIES_REPTILE
#define SPECIES_VULP "vulpkanin"
#define SPECIES_XENO "xeno"
#define SPECIES_GHOUL "ghoul"

#define SPECIES_MUTANT "mutant"
