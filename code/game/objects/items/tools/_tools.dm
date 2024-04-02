// Time added to tool operations in percent based on original time
// (if you dig hole in 10 seconds then 50 ADDITIONAL_TIME_LOWHEALTH will add 0 on full health, 2.5sec on 50% health and 5sec ~0% health)
#define ADDITIONAL_TIME_LOWHEALTH 60

/obj/item/tool
	name = "tool"
	icon = 'icons/obj/tools.dmi'
	slot_flags = SLOT_BELT
	force = WEAPON_FORCE_NORMAL
	throwforce = WEAPON_FORCE_NORMAL
	w_class = ITEM_SIZE_SMALL

/*
	//spawn values
	bad_type = /obj/item/tool
	spawn_tags = SPAWN_TAG_TOOL

	price_tag = 20

	health = 600
	maxHealth = 600

	var/tool_in_use = FALSE

	var/force_upgrade_mults = 1

	var/force_upgrade_mods = 0

	var/sparks_on_use = FALSE	//Set to TRUE if you want to have sparks on each use of a tool
	var/eye_hazard = FALSE	//Set to TRUE should damage users eyes if they without eye protection

	var/use_power_cost = 0	//For tool system, determinze how much power tool will drain from cells, 0 means no cell needed
	var/obj/item/cell/cell
	var/suitable_cell	//Dont forget to edit this for a tool, if you want in to consume cells
	var/passive_power_cost = 1 //Energy consumed per process tick while active

	var/use_fuel_cost = 0	//Same, only for fuel. And for the sake of God, DONT USE CELLS AND FUEL SIMULTANEOUSLY.
	var/passive_fuel_cost = 0.03 //Fuel consumed per process tick while active
	var/max_fuel = 0

	var/mode = NOMODE //For various tool icon updates.

	//Third type of resource, stock. A tool that uses physical objects (or itself) in order to work
	//Currently used for tape roll
	var/use_stock_cost = 0
	var/stock = 0
	var/max_stock = 0
	var/allow_decimal_stock = TRUE
	var/delete_when_empty = TRUE


	//Variables used for tool degradation
	health = 0		// Health of a tool.
	maxHealth = 1000
	var/degradation = 0.8 //If nonzero, the health of the tool decreases by this amount after each tool operation
	var/health_threshold  = 40 // threshold in percent on which tool health stops dropping
	var/lastNearBreakMessage = 0 // used to show messages that tool is about to break
	var/isBroken = FALSE


	var/toggleable = FALSE	//Determines if it can be switched ON or OFF, for example, if you need a tool that will consume power/fuel upon turning it ON only. Such as welder.
	var/switched_on = FALSE	//Curent status of tool. Dont edit this in subtypes vars, its for procs only.
	var/switched_on_qualities	//This var will REPLACE tool_qualities when tool will be toggled on.
	var/switched_on_force
	var/switched_on_hitsound
	var/switched_off_qualities	//This var will REPLACE tool_qualities when tool will be toggled off. So its possible for tool to have diferent qualities both for ON and OFF state.
	var/create_hot_spot = FALSE	 //Set this TRUE to ignite plasma on turf with tool upon activation
	var/glow_color	//Set color of glow upon activation, or leave it null if you dont want any light
	var/last_tooluse = 0 //When the tool was last used for a tool operation. This is set both at the start of an operation, and after the doafter call

	//Vars for tool upgrades
	var/precision = 0	//Subtracted from failure rates
	var/workspeed = 1	//Worktimes are divided by this
	var/extra_bulk = 0 	//Extra physicial volume added by certain mods
	var/list/prefixes = list()
*/

/obj/item/proc/has_quality(quality_id)
	return !quality_id || (quality_id in tool_qualities)

/obj/item/tool/admin_debug
	name = "Electric Boogaloo 3000"
	icon_state = "omnitool"
	item_state = "omnitool"
	spawn_tags = null
	tool_qualities = list(QUALITY_BOLT_TURNING = 100,
							QUALITY_PRYING = 100,
							QUALITY_WELDING = 100,
							QUALITY_SCREW_DRIVING = 100,
							QUALITY_CLAMPING = 100,
							QUALITY_CAUTERIZING = 100,
							QUALITY_WIRE_CUTTING = 100,
							QUALITY_RETRACTING = 100,
							QUALITY_DRILLING = 100,
							QUALITY_SAWING = 100,
							QUALITY_VEIN_FIXING = 100,
							QUALITY_BONE_SETTING = 100,
							QUALITY_BONE_FIXING = 100,
							QUALITY_SHOVELING = 100,
							QUALITY_DIGGING = 100,
							QUALITY_EXCAVATION = 100,
							QUALITY_CUTTING = 100,
							QUALITY_HAMMERING = 100,
							QUALITY_FILING = 100)

/obj/item/tool/hammer
	name = "ballpin hammer"
	icon_state = "oldcrowbar"
	tool_qualities = (QUALITY_HAMMERING = 50)

/obj/item/tool/file
	name = "metal file"
	icon_state = "oldwrench"
	tool_qualities = (QUALITY_FILING = 50)

/obj/item/tool/saw
	name = "rusty hacksaw"
	icon_state = "oldcutters_map"
	tool_qualities = (QUALITY_SAWING = 50)
