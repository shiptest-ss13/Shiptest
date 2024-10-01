/// Index for all cables, so that powernets don't have to look through the entire world all the time
GLOBAL_LIST_EMPTY(cable_list)
/// list of all /obj/effect/portal
GLOBAL_LIST_EMPTY(portals)
/// List of all airlocks
GLOBAL_LIST_EMPTY(airlocks)
/// List of all mechs. Used by hostile mobs target tracking.
GLOBAL_LIST_EMPTY(mechas_list)
/// NOTE: this is a list of ALL machines now. The processing machines list is SSmachine.processing!
GLOBAL_LIST_EMPTY(machines)
/// List of all bot nagivation beacons, used for patrolling.
GLOBAL_LIST_EMPTY(navbeacons)
/// List of all tracking beacons used by teleporters
GLOBAL_LIST_EMPTY(teleportbeacons)
/// List of all MULEbot delivery beacons.
GLOBAL_LIST_EMPTY(deliverybeacons)
/// List of all tags associated with delivery beacons.
GLOBAL_LIST_EMPTY(deliverybeacontags)
/// List of all navigation beacons used by wayfinding pinpointers
GLOBAL_LIST_EMPTY(wayfindingbeacons)
/// List of all navigation beacons used by wayfinding pinpointers
GLOBAL_LIST_EMPTY(nuke_list)
/// List of all machines or programs that can display station alerts
GLOBAL_LIST_EMPTY(alarmdisplay)
/// List of all singularities (actually technically all engines)
GLOBAL_LIST_EMPTY(singularities)
/// List of all fax machines
GLOBAL_LIST_EMPTY(fax_machines)
/// List of all /datum/chemical_reaction datums. Used during chemical reactions
GLOBAL_LIST(chemical_reactions_list)
/// List of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
GLOBAL_LIST(chemical_reagents_list)
/// List of all /datum/material datums indexed by material id.
GLOBAL_LIST_EMPTY(materials_list)
/// List of all /datum/tech datums indexed by id.
GLOBAL_LIST_EMPTY(tech_list)
/// List of all surgeries by name, associated with their path.
GLOBAL_LIST_EMPTY(surgeries_list)
/// List of all table craft recipes
GLOBAL_LIST_EMPTY(crafting_recipes)
/// List of Rapid Construction Devices.
GLOBAL_LIST_EMPTY(rcd_list)
/// List of all Area Power Controller machines, separate from machines for powernet speeeeeeed.
GLOBAL_LIST_EMPTY(apcs_list)
/// List of all current implants that are tracked to work out what sort of trek everyone is on.
GLOBAL_LIST_EMPTY(tracked_implants)
/// List of implants the prisoner console can track and send inject commands too
GLOBAL_LIST_EMPTY(tracked_chem_implants)
/// List of all pinpointers. Used to change stuff they are pointing to all at once.
GLOBAL_LIST_EMPTY(pinpointer_list)
/// List of all zombie_infection organs, for any mass "animation"
GLOBAL_LIST_EMPTY(zombie_infection_list)
/// List of all meteors.
GLOBAL_LIST_EMPTY(meteor_list)
/// List of active radio jammers
GLOBAL_LIST_EMPTY(active_jammers)

GLOBAL_LIST_EMPTY(ladders)

GLOBAL_LIST_EMPTY(trophy_cases)

/// This is a global list of all signs you can change an existing sign or new sign backing to, when using a pen on them.
GLOBAL_LIST_EMPTY(editable_sign_types)

GLOBAL_LIST_EMPTY(wire_color_directory)

GLOBAL_LIST_EMPTY(wire_name_directory)

GLOBAL_LIST_EMPTY(ai_status_displays)
/// List of All mob_spawn objects
GLOBAL_LIST_EMPTY(mob_spawners)
/// List of Station alert consoles, /obj/machinery/computer/station_alert
GLOBAL_LIST_EMPTY(alert_consoles)
