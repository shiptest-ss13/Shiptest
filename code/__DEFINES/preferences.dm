
//Preference toggles
#define SOUND_ADMINHELP (1<<0)
#define SOUND_MIDI (1<<1)
#define SOUND_AMBIENCE (1<<2)
#define SOUND_LOBBY (1<<3)
#define MEMBER_PUBLIC (1<<4)
#define INTENT_STYLE (1<<5)
#define MIDROUND_ANTAG (1<<6)
#define SOUND_INSTRUMENTS (1<<7)
#define SOUND_SHIP_AMBIENCE (1<<8)
#define SOUND_PRAYERS (1<<9)
#define ANNOUNCE_LOGIN (1<<10)
#define SOUND_ANNOUNCEMENTS (1<<11)
#define DISABLE_DEATHRATTLE (1<<12)
#define DISABLE_ARRIVALRATTLE (1<<13)
#define COMBOHUD_LIGHTING (1<<14)
#define DEADMIN_ALWAYS (1<<15)
#define DEADMIN_ANTAGONIST (1<<16)
#define DEADMIN_POSITION_HEAD (1<<17)
#define DEADMIN_POSITION_SECURITY (1<<18)
#define DEADMIN_POSITION_SILICON (1<<19)
#define SOUND_ENDOFROUND (1<<20)
#define ADMIN_IGNORE_CULT_GHOST (1<<21)
#define SPLIT_ADMIN_TABS (1<<22)
#define FAST_MC_REFRESH (1<<23)

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|SOUND_ENDOFROUND|MEMBER_PUBLIC|INTENT_STYLE|MIDROUND_ANTAG|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS)

//Chat toggles
#define CHAT_OOC (1<<0)
#define CHAT_DEAD (1<<1)
#define CHAT_GHOSTEARS (1<<2)
#define CHAT_GHOSTSIGHT (1<<3)
#define CHAT_PRAYER (1<<4)
#define CHAT_RADIO (1<<5)
#define CHAT_PULLR (1<<6)
#define CHAT_GHOSTWHISPER (1<<7)
#define CHAT_GHOSTPDA (1<<8)
#define CHAT_GHOSTRADIO (1<<9)
#define CHAT_BANKCARD (1<<10)
#define CHAT_GHOSTLAWS (1<<11)
#define CHAT_LOOC (1<<12)
#define CHAT_LOGIN_LOGOUT (1<<13)
#define CHAT_GHOSTCKEY (1<<14)

#define TOGGLES_DEFAULT_CHAT (CHAT_OOC|CHAT_DEAD|CHAT_GHOSTEARS|CHAT_GHOSTSIGHT|CHAT_PRAYER|CHAT_RADIO|CHAT_PULLR|CHAT_GHOSTWHISPER|CHAT_GHOSTPDA|CHAT_GHOSTRADIO|CHAT_BANKCARD|CHAT_GHOSTLAWS|CHAT_LOOC|CHAT_LOGIN_LOGOUT)

#define PARALLAX_INSANE -1 //for show offs
#define PARALLAX_HIGH 0 //default.
#define PARALLAX_MED 1
#define PARALLAX_LOW 2
#define PARALLAX_DISABLE 3 //this option must be the highest number

#define PIXEL_SCALING_AUTO 0
#define PIXEL_SCALING_1X 1
#define PIXEL_SCALING_1_2X 1.5
#define PIXEL_SCALING_2X 2
#define PIXEL_SCALING_3X 3

#define SCALING_METHOD_NORMAL "normal"
#define SCALING_METHOD_DISTORT "distort"
#define SCALING_METHOD_BLUR "blur"

#define PARALLAX_DELAY_DEFAULT world.tick_lag
#define PARALLAX_DELAY_MED 1
#define PARALLAX_DELAY_LOW 2

// Playtime tracking system, see jobs_exp.dm
// Due to changes to job experience requirements, many of these are effectively unused.
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_CREW "Crew"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_SCIENCE "Science"
#define EXP_TYPE_SUPPLY "Supply"
#define EXP_TYPE_SECURITY "Security"
#define EXP_TYPE_SILICON "Silicon"
#define EXP_TYPE_SERVICE "Service"
#define EXP_TYPE_ANTAG "Antag"
#define EXP_TYPE_SPECIAL "Special"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ADMIN "Admin"

///Screentip settings
#define SCREENTIP_OFF 0
#define SCREENTIP_SMALL 1
#define SCREENTIP_MEDIUM 1
#define SCREENTIP_BIG 1

