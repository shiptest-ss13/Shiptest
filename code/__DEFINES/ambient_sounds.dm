#define AMBIENCE_GENERIC 1
#define AMBIENCE_SHIP_GENERIC 2
#define AMBIENCE_GENERIC_ENGINE 3
#define AMBIENCE_GENERIC_BRIDGE 4
#define AMBIENCE_GENERIC_MAINTENANCE 5
#define AMBIENCE_SHIP_GENERIC_LARGE 6
#define AMBIENCE_HITECH_BRIDGE 7
#define AMBIENCE_SHIP_DECREPIT 8
#define AMBIENCE_DECREPIT_ENGINE 9
#define AMBIENCE_DECREPIT_BRIDGE 10
#define AMBIENCE_DECREPIT_MAINTENANCE 11
#define AMBIENCE_SHIP_DECREPIT_LARGE 12
#define AMBIENCE_BEACH 13
#define AMBIENCE_OCEAN 14
#define AMBIENCE_ICE 15
#define AMBIENCE_JUNGLE 16
#define AMBIENCE_LAVA 17
#define AMBIENCE_ROCK 18
#define AMBIENCE_SAND 19
#define AMBIENCE_SAND_SCRAP 20
#define AMBIENCE_WASTE 21
#define AMBIENCE_HIGHSEC 22
#define AMBIENCE_RUINS 23
#define AMBIENCE_ENGINEERING 24
#define AMBIENCE_SPOOKY 25
#define AMBIENCE_MAINTENANCE 26
#define AMBIENCE_CREEPY 27
#define AMBIENCE_HUM 28
#define AMBIENCE_FIRE_SMALL 29
#define AMBIENCE_FIRE_LARGE 30
#define AMBIENCE_CAVE 31

#define TOTAL_AMBIENT_SOUNDS 31 //KEEP THIS UP TO DATE!


#define AMBIENCE_SWEEP_TIME 3 SECONDS

#define AMBIENCE_QUEUE_TIME 4 SECONDS

#define MAX_AMBIENCE_RANGE 5
#define MAX_DISTANCE_AMBIENCE_SOUND 6

#define AMBIENCE_FALLOFF_DISTANCE 2
#define AMBIENCE_FALLOFF_EXPONENT 1

#define SHIP_AMBIENCE_VOLUME 0

/// For hallucinations
GLOBAL_LIST_INIT(creepy_ambience,list(
	'sound/effects/ghost.ogg', 'sound/effects/ghost2.ogg',
	'sound/effects/heart_beat.ogg', 'sound/effects/screech.ogg',
	'sound/hallucinations/behind_you1.ogg', 'sound/hallucinations/behind_you2.ogg',
	'sound/hallucinations/far_noise.ogg', 'sound/hallucinations/growl1.ogg',
	'sound/hallucinations/growl2.ogg', 'sound/hallucinations/growl3.ogg',
	'sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg',
	'sound/hallucinations/i_see_you1.ogg', 'sound/hallucinations/i_see_you2.ogg',
	'sound/hallucinations/look_up1.ogg', 'sound/hallucinations/look_up2.ogg',
	'sound/hallucinations/over_here1.ogg', 'sound/hallucinations/over_here2.ogg',
	'sound/hallucinations/over_here3.ogg', 'sound/hallucinations/turn_around1.ogg',
	'sound/hallucinations/turn_around2.ogg', 'sound/hallucinations/veryfar_noise.ogg',
	'sound/hallucinations/wail.ogg'))
