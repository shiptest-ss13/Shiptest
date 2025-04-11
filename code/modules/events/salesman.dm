/datum/round_event_control/salesman
	name = "Outpost Salesman"
	typepath = /datum/round_event/ghost_role/salesman
	weight = 0
	earliest_start = 10 MINUTES
	min_players = 0
	max_occurrences = 1

/datum/round_event/ghost_role/salesman
	role_name = "Outpost Salesman"
	minimum_required = 1
	var/salesman_outfit = /datum/outfit/job/independent/cargo_tech
	var/locker = /obj/structure/closet/salesman

/datum/round_event/ghost_role/salesman/spawn_role()
	var/list/candidates = get_candidates(null, null, null)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected = pick_n_take(candidates)

	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/salesman/spawn_point in GLOB.landmarks_list)
		spawn_locs += spawn_point.loc
	if(!spawn_locs.len)
		return MAP_ERROR

	var/spawn_location = pick(spawn_locs)
	var/mob/living/carbon/human/salesman = new(spawn_location)
	selected.client.prefs.copy_to(salesman)
	var/datum/mind/salesman_mind = new /datum/mind(selected.key)
	salesman_mind.assigned_role = role_name
	salesman_mind.special_role = role_name
	salesman_mind.active = TRUE
	salesman_mind.transfer_to(salesman)
	salesman.equipOutfit(salesman_outfit)

	new locker(spawn_location)

	message_admins("[ADMIN_LOOKUPFLW(salesman)] has been made into a salesman by an event.")
	log_game("[key_name(salesman)] was spawned as a salesman by an event.")
	spawned_mobs += salesman
	return SUCCESSFUL_SPAWN

/obj/structure/closet/salesman

/obj/structure/closet/salesman/PopulateContents()
	..()
	var/type = pick("hunters_pride")

	var/list/stuff = list()

	stuff += /obj/item/spacecash/bundle/loadsamoney
	stuff += /obj/item/spacecash/bundle/loadsamoney

	switch(type)
		if("hunters_pride")
			stuff += list(
				/obj/item/gun/ballistic/rifle/illestren,
				/obj/item/gun/ballistic/rifle/illestren,
				/obj/item/gun/ballistic/rifle/scout,
				/obj/item/gun/ballistic/shotgun/doublebarrel,
				/obj/item/gun/ballistic/revolver/detective,
				/obj/item/gun/ballistic/revolver/detective,
				/obj/item/gun/ballistic/revolver/firebrand,
				/obj/item/ammo_box/c38,
				/obj/item/ammo_box/c38,
				/obj/item/ammo_box/magazine/illestren_a850r,
				/obj/item/ammo_box/magazine/illestren_a850r,
				/obj/item/storage/toolbox/ammo/a850r
			)

	for(var/thing in stuff)
		new thing(src)


