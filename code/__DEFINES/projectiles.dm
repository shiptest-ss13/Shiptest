// check_pierce() return values
/// Default behavior: hit and delete self
#define PROJECTILE_PIERCE_NONE 0
/// Hit the thing but go through without deleting. Causes on_hit to be called with pierced = TRUE
#define PROJECTILE_PIERCE_HIT 1
/// Entirely phase through the thing without ever hitting.
#define PROJECTILE_PIERCE_PHASE 2
// Delete self without hitting
#define PROJECTILE_DELETE_WITHOUT_HITTING 3

#define PROJECTILE_BONUS_DAMAGE_NONE 0
#define PROJECTILE_BONUS_DAMAGE_MINERALS (1<<0) //minable walls
#define PROJECTILE_BONUS_DAMAGE_WALLS (1<<1) // walls
#define PROJECTILE_BONUS_DAMAGE_RWALLS (1<<2) //reinforced walls

//vibes based bullet speed

#define BULLET_SPEED_SHOTGUN 0.5
#define BULLET_SPEED_HANDGUN 0.4
#define BULLET_SPEED_REVOLVER 0.4 //why do we have multiple defines for the same thing? future proofing.
#define BULLET_SPEED_PDW 0.3
#define BULLET_SPEED_RIFLE 0.3
#define BULLET_SPEED_SNIPER 0.2

//speed modifiers
#define BULLET_SPEED_AP_MOD -0.05
#define BULLET_SPEED_HP_MOD 0.05
#define BULLET_SPEED_RUBBER_MOD 0.1
#define BULLET_SPEED_HV_MOD -0.1
#define BULLET_SPEED_SURPLUS_MOD 0.05