//Flags in the players table in the db
#define DB_FLAG_EXEMPT (1<<0)

#define DEFAULT_CYBORG_NAME "Default Cyborg Name"

#warn remove
//randomised elements
#define RANDOM_NAME "random_name"
#define RANDOM_NAME_ANTAG "random_name_antag"
#define RANDOM_BODY "random_body"
#define RANDOM_BODY_ANTAG "random_body_antag"
#define RANDOM_SPECIES "random_species"
#define RANDOM_GENDER "random_gender"
#define RANDOM_GENDER_ANTAG "random_gender_antag"
#define RANDOM_AGE "random_age"
#define RANDOM_AGE_ANTAG "random_age_antag"
#define RANDOM_UNDERWEAR "random_underwear"
#define RANDOM_UNDERWEAR_COLOR "random_underwear_color"
#define RANDOM_UNDERSHIRT "random_undershirt"
#define RANDOM_UNDERSHIRT_COLOR "random_undershirt_color"
#define RANDOM_SOCKS "random_socks"
#define RANDOM_SOCKS_COLOR "random_socks_color"
#define RANDOM_BACKPACK "random_backpack"
#define RANDOM_JUMPSUIT_STYLE "random_jumpsuit_style"
#define RANDOM_EXOWEAR_STYLE "random_jumpsuit_style"
#define RANDOM_HAIRSTYLE "random_hairstyle"
#define RANDOM_HAIR_COLOR "random_hair_color"
#define RANDOM_FACIAL_HAIR_COLOR "random_facial_hair_color"
#define RANDOM_FACIAL_HAIRSTYLE "random_facial_hairstyle"
#define RANDOM_SKIN_TONE "random_skin_tone"
#define RANDOM_EYE_COLOR "random_eye_color"
#define RANDOM_PROSTHETIC "random_prosthetic"
#define RANDOM_HAIR_GRADIENT_STYLE "random_grad_style"
#define RANDOM_HAIR_GRADIENT_COLOR "random_grad_color"

//prosthetics stuff
#define PROSTHETIC_NORMAL "normal"
#define PROSTHETIC_AMPUTATED "amputated"
#define PROSTHETIC_ROBOTIC "prosthetic"

#warn ensure that these defines are universally used (post-update from master)
#warn file could do with some sorting.
// Strings used as keys in the "features" list on mobs, signifying various attributes.
// THESE SHOULD NOT OVERLAP WITH THE mutant_string VARIABLE
// ON ANY /datum/sprite_accessory/mutant_part SUBTYPE!!
// THINGS WILL BREAK!!!!
#define FEATURE_MUTANT_COLOR "mcolor"
#define FEATURE_MUTANT_COLOR2 "mcolor2"
#define FEATURE_BODY_SIZE "body_size"

#define FEATURE_FLAVOR_TEXT "flavor_text"
#define FEATURE_IPC_CHASSIS "ipc_chassis"
#define FEATURE_IPC_BRAIN "ipc_brain"
#define FEATURE_LEGS_TYPE "legs"


