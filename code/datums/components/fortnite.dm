#define FORTNITE_RARITY_COMMON "Common"
#define FORTNITE_RARITY_UNCOMMON "Uncommon"
#define FORTNITE_RARITY_RARE "Rare"
#define FORTNITE_RARITY_EPIC "Epic"
#define FORTNITE_RARITY_LEGENDARY "Legendary"

#define RARITY_TABLE_DEFAULT 0
#define RARITY_TABLE_ALWAYS_COMMON 1
#define RARITY_TABLE_ALWAYS_UNCOMMON_TO_LEGEND_ONLY 2
#define RARITY_TABLE_ALWAYS_RARE_TO_LEGEND_ONLY 3
#define RARITY_TABLE_ALWAYS_EPIC_TO_LEGEND_ONLY 4

/**
 * Fortnite component
 *
 * When applied to an item it attempt to simulate the fortnite/super animal royale rarity system
 *
 */

/datum/component/fortnite
	/// Only one of the component can exist on an item
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS
	///our current rarity
	var/rarity = FORTNITE_RARITY_COMMON
	///do we edit the prefix of the item
	var/edit_prefix = TRUE
	///do we fuck with the bullet damage
	var/adjust_bullet_stats = TRUE
	///what do we use to determine rarity
	var/rarity_table = RARITY_TABLE_DEFAULT
	//current rarity list
	var/list/rarity_list
	///color of prefix/outline
	var/rarity_color

/datum/component/fortnite/Initialize(force_rarity=FALSE, _edit_prefix = TRUE , _adjust_bullet_stats = TRUE, _rarity_table = RARITY_TABLE_DEFAULT)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	edit_prefix = _edit_prefix
	adjust_bullet_stats = _adjust_bullet_stats
	rarity_table = _rarity_table
	get_rarity(force_rarity)

/datum/component/fortnite/InheritComponent(datum/component/C, i_am_original, force_rarity=FALSE, _edit_prefix = TRUE , _adjust_bullet_stats = TRUE, _rarity_table = RARITY_TABLE_DEFAULT)
	var/obj/modifying_thing = parent
	modifying_thing.remove_filter("fortnite")
	rarity_color = null

	Initialize(force_rarity, _edit_prefix , _adjust_bullet_stats, _rarity_table)

/datum/component/fortnite/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_NAME, PROC_REF(update_prefix))
	RegisterSignal(parent, COMSIG_GUN_BEFORE_FIRING, PROC_REF(adjust_bullet_stats))

/datum/component/fortnite/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_UPDATE_NAME, COMSIG_GUN_BEFORE_FIRING))

/datum/component/fortnite/proc/get_rarity(force_rarity)
	var/dont_loot_gen
	if(force_rarity)
		rarity = force_rarity
		dont_loot_gen = TRUE

	switch(rarity_table)
		if(RARITY_TABLE_ALWAYS_COMMON)
			rarity = FORTNITE_RARITY_COMMON
			dont_loot_gen = TRUE
		if(RARITY_TABLE_DEFAULT)
			rarity_list = list(
				FORTNITE_RARITY_COMMON = 400,
				FORTNITE_RARITY_UNCOMMON = 200,
				FORTNITE_RARITY_RARE = 100,
				FORTNITE_RARITY_EPIC = 10,
				FORTNITE_RARITY_LEGENDARY = 1,
			)
		if(RARITY_TABLE_ALWAYS_UNCOMMON_TO_LEGEND_ONLY)
			rarity_list = list(
				FORTNITE_RARITY_UNCOMMON = 200,
				FORTNITE_RARITY_RARE = 100,
				FORTNITE_RARITY_EPIC = 10,
				FORTNITE_RARITY_LEGENDARY = 1,
			)
		if(RARITY_TABLE_ALWAYS_RARE_TO_LEGEND_ONLY)
			rarity_list = list(
				FORTNITE_RARITY_RARE = 100,
				FORTNITE_RARITY_EPIC = 10,
				FORTNITE_RARITY_LEGENDARY = 1,
			)
		if(RARITY_TABLE_ALWAYS_EPIC_TO_LEGEND_ONLY)
			rarity_list = list(
				FORTNITE_RARITY_EPIC = 10,
				FORTNITE_RARITY_LEGENDARY = 1,
			)
	if(!dont_loot_gen)
		var/picked = pickweight_float(rarity_list)
		rarity = picked
	set_rarity()

