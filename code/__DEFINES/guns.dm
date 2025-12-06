//Gun weapon weight
/// Allows you to dual wield this gun and your offhand gun
#define WEAPON_LIGHT 1
/// Does not allow you to dual wield with this gun and your offhand gun
#define WEAPON_MEDIUM 2
/// You must wield the gun to fire this gun
#define WEAPON_HEAVY 3
/// You must FULLY wield (wait the full wield delay) the gun to fire this gun
#define WEAPON_VERY_HEAVY 4
//Gun trigger guards
#define TRIGGER_GUARD_ALLOW_ALL -1
#define TRIGGER_GUARD_NONE 0
#define TRIGGER_GUARD_NORMAL 1
//Gun bolt types
///Gun has a bolt, it stays closed while not cycling. The gun must be racked to have a bullet chambered when a mag is inserted.
/// Example: c20, shotguns, m90
#define BOLT_TYPE_STANDARD 1
///Gun has a bolt, it is open when ready to fire. The gun can never have a chambered bullet with no magazine, but the bolt stays ready when a mag is removed.
/// Example: Some SMGs, the L6
#define BOLT_TYPE_OPEN 2
///Gun has no moving bolt mechanism, it cannot be racked. Also dumps the entire contents when emptied instead of a magazine.
/// Example: Break action shotguns, revolvers
#define BOLT_TYPE_NO_BOLT 3
///Gun has a bolt, it locks back when empty. It can be released to chamber a round if a magazine is in.
/// Example: Pistols with a slide lock, some SMGs
#define BOLT_TYPE_LOCKING 4
///Gun has an HK-style locking charging handle, so you can slap it. Only use this for flavor, otherwise modern-style automatics should use BOLT_TYPE_LOCKING.
/// Example: everything made by lanchester
#define BOLT_TYPE_CLIP 5
//Sawn off nerfs
///accuracy penalty of sawn off guns
#define SAWN_OFF_ACC_PENALTY 25
///added recoil of sawn off guns
#define SAWN_OFF_RECOIL 1

//Autofire component
/// Compatible firemode is in the gun. Wait until it's held in the user hands.
#define AUTOFIRE_STAT_IDLE (1<<0)
/// Gun is active and in the user hands. Wait until user does a valid click.
#define AUTOFIRE_STAT_ALERT (1<<1)
/// Gun is shooting.
#define AUTOFIRE_STAT_FIRING (1<<2)

#define COMSIG_AUTOFIRE_ONMOUSEDOWN "autofire_onmousedown"
	#define COMPONENT_AUTOFIRE_ONMOUSEDOWN_BYPASS (1<<0)
#define COMSIG_AUTOFIRE_SHOT "autofire_shot"
	#define COMPONENT_AUTOFIRE_SHOT_SUCCESS (1<<0)

#define SUPPRESSED_NONE 0
#define SUPPRESSED_QUIET 1 ///standard suppressed
#define SUPPRESSED_VERY 2 /// no message

#define DUALWIELD_PENALTY_EXTRA_MULTIPLIER 1.6

#define MANUFACTURER_NONE null
#define MANUFACTURER_SHARPLITE "the Sharplite Defense logo"
#define MANUFACTURER_SHARPLITE_NEW "the Nanotrasen-Sharplite logo"
#define MANUFACTURER_HUNTERSPRIDE "the Hunter's Pride Arms and Ammunition logo"
#define MANUFACTURER_SOLARARMORIES "the Solarbundswaffenkammer emblem"
#define MANUFACTURER_SCARBOROUGH "the Scarborough Arms logo"
#define MANUFACTURER_EOEHOMA "the Eoehoma Firearms emblem"
#define MANUFACTURER_NANOTRASEN_OLD "an outdated Nanotrasen logo"
#define MANUFACTURER_NANOTRASEN "the Nanotrasen logo"
#define MANUFACTURER_VIGILITAS "the Nanotrasen Advantage logo"
#define MANUFACTURER_BRAZIL "a green flag with a blue circle and a yellow diamond around it"
#define MANUFACTURER_INTEQ "an orange crest with the letters 'IRMG'"
#define MANUFACTURER_MINUTEMAN "the Lanchester City Firearms Plant logo"
#define MANUFACTURER_MINUTEMAN_LASER "the Clover Photonics logo"
#define MANUFACTURER_DONKCO "the Donk! Co. logo"
#define MANUFACTURER_PGF "the Etherbor Industries emblem"
#define MANUFACTURER_IMPORT "Lanchester Import Co."
#define MANUFACTURER_SERENE "the Serene Outdoors logo"

