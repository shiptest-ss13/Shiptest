// #define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "shuttles\amogus_sus.dmm"
		#include "shuttles\bar_ship.dmm"
		#include "shuttles\mining_ship_all.dmm"
		#include "shuttles\whiteship_box.dmm"
		#include "shuttles\whiteship_delta.dmm"
		#include "shuttles\whiteship_meta.dmm"
		#include "shuttles\whiteship_midway.dmm"
		#include "shuttles\whiteship_pubby.dmm"
		#ifdef CIBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
