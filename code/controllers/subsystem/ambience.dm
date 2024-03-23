/// The subsystem used to play ambience to users every now and then, makes them real excited.
SUBSYSTEM_DEF(ambience)
	name = "Ambience"
	flags = SS_BACKGROUND
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 0.5 SECONDS
	/// List of ambient sound datums we populate
	var/list/ambient_sounds[TOTAL_AMBIENT_SOUNDS]
	/// List of all ambience controllers
	var/list/ambience_controller_list = list()

/datum/controller/subsystem/ambience/Initialize(timeofday)
	for(var/ambience_type in subtypesof(/datum/ambient_sound))
		var/datum/ambient_sound/ambi_cast = ambience_type
		if(!initial(ambi_cast.id))
			continue
		ambi_cast = new ambience_type()
		ambient_sounds[ambi_cast.id] = ambi_cast
	return ..()

/datum/controller/subsystem/ambience/fire(resumed)
	for(var/datum/ambience_controller/ambi_control as anything in ambience_controller_list)
		ambi_control.process()
		if(MC_TICK_CHECK)
			return