// Misfire chances if the gun's safety is off
#define GUN_NO_SAFETY_MALFUNCTION_CHANCE_LOW 5
#define GUN_NO_SAFETY_MALFUNCTION_CHANCE_MEDIUM 10
#define GUN_NO_SAFETY_MALFUNCTION_CHANCE_HIGH 15

//aiming down sights values
#define PISTOL_ZOOM 2
#define SHOTGUN_ZOOM 2
#define SMG_ZOOM 2
#define RIFLE_ZOOM 2
#define DMR_ZOOM 6

//ads slowdown
#define PISTOL_AIM_SLOWDOWN 0.1
#define SHOTGUN_AIM_SLOWDOWN 0.3
#define SMG_AIM_SLOWDOWN 0.2
#define RIFLE_AIM_SLOWDOWN 0.3
#define LONG_RIFLE_AIM_SLOWDOWN 0.4
#define HEAVY_AIM_SLOWDOWN 0.6

//slowdown defines
#define NO_SLOWDOWN 0.0
#define LIGHT_PISTOL_SLOWDOWN 0.05
#define PISTOL_SLOWDOWN 0.1
#define REVOLVER_SLOWDOWN 0.15
#define HEAVY_REVOLVER_SLOWDOWN 0.2
#define PDW_SLOWDOWN 0.25
#define SMG_SLOWDOWN 0.3
#define SHOTGUN_SLOWDOWN 0.4
#define HEAVY_SHOTGUN_SLOWDOWN 0.45
#define LIGHT_RIFLE_SLOWDOWN 0.45
#define RIFLE_SLOWDOWN 0.55
#define HEAVY_RIFLE_SLOWDOWN 0.6
#define DMR_SLOWDOWN 0.6
#define SAW_SLOWDOWN 0.7
#define LIGHT_SNIPER_SLOWDOWN 0.75
#define SNIPER_SLOWDOWN 0.9
#define HMG_SLOWDOWN 1
#define AMR_SLOWDOWN 1


//laser slowdown
#define LASER_PISTOL_SLOWDOWN 0.05
#define LASER_SMG_SLOWDOWN 0.2
#define LASER_RIFLE_SLOWDOWN 0.35
#define HEAVY_LASER_RIFLE_SLOWDOWN 0.45
#define LASER_SNIPER_SLOWDOWN 0.6


/////////////////
// ATTACHMENTS //
/////////////////
#define TRAIT_ATTACHABLE "attachable"

#define COMSIG_ATTACHMENT_ATTACH "attach-attach"
#define COMSIG_ATTACHMENT_DETACH "attach-detach"
#define COMSIG_ATTACHMENT_EXAMINE "attach-examine"
#define COMSIG_ATTACHMENT_EXAMINE_MORE "attach-examine-more"
#define COMSIG_ATTACHMENT_PRE_ATTACK "attach-pre-attack"
#define COMSIG_ATTACHMENT_AFTER_ATTACK "attach-after-attack"
#define COMSIG_ATTACHMENT_ATTACK "attach-attacked"
#define COMSIG_ATTACHMENT_WIELD "attach-wield"
#define COMSIG_ATTACHMENT_UNWIELD "attach-unwield"
#define COMSIG_ATTACHMENT_UPDATE_OVERLAY "attach-overlay"
#define COMSIG_ATTACHMENT_UNIQUE_ACTION "attach-unique-action"
#define COMSIG_ATTACHMENT_CTRL_CLICK "attach-ctrl-click"
#define COMSIG_ATTACHMENT_ALT_CLICK "attach-alt-click"
#define COMSIG_ATTACHMENT_ATTACK_HAND "attach-attack-hand"

#define COMSIG_ATTACHMENT_TOGGLE "attach-toggle"

