// Helpers for checking whether a z-level conforms to a specific requirement

// Basic levels
#define is_centcom_level(atom) atom.virtual_level_trait(ZTRAIT_CENTCOM)

#define is_reserved_level(atom) atom.virtual_level_trait(ZTRAIT_RESERVED)

#define is_away_level(atom) atom.virtual_level_trait(ZTRAIT_AWAY)
