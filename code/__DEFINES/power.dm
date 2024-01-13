/*WS - Smartwire Revertie Boys
#define CABLE_LAYER_1 1
#define CABLE_LAYER_2 2
#define CABLE_LAYER_3 4
*/

#define MACHINERY_LAYER_1 1

#define SOLAR_TRACK_OFF 0
#define SOLAR_TRACK_TIMED 1
#define SOLAR_TRACK_AUTO 2

#define TESLA_DEFAULT_POWER 1738260
#define TESLA_MINI_POWER 869130

#define LIGHT_DRAW 10 // mulitplied by brightness, typically 4-8

#define IDLE_DRAW_MINIMAL 50 // 20x = 1kw, used for small things and computers on stand-by
#define IDLE_DRAW_LOW 200 //5x = 1kw, used for always-active computers
#define IDLE_DRAW_MEDIUM 500 //2x = 1kw
#define IDLE_DRAW_HIGH 1000 //1kw

#define ACTIVE_DRAW_MINIMAL 200 //5x = 1kw
#define ACTIVE_DRAW_LOW 500 //2x = 1kw
#define ACTIVE_DRAW_MEDIUM 1000 //microwaves use this
#define ACTIVE_DRAW_HIGH 2000
#define ACTIVE_DRAW_EXTREME 5000 //highest this value should be in most cases
