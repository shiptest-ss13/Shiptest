#define RUINTYPE_SPACE "Space"
#define RUINTYPE_LAVA "Lava"
#define RUINTYPE_ICE "Ice"
#define RUINTYPE_SAND "Sand"
#define RUINTYPE_JUNGLE "Jungle"
#define RUINTYPE_ROCK "Rock"
#define RUINTYPE_BEACH "Beach"
#define RUINTYPE_WASTE "Waste"
#define RUINTYPE_YELLOW "Yellow"

/// do not actually use this for your ruin type, this is for the ruintype_to_list proc
#define RUINTYPE_EVERYTHING "Everything"

// HEY LISTEN!
// IF YOU ADD NEW A NEW RUIN TYPE
// PLEASE MAKE SURE YOU ADD IT TO THE BELOW LIST AND PROC!

#define RUINTYPE_LIST_ALL list(\
	RUINTYPE_SPACE,\
	RUINTYPE_LAVA,\
	RUINTYPE_ICE,\
	RUINTYPE_SAND,\
	RUINTYPE_JUNGLE,\
	RUINTYPE_ROCK,\
	RUINTYPE_BEACH,\
	RUINTYPE_WASTE,\
	RUINTYPE_YELLOW,\
	RUINTYPE_EVERYTHING)

/proc/ruintype_to_list(ruintype)
	switch(ruintype)
		if(RUINTYPE_SPACE)
			return SSmapping.space_ruins_templates
		if(RUINTYPE_LAVA)
			return SSmapping.lava_ruins_templates
		if(RUINTYPE_ICE)
			return SSmapping.ice_ruins_templates
		if(RUINTYPE_SAND)
			return SSmapping.sand_ruins_templates
		if(RUINTYPE_JUNGLE)
			return SSmapping.jungle_ruins_templates
		if(RUINTYPE_ROCK)
			return SSmapping.rock_ruins_templates
		if(RUINTYPE_BEACH)
			return SSmapping.beach_ruins_templates
		if(RUINTYPE_WASTE)
			return SSmapping.waste_ruins_templates
		if(RUINTYPE_YELLOW)
			return SSmapping.yellow_ruins_templates
		if(RUINTYPE_EVERYTHING)
			return SSmapping.ruins_templates
		else
			CRASH("Unknown ruin type")
