// Use to play cinematics.
// Watcher can be world,mob, or a list of mobs
// Blocks until sequence is done.
/proc/Cinematic(id,watcher,datum/callback/special_callback)
	var/datum/cinematic/playing
	for(var/V in subtypesof(/datum/cinematic))
		var/datum/cinematic/C = V
		if(initial(C.id) == id)
			playing = new V()
			break
	if(!playing)
		CRASH("Cinematic type not found")
	if(special_callback)
		playing.special_callback = special_callback
	if(watcher == world)
		playing.is_global = TRUE
		watcher = GLOB.mob_list
	playing.play(watcher)
	qdel(playing)

/atom/movable/screen/cinematic
	icon = 'icons/effects/station_explosion.dmi'
	icon_state = "station_intact"
	plane = SPLASHSCREEN_PLANE
	layer = SPLASHSCREEN_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "BOTTOM,LEFT+50%"
	appearance_flags = APPEARANCE_UI | TILE_BOUND

/datum/cinematic
	var/id = CINEMATIC_DEFAULT
	var/list/watching = list() //List of clients watching this
	var/list/locked = list() //Who had notransform set during the cinematic
	var/is_global = FALSE //Global cinematics will override mob-specific ones
	var/atom/movable/screen/cinematic/screen
	var/datum/callback/special_callback //For special effects synced with animation (explosions after the countdown etc)
	var/cleanup_time = 300 //How long for the final screen to remain
	var/stop_ooc = TRUE //Turns off ooc when played globally.

/datum/cinematic/New()
	screen = new(src)

/datum/cinematic/Destroy()
	for(var/CC in watching)
		if(!CC)
			continue
		var/client/C = CC
		C.mob.clear_fullscreen("cinematic")
		C.screen -= screen
	watching = null
	QDEL_NULL(screen)
	QDEL_NULL(special_callback)
	for(var/MM in locked)
		if(!MM)
			continue
		var/mob/M = MM
		M.notransform = FALSE
	locked = null
	return ..()

/datum/cinematic/proc/play(watchers)
	//Check if cinematic can actually play (stop mob cinematics for global ones)
	if(SEND_GLOBAL_SIGNAL(COMSIG_GLOB_PLAY_CINEMATIC, src) & COMPONENT_GLOB_BLOCK_CINEMATIC)
		return

	//We are now playing this cinematic

	//Handle what happens when a different cinematic tries to play over us
	RegisterSignal(SSdcs, COMSIG_GLOB_PLAY_CINEMATIC, PROC_REF(replacement_cinematic))

	//Pause OOC
	var/ooc_toggled = FALSE
	if(is_global && stop_ooc && GLOB.ooc_allowed)
		ooc_toggled = TRUE
		toggle_ooc(FALSE)

	//Place /atom/movable/screen/cinematic into everyone's screens, prevent them from moving
	for(var/MM in watchers)
		var/mob/M = MM
		show_to(M, M.client)
		RegisterSignal(M, COMSIG_MOB_CLIENT_LOGIN, PROC_REF(show_to))
		//Close watcher ui's
		SStgui.close_user_uis(M)

	//Actually play it
	content()

	//Cleanup
	sleep(cleanup_time)

	//Restore OOC
	if(ooc_toggled)
		toggle_ooc(TRUE)

/datum/cinematic/proc/show_to(mob/M, client/C)
	SIGNAL_HANDLER

	if(!M.notransform)
		locked += M
		M.notransform = TRUE //Should this be done for non-global cinematics or even at all ?
	if(!C)
		return
	watching += C
	M.overlay_fullscreen("cinematic",/atom/movable/screen/fullscreen/cinematic_backdrop)
	C.screen += screen

//Sound helper
/datum/cinematic/proc/cinematic_sound(s)
	if(is_global)
		SEND_SOUND(world,s)
	else
		for(var/C in watching)
			SEND_SOUND(C,s)

//Fire up special callback for actual effects synchronized with animation (eg real nuke explosion happens midway)
/datum/cinematic/proc/special()
	if(special_callback)
		special_callback.Invoke()

//Actual cinematic goes in here
/datum/cinematic/proc/content()
	sleep(50)

/datum/cinematic/proc/replacement_cinematic(datum/source, datum/cinematic/other)
	SIGNAL_HANDLER

	if(!is_global && other.is_global) //Allow it to play if we're local and it's global
		return NONE
	return COMPONENT_GLOB_BLOCK_CINEMATIC

/datum/cinematic/nuke_win
	id = CINEMATIC_NUKE_WIN

/datum/cinematic/nuke_win/content()
	flick("intro_nuke",screen)
	sleep(35)
	flick("station_explode_fade_red",screen)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	screen.icon_state = "summary_nukewin"

/datum/cinematic/nuke_miss
	id = CINEMATIC_NUKE_MISS

/datum/cinematic/nuke_miss/content()
	flick("intro_nuke",screen)
	sleep(35)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	flick("station_intact_fade_red",screen)
	screen.icon_state = "summary_nukefail"

/datum/cinematic/nuke_selfdestruct
	id = CINEMATIC_SELFDESTRUCT

/datum/cinematic/nuke_selfdestruct/content()
	flick("intro_nuke",screen)
	sleep(35)
	flick("station_explode_fade_red", screen)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	screen.icon_state = "summary_selfdes"

/datum/cinematic/nuke_selfdestruct_miss
	id = CINEMATIC_SELFDESTRUCT_MISS

/datum/cinematic/nuke_selfdestruct_miss/content()
	flick("intro_nuke",screen)
	sleep(35)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	screen.icon_state = "station_intact"

/datum/cinematic/malf
	id = CINEMATIC_MALF

/datum/cinematic/malf/content()
	flick("intro_malf",screen)
	sleep(76)
	flick("station_explode_fade_red",screen)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	screen.icon_state = "summary_malf"

/datum/cinematic/nuke_annihilation
	id = CINEMATIC_ANNIHILATION

/datum/cinematic/nuke_annihilation/content()
	flick("intro_nuke",screen)
	sleep(35)
	flick("station_explode_fade_red",screen)
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
	screen.icon_state = "summary_totala"

/datum/cinematic/fake
	id = CINEMATIC_NUKE_FAKE
	cleanup_time = 100

/datum/cinematic/fake/content()
	flick("intro_nuke",screen)
	sleep(35)
	cinematic_sound(sound('sound/items/bikehorn.ogg'))
	flick("summary_selfdes",screen) //???
	special()

/datum/cinematic/no_core
	id = CINEMATIC_NUKE_NO_CORE
	cleanup_time = 100

/datum/cinematic/no_core/content()
	flick("intro_nuke",screen)
	sleep(35)
	flick("station_intact",screen)
	cinematic_sound(sound('sound/ambience/signal.ogg'))
	sleep(100)

/datum/cinematic/nuke_far
	id = CINEMATIC_NUKE_FAR
	cleanup_time = 0

/datum/cinematic/nuke_far/content()
	cinematic_sound(sound('sound/effects/explosion_distant.ogg'))
	special()
