// Helpers for checking whether a z-level conforms to a specific requirement

// Basic levels
#define is_centcom_level(atom) SSmapping.virtual_level_trait(atom, ZTRAIT_CENTCOM)

#define is_reserved_level(atom) SSmapping.virtual_level_trait(atom, ZTRAIT_RESERVED)

#define is_away_level(atom) SSmapping.virtual_level_trait(atom, ZTRAIT_AWAY)
