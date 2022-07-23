#define GRID_TYPE_EMPTY 0
#define GRID_TYPE_PLUG 1
#define GRID_TYPE_SOCKET 2
#define GRID_TYPE_LINE 3

/client/verb/debug_rnd()
	var/turf/turf = get_turf(mob)
	var/obj/machinery/research_server/serv = new(turf)
	var/obj/machinery/computer/rdconsole/rdc = new(turf)
	var/obj/item/multitool/mult = new(turf)
	mob.put_in_active_hand(mult, TRUE, TRUE)
	mob.ClickOn(serv)
	mob.ClickOn(rdc)
	qdel(mult)
	rdc.ui_interact(mob)

/datum/grid_tile
	var/x
	var/y
	var/id
	var/grid_type

	/// The grid we are contained within
	var/list/grid
	/// Our immediate neighbors which we can connect to
	var/list/neighbors
	/// The list of directions we cannot connect with
	var/list/blocked

/datum/grid_tile/New(grid, x, y, id, grid_type)
	src.grid = grid
	src.x = x
	src.y = y
	src.id = id
	src.grid_type = grid_type
	neighbors = new
	blocked = new

/datum/grid_tile/Destroy(force, ...)
	grid = null
	neighbors.Cut()
	return ..()

/datum/grid_tile/proc/change_id(new_id)
	if(id == new_id)
		return
	id = new_id
	update()

/datum/grid_tile/proc/change_type(new_type)
	if(grid_type == new_type)
		return
	grid_type = new_type
	update()

/datum/grid_tile/proc/update()
	for(var/datum/grid_tile/neighbor as anything in neighbors)
		neighbor = neighbors[neighbor]
		neighbor.refresh()
	refresh()

/datum/grid_tile/proc/can_connect(datum/grid_tile/other)
	if(grid_type == GRID_TYPE_EMPTY)
		return FALSE
	if(id != other.id)
		return FALSE
	if(grid_type == other.grid_type)
		return grid_type == GRID_TYPE_LINE
	if(other.grid_type == GRID_TYPE_EMPTY)
		return FALSE
	return TRUE

/datum/grid_tile/proc/refresh()
	neighbors.Cut()
	for(var/dir in (GLOB.cardinals - blocked))
		var/tx = x
		var/ty = y
		switch(dir)
			if(NORTH)
				ty++
			if(SOUTH)
				ty--
			if(EAST)
				tx++
			if(WEST)
				tx--
		if(tx < 1 || tx > length(grid.len))
			continue
		if(ty < 1 || ty > length(grid[tx]))
			continue
		var/datum/grid_tile/neighbor = grid[tx][ty]
		if(!neighbor)
			continue

		var/dir_neighbor = turn(dir, 180)
		if(dir_neighbor in neighbor.blocked)
			continue
		if(!can_connect(neighbor))
			continue

		neighbor.neighbors[dir_neighbor] = src
		neighbors[dir] = src

/datum/grid_tile/proc/get_all_connected(list/existing = null)
	existing ||= list()
	if(src in existing)
		return

	existing += src
	refresh()
	for(var/datum/grid_tile/neighbor in neighbors)
		neighbor.get_all_connected(existing)

	return existing

/datum/grid_tile/proc/has_path_to(datum/grid_tile/target, list/path, list/exclude)
	var/dist = .proc/__astar_dist
	var/adjacent = .proc/__astar_adj
	var/maxnodedepth = 7
	if(!(target in get_all_connected()))
		return FALSE
	// no need to refresh here because get_all_connected causes a refresh on the entire path tree
	// we just need to manually traverse it to create a path list
	// this is a cookie cutter copy/paste of the current astar implementation, but with changes
	var/datum/Heap/open = new /datum/Heap(/proc/HeapPathWeightCompare)
	var/list/openc = new
	path.Cut()
	var/datum/PathNode/cur = new /datum/PathNode(src, null, 0, __astar_dist(target), 0, 15, 1)

	while(!open.IsEmpty() && !length(path))
		cur = open.Pop()
		if(cur.source == target)
			path.Add(cur.source)
			while(cur.prevNode)
				cur = cur.prevNode
				path.Add(cur.source)
			break

		//get adjacents turfs using the adjacent proc, checking for access with id
		if((!maxnodedepth)||(cur.nt <= maxnodedepth))//if too many steps, don't process that path
			for(var/i = 0 to 3)
				var/f= 1<<i //get cardinal directions.1,2,4,8
				if(cur.bf & f)
					var/datum/grid_tile/source = cur.source
					var/T = source.neighbors[f]
					if(!T || (T in exclude))
						continue
					if(!source.can_connect(T))
						continue
					var/datum/PathNode/CN = openc[T]  //current checking turf
					var/r=((f & MASK_ODD)<<1)|((f & MASK_EVEN)>>1) //getting reverse direction throught swapping even and odd bits.((f & 01010101)<<1)|((f & 10101010)>>1)
					var/newg = cur.g + call(cur.source,dist)(T)
					if(CN)
					//is already in open list, check if it's a better way from the current turf
						CN.bf &= 15^r //we have no closed, so just cut off exceed dir.00001111 ^ reverse_dir.We don't need to expand to checked turf.
						if((newg < CN.g) )
							if(call(cur.source,adjacent)(T))
								CN.setp(cur,newg,CN.h,cur.nt+1)
								open.ReSort(CN)//reorder the changed element in the list
					else
					//is not already in open list, so add it
						if(call(cur.source,adjacent)(T))
							CN = new(T,cur,newg,call(T,dist)(target),cur.nt+1,15^r)
							open.Insert(CN)
							openc[T] = CN
		cur.bf = 0
		CHECK_TICK
	if(path)
		for(var/i = 1 to round(0.5*path.len))
			path.Swap(i,path.len-i+1)
	openc = null
	return !!path

