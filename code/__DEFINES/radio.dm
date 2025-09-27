// Radios use a large variety of predefined frequencies.

//say based modes like binary are in living/say.dm

#define RADIO_CHANNEL_COMMON "Common"
#define RADIO_KEY_COMMON ";"

#define RADIO_CHANNEL_EMERGENCY "Emergency"
#define RADIO_KEY_EMERGENCY "c"
#define RADIO_TOKEN_EMERGENCY ":c"

#define RADIO_CHANNEL_SYNDICATE "Syndicate"
#define RADIO_KEY_SYNDICATE "t"
#define RADIO_TOKEN_SYNDICATE ":t"

#define RADIO_CHANNEL_CENTCOM "CentCom"
#define RADIO_KEY_CENTCOM "e"
#define RADIO_TOKEN_CENTCOM ":e"

#define RADIO_CHANNEL_SOLGOV "SolGov"
#define RADIO_KEY_SOLGOV "s"
#define RADIO_TOKEN_SOLGOV ":s"

#define RADIO_CHANNEL_NANOTRASEN "Nanotrasen"
#define RADIO_KEY_NANOTRASEN "n"
#define RADIO_TOKEN_NANOTRASEN ":n"

#define RADIO_CHANNEL_MINUTEMEN "Minutemen"
#define RADIO_KEY_MINUTEMEN "m"
#define RADIO_TOKEN_MINUTEMEN ":m"

#define RADIO_CHANNEL_PGF "PGF"
#define RADIO_KEY_PGF "g"
#define RADIO_TOKEN_PGF ":g"

#define RADIO_CHANNEL_INTEQ "Inteq"
#define RADIO_KEY_INTEQ "q"
#define RADIO_TOKEN_INTEQ ":q"

#define RADIO_CHANNEL_PIRATE "Pirate"
#define RADIO_KEY_PIRATE "y"
#define RADIO_TOKEN_PIRATE ":y"

#define RADIO_CHANNEL_WIDEBAND "Wideband"

#define MIN_FREE_FREQ 1201 // -------------------------------------------------
// Frequencies are always odd numbers and range from 1201 to 1599.

#define FREQ_SYNDICATE 1213 // Syndicate Coalition comms frequency, dark brown
#define FREQ_CENTCOM 1337 // NT-CentCom comms frequency, gray
#define FREQ_SOLGOV 1345 // SolGov comms frequency, dark blue WS ADDITION
#define FREQ_INTEQ 1347 // Inteq comms frequency, light brown
#define FREQ_PGF 1349 // PGF comms frequency, lime green
#define FREQ_NANOTRASEN 1351 // Nanotrasen comms frequency, plum
#define FREQ_EMERGENCY 1353 // Emergency comms frequency, red
#define FREQ_MINUTEMEN 1355 // Minutemen comms frequency, soft blue
#define FREQ_PIRATE 1359 // Pirate comms frequency, gold

#define FREQ_HOLOGRID_SOLUTION 1433
#define FREQ_STATUS_DISPLAYS 1435
#define FREQ_ATMOS_ALARMS 1437 // air alarms <-> alert computers
#define FREQ_ATMOS_CONTROL 1439 // air alarms <-> vents and scrubbers

#define MIN_FREQ 1441 // ------------------------------------------------------
// Only the 1441 to 1689 range is freely available for general conversation.

#define FREQ_ATMOS_STORAGE 1441
#define FREQ_NAV_BEACON 1445
#define FREQ_PRESSURE_PLATE 1447
#define FREQ_AIRLOCK_CONTROL 1449
#define FREQ_ELECTROPACK 1449
#define FREQ_MAGNETS 1449
#define FREQ_LOCATOR_IMPLANT 1451
#define FREQ_SIGNALER 1457 // the default for new signalers
#define FREQ_COMMON 1459 // Common comms frequency, dark green

#define MAX_FREQ 1689 // ------------------------------------------------------

#define FREQ_WIDEBAND 1691 // sector wide communication

#define MAX_FREE_FREQ 1699 // -------------------------------------------------

// Transmission types.
#define TRANSMISSION_WIRE 0 // some sort of wired connection, not used
#define TRANSMISSION_RADIO 1 // electromagnetic radiation (default)
#define TRANSMISSION_SUBSPACE 2 // subspace transmission (headsets only)
#define TRANSMISSION_SUPERSPACE 3 // reaches independent (CentCom) radios only
#define TRANSMISSION_SECTOR 4 // sector-wide broadcasting units, for cross-sector transmitting but not receiving

// Filter types, used as an optimization to avoid unnecessary proc calls.
#define RADIO_TO_AIRALARM "to_airalarm"
#define RADIO_FROM_AIRALARM "from_airalarm"
#define RADIO_SIGNALER "signaler"
#define RADIO_ATMOSIA "atmosia"
#define RADIO_AIRLOCK "airlock"
#define RADIO_MAGNETS "magnets"

#define DEFAULT_SIGNALER_CODE 30

//Requests Console
#define REQ_NO_NEW_MESSAGE 0
#define REQ_NORMAL_MESSAGE_PRIORITY 1
#define REQ_HIGH_MESSAGE_PRIORITY 2
#define REQ_EXTREME_MESSAGE_PRIORITY 3

#define REQ_DEP_TYPE_ASSISTANCE (1<<0)
#define REQ_DEP_TYPE_SUPPLIES (1<<1)
#define REQ_DEP_TYPE_INFORMATION (1<<2)

//Interference levels
#define INTERFERENCE_LEVEL_BREAKUP_HOLOPADS 30
#define INTERFERENCE_LEVEL_RADIO_PREVENT_ID 50
#define INTERFERENCE_LEVEL_RADIO_STATIC_SOUND 70

///give this to can_receive to specify that there is no restriction on what virtual z level this signal is sent to
#define RADIO_NO_Z_LEVEL_RESTRICTION 0
