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

