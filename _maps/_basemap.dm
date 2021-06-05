// #define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\Salvage\Salvage.dmm"
		#include "map_files\Amogus\Amogus.dmm"
		#include "map_files\Diner\Diner.dmm"
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