/datum/component/fortnite/proc/set_rarity()
	var/obj/modifying_thing = parent
	switch(rarity)
		if(FORTNITE_RARITY_UNCOMMON)
			rarity_color = "#4ca226"
		if(FORTNITE_RARITY_RARE)
			rarity_color = "#008dd4"
		if(FORTNITE_RARITY_EPIC)
			rarity_color = "#8a2be2"
		if(FORTNITE_RARITY_LEGENDARY)
			rarity_color = "#de6e0e"

	modifying_thing.remove_filter("fortnite")
	if(rarity_color)
		modifying_thing.add_filter("fortnite", 5, list("type"="outline", "color"= rarity_color, "size"=1))
	update_prefix()

/datum/component/fortnite/proc/update_prefix()
	var/obj/modifying_thing = parent
	if(rarity_color)
		modifying_thing.name = "<font color='[rarity_color]'>[rarity] [modifying_thing::name]</font>"
	else
		modifying_thing.name = "[rarity] [modifying_thing::name]"

/datum/component/fortnite/proc/adjust_bullet_stats()
	var/obj/item/gun/current_gun = parent
	var/damage_bonus
	switch(rarity_table)
		if(RARITY_TABLE_DEFAULT, RARITY_TABLE_ALWAYS_COMMON, RARITY_TABLE_ALWAYS_UNCOMMON_TO_LEGEND_ONLY)
			switch(rarity)
				if(FORTNITE_RARITY_UNCOMMON)
					damage_bonus = 3
				if(FORTNITE_RARITY_RARE)
					damage_bonus = 6
				if(FORTNITE_RARITY_EPIC)
					damage_bonus = 9
				if(FORTNITE_RARITY_LEGENDARY)
					damage_bonus = 12
		if(RARITY_TABLE_ALWAYS_RARE_TO_LEGEND_ONLY)//the gun is already good anwyays, don't fuck with the stats too much
			switch(rarity)
				if(FORTNITE_RARITY_EPIC)
					damage_bonus = 2.5
				if(FORTNITE_RARITY_LEGENDARY)
					damage_bonus = 5
		if(RARITY_TABLE_ALWAYS_EPIC_TO_LEGEND_ONLY)//ditto
			switch(rarity)
				if(FORTNITE_RARITY_LEGENDARY)
					damage_bonus = 5

	if(current_gun.chambered.BB)
		//unliked 2024, the damage bonus isnt damage, balance nowdays is more dependant on AP, also helps to not have
		current_gun.chambered.BB.armour_penetration += damage_bonus//smiles

//idk where else to put this so rest of the file is unrelated to the component

GLOBAL_LIST_EMPTY(royale_common_loot)
GLOBAL_LIST_EMPTY(royale_rarer_loot)
GLOBAL_LIST_EMPTY(royale_legendary_loot)
/obj/effect/battle_royale
	name = "generic battle royale spawner"

/obj/effect/battle_royale/Initialize(mapload)
	. = ..()
	var/turf/current_turf = get_turf(src)
	var/obj/structure/closet/supplypod/centcompod/pod = new(null, STYLE_BOX)
	pod.bluespace = FALSE

	extra_changes(get_cargo(pod))
	new /obj/effect/pod_landingzone(current_turf, pod)
	return INITIALIZE_HINT_QDEL


/obj/effect/battle_royale/proc/get_cargo(pod)
	if(!GLOB.royale_common_loot.len)
		var/list/loot_types_list = subtypesof(/datum/supply_pack)
		for(var/datum/supply_pack/picked_pack as anything in loot_types_list)
			if(!check_type(picked_pack))
				loot_types_list -= picked_pack
		GLOB.royale_common_loot = loot_types_list
	var/datum/supply_pack/picked_cargo = pick(GLOB.royale_common_loot)
	picked_cargo = new picked_cargo

	return picked_cargo.generate(pod)

/obj/effect/battle_royale/proc/extra_changes(obj/thing_to_check)
	var/list/ignore_these = list(
		/obj/item/gun/ballistic/automatic/marksman/taipan,
		/obj/item/gun/ballistic/automatic/assault/hydra/lmg,
		/obj/item/gun/ballistic/automatic/marksman/boomslang,
		/obj/item/gun/ballistic/automatic/hmg,
		/obj/item/gun/energy/laser/e50,
		/obj/item/gun/energy/pulse
		)
	if(!thing_to_check)
		return
	var/list/guns = list()

	for(var/obj/item/item_to_check in thing_to_check.contents)
		if(istype(item_to_check, /obj/item/gun))
			guns += item_to_check
		if(istype(item_to_check, /obj/item/storage/guncase))
			var/obj/item/gun/found_gun = locate(/obj/item/gun) in item_to_check
			if(!istype(found_gun))
				continue
			guns += found_gun

	for(var/obj/item/gun/gun_to_check in guns)
		if(!gun_to_check)
			continue
		for(var/obj/currently_looking as anything in  ignore_these)
			if(istype(gun_to_check,currently_looking))
				break
		gun_to_check.AddComponent(/datum/component/fortnite,force_rarity=FORTNITE_RARITY_COMMON)



