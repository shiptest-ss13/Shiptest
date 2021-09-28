// orbital period of an object w/ semi-major axis of 1 AU around an object of 1 solar mass
#define STD_ORBIT_TIME (1 MINUTES)

// the relative mass of the sun compared to "1" mass
#define SOLAR_MASS 1

#define ONE_AU 1

// we can calculate G using our choice of units like so
#define NORM_GRAV_CONSTANT (((2 * PI * ONE_AU / STD_ORBIT_TIME)**2)/SOLAR_MASS)

// DEBUG REMOVE
#define SYS_GENMODE_NORMAL (0)
#define SYS_GENMODE_PERIAP (1 << 0)
#define SYS_GENMODE_ZEROPER (1 << 1)
#define SYS_GENMODE_OCWISE (1 << 2)
#define SYS_GENMODE_OCCWISE (1 << 3)