#define COMSIG_ATTACHMENT_GET_SLOT "attach-slot-who"
#define COMSIG_ATTACHMENT_CHANGE_SLOT "change_attach_slot"
#define ATTACHMENT_SLOT_MUZZLE "muzzle"
#define ATTACHMENT_SLOT_SCOPE "scope"
#define ATTACHMENT_SLOT_GRIP "grip"
#define ATTACHMENT_SLOT_RAIL "rail"
#define ATTACHMENT_SLOT_STOCK "stock"

/proc/attachment_slot_to_bflag(slot)
	switch(slot)
		if(ATTACHMENT_SLOT_MUZZLE)
			return (1<<0)
		if(ATTACHMENT_SLOT_SCOPE)
			return (1<<1)
		if(ATTACHMENT_SLOT_GRIP)
			return (1<<2)
		if(ATTACHMENT_SLOT_RAIL)
			return (1<<3)
		if(ATTACHMENT_SLOT_STOCK)
			return (1<<4)

/proc/attachment_slot_from_bflag(slot)
	switch(slot)
		if(1<<0)
			return ATTACHMENT_SLOT_MUZZLE
		if(1<<1)
			return ATTACHMENT_SLOT_SCOPE
		if(1<<2)
			return ATTACHMENT_SLOT_GRIP
		if(1<<3)
			return ATTACHMENT_SLOT_RAIL
		if(1<<4)
			return ATTACHMENT_SLOT_STOCK

#define ATTACHMENT_DEFAULT_SLOT_AVAILABLE list( \
	ATTACHMENT_SLOT_MUZZLE = 1, \
	ATTACHMENT_SLOT_SCOPE = 1, \
	ATTACHMENT_SLOT_GRIP = 1, \
	ATTACHMENT_SLOT_RAIL = 1, \
	ATTACHMENT_SLOT_STOCK = 1, \
)

//attach_features_flags
/// Removable by hand
#define ATTACH_REMOVABLE_HAND (1<<0)
/// Removable via crowbar
#define ATTACH_REMOVABLE_TOOL (1<<1)
#define ATTACH_TOGGLE (1<<2)
#define ATTACH_NO_SPRITE (1<<3)

/////////////////
// PROJECTILES //
/////////////////

//bullet_act() return values
#define BULLET_ACT_HIT "HIT" //It's a successful hit, whatever that means in the context of the thing it's hitting.
#define BULLET_ACT_BLOCK "BLOCK" //It's a blocked hit, whatever that means in the context of the thing it's hitting.
#define BULLET_ACT_FORCE_PIERCE "PIERCE"	//It pierces through the object regardless of the bullet being piercing by default.

#define NICE_SHOT_RICOCHET_BONUS 10 //if the shooter has the NICE_SHOT trait and they fire a ricocheting projectile, add this to the ricochet chance and auto aim angle

//ammo box sprite defines
///ammo box will always use provided icon state
#define AMMO_BOX_ONE_SPRITE 0
///ammo box will have a different state for each bullet; <icon_state>-<bullets left>
#define AMMO_BOX_PER_BULLET 1
///ammo box will have a different state for full and empty; <icon_state>-max_ammo and <icon_state>-0
#define AMMO_BOX_FULL_EMPTY 2

//Projectile Reflect
#define REFLECT_NORMAL (1<<0)
#define REFLECT_FAKEPROJECTILE (1<<1)

#define MOVES_HITSCAN -1		//Not actually hitscan but close as we get without actual hitscan.
#define MUZZLE_EFFECT_PIXEL_INCREMENT 17	//How many pixels to move the muzzle flash up so your character doesn't look like they're shitting out lasers.

#define FIREMODE_SEMIAUTO "single"
#define FIREMODE_BURST "burst"
#define FIREMODE_FULLAUTO "auto"
#define FIREMODE_OTHER "other"
#define FIREMODE_OTHER_TWO "other2"
#define FIREMODE_UNDERBARREL "underbarrel"

#define GUN_LEFTHAND_ICON 'icons/mob/inhands/weapons/guns_lefthand.dmi'
#define GUN_RIGHTHAND_ICON 'icons/mob/inhands/weapons/guns_righthand.dmi'