/obj/effect/battle_royale/proc/check_type(datum/checking)
	var/list/bad_types = list(
		/datum/supply_pack/gun,
		/datum/supply_pack/ammo,
		/datum/supply_pack/animal,
		/datum/supply_pack/canister,
		/datum/supply_pack/chemistry,
		/datum/supply_pack/civilian,
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/emergency,
		/datum/supply_pack/exploration,
		/datum/supply_pack/food,
		/datum/supply_pack/machinery,
		/datum/supply_pack/material,
		/datum/supply_pack/mech,
		/datum/supply_pack/medical,
		/datum/supply_pack/sec_supply,
		/datum/supply_pack/spacesuits,
		/datum/supply_pack/armor,
		/datum/supply_pack/tools,
		/datum/supply_pack/vendor_refill,
		/datum/supply_pack/gun/skm_lmg,
		/datum/supply_pack/gun/saw80,
		/datum/supply_pack/gun/cm40,
		/datum/supply_pack/gun/shredder,
		/datum/supply_pack/gun/cmf4,
		/datum/supply_pack/gun/ssg04,
		/datum/supply_pack/gun/sbr80,
		/datum/supply_pack/gun/vickland,
		/datum/supply_pack/gun/swiss,
		/datum/supply_pack/gun/skm,
		/datum/supply_pack/gun/inteq_skm,
		/datum/supply_pack/gun/m15,
		/datum/supply_pack/gun/gar,
		/datum/supply_pack/gun/hydra,
		/datum/supply_pack/gun/sidewinder,
		/datum/supply_pack/gun/wt550,
		/datum/supply_pack/gun/amr,
		/datum/supply_pack/gun/f90,
		/datum/supply_pack/gun/ssg669,
		/datum/supply_pack/gun/scout,
//		/datum/supply_pack/gun/illestren_scoped,
		/datum/supply_pack/gun/m12,
		/datum/supply_pack/gun/cm15,
		/datum/supply_pack/gun/mastiff,
		/datum/supply_pack/gun/bulldog,
		/datum/supply_pack/gun/laser/hb7,
		/datum/supply_pack/gun/laser/bgc10,
		/datum/supply_pack/gun/laser/bg16,
		/datum/supply_pack/gun/e40,
		/datum/supply_pack/gun/hades,
		/datum/supply_pack/gun/e50,
		/datum/supply_pack/gun/model_h,
//		/datum/supply_pack/gun/commander_2,
		/datum/supply_pack/gun/cm70,
		/datum/supply_pack/gun/ion,
		/datum/supply_pack/gun/oneshot,
		/datum/supply_pack/gun/huntsman,
		/datum/supply_pack/gun/oneshot/hedp,
		/datum/supply_pack/spacesuits/armored_spacesuit,
		/datum/supply_pack/spacesuits/spacesuit/inteq,
		/datum/supply_pack/spacesuits/spacesuit/solgov,
		/datum/supply_pack/spacesuits/spacesuit/pgf,
		/datum/supply_pack/spacesuits/mining_hardsuit_heavy,
		/datum/supply_pack/spacesuits/heavy_sec_hardsuit,
		/datum/supply_pack/spacesuits/neutron_hardsuit,
		/datum/supply_pack/spacesuits/cmt_hardsuit,
		/datum/supply_pack/spacesuits/pointman_hardsuit,
		/datum/supply_pack/spacesuits/inteq_hardsuit,
		/datum/supply_pack/spacesuits/solar_hardsuit,
		/datum/supply_pack/spacesuits/patroller_hardsuit,
		/datum/supply_pack/spacesuits/spotter_hardsuit,
		/datum/supply_pack/spacesuits/white_red_hardsuit,
		/datum/supply_pack/spacesuits/beige_red_hardsuit,
		/datum/supply_pack/spacesuits/roumain_hardsuit,
		)
	var/list/bad_subtypes = list(
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/vendor_refill,
		/datum/supply_pack/animal,
		/datum/supply_pack/civilian,
		/datum/supply_pack/chemistry,
		/datum/supply_pack/food,
		/datum/supply_pack/mech,
		/datum/supply_pack/food/trickwine
		)

	for(var/datum/supply_pack/checked_datum as anything in bad_subtypes)
		bad_types += subtypesof(checked_datum)

	for(var/datum/checked_datum as anything in bad_types)
		if(checking.type == checked_datum)
			return FALSE

	for(var/datum/checked_datum as anything in bad_subtypes)
		if(istype(checking,checked_datum))
			return FALSE
	return TRUE

