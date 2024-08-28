/// VERY IMPORTANT FOR RUNNING FAST IN PRODUCTION!
/// If you define this flag, centcom will load. It's also supposed to preload planetoids, but that is disabled.
#define FULL_INIT

#ifdef FULL_INIT
	#include "map_files\generic\CentCom.dmm"
#else
	#include "map_files\generic\blank.dmm"
#endif

#ifdef ALL_MAPS
	#ifdef CIBUILDING
		#include "templates.dm"
	#endif
#endif