/datum/grid_tile/proc/__astar_dist(datum/grid_tile/target)
	var/x = (src.x + target.x)**2
	var/y = (src.y + target.y)**2
	return (x + y)**(1/2)

/datum/grid_tile/proc/__astar_adj(datum/grid_tile/target)
	var/x_d = abs(x - target.x)
	var/y_d = abs(y - target.y)
	return (x_d + y_d) == 1

/datum/research_grid
	var/datum/research_node/node
	var/datum/research_web/web
	var/grid_size

	/// The entirety of the grid in one convienent var
	var/list/datum/grid_tile/grid
	/// Assosciative list of plug -> socket
	var/list/datum/grid_tile/plug_map

	var/list/mob/users

/datum/research_grid/New(datum/research_node/node, datum/research_web/web, grid_size)
	src.node = node
	src.web = web
	src.grid_size = grid_size
	users = new
	init_grid()

/datum/research_grid/Destroy(force, ...)
	node.grids -= web
	node = null
	web = null
	users.Cut()
	plug_map.Cut()
	for(var/list/subl as anything in grid)
		QDEL_LIST_ASSOC(subl)
	grid.Cut()
	return ..()

/datum/research_grid/proc/check_completion()
	var/list/path = new
	var/list/exclude = new
	for(var/datum/grid_tile/plug as anything in plug_map)
		path.Cut()
		if(!plug.has_path_to(plug_map[plug], path, exclude))
			return FALSE
		for(var/used in path)
			exclude |= used

	return TRUE

/datum/research_grid/proc/init_grid()
	grid = new(grid_size)
	plug_map = new

	for(var/x in 1 to grid_size)
		var/list/list_x = new(grid_size)
		for(var/y in 1 to grid_size)
			list_x[y] = new /datum/grid_tile(grid, x, y, null, GRID_TYPE_EMPTY)
		grid[x] = list_x

	var/list/used = new
	var/tries = 0
	for(var/id in node.theories_required)
		var/needed = node.theories_required[id]
		for(var/idx in 1 to needed)
			var/datum/grid_tile/pos
			do
				if(tries++ >= 10)
					CRASH("Too many tries in getting a position")
				var/x = rand(1, grid_size)
				var/y = rand(1, grid_size)
				pos = grid[x][y]
			while(pos in used)
			used += pos
			var/datum/grid_tile/plug = pos
			plug.change_id(id)
			plug.change_type(GRID_TYPE_PLUG)

			tries = 0
			do
				if(tries++ >= 10)
					CRASH("Too many tries in getting a position")
				var/x = rand(1, grid_size)
				var/y = rand(1, grid_size)
				pos = grid[x][y]
			while(pos in used)
			used += pos
			var/datum/grid_tile/socket = pos
			socket.change_id(id)
			socket.change_type(GRID_TYPE_SOCKET)
			plug_map[plug] = socket

/mob/var/datum/research_grid/active_grid
/mob/Login()
	. = ..()
	active_grid?.ui_interact(src)

/datum/research_grid/ui_close(mob/user)
	. = ..()
	remove_user(user)

/datum/research_grid/proc/add_user(mob/user)
	if(user.active_grid != src)
		user.active_grid?.remove_user(user)

	user.active_grid = src
	users |= user
	ui_interact(user)

/datum/research_grid/proc/remove_user(mob/user)
	ASSERT(user.active_grid == src)
	user.active_grid = null
	SStgui.close_user_uis(user, src)
	users -= user

/datum/research_grid/ui_status(mob/user, datum/ui_state/state)
	if(!(user in users))
		return UI_CLOSE
	for(var/console in web.consoles_accessing)
		if(user.Adjacent(console))
			return UI_INTERACTIVE
	return UI_DISABLED

/datum/research_grid/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ResearchGridUI")
		ui.open()
		ui.set_autoupdate(TRUE)
