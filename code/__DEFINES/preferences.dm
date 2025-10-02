
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
#define SPLIT_ADMIN_TABS (1<<21)
#define FAST_MC_REFRESH (1<<22)
#define SOUND_RADIO (1<<23)

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|SOUND_ENDOFROUND|SOUND_RADIO|MEMBER_PUBLIC|INTENT_STYLE|MIDROUND_ANTAG|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS)

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

/// You cannot speak or understand this language whatsoever.
#define LANGUAGE_UNKNOWN "Unknown (0)"
/// You cannot speak this language, but can recognize some of the words.
#define LANGUAGE_RECOGNIZED "Recognized (1)"
/// You are familiar with this language enough to sort of speak it, but cannot understand it very well.
#define LANGUAGE_FAMILIAR "Familiar (2)"
/// You are fluent in this language, and can both understand and speak it perfectly.
#define LANGUAGE_FLUENT "Fluent (3)"
/// Maximum number of additional languages that can be selected.
#define MAX_LANGUAGE_POINTS 4

#define NOT_SYNTHETIC FALSE
#define IS_SYNTHETIC TRUE
