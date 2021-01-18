/*\
	Defines for Deep Core mining machines and network flags
\*/

/// REMOTE MINING

//Machine is putting material into the system
#define DCM_TYPE_INPUT (1<<0)
//Machine is taking material out of the system
#define DCM_TYPE_OUTPUT (1<<1)

/// DCM DRILL
#define DCM_NO_VEIN 0		//No ore_vein area detected
#define DCM_OCCUPIED_VEIN 1	//A vein was found, but in-use by a different drill
#define DCM_LOCATED_VEIN 2	//A vein was found and connected to
