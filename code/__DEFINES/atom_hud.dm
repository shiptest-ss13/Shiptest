// for secHUDs and medHUDs and variants. The number is the location of the image on the list hud_list
// note: if you add more HUDs, even for non-human atoms, make sure to use unique numbers for the defines!
// /datum/atom_hud expects these to be unique
// these need to be strings in order to make them associative lists
/// dead, alive, sick, health status
#define HEALTH_HUD "1"
/// a simple line rounding the mob's number health
#define STATUS_HUD "2"
/// the job asigned to your ID
#define ID_HUD "3"
/// wanted, released, parroled, security status
#define WANTED_HUD "4"
/// loyality implant
#define IMPLOYAL_HUD "5"
/// chemical implant
#define IMPCHEM_HUD "6"
/// tracking implant
#define IMPTRACK_HUD "7"
/// Silicon/Mech/Circuit Status
#define DIAG_STAT_HUD "8"
/// Silicon health bar
#define DIAG_HUD "9"
/// Borg/Mech/Circutry power meter
#define DIAG_BATT_HUD "10"
/// Mech health bar
#define DIAG_MECH_HUD "11"
/// Bot HUDs
#define DIAG_BOT_HUD "12"
/// Circuit assembly health bar
#define DIAG_CIRCUIT_HUD "13"
/// Mech/Silicon tracking beacon, Circutry long range icon
#define DIAG_TRACK_HUD "14"
/// Airlock shock overlay
#define DIAG_AIRLOCK_HUD "15"
/// Bot path indicators
#define DIAG_PATH_HUD "16"
/// Gland indicators for abductors
#define GLAND_HUD "17"
#define SENTIENT_DISEASE_HUD "18"
#define AI_DETECT_HUD "19"
#define NANITE_HUD "20"
#define DIAG_NANITE_FULL_HUD "21"
/// Displays launchpads' targeting reticle
#define DIAG_LAUNCHPAD_HUD "22"
//for antag huds. these are used at the /mob level
#define ANTAG_HUD "23"
// for fans to identify pins
#define FAN_HUD "24"

//by default everything in the hud_list of an atom is an image
//a value in hud_list with one of these will change that behavior
#define HUD_LIST_LIST 1

//data HUD (medhud, sechud) defines
//Don't forget to update human/New() if you change these!
#define DATA_HUD_SECURITY_BASIC "sec_basic"
#define DATA_HUD_SECURITY_ADVANCED "sec_adv"
#define DATA_HUD_MEDICAL_BASIC "med_basic"
#define DATA_HUD_MEDICAL_ADVANCED "med_adv"
#define DATA_HUD_DIAGNOSTIC_BASIC "diag_basic"
#define DATA_HUD_DIAGNOSTIC_ADVANCED "diag_adv"
#define DATA_HUD_ABDUCTOR "abductor_data"
#define DATA_HUD_SENTIENT_DISEASE "disease"
#define DATA_HUD_AI_DETECT "ai_detect"
#define DATA_HUD_FAN "fan"

//antag HUD defines
#define ANTAG_HUD_REV "rev"
#define ANTAG_HUD_OPS "ops"
#define ANTAG_HUD_WIZ "wiz"
#define ANTAG_HUD_SHADOW "shadow"
#define ANTAG_HUD_TRAITOR "traitor"
#define ANTAG_HUD_NINJA "ninja"
#define ANTAG_HUD_CHANGELING "changeling"
#define ANTAG_HUD_ABDUCTOR "abductor_antag"
#define ANTAG_HUD_BROTHER "brother"
#define ANTAG_HUD_OBSESSED "obsessed"
#define ANTAG_HUD_FUGITIVE "fugitive"
#define ANTAG_HUD_GANGSTER "gangster"
#define ANTAG_HUD_SPACECOP "spacecop"


// Notification action types
#define NOTIFY_JUMP "jump"
#define NOTIFY_ATTACK "attack"
#define NOTIFY_ORBIT "orbit"

/// cooldown for being shown the images for any particular data hud
#define ADD_HUD_TO_COOLDOWN 20
