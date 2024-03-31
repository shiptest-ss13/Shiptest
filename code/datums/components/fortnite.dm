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
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
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


/datum/component/fortnite/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_NAME, PROC_REF(update_prefix))
	RegisterSignal(parent, COMSIG_GUN_BEFORE_FIRING, PROC_REF(adjust_bullet_stats))

/datum/component/fortnite/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_UPDATE_NAME, COMSIG_GUN_BEFORE_FIRING))
	var/obj/modifying_thing = parent
	modifying_thing.remove_filter("fortnite")

/datum/component/fortnite/proc/get_rarity(force_rarity)
	var/dont_loot_gen
	if(force_rarity)
		rarity = force_rarity
		return

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
		if(RARITY_TABLE_DEFAULT || RARITY_TABLE_ALWAYS_COMMON || RARITY_TABLE_ALWAYS_UNCOMMON_TO_LEGEND_ONLY)
			switch(rarity)
				if(FORTNITE_RARITY_UNCOMMON)
					damage_bonus = 3
				if(FORTNITE_RARITY_RARE)
					damage_bonus = 6
				if(FORTNITE_RARITY_EPIC)
					damage_bonus = 10
				if(FORTNITE_RARITY_LEGENDARY)
					damage_bonus = 15
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
		current_gun.chambered.BB.damage += damage_bonus//smiles
