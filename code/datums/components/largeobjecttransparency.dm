///Makes large icons partially see through if high priority atoms are behind them.
/datum/component/largetransparency
	//Can be positive or negative. Determines how far away from parent the first registered turf is.
	var/x_offset
	var/y_offset
	//Has to be positive or 0.
	var/x_size
	var/y_size
	//The alpha values this switches in between.
	var/initial_alpha
	var/target_alpha
	//if this is supposed to prevent clicks if it's transparent.
	var/toggle_click
	var/list/registered_turfs
	var/amounthidden = 0

/datum/component/largetransparency/Initialize(_x_offset = 0, _y_offset = 1, _x_size = 0, _y_size = 1, _initial_alpha = null, _target_alpha = 140, _toggle_click = TRUE)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	x_offset = _x_offset
	y_offset = _y_offset
	x_size = _x_size
	y_size = _y_size
	if(isnull(_initial_alpha))
		var/atom/at = parent
		initial_alpha = at.alpha
	else
		initial_alpha = _initial_alpha
	target_alpha = _target_alpha
	toggle_click = _toggle_click
	registered_turfs = list()


/datum/component/largetransparency/Destroy()
	registered_turfs.Cut()
	return ..()

/datum/component/largetransparency/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/on_move)
	register_with_turfs()

/datum/component/largetransparency/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	unregister_with_turfs()

/datum/component/largetransparency/proc/register_with_turfs()
	var/turf/current_tu = get_turf(parent)
	if(!current_tu)
		return
	var/turf/lowleft_tu = locate(clamp(current_tu.x + x_offset, 0, world.maxx), clamp(current_tu.y + y_offset, 0, world.maxy), current_tu.z)
	var/turf/upright_tu = locate(min(lowleft_tu.x + x_size, world.maxx), min(lowleft_tu.y + y_size, world.maxy), current_tu.z)
	registered_turfs = block(lowleft_tu, upright_tu) //small problems with z level edges but nothing gamebreaking.
	//register the signals
	for(var/regist_tu in registered_turfs)
		if(!regist_tu)
			continue
		RegisterSignal(regist_tu, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_CREATED), .proc/object_enter)
		RegisterSignal(regist_tu, COMSIG_ATOM_EXITED, .proc/object_leave)
		RegisterSignal(regist_tu, COMSIG_TURF_CHANGE, .proc/on_turf_change)
		for(var/thing in regist_tu)
			var/atom/check_atom = thing
			if(!(check_atom.flags_1 & SHOW_BEHIND_LARGE_ICONS_1))
				continue
			amounthidden++
	if(amounthidden)
		reduce_alpha()

/datum/component/largetransparency/proc/unregister_with_turfs()
	var/list/signal_list = list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_EXITED, COMSIG_TURF_CHANGE, COMSIG_ATOM_CREATED)
	for(var/regist_tu in registered_turfs)
		UnregisterSignal(regist_tu, signal_list)
	registered_turfs.Cut()

/datum/component/largetransparency/proc/on_move()
	SIGNAL_HANDLER
	amounthidden = 0
	restore_alpha()
	unregister_with_turfs()
	register_with_turfs()

/datum/component/largetransparency/proc/on_turf_change()
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, .proc/on_move), 1, TIMER_UNIQUE|TIMER_OVERRIDE) //*pain

/datum/component/largetransparency/proc/object_enter(datum/source, atom/enterer)
	SIGNAL_HANDLER
	if(!(enterer.flags_1 & SHOW_BEHIND_LARGE_ICONS_1))
		return
	if(!amounthidden)
		reduce_alpha()
	amounthidden++

/datum/component/largetransparency/proc/object_leave(datum/source, atom/leaver, direction)
	SIGNAL_HANDLER
	if(!(leaver.flags_1 & SHOW_BEHIND_LARGE_ICONS_1))
		return
	amounthidden = max(0, amounthidden - 1)
	if(!amounthidden)
		restore_alpha()

/datum/component/largetransparency/proc/reduce_alpha()
	var/atom/par_atom = parent
	par_atom.alpha = target_alpha
	if(toggle_click)
		par_atom.mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/datum/component/largetransparency/proc/restore_alpha()
	var/atom/par_atom = parent
	par_atom.alpha = initial_alpha
	if(toggle_click)
		par_atom.mouse_opacity = initial(par_atom.mouse_opacity)
