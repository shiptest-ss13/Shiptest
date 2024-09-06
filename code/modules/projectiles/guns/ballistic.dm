#define EMPTY_GUN_HELPER(gun_type)				\
	/obj/item/gun/ballistic/##gun_type/no_mag {	\
		default_ammo_type = null;				\
	}

///Subtype for any kind of ballistic gun
///This has a shitload of vars on it, and I'm sorry for that, but it does make making new subtypes really easy
/obj/item/gun/ballistic
	desc = "Now comes in flavors like GUN. Uses 10mm ammo, for some reason."
	name = "projectile gun"
	w_class = WEIGHT_CLASS_NORMAL

	has_safety = TRUE
	safety = TRUE

	min_recoil = 0.1

	valid_attachments = list(
		/obj/item/attachment/silencer,
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 26,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 18,
		)
	)

/obj/item/gun/ballistic/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, burst_firing = FALSE, spread_override = 0, iteration = 0)
	. = ..() //The gun actually firing
	postfire_empty_checks(.)

///Gets the number of bullets in the gun
/obj/item/gun/ballistic/get_ammo_count(countchambered = TRUE)
	var/rounds = 0
	if (chambered && countchambered)
		rounds++
	if (magazine)
		rounds += magazine?.ammo_count()
	return rounds

/obj/item/gun/ballistic/get_max_ammo(countchamber = TRUE)
	var/rounds = 0
	rounds = magazine?.max_ammo
	if(countchamber)
		rounds += 1
	return rounds

///gets a list of every bullet in the gun
/obj/item/gun/ballistic/get_ammo_list(countchambered = TRUE, drop_all = FALSE)
	var/list/rounds = list()
	if(chambered && countchambered)
		rounds.Add(chambered)
		if(drop_all)
			chambered = null
	rounds.Add(magazine.ammo_list(drop_all))
	return rounds

///used for sawing guns, causes the gun to fire without the input of the user
/obj/item/gun/ballistic/blow_up(mob/user)
	. = FALSE
	for(var/obj/item/ammo_casing/AC in magazine.stored_ammo)
		if(AC.BB)
			process_fire(user, user, FALSE)
			. = TRUE
