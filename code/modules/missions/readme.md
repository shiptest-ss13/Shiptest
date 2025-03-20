# Dynamic Missions

## About
A new advanced type of missions with the core goal of making them more intresting and feeding into our existing loop better. The core premis is to allow mappers to create there own missions specific to there ruin. For example I add three custom missions to the wrecked factory involving recovering data

```dm
/datum/map_template/ruin/lavaland/wrecked_factory
	name = "Wrecked Factory"
	id = "wreck_factory"
	description = "A Nanotrasen processing facility, assaulted by a pirate raid that has killed most of the staff. The offices however, remain unbreached for now."
	suffix = "lavaland_surface_wrecked_factory.dmm"
	ruin_mission_types = list(
		/datum/mission/ruin/nanotrasen_docs,
		/datum/mission/ruin/captain_medal,
		/datum/mission/ruin/brainchip
	)
```

## Adding a mission to a ruin
Assuming you want to add a prexisting mission the process is quite simple. A ruin is preselected and Missions are generated when a planet is first created. But in order for a mission to be able to spawn or find items you need to use landmarks.
The simplest addition of a mission would be something like secret documents in which you map a /obj/effect/landmark/mission_poi/main wherever you want the documents to spawn (It will also need an index if you have multiple missions) 
If you want to make existing doucments the objective you set var/already_spawned TRUE and place the landmark ontop of it.
Then all you need to do is add /datum/mission/ruin/data_reterival to your ruin datums var/ruin_mission_types

## Creating a simple ruin mission
If you want your own cost, item, or other simple tweaks create a subtype. vars like faction and mission_reward support lists which and picked at random from. An example like the frontier termination mission pick one of the rewards in proc/generate_mission_details()

```dm
/datum/mission/ruin/signaled/kill/frontiersmen
	value = 4500
	mission_reward = list(
		/obj/item/gun/ballistic/automatic/pistol/mauler,
		/obj/item/gun/ballistic/automatic/pistol/spitter
	)
	registered_type = /mob/living/simple_animal/hostile/human/frontier/ranged/officer
	setpiece_item = /obj/item/clothing/neck/dogtag/frontier
```

generate_mission_details is useful if you want to add some extra randomization of flavor like here.

```dm
/datum/mission/ruin/nt_files/generate_mission_details()
	. = ..()
	author = "Captain [random_species_name()]"
```

if you need some weird spawning conditions you can use a subtyped landmark to overide the default behavoir of just spawning whatever its passed

```dm
/obj/effect/landmark/mission_poi/main/blackbox/use_poi(_type_to_spawn)
	var/obj/machinery/blackbox_recorder/recorder = ..()
	if(istype(recorder, /obj/machinery/blackbox_recorder))
		if(istype(recorder.stored, /obj/item/blackbox))
			return recorder.stored
```
In this instance we want to spawn a blackbox recorder but we want the actual mission objective to be the blackbox itself so we find it inside it.

### Weird completion requirments
Say you dont just want a fetch quest but instead to complete some sort of basic objective like killing a target or restarting a drill.
the signaled subtype of mission/ruin work well for this

```dm
/datum/mission/ruin/signaled/drill
	name = "drill reinstallment"
	desc = "We have a drill we want turned back on before we send people to get this outpost back up and running. \
			Its a industrial level drill resting ontop of a class 4 vein. \
			We want the seismograph readout it prints out when its done as proof."
	value = 15000
	faction = list(
		/datum/faction/nt,
		/datum/faction/nt/ns_logi,
		/datum/faction/nt/vigilitas,
		/datum/faction/independent
	)
	registered_type = /obj/machinery/drill/mission/ruin
	setpiece_item = /obj/item/drill_readout
	mission_main_signal = COMSIG_DRILL_SAMPLES_DONE
```
mission_main_signal can be any type of signal thats sent out by the registered_type, from things like it moving, dying or specfic things like it finishing its sampling. Upon the mission reciving said signal it spawns the setpiece item and sets it as the required_item (most of this behavoir can be overwritten)