/obj/effect/battle_royale/proc/fill_ammo(obj/thing_to_check)
	for(var/obj/item/item_to_check in thing_to_check.contents)
		var/obj/item/ammo_box/our_mag = item_to_check
		if(istype(our_mag))
			our_mag.top_off(starting = TRUE)
		our_mag.update_appearance()

/obj/effect/battle_royale/common
	name = "common battle royale loot spawner"

/obj/effect/battle_royale/rarer
	name = "rare battle royale loot spawner"

/obj/effect/battle_royale/rarer/get_cargo(pod)
	if(!GLOB.royale_rarer_loot.len)
		var/list/bad_subtypes = list(
			/datum/supply_pack/costumes_toys,
			/datum/supply_pack/vendor_refill,
			/datum/supply_pack/animal,
			/datum/supply_pack/civilian,
			/datum/supply_pack/food
			)
		var/list/loot_types_list = subtypesof(/datum/supply_pack)
		for(var/datum/supply_pack/picked_pack as anything in loot_types_list)
			if(!check_type(picked_pack))
				loot_types_list -= picked_pack
			for(var/datum/supply_pack/checked_datum as anything in bad_subtypes)
				if(istype(picked_pack,checked_datum))
					loot_types_list -= picked_pack
					break
		GLOB.royale_rarer_loot = loot_types_list
	var/datum/supply_pack/picked_cargo = pick(GLOB.royale_rarer_loot)
	picked_cargo = new picked_cargo

	return picked_cargo.generate(pod)

/obj/effect/battle_royale/rarer/check_type(datum/checking)
	var/list/bad_types = list(
		/datum/supply_pack/gun,
		/datum/supply_pack/ammo,
		/datum/supply_pack/animal,
		/datum/supply_pack/canister,
		/datum/supply_pack/chemistry,
		/datum/supply_pack/civilian,
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/emergency,
		/datum/supply_pack/exploration,
		/datum/supply_pack/food,
		/datum/supply_pack/machinery,
		/datum/supply_pack/material,
		/datum/supply_pack/mech,
		/datum/supply_pack/medical,
		/datum/supply_pack/sec_supply,
		/datum/supply_pack/spacesuits,
		/datum/supply_pack/armor,
		/datum/supply_pack/tools,
		/datum/supply_pack/vendor_refill
		)
	var/list/bad_subtypes = list(
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/vendor_refill,
		/datum/supply_pack/animal,
		/datum/supply_pack/civilian,
		/datum/supply_pack/chemistry,
		/datum/supply_pack/food
		)
	for(var/datum/supply_pack/checked_datum as anything in bad_subtypes)
		bad_types += subtypesof(checked_datum)

	for(var/datum/checked_datum as anything in bad_types)
		if(checking.type == checked_datum)
			return FALSE

	for(var/datum/checked_datum as anything in bad_subtypes)
		if(istype(checking,checked_datum))
			return FALSE
	return TRUE

/obj/effect/battle_royale/rarer/extra_changes(obj/thing_to_check)
	var/list/ignore_these = list(
		/obj/item/gun/ballistic/automatic/marksman/taipan,
		/obj/item/gun/ballistic/automatic/hmg,
		/obj/item/gun/ballistic/automatic/assault/hydra/lmg,
		/obj/item/gun/energy/laser/e50,
		/obj/item/gun/energy/pulse
		)
	if(!thing_to_check)
		return
	var/list/guns = list()
	for(var/obj/item/item_to_check in thing_to_check.contents)
		if(istype(item_to_check, /obj/item/gun))
			guns += item_to_check
		if(istype(item_to_check, /obj/item/storage/guncase))
			var/obj/item/gun/found_gun = locate(/obj/item/gun) in item_to_check
			if(!istype(found_gun))
				continue
			fill_ammo(thing_to_check)
			fill_ammo(item_to_check)
			guns += found_gun

	for(var/obj/item/gun/gun_to_check in guns)
		if(!gun_to_check)
			continue
		for(var/obj/currently_looking as anything in  ignore_these)
			if(istype(gun_to_check,currently_looking))
				break
		gun_to_check.AddComponent(/datum/component/fortnite,_rarity_table=RARITY_TABLE_ALWAYS_UNCOMMON_TO_LEGEND_ONLY)

/obj/effect/battle_royale/legendary
	name = "legendary battle royale loot spawner"

