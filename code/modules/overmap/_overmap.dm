// DEBUG FIX -- flesh this out and move it out of town
/datum/overmap_system
	var/name = "System"
	var/list/datum/overmap_ent/entities = list()

/datum/overmap_system/New(genmode)
	. = ..()
	populate_system(genmode)

/datum/overmap_system/Destroy()
	clear_system()
	. = ..()

// DEBUG FIX -- turn this into a unified framework for entity spawning + system generation
// also get rid of genmode before production
/datum/overmap_system/proc/populate_system(genmode = 0)
	var/datum/overmap_ent/sun = new /datum/overmap_ent(list(0,0))
	sun.AddComponent(/datum/component/overmap/circle_vis, 0.125*DIST_AU, "#F6DE01")
	sun.AddComponent(/datum/component/overmap/physics, 1*MASS_SOLAR)
	entities.Add(sun)

	var/desired_planets = 3
	var/num_planets = 0

	var/datum/overmap_ent/cur_planet
	var/datum/component/overmap/physics/planet_phys_comp

	while(num_planets < desired_planets)
		cur_planet = new(list(0,0))
		cur_planet.AddComponent(/datum/component/overmap/circle_vis, 0.03*DIST_AU, COLOR_SILVER)
		planet_phys_comp = cur_planet.AddComponent(/datum/component/overmap/physics, 0.003 * MASS_SOLAR)

		// DEBUG FIX -- update these to more interesting and varied possibilities
		var/s_m = pick(list(0.3871, 0.7233, 1, 1.5273)) * DIST_AU
//		var/s_m = pick(list(1, 1.5273, 5.2028, 9.5388, 19.1914, 30.0611))
//		var/ecc = pick(0.205630, 0.006772, 0.0167086, 0.0934, 0.0489, 0.0565, 0.046381, 0.008678)
		var/ecc = rand(0, 400) / 1000
		var/ccwise = prob(50)
		var/arg_of_p = rand(0, 359)
		var/anomaly = rand(0, 359) // note that this technically unfairly biases start locations near periapsis

		// DEBUG REMOVE -- ALL THE GENMODE STUFF
		if(genmode & SYS_GENMODE_OCWISE)
			ccwise = FALSE
		else if(genmode & SYS_GENMODE_OCCWISE)
			ccwise = TRUE
		if(genmode & SYS_GENMODE_ZEROPER)
			arg_of_p = 0
		if(genmode & SYS_GENMODE_PERIAP)
			anomaly = 0

		cur_planet.AddComponent(/datum/component/overmap/orbit_line, s_m, ecc, ccwise, arg_of_p)

		planet_phys_comp.set_up_orbit(sun, s_m, ecc, ccwise, arg_of_p, anomaly)
		entities.Add(cur_planet)
		num_planets++

/datum/overmap_system/proc/clear_system()
	for(var/entity in entities)
		entities.Remove(entity)
		qdel(entity)

/*
console -> {
	(console_info)
	systems_info: {
		REF(system): system -> {
			name: blahblahblah
			color: blahblahblah
			body_info: {
				REF(body): body -> {
					name: blahblah
					position: blahblah
					components: {
						component.overmap_ui_comp_id: component -> {
							velocity: blahblah
						}
					}
				}
			}
		}
		REF(system2): system2 -> {
			name: foofoofoo
			color: barbarbar
			etc.
		}
	}
}
merging vs. separation of static vs. dynamic data
	merging:
		+consistent with functional paradigm
		+well-encapsulated: JS doesn't "know" static data from dynamic data
		-maybe perf heavy
		-have to write
	separation:
		+maybe easier on the DM end?
		+allows us to do pseudo-diffing -- "static" data always resets, "dynamic" data always merges
		-interferes with functional paradgim
*/

/datum/overmap_system/proc/get_body_data(user, list/options)
	. = list()

	for(var/E in entities)
		var/datum/overmap_ent/entity = E
		var/entity_data = entity.get_body_data(user)
		if(!entity_data) // entity_data might be falsey, such as if the entity isn't known to the user; if so, it is omitted entirely.
			continue	// if we don't omit, then the client might "know" about bodies the user hasn't detected. this is bad and insecure
		.[REF(entity)] = entity_data


/datum/overmap_ent
	/// The name of the overmap entity. Need not be unique; should not be treated as such.
	var/name = "overmap entity"

	// position
	var/pos_x
	var/pos_y

/datum/overmap_ent/New(list/pos_list)
	. = ..()
	if(pos_list)
		pos_x = pos_list[1]
		pos_y = pos_list[2]

// DEBUG FIX -- maybe add functionality to this, explain why it's here
/datum/overmap_ent/proc/is_known_to_user(user)
	return TRUE

/datum/overmap_ent/proc/get_body_data(user, list/options)
	if(!is_known_to_user(user))
		return FALSE
	. = list()

	.["name"] = name
	.["position"] = list(pos_x, pos_y)

	.["components"] = list()
	// every component that registers this signal adds their ui data to the passed list
	SEND_SIGNAL(src, COMSIG_OVERMAP_GET_UI_DATA, .["components"])

/datum/overmap_ent/proc/get_dist_to(datum/overmap_ent/other)
	return sqrt((pos_x - other.pos_x)**2 + (pos_y - other.pos_y)**2)
