// Byond direction defines, because I want to put them somewhere.
// #define NORTH 1
// #define SOUTH 2
// #define EAST 4
// #define WEST 8

#define TEXT_NORTH "[NORTH]"
#define TEXT_SOUTH "[SOUTH]"
#define TEXT_EAST "[EAST]"
#define TEXT_WEST "[WEST]"

/// Inverse direction, taking into account UP|DOWN if necessary.
#define REVERSE_DIR(dir) (((dir & 85) << 1) | ((dir & 170) >> 1))


/// Create directional subtypes for a path to simplify mapping.

#define MAPPING_DIRECTIONAL_HELPERS(path, offset) ##path/directional/north {\
	dir = NORTH; \
	pixel_y = offset; \
} \
##path/directional/south {\
	dir = SOUTH; \
	pixel_y = -offset; \
} \
##path/directional/east {\
	dir = EAST; \
	pixel_x = offset; \
} \
##path/directional/west {\
	dir = WEST; \
	pixel_x = -offset; \
}