/obj/effect/battle_royale/legendary/get_cargo(pod)
	if(!GLOB.royale_legendary_loot.len)
		var/list/loot_types_list = subtypesof(/datum/supply_pack/gun)
		for(var/datum/supply_pack/picked_pack as anything in loot_types_list)
			if(!check_type(picked_pack))
				loot_types_list -= picked_pack
		GLOB.royale_legendary_loot = loot_types_list
	var/datum/supply_pack/picked_cargo = pick(GLOB.royale_legendary_loot)
	picked_cargo = new picked_cargo

	return picked_cargo.generate(pod)

/obj/effect/battle_royale/legendary/check_type(datum/checking)
	var/list/bad_types = list(
		/datum/supply_pack/gun,
		/datum/supply_pack/ammo,
		/datum/supply_pack/animal,
		/datum/supply_pack/canister,
		/datum/supply_pack/chemistry,
		/datum/supply_pack/civilian,
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/emergency,
		/datum/supply_pack/exploration,
		/datum/supply_pack/food,
		/datum/supply_pack/machinery,
		/datum/supply_pack/material,
		/datum/supply_pack/mech,
		/datum/supply_pack/medical,
		/datum/supply_pack/sec_supply,
		/datum/supply_pack/spacesuits,
		/datum/supply_pack/armor,
		/datum/supply_pack/tools,
		/datum/supply_pack/vendor_refill,
		/datum/supply_pack/gun/disposable,
		/datum/supply_pack/gun/commanders,
		/datum/supply_pack/gun/commissioner,
		/datum/supply_pack/gun/cm23,
		/datum/supply_pack/gun/candors,
		/datum/supply_pack/gun/ringneck,
		/datum/supply_pack/gun/pc76,
		/datum/supply_pack/gun/laser,
		/datum/supply_pack/gun/pistolec,
		/datum/supply_pack/gun/conflagration,
		/datum/supply_pack/gun/himehabu,
		/datum/supply_pack/gun/detrevolver,
		/datum/supply_pack/gun/pepperbox,
		/datum/supply_pack/gun/ion,
		/datum/supply_pack/gun/e10,
		/datum/supply_pack/gun/ssg669,
		/datum/supply_pack/gun/e11,
		/datum/supply_pack/gun/hellfire_shotgun,
		/datum/supply_pack/gun/brimstone_shotgun,
		/datum/supply_pack/gun/winchester,
		/datum/supply_pack/gun/absolution,
		/datum/supply_pack/gun/m20_auto_elite,
		/datum/supply_pack/gun/oneshot,
		/datum/supply_pack/gun/oneshot/hedp
		)
	var/list/bad_subtypes = list(
		/datum/supply_pack/costumes_toys,
		/datum/supply_pack/vendor_refill,
		/datum/supply_pack/animal,
		/datum/supply_pack/civilian,
		/datum/supply_pack/food
		)

	for(var/datum/supply_pack/checked_datum as anything in bad_subtypes)
		bad_types += subtypesof(checked_datum)

	for(var/datum/checked_datum as anything in bad_types)
		if(checking.type == checked_datum)
			return FALSE

	for(var/datum/checked_datum as anything in bad_subtypes)
		if(istype(checking,checked_datum))
			return FALSE
	return TRUE


/obj/effect/battle_royale/legendary/extra_changes(obj/thing_to_check)
	if(!thing_to_check)
		return
	var/list/guns = list()
	for(var/obj/item/item_to_check in thing_to_check.contents)
		if(istype(item_to_check, /obj/item/gun))
			guns += item_to_check
		if(istype(item_to_check, /obj/item/storage/guncase))
			var/obj/item/gun/found_gun = locate(/obj/item/gun) in item_to_check
			if(!istype(found_gun))
				continue
			fill_ammo(thing_to_check)
			fill_ammo(item_to_check)
			guns += found_gun

	for(var/obj/item/gun/gun_to_check in guns)
		if(!gun_to_check)
			continue
		gun_to_check.AddComponent(/datum/component/fortnite,force_rarity=FORTNITE_RARITY_LEGENDARY)
		if(istype(gun_to_check,/obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/ballistic_to_check = gun_to_check
			if(!ballistic_to_check.internal_magazine)
				for(var/i in 1 to 2)
					var/ammo_type = ballistic_to_check.allowed_ammo_types[1]
					new ammo_type(thing_to_check)
		else if(istype(gun_to_check,/obj/item/gun/energy))
			var/obj/item/gun/energy/energy_to_check = gun_to_check
			if(!energy_to_check.internal_cell)
				for(var/i in 1 to 2)
					var/ammo_type = energy_to_check.allowed_ammo_types[1]
					new ammo_type(thing_to_check)

