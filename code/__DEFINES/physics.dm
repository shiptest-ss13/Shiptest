/// A mass of one ton.
#define MASS_TON 1

/// One solar mass (not necessarily to scale with IRL).
#define MASS_SOLAR (100000000*MASS_TON)

/// A distance of one gigameter.
#define DIST_GM 1

/// A distance of one AU (avg. distance between Sun and Earth).
#define DIST_AU (150*DIST_GM)

/// A force of one ton-gigameter per second squared.
#define FORCE_TON_GM_PER_SEC_SQUARE (MASS_TON*(DIST_GM/(1 SECONDS SECONDS)))

/// The orbital period of an object w/ semi-major axis of 1 AU around an object of 1 solar mass.
#define STD_ORBIT_TIME (1 MINUTES)

// we can calculate G using our choice of units like so
/// The gravitational constant.
#define NORM_GRAV_CONSTANT ((4*(PI**2)*(DIST_AU**3)/(STD_ORBIT_TIME**2))/MASS_SOLAR)

// DEBUG REMOVE
#define SYS_GENMODE_NORMAL (0)
#define SYS_GENMODE_PERIAP (1 << 0)
#define SYS_GENMODE_ZEROPER (1 << 1)
#define SYS_GENMODE_OCWISE (1 << 2)
#define SYS_GENMODE_OCCWISE (1 << 3)
