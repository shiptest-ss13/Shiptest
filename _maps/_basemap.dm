/// VERY IMPORTANT FOR RUNNING FAST IN PRODUCTION!
/// If you define this flag, more things will init during initializations rather than when they're needed, such as planetoids.
//#define FULL_INIT

#ifdef FULL_INIT
	#include "map_files\generic\CentCom.dmm"
#else
	#include "map_files\generic\blank.dmm"
#endif

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