//Hairstyles
GLOBAL_LIST_EMPTY(hairstyles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(facial_hairstyles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(hair_gradients_list) //stores /datum/sprite_accessory/hair_gradient indexed by name

//Underwear
GLOBAL_LIST_EMPTY(underwear_list)		//stores /datum/sprite_accessory/underwear indexed by name

//Undershirts
GLOBAL_LIST_EMPTY(undershirt_list) 	//stores /datum/sprite_accessory/undershirt indexed by name

//Socks
GLOBAL_LIST_EMPTY(socks_list)		//stores /datum/sprite_accessory/socks indexed by name

// IPC chassises
GLOBAL_LIST_EMPTY(ipc_chassis_list) // stores /datum/sprite_accessory/ipc_chassis indexed by name


// These are the *values* in the features list which are keyed by FEATURE_LEGS_TYPE, used to distinguish normal legs from digitigrade ones.
#define FEATURE_NORMAL_LEGS "Normal Legs"
#define FEATURE_DIGITIGRADE_LEGS "Digitigrade Legs"
GLOBAL_LIST_INIT(legs_list, list(FEATURE_NORMAL_LEGS, FEATURE_DIGITIGRADE_LEGS))


// Backpacks
#define GBACKPACK "Grey Backpack"
#define GSATCHEL "Grey Satchel"
#define GDUFFELBAG "Grey Duffel Bag"
#define GCOURIERBAG "Grey Messenger Bag"
#define LSATCHEL "Leather Satchel"
#define DBACKPACK "Department Backpack"
#define DSATCHEL "Department Satchel"
#define DDUFFELBAG "Department Duffel Bag"
#define DCOURIERBAG "Department Messenger Bag"
GLOBAL_LIST_INIT(backpacklist, list(DBACKPACK, DSATCHEL, DCOURIERBAG, DDUFFELBAG, GBACKPACK, GSATCHEL, GCOURIERBAG, GDUFFELBAG, LSATCHEL))

// Uniforms
#define PREF_SUIT "Standard Jumpsuit"
#define PREF_SKIRT "Standard Jumpskirt"
#define PREF_ALTSUIT "Alternate Jumpsuit"
#define PREF_GREYSUIT "Grey Jumpsuit"
GLOBAL_LIST_INIT(jumpsuitlist, list(PREF_SUIT, PREF_SKIRT, PREF_ALTSUIT, PREF_GREYSUIT))

// Exowear
#define PREF_NOEXOWEAR "No Exowear"
#define PREF_EXOWEAR "Standard Exowear"
#define PREF_ALTEXOWEAR "Alternate Exowear"
#define PREF_COATEXOWEAR "Departmental Winter Coat"
GLOBAL_LIST_INIT(exowearlist, list(PREF_NOEXOWEAR, PREF_EXOWEAR, PREF_ALTEXOWEAR, PREF_COATEXOWEAR))

// Body sizes
#define BODY_SIZE_NORMAL "Normal"
#define BODY_SIZE_SHORT "Short"
#define BODY_SIZE_TALL "Tall"

#define BODY_SIZE_NORMAL_SCALE 1
#define BODY_SIZE_SHORT_SCALE 0.93
#define BODY_SIZE_TALL_SCALE 1.03
GLOBAL_LIST_INIT(body_sizes, list(BODY_SIZE_NORMAL = BODY_SIZE_NORMAL_SCALE, BODY_SIZE_SHORT = BODY_SIZE_SHORT_SCALE, BODY_SIZE_TALL = BODY_SIZE_TALL_SCALE))

// IPC brains
GLOBAL_LIST_INIT(ipc_brain_list, list("Posibrain", "Man-Machine Interface"))


GLOBAL_LIST_INIT(color_list_ethereal, list(
	"Red" = "ff4d4d",
	"Faint Red" = "ffb3b3",
	"Dark Red" = "9c3030",
	"Orange" = "ffa64d",
	"Burnt Orange" = "cc4400",
	"Bright Yellow" = "ffff99",
	"Dull Yellow" = "fbdf56",
	"Faint Green" = "ddff99",
	"Green" = "97ee63",
	"Seafoam Green" = "00fa9a",
	"Dark Green" = "37835b",
	"Cyan Blue" = "00ffff",
	"Faint Blue" = "b3d9ff",
	"Blue" = "3399ff",
	"Dark Blue" = "6666ff",
	"Purple" = "ee82ee",
	"Dark Fuschia" = "cc0066",
	"Pink" = "ff99cc",
	"White" = "f2f2f2",))

GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list(
	"ghost",
	"ghostian",
	"ghostian2",
	"ghostking",
	"ghost_red",
	"ghost_black",
	"ghost_blue",
	"ghost_yellow",
	"ghost_green",
	"ghost_pink",
	"ghost_cyan",
	"ghost_dblue",
	"ghost_dred",
	"ghost_dgreen",
	"ghost_dcyan",
	"ghost_grey",
	"ghost_dyellow",
	"ghost_dpink",
	"skeleghost",
	"ghost_purpleswirl",
	"ghost_rainbow",
	"ghost_fire",
	"ghost_funkypurp",
	"ghost_pinksherbert",
	"ghost_blazeit",
	"ghost_mellow",
	"ghost_camo",
	"catghost")) //stores the ghost forms that support directional sprites

GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, sortList(list(
	":thinking:",
	"Alien",
	"Angel",
	"Banned",
	"Bliss",
	"Blue",
	"Clown",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"HAL 9000",
	"Heartline",
	"Helios",
	"House",
	"Inverted",
	"Lamp",
	"Matrix",
	"Monochrome",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"President",
	"Random",
	"Rainbow",
	"Red",
	"Red October",
	"Static",
	"Syndicat Meow",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Weird")))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		return "ai-[lowertext(input)]"
