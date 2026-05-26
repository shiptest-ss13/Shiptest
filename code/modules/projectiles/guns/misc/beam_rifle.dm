
#define ZOOM_LOCK_AUTOZOOM_FREEMOVE 0
#define ZOOM_LOCK_AUTOZOOM_ANGLELOCK 1
#define ZOOM_LOCK_CENTER_VIEW 2
#define ZOOM_LOCK_OFF 3

#define AUTOZOOM_PIXEL_STEP_FACTOR 48

// #define AIMING_BEAM_ANGLE_CHANGE_THRESHOLD 0.1

/obj/item/gun/energy/beam_rifle
	name = "particle acceleration rifle"
	desc = "An energy-based anti material marksman rifle that uses highly charged particle beams moving at extreme velocities to decimate whatever is unfortunate enough to be targeted by one. \
		<span class='boldnotice'>Hold down left click while scoped to aim, when weapon is fully aimed (Tracer goes from red to green as it charges), release to fire. Moving while aiming or \
		changing where you're pointing at while aiming will delay the aiming process depending on how much you changed.</span>"
	icon = 'icons/obj/guns/energy.dmi'
	icon_state = "esniper"
	item_state = "esniper"
	fire_sound = 'sound/weapons/beam_sniper.ogg'
	slot_flags = ITEM_SLOT_BACK
	force = 15
	custom_materials = null
	recoil = 4
	ammo_x_offset = 3
	ammo_y_offset = 3
	modifystate = FALSE
	charge_sections = 1
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/beam_rifle/hitscan)
	internal_magazine = FALSE
	default_ammo_type = /obj/item/stock_parts/cell/gun/large
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/large,
	)
	gun_firemodes = list(FIREMODE_AIMED)
	default_firemode = FIREMODE_AIMED
	var/delay = 25

/obj/item/gun/energy/beam_rifle/debug
	delay = 0
	default_ammo_type = /obj/item/stock_parts/cell/infinite
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/infinite,
	)
	aiming_time = 0
	recoil = 0

/obj/item/gun/energy/beam_rifle/Initialize()
	. = ..()
	fire_delay = delay

/obj/item/gun/energy/beam_rifle/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chambered = null
	recharge_newshot()

/obj/item/ammo_casing/energy/beam_rifle
	name = "particle acceleration lens"
	desc = "Don't look into barrel!"

/obj/item/ammo_casing/energy/beam_rifle/hitscan
	projectile_type = /obj/projectile/beam/beam_rifle/hitscan
	select_name = "beam"
	e_cost = 10000
	fire_sound = 'sound/weapons/beam_sniper.ogg'

/obj/projectile/beam/beam_rifle
	name = "particle beam"
	icon = null
	hitsound = 'sound/effects/explosion3.ogg'
	damage = 0
	damage_type = BURN
	flag = "energy"
	range = 150
	jitter = 10 SECONDS

/obj/projectile/beam/beam_rifle/on_hit(atom/target, blocked, piercing_hit)
	. = ..()
	explosion(target,0,1,3,3,flame_range = 3)

/obj/projectile/beam/beam_rifle/hitscan
	icon_state = ""
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/tracer/beam_rifle
