#define PROGRESSBAR_HEIGHT 6
#define PROGRESSBAR_ANIMATION_TIME 5

/datum/progressbar
	///The progress bar visual element.
	var/image/bar
	///The target where this progress bar is applied and where it is shown.
	var/atom/bar_loc
	///The mob whose client sees the progress bar.
	var/mob/user
	///The client seeing the progress bar.
	var/client/user_client
	///Effectively the number of steps the progress bar will need to do before reaching completion.
	var/goal = 1
	///Control check to see if the progress was interrupted before reaching its goal.
	var/last_progress = 0
	///Variable to ensure smooth visual stacking on multiple progress bars.
	var/listindex = 0
	///The type of our last value for bar_loc, for debugging
	var/location_type

/datum/progressbar/New(mob/User, goal_number, atom/target)
	. = ..()
	if (!istype(target))
		EXCEPTION("Invalid target given")
	if(QDELETED(User) || !istype(User))
		stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] user")
		qdel(src)
		return
	if(!isnum(goal_number))
		stack_trace("/datum/progressbar created with [isnull(User) ? "null" : "invalid"] goal_number")
		qdel(src)
		return
	goal = goal_number
	bar_loc = target
	location_type = bar_loc.type
	bar = image('icons/effects/progressbar.dmi', bar_loc, "prog_bar_0", HUD_LAYER)
	bar.plane = ABOVE_HUD_PLANE
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	user = User

	LAZYADDASSOCLIST(user.progressbars, bar_loc, src)
	var/list/bars = user.progressbars[bar_loc]
	listindex = bars.len

	if(user.client)
		user_client = user.client
		add_prog_bar_image_to_client()

	RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(on_user_delete))
	RegisterSignal(user, COMSIG_MOB_LOGOUT, PROC_REF(clean_user_client))
	RegisterSignal(user, COMSIG_MOB_LOGIN, PROC_REF(on_user_login))


/datum/progressbar/Destroy()
	if(user)
		for(var/pb in user.progressbars[bar_loc])
			var/datum/progressbar/progress_bar = pb
			if(progress_bar == src || progress_bar.listindex <= listindex)
				continue
			progress_bar.listindex--

			progress_bar.bar.pixel_y = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1))
			var/dist_to_travel = 32 + (PROGRESSBAR_HEIGHT * (progress_bar.listindex - 1)) - PROGRESSBAR_HEIGHT
			animate(progress_bar.bar, pixel_y = dist_to_travel, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

		LAZYREMOVEASSOC(user.progressbars, bar_loc, src)
		user = null

	if(user_client)
		clean_user_client()

	bar_loc = null

	if(bar)
		QDEL_NULL(bar)

	return ..()


///Called right before the user's Destroy()
/datum/progressbar/proc/on_user_delete(datum/source)
	SIGNAL_HANDLER

	user.progressbars = null //We can simply nuke the list and stop worrying about updating other prog bars if the user itself is gone.
	user = null
	qdel(src)


///Removes the progress bar image from the user_client and nulls the variable, if it exists.
/datum/progressbar/proc/clean_user_client(datum/source)
	SIGNAL_HANDLER

	if(!user_client) //Disconnected, already gone.
		return
	user_client.images -= bar
	user_client = null


///Called by user's Login(), it transfers the progress bar image to the new client.
/datum/progressbar/proc/on_user_login(datum/source)
	SIGNAL_HANDLER

	if(user_client)
		if(user_client == user.client) //If this was not client handling I'd condemn this sanity check. But clients are fickle things.
			return
		clean_user_client()
	if(!user.client) //Clients can vanish at any time, the bastards.
		return
	user_client = user.client
	add_prog_bar_image_to_client()


///Adds a smoothly-appearing progress bar image to the player's screen.
/datum/progressbar/proc/add_prog_bar_image_to_client()
	bar.pixel_y = 0
	bar.alpha = 0
	user_client.images += bar
	animate(bar, pixel_y = 32 + (PROGRESSBAR_HEIGHT * (listindex - 1)), alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)


///Updates the progress bar image visually.
/datum/progressbar/proc/update(progress)
	progress = clamp(progress, 0, goal)
	if(progress == last_progress)
		return
	last_progress = progress
	bar.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"


///Called on progress end, be it successful or a failure. Wraps up things to delete the datum and bar.
/datum/progressbar/proc/end_progress()
	if(last_progress != goal)
		bar.icon_state = "[bar.icon_state]_fail"

	animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)

	QDEL_IN(src, PROGRESSBAR_ANIMATION_TIME)

///Progress bars are very generic, and what hangs a ref to them depends heavily on the context in which they're used
///So let's make hunting harddels easier yeah?
/datum/progressbar/dump_harddel_info()
	return "Owner's type: [location_type]"


/datum/world_progressbar
	///The progress bar visual element.
	var/obj/effect/abstract/progbar/bar
	///The atom who "created" the bar
	var/atom/movable/owner
	///Effectively the number of steps the progress bar will need to do before reaching completion.
	var/goal = 1
	///Control check to see if the progress was interrupted before reaching its goal.
	var/last_progress = 0
	///Variable to ensure smooth visual stacking on multiple progress bars.
	var/listindex = 0
	///Does this qdelete on completion?
	var/qdel_when_done = TRUE

/datum/world_progressbar/New(atom/movable/_owner, _goal, image/underlay)
	if(!_owner)
		return

	owner = _owner
	goal = _goal

	bar = new()

	if(underlay)
		if(!istype(underlay))
			underlay = image(underlay, dir = SOUTH)
			underlay.filters += filter(type = "outline", size = 1)

		underlay.pixel_y += 2
		underlay.alpha = 200
		underlay.plane = GAME_PLANE
		underlay.layer = FLY_LAYER
		underlay.appearance_flags = APPEARANCE_UI
		bar.underlays += underlay

	owner:vis_contents += bar

	animate(bar, alpha = 255, time = PROGRESSBAR_ANIMATION_TIME, easing = SINE_EASING)

	RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(owner_delete))

/datum/world_progressbar/Destroy()
	owner = null
	QDEL_NULL(bar)
	return ..()


/datum/world_progressbar/proc/owner_delete()
	qdel(src)

///Updates the progress bar image visually.
/datum/world_progressbar/proc/update(progress)
	progress = clamp(progress, 0, goal)
	if(progress == last_progress)
		return
	last_progress = progress
	bar.icon_state = "prog_bar_[round(((progress / goal) * 100), 5)]"

/datum/world_progressbar/proc/end_progress()
	if(last_progress != goal)
		bar.icon_state = "[bar.icon_state]_fail"

	if(qdel_when_done)
		animate(bar, alpha = 0, time = PROGRESSBAR_ANIMATION_TIME)
		QDEL_IN(src, PROGRESSBAR_ANIMATION_TIME)
	else
		bar.icon_state = "prog_bar_0"

#undef PROGRESSBAR_ANIMATION_TIME
#undef PROGRESSBAR_HEIGHT

/obj/effect/abstract/progbar
	icon = 'icons/effects/progressbar.dmi'
	icon_state = "prog_bar_0"
	plane = ABOVE_HUD_PLANE
	appearance_flags = APPEARANCE_UI | KEEP_APART
	pixel_y = 32
	alpha = 0
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	vis_flags = NONE //We don't want VIS_INHERIT_PLANE
